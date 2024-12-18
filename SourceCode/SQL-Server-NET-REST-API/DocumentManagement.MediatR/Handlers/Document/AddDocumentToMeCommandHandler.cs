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
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Threading;
using System.Threading.Tasks;

namespace DocumentManagement.MediatR.Handlers
{
    public class AddDocumentToMeCommandHandler : IRequestHandler<AddDocumentToMeCommand, ServiceResponse<DocumentDto>>
    {
        private readonly IDocumentRepository _documentRepository;
        private readonly IUnitOfWork<DocumentContext> _uow;
        private readonly IMapper _mapper;
        private readonly UserInfoToken _userInfo;
        private readonly IDocumentUserPermissionRepository _documentUserPermissionRepository;
        private readonly IDocumentAuditTrailRepository _documentAuditTrailRepository;
        private readonly PathHelper _pathHelper;
        private readonly IWebHostEnvironment _webHostEnvironment;
        private readonly IStorageSettingRepository _storageSettingRepository;
        private readonly StorageServiceFactory _storeageServiceFactory;
        private readonly IDocumentIndexRepository _documentIndexRepository;
        private readonly ILogger<AddDocumentToMeCommandHandler> _logger;

        public AddDocumentToMeCommandHandler(
            IDocumentRepository documentRepository,
            IMapper mapper,
            IUnitOfWork<DocumentContext> uow,
            UserInfoToken userInfo,
            IDocumentUserPermissionRepository documentUserPermissionRepository,
            IDocumentAuditTrailRepository documentAuditTrailRepository,
            PathHelper pathHelper,
            IWebHostEnvironment webHostEnvironment,
            StorageServiceFactory storeageServiceFactory,
            IStorageSettingRepository storageSettingRepository,
            IDocumentIndexRepository documentIndexRepository,
            ILogger<AddDocumentToMeCommandHandler> logger)
        {
            _documentRepository = documentRepository;
            _mapper = mapper;
            _uow = uow;
            _userInfo = userInfo;
            _documentUserPermissionRepository = documentUserPermissionRepository;
            _documentAuditTrailRepository = documentAuditTrailRepository;
            _pathHelper = pathHelper;
            _webHostEnvironment = webHostEnvironment;
            _storeageServiceFactory = storeageServiceFactory;
            _storageSettingRepository = storageSettingRepository;
            _documentIndexRepository = documentIndexRepository;
            _logger = logger;
        }

