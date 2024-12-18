import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DashboardRoutingModule } from './dashboard-routing.module';
import { MatSortModule } from '@angular/material/sort';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatTableModule } from '@angular/material/table';
import { MatCardModule } from '@angular/material/card';
import { SharedModule } from '../shared/shared.module';
import { FullCalendarModule } from '@fullcalendar/angular';
import { NgxEchartsModule } from 'ngx-echarts';

import { DashboardComponent } from './dashboard.component';
import { DocumentByCategoryChartComponent } from './document-by-category-chart/document-by-category-chart.component';
import { CalenderViewComponent } from './calender-view/calender-view.component';
import { MatTooltipModule } from '@angular/material/tooltip';
import * as echarts from 'echarts';

@NgModule({
  declarations: [
    DashboardComponent,
    DocumentByCategoryChartComponent,
    CalenderViewComponent
  ],
  imports: [
    CommonModule,
    DashboardRoutingModule,
    MatSortModule,
    MatPaginatorModule,
    MatTableModule,
    MatCardModule,
    SharedModule,
    FullCalendarModule,
    MatTooltipModule,
    NgxEchartsModule.forRoot({ echarts })
  ]
})
export class DashboardModule { }