
using Microsoft.AspNetCore.Http;
using System;
using System.IO;
using System.Threading.Tasks;
using Tesseract;

namespace DocumentManagement.MediatR.Handlers
{
    public class TessDataContextExtractor
    {
        public string ExtractContentByBytes(string tessDataPath, byte[] documentBytes, string tessLang)
        {
            try
            {
                string text = string.Empty;
                using (var engine = new TesseractEngine(tessDataPath, tessLang, Tesseract.EngineMode.Default))
                {
                    using (var img = Pix.LoadFromMemory(documentBytes))
                    {
                        using (var page = engine.Process(img))
                        {
                            text = page.GetText(); // Get recognized text

                        }
                    }
                }
                return text;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error: {ex.Message}");
                return "";
            }
        }
        public async Task<string> ExtractContentByFile(string tessDataPath, IFormFile file, string tessLang)
        {
            if (file == null || file.Length == 0)
            {
                return "";
            }

            using (var memoryStream = new MemoryStream())
            {
                await file.CopyToAsync(memoryStream);
                var fileBytes = memoryStream.ToArray();

                // Step 2: Use Tesseract to perform OCR on the file in memory
                using (var engine = new TesseractEngine(tessDataPath, tessLang, Tesseract.EngineMode.Default))
                {
                    using (var img = Pix.LoadFromMemory(fileBytes))
                    {
                        using (var page = engine.Process(img))
                        {
                            return page.GetText();
                        }
                    }
                }
            }

        }
    }
}
