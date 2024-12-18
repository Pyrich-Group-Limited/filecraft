using System;

namespace DocumentManagement.Data.Dto
{
    public class CategoryDto : ErrorStatusCode
    {
        public Guid Id { get; set; }
        public string Name { get; set; }=string.Empty;
        public string Description { get; set; } = string.Empty;
        public Guid? ParentId { get; set; }
    }
}
