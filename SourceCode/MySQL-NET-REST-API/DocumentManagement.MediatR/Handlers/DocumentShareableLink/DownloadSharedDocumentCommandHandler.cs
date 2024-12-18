using DocumentManagement.Helper;
using DocumentManagement.MediatR.Commands;
using DocumentManagement.MediatR.Queries;
using MediatR;
using System.Threading;
using System.Threading.Tasks;

namespace DocumentManagement.MediatR.Handlers
{
    public class DownloadSharedDocumentCommandHandler(IMediator mediator)
        : IRequestHandler<DownloadSharedDocumentCommand, ServiceResponse<DocumentDownload>>
    {
        public async Task<ServiceResponse<DocumentDownload>> Handle(DownloadSharedDocumentCommand request, CancellationToken cancellationToken)
        {

            var command = new GetLinkInfoByCodeQuery { Code = request.Code };
            var result = await mediator.Send(command);

            if (!result.Success || result.Data == null)
            {
                return ServiceResponse<DocumentDownload>.ReturnFailed(404, result.Errors);
            }

            var link = result.Data;
            if (link.IsLinkExpired)
            {
                return ServiceResponse<DocumentDownload>.ReturnFailed(404, "Link is expired");
            }

            if (link.HasPassword)
            {
                if (link.Password != request.Password)
                {
                    return ServiceResponse<DocumentDownload>.ReturnFailed(404, "Invalid password");
                }
            }

            var commnad = new DownloadDocumentCommand
            {
                Id = link.DocumentId,
                IsVersion = false
            };

            var downloadDocument = await mediator.Send(commnad);
            return downloadDocument;
        }
    }
}
