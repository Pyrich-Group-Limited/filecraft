using Microsoft.Extensions.Configuration;
using System;

namespace DocumentManagement.Helper
{
    public class PathHelper
    {
        public IConfiguration _configuration;

        public PathHelper(IConfiguration configuration)
        {
            this._configuration = configuration;
        }

        public string TestFile
        {
            get
            {
                return _configuration["TestFile"];
            }
        }
        public string DocumentPath
        {
            get
            {
                return _configuration["DocumentPath"];
            }
        }

        public string SearchIndexPath
        {
            get
            {
                return _configuration["SearchIndexPath"];
            }
        }
        public string AesEncryptionKey
        {
            get
            {
                return _configuration["AesEncryptionKey"];
            }
        }
        public bool AllowEncryption
        {
            get
            {
                return Convert.ToBoolean(_configuration["AllowEncryption"]);
            }
        }
        public string ReminderFromEmail
        {
            get
            {
                return _configuration["ReminderFromEmail"];
            }
        }
        public string TESSDATA
        {
            get
            {
                return _configuration["TESSDATA"];
            }
        }

        public string FrontEndUrl
        {
            get
            {
                return _configuration["FrontEndUrl"];
            }
        }

        public string[] CorsUrls
        {
            get
            {
                return string.IsNullOrEmpty(_configuration["CorsUrls"]) ? new string[] { } : _configuration["CorsUrls"].Split(",");
            }
        }
        public string[] IMAGESSUPPORT
        {
            get
            {
                return string.IsNullOrEmpty(_configuration["IMAGESSUPPORT"]) ? new string[] { } : _configuration["IMAGESSUPPORT"].Split(",");
            }
        }
        public long MaxFileSizeIndexingQuick
        {
            get
            {
                return Convert.ToInt64( _configuration["MaxFileSizeIndexingQuick"]);
            }
        }
        public string TESSSUPPORTLANGUAGES
        {
            get
            {
                return _configuration["TESSSUPPORTLANGUAGES"];
            }
        }


    }
}
