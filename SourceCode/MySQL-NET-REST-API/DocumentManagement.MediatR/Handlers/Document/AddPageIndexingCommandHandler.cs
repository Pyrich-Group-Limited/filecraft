using DocumentManagement.Common.UnitOfWork;
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
using System;
using System.IO;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace DocumentManagement.MediatR.Handlers
{
    public class AddPageIndexingCommandHandler(IDocumentRepository _documentRepository, Helper.PathHelper pathHelper,
             ILogger<RemovePageIndexingCommandHandler> _logger, IDocumentIndexRepository documentIndexRepository, 
            IUnitOfWork<DocumentContext> uow, IStorageSettingRepository _storageSettingRepository, StorageServiceFactory _storeageServiceFactory, IWebHostEnvironment _webHostEnvironment ) : IRequestHandler<AddPageIndexingCommand, ServiceResponse<bool>>
    {
        public async Task<ServiceResponse<bool>> Handle(AddPageIndexingCommand request, CancellationToken cancellationToken)
        {
            var entityExist = await _documentRepository.All.Where(c => c.Id == request.DocumentId).FirstOrDefaultAsync();
            if (entityExist == null)
            {
                return ServiceResponse<bool>.ReturnFailed(404, "Document is not found");
            }
            try
            {
                var storeageSetting = await _storageSettingRepository.GetStorageSettingByIdOrLocal(entityExist.StorageSettingId);
                if (storeageSetting == null)
                {
                    return ServiceResponse<bool>.ReturnResultWith200(true);
                }
                var storageService = _storeageServiceFactory.GetStorageService(storeageSetting.StorageType);
                var fileResult = await storageService.DownloadFileAsync(entityExist.Url, storeageSetting.JsonValue, entityExist.Key, entityExist.IV);
                var imagessupport = pathHelper.IMAGESSUPPORT;
                try
                {
                    string extension = Path.GetExtension(entityExist.Url);
                    string tessdataPath = System.IO.Path.Combine(_webHostEnvironment.WebRootPath, pathHelper.TESSDATA);
                    var extractor = ContentExtractorFactory.GetExtractor(extension);
                    if (extractor != null)
                    {
                        documentIndexRepository.Add(new Data.Entities.DocumentIndex
                        {
                            DocumentId = entityExist.Id,
                            CreatedDate = DateTime.UtcNow
                        });
                    }
                    else if (Array.Exists(imagessupport, element => element.ToLower() == extension.ToLower()))
                    {
                        documentIndexRepository.Add(new Data.Entities.DocumentIndex
                        {
                            DocumentId = entityExist.Id,
                            CreatedDate = DateTime.UtcNow
                        });
                    }
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "Error while indexing document");
                }
                entityExist.IsAddedPageIndxing = true;
                _documentRepository.Update(entityExist);
                if (await uow.SaveAsync() <= 0)
                {
                    return ServiceResponse<bool>.ReturnFailed(500, "Error while removing document from index");
                }
                return ServiceResponse<bool>.ReturnResultWith200(true);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error while removing document from index");
                return ServiceResponse<bool>.ReturnFailed(404, "Error while removing document from index");
            }
        }
    }
}
