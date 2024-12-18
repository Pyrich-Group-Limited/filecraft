using System;

namespace DocumentManagement.Data.Entities
{
    public class CompanyProfile:BaseEntity
    {
        public  Guid Id { get; set; }
        public string Name { get; set; }
        public string LogoUrl { get; set; }
        public string BannerUrl { get; set; }
    }
}
