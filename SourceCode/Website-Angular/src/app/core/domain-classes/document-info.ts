import { DocumentRolePermission } from './document-role-permission';
import { DocumentUserPermission } from './document-user-permission';
import { DocumentMetaData } from './documentMetaData';
import { DocumentVersion } from './documentVersion';

export interface DocumentInfo {
  id?: string;
  name?: string;
  url?: string;
  description?: string;
  createdDate?: Date;
  createdBy?: string;
  categoryId?: string;
  documentStatusId?: string;
  documentStatus?: string;
  storageSettingId?: string;
  categoryName?: string;
  documentSource?: string;
  extension?: string;
  isVersion?: boolean;
  viewerType?: string;
  expiredDate?: Date;
  isAllowDownload?: boolean;
  documentVersions?: DocumentVersion[];
  documentMetaDatas?: DocumentMetaData[];
  documentUserPermissions?: DocumentUserPermission[];
  documentRolePermissions?: DocumentRolePermission[];
  files?: string;
  isAddedPageIndxing?: boolean;
  isIndexable?: boolean
  isMoreThan15MinutesFromLocal?: boolean;
}
