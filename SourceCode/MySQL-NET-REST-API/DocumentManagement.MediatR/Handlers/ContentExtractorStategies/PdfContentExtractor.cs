
using iText.Kernel.Pdf;
using iText.Kernel.Pdf.Canvas.Parser;
using iText.Kernel.Pdf.Canvas.Parser.Listener;
using Microsoft.AspNetCore.Http;
using SixLabors.ImageSharp.PixelFormats;
using SixLabors.ImageSharp;
using System.IO;
using System.Text;
using Tesseract;
using iText.Kernel.Pdf.Xobject;
using DocumentManagement.Helper;

namespace DocumentManagement.MediatR.Handlers
{
    public class PdfContentExtractor : IContentExtractor
    {
        public string ExtractContentByBytes(byte[] documentBytes, string tessdataPath, string tessLang)
        {
            using (var memoryStream = new MemoryStream(documentBytes))
            {
                using (PdfReader pdfReader = new PdfReader(memoryStream))
                using (PdfDocument pdfDocument = new PdfDocument(pdfReader))
                {
                    StringBuilder text = new StringBuilder();
                    for (int i = 1; i <= pdfDocument.GetNumberOfPages(); i++)
                    {
                        var page = pdfDocument.GetPage(i);

                        var pageText = PdfTextExtractor.GetTextFromPage(page);

                        if (!string.IsNullOrEmpty(pageText))
                        {
                            text.Append(pageText);
                        }
                        else
                        {
                            var resources = page.GetResources();
                            // Get all XObject resources (this includes images)
                            var xObjects = resources.GetResource(PdfName.XObject);
                            if (xObjects != null)
                            {
                                foreach (var entry in xObjects.KeySet())
                                {
                                    // Check if the resource is an image (PdfImageXObject)
                                    var xObject = xObjects.Get(entry);
                                    if (xObject.IsStream())
                                    {
                                        var stream = (PdfStream)xObject;
                                        var subtype = stream.Get(PdfName.Subtype);
                                        if (PdfName.Image.Equals(subtype))
                                        {
                                            PdfImageXObject imageXObject = new PdfImageXObject(stream);
                                            var img = ConvertPdfImageToImageSharp(imageXObject);
                                            var textData = PerformOcrOnImage(img, tessdataPath, tessLang);
                                            if (!string.IsNullOrEmpty(textData))
                                            {
                                                var cleanText = UnWantKeywordRemovalHelper.CleanExtractedText(textData);
                                                if (!string.IsNullOrEmpty(cleanText))
                                                {
                                                    text.Append(cleanText);
                                                }
                                            }

                                        }
                                    }
                                }
                            }
                        }
                    }
                    return text.ToString();
                }
            }
        }

        public string ExtractContentByFile(IFormFile file, string tessdataPath, string tessLang)
        {
            if (file == null || file.Length == 0)
            {
                return "";
            }

            var text = new StringBuilder();

            using (var stream = file.OpenReadStream())
            {
                // Initialize PdfReader with the file stream
                using (var pdfReader = new PdfReader(stream))
                {
                    // Load the PDF document using PdfDocument
                    using (var pdfDoc = new PdfDocument(pdfReader))
                    {
                        // Loop through all pages and extract text
                        for (int page = 1; page <= pdfDoc.GetNumberOfPages(); page++)
                        {
                            var pdfPage = pdfDoc.GetPage(page);
                            string pageText = PdfTextExtractor.GetTextFromPage(pdfPage);

                            if (!string.IsNullOrEmpty(pageText))
                            {
                                text.Append(pageText);
                            }
                            else
                            {
                                var resources = pdfPage.GetResources();
                                // Get all XObject resources (this includes images)
                                var xObjects = resources.GetResource(PdfName.XObject);
                                if (xObjects != null)
                                {
                                    foreach (var entry in xObjects.KeySet())
                                    {
                                        // Check if the resource is an image (PdfImageXObject)
                                        var xObject = xObjects.Get(entry);
                                        if (xObject.IsStream())
                                        {
                                            var pdfstream = (PdfStream)xObject;
                                            var subtype = pdfstream.Get(PdfName.Subtype);
                                            if (PdfName.Image.Equals(subtype))
                                            {
                                                PdfImageXObject imageXObject = new PdfImageXObject(pdfstream);
                                                var img = ConvertPdfImageToImageSharp(imageXObject);
                                                var textData = PerformOcrOnImage(img, tessdataPath, tessLang);
                                                if (!string.IsNullOrEmpty(textData))
                                                {
                                                    var cleanText = UnWantKeywordRemovalHelper.CleanExtractedText(textData);
                                                    if (!string.IsNullOrEmpty(cleanText))
                                                    {
                                                        text.Append(cleanText);
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            return text.ToString();
        }

        private Image<Rgba32> ConvertPdfImageToImageSharp(PdfImageXObject pdfImage)
        {
            // Get the raw bytes of the image
            var imageBytes = pdfImage.GetImageBytes();
            using (var ms = new MemoryStream(imageBytes))
            {
                return Image.Load<Rgba32>(ms); // Convert bytes to ImageSharp Image
            }
        }

        // Check if a page contains text
        private static bool CheckPageForText(PdfPage page)
        {
            var strategy = new SimpleTextExtractionStrategy();
            string extractedText = PdfTextExtractor.GetTextFromPage(page, strategy);
            return !string.IsNullOrWhiteSpace(extractedText);  // Returns true if text is found
        }


        // Perform OCR on an image using Tesseract
        private static string PerformOcrOnImage(Image<Rgba32> image, string tessdataPath, string tessLang)
        {
            string extractedText = "";

            using (var engine = new TesseractEngine(tessdataPath, tessLang, EngineMode.Default))
            {

                using (var img = ConvertImageToPix(image))
                {
                    using (var page = engine.Process(img))
                    {
                        var cleanText = UnWantKeywordRemovalHelper.CleanExtractedText(page.GetText());
                        extractedText = cleanText; // Get recognized text

                    }
                }
            }
            return extractedText;
        }
        public static Pix ConvertImageToPix(Image<Rgba32> image)
        {
            // Convert Image<Rgba32> to a memory stream (save as a BMP or PNG format)
            using (var memoryStream = new MemoryStream())
            {
                // You can choose the format - here BMP is used as an example
                image.SaveAsPng(memoryStream); // Alternatively, use SaveAsBmp(memoryStream) for PNG

                // Reset the stream position to the beginning
                memoryStream.Position = 0;

                // Load the stream into a Pix object
                return Pix.LoadFromMemory(memoryStream.ToArray());
            }
        }

        // Check if a page contains text


    }
}
