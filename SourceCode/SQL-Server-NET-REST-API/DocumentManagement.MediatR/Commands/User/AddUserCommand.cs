﻿using DocumentManagement.Data.Dto;
using MediatR;
using System.Collections.Generic;

namespace DocumentManagement.MediatR.Commands
{
    public class AddUserCommand : IRequest<UserDto>
    {
        public string UserName { get; set; }
        public string Email { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Password { get; set; }
        public string PhoneNumber { get; set; }
        public List<UserRoleDto> UserRoles { get; set; } = new List<UserRoleDto>();

    }
}
