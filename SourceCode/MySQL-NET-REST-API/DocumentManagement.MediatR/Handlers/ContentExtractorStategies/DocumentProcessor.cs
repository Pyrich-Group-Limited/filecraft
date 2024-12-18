using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DocumentManagement.MediatR.Handlers
{
    public class DocumentProcessor
    {
        private readonly IContentExtractor _contentExtractor;

        public DocumentProcessor(IContentExtractor contentExtractor)
        {
            _contentExtractor = contentExtractor;
        }

        public string ProcessDocumentByBytes(byte[] documentBytes, string tessdataPath, string tessLang )
        {
            return _contentExtractor.ExtractContentByBytes(documentBytes, tessdataPath, tessLang);
        }
        public string ProcessDocumentByIFile(IFormFile file, string tessdataPath, string tessLang)
        {
            return _contentExtractor.ExtractContentByFile(file,  tessdataPath, tessLang);
        }
    }
}
