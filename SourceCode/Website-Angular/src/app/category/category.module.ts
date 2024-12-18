import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CategoryRoutingModule } from './category-routing.module';
import { CategoryListComponent } from './category-list/category-list.component';
import { ManageCategoryComponent } from './manage-category/manage-category.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatTableModule } from '@angular/material/table';
import { MatDialogModule } from '@angular/material/dialog';
import { CategoryListPresentationComponent } from './category-list-presentation/category-list-presentation.component';
import { SharedModule } from '@shared/shared.module';
import { FeatherModule } from 'angular-feather';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';

@NgModule({
  declarations: [
    CategoryListComponent,
    ManageCategoryComponent,
    CategoryListPresentationComponent,
  ],
  imports: [
    CommonModule,
    CategoryRoutingModule,
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    MatTableModule,
    MatDialogModule,
    SharedModule,
    MatButtonModule,
    MatIconModule,
    FeatherModule,
  ],
})
export class CategoryModule {}
