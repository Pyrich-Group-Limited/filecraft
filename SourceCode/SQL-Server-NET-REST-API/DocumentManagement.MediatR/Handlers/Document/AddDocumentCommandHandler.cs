using AutoMapper;
using DocumentManagement.Common.UnitOfWork;
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
using Microsoft.IdentityModel.Tokens;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Threading;
using System.Threading.Tasks;

namespace DocumentManagement.MediatR.Handlers
{
    public class AddDocumentCommandHandler : IRequestHandler<AddDocumentCommand, ServiceResponse<DocumentDto>>
    {
        private readonly IDocumentRepository _documentRepository;
        private readonly IUnitOfWork<DocumentContext> _uow;
        private readonly IMapper _mapper;
        private readonly UserInfoToken _userInfo;
        private readonly PathHelper _pathHelper;
        private readonly IWebHostEnvironment _webHostEnvironment;
        private readonly StorageServiceFactory _storeageServiceFactory;
        private readonly IStorageSettingRepository _storageSettingRepository;
        private readonly ILogger<AddDocumentCommandHandler> _logger;
        private readonly IDocumentIndexRepository _documentIndexRepository;
        public AddDocumentCommandHandler(
            IDocumentRepository documentRepository,
            IMapper mapper,
            IUnitOfWork<DocumentContext> uow,
            UserInfoToken userInfo,
            PathHelper pathHelper,
            IWebHostEnvironment webHostEnvironment,
            StorageServiceFactory storeageServiceFactory,
            IStorageSettingRepository storageSettingRepository,
            ILogger<AddDocumentCommandHandler> logger,
            IDocumentIndexRepository documentIndexRepository)
        {
            _documentRepository = documentRepository;
            _mapper = mapper;
            _uow = uow;
            _userInfo = userInfo;
            _pathHelper = pathHelper;
            _webHostEnvironment = webHostEnvironment;
            _storeageServiceFactory = storeageServiceFactory;
            _storageSettingRepository = storageSettingRepository;
            _logger = logger;
            _documentIndexRepository = documentIndexRepository;
        }

        public async Task<ServiceResponse<DocumentDto>> Handle(AddDocumentCommand request, CancellationToken cancellationToken)
        {
            if (request.Files.Count == 0)
            {
                return ServiceResponse<DocumentDto>.ReturnFailed(409, "Please select the file.");
            }
            long fileSizeInBytes = request.Files[0].Length;
            // Convert file size to kilobytes or megabytes if necessary
            double fileSizeInKB = fileSizeInBytes / 1024.0;

            var entityExist = await _documentRepository.FindBy(c => c.Name == request.Name).FirstOrDefaultAsync();
            if (entityExist != null)
            {
                return ServiceResponse<DocumentDto>.ReturnFailed(409, "Document already exist.");
            }
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
            try
            {
                var metaData = JsonConvert.DeserializeObject<List<DocumentMetaDataDto>>(request.DocumentMetaDataString);
                entity.DocumentMetaDatas = _mapper.Map<List<Data.DocumentMetaData>>(metaData);
            }
            catch
            {
                // igonre
            }

            try
            {
                var documentUserPermissions = JsonConvert.DeserializeObject<List<DocumentUserPermissionDto>>(request.DocumentUserPermissionString);
                entity.DocumentUserPermissions = _mapper.Map<List<Data.DocumentUserPermission>>(documentUserPermissions);
            }
            catch
            {
                // igonre
            }

            try
            {
                var documentRolePermissions = JsonConvert.DeserializeObject<List<DocumentRolePermissionDto>>(request.DocumentRolePermissionString);
                entity.DocumentRolePermissions = _mapper.Map<List<Data.DocumentRolePermission>>(documentRolePermissions);
            }
            catch
            {
                // igonre
            }
            entity.IsAddedPageIndxing = true;
            _documentRepository.Add(entity);
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
