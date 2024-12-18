import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReminderListComponent } from './reminder-list/reminder-list.component';
import { ReminderRoutingModule } from './reminder-routing.module';
import { AddReminderComponent } from './add-reminder/add-reminder.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatSelectModule } from '@angular/material/select';
import { MatInputModule } from '@angular/material/input';
import { SharedModule } from '@shared/shared.module';
import { MatDialogModule } from '@angular/material/dialog';
import { MatSlideToggleModule } from '@angular/material/slide-toggle';
import { MatMenuModule } from '@angular/material/menu';
import { MatButtonModule } from '@angular/material/button';
import { MatCardModule } from '@angular/material/card';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatSortModule } from '@angular/material/sort';
import { MatTableModule } from '@angular/material/table';
import { MatButtonToggleModule } from '@angular/material/button-toggle';
import { MatRadioModule } from '@angular/material/radio';
import { MatIconModule } from '@angular/material/icon';
import { ReminderDetailResolverService } from './add-reminder/reminder-detail.resolver';
import { PipesModule } from '@shared/pipes/pipes.module';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatNativeDateModule } from '@angular/material/core';
import { NgxMaterialTimepickerModule } from 'ngx-material-timepicker';
import { FeatherModule } from 'angular-feather';

@NgModule({
  declarations: [
    AddReminderComponent,
    ReminderListComponent
  ],
  imports: [
    CommonModule,
    FormsModule,
    ReminderRoutingModule,
    MatCheckboxModule,
    MatDialogModule,
    MatSelectModule,
    MatSlideToggleModule,
    SharedModule,
    ReactiveFormsModule,
    MatMenuModule,
    MatButtonModule,
    MatCardModule,
    MatPaginatorModule,
    MatSortModule,
    MatInputModule,
    MatTableModule,
    MatButtonToggleModule,
    MatRadioModule,
    MatIconModule,
    PipesModule,
    MatDatepickerModule,
    MatNativeDateModule,
    NgxMaterialTimepickerModule,
    FeatherModule
  ],
  providers: [
    ReminderDetailResolverService
  ]
})
export class ReminderModule { }
