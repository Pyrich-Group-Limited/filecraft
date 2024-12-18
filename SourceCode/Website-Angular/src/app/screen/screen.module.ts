import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ScreenListComponent } from './screen-list/screen-list.component';
import { ScreenRoutingModule } from './screen-routing.module';
import { MatTableModule } from '@angular/material/table';
import { ManageScreenComponent } from './manage-screen/manage-screen.component';
import { MatDialogModule } from '@angular/material/dialog';
import { FormsModule } from '@angular/forms';
import { ScreenListPresentationComponent } from './screen-list-presentation/screen-list-presentation.component';
import { SharedModule } from '@shared/shared.module';
import { FeatherModule } from 'angular-feather';

@NgModule({
  declarations: [
    ScreenListComponent,
    ManageScreenComponent,
    ScreenListPresentationComponent,
  ],
  imports: [
    CommonModule,
    FormsModule,
    ScreenRoutingModule,
    MatTableModule,
    MatDialogModule,
    SharedModule,
    FeatherModule,
  ],
})
export class ScreenModule {}
