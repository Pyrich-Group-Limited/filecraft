using System;
using System.Collections.Generic;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using DocumentManagement.API.Helpers;
using DocumentManagement.Data.Dto;
using DocumentManagement.Data.Dto.Document;
using DocumentManagement.Data.Resources;
using DocumentManagement.Helper;
using DocumentManagement.MediatR.Commands;
using DocumentManagement.MediatR.Queries;
using DocumentManagement.Repository;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace DocumentManagement.API.Controllers
{
    /// <summary>
    /// Document
    /// </summary>
    [Route("api")]
    [ApiController]
    [Authorize]
    public class DocumentController : BaseController
    {
        public IMediator _mediator { get; set; }
        private PathHelper _pathHelper;
        /// <summary>
        /// Document
        /// </summary>
        /// <param name="mediator"></param>
        /// <param name="webHostEnvironment"></param>
        /// <param name="pathHelper"></param>
        public DocumentController(
            IMediator mediator,

            PathHelper pathHelper
            )
        {
            _mediator = mediator;
            _pathHelper = pathHelper;

        }
        /// <summary>
        /// Get Document By Id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet("Document/{id}", Name = "GetDocument")]
        [Produces("application/json", "application/xml", Type = typeof(DocumentDto))]
        public async Task<IActionResult> GetDocument(Guid id)
        {
            var getDocumentQuery = new GetDocumentQuery
            {
                Id = id
            };
            var response = await _mediator.Send(getDocumentQuery);
            if (!response.Success)
            {
                return StatusCode(response.StatusCode, response.Errors);
            }
            var result = response.Data;
            return StatusCode(result.StatusCode, result);
        }

        [HttpGet("Document/deepSearch", Name = "DeepSearch")]
        [Produces("application/json", "application/xml", Type = typeof(List<DocumentDto>))]
        [ClaimCheck("deep_search_deep_search")]
        public async Task<IActionResult> DeepSearch(string searchQuery)
        {
            var deepSearchCommand = new DeepSearchCommand
            {
                SearchQuery = searchQuery
            };
            var response = await _mediator.Send(deepSearchCommand);
            if (!response.Success)
            {
                return StatusCode(response.StatusCode, response.Errors);
            }
            return Ok(response.Data);
        }

        [HttpPost("Document/{id}/remove/pageindexing", Name = "RemovePageIndexing")]
        [Produces("application/json", "application/xml", Type = typeof(List<DocumentDto>))]
        [ClaimCheck("deep_search_remove_document_index")]
        public async Task<IActionResult> RemovePageIndexing(Guid Id)
        {
            var removePageIndexingCommand = new RemovePageIndexingCommand
            {
                DocumentId = Id
            };
            var response = await _mediator.Send(removePageIndexingCommand);
            if (!response.Success)
            {
                return StatusCode(response.StatusCode, response.Errors);
            }
            return Ok(response);
        }

        [HttpPost("Document/{id}/add/pageindexing", Name = "AddPageIndexing")]
        [Produces("application/json", "application/xml", Type = typeof(List<DocumentDto>))]
        [ClaimCheck("deep_search_add_document_index")]
        public async Task<IActionResult> AddPageIndexing(Guid Id)
        {
            var addPageIndexingCommand = new AddPageIndexingCommand
            {
                DocumentId = Id
            };
            var response = await _mediator.Send(addPageIndexingCommand);
            if (!response.Success)
            {
                return StatusCode(response.StatusCode, response.Errors);
            }
            return Ok(response);
        }

        /// <summary>
        /// Get All Documents
        /// </summary>
        /// <param name="Name"></param>
        /// <param name="Id"></param>
        /// <param name="CreatedBy"></param>
        /// <returns></returns>
        [HttpGet("Documents")]
        [Produces("application/json", "application/xml", Type = typeof(DocumentList))]
        [ClaimCheck("all_documents_view_documents")]
        public async Task<IActionResult> GetDocuments([FromQuery] DocumentResource documentResource)
        {
            var getAllDocumentQuery = new GetAllDocumentQuery
            {
                DocumentResource = documentResource
            };
            var result = await _mediator.Send(getAllDocumentQuery);

            var paginationMetadata = new
            {
                totalCount = result.TotalCount,
                pageSize = result.PageSize,
                skip = result.Skip,
                totalPages = result.TotalPages
            };

            Response.Headers.Append("X-Pagination",
                JsonSerializer.Serialize(paginationMetadata));

            return Ok(result);
        }
        /// <summary>
        /// Create a document.
        /// </summary>
        /// <param name="addDocumentCommand"></param>
        /// <returns></returns>
        [HttpPost("Document")]
        [DisableRequestSizeLimit]
        [Produces("application/json", "application/xml", Type = typeof(DocumentDto))]
        [ClaimCheck("all_documents_create_document")]
        public async Task<IActionResult> AddDocument([FromForm] AddDocumentCommand addDocumentCommand)
        {
            var result = await _mediator.Send(addDocumentCommand);
            if (!result.Success)
            {
                return StatusCode(result.StatusCode, result.Errors);
            }
            return CreatedAtAction("GetDocument", new { id = result.Data.Id }, result.Data);
        }

        [HttpPost("Document/assign")]
        [DisableRequestSizeLimit]
        [Produces("application/json", "application/xml", Type = typeof(DocumentDto))]
        [ClaimCheck("all_documents_create_document", "assigned_documents_create_document")]
        public async Task<IActionResult> AddDocumentToMe([FromForm] AddDocumentToMeCommand addDocumentCommand)
        {
            var result = await _mediator.Send(addDocumentCommand);
            if (!result.Success)
            {
                return StatusCode(result.StatusCode, result.Errors);
            }
            return CreatedAtAction("GetDocument", new { id = result.Data.Id }, result.Data);
        }
        /// <summary>
        /// Upload document.
        /// </summary>
        /// <param name="Id"></param>
        /// <param name="updateDocumentCommand"></param>
        /// <returns></returns>
        [HttpPut("Document/{Id}")]
        [Produces("application/json", "application/xml", Type = typeof(DocumentDto))]
        [ClaimCheck("all_documents_edit_document")]
        public async Task<IActionResult> UpdateDocument(Guid Id, UpdateDocumentCommand updateDocumentCommand)
        {
            updateDocumentCommand.Id = Id;
            var result = await _mediator.Send(updateDocumentCommand);
            return StatusCode(result.StatusCode, result);
        }
        /// <summary>
        /// Delete Document.
        /// </summary>
        /// <param name="Id"></param>
        /// <returns></returns>
        [HttpDelete("Document/{Id}")]
        [ClaimCheck("all_documents_delete_document")]
        public async Task<IActionResult> DeleteDocument(Guid Id)
        {
            var deleteDocumentCommand = new DeleteDocumentCommand
            {
                Id = Id
            };
            var result = await _mediator.Send(deleteDocumentCommand);
            return StatusCode(result.StatusCode, result);
        }

        [HttpGet("Document/{id}/download")]
        public async Task<IActionResult> DownloadDocument(Guid id, bool isVersion)
        {
            var commnad = new DownloadDocumentCommand
            {
                Id = id,
                IsVersion = isVersion
            };

            var downloadDocumentResponse = await _mediator.Send(commnad);
            if (!downloadDocumentResponse.Success)
            {
                return GenerateResponse(downloadDocumentResponse);
            }

            var downloadDocument = downloadDocumentResponse.Data;

            return File(downloadDocument.Data, downloadDocument.ContentType, downloadDocument.FileName);
        }

        [HttpGet("Document/{id}/officeviewer")]
        [AllowAnonymous]
        public async Task<IActionResult> GetDocumentFileByToken(Guid id, [FromQuery] OfficeViewerRequest officeViewerRequest)
        {
            var getDocumentTokenCommand = new GetDocumentPathByTokenCommand
            {
                Id = id,
                Token = officeViewerRequest.Token,
                IsPublic = officeViewerRequest.IsPublic
            };

            var result = await _mediator.Send(getDocumentTokenCommand);
            if (!result)
            {
                return NotFound();
            }

            if (officeViewerRequest.IsPublic)
            {
                var downloadSharedDocumentComamnd = new DownloadSharedDocumentCommand
                {
                    Code = id.ToString(),
                    Password = officeViewerRequest.Password
                };

                var downloadResult = await _mediator.Send(downloadSharedDocumentComamnd);
                if (!downloadResult.Success)
                {
                    return GenerateResponse(downloadResult);
                }

                var sharedDocument = downloadResult.Data;
                return File(sharedDocument.Data, sharedDocument.ContentType, sharedDocument.FileName);
            }

            var commnad = new DownloadDocumentCommand
            {
                Id = id,
                IsVersion = officeViewerRequest.IsVersion
            };

            var downloadDocumentResponse = await _mediator.Send(commnad);

            if (!downloadDocumentResponse.Success)
            {
                return GenerateResponse(downloadDocumentResponse);
            }

            var downloadDocument = downloadDocumentResponse.Data;
            return File(downloadDocument.Data, downloadDocument.ContentType, downloadDocument.FileName);
        }


        [HttpGet("Document/{id}/isDownloadFlag")]
        [AllowAnonymous]
        public async Task<ActionResult> GetIsDownloadFlag(Guid id)
        {
            var deleteDocumentTokenCommand = new GetIsDownloadFlagQuery
            {
                DocumentId = id,
            };
            var result = await _mediator.Send(deleteDocumentTokenCommand);
            return Ok(result);
        }

        /// <summary>
        /// Read text Document
        /// </summary>
        /// <param name="id"></param>
        /// <param name="isVersion"></param>
        /// <returns></returns>
        [HttpGet("Document/{id}/readText")]
        public async Task<IActionResult> ReadTextDocument(Guid id, bool isVersion)
        {
            var commnad = new DownloadDocumentCommand
            {
                Id = id,
                IsVersion = isVersion
            };
            var downloadDocumentResponse = await _mediator.Send(commnad);

            if (!downloadDocumentResponse.Success)
            {
                return GenerateResponse(downloadDocumentResponse);
            }

            var downloadDocument = downloadDocumentResponse.Data;
            string utfString = Encoding.UTF8.GetString(downloadDocument.Data, 0, downloadDocument.Data.Length);
            return Ok(new { result = new string[] { utfString } });

        }

        [HttpGet("Document/{id}/getMetatag")]
        public async Task<IActionResult> GetDocumentMetatags(Guid id)
        {
            var commnad = new GetDocumentMetaDataByIdQuery
            {
                DocumentId = id,
            };
            var documentMetas = await _mediator.Send(commnad);
            return Ok(documentMetas);
        }

    }
}
