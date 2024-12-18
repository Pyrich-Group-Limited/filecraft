CREATE TABLE IF NOT EXISTS `__EFMigrationsHistory` (
    `MigrationId` varchar(150) CHARACTER SET utf8mb4 NOT NULL,
    `ProductVersion` varchar(32) CHARACTER SET utf8mb4 NOT NULL,
    CONSTRAINT `PK___EFMigrationsHistory` PRIMARY KEY (`MigrationId`)
) CHARACTER SET=utf8mb4;

START TRANSACTION;

ALTER DATABASE CHARACTER SET utf8mb4;

CREATE TABLE `Categories` (
    `Id` char(36) COLLATE ascii_general_ci NOT NULL,
    `Name` longtext CHARACTER SET utf8mb4 NULL,
    `Description` longtext CHARACTER SET utf8mb4 NULL,
    `ParentId` char(36) COLLATE ascii_general_ci NULL,
    `CreatedDate` datetime NOT NULL,
    `CreatedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `ModifiedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `ModifiedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `DeletedDate` datetime NULL,
    `DeletedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `IsDeleted` tinyint(1) NOT NULL,
    CONSTRAINT `PK_Categories` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_Categories_Categories_ParentId` FOREIGN KEY (`ParentId`) REFERENCES `Categories` (`Id`) ON DELETE RESTRICT
) CHARACTER SET=utf8mb4;

CREATE TABLE `DocumentTokens` (
    `Id` char(36) COLLATE ascii_general_ci NOT NULL,
    `DocumentId` char(36) COLLATE ascii_general_ci NOT NULL,
    `Token` char(36) COLLATE ascii_general_ci NOT NULL,
    `CreatedDate` datetime NOT NULL,
    CONSTRAINT `PK_DocumentTokens` PRIMARY KEY (`Id`)
) CHARACTER SET=utf8mb4;

CREATE TABLE `EmailSMTPSettings` (
    `Id` char(36) COLLATE ascii_general_ci NOT NULL,
    `Host` longtext CHARACTER SET utf8mb4 NOT NULL,
    `UserName` longtext CHARACTER SET utf8mb4 NOT NULL,
    `Password` longtext CHARACTER SET utf8mb4 NOT NULL,
    `IsEnableSSL` tinyint(1) NOT NULL,
    `Port` int NOT NULL,
    `IsDefault` tinyint(1) NOT NULL,
    `CreatedDate` datetime NOT NULL,
    `CreatedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `ModifiedDate` datetime NOT NULL,
    `ModifiedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `DeletedDate` datetime NULL,
    `DeletedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `IsDeleted` tinyint(1) NOT NULL,
    CONSTRAINT `PK_EmailSMTPSettings` PRIMARY KEY (`Id`)
) CHARACTER SET=utf8mb4;

CREATE TABLE `LoginAudits` (
    `Id` char(36) COLLATE ascii_general_ci NOT NULL,
    `UserName` longtext CHARACTER SET utf8mb4 NULL,
    `LoginTime` datetime NOT NULL,
    `RemoteIP` varchar(50) CHARACTER SET utf8mb4 NULL,
    `Status` longtext CHARACTER SET utf8mb4 NULL,
    `Provider` longtext CHARACTER SET utf8mb4 NULL,
    `Latitude` varchar(50) CHARACTER SET utf8mb4 NULL,
    `Longitude` varchar(50) CHARACTER SET utf8mb4 NULL,
    CONSTRAINT `PK_LoginAudits` PRIMARY KEY (`Id`)
) CHARACTER SET=utf8mb4;

CREATE TABLE `NLog` (
    `Id` char(36) COLLATE ascii_general_ci NOT NULL,
    `MachineName` longtext CHARACTER SET utf8mb4 NULL,
    `Logged` longtext CHARACTER SET utf8mb4 NULL,
    `Level` longtext CHARACTER SET utf8mb4 NULL,
    `Message` longtext CHARACTER SET utf8mb4 NULL,
    `Logger` longtext CHARACTER SET utf8mb4 NULL,
    `Properties` longtext CHARACTER SET utf8mb4 NULL,
    `Callsite` longtext CHARACTER SET utf8mb4 NULL,
    `Exception` longtext CHARACTER SET utf8mb4 NULL,
    CONSTRAINT `PK_NLog` PRIMARY KEY (`Id`)
) CHARACTER SET=utf8mb4;

CREATE TABLE `Operations` (
    `Id` char(36) COLLATE ascii_general_ci NOT NULL,
    `Name` longtext CHARACTER SET utf8mb4 NULL,
    `CreatedDate` datetime NOT NULL,
    `CreatedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `ModifiedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `ModifiedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `DeletedDate` datetime NULL,
    `DeletedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `IsDeleted` tinyint(1) NOT NULL,
    CONSTRAINT `PK_Operations` PRIMARY KEY (`Id`)
) CHARACTER SET=utf8mb4;

CREATE TABLE `Roles` (
    `Id` char(36) COLLATE ascii_general_ci NOT NULL,
    `IsDeleted` tinyint(1) NOT NULL,
    `Name` varchar(256) CHARACTER SET utf8mb4 NULL,
    `NormalizedName` varchar(256) CHARACTER SET utf8mb4 NULL,
    `ConcurrencyStamp` longtext CHARACTER SET utf8mb4 NULL,
    CONSTRAINT `PK_Roles` PRIMARY KEY (`Id`)
) CHARACTER SET=utf8mb4;

CREATE TABLE `Screens` (
    `Id` char(36) COLLATE ascii_general_ci NOT NULL,
    `Name` longtext CHARACTER SET utf8mb4 NULL,
    `CreatedDate` datetime NOT NULL,
    `CreatedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `ModifiedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `ModifiedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `DeletedDate` datetime NULL,
    `DeletedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `IsDeleted` tinyint(1) NOT NULL,
    CONSTRAINT `PK_Screens` PRIMARY KEY (`Id`)
) CHARACTER SET=utf8mb4;

CREATE TABLE `Users` (
    `Id` char(36) COLLATE ascii_general_ci NOT NULL,
    `FirstName` longtext CHARACTER SET utf8mb4 NULL,
    `LastName` longtext CHARACTER SET utf8mb4 NULL,
    `IsDeleted` tinyint(1) NOT NULL,
    `UserName` varchar(256) CHARACTER SET utf8mb4 NULL,
    `NormalizedUserName` varchar(256) CHARACTER SET utf8mb4 NULL,
    `Email` varchar(256) CHARACTER SET utf8mb4 NULL,
    `NormalizedEmail` varchar(256) CHARACTER SET utf8mb4 NULL,
    `EmailConfirmed` tinyint(1) NOT NULL,
    `PasswordHash` longtext CHARACTER SET utf8mb4 NULL,
    `SecurityStamp` longtext CHARACTER SET utf8mb4 NULL,
    `ConcurrencyStamp` longtext CHARACTER SET utf8mb4 NULL,
    `PhoneNumber` longtext CHARACTER SET utf8mb4 NULL,
    `PhoneNumberConfirmed` tinyint(1) NOT NULL,
    `TwoFactorEnabled` tinyint(1) NOT NULL,
    `LockoutEnd` datetime(6) NULL,
    `LockoutEnabled` tinyint(1) NOT NULL,
    `AccessFailedCount` int NOT NULL,
    CONSTRAINT `PK_Users` PRIMARY KEY (`Id`)
) CHARACTER SET=utf8mb4;

CREATE TABLE `RoleClaims` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `OperationId` char(36) COLLATE ascii_general_ci NOT NULL,
    `ScreenId` char(36) COLLATE ascii_general_ci NOT NULL,
    `RoleId` char(36) COLLATE ascii_general_ci NOT NULL,
    `ClaimType` longtext CHARACTER SET utf8mb4 NULL,
    `ClaimValue` longtext CHARACTER SET utf8mb4 NULL,
    CONSTRAINT `PK_RoleClaims` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_RoleClaims_Operations_OperationId` FOREIGN KEY (`OperationId`) REFERENCES `Operations` (`Id`) ON DELETE CASCADE,
    CONSTRAINT `FK_RoleClaims_Roles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `Roles` (`Id`) ON DELETE CASCADE,
    CONSTRAINT `FK_RoleClaims_Screens_ScreenId` FOREIGN KEY (`ScreenId`) REFERENCES `Screens` (`Id`) ON DELETE CASCADE
) CHARACTER SET=utf8mb4;

CREATE TABLE `ScreenOperations` (
    `Id` char(36) COLLATE ascii_general_ci NOT NULL,
    `OperationId` char(36) COLLATE ascii_general_ci NOT NULL,
    `ScreenId` char(36) COLLATE ascii_general_ci NOT NULL,
    `CreatedDate` datetime NOT NULL,
    `CreatedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `ModifiedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `ModifiedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `DeletedDate` datetime NULL,
    `DeletedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `IsDeleted` tinyint(1) NOT NULL,
    CONSTRAINT `PK_ScreenOperations` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ScreenOperations_Operations_OperationId` FOREIGN KEY (`OperationId`) REFERENCES `Operations` (`Id`) ON DELETE CASCADE,
    CONSTRAINT `FK_ScreenOperations_Screens_ScreenId` FOREIGN KEY (`ScreenId`) REFERENCES `Screens` (`Id`) ON DELETE CASCADE
) CHARACTER SET=utf8mb4;

CREATE TABLE `Documents` (
    `Id` char(36) COLLATE ascii_general_ci NOT NULL,
    `CategoryId` char(36) COLLATE ascii_general_ci NOT NULL,
    `Name` longtext CHARACTER SET utf8mb4 NULL,
    `Description` longtext CHARACTER SET utf8mb4 NULL,
    `Url` varchar(255) CHARACTER SET utf8mb4 NULL,
    `CreatedDate` datetime NOT NULL,
    `CreatedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `ModifiedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `ModifiedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `DeletedDate` datetime NULL,
    `DeletedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `IsDeleted` tinyint(1) NOT NULL,
    CONSTRAINT `PK_Documents` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_Documents_Categories_CategoryId` FOREIGN KEY (`CategoryId`) REFERENCES `Categories` (`Id`) ON DELETE CASCADE,
    CONSTRAINT `FK_Documents_Users_CreatedBy` FOREIGN KEY (`CreatedBy`) REFERENCES `Users` (`Id`) ON DELETE CASCADE
) CHARACTER SET=utf8mb4;

CREATE TABLE `UserClaims` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `OperationId` char(36) COLLATE ascii_general_ci NOT NULL,
    `ScreenId` char(36) COLLATE ascii_general_ci NOT NULL,
    `UserId` char(36) COLLATE ascii_general_ci NOT NULL,
    `ClaimType` longtext CHARACTER SET utf8mb4 NULL,
    `ClaimValue` longtext CHARACTER SET utf8mb4 NULL,
    CONSTRAINT `PK_UserClaims` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_UserClaims_Operations_OperationId` FOREIGN KEY (`OperationId`) REFERENCES `Operations` (`Id`) ON DELETE CASCADE,
    CONSTRAINT `FK_UserClaims_Screens_ScreenId` FOREIGN KEY (`ScreenId`) REFERENCES `Screens` (`Id`) ON DELETE CASCADE,
    CONSTRAINT `FK_UserClaims_Users_UserId` FOREIGN KEY (`UserId`) REFERENCES `Users` (`Id`) ON DELETE CASCADE
) CHARACTER SET=utf8mb4;

CREATE TABLE `UserLogins` (
    `LoginProvider` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
    `ProviderKey` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
    `ProviderDisplayName` longtext CHARACTER SET utf8mb4 NULL,
    `UserId` char(36) COLLATE ascii_general_ci NOT NULL,
    CONSTRAINT `PK_UserLogins` PRIMARY KEY (`LoginProvider`, `ProviderKey`),
    CONSTRAINT `FK_UserLogins_Users_UserId` FOREIGN KEY (`UserId`) REFERENCES `Users` (`Id`) ON DELETE CASCADE
) CHARACTER SET=utf8mb4;

CREATE TABLE `UserRoles` (
    `UserId` char(36) COLLATE ascii_general_ci NOT NULL,
    `RoleId` char(36) COLLATE ascii_general_ci NOT NULL,
    CONSTRAINT `PK_UserRoles` PRIMARY KEY (`UserId`, `RoleId`),
    CONSTRAINT `FK_UserRoles_Roles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `Roles` (`Id`) ON DELETE CASCADE,
    CONSTRAINT `FK_UserRoles_Users_UserId` FOREIGN KEY (`UserId`) REFERENCES `Users` (`Id`) ON DELETE CASCADE
) CHARACTER SET=utf8mb4;

CREATE TABLE `UserTokens` (
    `UserId` char(36) COLLATE ascii_general_ci NOT NULL,
    `LoginProvider` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
    `Name` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
    `Value` longtext CHARACTER SET utf8mb4 NULL,
    CONSTRAINT `PK_UserTokens` PRIMARY KEY (`UserId`, `LoginProvider`, `Name`),
    CONSTRAINT `FK_UserTokens_Users_UserId` FOREIGN KEY (`UserId`) REFERENCES `Users` (`Id`) ON DELETE CASCADE
) CHARACTER SET=utf8mb4;

CREATE TABLE `DocumentAuditTrails` (
    `Id` char(36) COLLATE ascii_general_ci NOT NULL,
    `DocumentId` char(36) COLLATE ascii_general_ci NOT NULL,
    `OperationName` int NOT NULL,
    `AssignToUserId` char(36) COLLATE ascii_general_ci NULL,
    `AssignToRoleId` char(36) COLLATE ascii_general_ci NULL,
    `CreatedDate` datetime NOT NULL,
    `CreatedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `ModifiedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `ModifiedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `DeletedDate` datetime NULL,
    `DeletedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `IsDeleted` tinyint(1) NOT NULL,
    CONSTRAINT `PK_DocumentAuditTrails` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_DocumentAuditTrails_Documents_DocumentId` FOREIGN KEY (`DocumentId`) REFERENCES `Documents` (`Id`) ON DELETE RESTRICT,
    CONSTRAINT `FK_DocumentAuditTrails_Roles_AssignToRoleId` FOREIGN KEY (`AssignToRoleId`) REFERENCES `Roles` (`Id`) ON DELETE RESTRICT,
    CONSTRAINT `FK_DocumentAuditTrails_Users_AssignToUserId` FOREIGN KEY (`AssignToUserId`) REFERENCES `Users` (`Id`) ON DELETE RESTRICT,
    CONSTRAINT `FK_DocumentAuditTrails_Users_CreatedBy` FOREIGN KEY (`CreatedBy`) REFERENCES `Users` (`Id`) ON DELETE CASCADE
) CHARACTER SET=utf8mb4;

CREATE TABLE `DocumentRolePermissions` (
    `Id` char(36) COLLATE ascii_general_ci NOT NULL,
    `DocumentId` char(36) COLLATE ascii_general_ci NOT NULL,
    `RoleId` char(36) COLLATE ascii_general_ci NOT NULL,
    `StartDate` datetime(6) NULL,
    `EndDate` datetime(6) NULL,
    `IsTimeBound` tinyint(1) NOT NULL,
    `IsAllowDownload` tinyint(1) NOT NULL,
    `CreatedDate` datetime NOT NULL,
    `CreatedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `ModifiedDate` datetime NOT NULL,
    `ModifiedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `DeletedDate` datetime NULL,
    `DeletedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `IsDeleted` tinyint(1) NOT NULL,
    CONSTRAINT `PK_DocumentRolePermissions` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_DocumentRolePermissions_Documents_DocumentId` FOREIGN KEY (`DocumentId`) REFERENCES `Documents` (`Id`) ON DELETE RESTRICT,
    CONSTRAINT `FK_DocumentRolePermissions_Roles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `Roles` (`Id`) ON DELETE RESTRICT,
    CONSTRAINT `FK_DocumentRolePermissions_Users_CreatedBy` FOREIGN KEY (`CreatedBy`) REFERENCES `Users` (`Id`) ON DELETE CASCADE
) CHARACTER SET=utf8mb4;

CREATE TABLE `DocumentUserPermissions` (
    `Id` char(36) COLLATE ascii_general_ci NOT NULL,
    `DocumentId` char(36) COLLATE ascii_general_ci NOT NULL,
    `UserId` char(36) COLLATE ascii_general_ci NOT NULL,
    `StartDate` datetime NULL,
    `EndDate` datetime NULL,
    `IsTimeBound` tinyint(1) NOT NULL,
    `IsAllowDownload` tinyint(1) NOT NULL,
    `CreatedDate` datetime NOT NULL,
    `CreatedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `ModifiedDate` datetime NOT NULL,
    `ModifiedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `DeletedDate` datetime NULL,
    `DeletedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `IsDeleted` tinyint(1) NOT NULL,
    CONSTRAINT `PK_DocumentUserPermissions` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_DocumentUserPermissions_Documents_DocumentId` FOREIGN KEY (`DocumentId`) REFERENCES `Documents` (`Id`) ON DELETE RESTRICT,
    CONSTRAINT `FK_DocumentUserPermissions_Users_CreatedBy` FOREIGN KEY (`CreatedBy`) REFERENCES `Users` (`Id`) ON DELETE CASCADE,
    CONSTRAINT `FK_DocumentUserPermissions_Users_UserId` FOREIGN KEY (`UserId`) REFERENCES `Users` (`Id`) ON DELETE RESTRICT
) CHARACTER SET=utf8mb4;

CREATE TABLE `Reminders` (
    `Id` char(36) COLLATE ascii_general_ci NOT NULL,
    `Subject` longtext CHARACTER SET utf8mb4 NULL,
    `Message` longtext CHARACTER SET utf8mb4 NULL,
    `Frequency` int NULL,
    `StartDate` datetime(6) NOT NULL,
    `EndDate` datetime(6) NULL,
    `DayOfWeek` int NULL,
    `IsRepeated` tinyint(1) NOT NULL,
    `IsEmailNotification` tinyint(1) NOT NULL,
    `DocumentId` char(36) COLLATE ascii_general_ci NULL,
    `CreatedDate` datetime NOT NULL,
    `CreatedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `ModifiedDate` datetime NOT NULL,
    `ModifiedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `DeletedDate` datetime NULL,
    `DeletedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `IsDeleted` tinyint(1) NOT NULL,
    CONSTRAINT `PK_Reminders` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_Reminders_Documents_DocumentId` FOREIGN KEY (`DocumentId`) REFERENCES `Documents` (`Id`) ON DELETE RESTRICT
) CHARACTER SET=utf8mb4;

