using AutoMapper;
using DocumentManagement.Common.UnitOfWork;
using DocumentManagement.Data;
using DocumentManagement.Data.Dto;
using DocumentManagement.Data.Entities;
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
using System.Threading;
using System.Threading.Tasks;

namespace DocumentManagement.MediatR.Handlers
{
    public class UploadNewDocumentVersionCommandHandler : IRequestHandler<UploadNewDocumentVersionCommand, ServiceResponse<DocumentVersionDto>>
    {
        private readonly IDocumentRepository _documentRepository;
        private readonly IDocumentVersionRepository _documentVersionRepository;
        private readonly IUnitOfWork<DocumentContext> _uow;
        private readonly IMapper _mapper;
        private readonly ILogger<UploadNewDocumentVersionCommandHandler> _logger;
        private readonly UserInfoToken _userInfoToken;
        private readonly Helper.PathHelper _pathHelper;
        private readonly IWebHostEnvironment _webHostEnvironment;
        private readonly StorageServiceFactory _storeageServiceFactory;
        private readonly IStorageSettingRepository _storageSettingRepository;
        private readonly IMediator _mediator;
        private readonly IDocumentIndexRepository _documentIndexRepository;

        public UploadNewDocumentVersionCommandHandler(
            IDocumentRepository documentRepository,
            IDocumentVersionRepository documentVersionRepository,
            IUnitOfWork<DocumentContext> uow,
            IMapper mapper,
            ILogger<UploadNewDocumentVersionCommandHandler> logger,
            UserInfoToken userInfoToken,
            Helper.PathHelper pathHelper,
            IWebHostEnvironment webHostEnvironment,
            StorageServiceFactory storeageServiceFactory,
            IStorageSettingRepository storageSettingRepository,
            IMediator mediator,
            IDocumentIndexRepository documentIndexRepository
            )
        {
            _documentRepository = documentRepository;
            _documentVersionRepository = documentVersionRepository;
            _uow = uow;
            _mapper = mapper;
            _logger = logger;
            _userInfoToken = userInfoToken;
            _pathHelper = pathHelper;
            _webHostEnvironment = webHostEnvironment;
            _storeageServiceFactory = storeageServiceFactory;
            _storageSettingRepository = storageSettingRepository;
            _mediator = mediator;
            _documentIndexRepository = documentIndexRepository;
        }
        public async Task<ServiceResponse<DocumentVersionDto>> Handle(UploadNewDocumentVersionCommand request, CancellationToken cancellationToken)
        {
            if (request.Files.Count == 0)
            {
                return ServiceResponse<DocumentVersionDto>.ReturnFailed(409, "Please select the file.");
            }

            var doc = await _documentRepository.FindAsync(request.DocumentId);
            if (doc == null)
            {
                _logger.LogError("Document Not Found");
                return ServiceResponse<DocumentVersionDto>.Return500();
            }

            if (doc.IsAddedPageIndxing)
            {
                try
                {
                    string searchIndexPath = System.IO.Path.Combine(_webHostEnvironment.WebRootPath, _pathHelper.SearchIndexPath);
                    var indexService = new IndexDeleteManager(searchIndexPath);
                    indexService.DeleteDocumentById(request.DocumentId.ToString());
                    indexService.Dispose();
                    _documentIndexRepository.Add(new DocumentIndex
                    {
                        DocumentId = request.DocumentId,
                        CreatedDate = DateTime.UtcNow
                    });

                    //var imagessupport = _pathHelper.IMAGESSUPPORT;
                    //string extension = Path.GetExtension(doc.Url);
                    //var extractor = ContentExtractorFactory.GetExtractor(extension);
                    //if (extractor != null)
                    //{
                    //    string tessFilePath = System.IO.Path.Combine(_webHostEnvironment.WebRootPath, _pathHelper.TESSDATA);
                    //    var content = new DocumentProcessor(extractor).ProcessDocumentByIFile(request.Files[0], tessFilePath, _pathHelper.TESSSUPPORTLANGUAGES);
                    //    if (!string.IsNullOrEmpty(content))
                    //    {

                    //        var indexWriterManager = new IndexWriterManager(searchIndexPath);
                    //        indexWriterManager.AddDocument(doc.Id.ToString(), content);
                    //        indexWriterManager.Commit();
                    //        indexWriterManager.Dispose();
                    //    }
                    //}
                    //else if (Array.Exists(imagessupport, element => element.ToLower() == extension.ToLower()))
                    //{
                    //    string tessFilePath = System.IO.Path.Combine(_webHostEnvironment.WebRootPath, _pathHelper.TESSDATA);
                    //    var tessDataContextExtractor = new TessDataContextExtractor();
                    //    var tessLang = _pathHelper.TESSSUPPORTLANGUAGES;
                    //    var content = await tessDataContextExtractor.ExtractContentByFile(tessFilePath, request.Files[0], tessLang);
                    //    if (!string.IsNullOrEmpty(content))
                    //    {
                    //        var indexWriterManager = new IndexWriterManager(searchIndexPath);
                    //        indexWriterManager.AddDocument(doc.Id.ToString(), content);
                    //        indexWriterManager.Commit();
                    //        indexWriterManager.Dispose();
                    //    }
                    //}   
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "Error while indexing document");
                }
            }

            var storeageSetting = await _storageSettingRepository.GetStorageSettingByIdOrLocal(doc.StorageSettingId);

            var storageService = _storeageServiceFactory.GetStorageService(storeageSetting.StorageType);

            var fileNameKeyValut = await storageService.UploadFileAsync(request.Files[0], storeageSetting);

            if (string.IsNullOrEmpty(fileNameKeyValut.FileName))
            {
                return ServiceResponse<DocumentVersionDto>.Return422("Settings are not properly setup.");
            }

            var version = new DocumentVersion
            {
                Url = doc.Url,
                Key = doc.Key,
                IV = doc.IV,
                DocumentId = doc.Id,
                CreatedBy = doc.CreatedBy,
                CreatedDate = doc.CreatedDate,
                ModifiedBy = doc.ModifiedBy,
                ModifiedDate = doc.ModifiedDate,
            };
            doc.Url = fileNameKeyValut.FileName;
            doc.Key = fileNameKeyValut.Key;
            doc.IV = fileNameKeyValut.IV;
            doc.CreatedDate = DateTime.UtcNow;
            doc.CreatedBy = _userInfoToken.Id;

            _documentRepository.Update(doc);
            _documentVersionRepository.Add(version);
            if (await _uow.SaveAsync() <= 0)
            {
                _logger.LogError("Error while adding industry");
                return ServiceResponse<DocumentVersionDto>.Return500();
            }
            var documentCommentDto = _mapper.Map<DocumentVersionDto>(version);
            return ServiceResponse<DocumentVersionDto>.ReturnResultWith200(documentCommentDto);
        }

    }
}
