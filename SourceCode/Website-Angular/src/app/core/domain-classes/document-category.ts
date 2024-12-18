import { Category } from './category';
import { DocumentInfo } from './document-info';
import { DocumentStatus } from 'src/app/document-status/document-status';

export interface DocumentCategoryStatus {
  document: DocumentInfo;
  categories: Category[];
  documentStatuses: DocumentStatus[];

}