CREATE TABLE `ReminderSchedulers` (
    `Id` char(36) COLLATE ascii_general_ci NOT NULL,
    `Duration` datetime(6) NOT NULL,
    `IsActive` tinyint(1) NOT NULL,
    `Frequency` int NULL,
    `CreatedDate` datetime(6) NOT NULL,
    `DocumentId` char(36) COLLATE ascii_general_ci NULL,
    `UserId` char(36) COLLATE ascii_general_ci NOT NULL,
    `IsRead` tinyint(1) NOT NULL,
    `IsEmailNotification` tinyint(1) NOT NULL,
    `Subject` longtext CHARACTER SET utf8mb4 NULL,
    `Message` longtext CHARACTER SET utf8mb4 NULL,
    CONSTRAINT `PK_ReminderSchedulers` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ReminderSchedulers_Documents_DocumentId` FOREIGN KEY (`DocumentId`) REFERENCES `Documents` (`Id`) ON DELETE RESTRICT,
    CONSTRAINT `FK_ReminderSchedulers_Users_UserId` FOREIGN KEY (`UserId`) REFERENCES `Users` (`Id`) ON DELETE CASCADE
) CHARACTER SET=utf8mb4;

CREATE TABLE `SendEmails` (
    `Id` char(36) COLLATE ascii_general_ci NOT NULL,
    `Subject` longtext CHARACTER SET utf8mb4 NULL,
    `Message` longtext CHARACTER SET utf8mb4 NULL,
    `FromEmail` longtext CHARACTER SET utf8mb4 NULL,
    `DocumentId` char(36) COLLATE ascii_general_ci NULL,
    `IsSend` tinyint(1) NOT NULL,
    `Email` longtext CHARACTER SET utf8mb4 NULL,
    `CreatedDate` datetime NOT NULL,
    `CreatedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `ModifiedDate` datetime NOT NULL,
    `ModifiedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `DeletedDate` datetime NULL,
    `DeletedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `IsDeleted` tinyint(1) NOT NULL,
    CONSTRAINT `PK_SendEmails` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_SendEmails_Documents_DocumentId` FOREIGN KEY (`DocumentId`) REFERENCES `Documents` (`Id`) ON DELETE RESTRICT
) CHARACTER SET=utf8mb4;

CREATE TABLE `UserNotifications` (
    `Id` char(36) COLLATE ascii_general_ci NOT NULL,
    `UserId` char(36) COLLATE ascii_general_ci NOT NULL,
    `Message` longtext CHARACTER SET utf8mb4 NULL,
    `IsRead` tinyint(1) NOT NULL,
    `DocumentId` char(36) COLLATE ascii_general_ci NULL,
    `CreatedDate` datetime NOT NULL,
    `CreatedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `ModifiedDate` datetime NOT NULL,
    `ModifiedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `DeletedDate` datetime NULL,
    `DeletedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `IsDeleted` tinyint(1) NOT NULL,
    CONSTRAINT `PK_UserNotifications` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_UserNotifications_Documents_DocumentId` FOREIGN KEY (`DocumentId`) REFERENCES `Documents` (`Id`) ON DELETE RESTRICT,
    CONSTRAINT `FK_UserNotifications_Users_CreatedBy` FOREIGN KEY (`CreatedBy`) REFERENCES `Users` (`Id`) ON DELETE CASCADE,
    CONSTRAINT `FK_UserNotifications_Users_UserId` FOREIGN KEY (`UserId`) REFERENCES `Users` (`Id`)
) CHARACTER SET=utf8mb4;

CREATE TABLE `DailyReminders` (
    `Id` char(36) COLLATE ascii_general_ci NOT NULL,
    `ReminderId` char(36) COLLATE ascii_general_ci NOT NULL,
    `DayOfWeek` int NOT NULL,
    `IsActive` tinyint(1) NOT NULL,
    CONSTRAINT `PK_DailyReminders` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_DailyReminders_Reminders_ReminderId` FOREIGN KEY (`ReminderId`) REFERENCES `Reminders` (`Id`) ON DELETE CASCADE
) CHARACTER SET=utf8mb4;

CREATE TABLE `HalfYearlyReminders` (
    `Id` char(36) COLLATE ascii_general_ci NOT NULL,
    `ReminderId` char(36) COLLATE ascii_general_ci NOT NULL,
    `Day` int NOT NULL,
    `Month` int NOT NULL,
    `Quarter` int NOT NULL,
    CONSTRAINT `PK_HalfYearlyReminders` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_HalfYearlyReminders_Reminders_ReminderId` FOREIGN KEY (`ReminderId`) REFERENCES `Reminders` (`Id`) ON DELETE CASCADE
) CHARACTER SET=utf8mb4;

CREATE TABLE `QuarterlyReminders` (
    `Id` char(36) COLLATE ascii_general_ci NOT NULL,
    `ReminderId` char(36) COLLATE ascii_general_ci NOT NULL,
    `Day` int NOT NULL,
    `Month` int NOT NULL,
    `Quarter` int NOT NULL,
    CONSTRAINT `PK_QuarterlyReminders` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_QuarterlyReminders_Reminders_ReminderId` FOREIGN KEY (`ReminderId`) REFERENCES `Reminders` (`Id`) ON DELETE CASCADE
) CHARACTER SET=utf8mb4;

