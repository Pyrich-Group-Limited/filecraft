using DocumentManagement.Data;
using DocumentManagement.Data.Entities;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using System;


namespace DocumentManagement.Domain
{
    public class DocumentContext : IdentityDbContext<User, Role, Guid, UserClaim, UserRole, UserLogin, RoleClaim, UserToken>
    {
        public DocumentContext(DbContextOptions options) : base(options)
        {
        }
        public override DbSet<User> Users { get; set; }
        public override DbSet<Role> Roles { get; set; }
        public override DbSet<UserClaim> UserClaims { get; set; }
        public override DbSet<UserRole> UserRoles { get; set; }
        public override DbSet<UserLogin> UserLogins { get; set; }
        public override DbSet<RoleClaim> RoleClaims { get; set; }
        public override DbSet<UserToken> UserTokens { get; set; }
        public DbSet<Operation> Operations { get; set; }
        public DbSet<Screen> Screens { get; set; }
        public DbSet<ScreenOperation> ScreenOperations { get; set; }
        public DbSet<NLog> NLog { get; set; }
        public DbSet<Document> Documents { get; set; }
        public DbSet<Category> Categories { get; set; }
        public virtual DbSet<DocumentRolePermission> DocumentRolePermissions { get; set; }
        public virtual DbSet<DocumentUserPermission> DocumentUserPermissions { get; set; }
        public DbSet<DocumentAuditTrail> DocumentAuditTrails { get; set; }
        public DbSet<UserNotification> UserNotifications { get; set; }
        public DbSet<LoginAudit> LoginAudits { get; set; }
        public DbSet<DocumentToken> DocumentTokens { get; set; }
        public DbSet<Reminder> Reminders { get; set; }
        public DbSet<ReminderNotification> ReminderNotifications { get; set; }
        public DbSet<ReminderUser> ReminderUsers { get; set; }
        public DbSet<ReminderScheduler> ReminderSchedulers { get; set; }
        public DbSet<HalfYearlyReminder> HalfYearlyReminders { get; set; }
        public DbSet<QuarterlyReminder> QuarterlyReminders { get; set; }
        public DbSet<DailyReminder> DailyReminders { get; set; }
        public DbSet<EmailSMTPSetting> EmailSMTPSettings { get; set; }
        public DbSet<SendEmail> SendEmails { get; set; }

        public DbSet<DocumentComment> DocumentComments { get; set; }
        public DbSet<DocumentVersion> DocumentVersions { get; set; }
        public DbSet<DocumentMetaData> DocumentMetaDatas { get; set; }
        public DbSet<DocumentShareableLink> DocumentShareableLinks { get; set; }
        public DbSet<StorageSetting> StorageSettings { get; set; }
        public DbSet<DocumentStatus> DocumentStatuses { get; set; }
        public DbSet<CompanyProfile> CompanyProfiles { get; set; }
        public DbSet<PageHelper> PageHelpers { get; set; }
        public DbSet<DocumentIndex> DocumentIndexes { get; set; }

        //protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        //{
        //    optionsBuilder.AddInterceptors(new TaggedQueryCommandInterceptor());
        //}

        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);
            builder.Entity<Document>(entity =>
            {
                if (Database.IsSqlServer()) // For SQL Server
                {
                    entity.Property(e => e.IV).HasColumnType("VARBINARY(MAX)").IsRequired(false);
                    entity.Property(e => e.Key).HasColumnType("VARBINARY(MAX)").IsRequired(false);


                }
                else //For MySQL
                {
                    entity.Property(e => e.IV).HasColumnType("LONGBLOB").IsRequired(false);  // or BLOB
                    entity.Property(e => e.Key).HasColumnType("LONGBLOB").IsRequired(false);
                }
            });

            builder.Entity<DocumentVersion>(entity =>
            {
                if (Database.IsSqlServer()) // For SQL Server
                {
                    entity.Property(e => e.IV).HasColumnType("VARBINARY(MAX)").IsRequired(false);
                    entity.Property(e => e.Key).HasColumnType("VARBINARY(MAX)").IsRequired(false);
                }
                else //For MySQL
                {
                    entity.Property(e => e.IV).HasColumnType("LONGBLOB").IsRequired(false);  // or BLOB
                    entity.Property(e => e.Key).HasColumnType("LONGBLOB").IsRequired(false);
                }
            });


            builder.Entity<Category>(entity =>
            {
                entity.HasOne(x => x.Parent)
                    .WithMany(x => x.Children)
                    .HasForeignKey(x => x.ParentId)
                    .IsRequired(false)
                    .OnDelete(DeleteBehavior.Restrict);
            });

