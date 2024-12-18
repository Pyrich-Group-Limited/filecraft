using Azure;
using DocumentManagement.Common.GenericRepository;
using DocumentManagement.Common.UnitOfWork;
using DocumentManagement.Data;
using DocumentManagement.Domain;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using System.IO;
using System.Threading.Tasks;

namespace DocumentManagement.Repository
{
    public class SendEmailRepository : GenericRepository<SendEmail, DocumentContext>,
           ISendEmailRepository
    {
        private readonly IWebHostEnvironment _hostingEnvironment;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public SendEmailRepository(IUnitOfWork<DocumentContext> uow,
            IWebHostEnvironment hostingEnvironment,
            IHttpContextAccessor httpContextAccessor) : base(uow)
        {
            _hostingEnvironment = hostingEnvironment;
            _httpContextAccessor = httpContextAccessor;
        }

        public void AddSharedEmails(SendEmail sendEmail, string documentName)
        {
            var requestContext = _httpContextAccessor.HttpContext.Request;
            var url = $"{requestContext.Scheme}://{requestContext.Host}";
            var emailTemplatePath = Path.Combine(_hostingEnvironment.WebRootPath, "EmailTemplates", "SharedEmail.html");
            var emailTemplateContent = System.IO.File.ReadAllText(emailTemplatePath);
            sendEmail.Subject = $"{sendEmail.ToName} shared \"{documentName}\" with you";
            sendEmail.Message = emailTemplateContent
                .Replace("##TO_NAME##", sendEmail.ToName)
                .Replace("##FROM_NAME##", sendEmail.FromName)
                .Replace("##LINK##", url);
            Add(sendEmail);
        }
    }
}