        public async Task<ServiceResponse<DocumentDto>> Handle(AddDocumentToMeCommand request, CancellationToken cancellationToken)
        {
            if (request.Files.Count == 0)
            {
                return ServiceResponse<DocumentDto>.ReturnFailed(409, "Please select the file.");
            }

            var entityExist = await _documentRepository.FindBy(c => c.Name == request.Name).FirstOrDefaultAsync();
            if (entityExist != null)
            {
                return ServiceResponse<DocumentDto>.ReturnFailed(409, "Document already exist.");
            }

            long fileSizeInBytes = request.Files[0].Length;
            // Convert file size to kilobytes or megabytes if necessary
            double fileSizeInKB = fileSizeInBytes / 1024.0;

            var storeageSetting = await _storageSettingRepository.GetStorageSettingByIdOrLocal(request.StorageSettingId);

            var storageService = _storeageServiceFactory.GetStorageService(storeageSetting.StorageType);

            var fileNameKeyValut = await storageService.UploadFileAsync(request.Files[0], storeageSetting);

            if (string.IsNullOrEmpty(fileNameKeyValut.FileName))
            {
                return ServiceResponse<DocumentDto>.Return422("Settings are not properly setup.");
            }
            var keyValut = KeyGenerator.GenerateKeyAndIV();

            //var url = UploadFile(request.Files[0]);

            var entity = _mapper.Map<Document>(request);
            entity.CreatedBy = _userInfo.Id;
            entity.CreatedDate = DateTime.UtcNow;
            entity.Url = fileNameKeyValut.FileName;
            entity.Key = fileNameKeyValut.Key;
            entity.IV = fileNameKeyValut.IV;
            entity.StorageType = storeageSetting.StorageType;
            entity.IsAddedPageIndxing = false;

            try
            {
                var metaData = JsonConvert.DeserializeObject<List<DocumentMetaDataDto>>(request.DocumentMetaDataString);
                entity.DocumentMetaDatas = _mapper.Map<List<Data.DocumentMetaData>>(metaData);
            }
            catch
            {
                // igonre
            }
            _documentRepository.Add(entity);
            var documentUserPermission = new DocumentUserPermission
            {
                Id = Guid.NewGuid(),
                DocumentId = entity.Id,
                UserId = _userInfo.Id,
                IsTimeBound = false,
                IsAllowDownload = true,
                CreatedBy = _userInfo.Id,
                CreatedDate = DateTime.UtcNow

            };
            _documentUserPermissionRepository.Add(documentUserPermission);
            var documentAudit = new DocumentAuditTrail()
            {
                DocumentId = entity.Id,
                CreatedBy = _userInfo.Id,
                CreatedDate = DateTime.UtcNow,
                OperationName = DocumentOperation.Add_Permission,
                AssignToUserId = _userInfo.Id
            };
            _documentAuditTrailRepository.Add(documentAudit);
            var maxSizeQuick = _pathHelper.MaxFileSizeIndexingQuick;

            if (fileSizeInKB > maxSizeQuick)
            {
                _documentIndexRepository.Add(new DocumentIndex { Id = Guid.NewGuid(), DocumentId = entity.Id });
            }

            if (await _uow.SaveAsync() <= 0)
            {
                return ServiceResponse<DocumentDto>.ReturnFailed(500, "Error While Added Document");
            }
            var entityDto = _mapper.Map<DocumentDto>(entity);
            if (fileSizeInKB <= maxSizeQuick)
            {
                try
                {
                    string extension = Path.GetExtension(request.Files[0].FileName);
                    var extractor = ContentExtractorFactory.GetExtractor(extension);
                    var imagessupport = _pathHelper.IMAGESSUPPORT;
                    if (extractor != null)
                    {
                        string tessFilePath = System.IO.Path.Combine(_webHostEnvironment.WebRootPath, _pathHelper.TESSDATA);
                        var content = new DocumentProcessor(extractor).ProcessDocumentByIFile(request.Files[0], tessFilePath, _pathHelper.TESSSUPPORTLANGUAGES);
                        if (!string.IsNullOrEmpty(content))
                        {
                            string searchIndexPath = System.IO.Path.Combine(_webHostEnvironment.WebRootPath, _pathHelper.SearchIndexPath);
                            var indexWriterManager = new IndexWriterManager(searchIndexPath);
                            indexWriterManager.AddDocument(entity.Id.ToString(), content);
                            indexWriterManager.Commit();
                            indexWriterManager.Dispose();
                        }
                    }
                    else if (Array.Exists(imagessupport, element => element.ToLower() == extension.ToLower()))
                    {
                        string tessFilePath = System.IO.Path.Combine(_webHostEnvironment.WebRootPath, _pathHelper.TESSDATA);
                        var tessDataContextExtractor = new TessDataContextExtractor();
                        var tessLang = _pathHelper.TESSSUPPORTLANGUAGES;
                        var content = await tessDataContextExtractor.ExtractContentByFile(tessFilePath, request.Files[0], tessLang);
                        if (!string.IsNullOrEmpty(content))
                        {
                            string searchIndexPath = System.IO.Path.Combine(_webHostEnvironment.WebRootPath, _pathHelper.SearchIndexPath);
                            var indexWriterManager = new IndexWriterManager(searchIndexPath);
                            indexWriterManager.AddDocument(entity.Id.ToString(), content);
                            indexWriterManager.Commit();
                            indexWriterManager.Dispose();
                        }
                    }
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "Error while indexing document");
                    _documentIndexRepository.Add(new DocumentIndex { Id = Guid.NewGuid(), DocumentId = entity.Id });
                    return ServiceResponse<DocumentDto>.ReturnResultWith200(entityDto);
                }
            }
            return ServiceResponse<DocumentDto>.ReturnResultWith200(entityDto);
        }

    }
}