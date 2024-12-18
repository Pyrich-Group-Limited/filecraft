using DocumentManagement.API.Helpers;
using DocumentManagement.Data.Dto;
using DocumentManagement.MediatR.Commands;
using DocumentManagement.MediatR.Queries;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace DocumentManagement.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class CompanyProfileController(IMediator _mediator) : BaseController
    {
        /// <summary>
        /// Gets the company profile.
        /// </summary>
        /// <param name="id">The identifier.</param>
        /// <returns></returns>
        [HttpGet(Name = "GetCompanyProfile")]
        [Produces("application/json", "application/xml", Type = typeof(List<CompanyProfileDto>))]
        [AllowAnonymous]
        public async Task<IActionResult> GetCompanyProfile()
        {
            var query = new GetCompanyProfileQuery { };
            var result = await _mediator.Send(query);
            return Ok(result.Data);
        }

        /// <summary>
        /// Updates the company profile.
        /// </summary>
        /// <param name="id">The identifier.</param>
        /// <param name="updateCompanyProfileCommand">The update company profile command.</param>
        /// <returns></returns>
        [HttpPost("{id}")]
        [Produces("application/json", "application/xml", Type = typeof(CompanyProfileDto))]
        [ClaimCheck("company_profile_manage_company_settings")]
        public async Task<IActionResult> UpdateCompanyProfile(Guid id, UpdateCompanyProfileCommand updateCompanyProfileCommand)
        {
            var result = await _mediator.Send(updateCompanyProfileCommand);
            return GenerateResponse(result);
        }
    }
}
