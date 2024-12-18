using DocumentManagement.Common.GenericRepository;
using DocumentManagement.Common.UnitOfWork;
using DocumentManagement.Data;
using DocumentManagement.Domain;

namespace DocumentManagement.Repository
{
    public class DocumentVersionRepository : GenericRepository<DocumentVersion, DocumentContext>, IDocumentVersionRepository
    {
        public DocumentVersionRepository(IUnitOfWork<DocumentContext> uow) : base(uow)
        {
        }
    }

}