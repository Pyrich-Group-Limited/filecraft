using DocumentManagement.Data;
using DocumentManagement.Data.Entities;
using DocumentManagement.Helper;
using DocumentManagement.MediatR.Commands;
using DocumentManagement.MediatR.Handlers.StorageStategies;
using DocumentManagement.Repository;
using MediatR;
using Microsoft.EntityFrameworkCore;
using System.Threading;
using System.Threading.Tasks;

namespace DocumentManagement.MediatR.Handlers
{
    public class DownloadDocumentCommandHandler(IDocumentRepository _documentRepository,
        IDocumentVersionRepository _versionRepository,
         StorageServiceFactory _storeageServiceFactory,
         IStorageSettingRepository _storageSettingRepository)
        : IRequestHandler<DownloadDocumentCommand, ServiceResponse<DocumentDownload>>
    {


        public async Task<ServiceResponse<DocumentDownload>> Handle(DownloadDocumentCommand request, CancellationToken cancellationToken)
        {

            DocumentVersion documentVersion = null;
            Document document = null;
            if (request.IsVersion)
            {
                documentVersion = await _versionRepository.All.FirstOrDefaultAsync(c => c.Id == request.Id);
                document = await _documentRepository.All.FirstOrDefaultAsync(c => c.Id == documentVersion.DocumentId);
            }
            else
            {
                document = await _documentRepository.All.FirstOrDefaultAsync(c => c.Id == request.Id);

            }
            var storeageSetting = await _storageSettingRepository.GetStorageSettingByIdOrLocal(document.StorageSettingId);

            if (storeageSetting == null)
            {
                return ServiceResponse<DocumentDownload>.ReturnFailed(404, "Storage setting not found");
            }

            var storageService = _storeageServiceFactory.GetStorageService(storeageSetting.StorageType);


            var fileResult = await storageService.DownloadFileAsync(documentVersion != null ? documentVersion.Url : document.Url, storeageSetting.JsonValue, documentVersion != null ? documentVersion.Key : document.Key, documentVersion != null ? documentVersion.IV : document.IV);

            if (string.IsNullOrWhiteSpace(fileResult.ErrorMessage))
            {
                DocumentDownload documentDownload = new DocumentDownload
                {
                    Data = fileResult.FileBytes,
                    ContentType = FileHelper.GetMimeType(documentVersion != null ? documentVersion.Url : document.Url),
                    FileName = documentVersion != null ? documentVersion.Url : document.Url
                };
                return ServiceResponse<DocumentDownload>.ReturnResultWith200(documentDownload);
            }

            return ServiceResponse<DocumentDownload>.ReturnFailed(400, fileResult.ErrorMessage);
        }
    }
}
