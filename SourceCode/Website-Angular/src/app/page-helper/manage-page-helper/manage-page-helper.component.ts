import { Component, OnInit } from '@angular/core';
import { PageHelper } from '@core/domain-classes/pageHelper';
import { BaseComponent } from 'src/app/base.component';
import {
  UntypedFormGroup,
  UntypedFormBuilder,
  Validators,
} from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { CommonService } from '@core/services/common.service';
import { TranslationService } from '@core/services/translation.service';
import { ToastrService } from 'ngx-toastr';
import { PageHelperService } from '../page-helper.service';
import ClassicEditor from '@ckeditor/ckeditor5-build-classic';
import { HttpClient } from '@angular/common/http';
import { environment } from '@environments/environment';

@Component({
  selector: 'app-manage-page-helper',
  templateUrl: './manage-page-helper.component.html',
  styleUrls: ['./manage-page-helper.component.css'],
})
export class ManagePageHelperComponent extends BaseComponent implements OnInit {
  pageHelper: PageHelper;
  pageHelperForm: UntypedFormGroup;
  editor = ClassicEditor;
  isEditMode = false;
  constructor(
    private fb: UntypedFormBuilder,
    private router: Router,
    private activeRoute: ActivatedRoute,
    private pageHelperService: PageHelperService,
    private toastrService: ToastrService,
    private commonService: CommonService,
    private translationService: TranslationService,
    private http: HttpClient
  ) {
    super();
  }

  ngOnInit(): void {
    this.createPageHelperForm();
    this.sub$.sink = this.activeRoute.data.subscribe(
      (data: { pageHelper: PageHelper }) => {
        if (data.pageHelper) {
          this.isEditMode = true;
          this.pageHelperForm.patchValue(data.pageHelper);
          this.pageHelper = data.pageHelper;
        }
      }
    );
  }

  createPageHelperForm() {
    this.pageHelperForm = this.fb.group({
      id: [''],
      name: ['', [Validators.required]],
      description: ['', [Validators.required]],
    });
  }

  createBuildObject(): PageHelper {
    const pageHelper: PageHelper = {
      id: this.pageHelperForm.get('id').value,
      name: this.pageHelperForm.get('name').value,
      description: this.pageHelperForm.get('description').value,
    };
    return pageHelper;
  }

  saveUser() {
    if (this.pageHelperForm.valid) {
      const pageHelper = this.createBuildObject();
      if (this.isEditMode) {
        this.sub$.sink = this.pageHelperService
          .updatePageHelper(pageHelper)
          .subscribe(() => {
            this.toastrService.success(
              this.translationService.getValue(
                'PAGE_HELPER_UPDATED_SUCCESSFULLY'
              )
            );
            this.router.navigate(['/page-helper']);
          });
      } else {
        this.sub$.sink = this.pageHelperService
          .addPageHelper(pageHelper)
          .subscribe(() => {
            this.toastrService.success(
              this.translationService.getValue(
                'PAGE_HELPER_CREATED_SUCCESSFULLY'
              )
            );
            this.router.navigate(['/page-helper']);
          });
      }
    } else {
      this.toastrService.error(
        this.translationService.getValue('PLEASE_ENTER_PROPER_DATA')
      );
    }
  }

  onReady(editor: ClassicEditor): void {
    editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
      return new MyUploadAdapter(
        loader,
        this.http,
        this.toastrService,
        this.translationService
      );
    };
  }
}

class MyUploadAdapter {
  constructor(
    private loader: any,
    private http: HttpClient,
    private toastrService: ToastrService,
    private translationService: TranslationService
  ) { }
  upload() {
    const url = `Document/upload/image`;
    // const url = 'Document/upload';
    return this.loader.file.then(
      (file) =>
        new Promise((resolve, reject) => {
          var formData = new FormData();
          formData.append('upload', file);
          return this.http.post(url, formData).subscribe({
            next: (data: any) => {
              resolve({
                default: `${environment.apiUrl}${data.url}`,
              });
            },
            error: (error) => {
              this.toastrService.error(
                this.translationService.getValue('ERROR_WHILE_UPLOADING_IMAGE')
              );
              reject();
            }
          });
        })
    );
  }
  abort() {
    console.error('aborted');
  }
}
