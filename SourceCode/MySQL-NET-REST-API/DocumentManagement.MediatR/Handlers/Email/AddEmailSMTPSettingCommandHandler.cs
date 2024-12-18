using AutoMapper;
using DocumentManagement.Common.UnitOfWork;
using DocumentManagement.Data;
using DocumentManagement.Data.Dto;
using DocumentManagement.Domain;
using DocumentManagement.Helper;
using DocumentManagement.MediatR.Commands;
using DocumentManagement.Repository;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace DocumentManagement.MediatR.Handlers
{
    public class AddEmailSMTPSettingCommandHandler : IRequestHandler<AddEmailSMTPSettingCommand, ServiceResponse<EmailSMTPSettingDto>>
    {
        private readonly IEmailSMTPSettingRepository _emailSMTPSettingRepository;
        private readonly IUnitOfWork<DocumentContext> _uow;
        private readonly IMapper _mapper;
        private readonly ILogger<AddEmailSMTPSettingCommand> _logger;

        public AddEmailSMTPSettingCommandHandler(
           IEmailSMTPSettingRepository emailSMTPSettingRepository,
            IMapper mapper,
            IUnitOfWork<DocumentContext> uow,
            ILogger<AddEmailSMTPSettingCommand> logger
        )
        {
            _emailSMTPSettingRepository = emailSMTPSettingRepository;
            _mapper = mapper;
            _uow = uow;
            _logger = logger;
        }

        public async Task<ServiceResponse<EmailSMTPSettingDto>> Handle(AddEmailSMTPSettingCommand request, CancellationToken cancellationToken)
        {
            var data = new SendEmailSpecification
            {
                Body = "Dear User,\n\nThis is a test email to verify the SMTP configuration. If you're receiving this email, the SMTP settings are working correctly.\n\nBest regards",
                FromAddress = request.UserName,
                Host = request.Host,
                IsEnableSSL = request.IsEnableSSL,
                Password = request.Password,
                Port = request.Port,
                Subject = "SMTP Configuration Test",
                ToAddress = request.UserName,
                CCAddress = "",
                UserName = request.UserName
            };

            var emailTestResult = await TestMailAsync(data);
            if (!emailTestResult)
            {
                _logger.LogError("SMTP configuration is incorrect, please check the settings and try again.");
                return ServiceResponse<EmailSMTPSettingDto>.Return422("SMTP configuration is incorrect, please check the settings and try again.");
            }

            var entity = _mapper.Map<EmailSMTPSetting>(request);
            _emailSMTPSettingRepository.Add(entity);

            if (entity.IsDefault)
            {
                var defaultEmailSMTPSettings = await _emailSMTPSettingRepository.All.Where(c => c.IsDefault).ToListAsync();
                defaultEmailSMTPSettings.ForEach(c => c.IsDefault = false);
                _emailSMTPSettingRepository.UpdateRange(defaultEmailSMTPSettings);
            }

            if (await _uow.SaveAsync() <= -1)
            {
                return ServiceResponse<EmailSMTPSettingDto>.Return409("Failed to save email SMTP settings.");
            }

            var entityDto = _mapper.Map<EmailSMTPSettingDto>(entity);
            return ServiceResponse<EmailSMTPSettingDto>.ReturnResultWith200(entityDto);
        }

        public async Task<bool> TestMailAsync(SendEmailSpecification sendEmailSpecification)
        {
            try
            {
               var result = await EmailHelper.SendEmail(sendEmailSpecification);
                return result;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error while sending email");
                return false;
            }
        }
    }
}
