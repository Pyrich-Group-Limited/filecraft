using MediatR;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using DocumentManagement.MediatR.Commands;
using DocumentManagement.API.Helpers;

namespace DocumentManagement.API.Controllers.Email
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class EmailController : BaseController
    {
        IMediator _mediator;
        public EmailController(IMediator mediator)
        {
            _mediator = mediator;
        }
        /// <summary>
        /// Send mail.
        /// </summary>
        /// <param name="sendEmailCommand"></param>
        /// <returns></returns>
        [HttpPost(Name = "SendEmail")]
        [Produces("application/json", "application/xml", Type = typeof(void))]
        [ClaimCheck("all_documents_send_email")]
        public async Task<IActionResult> SendEmail(SendEmailCommand sendEmailCommand)
        {
            var result = await _mediator.Send(sendEmailCommand);
            return Ok(result);
        }
    }
}
