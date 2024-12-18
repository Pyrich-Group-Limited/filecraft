﻿using DocumentManagement.Data.Dto;
using MediatR;
using System;

namespace DocumentManagement.MediatR.Commands
{
    public class ActiveDeactiveUserCommand : IRequest<UserDto>
    {
        public Guid Id { get; set; }
    }
}
