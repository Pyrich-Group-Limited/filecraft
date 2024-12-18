
using DocumentManagement.Common.UnitOfWork;
using DocumentManagement.Domain;
using DocumentManagement.MediatR.Commands;
using DocumentManagement.MediatR.Handlers.LuceneHandler;
using DocumentManagement.MediatR.Handlers.StorageStategies;
using DocumentManagement.Repository;
using MediatR;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System;
using System.IO;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace DocumentManagement.MediatR.Handlers
{
    public class AddDocumentIndexContentCommandHandler(IDocumentIndexRepository _documentIndexRepository,
         IDocumentRepository _documentRepository,
         StorageServiceFactory _storeageServiceFactory,
         IStorageSettingRepository _storageSettingRepository,
         IWebHostEnvironment _webHostEnvironment,
          IUnitOfWork<DocumentContext> _uow,
          ILogger<AddDocumentIndexContentCommandHandler> _logger,
        Helper.PathHelper _pathHelper) : IRequestHandler<AddDocumentIndexContentCommand, bool>
    {
        public async Task<bool> Handle(AddDocumentIndexContentCommand request, CancellationToken cancellationToken)
        {
            var documentVersion = await _documentIndexRepository.All.OrderByDescending(c=>c.CreatedDate).FirstOrDefaultAsync();
            if (documentVersion == null)
            {
                return false;
            }
            var document = await _documentRepository.All.FirstOrDefaultAsync(c => c.Id == documentVersion.DocumentId);
            if(document != null)
            {
                var storeageSetting = await _storageSettingRepository.GetStorageSettingByIdOrLocal(document.StorageSettingId);
                if (storeageSetting == null)
                {
                    return false;
                }
                var storageService = _storeageServiceFactory.GetStorageService(storeageSetting.StorageType);
                var fileResult = await storageService.DownloadFileAsync(document.Url, storeageSetting.JsonValue, document.Key,  document.IV);
                try
                {
                    string extension = Path.GetExtension(document.Url);
                    var extractor = ContentExtractorFactory.GetExtractor(extension);
                    var imagessupport = _pathHelper.IMAGESSUPPORT;
                    var tessLang = _pathHelper.TESSSUPPORTLANGUAGES;
                    if (extractor != null)
                    {
                        string tessdataPath = System.IO.Path.Combine(_webHostEnvironment.WebRootPath, _pathHelper.TESSDATA);
                        var content = new DocumentProcessor(extractor).ProcessDocumentByBytes(fileResult.FileBytes, tessdataPath, _pathHelper.TESSSUPPORTLANGUAGES);
                        if (!string.IsNullOrEmpty(content))
                        {
                            string searchIndexPath = System.IO.Path.Combine(_webHostEnvironment.WebRootPath, _pathHelper.SearchIndexPath);
                            var indexWriterManager = new IndexWriterManager(searchIndexPath);
                            indexWriterManager.AddDocument(document.Id.ToString(), content);
                            indexWriterManager.Commit();
                            indexWriterManager.Dispose();
                        }
                     } 
                    else if(Array.Exists(imagessupport, element => element.ToLower() == extension.ToLower()))
                    {
                        this.ExtractTEssData(fileResult.FileBytes, document.Id, tessLang);
                    }
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "Error while indexing document");
                }

            }
            _documentIndexRepository.Remove(documentVersion);
            if (await _uow.SaveAsync() <= 0)
            {
                _logger.LogError("Error while saving data");
            }
            return true;
        }

        private void ExtractTEssData(byte[] fileBytes, Guid id, string tessLang)
        {
            string tessFilePath = System.IO.Path.Combine(_webHostEnvironment.WebRootPath, _pathHelper.TESSDATA);
            var tessDataContextExtractor = new TessDataContextExtractor();
            var content = tessDataContextExtractor.ExtractContentByBytes(tessFilePath, fileBytes, tessLang);
            if (!string.IsNullOrEmpty(content))
            {
                string searchIndexPath = System.IO.Path.Combine(_webHostEnvironment.WebRootPath, _pathHelper.SearchIndexPath);
                var indexWriterManager = new IndexWriterManager(searchIndexPath);
                indexWriterManager.AddDocument(id.ToString(), content);
                indexWriterManager.Commit();
                indexWriterManager.Dispose();
            }
        }
    }
   
}
