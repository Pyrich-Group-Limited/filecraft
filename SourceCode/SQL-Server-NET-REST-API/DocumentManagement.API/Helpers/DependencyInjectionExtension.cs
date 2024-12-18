using Amazon.S3;
using DocumentManagement.Common.UnitOfWork;
using DocumentManagement.MediatR.Handlers.StorageStategies;
using DocumentManagement.Repository;
using Microsoft.Extensions.DependencyInjection;

namespace DocumentManagement.Api.Helpers
{
    public static class DependencyInjectionExtension
    {
        public static void AddDependencyInjection(this IServiceCollection services)
        {
            services.AddScoped(typeof(IUnitOfWork<>), typeof(UnitOfWork<>));
            services.AddScoped<IPropertyMappingService, PropertyMappingService>();
            services.AddScoped<IScreenRepository, ScreenRepository>();
            services.AddScoped<IOperationRepository, OperationRepository>();
            services.AddScoped<IRoleRepository, RoleRepository>();
            services.AddScoped<IUserRepository, UserRepository>();
            services.AddScoped<IUserRoleRepository, UserRoleRepository>();
            services.AddScoped<IUserClaimRepository, UserClaimRepository>();
            services.AddScoped<IRoleClaimRepository, RoleClaimRepository>();
            services.AddScoped<IScreenOperationRepository, ScreenOperationRepository>();
            services.AddScoped<IDocumentRepository, DocumentRepository>();
            services.AddScoped<ICategoryRepository, CategoryRepository>();
            services.AddScoped<IDocumentShareableLinkRepository, DocumentShareableLinkRepository>();
            services.AddScoped<IDocumentRolePermissionRepository, DocumentRolePermissionRepository>();
            services.AddScoped<IDocumentUserPermissionRepository, DocumentUserPermissionRepository>();
            services.AddScoped<IDocumentAuditTrailRepository, DocumentAuditTrailRepository>();
            services.AddScoped<IUserNotificationRepository, UserNotificationRepository>();
            services.AddScoped<ILoginAuditRepository, LoginAuditRepository>();

            // Reminder
            services.AddScoped<IReminderNotificationRepository, ReminderNotificationRepository>();
            services.AddScoped<IReminderRepository, ReminderRepository>();
            services.AddScoped<IReminderUserRepository, ReminderUserRepository>();
            services.AddScoped<IReminderSchedulerRepository, ReminderSchedulerRepository>();
            services.AddScoped<IDailyReminderRepository, DailyReminderRepository>();
            services.AddScoped<IQuarterlyReminderRepository, QuarterlyReminderRepository>();
            services.AddScoped<IHalfYearlyReminderRepository, HalfYearlyReminderRepository>();
            services.AddScoped<IDocumentTokenRepository, DocumentTokenRepository>();
            services.AddScoped<IEmailSMTPSettingRepository, EmailSMTPSettingRepository>();
            services.AddScoped<ISendEmailRepository, SendEmailRepository>();
            services.AddSingleton<IConnectionMappingRepository, ConnectionMappingRepository>();

            services.AddScoped<IDocumentCommentRepository, DocumentCommentRepository>();

            services.AddScoped<IDocumentVersionRepository, DocumentVersionRepository>();
            services.AddScoped<IDocumentMetaDataRepository, DocumentMetaDataRepository>();

            services.AddScoped<IStorageSettingRepository, StorageSettingRepository>();
            services.AddScoped<IDocumentStatusRepository, DocumentStatusRepository>();
            services.AddScoped<ICompanyProfileRepository, CompanyProfileRepository>();

            //Store stategies dependancies

            services.AddScoped<LocalStorageService>();
            services.AddScoped<AwsS3StorageService>();
            services.AddScoped<CloudflareR2StorageService>();
            services.AddScoped<StorageServiceFactory>();

            services.AddScoped<INLogRepository, NLogRepository>();
            services.AddScoped<IPageHelperRepository, PageHelperRepository>();
            services.AddScoped<IDocumentIndexRepository, DocumentIndexRepository>();

            // Add AWS S3 configuration
            services.AddAWSService<IAmazonS3>();

        }
    }
}
