using DocumentManagement.Data.Entities;
using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace DocumentManagement.Data
{
    public class DocumentVersion : BaseEntity
    {
        public Guid Id { get; set; }
        public Guid DocumentId { get; set; }
        public string Url { get; set; }
        [ForeignKey("DocumentId")]
        public Document Document { get; set; }
        [ForeignKey("CreatedBy")]
        public User CreatedByUser { get; set; }
        public byte[]? Key { get; set; }
        public byte[]? IV { get; set; }
    }
}
