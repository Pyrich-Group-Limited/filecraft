using DocumentManagement.MediatR.Handlers.ContentExtractorStategies;

namespace DocumentManagement.MediatR.Handlers
{
    public class ContentExtractorFactory
    {
        public static IContentExtractor GetExtractor(string fileExtension)
        {
            return fileExtension.ToLower() switch
            {
                ".pdf" => new PdfContentExtractor(),
                ".doc" or ".docx" => new WordContentExtractor(),
                ".xls" or ".xlsx" => new ExcelContentExtractor(),
                ".ppt" or ".pptx" => new PptContentExtractor(),
                ".txt" => new TextContentExtractor(),
                _ => null
            };
        }
    }
}
