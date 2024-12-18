
using DocumentManagement.Common.GenericRepository;
using DocumentManagement.Data;
using System.Threading.Tasks;

namespace DocumentManagement.Repository
{
    public interface ISendEmailRepository : IGenericRepository<SendEmail>
    {
        void AddSharedEmails(SendEmail sendEmail, string documentName);
    }
}