            builder.Entity<User>(b =>
            {
                // Each User can have many UserClaims
                b.HasMany(e => e.UserClaims)
                    .WithOne(e => e.User)
                    .HasForeignKey(uc => uc.UserId)
                    .IsRequired();

                // Each User can have many UserLogins
                b.HasMany(e => e.UserLogins)
                    .WithOne(e => e.User)
                    .HasForeignKey(ul => ul.UserId)
                    .IsRequired();

                // Each User can have many UserTokens
                b.HasMany(e => e.UserTokens)
                    .WithOne(e => e.User)
                    .HasForeignKey(ut => ut.UserId)
                    .IsRequired();

                // Each User can have many entries in the UserRole join table
                b.HasMany(e => e.UserRoles)
                    .WithOne(e => e.User)
                    .HasForeignKey(ur => ur.UserId)
                    .IsRequired();
            });

            builder.Entity<Role>(b =>
            {
                // Each Role can have many entries in the UserRole join table
                b.HasMany(e => e.UserRoles)
                    .WithOne(e => e.Role)
                    .HasForeignKey(ur => ur.RoleId)
                    .IsRequired();

                // Each Role can have many associated RoleClaims
                b.HasMany(e => e.RoleClaims)
                    .WithOne(e => e.Role)
                    .HasForeignKey(rc => rc.RoleId)
                    .IsRequired();
            });

            builder.Entity<DocumentRolePermission>(entity =>
            {
                entity.HasOne(d => d.Document)
                    .WithMany(p => p.DocumentRolePermissions)
                    .HasForeignKey(d => d.DocumentId)
                    .OnDelete(DeleteBehavior.ClientSetNull);

                entity.HasOne(d => d.Role)
                    .WithMany(p => p.DocumentRolePermissions)
                    .HasForeignKey(d => d.RoleId)
                    .OnDelete(DeleteBehavior.ClientSetNull);
            });

            builder.Entity<DocumentUserPermission>(entity =>
            {

                entity.HasOne(d => d.Document)
                    .WithMany(p => p.DocumentUserPermissions)
                    .HasForeignKey(d => d.DocumentId)
                    .OnDelete(DeleteBehavior.ClientSetNull);

                entity.HasOne(d => d.User)
                    .WithMany(p => p.DocumentUserPermissions)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull);
            });

            builder.Entity<DocumentAuditTrail>(entity =>
            {
                entity.HasOne(d => d.Document)
                  .WithMany(p => p.DocumentAuditTrails)
                  .HasForeignKey(d => d.DocumentId)
                  .OnDelete(DeleteBehavior.ClientSetNull);
            });
            builder.Entity<UserNotification>(entity =>
            {
                entity.HasOne(d => d.User)
                    .WithMany(p => p.UserNotifications)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.NoAction);

                entity.HasOne(d => d.Document)
                    .WithMany(p => p.UserNotifications)
                    .HasForeignKey(d => d.DocumentId)
                    .OnDelete(DeleteBehavior.ClientSetNull);
            });

            builder.Entity<ReminderUser>(b =>
            {
                b.HasKey(e => new { e.ReminderId, e.UserId });
                b.HasOne(e => e.User)
                  .WithMany()
                  .HasForeignKey(ur => ur.UserId)
                  .OnDelete(DeleteBehavior.NoAction);
            });

            builder.Entity<Document>()
             .HasQueryFilter(p => !p.IsDeleted)
             .HasIndex(b => b.Url);

            builder.Entity<DocumentComment>(b =>
            {
                b.HasOne(e => e.CreatedByUser)
                    .WithMany()
                    .HasForeignKey(ur => ur.CreatedBy)
                    .OnDelete(DeleteBehavior.Restrict);
            });

            builder.Entity<DocumentVersion>(b =>
            {
                b.HasOne(e => e.CreatedByUser)
                    .WithMany()
                    .HasForeignKey(ur => ur.CreatedBy)
                    .OnDelete(DeleteBehavior.Restrict);
            });

            //builder.Entity<Document>(entity =>
            //{
            //    entity.Property(x => x.StorageType).HasDefaultValue(StorageType.LOCAL_STORAGE);
            //});

            builder.Entity<DocumentUserPermission>().HasQueryFilter(p => !p.IsDeleted);
            builder.Entity<DocumentRolePermission>().HasQueryFilter(p => !p.IsDeleted);
            builder.Entity<User>().ToTable("Users");
            builder.Entity<Role>().ToTable("Roles");
            builder.Entity<RoleClaim>().ToTable("RoleClaims");
            builder.Entity<UserClaim>().ToTable("UserClaims");
            builder.Entity<UserLogin>().ToTable("UserLogins");
            builder.Entity<UserRole>().ToTable("UserRoles");
            builder.Entity<UserToken>().ToTable("UserTokens");
            builder.Entity<DocumentUserPermission>().ToTable("DocumentUserPermissions");
            builder.Entity<DocumentRolePermission>().ToTable("DocumentRolePermissions");
            builder.Entity<UserNotification>().ToTable("UserNotifications");
            builder.DefalutMappingValue();
            builder.DefalutDeleteValueFilter();
        }
    }
}
