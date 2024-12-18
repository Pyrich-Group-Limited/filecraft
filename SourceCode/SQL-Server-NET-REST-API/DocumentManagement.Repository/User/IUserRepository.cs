using DocumentManagement.Common.GenericRepository;
using DocumentManagement.Data;
using DocumentManagement.Data.Dto;
using System.Collections.Generic;
using System;
using System.Threading.Tasks;
using DocumentManagement.Data.Resources;

namespace DocumentManagement.Repository
{
    public interface IUserRepository : IGenericRepository<User>
    {
        Task<UserAuthDto> BuildUserAuthObject(User appUser);

        Task<List<User>> GetUsersByIds(List<Guid> ids);
        Task<UserList> GetUsers(UserResource userResource);
    }
}
