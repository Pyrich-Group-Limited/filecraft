import { MenuInfo } from './menu-info';

export const ROUTES: MenuInfo[] = [
  {
    path: 'dashboard',
    title: 'DASHBOARD',
    icon: 'monitor',
    class: '',
    submenu: [],
    hasClaims: ['dashboard_view_dashboard'],
  },
  {
    path: '',
    title: 'ASSIGNED_DOCUMENTS',
    icon: 'align-justify',
    class: '',
    submenu: [],
    hasClaims: [],
  },
  {
    path: 'documents',
    title: 'ALL_DOCUMENTS',
    icon: 'layers',
    class: '',
    submenu: [],
    hasClaims: ['all_documents_view_documents'],
  },
  {
    path: 'documents/deep-search',
    title: 'DEEP_SEARCH',
    icon: 'target',
    class: '',
    submenu: [],
    hasClaims: ['deep_search_deep_search'],
  },
  {
    path: 'document-status',
    title: 'DOCUMENT_STATUS',
    icon: 'check',
    class: '',
    submenu: [],
    hasClaims: ['Document_Status_Manage_Document_Status'],
  },
  {
    path: 'categories',
    title: 'DOCUMENT_CATEGORIES',
    icon: 'box',
    class: '',
    submenu: [],
    hasClaims: ['document_category_view_categories'],
  },
  {
    path: 'document-audit-trails',
    title: 'DOCUMENTS_AUDIT_TRAIL',
    icon: 'clock',
    class: '',
    submenu: [],
    hasClaims: ['document_audit_trail_view_document_audit_trail'],
  },
  {
    path: 'roles',
    title: 'ROLES',
    icon: 'shield',
    class: '',
    submenu: [],
    hasClaims: ['role_view_roles'],
  },
  {
    path: 'users',
    title: 'USERS',
    icon: 'users',
    class: '',
    submenu: [],
    hasClaims: ['user_view_users'],
  },
  {
    path: 'roles/users',
    title: 'ROLE_USER',
    icon: 'user-check',
    class: '',
    submenu: [],
    hasClaims: ['user_assign_user_role'],
  },
  {
    path: 'reminders',
    title: 'REMINDER',
    icon: 'bell',
    class: '',
    submenu: [],
    hasClaims: ['reminder_view_reminders'],
  },

  {
    path: '',
    title: 'SETTINGS',
    icon: 'settings',
    class: 'menu-toggle',
    hasClaims: [
      'email_view_smtp_settings',
      'storage_settings_manage_storage_settings',
      'company_profile_manage_company_settings',
      'page_helper_manage_page_helper',
    ],
    submenu: [
      {
        path: '/email-smtp',
        title: 'EMAIL_SMTP_SETTINGS',
        icon: 'email',
        class: 'ml-menu',
        submenu: [],
        hasClaims: ['email_view_smtp_settings'],
      },
      {
        path: '/storage-settings',
        title: 'STORAGE_SETTINGS',
        icon: '',
        class: 'ml-menu',
        submenu: [],
        hasClaims: ['storage_settings_manage_storage_settings'],
      },
      {
        path: '/page-helper',
        title: 'PAGE_HELPER',
        icon: '',
        class: 'ml-menu',
        submenu: [],
        hasClaims: ['page_helper_manage_page_helper'],
      },
      {
        path: 'company-profile',
        title: 'COMPANY_PROFILE',
        icon: '',
        class: 'ml-menu',
        submenu: [],
        hasClaims: ['company_profile_manage_company_settings'],
      },
    ],
  },
  {
    path: '',
    title: 'LOGS',
    icon: 'file-text',
    class: 'menu-toggle',
    hasClaims: [
      'login_audit_view_login_audit_logs',
      'error_logs_view_error_logs',
    ],
    submenu: [
      {
        path: 'login-audit',
        title: 'LOGIN_AUDITS',
        icon: 'key',
        class: 'ml-menu',
        submenu: [],
        hasClaims: ['login_audit_view_login_audit_logs'],
      },
      {
        path: '/logs',
        title: 'ERROR_LOGS',
        icon: '',
        class: 'ml-menu',
        submenu: [],
        hasClaims: ['error_logs_view_error_logs'],
      },
    ],
  },
];
