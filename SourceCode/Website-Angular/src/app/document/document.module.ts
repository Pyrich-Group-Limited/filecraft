import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DocumentRoutingModule } from './document-routing.module';
import { DocumentListComponent } from './document-list/document-list.component';
import { DocumentManageComponent } from './document-manage/document-manage.component';
import { FormGroup, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatTableModule } from '@angular/material/table';
import { MatDialogModule } from '@angular/material/dialog';
import { MatSelectModule } from '@angular/material/select';
import { MatSlideToggleModule } from '@angular/material/slide-toggle';
import { DocumentManagePresentationComponent } from './document-manage-presentation/document-manage-presentation.component';
import { DocumentEditComponent } from './document-edit/document-edit.component';
import { MatSortModule } from '@angular/material/sort';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatInputModule } from '@angular/material/input';
import { SharedModule } from '@shared/shared.module';
import { MatProgressBarModule } from '@angular/material/progress-bar';
import { DocumentPermissionModule } from './document-permission/document-permission.module';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatMenuModule } from '@angular/material/menu';
import { SendEmailComponent } from './send-email/send-email.component';
import { CKEditorModule } from '@ckeditor/ckeditor5-angular';
import { DocumentReminderComponent } from './document-reminder/document-reminder.component';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatRadioModule } from '@angular/material/radio';
import { DocumentCommentComponent } from './document-comment/document-comment.component';
import { DocumentUploadNewVersionComponent } from './document-upload-new-version/document-upload-new-version.component';
import { DocumentVersionHistoryComponent } from './document-version-history/document-version-history.component';
import { StorageTypePipe } from '../storage-setting/storage-type.pipe';
import { MatFormFieldModule } from '@angular/material/form-field';
import { FeatherModule } from 'angular-feather';
import { NgxMaterialTimepickerModule } from 'ngx-material-timepicker';
import { MatTooltipModule } from '@angular/material/tooltip';
import { PipesModule } from '@shared/pipes/pipes.module';
import { DeepDocumentSearchComponent } from './deep-document-search/deep-document-search.component';
import { MatExpansionModule } from '@angular/material/expansion';

@NgModule({
  declarations: [
    DocumentListComponent,
    DocumentManageComponent,
    DocumentManagePresentationComponent,
    DocumentEditComponent,
    SendEmailComponent,
    DocumentReminderComponent,
    DocumentCommentComponent,
    DocumentUploadNewVersionComponent,
    DocumentVersionHistoryComponent,
    DeepDocumentSearchComponent
  ],
  imports: [
    CommonModule,
    DocumentRoutingModule,
    ReactiveFormsModule,
    MatTableModule,
    MatDialogModule,
    MatSelectModule,
    MatSlideToggleModule,
    MatSortModule,
    MatPaginatorModule,
    MatInputModule,
    MatDatepickerModule,
    MatIconModule,
    MatButtonModule,
    SharedModule,
    MatProgressBarModule,
    DocumentPermissionModule,
    MatCheckboxModule,
    MatMenuModule,
    CKEditorModule,
    MatRadioModule,
    StorageTypePipe,
    MatFormFieldModule,
    FeatherModule,
    NgxMaterialTimepickerModule,
    MatTooltipModule,
    PipesModule,
    FormsModule,
    MatExpansionModule
  ]
})
export class DocumentModule { }
