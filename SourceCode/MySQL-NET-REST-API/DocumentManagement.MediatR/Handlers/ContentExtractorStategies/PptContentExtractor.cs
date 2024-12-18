using DocumentFormat.OpenXml.Packaging;
using DocumentManagement.Helper;
using Microsoft.AspNetCore.Http;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Tesseract;

namespace DocumentManagement.MediatR.Handlers.ContentExtractorStategies
{
    public class PptContentExtractor: IContentExtractor
    {
        public string ExtractContentByBytes(byte[] documentBytes, string tessdataPath, string tessLang)
        {
            using (MemoryStream pptStream = new MemoryStream(documentBytes))
            {
                using (PresentationDocument presentationDocument = PresentationDocument.Open(pptStream, false))
                {
                    // Access the presentation part
                    PresentationPart presentationPart = presentationDocument.PresentationPart;
                    StringBuilder str = new StringBuilder();
                    if (presentationPart != null && presentationPart.SlideParts != null)
                    {
                        foreach (var slidePart in presentationPart.SlideParts)
                        {
                            // Extract text from the slide
                            var slideText = string.Join(" ", slidePart.Slide.Descendants<DocumentFormat.OpenXml.Drawing.Text>().Select(t => t.Text));
                            if (!string.IsNullOrWhiteSpace(slideText))
                            {
                                var cleanText = UnWantKeywordRemovalHelper.CleanExtractedText(slideText);
                                str.Append(cleanText);
                            }

                            foreach (var imagePart in slidePart.ImageParts)
                            {
                                // Save the image to disk or process it further
                                using (Stream imageStream = imagePart.GetStream())
                                {
                                    using (var engine = new TesseractEngine(tessdataPath, tessLang, EngineMode.Default))
                                    {
                                        // Load the image from the stream
                                        using (var img = Pix.LoadFromMemory(StreamToBytes(imageStream)))
                                        {
                                            // Perform OCR and extract text
                                            using (var page = engine.Process(img))
                                            {
                                                string text = page.GetText();
                                                if (!string.IsNullOrWhiteSpace(text))
                                                {
                                                    var cleanText = UnWantKeywordRemovalHelper.CleanExtractedText(text);
                                                    if (!string.IsNullOrEmpty(cleanText))
                                                    {
                                                        str.Append(cleanText);
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                        }
                    }
                    return str.ToString();
                }
            }
        }

        static byte[] StreamToBytes(Stream inputStream)
        {
            using (MemoryStream memoryStream = new MemoryStream())
            {
                // Copy the input stream to the memory stream
                inputStream.CopyTo(memoryStream);
                return memoryStream.ToArray(); // Return the byte array
            }
        }


        public string ExtractContentByFile(IFormFile file, string tessdataPath, string tessLang)
        {
            if (file == null || file.Length == 0)
            {
                return "No file uploaded or file is empty.";
            }
            using (var stream = file.OpenReadStream())
            {
                using (PresentationDocument presentationDocument = PresentationDocument.Open(stream, false))
                {
                    // Access the presentation part
                    PresentationPart presentationPart = presentationDocument.PresentationPart;
                    StringBuilder str = new StringBuilder();
                    if (presentationPart != null && presentationPart.SlideParts != null)
                    {
                        foreach (var slidePart in presentationPart.SlideParts)
                        {
                            // Extract text from the slide
                            var slideText = string.Join(" ", slidePart.Slide.Descendants<DocumentFormat.OpenXml.Drawing.Text>().Select(t => t.Text));
                            if (!string.IsNullOrWhiteSpace(slideText))
                            {
                                var cleanText = UnWantKeywordRemovalHelper.CleanExtractedText(slideText);
                                str.Append(cleanText);
                            }

                            foreach (var imagePart in slidePart.ImageParts)
                            {
                                // Save the image to disk or process it further
                                using (Stream imageStream = imagePart.GetStream())
                                {
                                    using (var engine = new TesseractEngine(tessdataPath, tessLang, EngineMode.Default))
                                    {
                                        // Load the image from the stream
                                        using (var img = Pix.LoadFromMemory(StreamToBytes(imageStream)))
                                        {
                                            // Perform OCR and extract text
                                            using (var page = engine.Process(img))
                                            {
                                                string text = page.GetText();
                                                if (!string.IsNullOrWhiteSpace(text))
                                                {
                                                    var cleanText= UnWantKeywordRemovalHelper.CleanExtractedText(text);
                                                    str.Append(cleanText);
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                        }
                    }
                    return str.ToString();
                }
            }
        }
    }
}
