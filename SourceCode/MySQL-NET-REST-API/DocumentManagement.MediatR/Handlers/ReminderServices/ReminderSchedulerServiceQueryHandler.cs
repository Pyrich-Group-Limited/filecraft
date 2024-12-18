using DocumentManagement.Common.UnitOfWork;
using DocumentManagement.Domain;
using DocumentManagement.Helper;
using DocumentManagement.MediatR.Queries;
using DocumentManagement.Repository;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace DocumentManagement.MediatR.Handlers
{
    public class ReminderSchedulerServiceQueryHandler : IRequestHandler<ReminderSchedulerServiceQuery, bool>
    {
        private readonly IReminderSchedulerRepository _reminderSchedulerRepository;
        private readonly IEmailSMTPSettingRepository _emailSMTPSettingRepository;
        private readonly ILogger<ReminderSchedulerServiceQueryHandler> _logger;
        private readonly PathHelper _pathHelper;
        private readonly IUnitOfWork<DocumentContext> _uow;
        private readonly IUserNotificationRepository _userNotificationRepository;


        public ReminderSchedulerServiceQueryHandler(IReminderRepository reminderRepository,
            IReminderSchedulerRepository reminderSchedulerRepository,
            IEmailSMTPSettingRepository emailSMTPSettingRepository,
            IUnitOfWork<DocumentContext> uow,
             ILogger<ReminderSchedulerServiceQueryHandler> logger,
             PathHelper pathHelper,
             IUserNotificationRepository userNotificationRepository
            )
        {
            _reminderSchedulerRepository = reminderSchedulerRepository;
            _emailSMTPSettingRepository = emailSMTPSettingRepository;
            _logger = logger;
            _pathHelper = pathHelper;
            _uow = uow;
            _userNotificationRepository = userNotificationRepository;
        }

        public async Task<bool> Handle(ReminderSchedulerServiceQuery request, CancellationToken cancellationToken)
        {
            try
            {
                var currentDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, DateTime.Now.Hour, DateTime.Now.Minute, DateTime.Now.Second).ToUniversalTime();

                var reminderSchedulers = await _reminderSchedulerRepository.AllIncluding(c => c.User)
                                                .AsNoTracking()
                                                .OrderBy(c => c.Duration)
                                                .Where(c => c.IsActive && c.Duration <= currentDate)
                                                .Take(10)
                                                .ToListAsync();

                if (reminderSchedulers.Count() > 0)
                {
                    var defaultSmtp = await _emailSMTPSettingRepository.FindBy(c => c.IsDefault).FirstOrDefaultAsync();

                    foreach (var reminderScheduler in reminderSchedulers)
                    {
                        var trackedUser = _uow.Context.Users.Local.FirstOrDefault(c => c.Id == reminderScheduler.User.Id);
                        if(trackedUser != null)
                        {
                            reminderScheduler.User = trackedUser;
                        }
                        else
                        {
                            _uow.Context.Attach(reminderScheduler.User);
                        }
                        _userNotificationRepository.AddUserNotificationByReminderScheduler(reminderScheduler);
                        if (reminderScheduler.IsEmailNotification && defaultSmtp != null)
                        {
                            try
                            {
                                await EmailHelper.SendEmail(new SendEmailSpecification
                                {
                                    Body = reminderScheduler.Message,
                                    FromAddress = defaultSmtp.UserName,
                                    Host = defaultSmtp.Host,
                                    IsEnableSSL = defaultSmtp.IsEnableSSL,
                                    Password = defaultSmtp.Password,
                                    Port = defaultSmtp.Port,
                                    Subject = reminderScheduler.Subject,
                                    ToAddress = reminderScheduler.User.Email,
                                    CCAddress = "",
                                    UserName = defaultSmtp.UserName,
                                    Attechments = new List<FileInfo>()
                                });
                            }
                            catch (Exception ex)
                            {
                                _logger.LogError(ex.Message, ex);
                            }
                        }
                        reminderScheduler.IsActive = false;
                    }
                    _reminderSchedulerRepository.UpdateRange(reminderSchedulers);
                    if (await _uow.SaveAsync() <= -1)
                    {
                        return false;
                    }
                    var userIds = reminderSchedulers.Select(c => c.UserId).Distinct().ToList();
                    await _userNotificationRepository.SendNotification(userIds);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message, ex);
            }
            return true;
        }
    }
}
