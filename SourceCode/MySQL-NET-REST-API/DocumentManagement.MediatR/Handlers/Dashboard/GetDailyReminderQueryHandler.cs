﻿using DocumentManagement.Data;
using DocumentManagement.Data.Dto;
using DocumentManagement.MediatR.Queries;
using DocumentManagement.Repository;
using MediatR;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace DocumentManagement.MediatR.Handlers
{
    public class GetDailyReminderQueryHandler
        : IRequestHandler<GetDailyReminderQuery, List<CalenderReminderDto>>
    {
        private readonly IReminderRepository _reminderRepository;
        private readonly UserInfoToken _userInfo;

        public GetDailyReminderQueryHandler(IReminderRepository reminderRepository, UserInfoToken userInfo)
        {
            _reminderRepository = reminderRepository;
            _userInfo = userInfo;
        }
        public async Task<List<CalenderReminderDto>> Handle(GetDailyReminderQuery request, CancellationToken cancellationToken)
        {
            var result = new List<CalenderReminderDto>();
            var startDate = new DateTime(request.Year, request.Month, 1, 0, 0, 1);
            var monthEndDate = startDate.AddMonths(1).AddDays(-1);
            var endDate = new DateTime(monthEndDate.Year, monthEndDate.Month, monthEndDate.Day, 23, 59, 59);
            var reminders = await _reminderRepository.All
                 .Include(c => c.ReminderUsers)
                 .Include(c => c.DailyReminders)
                 .Where(c => c.Frequency == Frequency.Daily
                    && c.StartDate <= endDate && (!c.EndDate.HasValue || c.EndDate >= startDate)
                    && (c.CreatedBy == _userInfo.Id || c.ReminderUsers.Any(c => c.UserId == _userInfo.Id)))
                 .ToListAsync();

            reminders.ForEach(re =>
            {
                var reminderStartDate = startDate <= re.StartDate ? re.StartDate : startDate;
                var reminderEndDate = re.EndDate.HasValue && endDate >= re.EndDate ? re.EndDate.Value : endDate;
                var dailyReminders = Enumerable.Range(0, 1 + reminderEndDate.Subtract(reminderStartDate).Days)
                    .Where(d => re.DailyReminders.Any(dr => dr.IsActive && dr.DayOfWeek == reminderStartDate.AddDays(d).DayOfWeek))
                 .Select(offset => reminderStartDate.AddDays(offset))
                 .ToList();
                result.AddRange(dailyReminders.Select(d => new CalenderReminderDto
                {
                    RemiderId = re.Id,
                    Start = d,
                    End = d,
                    Title = re.Subject
                }));
            });
            return result;
        }
    }
}
