import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AuthGuard } from '@core/security/auth.guard';
import { LayoutComponent } from './core/layout/layout.component';
import { MyProfileComponent } from './user/my-profile/my-profile.component';
import { DocumentLinkPreviewComponent } from './document/document-link-preview/document-link-preview.component';

const routes: Routes = [
  {
    path: 'login',
    loadChildren: () =>
      import('./login/login.module').then((m) => m.LoginModule),
  },
  {
    path: 'preview/:code',
    component: DocumentLinkPreviewComponent,
  },
  {
    path: '',
    component: LayoutComponent,
    children: [
      {
        path: '',
        canLoad: [AuthGuard],
        loadChildren: () =>
          import('./document-library/document-library.module').then(
            (m) => m.DocumentLibraryModule
          ),
      },
      {
        path: 'my-profile',
        component: MyProfileComponent,
        canActivate: [AuthGuard],
      },
      {
        path: 'dashboard',
        data: { claimType: 'dashboard_view_dashboard' },
        canLoad: [AuthGuard],
        loadChildren: () =>
          import('./dashboard/dashboard.module').then((m) => m.DashboardModule),
      },
      {
        path: 'operations',
        canLoad: [AuthGuard],
        loadChildren: () =>
          import('./operation/operation.module').then((m) => m.OperationModule),
      },
      {
        path: 'screens',
        canLoad: [AuthGuard],
        loadChildren: () =>
          import('./screen/screen.module').then((m) => m.ScreenModule),
      },
      {
        path: 'screen-operation',
        canLoad: [AuthGuard],
        loadChildren: () =>
          import('./screen-operation/screen-operation.module').then(
            (m) => m.ScreenOperationModule
          ),
      },
      {
        path: 'roles',
        data: {
          claimType: [
            'role_view_roles',
            'role_edit_role',
            'role_create_role',
            'user_assign_user_role',
          ],
        },
        canLoad: [AuthGuard],
        loadChildren: () =>
          import('./role/role.module').then((m) => m.RoleModule),
      },
      {
        path: 'users',
        data: {
          claimType: [
            'user_view_users',
            'user_edit_user',
            'user_create_user',
            'user_assign_permission',
          ],
        },
        canLoad: [AuthGuard],
        loadChildren: () =>
          import('./user/user.module').then((m) => m.UserModule),
      },
      {
        path: 'categories',
        data: { claimType: 'document_category_view_categories' },
        canLoad: [AuthGuard],
        loadChildren: () =>
          import('./category/category.module').then((m) => m.CategoryModule),
      },
      {
        path: 'documents',
        canLoad: [AuthGuard],
        data: {
          claimType: [
            'all_documents_view_documents',
            'all_documents_create_document',
            'all_documents_edit_document',
            'all_documents_share_document',
            'deep_search_deep_search'
          ],
        },
        loadChildren: () =>
          import('./document/document.module').then((m) => m.DocumentModule),
      },
      {
        path: 'document-audit-trails',
        canLoad: [AuthGuard],
        data: { claimType: 'document_audit_trail_view_document_audit_trail' },
        loadChildren: () =>
          import('./document-audit-trail/document-audit-trail.module').then(
            (m) => m.DocumentAuditTrailModule
          ),
      },
      {
        path: 'login-audit',
        data: { claimType: 'login_audit_view_login_audit_logs' },
        canLoad: [AuthGuard],
        loadChildren: () =>
          import('./login-audit/login-audit.module').then(
            (m) => m.LoginAuditModule
          ),
      },
      {
        path: 'logs',
        data: {
          claimType: 'error_logs_view_error_log'
        },
        loadChildren: () =>
          import('./n-log/n-log.module').then((m) => m.NLogModule),
      },
      {
        path: 'notifications',
        canLoad: [AuthGuard],
        loadChildren: () =>
          import('./notification/notification.module').then(
            (m) => m.NotificationModule
          ),
      },
      {
        path: 'reminders',
        data: {
          claimType: [
            'reminder_view_reminders',
            'reminder_create_reminder',
            'reminder_edit_reminder',
          ],
        },
        loadChildren: () =>
          import('./reminder/reminder.module').then((m) => m.ReminderModule),
      },
      {
        path: 'email-smtp',
        data: {
          claimType: [
            'email_view_smtp_settings',
            'email_edit_smtp_setting',
            'email_create_smtp_setting',
          ],
        },
        loadChildren: () =>
          import('./email-smtp-setting/email-smtp-setting.module').then(
            (m) => m.EmailSmtpSettingModule
          ),
      },
      {
        path: 'storage-settings',
        canActivate: [AuthGuard],
        data: { claimType: 'storage_settings_manage_storage_settings' },
        loadComponent: () =>
          import(
            './storage-setting/storage-setting-list/storage-setting-list.component'
          ).then((m) => m.StorageSettingListComponent),
      },
      {
        path: 'document-status',
        canActivate: [AuthGuard],
        data: { claimType: 'document_status_manage_document_status' },
        loadComponent: () =>
          import(
            './document-status/document-status-list/document-status-list.component'
          ).then((m) => m.DocumentStatusListComponent),
      },
      {
        path: 'company-profile',
        canActivate: [AuthGuard],
        data: { claimType: 'company_profile_manage_company_settings' },
        loadComponent: () =>
          import('./company-profile/company-profile.component').then(
            (m) => m.CompanyProfileComponent
          ),
      },
      {
        path: 'page-helper',
        data: { claimType: 'page_helper_manage_page_helper' },
        loadChildren: () =>
          import('./page-helper/page-helper.module').then(
            (m) => m.PageHelperModule
          ),
      },
      {
        path: '**',
        redirectTo: '/',
      },
    ],
  },
];

@NgModule({
  imports: [RouterModule.forRoot(routes, { scrollPositionRestoration: 'top' })],
  exports: [RouterModule],
})
export class AppRoutingModule { }
