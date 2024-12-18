import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AuthGuard } from '@core/security/auth.guard';
import { DocumentListComponent } from './document-list/document-list.component';
import { DocumentManageResolver } from './document-manage/document-manage-resolver';
import { DocumentManageComponent } from './document-manage/document-manage.component';
import { DeepDocumentSearchComponent } from './deep-document-search/deep-document-search.component';

const routes: Routes = [
  {
    path: '', component: DocumentListComponent,
    data: { claimType: 'all_documents_view_documents' },
    canActivate: [AuthGuard]
  },
  {
    path: 'deep-search', component: DeepDocumentSearchComponent,
    data: { claimType: 'deep_search_deep_search' },
    canActivate: [AuthGuard]
  },
  {
    path: 'add',
    component: DocumentManageComponent,
    data: { claimType: 'all_documents_create_document' },
    canActivate: [AuthGuard]
  },
  {
    path: ':id',
    component: DocumentManageComponent,
    resolve: {
      document: DocumentManageResolver
    },
    data: { claimType: 'all_documents_edit_document' },
    canActivate: [AuthGuard]
  }, {
    path: 'permission',
    data: { claimType: 'all_documents_share_document' },
    loadChildren: () =>
      import('./document-permission/document-permission.module')
        .then(m => m.DocumentPermissionModule)
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class DocumentRoutingModule { }
