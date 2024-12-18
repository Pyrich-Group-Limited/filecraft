import { Component, OnInit } from '@angular/core';
import { BaseComponent } from 'src/app/base.component';
import { PageHelperService } from '../page-helper.service';
import { ToastrService } from 'ngx-toastr';
import { TranslationService } from '@core/services/translation.service';
import { Observable } from 'rxjs';
import { PageHelper } from '@core/domain-classes/pageHelper';
import { CommonError } from '@core/error-handler/common-error';

@Component({
  selector: 'app-page-helper-list',
  templateUrl: './page-helper-list.component.html',
  styleUrls: ['./page-helper-list.component.css']
})
export class PageHelperListComponent extends BaseComponent implements OnInit {
  pageHelpers: Observable<PageHelper | CommonError>;

  constructor(
    private pageHelperService: PageHelperService
  ) {
    super();
  }
  ngOnInit(): void {
    this.getPageHelpers();
  }

  getPageHelpers(): void {
    this.pageHelpers = this.pageHelperService.getPageHelpers();
  }

  // deletePageHelper(id: string): void {
  //   this.pageHelperService.deletePageHelper(id).subscribe(d => {
  //     this.toastrService.success(this.translationService.getValue(`PAGE_HELPER_DELETED_SUCCESSFULLY`));
  //     this.getPageHelpers();
  //   });

  // }
}

