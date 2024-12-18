using DocumentManagement.Data.Entities;
using System;

namespace DocumentManagement.Data
{
    public class DocumentMetaData : BaseEntity
    {
        public Guid Id { get; set; }
        public Guid DocumentId { get; set; }
        public Document Document { get; set; }
        public string Metatag { get; set; }

    }
}
