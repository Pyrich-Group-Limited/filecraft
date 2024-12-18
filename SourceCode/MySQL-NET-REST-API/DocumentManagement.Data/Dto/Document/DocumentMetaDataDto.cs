using System;

namespace DocumentManagement.Data.Dto
{
    public class DocumentMetaDataDto
    {
        public Guid? Id { get; set; }
        public Guid? DocumentId { get; set; }
        public string Metatag { get; set; }
    }
}
