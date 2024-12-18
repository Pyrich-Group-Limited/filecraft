import { ResourceParameter } from './resource-parameter';

export class DocumentResource extends ResourceParameter {
  id?: string = '';
  createdBy?: string = '';
  categoryId?: string = '';
  documentStatusId?: string = '';
  storageSettingId?: string = '';
  createDate?: Date;
}
