using System;

namespace DocumentManagement.Data.Dto
{
    public class DocumentVersionDto
    {
        public Guid Id { get; set; }
        public Guid DocumentId { get; set; }
        public string Url { get; set; }
        public string CreatedByUser { get; set; }
        public bool IsCurrentVersion { get; set; }
        public DateTime ModifiedDate { get; set; }
    }
}
