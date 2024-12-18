using Amazon.Runtime.Internal.Util;
using AutoMapper;
using DocumentManagement.Common.UnitOfWork;
using DocumentManagement.Data.Dto;
using DocumentManagement.Domain;
using DocumentManagement.Helper;
using DocumentManagement.MediatR.Commands;
using DocumentManagement.MediatR.Handlers.LuceneHandler;
using DocumentManagement.Repository;
using MediatR;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace DocumentManagement.MediatR.Handlers
{
    public class DeleteDocumentCommandHandler : IRequestHandler<DeleteDocumentCommand, DocumentDto>
    {
        private readonly IDocumentRepository _documentRepository;
        private readonly IUnitOfWork<DocumentContext> _uow;
        private readonly IMapper _mapper;
        private readonly PathHelper _pathHelper;
        private readonly IWebHostEnvironment _webHostEnvironment;
        private readonly ILogger<DeleteDocumentCommandHandler> _logger;
        public DeleteDocumentCommandHandler(
           IDocumentRepository documentRepository,
            IMapper mapper,
            IUnitOfWork<DocumentContext> uow,
                PathHelper pathHelper,
            IWebHostEnvironment webHostEnvironment
            )
        {
            _documentRepository = documentRepository;
            _mapper = mapper;
            _uow = uow;
            _pathHelper = pathHelper;
            _webHostEnvironment = webHostEnvironment;
        }

        public async Task<DocumentDto> Handle(DeleteDocumentCommand request, CancellationToken cancellationToken)
        {
            var entityExist = await _documentRepository.FindAsync(request.Id);
            if (entityExist == null)
            {
                var errorDto = new DocumentDto
                {
                    StatusCode = 404,
                    Messages = new List<string> { "Not Found" }
                };
                return errorDto;
            }
            _documentRepository.Delete(request.Id);
            if (await _uow.SaveAsync() <= -1)
            {
                var errorDto = new DocumentDto
                {
                    StatusCode = 500,
                    Messages = new List<string> { "An unexpected fault happened. Try again later." }
                };
                return errorDto;
            }
            try
            {
                string searchIndexPath = System.IO.Path.Combine(_webHostEnvironment.WebRootPath, _pathHelper.SearchIndexPath);
                var indexService = new IndexDeleteManager(searchIndexPath);
                indexService.DeleteDocumentById(request.Id.ToString());
                indexService.Dispose();
            }
           catch(Exception ex)
            {
                _logger.LogError(ex, "Error while deleting document from index");
            }

            return new DocumentDto
            {
                StatusCode = 200,
                Messages = new List<string> { "Document deleted successfully." }
            };
        }
    }
}
