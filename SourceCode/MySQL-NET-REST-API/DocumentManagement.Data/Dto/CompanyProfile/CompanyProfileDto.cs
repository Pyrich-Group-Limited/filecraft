using System;

namespace DocumentManagement.Data.Dto
{
    public class CompanyProfileDto: ErrorStatusCode
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string LogoUrl { get; set; }
        public string BannerUrl { get; set; }
    }
}
