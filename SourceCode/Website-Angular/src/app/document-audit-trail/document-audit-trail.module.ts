import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { DocumentAuditTrailRoutingModule } from './document-audit-trail-routing.module';
import { DocumentAuditTrailComponent } from './document-audit-trail.component';
import { MatTableModule } from '@angular/material/table';
import { MatSelectModule } from '@angular/material/select';
import { MatSlideToggleModule } from '@angular/material/slide-toggle';
import { MatSortModule } from '@angular/material/sort';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatInputModule } from '@angular/material/input';
import { SharedModule } from '@shared/shared.module';
import { TranslateModule } from '@ngx-translate/core';
import { PipesModule } from '@shared/pipes/pipes.module';
import { MatExpansionModule } from '@angular/material/expansion';


@NgModule({
  declarations: [DocumentAuditTrailComponent],
  imports: [
    CommonModule,
    DocumentAuditTrailRoutingModule,
    MatTableModule,
    MatSelectModule,
    MatSlideToggleModule,
    MatSortModule,
    MatPaginatorModule,
    MatInputModule,
    TranslateModule,
    SharedModule,
    PipesModule,
    MatExpansionModule
  ]
})
export class DocumentAuditTrailModule { }
