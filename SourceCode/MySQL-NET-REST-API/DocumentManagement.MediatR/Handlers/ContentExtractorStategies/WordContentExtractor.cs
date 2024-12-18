﻿using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Wordprocessing;
using DocumentManagement.Helper;
using Microsoft.AspNetCore.Http;
using System.IO;
using System.Text;

namespace DocumentManagement.MediatR.Handlers
{
    public class WordContentExtractor : IContentExtractor
    {
        public string ExtractContentByBytes(byte[] documentBytes, string tessdataPath, string tessLang)
        {
            using (var memoryStream = new MemoryStream(documentBytes))
            {
                // Open the WordprocessingDocument from the memory stream
                using (var wordDocument = WordprocessingDocument.Open(memoryStream, false))
                {
                    // Access the main document part
                    var body = wordDocument.MainDocumentPart.Document.Body;

                    var cleanText = UnWantKeywordRemovalHelper.CleanExtractedText(body.InnerText.ToString());
                    if (!string.IsNullOrEmpty(cleanText))
                    {
                        return cleanText;
                    }

                    // Read the text from the document
                    return "";
                }
            }
        }

        public string ExtractContentByFile(IFormFile file, string tessdataPath, string tessLang)
        {
            if (file == null || file.Length == 0)
            {
                return "";
            }

            var stringBuilder = new StringBuilder();

            using (var stream = file.OpenReadStream())
            {
                // Open WordprocessingDocument from the file stream
                using (WordprocessingDocument wordDoc = WordprocessingDocument.Open(stream, false))
                {
                    // Access the main document part
                    var body = wordDoc.MainDocumentPart.Document.Body;

                    // Loop through all elements in the body and append text
                    foreach (var text in body.Descendants<Text>())
                    {
                        var cleanText = UnWantKeywordRemovalHelper.CleanExtractedText(text.ToString());
                        if (!string.IsNullOrEmpty(cleanText))
                        {
                            stringBuilder.Append(cleanText);
                        }
                    }
                }
            }

            return stringBuilder.ToString();
        }
    }
}
