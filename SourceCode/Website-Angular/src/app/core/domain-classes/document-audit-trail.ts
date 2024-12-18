export interface DocumentAuditTrail {
  id?: string;
  documentId?: string;
  documentName?: string;
  url?: string;
  createdBy?: string;
  createdDate?: Date;
  operationName: string;
  permissionUser?: string;
  permissionRole?: string
}
