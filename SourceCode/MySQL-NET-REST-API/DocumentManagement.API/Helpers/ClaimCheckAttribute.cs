using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Primitives;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System;

namespace DocumentManagement.API.Helpers
{
    public class ClaimCheckAttribute(params string[] claimNames) : Attribute, IActionFilter
    {
        private StringValues auth;

        public void OnActionExecuted(ActionExecutedContext context)
        {
        }

        public void OnActionExecuting(ActionExecutingContext context)
        {
            context.HttpContext.Request.Headers.TryGetValue("Authorization", out auth);

            var tokenValue = auth[0].Replace("Bearer ", "");
            JwtSecurityToken token;
            Claim claim = null;

            token = new JwtSecurityTokenHandler().ReadJwtToken(tokenValue);
            foreach (var claimName in claimNames)
            {
                claim = token.Claims.Where(c => c.Type.Trim() == claimName.Trim() && c.Value == "true").FirstOrDefault();

                if (claim != null)
                {
                    break;
                }
            }

            if (claim == null)
            {
                context.Result = new StatusCodeResult(StatusCodes.Status403Forbidden);
            }
        }
    }
}