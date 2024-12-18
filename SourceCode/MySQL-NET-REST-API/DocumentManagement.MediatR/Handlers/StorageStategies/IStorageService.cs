﻿using DocumentManagement.Data;
using DocumentManagement.Data.Dto;
using DocumentManagement.Data.Dto.Document;
using Microsoft.AspNetCore.Http;
using System;
using System.Threading.Tasks;

namespace DocumentManagement.MediatR.Handlers.StorageStategies
{
    public interface IStorageService
    {
        Task<UploadFileResponse> UploadFileAsync(IFormFile file, StorageSetting storageSetting);
        Task<DownloadFileResponse> DownloadFileAsync(string fileName, string storageSetting, byte[] key, byte[] iv);
        Task DeleteFileAsync(string fileName, string storageSetting);
        Task<UploadFileResponse> TestUploadFileAsync(IFormFile file, StorageSetting storageSetting);
    }
}
