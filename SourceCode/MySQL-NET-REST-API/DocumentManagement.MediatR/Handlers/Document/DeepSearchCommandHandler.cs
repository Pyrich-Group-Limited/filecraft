using DocumentManagement.Data.Dto;
using DocumentManagement.Helper;
using DocumentManagement.MediatR.Commands;
using DocumentManagement.MediatR.Handlers.LuceneHandler;
using DocumentManagement.Repository;
using MediatR;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace DocumentManagement.MediatR.Handlers
{
    public class DeepSearchCommandHandler(IDocumentRepository documentRepository, IWebHostEnvironment webHostEnvironment, Helper.PathHelper pathHelper) : IRequestHandler<DeepSearchCommand, ServiceResponse<List<DocumentDto>>>
    {
        public async Task<ServiceResponse<List<DocumentDto>>> Handle(DeepSearchCommand request, CancellationToken cancellationToken)
        {
            if (string.IsNullOrWhiteSpace(request.SearchQuery))
            {
                return ServiceResponse<List<DocumentDto>>.ReturnFailed(404, "Please enter search text.");
            }
            string searchIndexPath = System.IO.Path.Combine(webHostEnvironment.WebRootPath, pathHelper.SearchIndexPath);
            var indexSearcherManager = new IndexSearcherManager(searchIndexPath);
            indexSearcherManager.CreateSearcher();
            var lstIds = indexSearcherManager.Search(request.SearchQuery);
            indexSearcherManager.Dispose();
            if (lstIds.Count > 0)
            {
                var documents = await documentRepository.All.Where(c => lstIds.Contains(c.Id))
                                       .AsNoTracking()
                                       .Select(c => new DocumentDto
                                       {
                                           Id = c.Id,
                                           Name = c.Name,
                                           CreatedDate = c.CreatedDate,
                                           CategoryId = c.CategoryId,
                                           Description = c.Description,
                                           CategoryName = c.Category.Name,
                                           Url = c.Url,
                                           CreatedBy = c.User != null ? $"{c.User.FirstName} {c.User.LastName}" : "",
                                           IsAllowDownload = true,
                                           DocumentStatusId = c.DocumentStatusId,
                                           DocumentStatus = c.DocumentStatus,
                                           StorageSettingId = c.StorageSettingId,
                                           StorageSettingName = c.StorageSetting.Name,
                                           StorageType = c.StorageType,
                                           IsAddedPageIndxing = c.IsAddedPageIndxing

                                       }).ToListAsync();
                return ServiceResponse<List<DocumentDto>>.ReturnResultWith200(documents);
            }

            return ServiceResponse<List<DocumentDto>>.ReturnFailed(404, "No document found");
        }
    }
}
