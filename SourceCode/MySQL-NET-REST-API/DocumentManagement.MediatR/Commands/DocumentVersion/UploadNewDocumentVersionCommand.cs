using DocumentManagement.Data.Dto;
using DocumentManagement.Helper;
using MediatR;
using Microsoft.AspNetCore.Http;
using System;

namespace DocumentManagement.MediatR.Commands
{
    public class UploadNewDocumentVersionCommand : IRequest<ServiceResponse<DocumentVersionDto>>
    {
        public Guid DocumentId { get; set; }
        public string Url { get; set; }
        public IFormFileCollection Files { get; set; } = new FormFileCollection();
    }
}
