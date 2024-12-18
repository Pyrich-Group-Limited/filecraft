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
    public class DocumentPermissionUserRoleCommandHandler : IRequestHandler<DocumentPermissionUserRoleCommand, bool>
    {
        private readonly IDocumentRolePermissionRepository _documentRolePermissionRepository;
        private readonly IDocumentUserPermissionRepository _documentUserPermissionRepository;
        private readonly IUserNotificationRepository _userNotificationRepository;
        private readonly IUnitOfWork<DocumentContext> _uow;
        private readonly IMapper _mapper;
        private readonly IDocumentAuditTrailRepository _documentAuditTrailRepository;
        private readonly UserInfoToken _userInfo;
        private readonly IUserRepository _userRepository;
        private readonly IDocumentRepository _documentRepository;
        private readonly ISendEmailRepository _sendEmailRepository;

        public DocumentPermissionUserRoleCommandHandler(
            IDocumentRolePermissionRepository documentRolePermissionRepository,
            IUnitOfWork<DocumentContext> uow,
            IUserNotificationRepository userNotificationRepository,
            IMapper mapper,
            IDocumentAuditTrailRepository documentAuditTrailRepository,
            UserInfoToken userInfo,
            IDocumentUserPermissionRepository documentUserPermissionRepository,
            IUserRepository userRepository,
            IDocumentRepository documentRepository,
            ISendEmailRepository sendEmailRepository)
        {
            _documentRolePermissionRepository = documentRolePermissionRepository;
            _uow = uow;
            _mapper = mapper;
            _userNotificationRepository = userNotificationRepository;
            _documentAuditTrailRepository = documentAuditTrailRepository;
            _documentUserPermissionRepository = documentUserPermissionRepository;
            _userInfo = userInfo;
            _userRepository = userRepository;
            _documentRepository = documentRepository;
            _sendEmailRepository = sendEmailRepository;
        }

        public async Task<bool> Handle(DocumentPermissionUserRoleCommand request, CancellationToken cancellationToken)
        {
            List<DocumentAuditTrail> lstDocumentAuditTrail = new List<DocumentAuditTrail>();
            List<SendEmail> lstSendEmail = new List<SendEmail>();

            List<Guid> userIds = new List<Guid>();
            var currentUserInfo = _userRepository.Find(_userInfo.Id);

            if (request.Roles != null && request.Roles.Count() > 0)
            {
                List<DocumentRolePermission> lstDocumentRolePermission = new List<DocumentRolePermission>();

                foreach (var document in request.Documents)
                {
                    foreach (var role in request.Roles)
                    {

                        lstDocumentRolePermission.Add(new DocumentRolePermission
                        {
                            DocumentId = Guid.Parse(document),
                            RoleId = Guid.Parse(role),
                            StartDate = request.StartDate,
                            EndDate = request.IsTimeBound ? request.EndDate.Value.AddDays(1).AddSeconds(-1) : request.EndDate,
                            IsTimeBound = request.IsTimeBound,
                            IsAllowDownload = request.IsAllowDownload,
                            CreatedBy = _userInfo.Id,
                            CreatedDate = DateTime.UtcNow
                        });

                        lstDocumentAuditTrail.Add(new DocumentAuditTrail()
                        {
                            DocumentId = Guid.Parse(document),
                            CreatedBy = _userInfo.Id,
                            CreatedDate = DateTime.UtcNow,
                            OperationName = DocumentOperation.Add_Permission,
                            AssignToRoleId = Guid.Parse(role)
                        });
                    }
                    List<Guid> roles = request.Roles.Select(c => Guid.Parse(c)).ToList();
                    var documentInfo = await _documentRepository.FindAsync(Guid.Parse(document));
                    var users = await _userNotificationRepository.CreateRolesDocumentNotifiction(roles, documentInfo.Id);
                    userIds.AddRange(users.Select(d => d.Id));
                    if (request.IsAllowEmailNotification && users.Count() > 0)
                    {


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
                }
                _documentRolePermissionRepository.AddRange(lstDocumentRolePermission);
            }

            if (request.Users != null && request.Users.Count() > 0)
            {
                List<DocumentUserPermission> lstDocumentUserPermission = new List<DocumentUserPermission>();

                foreach (var document in request.Documents)
                {
                    foreach (var user in request.Users)
                    {

                        lstDocumentUserPermission.Add(new DocumentUserPermission
                        {
                            DocumentId = Guid.Parse(document),
                            UserId = Guid.Parse(user),
                            StartDate = request.StartDate,
                            EndDate = request.IsTimeBound ? request.EndDate.Value.AddDays(1).AddSeconds(-1) : request.EndDate,
                            IsTimeBound = request.IsTimeBound,
                            IsAllowDownload = request.IsAllowDownload,
                            CreatedBy = _userInfo.Id,
                            CreatedDate = DateTime.UtcNow
                        });

                        lstDocumentAuditTrail.Add(new DocumentAuditTrail()
                        {
                            DocumentId = Guid.Parse(document),
                            CreatedBy = _userInfo.Id,
                            CreatedDate = DateTime.UtcNow,
                            OperationName = DocumentOperation.Add_Permission,
                            AssignToUserId = Guid.Parse(user)
                        });

                    }
                    var filterUsers = request.Users.Where(c => !userIds.Contains(Guid.Parse(c))).ToList();
                    var documentInfo = await _documentRepository.FindAsync(Guid.Parse(document));
                    if (request.IsAllowEmailNotification && filterUsers.Count() > 0)
                    {
                        var users = await _userRepository.GetUsersByIds(filterUsers.Select(c => Guid.Parse(c)).ToList());
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

                    var tempUserIds = request.Users.Select(c => Guid.Parse(c)).ToList();
                    _userNotificationRepository.CreateUsersDocumentNotifiction(tempUserIds, documentInfo.Id);
                    userIds.AddRange(tempUserIds);
                }
                _documentUserPermissionRepository.AddRange(lstDocumentUserPermission);
            }
            if (lstSendEmail.Count() > 0)
            {
                _sendEmailRepository.AddRange(lstSendEmail);
            }

            if (lstDocumentAuditTrail.Count() > 0)
            {
                _documentAuditTrailRepository.AddRange(lstDocumentAuditTrail);
            }

            if (await _uow.SaveAsync() <= -1)
            {
                var errorDto = new DocumentRolePermissionDto
                {
                    StatusCode = 500,
                    Messages = new List<string> { "An unexpected fault happened. Try again later." }
                };
                return false;
            }

            await _userNotificationRepository.SendNotification(userIds);

            return true;
        }
    }
}
