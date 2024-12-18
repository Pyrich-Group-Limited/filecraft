import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DocumentLibraryListComponent } from './document-library-list/document-library-list.component';
import { DocumentLibraryRoutingModule } from './document-library-routing.module';
import { MatTableModule } from '@angular/material/table';
import { MatDialogModule } from '@angular/material/dialog';
import { MatSelectModule } from '@angular/material/select';
import { MatSlideToggleModule } from '@angular/material/slide-toggle';
import { MatSortModule } from '@angular/material/sort';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatInputModule } from '@angular/material/input';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { SharedModule } from '@shared/shared.module';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { DocumentReminderComponent } from './document-reminder/document-reminder.component';

import { AddDocumentComponent } from './add-document/add-document.component';
import { ReminderListComponent } from './reminder-list/reminder-list.component';
import { PipesModule } from '@shared/pipes/pipes.module';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatRadioModule } from '@angular/material/radio';
import { MatMenuModule } from '@angular/material/menu';
import { StorageTypePipe } from '../storage-setting/storage-type.pipe';
import { MatFormFieldModule } from '@angular/material/form-field';
import { FeatherModule } from 'angular-feather';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { NgxMaterialTimepickerModule } from 'ngx-material-timepicker';
import { MatExpansionModule } from '@angular/material/expansion';

@NgModule({
  declarations: [
    DocumentLibraryListComponent,
    DocumentReminderComponent,
    AddDocumentComponent,
    ReminderListComponent,
  ],
  imports: [
    CommonModule,
    SharedModule,
    ReactiveFormsModule,
    DocumentLibraryRoutingModule,
    MatTableModule,
    MatDialogModule,
    MatSelectModule,
    MatSlideToggleModule,
    MatSortModule,
    MatPaginatorModule,
    MatInputModule,
    MatCheckboxModule,
    FormsModule,
    PipesModule,
    MatButtonModule,
    MatIconModule,
    MatRadioModule,
    MatMenuModule,
    StorageTypePipe,
    MatFormFieldModule,
    FeatherModule,
    MatDatepickerModule,
    NgxMaterialTimepickerModule,
    MatExpansionModule
  ],
})
export class DocumentLibraryModule { }