CREATE TABLE `ReminderNotifications` (
    `Id` char(36) COLLATE ascii_general_ci NOT NULL,
    `ReminderId` char(36) COLLATE ascii_general_ci NOT NULL,
    `Subject` longtext CHARACTER SET utf8mb4 NULL,
    `Description` longtext CHARACTER SET utf8mb4 NULL,
    `FetchDateTime` datetime(6) NOT NULL,
    `IsDeleted` tinyint(1) NOT NULL,
    `IsEmailNotification` tinyint(1) NOT NULL,
    CONSTRAINT `PK_ReminderNotifications` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ReminderNotifications_Reminders_ReminderId` FOREIGN KEY (`ReminderId`) REFERENCES `Reminders` (`Id`) ON DELETE CASCADE
) CHARACTER SET=utf8mb4;

CREATE TABLE `ReminderUsers` (
    `ReminderId` char(36) COLLATE ascii_general_ci NOT NULL,
    `UserId` char(36) COLLATE ascii_general_ci NOT NULL,
    CONSTRAINT `PK_ReminderUsers` PRIMARY KEY (`ReminderId`, `UserId`),
    CONSTRAINT `FK_ReminderUsers_Reminders_ReminderId` FOREIGN KEY (`ReminderId`) REFERENCES `Reminders` (`Id`) ON DELETE CASCADE,
    CONSTRAINT `FK_ReminderUsers_Users_UserId` FOREIGN KEY (`UserId`) REFERENCES `Users` (`Id`)
) CHARACTER SET=utf8mb4;

CREATE INDEX `IX_Categories_ParentId` ON `Categories` (`ParentId`);

CREATE INDEX `IX_DailyReminders_ReminderId` ON `DailyReminders` (`ReminderId`);

CREATE INDEX `IX_DocumentAuditTrails_AssignToRoleId` ON `DocumentAuditTrails` (`AssignToRoleId`);

CREATE INDEX `IX_DocumentAuditTrails_AssignToUserId` ON `DocumentAuditTrails` (`AssignToUserId`);

CREATE INDEX `IX_DocumentAuditTrails_CreatedBy` ON `DocumentAuditTrails` (`CreatedBy`);

CREATE INDEX `IX_DocumentAuditTrails_DocumentId` ON `DocumentAuditTrails` (`DocumentId`);

CREATE INDEX `IX_DocumentRolePermissions_CreatedBy` ON `DocumentRolePermissions` (`CreatedBy`);

CREATE INDEX `IX_DocumentRolePermissions_DocumentId` ON `DocumentRolePermissions` (`DocumentId`);

CREATE INDEX `IX_DocumentRolePermissions_RoleId` ON `DocumentRolePermissions` (`RoleId`);

CREATE INDEX `IX_Documents_CategoryId` ON `Documents` (`CategoryId`);

CREATE INDEX `IX_Documents_CreatedBy` ON `Documents` (`CreatedBy`);

CREATE INDEX `IX_Documents_Url` ON `Documents` (`Url`);

CREATE INDEX `IX_DocumentUserPermissions_CreatedBy` ON `DocumentUserPermissions` (`CreatedBy`);

CREATE INDEX `IX_DocumentUserPermissions_DocumentId` ON `DocumentUserPermissions` (`DocumentId`);

CREATE INDEX `IX_DocumentUserPermissions_UserId` ON `DocumentUserPermissions` (`UserId`);

CREATE INDEX `IX_HalfYearlyReminders_ReminderId` ON `HalfYearlyReminders` (`ReminderId`);

CREATE INDEX `IX_QuarterlyReminders_ReminderId` ON `QuarterlyReminders` (`ReminderId`);

CREATE INDEX `IX_ReminderNotifications_ReminderId` ON `ReminderNotifications` (`ReminderId`);

CREATE INDEX `IX_Reminders_DocumentId` ON `Reminders` (`DocumentId`);

CREATE INDEX `IX_ReminderSchedulers_DocumentId` ON `ReminderSchedulers` (`DocumentId`);

CREATE INDEX `IX_ReminderSchedulers_UserId` ON `ReminderSchedulers` (`UserId`);

CREATE INDEX `IX_ReminderUsers_UserId` ON `ReminderUsers` (`UserId`);

CREATE INDEX `IX_RoleClaims_OperationId` ON `RoleClaims` (`OperationId`);

CREATE INDEX `IX_RoleClaims_RoleId` ON `RoleClaims` (`RoleId`);

CREATE INDEX `IX_RoleClaims_ScreenId` ON `RoleClaims` (`ScreenId`);

CREATE UNIQUE INDEX `RoleNameIndex` ON `Roles` (`NormalizedName`);

CREATE INDEX `IX_ScreenOperations_OperationId` ON `ScreenOperations` (`OperationId`);

CREATE INDEX `IX_ScreenOperations_ScreenId` ON `ScreenOperations` (`ScreenId`);

CREATE INDEX `IX_SendEmails_DocumentId` ON `SendEmails` (`DocumentId`);

CREATE INDEX `IX_UserClaims_OperationId` ON `UserClaims` (`OperationId`);

CREATE INDEX `IX_UserClaims_ScreenId` ON `UserClaims` (`ScreenId`);

CREATE INDEX `IX_UserClaims_UserId` ON `UserClaims` (`UserId`);

CREATE INDEX `IX_UserLogins_UserId` ON `UserLogins` (`UserId`);

CREATE INDEX `IX_UserNotifications_CreatedBy` ON `UserNotifications` (`CreatedBy`);

CREATE INDEX `IX_UserNotifications_DocumentId` ON `UserNotifications` (`DocumentId`);

CREATE INDEX `IX_UserNotifications_UserId` ON `UserNotifications` (`UserId`);

CREATE INDEX `IX_UserRoles_RoleId` ON `UserRoles` (`RoleId`);

CREATE INDEX `EmailIndex` ON `Users` (`NormalizedEmail`);

CREATE UNIQUE INDEX `UserNameIndex` ON `Users` (`NormalizedUserName`);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20211225124149_Initial', '8.0.8');

COMMIT;

START TRANSACTION;

-- Categories
INSERT `Categories` (`Id`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`, `ParentId`) VALUES (N'9cc497f5-1736-4bc6-84a8-316fd983b732', N'HR Policies', NULL, CAST(N'2021-12-22T17:13:13.4469583' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T17:13:13.4466667' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0, NULL);
INSERT `Categories` (`Id`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`, `ParentId`) VALUES (N'4dbbd372-6acf-4e5d-a1cf-3ca3f7cc190d', N'HR Policies 2020', N'', CAST(N'2021-12-22T17:13:38.7871646' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T17:13:38.7900000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0, N'9cc497f5-1736-4bc6-84a8-316fd983b732');
INSERT `Categories` (`Id`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`, `ParentId`) VALUES (N'0e628f62-c710-40f2-949d-5b38583869f2', N'HR Policies 2021', N'', CAST(N'2021-12-22T17:13:48.4922407' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T17:13:48.4933333' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0, N'9cc497f5-1736-4bc6-84a8-316fd983b732');
INSERT `Categories` (`Id`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`, `ParentId`) VALUES (N'a465e640-4a44-44e9-9821-630cc8da4a4c', N'Confidential', NULL, CAST(N'2021-12-22T17:13:06.8971286' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T17:13:06.8966667' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0, NULL);
INSERT `Categories` (`Id`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`, `ParentId`) VALUES (N'48c4c825-04d7-44c5-84c8-6d134cb9b36b', N'Logbooks', NULL, CAST(N'2021-12-22T17:12:44.7875398' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T17:12:44.7900000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0, NULL);
INSERT `Categories` (`Id`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`, `ParentId`) VALUES (N'e6bc300e-6600-442e-b452-9a13213ab980', N'Quality Assurance Document', NULL, CAST(N'2021-12-22T17:13:25.7641267' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T17:13:25.7633333' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0, NULL);
INSERT `Categories` (`Id`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`, `ParentId`) VALUES (N'ad57c02a-b6cf-4aa3-aad7-9c014c41b3e6', N'SOP Production', NULL, CAST(N'2021-12-22T17:12:56.6720077' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T17:12:56.6700000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0, NULL);
INSERT `Categories` (`Id`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`, `ParentId`) VALUES (N'04226dd5-fedc-4fbd-8ba9-c0a5b72c5b39', N'Resume', NULL, CAST(N'2021-12-22T17:12:49.0555527' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T17:12:49.0566667' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0, NULL);

-- Users
INSERT `Users` (`Id`, `FirstName`, `LastName`, `IsDeleted`, `UserName`, `NormalizedUserName`, `Email`, `NormalizedEmail`, `EmailConfirmed`, `PasswordHash`, `SecurityStamp`, `ConcurrencyStamp`, `PhoneNumber`, `PhoneNumberConfirmed`, `TwoFactorEnabled`, `LockoutEnd`, `LockoutEnabled`, `AccessFailedCount`) VALUES (N'1a5cf5b9-ead8-495c-8719-2d8be776f452', N'Shirley', N'Heitzman', 0, N'employee@gmail.com', N'EMPLOYEE@GMAIL.COM', N'employee@gmail.com', N'EMPLOYEE@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEISmz8S4E4dOhEPhhcQ6xmdJCNeez7fmWB6tXa1h2yKrwD3lO+lX+eKSeKdgPB/Mcw==', N'HFC3ZVYIMS63F5H6FHWNDUFRLRI4RDEG', N'6b2c2644-949a-4d2c-99fe-bb72411b6eb2', N'9904750722', 0, 0, NULL, 1, 0);
INSERT `Users` (`Id`, `FirstName`, `LastName`, `IsDeleted`, `UserName`, `NormalizedUserName`, `Email`, `NormalizedEmail`, `EmailConfirmed`, `PasswordHash`, `SecurityStamp`, `ConcurrencyStamp`, `PhoneNumber`, `PhoneNumberConfirmed`, `TwoFactorEnabled`, `LockoutEnd`, `LockoutEnabled`, `AccessFailedCount`) VALUES (N'4b352b37-332a-40c6-ab05-e38fcf109719', N'David', N'Parnell', 0, N'admin@gmail.com', N'ADMIN@GMAIL.COM', N'admin@gmail.com', N'ADMIN@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEM60FYHL5RMKNeB+CxCOI41EC8Vsr1B3Dyrrr2BOtZrxz6doL8o6Tv/tYGDRk20t1A==', N'5D4GQ7LLLVRQJDQFNUGUU763GELSABOJ', N'dde0074a-2914-476c-bd3b-63622da1dbeb', N'1234567890', 0, 0, NULL, 1, 0);

-- Operations
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'c288b5d3-419d-4dc0-9e5a-083194016d2c', N'Edit Role', CAST(N'2021-12-22T16:19:27.0969638' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:19:27.0966667' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'41f65d07-9023-4cfb-9c7c-0e3247a012e0', N'View SMTP Settings', CAST(N'2021-12-22T17:10:54.4083253' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T17:10:54.4100000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'229ad778-c7d3-4f5f-ab52-24b537c39514', N'Delete Document', CAST(N'2021-12-22T16:18:30.3499854' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:18:30.3533333' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'752ae5b8-e34f-4b32-81f2-2cf709881663', N'Edit SMTP Setting', CAST(N'2021-12-22T16:20:21.5000620' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:20:21.5000000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'6f2717fc-edef-4537-916d-2d527251a5c1', N'View Reminders', CAST(N'2021-12-22T17:10:31.0954098' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T17:10:31.0966667' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'cd46a3a4-ede5-4941-a49b-3df7eaa46428', N'Edit Category', CAST(N'2021-12-22T16:19:11.9766992' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:19:11.9766667' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'63ed1277-1db5-4cf7-8404-3e3426cb4bc5', N'View Documents', CAST(N'2021-12-22T17:08:28.5475520' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T17:08:28.5566667' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'6bc0458e-22f5-4975-b387-4d6a4fb35201', N'Create Reminder', CAST(N'2021-12-22T16:20:01.0047984' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:20:01.0066667' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'1c7d3e31-08ad-43cf-9cf7-4ffafdda9029', N'View Document Audit Trail', CAST(N'2021-12-22T16:19:19.6713411' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:19:19.6700000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'3ccaf408-8864-4815-a3e0-50632d90bcb6', N'Edit Reminder', CAST(N'2021-12-22T16:20:05.0099657' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:20:05.0166667' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'67ae2b97-b24e-41d5-bf39-56b2834548d0', N'Create Category', CAST(N'2021-12-22T16:19:08.4886748' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:19:08.4900000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'595a769d-f7ef-45f3-9f9e-60c58c5e1542', N'Send Email', CAST(N'2021-12-22T16:18:38.5891523' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:18:38.5900000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'e506ec48-b99a-45b4-9ec9-6451bc67477b', N'Assign Permission', CAST(N'2021-12-22T16:19:48.2359350' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:19:48.2366667' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'ab45ef6a-a8e6-47ef-a182-6b88e2a6f9aa', N'View Categories', CAST(N'2021-12-22T17:09:09.2608417' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T17:09:09.2600000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'd4d724fc-fd38-49c4-85bc-73937b219e20', N'Reset Password', CAST(N'2021-12-22T16:19:51.9868277' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:19:51.9866667' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'7ba630ca-a9d3-42ee-99c8-766e2231fec1', N'View Dashboard', CAST(N'2021-12-22T16:18:17.4262057' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:18:17.4300000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'3da78b4d-d263-4b13-8e81-7aa164a3688c', N'Add Reminder', CAST(N'2021-12-22T16:18:42.2181455' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:18:42.2200000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'ab0544d7-2276-4f3b-b450-7f0fa11c3dd9', N'Create SMTP Setting', CAST(N'2021-12-22T16:20:17.6534586' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:20:17.6533333' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'57216dcd-1a1c-4f94-a33d-83a5af2d7a46', N'View Roles', CAST(N'2021-12-22T17:09:43.8015442' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T17:09:43.8033333' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'4f19045b-e9a8-403b-b730-8453ee72830e', N'Delete SMTP Setting', CAST(N'2021-12-22T16:20:25.5731214' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:20:25.5733333' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'fbe77c07-3058-4dbe-9d56-8c75dc879460', N'Assign User Role', CAST(N'2021-12-22T16:19:56.3240583' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:19:56.3233333' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'ff4b3b73-c29f-462a-afa4-94a40e6b2c4a', N'View Login Audit Logs', CAST(N'2021-12-22T16:20:13.3631949' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:20:13.3633333' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'239035d5-cd44-475f-bbc5-9ef51768d389', N'Create Document', CAST(N'2021-12-22T16:18:22.7285627' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:18:22.7300000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'db8825b1-ee4e-49f6-9a08-b0210ed53fd4', N'Create Role', CAST(N'2021-12-22T16:19:23.9337990' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:19:23.9333333' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'31cb6438-7d4a-4385-8a34-b4e8f6096a48', N'View Users', CAST(N'2021-12-22T17:10:05.7725732' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T17:10:05.7733333' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'18a5a8f6-7cb6-4178-857d-b6a981ea3d4f', N'Delete Role', CAST(N'2021-12-22T16:19:30.9951456' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:19:30.9966667' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'6719a065-8a4a-4350-8582-bfc41ce283fb', N'Download Document', CAST(N'2021-12-22T16:18:46.2300299' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:18:46.2300000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'a8dd972d-e758-4571-8d39-c6fec74b361b', N'Edit Document', CAST(N'2021-12-22T16:18:26.4671126' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:18:26.4666667' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'86ce1382-a2b1-48ed-ae81-c9908d00cf3b', N'Create User', CAST(N'2021-12-22T16:19:35.4981545' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:19:35.4966667' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'5ea48d56-2ed3-4239-bb90-dd4d70a1b0b2', N'Delete Reminder', CAST(N'2021-12-22T16:20:09.0773918' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:20:09.0800000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'0a2e19fc-d9f2-446c-8ca3-e6b8b73b5f9b', N'Edit User', CAST(N'2021-12-22T16:19:41.0135872' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:19:41.0166667' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'2ea6ba08-eb36-4e34-92d9-f1984c908b31', N'Share Document', CAST(N'2021-12-22T16:18:34.8231442' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:18:34.8233333' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'9c0e2186-06a4-4207-acbc-f6d8efa430b3', N'Delete Category', CAST(N'2021-12-22T16:19:15.0882259' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:19:15.0900000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'374d74aa-a580-4928-848d-f7553db39914', N'Delete User', CAST(N'2021-12-22T16:19:44.4173351' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:19:44.4166667' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);

-- Roles
INSERT `Roles` (`Id`, `IsDeleted`, `Name`, `NormalizedName`, `ConcurrencyStamp`) VALUES (N'c5d235ea-81b4-4c36-9205-2077da227c0a', 0, N'Employee', N'Employee', N'47432aba-cc42-4113-a49d-cb8548e185b2');
INSERT `Roles` (`Id`, `IsDeleted`, `Name`, `NormalizedName`, `ConcurrencyStamp`) VALUES (N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', 0, N'Super Admin', N'Super Admin', N'870b5668-b97a-4406-bead-09022612568c');

-- Screens
INSERT `Screens` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'2e3c07a4-fcac-4303-ae47-0d0f796403c9', N'Email', CAST(N'2021-12-22T16:18:01.0788250' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:18:01.0800000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Screens` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'eddf9e8e-0c70-4cde-b5f9-117a879747d6', N'All Documents', CAST(N'2021-12-22T16:17:23.9712198' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:17:23.9700000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Screens` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'42e44f15-8e33-423a-ad7f-17edc23d6dd3', N'Dashboard', CAST(N'2021-12-22T16:17:16.4668983' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:17:16.4733333' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Screens` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'97ff6eb0-39b3-4ddd-acf1-43205d5a9bb3', N'Reminder', CAST(N'2021-12-22T16:17:52.9795843' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:17:52.9800000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Screens` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'f042bbee-d15f-40fb-b79a-8368f2c2e287', N'Login Audit', CAST(N'2021-12-22T16:17:57.4457910' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:17:57.4466667' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Screens` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'2396f81c-f8b5-49ac-88d1-94ed57333f49', N'Document Audit Trail', CAST(N'2021-12-22T16:17:38.6403958' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:17:38.6400000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Screens` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'324bdc51-d71f-4f80-9f28-a30e8aae4009', N'User', CAST(N'2021-12-22T16:17:48.8833752' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:17:48.8833333' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Screens` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', N'Assigned Documents', CAST(N'2021-12-24T10:15:02.1617631' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-24T10:15:02.1733333' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Screens` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'090ea443-01c7-4638-a194-ad3416a5ea7a', N'Role', CAST(N'2021-12-22T16:17:44.1841942' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:17:44.1833333' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Screens` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'5a5f7cf8-21a6-434a-9330-db91b17d867c', N'Document Category', CAST(N'2021-12-22T16:17:33.3778925' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:17:33.3800000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);

-- Role Claims
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'752ae5b8-e34f-4b32-81f2-2cf709881663', N'2e3c07a4-fcac-4303-ae47-0d0f796403c9', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Email_Edit_SMTP_Setting', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'cd46a3a4-ede5-4941-a49b-3df7eaa46428', N'5a5f7cf8-21a6-434a-9330-db91b17d867c', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Document_Category_Edit_Category', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'18a5a8f6-7cb6-4178-857d-b6a981ea3d4f', N'090ea443-01c7-4638-a194-ad3416a5ea7a', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Role_Delete_Role', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'db8825b1-ee4e-49f6-9a08-b0210ed53fd4', N'090ea443-01c7-4638-a194-ad3416a5ea7a', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Role_Create_Role', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'c288b5d3-419d-4dc0-9e5a-083194016d2c', N'090ea443-01c7-4638-a194-ad3416a5ea7a', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Role_Edit_Role', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'374d74aa-a580-4928-848d-f7553db39914', N'324bdc51-d71f-4f80-9f28-a30e8aae4009', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'User_Delete_User', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'0a2e19fc-d9f2-446c-8ca3-e6b8b73b5f9b', N'324bdc51-d71f-4f80-9f28-a30e8aae4009', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'User_Edit_User', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'86ce1382-a2b1-48ed-ae81-c9908d00cf3b', N'324bdc51-d71f-4f80-9f28-a30e8aae4009', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'User_Create_User', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'fbe77c07-3058-4dbe-9d56-8c75dc879460', N'324bdc51-d71f-4f80-9f28-a30e8aae4009', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'User_Assign_User_Role', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'd4d724fc-fd38-49c4-85bc-73937b219e20', N'324bdc51-d71f-4f80-9f28-a30e8aae4009', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'User_Reset_Password', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'e506ec48-b99a-45b4-9ec9-6451bc67477b', N'324bdc51-d71f-4f80-9f28-a30e8aae4009', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'User_Assign_Permission', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'1c7d3e31-08ad-43cf-9cf7-4ffafdda9029', N'2396f81c-f8b5-49ac-88d1-94ed57333f49', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Document_Audit_Trail_View_Document_Audit_Trail', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'ff4b3b73-c29f-462a-afa4-94a40e6b2c4a', N'f042bbee-d15f-40fb-b79a-8368f2c2e287', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Login_Audit_View_Login_Audit_Logs', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'67ae2b97-b24e-41d5-bf39-56b2834548d0', N'5a5f7cf8-21a6-434a-9330-db91b17d867c', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Document_Category_Create_Category', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'5ea48d56-2ed3-4239-bb90-dd4d70a1b0b2', N'97ff6eb0-39b3-4ddd-acf1-43205d5a9bb3', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Reminder_Delete_Reminder', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'6bc0458e-22f5-4975-b387-4d6a4fb35201', N'97ff6eb0-39b3-4ddd-acf1-43205d5a9bb3', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Reminder_Create_Reminder', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'7ba630ca-a9d3-42ee-99c8-766e2231fec1', N'42e44f15-8e33-423a-ad7f-17edc23d6dd3', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Dashboard_View_Dashboard', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'2ea6ba08-eb36-4e34-92d9-f1984c908b31', N'eddf9e8e-0c70-4cde-b5f9-117a879747d6', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'All_Documents_Share_Document', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'a8dd972d-e758-4571-8d39-c6fec74b361b', N'eddf9e8e-0c70-4cde-b5f9-117a879747d6', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'All_Documents_Edit_Document', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'6719a065-8a4a-4350-8582-bfc41ce283fb', N'eddf9e8e-0c70-4cde-b5f9-117a879747d6', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'All_Documents_Download_Document', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'239035d5-cd44-475f-bbc5-9ef51768d389', N'eddf9e8e-0c70-4cde-b5f9-117a879747d6', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'All_Documents_Create_Document', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'3da78b4d-d263-4b13-8e81-7aa164a3688c', N'eddf9e8e-0c70-4cde-b5f9-117a879747d6', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'All_Documents_Add_Reminder', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'595a769d-f7ef-45f3-9f9e-60c58c5e1542', N'eddf9e8e-0c70-4cde-b5f9-117a879747d6', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'All_Documents_Send_Email', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'229ad778-c7d3-4f5f-ab52-24b537c39514', N'eddf9e8e-0c70-4cde-b5f9-117a879747d6', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'All_Documents_Delete_Document', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'4f19045b-e9a8-403b-b730-8453ee72830e', N'2e3c07a4-fcac-4303-ae47-0d0f796403c9', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Email_Delete_SMTP_Setting', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'ab0544d7-2276-4f3b-b450-7f0fa11c3dd9', N'2e3c07a4-fcac-4303-ae47-0d0f796403c9', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Email_Create_SMTP_Setting', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'3ccaf408-8864-4815-a3e0-50632d90bcb6', N'97ff6eb0-39b3-4ddd-acf1-43205d5a9bb3', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Reminder_Edit_Reminder', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'9c0e2186-06a4-4207-acbc-f6d8efa430b3', N'5a5f7cf8-21a6-434a-9330-db91b17d867c', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Document_Category_Delete_Category', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'ab45ef6a-a8e6-47ef-a182-6b88e2a6f9aa', N'5a5f7cf8-21a6-434a-9330-db91b17d867c', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Document_Category_View_Categories', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'57216dcd-1a1c-4f94-a33d-83a5af2d7a46', N'090ea443-01c7-4638-a194-ad3416a5ea7a', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Role_View_Roles', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'31cb6438-7d4a-4385-8a34-b4e8f6096a48', N'324bdc51-d71f-4f80-9f28-a30e8aae4009', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'User_View_Users', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'6f2717fc-edef-4537-916d-2d527251a5c1', N'97ff6eb0-39b3-4ddd-acf1-43205d5a9bb3', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Reminder_View_Reminders', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'63ed1277-1db5-4cf7-8404-3e3426cb4bc5', N'eddf9e8e-0c70-4cde-b5f9-117a879747d6', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'All_Documents_View_Documents', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'41f65d07-9023-4cfb-9c7c-0e3247a012e0', N'2e3c07a4-fcac-4303-ae47-0d0f796403c9', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Email_View_SMTP_Settings', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'7ba630ca-a9d3-42ee-99c8-766e2231fec1', N'42e44f15-8e33-423a-ad7f-17edc23d6dd3', N'c5d235ea-81b4-4c36-9205-2077da227c0a', N'Dashboard_View_Dashboard', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'ab45ef6a-a8e6-47ef-a182-6b88e2a6f9aa', N'5a5f7cf8-21a6-434a-9330-db91b17d867c', N'c5d235ea-81b4-4c36-9205-2077da227c0a', N'Document_Category_View_Categories', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'239035d5-cd44-475f-bbc5-9ef51768d389', N'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', N'c5d235ea-81b4-4c36-9205-2077da227c0a', N'Assigned_Documents_Create_Document', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'239035d5-cd44-475f-bbc5-9ef51768d389', N'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Assigned_Documents_Create_Document', N'');

-- ScreenOperations
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'6adf6012-0101-48b2-ad54-078d2f7fe96d', N'31cb6438-7d4a-4385-8a34-b4e8f6096a48', N'324bdc51-d71f-4f80-9f28-a30e8aae4009', CAST(N'2021-12-22T17:10:15.7372916' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T17:10:15.7400000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'f54926e2-3ad3-40be-8f7e-14cab77e87bd', N'3ccaf408-8864-4815-a3e0-50632d90bcb6', N'97ff6eb0-39b3-4ddd-acf1-43205d5a9bb3', CAST(N'2021-12-22T16:21:45.5996626' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:21:45.6000000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'87089dd2-149a-49c4-931c-18b47e08561c', N'd4d724fc-fd38-49c4-85bc-73937b219e20', N'324bdc51-d71f-4f80-9f28-a30e8aae4009', CAST(N'2021-12-22T16:21:35.8791295' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:21:35.8800000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'8e82fe1f-8ccd-4cc2-b1ca-1a84dd17a5ab', N'67ae2b97-b24e-41d5-bf39-56b2834548d0', N'5a5f7cf8-21a6-434a-9330-db91b17d867c', CAST(N'2021-12-22T16:21:05.3807145' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:21:05.3800000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'6a048b38-5b3a-42b0-83fd-2c4d588d0b2f', N'6bc0458e-22f5-4975-b387-4d6a4fb35201', N'97ff6eb0-39b3-4ddd-acf1-43205d5a9bb3', CAST(N'2021-12-22T16:21:44.7181855' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:21:44.7200000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'faf1cb6f-9c20-4ca3-8222-32028b44e484', N'595a769d-f7ef-45f3-9f9e-60c58c5e1542', N'eddf9e8e-0c70-4cde-b5f9-117a879747d6', CAST(N'2021-12-22T16:20:43.0046514' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:20:43.0033333' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'65dfed53-7855-46f5-ab93-3629fc68ea71', N'1c7d3e31-08ad-43cf-9cf7-4ffafdda9029', N'2396f81c-f8b5-49ac-88d1-94ed57333f49', CAST(N'2021-12-22T16:21:14.2760682' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:21:14.2800000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'761032d2-822a-4274-ab85-3b389f5ec252', N'2ea6ba08-eb36-4e34-92d9-f1984c908b31', N'eddf9e8e-0c70-4cde-b5f9-117a879747d6', CAST(N'2021-12-22T16:20:42.2272333' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:20:42.2300000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'5d5e0edc-e14f-48ad-bf1d-3dfbd9ac55aa', N'db8825b1-ee4e-49f6-9a08-b0210ed53fd4', N'090ea443-01c7-4638-a194-ad3416a5ea7a', CAST(N'2021-12-22T16:21:21.0297782' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:21:21.0300000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'cc5d7643-e418-492f-bbbd-409a336dbce5', N'9c0e2186-06a4-4207-acbc-f6d8efa430b3', N'5a5f7cf8-21a6-434a-9330-db91b17d867c', CAST(N'2021-12-22T16:21:06.6744709' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:21:06.6800000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'c9928f1f-0702-4e37-97a7-431e5c9f819c', N'374d74aa-a580-4928-848d-f7553db39914', N'324bdc51-d71f-4f80-9f28-a30e8aae4009', CAST(N'2021-12-22T16:21:33.4580076' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:21:33.4600000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'e67675a7-cd03-4b28-bd2f-437a813686b0', N'cd46a3a4-ede5-4941-a49b-3df7eaa46428', N'5a5f7cf8-21a6-434a-9330-db91b17d867c', CAST(N'2021-12-22T16:21:06.0554216' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:21:06.0533333' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'8a90c207-7752-4277-83f6-5345ed277d7a', N'57216dcd-1a1c-4f94-a33d-83a5af2d7a46', N'090ea443-01c7-4638-a194-ad3416a5ea7a', CAST(N'2021-12-22T17:09:52.9006960' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T17:09:52.9000000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'dcba14ed-cb99-44d4-8b4f-53d8f249ed20', N'3da78b4d-d263-4b13-8e81-7aa164a3688c', N'eddf9e8e-0c70-4cde-b5f9-117a879747d6', CAST(N'2021-12-22T16:20:47.1425483' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:20:47.1433333' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'8f065fb5-01c7-4dea-ab19-650392338688', N'752ae5b8-e34f-4b32-81f2-2cf709881663', N'2e3c07a4-fcac-4303-ae47-0d0f796403c9', CAST(N'2021-12-22T16:22:00.6107538' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:22:00.6100000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'ff092131-a214-48c0-a8e3-68a8723840e1', N'86ce1382-a2b1-48ed-ae81-c9908d00cf3b', N'324bdc51-d71f-4f80-9f28-a30e8aae4009', CAST(N'2021-12-22T16:21:31.6462984' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:21:31.6466667' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'd53f507b-c73c-435f-a4d0-69fe616b8d80', N'6f2717fc-edef-4537-916d-2d527251a5c1', N'97ff6eb0-39b3-4ddd-acf1-43205d5a9bb3', CAST(N'2021-12-22T17:10:41.8229074' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T17:10:41.8300000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'f8863c5a-4344-41cb-b1fa-83e223d6a7df', N'6719a065-8a4a-4350-8582-bfc41ce283fb', N'eddf9e8e-0c70-4cde-b5f9-117a879747d6', CAST(N'2021-12-22T16:20:48.9822259' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:20:48.9833333' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'1a0a3737-ee82-46dc-a1b1-8bbc3aee23f6', N'ab0544d7-2276-4f3b-b450-7f0fa11c3dd9', N'2e3c07a4-fcac-4303-ae47-0d0f796403c9', CAST(N'2021-12-22T16:22:00.0004601' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:22:00.0000000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'e1278d04-1e53-4885-b7f3-8dd9786ee8ba', N'fbe77c07-3058-4dbe-9d56-8c75dc879460', N'324bdc51-d71f-4f80-9f28-a30e8aae4009', CAST(N'2021-12-22T16:21:36.6827083' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:21:36.6800000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'b13dc77a-32b9-4f48-96de-90539ba688fa', N'41f65d07-9023-4cfb-9c7c-0e3247a012e0', N'2e3c07a4-fcac-4303-ae47-0d0f796403c9', CAST(N'2021-12-22T17:11:05.2931233' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T17:11:05.2933333' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'7df88485-9516-4995-9bc2-99dd7edd6bf9', N'229ad778-c7d3-4f5f-ab52-24b537c39514', N'eddf9e8e-0c70-4cde-b5f9-117a879747d6', CAST(N'2021-12-22T16:20:40.0817371' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:20:40.0800000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'e99d8d8b-961c-47ad-85d8-a7b57c6a2f65', N'239035d5-cd44-475f-bbc5-9ef51768d389', N'eddf9e8e-0c70-4cde-b5f9-117a879747d6', CAST(N'2021-12-22T16:20:37.6126421' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:20:37.6133333' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'4de6055c-5f81-44d8-aee2-b966fc442263', N'4f19045b-e9a8-403b-b730-8453ee72830e', N'2e3c07a4-fcac-4303-ae47-0d0f796403c9', CAST(N'2021-12-22T16:22:01.1583447' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:22:01.1566667' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'cb980805-4de9-45b6-a12d-bb0f91d549cb', N'e506ec48-b99a-45b4-9ec9-6451bc67477b', N'324bdc51-d71f-4f80-9f28-a30e8aae4009', CAST(N'2021-12-22T16:21:35.0223941' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:21:35.0233333' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'd886ffaa-e26f-4e27-b4e5-c3636f6422cf', N'ff4b3b73-c29f-462a-afa4-94a40e6b2c4a', N'f042bbee-d15f-40fb-b79a-8368f2c2e287', CAST(N'2021-12-22T16:21:54.0380761' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:21:54.0366667' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'ecf7dc42-fc44-4d1a-b314-d1ff71878d94', N'5ea48d56-2ed3-4239-bb90-dd4d70a1b0b2', N'97ff6eb0-39b3-4ddd-acf1-43205d5a9bb3', CAST(N'2021-12-22T16:21:46.9438819' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:21:46.9433333' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'23ddf867-056f-425b-99ed-d298bbd2d80f', N'0a2e19fc-d9f2-446c-8ca3-e6b8b73b5f9b', N'324bdc51-d71f-4f80-9f28-a30e8aae4009', CAST(N'2021-12-22T16:21:32.5698943' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:21:32.5700000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'f591c7be-4913-44f8-a74c-d2fc44dd5a3e', N'ab45ef6a-a8e6-47ef-a182-6b88e2a6f9aa', N'5a5f7cf8-21a6-434a-9330-db91b17d867c', CAST(N'2021-12-22T17:09:28.4063740' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T17:09:28.4100000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'b4fc0f33-0e9b-4b22-b357-d85125ba8d49', N'a8dd972d-e758-4571-8d39-c6fec74b361b', N'eddf9e8e-0c70-4cde-b5f9-117a879747d6', CAST(N'2021-12-22T16:20:39.2013274' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:20:39.2033333' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'ded2da54-9077-46b4-8d2e-db69890bed25', N'63ed1277-1db5-4cf7-8404-3e3426cb4bc5', N'eddf9e8e-0c70-4cde-b5f9-117a879747d6', CAST(N'2021-12-22T17:08:44.8152974' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T17:08:44.8433333' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'1a3346d9-3c8d-4ae0-9416-db9a157d20f2', N'18a5a8f6-7cb6-4178-857d-b6a981ea3d4f', N'090ea443-01c7-4638-a194-ad3416a5ea7a', CAST(N'2021-12-22T16:21:22.7469170' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:21:22.7466667' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'b7d48f9a-c54c-4394-81ce-ea10aba9df87', N'239035d5-cd44-475f-bbc5-9ef51768d389', N'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', CAST(N'2021-12-24T10:15:31.2448701' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-24T10:15:31.2600000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'51c88956-ea5a-4934-96ba-fd09905a1b0a', N'7ba630ca-a9d3-42ee-99c8-766e2231fec1', N'42e44f15-8e33-423a-ad7f-17edc23d6dd3', CAST(N'2021-12-22T16:20:34.2980924' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:20:34.3066667' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'044ceb92-87fc-41a5-93a7-ffaf096db766', N'c288b5d3-419d-4dc0-9e5a-083194016d2c', N'090ea443-01c7-4638-a194-ad3416a5ea7a', CAST(N'2021-12-22T16:21:21.8659673' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2021-12-22T16:21:21.8666667' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);

-- UserRoles
INSERT `UserRoles` (`UserId`, `RoleId`) VALUES (N'1a5cf5b9-ead8-495c-8719-2d8be776f452', N'c5d235ea-81b4-4c36-9205-2077da227c0a');
INSERT `UserRoles` (`UserId`, `RoleId`) VALUES (N'4b352b37-332a-40c6-ab05-e38fcf109719', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5');


CREATE DEFINER=`root`@`localhost` PROCEDURE `NLog_AddEntry_p`(
  machineName nvarchar(200),
  logged datetime(3),
  level varchar(5),
  message longtext,
  logger nvarchar(300),
  properties longtext,
  callsite nvarchar(300),
  exception longtext
)
BEGIN
  INSERT INTO NLog (
	`Id`,
    `MachineName`,
    `Logged`,
    `Level`,
    `Message`,
    `Logger`,
    `Properties`,
    `Callsite`,
    `Exception`
  ) VALUES (
    uuid(),
    machineName,
    UTC_TIMESTAMP,
    level,
    message,
    logger,
    properties,
    callsite,
    exception
  );
  END;

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20211225124206_Initial_SQL_Data', '8.0.8');

COMMIT;

START TRANSACTION;

ALTER TABLE `UserNotifications` MODIFY COLUMN `DeletedBy` char(36) COLLATE ascii_general_ci NULL;

ALTER TABLE `SendEmails` MODIFY COLUMN `DeletedBy` char(36) COLLATE ascii_general_ci NULL;

ALTER TABLE `Screens` MODIFY COLUMN `DeletedBy` char(36) COLLATE ascii_general_ci NULL;

ALTER TABLE `ScreenOperations` MODIFY COLUMN `DeletedBy` char(36) COLLATE ascii_general_ci NULL;

ALTER TABLE `Reminders` MODIFY COLUMN `DeletedBy` char(36) COLLATE ascii_general_ci NULL;

ALTER TABLE `Operations` MODIFY COLUMN `DeletedBy` char(36) COLLATE ascii_general_ci NULL;

ALTER TABLE `EmailSMTPSettings` MODIFY COLUMN `DeletedBy` char(36) COLLATE ascii_general_ci NULL;

ALTER TABLE `DocumentUserPermissions` MODIFY COLUMN `DeletedBy` char(36) COLLATE ascii_general_ci NULL;

ALTER TABLE `Documents` MODIFY COLUMN `DeletedBy` char(36) COLLATE ascii_general_ci NULL;

ALTER TABLE `DocumentRolePermissions` MODIFY COLUMN `DeletedBy` char(36) COLLATE ascii_general_ci NULL;

ALTER TABLE `DocumentAuditTrails` MODIFY COLUMN `DeletedBy` char(36) COLLATE ascii_general_ci NULL;

ALTER TABLE `Categories` MODIFY COLUMN `DeletedBy` char(36) COLLATE ascii_general_ci NULL;

CREATE TABLE `DocumentComments` (
    `Id` char(36) COLLATE ascii_general_ci NOT NULL,
    `DocumentId` char(36) COLLATE ascii_general_ci NOT NULL,
    `Comment` longtext CHARACTER SET utf8mb4 NULL,
    `CreatedDate` datetime NOT NULL,
    `CreatedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `ModifiedDate` datetime NOT NULL,
    `ModifiedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `DeletedDate` datetime NULL,
    `DeletedBy` char(36) COLLATE ascii_general_ci NULL,
    `IsDeleted` tinyint(1) NOT NULL,
    CONSTRAINT `PK_DocumentComments` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_DocumentComments_Documents_DocumentId` FOREIGN KEY (`DocumentId`) REFERENCES `Documents` (`Id`) ON DELETE CASCADE,
    CONSTRAINT `FK_DocumentComments_Users_CreatedBy` FOREIGN KEY (`CreatedBy`) REFERENCES `Users` (`Id`) ON DELETE RESTRICT
) CHARACTER SET=utf8mb4;

CREATE TABLE `DocumentMetaDatas` (
    `Id` char(36) COLLATE ascii_general_ci NOT NULL,
    `DocumentId` char(36) COLLATE ascii_general_ci NOT NULL,
    `Metatag` longtext CHARACTER SET utf8mb4 NULL,
    `CreatedDate` datetime NOT NULL,
    `CreatedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `ModifiedDate` datetime NOT NULL,
    `ModifiedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `DeletedDate` datetime NULL,
    `DeletedBy` char(36) COLLATE ascii_general_ci NULL,
    `IsDeleted` tinyint(1) NOT NULL,
    CONSTRAINT `PK_DocumentMetaDatas` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_DocumentMetaDatas_Documents_DocumentId` FOREIGN KEY (`DocumentId`) REFERENCES `Documents` (`Id`) ON DELETE CASCADE
) CHARACTER SET=utf8mb4;

CREATE TABLE `DocumentVersions` (
    `Id` char(36) COLLATE ascii_general_ci NOT NULL,
    `DocumentId` char(36) COLLATE ascii_general_ci NOT NULL,
    `Url` longtext CHARACTER SET utf8mb4 NULL,
    `CreatedDate` datetime NOT NULL,
    `CreatedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `ModifiedDate` datetime NOT NULL,
    `ModifiedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `DeletedDate` datetime NULL,
    `DeletedBy` char(36) COLLATE ascii_general_ci NULL,
    `IsDeleted` tinyint(1) NOT NULL,
    CONSTRAINT `PK_DocumentVersions` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_DocumentVersions_Documents_DocumentId` FOREIGN KEY (`DocumentId`) REFERENCES `Documents` (`Id`) ON DELETE CASCADE,
    CONSTRAINT `FK_DocumentVersions_Users_CreatedBy` FOREIGN KEY (`CreatedBy`) REFERENCES `Users` (`Id`) ON DELETE RESTRICT
) CHARACTER SET=utf8mb4;

CREATE INDEX `IX_DocumentComments_CreatedBy` ON `DocumentComments` (`CreatedBy`);

CREATE INDEX `IX_DocumentComments_DocumentId` ON `DocumentComments` (`DocumentId`);

CREATE INDEX `IX_DocumentMetaDatas_DocumentId` ON `DocumentMetaDatas` (`DocumentId`);

CREATE INDEX `IX_DocumentVersions_CreatedBy` ON `DocumentVersions` (`CreatedBy`);

CREATE INDEX `IX_DocumentVersions_DocumentId` ON `DocumentVersions` (`DocumentId`);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20220620111304_Version_V3', '8.0.8');

COMMIT;

START TRANSACTION;

ALTER TABLE `UserNotifications` DROP FOREIGN KEY `FK_UserNotifications_Users_CreatedBy`;

ALTER TABLE `UserNotifications` DROP INDEX `IX_UserNotifications_CreatedBy`;

ALTER TABLE `UserNotifications` ADD `NotificationsType` int NOT NULL DEFAULT 0;

ALTER TABLE `UserClaims` MODIFY COLUMN `Id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `SendEmails` ADD `FromName` longtext CHARACTER SET utf8mb4 NULL;

ALTER TABLE `SendEmails` ADD `ToName` longtext CHARACTER SET utf8mb4 NULL;

ALTER TABLE `Screens` ADD `OrderNo` int NULL;

ALTER TABLE `RoleClaims` MODIFY COLUMN `Id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `NLog` MODIFY COLUMN `Logged` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE `DocumentVersions` ADD `IV` LONGBLOB NULL;

ALTER TABLE `DocumentVersions` ADD `Key` LONGBLOB NULL;

ALTER TABLE `Documents` ADD `DocumentStatusId` char(36) COLLATE ascii_general_ci NULL;

ALTER TABLE `Documents` ADD `IV` LONGBLOB NULL;

ALTER TABLE `Documents` ADD `Key` LONGBLOB NULL;

ALTER TABLE `Documents` ADD `StorageSettingId` char(36) COLLATE ascii_general_ci NULL;

ALTER TABLE `Documents` ADD `StorageType` int NOT NULL DEFAULT 0;

CREATE TABLE `CompanyProfiles` (
    `Id` char(36) COLLATE ascii_general_ci NOT NULL,
    `Name` longtext CHARACTER SET utf8mb4 NULL,
    `LogoUrl` longtext CHARACTER SET utf8mb4 NULL,
    `BannerUrl` longtext CHARACTER SET utf8mb4 NULL,
    `CreatedDate` datetime NOT NULL,
    `CreatedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `ModifiedDate` datetime NOT NULL,
    `ModifiedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `DeletedDate` datetime NULL,
    `DeletedBy` char(36) COLLATE ascii_general_ci NULL,
    `IsDeleted` tinyint(1) NOT NULL,
    CONSTRAINT `PK_CompanyProfiles` PRIMARY KEY (`Id`)
) CHARACTER SET=utf8mb4;

CREATE TABLE `DocumentShareableLinks` (
    `Id` char(36) COLLATE ascii_general_ci NOT NULL,
    `DocumentId` char(36) COLLATE ascii_general_ci NOT NULL,
    `LinkExpiryTime` datetime NULL,
    `Password` longtext CHARACTER SET utf8mb4 NULL,
    `LinkCode` longtext CHARACTER SET utf8mb4 NULL,
    `IsLinkExpired` tinyint(1) NOT NULL,
    `IsAllowDownload` tinyint(1) NOT NULL,
    `CreatedDate` datetime NOT NULL,
    `CreatedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `ModifiedDate` datetime NOT NULL,
    `ModifiedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `DeletedDate` datetime NULL,
    `DeletedBy` char(36) COLLATE ascii_general_ci NULL,
    `IsDeleted` tinyint(1) NOT NULL,
    CONSTRAINT `PK_DocumentShareableLinks` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_DocumentShareableLinks_Documents_DocumentId` FOREIGN KEY (`DocumentId`) REFERENCES `Documents` (`Id`) ON DELETE CASCADE
) CHARACTER SET=utf8mb4;

CREATE TABLE `DocumentStatuses` (
    `Id` char(36) COLLATE ascii_general_ci NOT NULL,
    `Name` longtext CHARACTER SET utf8mb4 NULL,
    `Description` longtext CHARACTER SET utf8mb4 NULL,
    `ColorCode` longtext CHARACTER SET utf8mb4 NULL,
    CONSTRAINT `PK_DocumentStatuses` PRIMARY KEY (`Id`)
) CHARACTER SET=utf8mb4;

CREATE TABLE `PageHelpers` (
    `Id` char(36) COLLATE ascii_general_ci NOT NULL,
    `Code` longtext CHARACTER SET utf8mb4 NULL,
    `Name` longtext CHARACTER SET utf8mb4 NULL,
    `Description` longtext CHARACTER SET utf8mb4 NULL,
    `CreatedDate` datetime NOT NULL,
    `CreatedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `ModifiedDate` datetime NOT NULL,
    `ModifiedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `DeletedDate` datetime NULL,
    `DeletedBy` char(36) COLLATE ascii_general_ci NULL,
    `IsDeleted` tinyint(1) NOT NULL,
    CONSTRAINT `PK_PageHelpers` PRIMARY KEY (`Id`)
) CHARACTER SET=utf8mb4;

CREATE TABLE `StorageSettings` (
    `Id` char(36) COLLATE ascii_general_ci NOT NULL,
    `Name` longtext CHARACTER SET utf8mb4 NULL,
    `JsonValue` longtext CHARACTER SET utf8mb4 NULL,
    `IsDefault` tinyint(1) NOT NULL,
    `EnableEncryption` tinyint(1) NOT NULL,
    `StorageType` int NOT NULL,
    `CreatedDate` datetime NOT NULL,
    `CreatedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `ModifiedDate` datetime NOT NULL,
    `ModifiedBy` char(36) COLLATE ascii_general_ci NOT NULL,
    `DeletedDate` datetime NULL,
    `DeletedBy` char(36) COLLATE ascii_general_ci NULL,
    `IsDeleted` tinyint(1) NOT NULL,
    CONSTRAINT `PK_StorageSettings` PRIMARY KEY (`Id`)
) CHARACTER SET=utf8mb4;

CREATE INDEX `IX_Documents_DocumentStatusId` ON `Documents` (`DocumentStatusId`);

CREATE INDEX `IX_Documents_StorageSettingId` ON `Documents` (`StorageSettingId`);

CREATE INDEX `IX_DocumentShareableLinks_DocumentId` ON `DocumentShareableLinks` (`DocumentId`);

ALTER TABLE `Documents` ADD CONSTRAINT `FK_Documents_DocumentStatuses_DocumentStatusId` FOREIGN KEY (`DocumentStatusId`) REFERENCES `DocumentStatuses` (`Id`);

ALTER TABLE `Documents` ADD CONSTRAINT `FK_Documents_StorageSettings_StorageSettingId` FOREIGN KEY (`StorageSettingId`) REFERENCES `StorageSettings` (`Id`);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20241009065257_Version_V31_MySql', '8.0.8');

COMMIT;

START TRANSACTION;

-- CompanyProfiles
INSERT `CompanyProfiles` (`Id`, `Name`, `LogoUrl`, `BannerUrl`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'5bf73f1d-4679-4901-b833-7963b2799f33', N'Document Mangement', N'log.png', N'banner.png', CAST(N'2024-10-01T12:39:07.6685564' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-01T12:39:07.6685565' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, NULL, 0);

-- StorageSettings
INSERT `StorageSettings` (`Id`, `Name`, `JsonValue`, `IsDefault`, `StorageType`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`, `EnableEncryption`) VALUES (N'06890479-e463-4f40-a9a0-080c03e3f7a4', N'Local Storage', NULL, 1, 2, CAST(N'2024-09-30T14:16:38.7395207' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-09-30T14:16:38.7395209' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, NULL, 0, 0);

-- Screens
INSERT `Screens` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `IsDeleted`, `OrderNo`) VALUES (N'FC1D752F-005B-4CAE-9303-B7557EEE7461', N'Storage Settings', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', 0,10);
INSERT `Screens` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `IsDeleted`, `OrderNo`) VALUES (N'669C82F1-0DE0-459C-B62A-83A9614259E4', N'Company Profile', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', 0,11);
INSERT `Screens` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `IsDeleted`, `OrderNo`) VALUES (N'4513EAE1-373A-4734-928C-8943C3F070BB', N'Document Status', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', 0,12);

INSERT `Screens` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `IsDeleted`, `OrderNo`) VALUES (N'73DF018E-77B1-42FB-B8D7-D7A09836E453', N'Page Helper', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', 0, 14);
INSERT `Screens` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `IsDeleted`, `OrderNo`) VALUES (N'42338E4F-05E0-48D1-862A-D977C39D02DF', N'Error Logs', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', 0, 15);

-- Operations
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `IsDeleted`) VALUES (N'64E4EC29-5280-4CED-A196-3B95D2FC5C68', N'Manage Storage Settings', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `IsDeleted`) VALUES (N'432B3A42-9FB5-48C1-A6FB-2ADF40B650D0', N'Manage Company Settings', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `IsDeleted`) VALUES (N'508DECA4-61DE-426F-AB1E-47A4A30DFD24', N'Manage Document Status', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `IsDeleted`) VALUES (N'F0BD06DA-4E1B-41BC-ABB0-AC833392C880', N'Create Shareable Link', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `IsDeleted`) VALUES (N'3CA8F8CD-0DEC-4079-A3EB-6F48D1788283', N'Add Comment', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `IsDeleted`) VALUES (N'4C9DBF32-7608-469A-BFFF-12DC83B00912', N'Delete Comment', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `IsDeleted`) VALUES (N'0AAAFAF0-CE63-4055-9204-DB4B03160CDE', N'Upload New version', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `IsDeleted`) VALUES (N'1E2453BD-A1CD-4E8F-B5B3-7C536CE7FED5', N'View version history', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `IsDeleted`) VALUES (N'E3EBB06C-1D2C-4FA8-A3E8-612ADA02D4AE', N'Restore version', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `IsDeleted`) VALUES (N'AD313C14-ABE8-4557-8989-CE6243BCD9CE', N'Manage Page Helper', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `IsDeleted`) VALUES (N'D2468BFC-15EB-4C80-8A3C-582C4811EC4D', N'View Error Logs', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', 0);


-- ScreenOperations
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'FC1D752F-005B-4CAE-9303-B7557EEE7461', N'64E4EC29-5280-4CED-A196-3B95D2FC5C68', N'FC1D752F-005B-4CAE-9303-B7557EEE7461', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'61C15E32-28A9-4DCE-8CDE-5CA8325F5F04', N'432B3A42-9FB5-48C1-A6FB-2ADF40B650D0', N'669C82F1-0DE0-459C-B62A-83A9614259E4', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'77B6DC42-AECE-4FDB-8203-06B61C2DDDB0', N'508DECA4-61DE-426F-AB1E-47A4A30DFD24', N'4513EAE1-373A-4734-928C-8943C3F070BB', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'70826821-6FEE-4BF2-A64D-49CD41E7823D', N'F0BD06DA-4E1B-41BC-ABB0-AC833392C880', N'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'6E52219E-0B7F-4E57-B7B3-DB688DE17AF0', N'F0BD06DA-4E1B-41BC-ABB0-AC833392C880', N'eddf9e8e-0c70-4cde-b5f9-117a879747d6', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'616254DE-2EA2-46E3-B7C3-4596D6180144', N'3CA8F8CD-0DEC-4079-A3EB-6F48D1788283', N'eddf9e8e-0c70-4cde-b5f9-117a879747d6', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'74BDCA6C-DDF5-49A6-9719-F364AB7BEE11', N'0AAAFAF0-CE63-4055-9204-DB4B03160CDE', N'eddf9e8e-0c70-4cde-b5f9-117a879747d6', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'63B2165E-CB49-4F10-B504-082F618B76F0', N'1E2453BD-A1CD-4E8F-B5B3-7C536CE7FED5', N'eddf9e8e-0c70-4cde-b5f9-117a879747d6', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'B0081952-68C8-4C89-83B1-3D5C97941C19', N'E3EBB06C-1D2C-4FA8-A3E8-612ADA02D4AE', N'eddf9e8e-0c70-4cde-b5f9-117a879747d6', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'B470AE88-E223-45DE-8720-3D4467A5F702', N'4C9DBF32-7608-469A-BFFF-12DC83B00912', N'eddf9e8e-0c70-4cde-b5f9-117a879747d6', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'197C97B0-BD33-4E2E-8C1E-BCCFD1C65FBD', N'4C9DBF32-7608-469A-BFFF-12DC83B00912', N'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'01CE3C47-67A7-4FAE-821A-494BFF0D46EF', N'3CA8F8CD-0DEC-4079-A3EB-6F48D1788283', N'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'DF81DECD-4282-4873-9606-AB353FCC4523', N'3da78b4d-d263-4b13-8e81-7aa164a3688c', N'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'A2148F30-0A60-420E-992A-C93B4B297DF8', N'1E2453BD-A1CD-4E8F-B5B3-7C536CE7FED5', N'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'2A9169A8-A46E-4D61-94FC-AA8A9ADC459A', N'AD313C14-ABE8-4557-8989-CE6243BCD9CE', N'73DF018E-77B1-42FB-B8D7-D7A09836E453', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'D21077FE-3441-4AD2-BD22-BD13233EE5B2', N'D2468BFC-15EB-4C80-8A3C-582C4811EC4D', N'42338E4F-05E0-48D1-862A-D977C39D02DF', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', CAST(N'2024-10-22T16:18:01.0788250' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, N'00000000-0000-0000-0000-000000000000', 0);

-- RoleClaims
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'4C9DBF32-7608-469A-BFFF-12DC83B00912', N'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Assigned_Documents_Delete_Comment', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'3CA8F8CD-0DEC-4079-A3EB-6F48D1788283', N'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Assigned_Documents_Add_Comment', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'3da78b4d-d263-4b13-8e81-7aa164a3688c', N'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Assigned_Documents_Add_Reminder', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'1E2453BD-A1CD-4E8F-B5B3-7C536CE7FED5', N'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Assigned_Documents_View_version_history', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'F0BD06DA-4E1B-41BC-ABB0-AC833392C880', N'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Assigned_Documents_Create_Shareable_Link', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'4C9DBF32-7608-469A-BFFF-12DC83B00912', N'eddf9e8e-0c70-4cde-b5f9-117a879747d6', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Assigned_Documents_Create_Delete_Comment', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'E3EBB06C-1D2C-4FA8-A3E8-612ADA02D4AE', N'eddf9e8e-0c70-4cde-b5f9-117a879747d6', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Assigned_Documents_Create_Restore_version', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'3CA8F8CD-0DEC-4079-A3EB-6F48D1788283', N'eddf9e8e-0c70-4cde-b5f9-117a879747d6', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Assigned_Documents_Create_Add_Comment', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'1E2453BD-A1CD-4E8F-B5B3-7C536CE7FED5', N'eddf9e8e-0c70-4cde-b5f9-117a879747d6', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Assigned_Documents_View_version_history', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'F0BD06DA-4E1B-41BC-ABB0-AC833392C880', N'eddf9e8e-0c70-4cde-b5f9-117a879747d6', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Assigned_Documents_Create_Shareable_Link', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'0AAAFAF0-CE63-4055-9204-DB4B03160CDE', N'eddf9e8e-0c70-4cde-b5f9-117a879747d6', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Assigned_Documents_Upload_New_version', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'508DECA4-61DE-426F-AB1E-47A4A30DFD24', N'4513EAE1-373A-4734-928C-8943C3F070BB', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Document_Status_Manage_Document_Status', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'64E4EC29-5280-4CED-A196-3B95D2FC5C68', N'FC1D752F-005B-4CAE-9303-B7557EEE7461', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Storage_Settings_Manage_Storage_Settings', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'432B3A42-9FB5-48C1-A6FB-2ADF40B650D0', N'669C82F1-0DE0-459C-B62A-83A9614259E4', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Company_Profile_Manage_Company_Settings', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'AD313C14-ABE8-4557-8989-CE6243BCD9CE', N'73DF018E-77B1-42FB-B8D7-D7A09836E453', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Page_Helper_Manage_Page_Helper', N'');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) VALUES (N'D2468BFC-15EB-4C80-8A3C-582C4811EC4D', N'42338E4F-05E0-48D1-862A-D977C39D02DF', N'fedeac7a-a665-40a4-af02-f47ec4b7aff5', N'Error_Logs_View_Error_Logs', N'');

-- Screen Order
Update Screens set OrderNo = 1 where name = 'Dashboard';
Update Screens set OrderNo = 2 where name = 'Assigned Documents';
Update Screens set OrderNo = 3 where name = 'All Documents';
Update Screens set OrderNo = 4 where name = 'Document Status';
Update Screens set OrderNo = 5 where name = 'Document Category';
Update Screens set OrderNo = 6 where name = 'Document Audit Trail';
Update Screens set OrderNo = 7 where name = 'Role';
Update Screens set OrderNo = 8 where name = 'User';
Update Screens set OrderNo = 9 where name = 'Reminder';
Update Screens set OrderNo = 10 where name = 'Storage Settings';
Update Screens set OrderNo = 11 where name = 'Company Profile';
Update Screens set OrderNo = 12 where name = 'Email';
Update Screens set OrderNo = 13 where name = 'Login Audit';

-- PageHelpers
INSERT `PageHelpers` (`Id`, `Code`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'8fd8c3c6-ac6e-45d8-9757-00300fc9ca8f', N'DOCUMENT_STATUS', N'Document Status', N'<p>Users can add, edit, and view a list of document statuses. Each status includes three customizable fields: name, description, and a unique colour code for easy identification and organization of documents.</p><h4><strong>Main Components:</strong></h4><p><strong>"Add New Document Status" Button:</strong></p><p>Allows administrators or users with appropriate permissions to create a new status.</p><ul><li><strong>List of Existing Statuses:</strong></li><li>Displays all the Statuses created within the system.</li><li>Each entry includes the status name, description and unique colour code for easy identification and organization of documents.</li><li><strong>Action Menu for Each Status:</strong></li><li>Next to each status, users will find action options that allow them to manage the Category:<ul><li><strong>Edit:</strong> Enables modification of the status''s details, such as the name or description, and unique colour code .</li><li><strong>Delete:</strong> Removes the status from the system. This action may require confirmation to prevent accidental deletions.</li></ul></li></ul>', CAST(N'2023-06-03T05:22:43.7270890' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2024-10-05T07:18:42.0522139' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', NULL, NULL, 0);
INSERT `PageHelpers` (`Id`, `Code`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'eccba93d-48bb-48f6-9784-14968d8843c8', N'MANAGE_USER', N'Manage User', N'<p>The User Information page is designed to collect and manage your personal details. This page is essential for setting up your user profile and ensuring you have a seamless experience using our application. Below is a brief overview of the fields you willl encounter:</p><h4><strong>Fields on the User Information Page</strong></h4><ol><li><strong>First Name</strong>:<ul><li><strong>What it is</strong>: Your given name.</li><li><strong>Importance</strong>: Helps us address you properly within the application.</li></ul></li><li><strong>Last Name</strong>:<ul><li><strong>What it is</strong>: Your family name or surname.</li><li><strong>Importance</strong>: Completes your identity and is often required for official documents.</li></ul></li><li><strong>Mobile Number</strong>:<ul><li><strong>What it is</strong>: Your phone number.</li><li><strong>Importance</strong>: Used for account recovery, notifications, and two-factor authentication. It’s optional but recommended for security purposes.</li></ul></li><li><strong>Email Address</strong>:<ul><li><strong>What it is</strong>: Your electronic mail address.</li><li><strong>Importance</strong>: Serves as your primary communication channel with us. It’s required for account verification, notifications, and password recovery.</li></ul></li><li><strong>Password</strong>:<ul><li><strong>What it is</strong>: A secret word or phrase you create to secure your account.</li><li><strong>Importance</strong>: Protects your account from unauthorized access. It must be at least 6 characters long.</li></ul></li><li><strong>Confirm Password</strong>:<ul><li><strong>What it is</strong>: A second entry of your chosen password.</li><li><strong>Importance</strong>: Ensures you’ve entered your password correctly.</li></ul></li><li><strong>Role</strong>:<ul><li><strong>What it is</strong>: Your assigned position or function within the application (e.g., Admin, User, Editor).</li><li><strong>Importance</strong>: Determines your access level and permissions within the application. This field is required to define your responsibilities and capabilities.</li></ul></li></ol><h4><strong>How to Use the Page</strong></h4><ul><li><strong>Filling Out the Form</strong>:<ul><li>Enter your information in the required fields.</li><li>Ensure that your password and confirm password entries match to avoid any errors.</li></ul></li><li><strong>Submitting Your Information</strong>:<ul><li>Once you have filled in all required fields, click the "Submit" button.</li><li>If any required fields are left blank or contain errors, you willl see helpful messages prompting you to correct them.</li></ul></li><li><strong>Visual Feedback</strong>:<ul><li>Fields that require your attention will be highlighted, and error messages will guide you in making the necessary corrections.</li></ul></li></ul>', CAST(N'2023-06-03T05:22:22.0000000' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'0001-01-01T00:00:00.0000000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, NULL, 0);
INSERT `PageHelpers` (`Id`, `Code`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'a1c28412-9590-4cdb-b7a0-1687e890ad5d', N'ADD_REMINDER', N'Add reminder', N'<p><strong>The "Add Reminder" functionality in the "Manage Reminders" section allows users to create reminders or notifications related to specific events or tasks. These reminders can be customized according to the user''s needs and can be sent to specific other users.</strong></p><p><strong>Components and Features:</strong></p><ul><li><strong>Subject:</strong> This field allows the user to enter a title or theme for the reminder. This will be the main subject of the notification.</li><li><strong>Message:</strong> Here, users can add additional details or information related to the reminder. This can be a descriptive message or specific instructions.</li><li><strong>Repeat Reminder:</strong> This option allows setting the frequency with which the reminder will be repeated, such as daily, weekly, or monthly.</li><li><strong>Send Email:</strong> If this option is enabled, the reminder will also be sent as an email to the selected users.</li><li><strong>Select Users:</strong> This field allows the selection of users to whom the reminder will be sent. Users can be selected individually or in groups.</li><li><strong>Reminder Date:</strong> This is the time at which the reminder will be activated and sent to the selected users.</li></ul><p><strong>How to Add a New Reminder:</strong></p><ul><li>; to the "Manage Reminders" section.</li><li>Click the "Add Reminder" button.</li><li>Fill in all required fields with the desired information.</li><li>After entering all the details, click "Save" or "Confirm" to add the reminder to the system.</li></ul>', CAST(N'2023-06-03T05:09:44.0000000' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2024-10-05T05:17:00.0249145' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', NULL, NULL, 0);
INSERT `PageHelpers` (`Id`, `Code`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'2b728c10-c0b3-451e-8d08-2be1e3f6d5b3', N'USERS', N'Users', N'<p><strong>The "Users" page is the central hub for managing all registered users in CMR DMS. Here, administrators can add, edit, or delete users, as well as manage permissions and reset passwords. Each user has associated details such as first name, last name, mobile phone number, and email address.</strong></p><p><strong>Main Components:</strong></p><ul><li><p><strong>"Add User" Button:</strong> Allows administrators to create a new user in the system.</p><p>Opens a form where details such as first name, last name, mobile phone number, email address, password, and password confirmation can be entered.</p></li><li><p><strong>List of Existing Users:</strong> Displays all registered users in the system in a tabular format.</p><p>Each entry includes the user’s email address, first name, last name, and mobile phone number.</p><p>Next to each user, there is an action menu represented by three vertical dots.</p></li><li><p><strong>Action Menu for Each User:</strong> This menu opens by clicking on the three vertical dots next to each user.</p><p>Includes the options:</p><ul><li><strong>Edit:</strong> Allows modification of the user’s details.</li><li><strong>Delete:</strong> Removes the user from the system. This action may require confirmation to prevent accidental deletions.</li><li><strong>Permissions:</strong> Opens a window or form where administrators can set or modify the user’s permissions.</li><li><strong>Reset Password:</strong> Allows administrators to initiate a password reset process for the selected user.</li></ul></li></ul><p><strong>How to Add a New User:</strong></p><ol><li>Click on the "Add User" button.</li><li>A form will open where you can enter the user’s details: first name, last name, mobile phone number, email address, password, and password confirmation.</li><li>After completing the details, click "Save" or "Add" to add the user to the system.</li></ol>', CAST(N'2023-06-03T05:21:00.0000000' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2024-10-04T14:17:56.5874730' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', NULL, NULL, 0);
INSERT `PageHelpers` (`Id`, `Code`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'f5cecacd-f0e6-45b3-8de2-348d8ec29556', N'LOGIN_AUDIT_LOGS', N'Audit logs', N'<p><strong>The "Login Audit Logs" page serves as a centralized record for all authentication activities within CMR DMS. Here, administrators can monitor and review all login attempts, successful or failed, made by users. This provides a clear perspective on system security and user activities.</strong></p><p><strong>Main Components:</strong></p><ul><li><p><strong>Authentication Logs Table:</strong> Displays all login entries in a tabular format.</p><p>Each entry includes details such as the username, login date and time, the IP address from which the login was made, and the result (success/failure).</p></li></ul><p><strong>How to View Log Entries:</strong></p><ol><li>Navigate to the "Login Audit Logs" page.</li><li>Browse through the table to view all login entries.</li><li>Use the search or filter function, if available, to find specific entries.</li></ol>', CAST(N'2023-06-03T05:25:13.0000000' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2024-10-04T14:20:41.4415623' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', NULL, NULL, 0);
INSERT `PageHelpers` (`Id`, `Code`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'5d15d912-674b-47af-ade8-35013e4c95c4', N'DOCUMENT_COMMENTS', N'Comments', N'<ul><li><strong>Allows users to add comments to the document.</strong></li><li>Other users can view and respond to comments, facilitating discussion and collaboration on the document.</li></ul>', CAST(N'2023-06-03T05:14:57.0000000' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2024-10-04T14:21:21.7475706' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', NULL, NULL, 0);
INSERT `PageHelpers` (`Id`, `Code`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'ab28cf5c-0d89-4a52-a87b-359106897cba', N'MANAGE_EMAIL_SMTP_SETTING', N'Manage Email SMTP Setting', N'<p>The <strong>"Email SMTP Settings"</strong> page within CMR DMS allows administrators to configure and manage the SMTP settings for sending emails. This ensures that emails sent from the system are correctly and efficiently delivered to recipients.</p><p><strong>Key Components:</strong></p><ul><li><p><strong>SMTP Settings Table:</strong> Displays all configured SMTP settings in a tabular format.</p><p>Each entry in the table includes details such as the username, host, port, and whether that configuration is set as the default.</p></li><li><p><strong>"Add Settings" Button:</strong> Allows administrators to add a new SMTP configuration.</p><p>Clicking the button opens a form where details like username, host, port, and the option to set it as the default configuration can be entered.</p></li></ul><p><strong>"Add Settings" Form:</strong></p><p>This form opens when administrators click the "Add Settings" button and includes the following fields:</p><ul><li><strong>Username:</strong> The username required for authentication on the SMTP server.</li><li><strong>Host:</strong> The SMTP server address.</li><li><strong>Port:</strong> The port on which the SMTP server listens.</li><li><strong>Is Default:</strong> A checkbox that allows setting this configuration as the default for sending emails.</li></ul><p><strong>How to Add a New SMTP Configuration:</strong></p><ol><li>Click the "Add Settings" button.</li><li>The "Add Settings" form will open, where you can enter the SMTP configuration details.</li><li>Fill in the necessary fields and select the desired options.</li><li>After completing the details, click "Save" or "Add" to add the configuration to the system.</li></ol>', CAST(N'2023-06-03T05:27:13.0000000' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'0001-01-01T00:00:00.0000000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, NULL, 0);
INSERT `PageHelpers` (`Id`, `Code`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'8c1e5b05-0d7e-45cc-973d-423b2e10c5fd', N'SHARE_DOCUMENT', N'Share Document', N'<h4>Overview</h4><p>The <strong>Share Document</strong> feature allows users to assign access permissions to specific documents for individual users or user roles, with the ability to manage these permissions effectively. Users can also remove existing permissions, enhancing collaboration and control over document access.</p><h4>Features</h4><ol><li><strong>Assign By Users and Assign By Roles</strong><ul><li><strong>Buttons:</strong><ul><li>Two separate buttons are available at the Top of the share document section:<ul><li><strong>Assign By Users:</strong> Opens a dialog for selecting individual users to share the document with.</li><li><strong>Assign By Roles:</strong> Opens a dialog for selecting user roles to share the document with.</li></ul></li></ul></li><li><strong>User/Roles List:</strong><ul><li>Below the buttons, a list displays users or roles who currently have document permissions, including details such as:</li><li>Delete Button( Allow to delete existing permission to user or role)<ul><li>User/Role Name</li><li>Type (User/Role)</li><li>Allow Download(if applicable)</li><li>Email(if applicable)</li><li>Start Date (if applicable)</li><li>End Date (if applicable)</li><li> </li><li><strong>Delete Button:</strong> A delete button next to each user/role in the list, allowing for easy removal of permissions.</li></ul></li></ul></li></ul></li><li><strong>Dialog for Selection</strong><ul><li><strong>Dialog Features:</strong><ul><li>Upon clicking either <strong>Assign By Users</strong> or <strong>Assign By Roles</strong>, a dialog opens with the following features:<ul><li><strong>User/Role Selection:</strong><ul><li>A multi-select dropdown list allows users to select multiple users or roles for sharing the document.</li></ul></li><li><strong>Additional Options:</strong><ul><li><strong>Share Duration:</strong> Users can specify a time period for which the document will be accessible (e.g., start date and end date). </li><li><strong>Allow Download:</strong> A checkbox option that allows users to enable or disable downloading of the document.</li><li><strong>Allow Email Notification:</strong>A checkbox option that, when checked, sends an email notification to the selected users/roles.<ul><li>If this option is selected, SMTP configuration must be set up in the application. If SMTP is not configured, an error message will display informing the user of the missing configuration.</li></ul></li></ul></li></ul></li></ul></li></ul></li><li><strong>Saving Shared Document Permissions</strong><ul><li><strong>Save Button:</strong><ul><li>A <strong>Save</strong> button within the dialog allows users to save the selected permissions.</li></ul></li><li><strong>Reflection of Changes:</strong><ul><li>Upon saving, the data is updated, and the list at the bottom of the main interface reflects the newly shared document permissions, showing:<ul><li>User/Role Name</li><li>Type (User/Role)</li><li>Allow Download(if applicable)</li><li>Email(if applicable)</li><li>Start Date (if applicable)</li><li>End Date (if applicable)</li><li>Whether download and email notification options are enabled</li></ul></li></ul></li></ul></li><li><strong>Removing Shared Permissions</strong><ul><li><strong>Delete Button Functionality:</strong><ul><li>Users can click the <strong>Delete</strong> button next to any user or role in the existing shared permissions list.</li><li><strong>Confirmation Dialog:</strong> A confirmation prompt appears to ensure that users intend to remove the selected permission. Users must confirm the action to proceed.</li></ul></li><li><strong>Updating the List:</strong><ul><li>Once confirmed, the shared permission for the selected user or role is removed from the list, and the list updates immediately to reflect this change.</li></ul></li></ul></li><li><strong>User Interaction Flow</strong><ul><li><strong>Navigating to Share Document:</strong><ul><li>Users access the <strong>Share Document</strong> section within the application.</li></ul></li><li><strong>Assigning Permissions:</strong><ul><li>Users click on <strong>Assign By Users</strong> or <strong>Assign By Roles</strong> to open the respective dialog.</li><li>They select the appropriate users or roles, configure additional options, and click <strong>Save</strong>.</li></ul></li><li><strong>Removing Permissions:</strong><ul><li>Users can remove permissions by clicking the <strong>Delete</strong> button next to an entry in the shared permissions list and confirming the action.</li></ul></li><li><strong>Reviewing Shared Permissions:</strong><ul><li>The updated list displays the current permissions, allowing users to verify and manage document sharing effectively.</li></ul></li></ul></li></ol><h3>Summary</h3><p>The <strong>Share Document</strong> functionality provides a structured interface for assigning and managing document permissions to individual users or roles, with added flexibility to remove existing permissions. This feature enhances document collaboration and control while ensuring users can efficiently manage access. The inclusion of SMTP configuration checks for email notifications adds robustness to the communication aspect of the document-sharing process.</p>', CAST(N'2023-06-03T05:22:43.7270890' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2024-10-05T09:44:36.7243227' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', NULL, NULL, 0);
INSERT `PageHelpers` (`Id`, `Code`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'f6a1faa6-7245-4f9f-ad17-5478677bedfb', N'DOCUMENTS_BY_CATEGORY', N'Documents by Category', N'<p>The <strong>Homepage</strong> provides an overview of the documents within the system, showcasing statistics related to the number of documents organized by Category. It is the ideal place to quickly obtain a clear view of the volume and distribution of documents in the DMS.</p><h3>Main Components:</h3><ol><li><strong>Document Statistics</strong>:<ul><li>Displays a numerical summary of all the documents in the system, organized by Category.</li><li>Each Category is accompanied by a number indicating how many documents are in that Category.</li></ul></li><li><strong>"Document Categories" List</strong>:<ul><li>Shows the different document Categories available in the system, such as:<ul><li>"Professional-Scientific_and_Education"</li><li>"HR Policies 2021"</li><li>"Professional1"</li><li>"Initial Complaint"</li><li>"HR Policies 2020"</li><li>"Studies_and_Strategies"</li><li>"Administrative_and_Financial"</li><li>"Approvals"</li><li>"Jurisdiction Commission"</li></ul></li><li>Next to each Category, the number of documents is displayed, providing a clear view of the document distribution across Categories.</li></ul></li></ol><h3>How to interpret the statistics:</h3><ol><li>Navigate to the <strong>Statistics</strong> section on the <strong>Homepage</strong>.</li><li>View the total number of documents for each Category.<ul><li>These numbers give you an idea of the volume of documents in each Category and help identify which Categories have the most or fewest documents.</li></ul></li></ol>', CAST(N'2023-06-02T17:29:40.0000000' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2024-10-05T04:44:20.2555490' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', NULL, NULL, 0);
INSERT `PageHelpers` (`Id`, `Code`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'5d7ba1b1-a380-4e4d-8cb0-56159a6ee0d3', N'ASSIGNED_DOCUMENTS', N'Assigned documents', N'<p>The <strong>"Assigned Documents"</strong> page is the central hub for managing documents allocated to a specific user. Here, users can view all the documents assigned to them, search for specific documents, and perform various actions on each document.</p><h3>Main Components:</h3><ul><li><strong>"Add Document" Button</strong>: Allows users to upload a new document to the system.<ul><li>Opens a form or pop-up window where files can be selected and uploaded.</li></ul></li><li><strong>My Reminders</strong>: Displays a list of all the reminders set by the user.<ul><li>Users can view, edit, or delete reminders.</li></ul></li><li><strong>Search Box (by name or document)</strong>: Allows users to search for a specific document by entering its name or other document details.</li><li><strong>Search Box (by meta tags)</strong>: Users can enter meta tags to filter and search for specific documents.</li><li><strong>Category Selection Dropdown</strong>: A dropdown menu that allows users to filter documents based on their Category.</li><li><strong>Status Selection Dropdown</strong>: A dropdown menu that allows users to filter documents based on their status.</li><li><strong>List of files allocated to the user</strong>: Displays the documents assigned to the user in allocation order.<ul><li>Each entry includes columns for "Action," "Name," "Status," "Category Name," "Creation Date," "Expiration Date," and "Created By."</li></ul></li><li>Next to each document, there is a menu with options such as "edit," "share," "view," "upload a version," "version history," "comment," and "add reminder."</li></ul><h3>How to Add a New Document:</h3><ol><li>Click the <strong>"Add Document"</strong> button.</li><li>A form or pop-up window will open.</li><li>Select and upload the desired file, then fill in the necessary details.</li><li>Click <strong>"Save"</strong> or <strong>"Add"</strong> to upload the document to the system.</li></ol><h3>How to Search for a Document:</h3><ol><li>Enter the document''s name or details in the appropriate search box.</li><li>The search results will be displayed in the document list.</li></ol><h3>How to Perform Actions on a Document:</h3><p><strong>Document Action Menu Overview</strong>:<br>The action menu offers users various options for managing and interacting with the assigned documents. Each action is designed to provide specific functionalities, allowing users to work efficiently with their documents.</p><h4>Available Options:</h4><ul><li><strong>Edit</strong>: Allows users to modify the document''s details, such as its name, description, or meta tags.<ul><li>After making changes, users can save the updates.</li></ul></li><li><strong>Share</strong>: Provides the option to share the document with other users or roles in the system.<ul><li>Users can set specific permissions, such as view or edit, for those with whom the document is shared.</li></ul></li><li><strong>View</strong>: Opens the document in a new window or an embedded viewer, allowing users to view the document''s content without downloading it.</li><li><strong>Upload a Version</strong>: Allows users to upload an updated version of the document.<ul><li>The original document remains in the system, and the new version is added as an update.</li></ul></li><li><strong>Version History</strong>: Displays all previous versions of the document.<ul><li>Users can view, or download any of the previous versions if the administrator allows the user to download document permission.</li></ul></li><li><strong>Comment</strong>: Allows users to add comments to the document.<ul><li>Other users can view and respond to comments, facilitating discussion and collaboration on the document.</li></ul></li><li><strong>Add Reminder</strong>: Sets a reminder for an event or action related to the document.<ul><li>Users can receive notifications or emails when the reminder date approaches.</li></ul></li></ul>', CAST(N'2023-06-02T17:32:19.0000000' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2024-10-05T06:58:47.4846831' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', NULL, NULL, 0);
INSERT `PageHelpers` (`Id`, `Code`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'5d858491-f9db-4aef-959f-5af9d7f3b7bd', N'MANAGE_ROLE', N'Manage Role', N'<ul><li>Allows administrators or users with appropriate permissions to create a new role in the system.</li><li>Opens a form or a pop-up window where permissions and role details can be defined.</li><li>Enter the role name and select the appropriate permissions from the available list.</li><li>Click <strong>"Save"</strong> or <strong>"Add"</strong> to add the role to the system with the specified permissions.</li></ul><p> </p><p><br> </p>', CAST(N'2023-06-03T05:20:37.0000000' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2024-10-04T14:25:11.9869322' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', NULL, NULL, 0);
INSERT `PageHelpers` (`Id`, `Code`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'ec6b2368-b8fd-4101-addf-5dec7c1d1c63', N'SHAREABLE_LINK', N'Shareable Link', N'<ul><li><strong>Shareable Link</strong>:<br>This feature allows users to share documents with anonymous users through a customizable link. Users have the flexibility to configure various options when creating a shareable link, including:<ul><li><strong>Start and Expiry Dates</strong>: Specify the validity period for the link, defining when it becomes active and when it expires.</li><li><strong>Password Protection</strong>: Optionally set a password to restrict access to the shared document.</li><li><strong>Download Permission</strong>: Choose whether recipients are allowed to download the document.</li></ul></li></ul><p>All options are optional, allowing users to customize the shareable link according to their preferences and requirements.</p>', CAST(N'2023-06-03T05:22:43.7270890' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2024-10-05T09:52:30.0027792' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', NULL, NULL, 0);
INSERT `PageHelpers` (`Id`, `Code`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'2dd28c72-3ed4-4f75-b23b-63cadcaa3982', N'ALL_DOCUMENTS', N'All Documents', N'<p>The <strong>"All Documents"</strong> page provides a complete overview of all documents uploaded in the DMS. It is the ideal place to search, view, manage, and distribute all available documents in the system.</p><p><strong>Main Components:</strong></p><ul><li><strong>"Add Document" Button:</strong> Allows any user with appropriate permissions to upload a new document into the system.<ul><li>Opens a form or a pop-up window where files can be selected and uploaded.</li></ul></li><li><strong>Search Box (by name):</strong> Allows users to search for a specific document by entering its name or other details.</li><li><strong>Search Box (by meta tags):</strong> Users can enter Meta tags to filter and search for specific documents.</li><li><strong>Category Dropdown:</strong> A dropdown menu that allows users to filter documents by Category.</li><li><strong>Status Dropdown:</strong>  There is an option users to store A dropdown menu that allows users to filter documents by Status.</li><li><strong>Storage Dropdown: </strong>The application lets users store documents in various storage options, such as AWS S3, Cloudflare R2, and local storage. Users can easily search for documents by selecting the desired storage option from a dropdown menu.</li><li><strong>Search Box (by creation date):</strong> Allows users to search for documents based on their creation date.</li><li><strong>List of All Uploaded Files:</strong> Displays all documents available in the system.<ul><li>Each entry includes document details such as name, creation date, Category, status and storage.</li></ul></li><li><strong>Document Actions Menu:</strong> Alongside each document in the list, users will find an actions menu allowing them to perform various operations on the document:<ul><li><strong>Edit:</strong> Modify the document details, such as its name or description.</li><li><strong>Share:</strong> Share the document with other users or roles within the system.</li><li><strong>Get Shareable Link:</strong> Users can generate a shareable link to allow anonymous users to access documents. They can also protect the link with a password and set an expiration period, ensuring the link remains active only for the selected duration. Additionally, the link includes an option for recipients to download the shared document.</li><li><strong>View:</strong> Open the document for viewing.</li><li><strong>Upload a New Version:</strong> Add a new version of the document.</li><li><strong>Version History:</strong> Users can view all previous versions of a document, with the ability to restore any earlier version as needed. Each version can also be downloaded for offline access or review.</li><li><strong>Comment:</strong> Add or view comments on the document.</li><li><strong>Add Reminder:</strong> Set a reminder for the document.</li><li><strong>Send as Email:</strong> Send the document as an attachment via email.</li><li><strong>Delete:</strong> Remove the document from the system.</li></ul></li></ul><p><strong>Document Sharing:</strong></p><p>Users can select one, multiple, or all documents from the list and use the sharing option to distribute the selected documents to other users. This feature facilitates the mass distribution of documents to specific users or groups.</p>', CAST(N'2023-06-03T05:12:00.0000000' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2024-10-05T06:52:17.9880511' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', NULL, NULL, 0);
INSERT `PageHelpers` (`Id`, `Code`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'fac3d38a-5267-4b09-aea2-6682256ba777', N'ERROR_LOGS', N'Error Logs', N'<h4>Overview</h4><p>The <strong>ERROR_LOGS</strong> feature allows users to view the application logs generated by the backend REST API. This functionality is essential for monitoring application performance, diagnosing issues, and troubleshooting errors that may arise during API interactions.</p><h4>Features</h4><ol><li><strong>Accessing Error Logs</strong><ul><li><strong>Navigation:</strong><ul><li>Users can access the <strong>ERROR_LOGS</strong> section through the application’s administration panel or settings menu.</li></ul></li><li><strong>User Permissions:</strong><ul><li>Access to error logs may be restricted to users with specific roles, such as administrators or support staff, to maintain security and data integrity.</li></ul></li></ul></li><li><strong>Viewing Logs</strong><ul><li><strong>Log List:</strong><ul><li>The error logs are displayed in a list format, showing relevant details for each entry, including:<ul><li><strong>Timestamp:</strong> The date and time when the error occurred.</li><li><strong>Error Code:</strong> A unique code associated with the error.</li><li><strong>Error Message:</strong> A brief description of the error.</li><li><strong>Endpoint:</strong> The API endpoint that triggered the error.</li><li><strong>Request Data:</strong> The payload or parameters sent with the request (if applicable).</li><li><strong>Response Data:</strong> The response returned from the server (if applicable).</li></ul></li></ul></li><li><strong>Pagination:</strong><ul><li>Logs can be paginated to avoid overwhelming users with too much information at once, allowing users to navigate through entries easily.</li></ul></li></ul></li><li><strong>Filtering and Searching</strong><ul><li><strong>Filter Options:</strong><ul><li>Users can filter logs by various criteria, such as date range, error code, or specific endpoints, to quickly locate relevant entries.</li></ul></li><li><strong>Search Functionality:</strong><ul><li>A search bar allows users to enter keywords or phrases to find specific logs, improving the efficiency of troubleshooting.</li></ul></li></ul></li><li><strong>Log Details</strong><ul><li><strong>Expand/Collapse Feature:</strong><ul><li>Users can click on a log entry to expand and view additional details, such as:<ul><li>Full error stack trace (if available).</li><li>Contextual information regarding the request and server response.</li></ul></li></ul></li><li><strong>Export Option:</strong><ul><li>Users can export the logs in various formats (e.g., CSV, JSON) for offline analysis or reporting purposes.</li></ul></li></ul></li><li><strong>User Interaction Flow</strong><ul><li><strong>Navigating to Error Logs:</strong><ul><li>Users select the <strong>ERROR_LOGS</strong> option from the administration panel to access the log list.</li></ul></li><li><strong>Viewing and Filtering Logs:</strong><ul><li>Users can apply filters and search for specific logs to identify issues effectively.</li></ul></li><li><strong>Exploring Log Details:</strong><ul><li>Users can expand log entries to review detailed error information and troubleshoot accordingly.</li></ul></li></ul></li></ol><h3>Summary</h3><p>The <strong>ERROR_LOGS</strong> functionality provides a robust interface for users to view and manage application logs related to the backend REST API. With features such as filtering, searching, and detailed log views, users can effectively monitor application performance, diagnose errors, and troubleshoot issues, ensuring a smoother user experience and improved application reliability.</p>', CAST(N'2023-06-03T05:22:43.7270890' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2024-10-05T09:14:40.3391298' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', NULL, NULL, 0);
INSERT `PageHelpers` (`Id`, `Code`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'd6e392a9-b180-4c68-8566-6f289150a226', N'ADD_DOCUMENT', N'Manage document', N'<ul><li><strong>Allows users to upload and add a new document to the system.</strong></li><li>It includes the following fields:</li><li><strong>Upload Document:</strong> An option to upload the document file.</li><li><strong>Category:</strong> The Category under which the document is classified.</li><li><strong>Name:</strong> The name of the document.</li><li><strong>Status:</strong> The status of the document (e.g., confidential or public).</li><li><strong>Description:</strong> A detailed description or additional notes related to the document.</li><li><strong>Meta Tags:</strong> Tags or keywords associated with the document for easier searching.</li></ul>', CAST(N'2023-06-02T17:33:42.0000000' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2024-10-05T09:19:10.4910558' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', NULL, NULL, 0);
INSERT `PageHelpers` (`Id`, `Code`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'b99e45c1-9d9f-4b0e-80f0-906c7c830394', N'STORAGE_SETTINGS', N'Storage Settings', N'<p><strong>Document Storage Settings</strong>:<br>Users can configure various storage options, including AWS S3 and Cloudflare R2, with specific fields required for each storage type. Additionally, there is a default option available for storing files on a local server. This local server setting cannot be deleted, ensuring a reliable and consistent storage option for users.</p><ol><li><strong>Enable Encryption</strong>: When selected, this option ensures that files are stored in encrypted form within the chosen storage.</li><li><strong>Set as Default</strong>: If this option is set to "true," the storage becomes the default selection in the dropdown on the document add page.</li></ol><p>Upon saving the storage settings, the system attempts to upload a dummy file to verify the configuration. If the upload is successful, the settings are saved; otherwise, an error message prompts the user to adjust the field values.</p><ul><li><h4><strong>Add a new Storage Setting to the system.</strong></h4></li><li><strong>It includes the following fields:</strong></li><li><strong>Storage Type: </strong>AWS/CloudFlare-R2</li><li><strong>Access Key:</strong></li><li><strong>Secret Key:</strong></li><li><strong>Bucket Name:</strong></li><li><strong>Account ID: </strong>Required for CloudFlare-R2 Storage Type</li><li><strong>Enable Encryption: </strong>When selected, this option ensures that files are stored in encrypted form within the chosen storage.</li><li><strong>Is Default:</strong>  If this option is set to "true," the storage becomes the default selection in the dropdown on the document add page.</li><li> </li><li><h4><strong>Edit Storage Setting to the system.</strong></h4></li><li>Users can edit existing storage settings from the storage settings list, which includes an edit button on the left side of each row. When the edit button is clicked, the row opens in edit mode, allowing users to modify the following fields: name, "Is Default," and "Enable Encryption." This provides users with the flexibility to update their storage configurations as needed.</li></ul><h4>CREATE AWS S3 ACCOUNT:</h4><p><a href="https://aws.amazon.com/free/?gclid=CjwKCAjwx4O4BhAnEiwA42SbVPBXf7hpN07vHx4ObiZX3xFHpgCLP9mHQ4P1CaykaQkJKT53F2EQFhoCWRkQAvD_BwE&trk=b8b87cd7-09b8-4229-a529-91943319b8f5&sc_channel=ps&ef_id=CjwKCAjwx4O4BhAnEiwA42SbVPBXf7hpN07vHx4ObiZX3xFHpgCLP9mHQ4P1CaykaQkJKT53F2EQFhoCWRkQAvD_BwE:G:s&s_kwcid=AL!4422!3!536324516040!e!!g!!aws%20s3%20account!11539706604!115473954714&all-free-tier.sort-by=item.additionalFields.SortRank&all-free-tier.sort-order=asc&awsf.Free%20Tier%20Types=*all&awsf.Free%20Tier%20Categories=*all">https://aws.amazon.com/free/?gclid=CjwKCAjwx4O4BhAnEiwA42SbVPBXf7hpN07vHx4ObiZX3xFHpgCLP9mHQ4P1CaykaQkJKT53F2EQFhoCWRkQAvD_BwE&trk=b8b87cd7-09b8-4229-a529-91943319b8f5&sc_channel=ps&ef_id=CjwKCAjwx4O4BhAnEiwA42SbVPBXf7hpN07vHx4ObiZX3xFHpgCLP9mHQ4P1CaykaQkJKT53F2EQFhoCWRkQAvD_BwE:G:s&s_kwcid=AL!4422!3!536324516040!e!!g!!aws%20s3%20account!11539706604!115473954714&all-free-tier.sort-by=item.additionalFields.SortRank&all-free-tier.sort-order=asc&awsf.Free%20Tier%20Types=*all&awsf.Free%20Tier%20Categories=*all</a></p><h4><strong>CREATE  Cloudflare R2</strong></h4><p><a href="https://developers.cloudflare.com/workers/tutorials/upload-assets-with-r2/">https://developers.cloudflare.com/workers/tutorials/upload-assets-with-r2/</a></p><ul><li> </li></ul>', CAST(N'2023-06-03T05:22:44.0000000' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2024-10-05T08:46:32.2587433' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', NULL, NULL, 0);
INSERT `PageHelpers` (`Id`, `Code`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'd96ee5aa-4253-4a28-ba61-94b15b6cbfae', N'VERSION_HISTORY', N'Document versions', N'<p><strong>Uploading a New Version of the Document:</strong></p><p>Allows users to upload an updated or modified version of an existing document.</p><p>It includes the following fields:</p><ul><li><strong>Upload a New Version:</strong> A dedicated section for uploading a new version of the document.</li><li><strong>Restore previous version document to current version : </strong>When a user restores a previous version as the current document, the existing current document is automatically added to the document history. The restored document then becomes the active current document, ensuring effective version control and easy tracking of changes</li><li><strong>Upload Document:</strong> An option to upload the document file. Users can select the file they want to upload, and the text "No file chosen" will appear until a file is selected.</li><li><strong>View Document</strong>:<br>This feature provides users with the ability to preview previous versions of a document. Users can easily access and review any earlier version, allowing for better assessment and comparison before deciding to restore or make further edits.</li></ul><p><strong>How to Upload a New Version of the Document:</strong></p><ol><li>Navigate to the "All Documents" page.</li><li>Select the document for which you want to upload a new version.</li><li>Click on the "Upload a New Version" option or a similar button.</li><li>A dedicated form will open where you can select and upload the appropriate file.</li><li>After uploading the file, click "Save" or "Add" to update the document in the system with the new version.</li></ol>', CAST(N'2023-06-03T05:11:05.0000000' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2024-10-05T10:01:08.4565463' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', NULL, NULL, 0);
INSERT `PageHelpers` (`Id`, `Code`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'0fae65e2-091d-469b-8a2a-9bb363ba8290', N'DOCUMENTS_AUDIT_TRAIL', N'Document audit history', N'<p><strong>General Description:</strong></p><p>The "Document Audit History" page provides a detailed view of all actions performed on documents within the DMS. It allows administrators and users with appropriate permissions to monitor and review document-related activities, ensuring transparency and information security.</p><p><strong>Main Components:</strong></p><p><strong>Search Boxes:</strong></p><ul><li><strong>By Document Name:</strong> Allows users to search for a specific document by entering its name or other details.</li><li><strong>By Meta Tag:</strong> Users can enter meta tags to filter and search for specific document-related activities.</li><li><strong>By User:</strong> Enables filtering activities based on the user who performed the operation.</li></ul><p><strong>List of Audited Documents:</strong></p><p>Displays all actions taken on documents in a tabular format.</p><p>Each entry includes details of the action, such as the date, document name, Category, operation performed, who performed the operation, to which user, and to which role the operation was directed.</p><p>Users can click on an entry to view additional details or access the associated document.</p><p><strong>List Sorting:</strong></p><p>Users can sort the list by any of the available columns, such as "Date," "Name," "Category Name," "Operation," "Performed by," "Directed to User," and "Directed to Role."</p><p>This feature makes it easier to organize and analyze information based on specific criteria.</p><p><strong>How to Search the Audit History:</strong></p><ul><li>Enter your search criteria in the corresponding search box (document name, meta tag, or user).</li><li>The search results will be displayed in the audited documents list.</li></ul><p><strong>How to Sort the List:</strong></p><ul><li>Click on the column title by which you want to sort the list (e.g., "Date" or "Name").</li><li>The list will automatically reorder based on the selected criterion.</li></ul>', CAST(N'2023-06-03T05:17:16.0000000' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2024-10-05T05:50:15.8413357' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', NULL, NULL, 0);
INSERT `PageHelpers` (`Id`, `Code`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'b1c70caf-ce26-4dff-8f8a-aed4c8eab097', N'PAGE_HELPERS', N'Page Helpers', N'<p>Users can manage the pages within the application using a user-friendly interface that displays a list of available pages. Each entry in the list includes options to <strong>Edit</strong> or <strong>View</strong> the corresponding page''s details.</p><h4>Features</h4><ol><li><h4><strong>List of Pages</strong></h4><ul><li>Users can see a comprehensive list of all pages in the application, each with the following details:<ul><li><strong>Unique Code:</strong> A non-editable code for each page.</li><li><strong>Editable Name:</strong> An editable field that allows users to change the page name.</li><li><strong>Page Info Content:</strong> A section that displays the functionality description of each page.</li><li> </li></ul></li></ul></li><li><h4><strong>Edit Feature</strong></h4><ul><li><strong>Edit Button:</strong><ul><li>When a user clicks the <strong>Edit</strong> button next to a page, they are directed to an editable form.</li><li>Users can modify the page name and update the page info content to reflect any changes or improvements.</li><li><strong>Validation:</strong><ul><li>The form includes validation checks to ensure that the new name is unique and meets any defined requirements (e.g., length, special characters).</li></ul></li><li><strong>Save Changes:</strong><ul><li>Users can save the changes, which are then reflected in the list of pages and will persist across sessions.</li><li> </li></ul></li></ul></li></ul></li><li><h4><strong>View Feature</strong></h4><ul><li><strong>View Button:</strong><ul><li>Clicking the <strong>View</strong> button opens a dialog box displaying a preview of the page info content.</li><li>This preview includes  current page name, and detailed functionality description.</li><li><strong>Modal Dialog:</strong><ul><li>The dialog box is modal, meaning users cannot interact with the rest of the application until they close the dialog.</li><li>Users can close the dialog by clicking an "X" button or a "Close" button.</li></ul></li></ul></li></ul></li><li> <ul><li><h4><strong>Navigating to the Page List:</strong></h4><ul><li>Users can easily navigate to the page list through the main navigation menu.</li></ul></li><li><strong>Editing a Page:</strong><ul><li>Users select the <strong>Edit</strong> button next to the desired page, modify the name and content, and click <strong>Save</strong> to apply the changes.</li></ul></li><li><strong>Viewing a Page:</strong><ul><li>Users can click the <strong>View</strong> button to open the dialog box, review the details, and close the dialog when finished.</li></ul></li></ul></li></ol><h3>Summary</h3><p>This functionality empowers users to effectively manage page names and content within the application, ensuring that information is accurate and up-to-date. The combination of edit and view features enhances the user experience by allowing for quick modifications and easy access to page details.</p>', CAST(N'2023-06-03T05:22:43.7270890' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2024-10-05T08:53:15.1785445' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', NULL, NULL, 0);
INSERT `PageHelpers` (`Id`, `Code`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'd0e88580-71d2-4d74-b1ac-b9f34aec6818', N'DOCUMENT_Categories', N'Document Categories', N'<p><strong>The "Document Categories" page serves as a centralized hub for managing and organizing Categories, which essentially represent the departments that work with the files. It offers a hierarchical structure, allowing the creation of main Categories and subCategories.</strong></p><h4><strong>Main Components:</strong></h4><p><strong>"Add New Document Category" Button:</strong></p><ul><li>Allows administrators or users with appropriate permissions to create a new Category or department.</li><li>Opens a form or a pop-up window where details like the Category name and description can be entered.</li></ul><p><strong>List of Existing Categories:</strong></p><ul><li>Displays all the Categories or departments created within the system.</li><li>Each entry includes the Category name and associated action options.</li></ul><p><strong>Action Menu for Each Category:</strong></p><ul><li>Next to each Category, users will find action options that allow them to manage the Category:<ul><li><strong>Edit:</strong> Enables modification of the Category''s details, such as the name or description.</li><li><strong>Delete:</strong> Removes the Category from the system. This action may require confirmation to prevent accidental deletions.</li></ul></li></ul><p><strong>Double Arrow Button ">>":</strong></p><ul><li>Located next to each main Category.</li><li>When clicked, it reveals the subCategories associated with the main Category.</li><li>Allows users to view and manage subCategories in a hierarchical manner.</li></ul><h4><strong>How to Add a New Category:</strong></h4><ol><li>Click on the "Add New Document Category" button.</li><li>A form or pop-up window will open.</li><li>Enter the Category name and description.</li><li>Click "Save" or "Add" to add the Category to the system.</li></ol><h4><strong>How to View SubCategories:</strong></h4><ol><li>Locate the main Category in the list.</li><li>Click on the double arrow button ">>" next to the Category name.</li><li>The associated subCategories will be displayed beneath the main Category.</li></ol>', CAST(N'2023-06-03T05:16:36.0000000' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2024-10-05T07:06:36.4241448' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', NULL, NULL, 0);
INSERT `PageHelpers` (`Id`, `Code`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'd8506639-f4ec-42d8-9939-bae893abef57', N'ROLES', N'Roles', N'<p><strong>The "User Roles" page is essential for managing and defining permissions within the CMR DMS. Roles represent predefined sets of permissions that can be assigned to users, ensuring that each user has access only to the functionalities and documents appropriate to their position and responsibilities within the organization.</strong></p><h3><strong>Main Components:</strong></h3><p><strong>"Add Roles" Button:</strong></p><ul><li>Allows administrators or users with appropriate permissions to create a new role in the system.</li><li>Opens a form or pop-up window where the role’s permissions and details can be defined.</li></ul><p><strong>List of Existing Roles:</strong></p><ul><li>Displays all roles created within the system in a tabular format.</li><li>Each entry includes the role name and associated action options.</li></ul><p><strong>Action Menu for Each Role:</strong></p><ul><li>Includes options for "Edit" and "Delete."<ul><li><strong>Edit:</strong> Allows modification of the role''s details and permissions.</li><li><strong>Delete:</strong> Removes the role from the system. This action may require confirmation to prevent accidental deletions.</li></ul></li></ul><p><strong>Role Creation Page:</strong></p><ul><li>Here, administrators can define specific permissions for each role.</li><li>Permissions can include rights such as viewing, editing, deleting, or sharing documents, managing users, defining Categories, and more.</li><li>Once permissions are set, they can be saved to create a new role or update an existing one.</li></ul><h3><strong>How to Add a New Role:</strong></h3><ol><li>Click on the "Add Roles" button.</li><li>A form or pop-up window will open.</li><li>Enter the role name and select the appropriate permissions from the available list.</li><li>Click "Save" or "Add" to add the role to the system with the specified permissions.</li></ol>', CAST(N'2023-06-03T05:18:29.0000000' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2024-10-05T05:52:38.0563727' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', NULL, NULL, 0);
INSERT `PageHelpers` (`Id`, `Code`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'ee4f69f1-1ed7-4447-87d4-c43a0b0f92e0', N'UPLOAD_NEW_VERSION', N'Upload version file', N'<p><strong>How to Upload a New Version of a Document:</strong></p><ol><li>Navigate to the "All Documents" page.</li><li>Select the document for which you want to upload a new version.</li><li>Click on the option "Upload a New Version" or a similar button.</li><li>A dedicated form will open, allowing you to select and upload the appropriate file.</li><li>After uploading the file, click "Save" or "Add" to update the document in the system with the new version.</li></ol>', CAST(N'2023-06-03T05:14:00.0000000' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2024-10-05T06:15:02.9239849' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', NULL, NULL, 0);
INSERT `PageHelpers` (`Id`, `Code`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'25ccccd4-bd60-4f8b-8bc1-c49eca98fb49', N'EMAIL_SMTP_SETTINGS', N'SMTP Email Settings', N'<p>The <strong>"Email SMTP Settings"</strong> page within CMR DMS allows administrators to configure and manage the SMTP settings for sending emails. This ensures that emails sent from the system are correctly and efficiently delivered to recipients.</p><p><strong>Key Components:</strong></p><ul><li><p><strong>SMTP Settings Table:</strong> Displays all configured SMTP settings in a tabular format.</p><p>Each entry in the table includes details such as the username, host, port, and whether that configuration is set as the default.</p></li><li><p><strong>"Add Settings" Button:</strong> Allows administrators to add a new SMTP configuration.</p><p>Clicking the button opens a form where details like username, host, port, and the option to set it as the default configuration can be entered.</p></li></ul><p><strong>"Add Settings" Form:</strong></p><p>This form opens when administrators click the "Add Settings" button and includes the following fields:</p><ul><li><strong>Username:</strong> The username required for authentication on the SMTP server.</li><li><strong>Host:</strong> The SMTP server address.</li><li><strong>Port:</strong> The port on which the SMTP server listens.</li><li><strong>Is Default:</strong> A checkbox that allows setting this configuration as the default for sending emails.</li></ul><p><strong>How to Add a New SMTP Configuration:</strong></p><ol><li>Click the "Add Settings" button.</li><li>The "Add Settings" form will open, where you can enter the SMTP configuration details.</li><li>Fill in the necessary fields and select the desired options.</li><li>After completing the details, click "Save" or "Add" to add the configuration to the system.</li></ol>', CAST(N'2023-06-03T05:25:45.0000000' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2024-10-04T14:30:24.7343669' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', NULL, NULL, 0);
INSERT `PageHelpers` (`Id`, `Code`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'3e0fe36d-cde5-4bd9-b65d-cfaeadcffce3', N'COMPANY_PROFILE', N'Company Profile', N'<p>Here’s a detailed description of the functionality for managing the company profile, focusing on the company name, lo;, and banner lo; on the login screen.</p><h3> </h3><h4>Overview</h4><p>The Company Profile feature allows users to customize the branding of the application by entering the company name and uploading lo;s. This customization will reflect on the login screen, enhancing the professional appearance and brand identity of the application.</p><h4>Features</h4><ol><li><h4><strong>Company Name</strong></h4><ul><li><strong>Input Field:</strong><ul><li>Users can enter the name of the company in a text input field.</li><li><strong>Validation:</strong><ul><li>The field will have validation to ensure the name is not empty and meets any specified length requirements (e.g., minimum 2 characters, maximum 50 characters).</li><li><strong>Browser Title Setting:</strong></li><li>Upon saving the company name, the application will dynamically set the browser title to match the company name, improving brand visibility in browser tabs.</li></ul></li></ul></li></ul></li><li><h4><strong>Lo; Upload</strong></h4><ul><li><strong>Upload Button:</strong><ul><li>Users can upload a company lo; that will be displayed in the header of the login page.</li><li><strong>File Requirements:</strong><ul><li>Supported file formats: PNG, JPG, JPEG (with size limits, e.g., up to 2 MB).</li><li>Recommended dimensions for optimal display (e.g., width: 200px, height: 100px).</li></ul></li></ul></li><li><strong>Preview:</strong><ul><li>After uploading, a preview of the lo; will be displayed to confirm the upload.</li></ul></li></ul></li><li><h4><strong>Banner Lo; Upload</strong></h4><ul><li><strong>Upload Button:</strong><ul><li>Users can upload a banner lo; that will appear prominently on the login screen.</li><li><strong>File Requirements:</strong><ul><li>Supported file formats: PNG, JPG, JPEG (with size limits, e.g., up to 3 MB).</li><li>Recommended dimensions for optimal display (e.g., width: 1200px, height: 300px).</li></ul></li></ul></li><li><strong>Preview:</strong><ul><li>A preview of the banner lo; will be displayed after the upload for confirmation.</li></ul></li></ul></li><li><h4><strong>User Interaction Flow</strong></h4><ul><li><h4><strong>Navigating to the Company Profile:</strong></h4><ul><li>Users can access the company profile settings from the application’s settings menu or administration panel.</li></ul></li><li><strong>Editing Company Profile:</strong><ul><li>Users enter the company name, upload the lo;, and the banner lo;.</li><li>A "Save Changes" button will be available to apply the modifications.</li></ul></li><li><strong>Saving Changes:</strong><ul><li>Upon clicking "Save Changes," the uploaded lo;s and company name will be saved and reflected on the login screen.</li><li>Confirmation messages will be displayed to indicate successful updates.</li></ul></li></ul></li><li><strong>Display on Login Screen</strong><ul><li><strong>Header Display:</strong><ul><li>The company lo; will be displayed in the header at the top of the login page, maintaining a consistent branding experience.</li></ul></li><li><strong>Banner Display:</strong><ul><li>The banner lo; will be displayed prominently below the header, enhancing the visual appeal of the login interface.</li></ul></li></ul></li></ol><h3>Summary</h3><p>The Company Profile functionality allows for a customizable branding experience, enabling users to set their company name and lo;s that will be visible on the login screen. This feature enhances user engagement and presents a professional image right from the login phase of the application.</p>', CAST(N'2023-06-03T05:22:43.7270890' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2024-10-05T08:59:50.4836430' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', NULL, NULL, 0);
INSERT `PageHelpers` (`Id`, `Code`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'762a5894-0c49-48d8-9e0c-e5062a4c3322', N'SEND_EMAIL', N'Send mail', N'<ul><li><strong>How to Send a Document as an Email Attachment:</strong></li><li><strong>Select the email field</strong>: Navigate to the section where you can compose an email and select the field for entering the recipient''s email address.</li><li><strong>Enter the email address</strong>: Type the recipient''s email address in the provided field.</li><li><strong>Subject field</strong>: Enter a relevant subject for your email.</li><li><strong>Email content</strong>: Write the body of your email, providing any necessary context or information.</li><li><strong>Attach the document</strong>: Find the option to "Attach" or "Upload" a document, then select the file you wish to send.</li><li><strong>Send the email</strong>: After attaching the document and ensuring the recipient, subject, and content are correct, click the "Send" button to deliver the email with the attached document.</li></ul>', CAST(N'2023-06-03T05:16:00.0000000' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2024-10-05T06:16:51.7893891' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', NULL, NULL, 0);
INSERT `PageHelpers` (`Id`, `Code`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'dd0c9840-b7c6-4a51-b78a-e674918ff7e5', N'NOTIFICATIONS', N'Notifications', N'<ul><li><strong>Document Shared Notification</strong>:<ul><li>Sends real-time notifications to users when a document is shared with them.</li><li>Notifications are sent via email and in-app, with details about the shared document, including name, category, and shared user.</li><li>For documents shared with external users, the recipient is notified with a secure link to access the document.</li></ul></li><li><strong>Reminder Notifications</strong>:<ul><li>Sends reminders to users for upcoming deadlines or actions related to documents (e.g., review deadlines or document expiration).</li><li>Users can configure reminder frequency and set specific reminders for important documents.</li><li>Reminders are delivered via both email and in-app notifications.</li></ul></li></ul><p>&nbsp;</p>', CAST(N'2023-06-03T05:28:05.0000000' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2023-08-25T19:10:29.0000000' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', NULL, NULL, 0);
INSERT `PageHelpers` (`Id`, `Code`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'509dfdb8-8e5c-4370-8427-f6a9c2c78007', N'ROLE_USER', N'Role users', N'<p><strong>The "User with Role" page is dedicated to assigning specific roles to users within the DMS. It allows administrators to associate users with particular roles using an intuitive "drag and drop" system. Users can be moved from the general user list to the "Users with Role" list, thereby assigning them the selected role.</strong></p><h3><strong>Main Components:</strong></h3><ul><li><strong>Title "User with Role":</strong> Indicates the purpose and functionality of the page.</li><li><strong>Department:</strong> Displays the currently selected department, in this case, "Approvals."<ul><li>There may be an option to change the department if needed.</li></ul></li><li><strong>Select Role:</strong> A dropdown menu or selection box where administrators can choose the role they wish to assign to users.<ul><li>Once a role is selected, users can be moved into the "Users with Role" list to assign them that role.</li></ul></li><li><strong>Note:</strong> A short instruction explaining how to use the page, indicating that users can be moved from the "All Users" list to the "Users with Role" list to assign them a role.</li><li><strong>"All Users" and "Users with Role" Lists:</strong><ul><li><strong>"All Users":</strong> Displays a complete list of all registered users in the CMR DMS.</li><li><strong>"Users with Role":</strong> Displays the users who have been assigned the selected role.</li><li>Users can be moved between these lists using the "drag and drop" functionality.</li></ul></li></ul><h3><strong>How to Assign a Role to a User:</strong></h3><ol><li>Select the desired role from the "Select Role" box.</li><li>Locate the desired user in the "All Users" list.</li><li>Using the mouse or a touch device, drag the user from the "All Users" list and drop them into the "Users with Role" list.</li><li>The selected user will now be associated with the chosen role and will appear in the "Users with Role" list.</li></ol>', CAST(N'2023-06-03T05:23:23.0000000' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2024-10-05T06:17:44.8519754' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', NULL, NULL, 0);
INSERT `PageHelpers` (`Id`, `Code`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'0cc83192-f05b-4c97-ab20-f7f3b5ba16d0', N'REMINDERS', N'Reminders', N'<p>The <strong>"Reminders"</strong> page is the central hub for managing reminders within CMR DMS, where users can create, view, and manage reminders or notifications related to documents or other activities. Reminders can be set to repeat at regular intervals and can be associated with a specific document for efficient tracking of tasks and activities.</p><h3>Main components:</h3><ol><li><strong>"Add Reminder" Button</strong>:<ul><li>Allows users to create a new reminder.</li><li>Upon clicking, it opens a form where details such as subject, message, frequency, associated document, and reminder date can be entered.</li></ul></li><li><strong>Reminders Table</strong>:<ul><li>Displays all created reminders in a tabular format.</li><li>Each entry includes:<ul><li>Start date</li><li>End date</li><li>Reminder subject</li><li>Associated message</li><li>Recurrence frequency</li><li>Associated document (if applicable)</li></ul></li></ul></li></ol><h3>"Add Reminder" Form:</h3><p>When users click on the <strong>"Add Reminder"</strong> button, a form opens with the following fields:</p><ul><li><strong>Subject</strong>: The title or topic of the reminder (e.g., "Document Review").</li><li><strong>Message</strong>: Additional details about the reminder (e.g., "Review the document by X date").</li><li><strong>Repeat Reminder</strong>: Sets the recurrence frequency, with options such as:<ul><li>Daily</li><li>Weekly</li><li>Monthly</li><li>Semi-annually</li></ul></li><li><strong>Send Email</strong>: An option to send an email notification when the reminder is activated.</li><li><strong>Select Users</strong>: Allows selecting users to whom the reminder will be sent. It can be customized for specific teams or individuals.</li><li><strong>Reminder Date</strong>: The date and time when the reminder will be activated and sent.</li></ul><h3>How to add a new reminder:</h3><ol><li>Navigate to the <strong>"Reminders"</strong> page.</li><li>Click the <strong>"Add Reminder"</strong> button.</li><li>Fill in the form fields with the necessary information.</li><li>After entering all the details, click <strong>"Save"</strong> or <strong>"Add"</strong> to save the reminder in the system.</li></ol><h3>"Add Reminder" Functionality in the "Manage Reminders" section:</h3><p>This is the dedicated place for creating and managing notifications related to events or tasks. The <strong>"Add Reminder"</strong> functionality offers full customization, and reminders can be sent to selected users.</p><ul><li><strong>Subject</strong>: Enter a descriptive title for the reminder.</li><li><strong>Message</strong>: Add a clear and concise message to detail the purpose of the reminder.</li><li><strong>Repeat Reminder</strong>: Set whether the reminder will be repeated periodically (daily, weekly, etc.).</li><li><strong>Send Email</strong>: If this option is checked, the reminder will also be sent as an email.</li><li><strong>Select Users</strong>: Select users from the system''s list to whom the reminder will be sent.</li><li><strong>Reminder Date</strong>: Set the date and time for the reminder to be triggered.</li></ul>', CAST(N'2023-06-02T17:31:21.0000000' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'2024-10-05T04:41:27.0060525' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', NULL, NULL, 0);
INSERT `PageHelpers` (`Id`, `Code`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES (N'a3664127-34f1-494c-84c5-fc3f307a9d11', N'USER_PAGE_PERMISSION_TO', N'User Page Permission To', N'<ul><li>Enable the ability to assign specific permissions to users that are not tied to their assigned roles. This gives admins the flexibility to grant access to particular features for individual users.</li><li>Click <strong>"Save"</strong> or <strong>"Add"</strong> to assign the user to the system with the specified permissions.</li></ul>', CAST(N'2023-06-03T05:22:44.0000000' AS DATETIME(6)), N'4b352b37-332a-40c6-ab05-e38fcf109719', CAST(N'0001-01-01T00:00:00.0000000' AS DATETIME(6)), N'00000000-0000-0000-0000-000000000000', NULL, NULL, 0);


INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20241009065309_Version_V31_MySql_Data', '8.0.8');

COMMIT;

START TRANSACTION;

ALTER TABLE `Documents` ADD `IsAddedPageIndxing` tinyint(1) NOT NULL DEFAULT FALSE;

CREATE TABLE `DocumentIndexes` (
    `Id` char(36) COLLATE ascii_general_ci NOT NULL,
    `DocumentId` char(36) COLLATE ascii_general_ci NOT NULL,
    `CreatedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT `PK_DocumentIndexes` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_DocumentIndexes_Documents_DocumentId` FOREIGN KEY (`DocumentId`) REFERENCES `Documents` (`Id`) ON DELETE CASCADE
) CHARACTER SET=utf8mb4;

CREATE INDEX `IX_DocumentIndexes_DocumentId` ON `DocumentIndexes` (`DocumentId`);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20241023101720_Version_V4_MySql', '8.0.8');

COMMIT;

START TRANSACTION;

INSERT `Screens` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `IsDeleted`, `OrderNo`) 
	VALUES ('D6B63A2E-F7DB-4F83-B5DD-96A000D9A789', 'Deep Search', CAST('2024-10-22T16:18:01.0788250' AS DATETIME(6)), '00000000-0000-0000-0000-000000000000', CAST('2024-10-22T16:18:01.0788250' AS DATETIME(6)), '00000000-0000-0000-0000-000000000000', 0, 4);


INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `IsDeleted`) 
	VALUES ('393B2BA9-0664-470D-807F-D5D936FAAF27', 'Deep Search', CAST('2024-10-22T16:18:01.0788250' AS DATETIME(6)), '00000000-0000-0000-0000-000000000000', CAST('2024-10-22T16:18:01.0788250' AS DATETIME(6)), '00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `IsDeleted`) 
	VALUES ('B1139F93-8ADC-4034-BCF1-B27203831FA8', 'Add Document Index', CAST('2024-10-22T16:18:01.0788250' AS DATETIME(6)), '00000000-0000-0000-0000-000000000000', CAST('2024-10-22T16:18:01.0788250' AS DATETIME(6)), '00000000-0000-0000-0000-000000000000', 0);
INSERT `Operations` (`Id`, `Name`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `IsDeleted`) 
	VALUES ('5B53E317-E2B4-4808-839F-424CF25762B5', 'Remove Document Index', CAST('2024-10-22T16:18:01.0788250' AS DATETIME(6)), '00000000-0000-0000-0000-000000000000', CAST('2024-10-22T16:18:01.0788250' AS DATETIME(6)), '00000000-0000-0000-0000-000000000000', 0);


INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) 
	VALUES ('42794D41-EF8A-4F8E-B0AD-1FCEB50B3E2E', '393B2BA9-0664-470D-807F-D5D936FAAF27', 'D6B63A2E-F7DB-4F83-B5DD-96A000D9A789', CAST('2024-10-22T16:18:01.0788250' AS DATETIME(6)), '00000000-0000-0000-0000-000000000000', CAST('2024-10-22T16:18:01.0788250' AS DATETIME(6)), '00000000-0000-0000-0000-000000000000', NULL, '00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) 
	VALUES ('ECA884BB-CCB8-4723-A137-D73F988AE300', 'B1139F93-8ADC-4034-BCF1-B27203831FA8', 'D6B63A2E-F7DB-4F83-B5DD-96A000D9A789', CAST('2024-10-22T16:18:01.0788250' AS DATETIME(6)), '00000000-0000-0000-0000-000000000000', CAST('2024-10-22T16:18:01.0788250' AS DATETIME(6)), '00000000-0000-0000-0000-000000000000', NULL, '00000000-0000-0000-0000-000000000000', 0);
INSERT `ScreenOperations` (`Id`, `OperationId`, `ScreenId`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) 
	VALUES ('A73CCEF3-DA47-49E8-9944-EBA0F18B2E40', '5B53E317-E2B4-4808-839F-424CF25762B5', 'D6B63A2E-F7DB-4F83-B5DD-96A000D9A789', CAST('2024-10-22T16:18:01.0788250' AS DATETIME(6)), '00000000-0000-0000-0000-000000000000', CAST('2024-10-22T16:18:01.0788250' AS DATETIME(6)), '00000000-0000-0000-0000-000000000000', NULL, '00000000-0000-0000-0000-000000000000', 0);


INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) 
	VALUES ('393B2BA9-0664-470D-807F-D5D936FAAF27', 'D6B63A2E-F7DB-4F83-B5DD-96A000D9A789', 'fedeac7a-a665-40a4-af02-f47ec4b7aff5', 'Deep_Search_Deep_Search', '');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) 
	VALUES ('B1139F93-8ADC-4034-BCF1-B27203831FA8', 'D6B63A2E-F7DB-4F83-B5DD-96A000D9A789', 'fedeac7a-a665-40a4-af02-f47ec4b7aff5', 'Deep_Search_Add_Document_Index', '');
INSERT `RoleClaims` (`OperationId`, `ScreenId`, `RoleId`, `ClaimType`, `ClaimValue`) 
	VALUES ('5B53E317-E2B4-4808-839F-424CF25762B5', 'D6B63A2E-F7DB-4F83-B5DD-96A000D9A789', 'fedeac7a-a665-40a4-af02-f47ec4b7aff5', 'Deep_Search_Remove_Document_Index', '');

INSERT `PageHelpers` (`Id`, `Code`, `Name`, `Description`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `DeletedDate`, `DeletedBy`, `IsDeleted`) VALUES 
('A8209505-ED74-4D3A-93F4-8185192994DC', 'DEEP_SEARCH', 'Deep Search', '<p>The <strong>Deep Search</strong> feature allows you to search through the content of various types of documents, including Word documents, PDFs, Notepad files, PPT, Images (.tif, .tiff, .png, .jpg, .jpeg, .bmp, .pbm, .pgm, .ppm) and Excel spreadsheets. Follow the instructions below to ensure accurate and efficient searches.</p><h4><strong>1. How to Perform a Search</strong></h4><ul><li><strong>Basic Search</strong>: Enter keywords or phrases in the search bar. The system will look for these terms across supported document types. When the ''Search Exact Match'' checkbox is checked, the system will search for documents that contain the exact phrase entered in the search field. </li></ul><h4><strong>2. Case Sensitivity</strong></h4><ul><li><strong>Case-Insensitive Search</strong>: The search is not case-sensitive. This means that searching for "Report" and "Report" will return the same results, regardless of capitalization.</li></ul><h4><strong>3. Common Words</strong></h4><ul><li><strong>Ignored Words</strong>: Common words such as "and," "the," and "is" are automatically ignored to provide more relevant results. This improves search accuracy by focusing on significant terms in your query.</li></ul><h4><strong>4. Word Variations (Stemming)</strong></h4><ul><li><strong>Word Variations</strong>: The search automatically includes variations of the words you enter. For example, if you search for "run", the system will also return documents that contain "running", "runs", and similar variations.</li></ul><h4><strong>5. Supported File Types</strong></h4><p>Deep Search can find content within the following document types:</p><ul><li><strong>Microsoft Word</strong> documents (.doc, .docx)</li><li><strong>Writable PDF</strong> files (editable, non-scanned PDFs)</li><li><strong>Notepad</strong> text files (.txt)</li><li><strong>Excel spreadsheets</strong> (.xls, .xlsx)</li><li><strong>PowerPoint documents</strong> (.ppt, .pptx)</li><li><strong>Images </strong>(tif,.tiff,.png,.jpg,.jpeg,.bmp,.pbm,.pgm,.ppm)</li></ul><p>Ensure that your documents are in one of these supported formats for the search function to work properly.</p><h4><strong>6. Search Results Limit</strong></h4><ul><li>You will receive a <strong>maximum of 10 results</strong> per search. If more documents match your query, you may need to refine your search to narrow down the results.</li></ul><h4><strong>7. Indexing Time for New Documents</strong></h4><ul><li>After uploading a new document, it may take <strong>15 to 20 minutes</strong> for it to become searchable. This delay is due to background document indexing, which is necessary to prepare the document''s content for Deep Search.</li><li> </li><li><h4><strong>8. Removing a Document from Indexing</strong></h4></li><li>If you no longer want a document to be searchable, you can <strong>remove it from indexing</strong>. Follow these steps:</li><li>Navigate to the <strong>Document List</strong> page.</li><li>Find the document you want to remove from search indexing.</li><li>Click on the <strong>Remove Page Indexing</strong> menu item for that document.</li><li>After removal, the document''s content will no longer be searchable. <strong>Once removed, the document will not appear in search results, and the indexing process cannot be reversed.</strong></li></ul><h4><strong>9. Tips for Better Search Results</strong></h4><ul><li>Use <strong>specific keywords</strong>: The more specific your search terms, the more relevant the results will be.</li><li>Combine <strong>exact phrase search</strong> and regular search terms to narrow down results (e.g., "annual report" budget overview).</li><li>Avoid using common words that the system ignores unless they are part of an exact phrase search.</li></ul>', CAST('2023-06-03T05:22:44.0000000' AS DATETIME(6)), '4b352b37-332a-40c6-ab05-e38fcf109719', CAST('0001-01-01T00:00:00.0000000' AS DATETIME(6)), '00000000-0000-0000-0000-000000000000', NULL, NULL, 0);


INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20241023101736_Version_V4_MySql_Data', '8.0.8');

COMMIT;

