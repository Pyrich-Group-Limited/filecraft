using AutoMapper;
using DocumentManagement.Common.UnitOfWork;
using DocumentManagement.Data;
using DocumentManagement.Data.Dto;
using DocumentManagement.Data.Entities;
using DocumentManagement.Domain;
using DocumentManagement.MediatR.Commands;
using DocumentManagement.Repository;
using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace DocumentManagement.MediatR.Handlers
{
    public class AddDocumentUserPermissionCommandHandler
        : IRequestHandler<AddDocumentUserPermissionCommand, DocumentUserPermissionDto>
    {
        IDocumentUserPermissionRepository _documentUserPermissionRepository;
        private readonly IUserNotificationRepository _userNotificationRepository;
        private readonly IUnitOfWork<DocumentContext> _uow;
        private readonly IMapper _mapper;
        private readonly IDocumentAuditTrailRepository _documentAuditTrailRepository;
        private readonly UserInfoToken _userInfo;
        private readonly IUserRepository _userRepository;
        private readonly IDocumentRepository _documentRepository;
        private readonly ISendEmailRepository _sendEmailRepository;

        public AddDocumentUserPermissionCommandHandler(
            IDocumentUserPermissionRepository documentUserPermissionRepository,
            IUnitOfWork<DocumentContext> uow,
            IUserNotificationRepository userNotificationRepository,
            IMapper mapper,
               IDocumentAuditTrailRepository documentAuditTrailRepository,
            UserInfoToken userInfo,
            IUserRepository userRepository,
            IDocumentRepository documentRepository,
            ISendEmailRepository sendEmailRepository)
        {
            _documentUserPermissionRepository = documentUserPermissionRepository;
            _uow = uow;
            _mapper = mapper;
            _userNotificationRepository = userNotificationRepository;
            _documentAuditTrailRepository = documentAuditTrailRepository;
            _userInfo = userInfo;
            _userRepository = userRepository;
            _documentRepository = documentRepository;
            _sendEmailRepository = sendEmailRepository;
        }
        public async Task<DocumentUserPermissionDto> Handle(AddDocumentUserPermissionCommand request, CancellationToken cancellationToken)
        {
            var permissions = _mapper.Map<List<DocumentUserPermission>>(request.DocumentUserPermissions);
            var lstSendEmail = new List<SendEmail>();
            permissions.ForEach(permission =>
            {
                if (permission.IsTimeBound)
                {
                    permission.StartDate = permission.StartDate;
                    permission.EndDate = permission.EndDate.Value.AddDays(1).AddSeconds(-1);
                }
            });
            _documentUserPermissionRepository.AddRange(permissions);
            var userIds = request.DocumentUserPermissions.Select(c => c.UserId).ToList();
            var documentId = request.DocumentUserPermissions.FirstOrDefault().DocumentId;

            List<DocumentAuditTrail> lstDocumentAuditTrail = new List<DocumentAuditTrail>();
            foreach (var userId in userIds)
            {
                var documentAudit = new DocumentAuditTrail()
                {
                    DocumentId = documentId.Value,
                    CreatedBy = _userInfo.Id,
                    CreatedDate = DateTime.UtcNow,
                    OperationName = DocumentOperation.Add_Permission,
                    AssignToUserId = userId
                };
                lstDocumentAuditTrail.Add(documentAudit);
            }
            var documentInfo = await _documentRepository.FindAsync(documentId.Value);
            if (request.DocumentUserPermissions.Count(d => d.IsAllowEmailNotification == true) > 0)
            {
                var users = await _userRepository.GetUsersByIds(userIds);

                var currentUserInfo = await _userRepository.FindAsync(_userInfo.Id);
                foreach (var user in users)
                {
                    _sendEmailRepository.AddSharedEmails(new SendEmail
                    {
                        Email = user.Email,
                        FromEmail = currentUserInfo.Email,
                        FromName = currentUserInfo.FirstName + ' ' + currentUserInfo.LastName,
                        ToName = user.FirstName + ' ' + user.LastName,
                        CreatedBy = _userInfo.Id,
                        CreatedDate = DateTime.UtcNow,
                    }, documentInfo.Name);
                }
            }
            if (lstSendEmail.Count() > 0)
            {
                _sendEmailRepository.AddRange(lstSendEmail);
            }

            if (lstDocumentAuditTrail.Count() > 0)
            {
                _documentAuditTrailRepository.AddRange(lstDocumentAuditTrail);
            }
            _userNotificationRepository.CreateUsersDocumentNotifiction(userIds, documentInfo.Id);
            if (await _uow.SaveAsync() <= -1)
            {
                var errorDto = new DocumentUserPermissionDto
                {
                    StatusCode = 500,
                    Messages = new List<string> { "An unexpected fault happened. Try again later." }
                };
                return errorDto;
            }
            await _userNotificationRepository.SendNotification(userIds);

            return new DocumentUserPermissionDto();
        }
    }
}
