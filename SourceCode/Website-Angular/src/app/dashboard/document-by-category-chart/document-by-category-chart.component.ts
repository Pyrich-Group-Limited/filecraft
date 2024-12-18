import { Component, inject, OnInit } from '@angular/core';
import { DashboradService } from '../dashboard.service';
import { ClonerService } from '../../core/services/clone.service';
import { delay } from 'rxjs';
import { BreakpointsService } from '@core/services/breakpoints.service';

@Component({
  selector: 'app-document-by-category-chart',
  templateUrl: './document-by-category-chart.component.html',
  styleUrls: ['./document-by-category-chart.component.scss']
})
export class DocumentByCategoryChartComponent implements OnInit {

  isLoading: boolean = true;
  private cloneService = inject(ClonerService);
  private dashboardService = inject(DashboradService);
  private breakpointsService = inject(BreakpointsService);
  echartsInstance = null;

  pieChartOptions = {
    title: {
      text: '',
      left: 'center'
    },
    tooltip: {
      trigger: 'item'
    },
    legend: {
      orient: 'horizontal',
      left: this.breakpointsService.isMobile$.value ? 'center' : 'left'
    },
    series: [
      {
        name: 'Documents',
        type: 'pie',
        radius: '50%',
        data: [], // Initialize with empty data
        emphasis: {
          itemStyle: {
            shadowBlur: 10,
            shadowOffsetX: 0,
            shadowColor: 'rgba(0, 0, 0, 0.5)'
          }
        }
      }
    ]
  };
  ngOnInit(): void {
    this.getDocumentCategoryChartData();
  }

  getDocumentCategoryChartData() {
    this.dashboardService.getDocumentByCategory()
      .subscribe(data => {
        this.isLoading = false;
        const chartData = data.map(c => {
          return {
            name: c.categoryName,
            value: c.documentCount
          };
        }, error => {
          this.isLoading = false;
        });
        this.updateChartData(this.cloneService.deepClone(chartData));
      });
  }

  updateChartData(newData: any) {
    this.pieChartOptions = {
      ...this.pieChartOptions,
      series: [
        {
          ...this.pieChartOptions.series[0],
          data: newData  // Updated series data
        }
      ]
    };
  }

  onChartInit(ec) {
    this.echartsInstance = ec;
  }


}
