import { Component, Inject, OnInit } from '@angular/core';
import {
  UntypedFormBuilder,
  UntypedFormGroup,
  ReactiveFormsModule,
  AbstractControl,
  AbstractControlOptions,
} from '@angular/forms';
import {
  MAT_DIALOG_DATA,
  MatDialogModule,
  MatDialogRef,
} from '@angular/material/dialog';
import { CommonDialogService } from '@core/common-dialog/common-dialog.service';
import { DocumentInfo } from '@core/domain-classes/document-info';
import { ToastrService } from 'ngx-toastr';
import { BaseComponent } from 'src/app/base.component';
import { DocumentService } from '../document.service';
import { DocumentShareableLink } from '@core/domain-classes/DocumentShareableLink';
import { NgIf } from '@angular/common';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { SharedModule } from '@shared/shared.module';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { NgxMaterialTimepickerModule } from 'ngx-material-timepicker';
import { ClipboardModule } from '@angular/cdk/clipboard';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatNativeDateModule } from '@angular/material/core';
import { FeatherModule } from 'angular-feather';
import { MatButtonModule } from '@angular/material/button';
import { TranslationService } from '@core/services/translation.service';

@Component({
  standalone: true,
  imports: [
    ReactiveFormsModule,
    NgIf,
    SharedModule,
    MatNativeDateModule,
    MatCheckboxModule,
    MatDatepickerModule,
    NgxMaterialTimepickerModule,
    ClipboardModule,
    MatTooltipModule,
    MatDialogModule,
    MatButtonModule,
    FeatherModule,
  ],
  templateUrl: './document-shared-link.component.html',
  styleUrl: './document-shared-link.component.scss',
})
export class DocumentSharedLinkComponent
  extends BaseComponent
  implements OnInit
{
  documentLinkForm: UntypedFormGroup;
  isEditMode = false;
  isResetLink = false;
  minDate = new Date();
  isLoading = false;
  baseUrl = `${window.location.protocol}//${window.location.host}/preview/`;

  constructor(
    public dialogRef: MatDialogRef<DocumentSharedLinkComponent>,
    @Inject(MAT_DIALOG_DATA)
    public data: { document: DocumentInfo; link: DocumentShareableLink },
    private fb: UntypedFormBuilder,
    private documentService: DocumentService,
    private toastrService: ToastrService,
    private commonDialogService: CommonDialogService,
    private translationService: TranslationService
  ) {
    super();
  }

  ngOnInit(): void {
    this.createDocumentLinkForm();
    if (this.data.link) {
      if (this.data.link.id) {
        this.isEditMode = true;
        this.pathValue();
      }
    }
  }

  timeValidator(control: AbstractControl) {
    const linkExpiryTime = control.get('linkExpiryTime')?.value;
    const linkExpiryDate = control.get('linkExpiryDate')?.value;

    if (linkExpiryDate && !linkExpiryTime) {
      control.get('linkExpiryTime')?.setErrors({ required: true });
    } else {
      control.get('linkExpiryDate')?.setErrors(null);
    }
    return null;
  }

  pathValue() {
    this.documentLinkForm.patchValue(this.data.link);
    this.documentLinkForm
      .get('linkCode')
      .setValue(`${this.baseUrl}${this.data.link.linkCode}`);

    if (this.data.link.linkExpiryTime) {
      const expiryDate = new Date(this.data.link.linkExpiryTime);
      const hours = expiryDate.getHours().toString().padStart(2, '0');
      const minutes = expiryDate.getMinutes().toString().padStart(2, '0');

      this.documentLinkForm.get('linkExpiryDate').setValue(expiryDate);
      this.documentLinkForm
        .get('linkExpiryTime')
        .setValue(`${hours}:${minutes}`);
      this.documentLinkForm.get('isLinkExpiryTime').setValue(true);
    }

    if (this.data.link.password) {
      this.documentLinkForm.get('isPassword').setValue(true);
    }
  }

  createDocumentLinkForm() {
    var currentDate = new Date();
    this.documentLinkForm = this.fb.group(
      {
        id: [''],
        isLinkExpiryTime: [false],
        linkExpiryDate: [currentDate],
        linkExpiryTime: ['12:00'],
        isPassword: [false],
        password: [''],
        linkCode: [''],
        isAllowDownload: [false],
      },
      {
        validators: [this.checkData, this.timeValidator],
      } as AbstractControlOptions
    );
  }

  checkData(group: UntypedFormGroup) {
    let isLinkExpiryTime = group.get('isLinkExpiryTime').value;
    let linkExpiryDate = group.get('linkExpiryDate').value;
    let isPassword = group.get('isPassword').value;
    let password = group.get('password').value;
    const data = {};
    if (isLinkExpiryTime && !linkExpiryDate) {
      data['linkExpiryDateValidator'] = true;
    }
    if (isPassword && !password) {
      data['passwordValidator'] = true;
    }
    return data;
  }

  openLinkSettings() {
    this.isResetLink = !this.isResetLink;
  }

  createLink() {
    if (!this.documentLinkForm.valid) {
      this.documentLinkForm.markAllAsTouched();
      return;
    }
    const link = this.createBuildObject();
    this.isLoading = true;
    this.sub$.sink = this.documentService
      .createDocumentShareableLink(link)
      .subscribe(
        (data: DocumentShareableLink) => {
          this.toastrService.success(
            this.translationService.getValue('LINK_GENERATED_SUCCESSFULLY')
          );
          this.data.link = data;
          this.isEditMode = true;
          this.isResetLink = false;
          this.isLoading = false;
          this.pathValue();
        },
        () => (this.isLoading = false)
      );
  }

  deleteDocumentLink() {
    this.sub$.sink = this.commonDialogService
      .deleteConformationDialog(
        this.translationService.getValue('ARE_YOU_SURE_YOU_WANT_TO_DELETE')
      )
      .subscribe((isTrue: boolean) => {
        if (isTrue) {
          this.isLoading = true;
          this.sub$.sink = this.documentService
            .deleteDocumentShareableLInk(this.data.link.id)
            .subscribe(
              () => {
                this.isLoading = false;
                this.toastrService.success(
                  this.translationService.getValue(
                    'DOCUMENT_LINK_DELETED_SUCCESSFULLY'
                  )
                );
                this.dialogRef.close();
              },
              () => (this.isLoading = false)
            );
        }
      });
  }

  closeDialog() {
    this.dialogRef.close();
  }

  createBuildObject(): DocumentShareableLink {
    const id: string = this.documentLinkForm.get('id').value;
    let linkCode: string = this.documentLinkForm.get('linkCode').value;
    if (linkCode) {
      linkCode = linkCode.replace(this.baseUrl, '');
    }

    let combinedExpiryDate = null;
    if (this.documentLinkForm.get('isLinkExpiryTime').value) {
      const expiryDate = new Date(
        this.documentLinkForm.get('linkExpiryDate').value
      );
      const expiryTime = this.documentLinkForm.get('isLinkExpiryTime').value
        ? this.documentLinkForm.get('linkExpiryTime').value
        : '';
      if (expiryTime && typeof expiryTime === 'string') {
        const [hours, minutes] = expiryTime.split(':').map(Number);
        combinedExpiryDate = new Date(
          expiryDate.getFullYear(),
          expiryDate.getMonth(),
          expiryDate.getDate(),
          hours,
          minutes
        );
      }
    }

    const link: DocumentShareableLink = {
      id: id,
      documentId: this.data.document.id,
      isAllowDownload: this.documentLinkForm.get('isAllowDownload').value,
      password: this.documentLinkForm.get('isPassword').value
        ? this.documentLinkForm.get('password').value
        : '',
      linkExpiryTime: combinedExpiryDate,
      linkCode: linkCode,
    };
    return link;
  }
}
