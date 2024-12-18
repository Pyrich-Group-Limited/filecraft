using Amazon.Runtime.Internal.Util;
using DocumentManagement.Common.UnitOfWork;
using DocumentManagement.Data;
using DocumentManagement.Data.Dto;
using DocumentManagement.Domain;
using DocumentManagement.Helper;
using DocumentManagement.MediatR.Commands;
using DocumentManagement.MediatR.Handlers.LuceneHandler;
using DocumentManagement.MediatR.Handlers.StorageStategies;
using DocumentManagement.Repository;
using MediatR;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Logging;
using System;
using System.IO;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace DocumentManagement.MediatR.Handlers
{
    public class RestoreDocumentVersionCommandHandler : IRequestHandler<RestoreDocumentVersionCommand, ServiceResponse<bool>>
    {
        private readonly IDocumentVersionRepository _documentVersionRepository;
        private readonly IDocumentRepository _documentRepository;
        private readonly IUnitOfWork<DocumentContext> _uow;
        private readonly IWebHostEnvironment _webHostEnvironment;
        private readonly PathHelper _pathHelper;
        private readonly ILogger<RestoreDocumentVersionCommandHandler> _logger;
        private readonly IDocumentIndexRepository _documentIndexRepository;

        public RestoreDocumentVersionCommandHandler(IDocumentVersionRepository documentVersionRepository,
            IDocumentRepository documentRepository,
            IUnitOfWork<DocumentContext> uow,
            IWebHostEnvironment webHostEnvironment,
            PathHelper pathHelper,
            ILogger<RestoreDocumentVersionCommandHandler> logger,
            IDocumentIndexRepository documentIndexRepository
            )
        {
            _documentVersionRepository = documentVersionRepository;
            _documentRepository = documentRepository;
            _uow = uow;
            _webHostEnvironment = webHostEnvironment;
            _pathHelper = pathHelper;
            _logger = logger;
            _documentIndexRepository = documentIndexRepository;

        }
        public async Task<ServiceResponse<bool>> Handle(RestoreDocumentVersionCommand request, CancellationToken cancellationToken)
        {
            var document = await _documentRepository.FindAsync(request.DocumentId);
            if (document == null)
            {
                return ServiceResponse<bool>.Return404();
            }

            var originalPath = document.Url;
            var version = _documentVersionRepository
                .All.FirstOrDefault(c => c.Id == request.Id && c.DocumentId == request.DocumentId);
            if (version == null)
            {
                return ServiceResponse<bool>.Return404();
            }

            var versionId = Guid.NewGuid();
            //var versionUrl = versionId.ToString() + Path.GetExtension(document.Url);
            _documentVersionRepository.Add(new DocumentVersion
            {
                Id = versionId,
                DocumentId = document.Id,
                Url = document.Url,
                Key = document.Key,
                IV = document.IV,
                CreatedBy = document.CreatedBy,
                CreatedDate = document.CreatedDate,
                ModifiedDate = document.ModifiedDate,
                ModifiedBy = document.ModifiedBy
            });
            document.Url = version.Url;
            document.Key = version.Key;
            document.IV = version.IV;
            if (document.IsAddedPageIndxing)
            {
                try
                {
                    //Remove existing index
                    string searchIndexPath = System.IO.Path.Combine(_webHostEnvironment.WebRootPath, _pathHelper.SearchIndexPath);
                    string tessdataPath = System.IO.Path.Combine(_webHostEnvironment.WebRootPath, _pathHelper.TESSDATA);
                    var indexService = new IndexDeleteManager(searchIndexPath);
                    indexService.DeleteDocumentById(request.DocumentId.ToString());
                    indexService.Dispose();

                    _documentIndexRepository.Add(new Data.Entities.DocumentIndex
                    {
                        DocumentId = document.Id,
                        CreatedDate = DateTime.UtcNow
                    });
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "Error while indexing document");
                }
            }

            _documentRepository.Update(document);
            if (await _uow.SaveAsync() <= 0)
            {
                return ServiceResponse<bool>.Return500();
            }

            return ServiceResponse<bool>.ReturnResultWith200(true); ;
        }
    }
}
