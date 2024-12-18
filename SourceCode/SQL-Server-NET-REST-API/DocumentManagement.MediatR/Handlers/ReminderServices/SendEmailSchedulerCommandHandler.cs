using AutoMapper;
using DocumentManagement.Common.UnitOfWork;
using DocumentManagement.Data;
using DocumentManagement.Data.Dto;
using DocumentManagement.Domain;
using DocumentManagement.Helper;
using DocumentManagement.MediatR.Handlers.StorageStategies;
using DocumentManagement.MediatR.Queries;
using DocumentManagement.Repository;
using MediatR;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.StaticFiles;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System;
using System.IO;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace DocumentManagement.MediatR.Handlers
{
    public class SendEmailSchedulerCommandHandler : IRequestHandler<SendEmailSchedulerCommand, bool>
    {
        private readonly ISendEmailRepository _sendEmailRepository;
        private readonly IUnitOfWork<DocumentContext> _uow;
        private readonly ILogger<SendEmailSchedulerCommandHandler> _logger;
        private readonly IMapper _mapper;
        private readonly IEmailSMTPSettingRepository _emailSMTPSettingRepository;
        private readonly PathHelper _pathHelper;
        private readonly IMediator _mediator;
        private readonly IWebHostEnvironment _webHostEnvironment;
        private readonly IDocumentRepository _documentRepository;
        private readonly IStorageSettingRepository _storageSettingRepository;
        private readonly StorageServiceFactory _storeageServiceFactory;

        public SendEmailSchedulerCommandHandler(
            ISendEmailRepository sendEmailRepository,
            ILogger<SendEmailSchedulerCommandHandler> logger,
            IUnitOfWork<DocumentContext> uow,
            IMapper mapper,
            IEmailSMTPSettingRepository emailSMTPSettingRepository,
            PathHelper pathHelper,
            IMediator mediator,
            IDocumentRepository documentRepository,
            IWebHostEnvironment webHostEnvironment,
            IStorageSettingRepository storageSettingRepository,
            StorageServiceFactory storeageServiceFactory
            )
        {
            _sendEmailRepository = sendEmailRepository;
            _uow = uow;
            _logger = logger;
            _mapper = mapper;
            _emailSMTPSettingRepository = emailSMTPSettingRepository;
            _pathHelper = pathHelper;
            _mediator = mediator;
            _documentRepository = documentRepository;
            _webHostEnvironment = webHostEnvironment;
            _storageSettingRepository = storageSettingRepository;
            _storeageServiceFactory = storeageServiceFactory;
        }

        public async Task<bool> Handle(SendEmailSchedulerCommand request, CancellationToken cancellationToken)
        {
            try
            {
                var sendEmails = await _sendEmailRepository.All
                    .OrderByDescending(c => c.CreatedDate)
                    .Where(c => !c.IsSend)
                    .Take(10)
                    .ToListAsync();

                if (sendEmails.Count > 0)
                {
                    var defaultSmtp = await _emailSMTPSettingRepository.FindBy(c => c.IsDefault).FirstOrDefaultAsync();
                    if (defaultSmtp == null)
                    {
                        return true;
                    }

                    foreach (var sendEmail in sendEmails)
                    {
                        if (!string.IsNullOrEmpty(sendEmail.Email))
                        {
                            try
                            {
                                var email = new SendEmailSpecification
                                {
                                    Body = sendEmail.Message,
                                    FromAddress = defaultSmtp.UserName,
                                    FromName = defaultSmtp.UserName,
                                    Host = defaultSmtp.Host,
                                    IsEnableSSL = defaultSmtp.IsEnableSSL,
                                    Password = defaultSmtp.Password,
                                    Port = defaultSmtp.Port,
                                    Subject = sendEmail.Subject,
                                    ToAddress = sendEmail.Email,
                                    CCAddress = "",
                                    UserName = defaultSmtp.UserName,
                                };

                                if (sendEmail.DocumentId != null)
                                {
                                    var document = await _documentRepository.All.FirstOrDefaultAsync(c => c.Id == sendEmail.DocumentId.Value);

                                    var storeageSetting = await _storageSettingRepository.GetStorageSettingByIdOrLocal(document.StorageSettingId);
                                    if (storeageSetting != null)
                                    {

                                        var storageService = _storeageServiceFactory.GetStorageService(storeageSetting.StorageType);

                                        var fileObject = await storageService.DownloadFileAsync(document.Url, storeageSetting.JsonValue, document.Key, document.IV);
                                        if (!string.IsNullOrEmpty(fileObject.ErrorMessage))
                                        {
                                            _logger.LogError($"Error while sending emails. {fileObject.ErrorMessage}");
                                            continue;
                                        }
                                        var fileInfo = new Helper.FileInfo()
                                        {
                                            Src = fileObject.FileBytes,
                                            FileType = "",
                                            Extension = Path.GetExtension(document.Url),
                                            Name = document.Name
                                        };
                                        email.Attechments.Add(fileInfo);
                                    }
                                }
                                await EmailHelper.SendEmail(email);

                            }
                            catch (Exception ex)
                            {
                                _logger.LogError(ex.Message, ex);
                            }
                        }
                        sendEmail.FromEmail = defaultSmtp.UserName;
                        sendEmail.IsSend = true;
                    }
                    _sendEmailRepository.UpdateRange(sendEmails);
                    if (await _uow.SaveAsync() <= 0)
                    {
                        return false;
                    }
                    return true;
                }
                return true;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message, ex);
                return true;
            }
        }
    }
}
