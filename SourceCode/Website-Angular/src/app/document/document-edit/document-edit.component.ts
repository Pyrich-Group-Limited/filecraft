import { Component, Inject, Input, OnInit } from '@angular/core';
import {
  FormArray,
  FormGroup,
  UntypedFormBuilder,
  UntypedFormGroup,
  Validators,
} from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { Category } from '@core/domain-classes/category';
import { DocumentAuditTrail } from '@core/domain-classes/document-audit-trail';
import { DocumentInfo } from '@core/domain-classes/document-info';
import { DocumentOperation } from '@core/domain-classes/document-operation';
import { DocumentMetaData } from '@core/domain-classes/documentMetaData';
import { CommonService } from '@core/services/common.service';
import { TranslationService } from '@core/services/translation.service';
import { ToastrService } from 'ngx-toastr';
import { BaseComponent } from 'src/app/base.component';
import { DocumentService } from '../document.service';
import { DocumentStatus } from 'src/app/document-status/document-status';
import { DocumentCategoryStatus } from '@core/domain-classes/document-category';
import { CategoryService } from '@core/services/category.service';
import { DocumentStatusService } from 'src/app/document-status/document-status.service';

@Component({
  selector: 'app-document-edit',
  templateUrl: './document-edit.component.html',
  styleUrls: ['./document-edit.component.scss'],
})
export class DocumentEditComponent extends BaseComponent implements OnInit {
  document: DocumentInfo;
  documentForm: UntypedFormGroup;
  extension: string = '';
  documentSource: string;
  allCategories: Category[] = [];
  documentStatuses: DocumentStatus[] = [];

  get documentMetaTagsArray(): FormArray {
    return <FormArray>this.documentForm.get('documentMetaTags');
  }

  constructor(
    private fb: UntypedFormBuilder,
    public dialogRef: MatDialogRef<DocumentEditComponent>,
    @Inject(MAT_DIALOG_DATA) public data: DocumentCategoryStatus,
    private toastrService: ToastrService,
    private documentService: DocumentService,
    private commonService: CommonService,
    private translationService: TranslationService,
    private categoryService: CategoryService,
    private documentStatusService: DocumentStatusService
  ) {
    super();
  }

  ngOnInit(): void {
    this.createDocumentForm();
    this.pushValuesDocumentMetatagArray();
    this.patchDocumentForm();
    this.getCategories();
    this.populateDocumentStatus();
  }

  populateDocumentStatus() {
    if (
      this.data &&
      this.data.documentStatuses &&
      this.data.documentStatuses.length > 0
    ) {
      this.documentStatuses = [...this.data.documentStatuses];
    } else {
      this.documentStatusService
        .getDocumentStatuss()
        .subscribe((c: DocumentStatus[]) => {
          if (c && c.length > 0) {
            this.documentStatuses = [...c];
          }
        });
    }
  }

  getCategories(): void {
    if (this.data.categories && this.data.categories.length > 0) {
      this.setDeafLevel();
    } else {
      this.categoryService
        .getAllCategoriesForDropDown()
        .subscribe((c: Category[]) => {
          if (c && c.length > 0) {
            this.data.categories = [...c];
            this.setDeafLevel();
          }
        });
    }
  }

  setDeafLevel(parent?: Category, parentId?: string) {
    const children = this.data.categories.filter((c) => c.parentId == parentId);
    if (children.length > 0) {
      children.map((c, index) => {
        c.deafLevel = parent ? parent.deafLevel + 1 : 0;
        c.index =
          (parent ? parent.index : 0) + index * Math.pow(0.1, c.deafLevel);
        this.allCategories.push(c);
        this.setDeafLevel(c, c.id);
      });
    }
    return parent;
  }

  patchDocumentForm() {
    this.documentForm.patchValue({
      name: this.data.document.name,
      description: this.data.document.description,
      categoryId: this.data.document.categoryId,
      documentStatusId: this.data.document.documentStatusId,
    });
  }

  createDocumentForm() {
    this.documentForm = this.fb.group({
      name: ['', [Validators.required]],
      description: [''],
      categoryId: ['', [Validators.required]],
      documentStatusId: [''],
      documentMetaTags: this.fb.array([]),
    });
  }

  SaveDocument() {
    if (this.documentForm.valid) {
      this.sub$.sink = this.documentService
        .updateDocument(this.buildDocumentObject())
        .subscribe((c) => {
          this.toastrService.success(
            this.translationService.getValue('DOCUMENT_UPDATE_SUCCESSFULLY')
          );
          this.addDocumentTrail();
        });
    } else {
      this.markFormGroupTouched(this.documentForm);
    }
  }

  addDocumentTrail() {
    const objDocumentAuditTrail: DocumentAuditTrail = {
      documentId: this.data.document.id,
      operationName: DocumentOperation.Modified.toString(),
    };
    this.sub$.sink = this.commonService
      .addDocumentAuditTrail(objDocumentAuditTrail)
      .subscribe((c) => {
        this.dialogRef.close('loaded');
      });
  }

  private markFormGroupTouched(formGroup: UntypedFormGroup) {
    (<any>Object).values(formGroup.controls).forEach((control) => {
      control.markAsTouched();
      if (control.controls) {
        this.markFormGroupTouched(control);
      }
    });
  }

  buildDocumentObject(): DocumentInfo {
    const documentMetaTags = this.documentMetaTagsArray.value;
    const document: DocumentInfo = {
      id: this.data.document.id,
      categoryId: this.documentForm.get('categoryId').value,
      documentStatusId: this.documentForm.get('documentStatusId').value,
      description: this.documentForm.get('description').value,
      name: this.documentForm.get('name').value,
      documentMetaDatas: [...documentMetaTags],
    };
    return document;
  }
  onDocumentCancel() {
    this.dialogRef.close('canceled');
  }

  onAddAnotherMetaTag() {
    const documentMetaTag: DocumentMetaData = {
      id: '',
      documentId: this.document && this.document.id ? this.document.id : '',
      metatag: '',
    };
    this.documentMetaTagsArray.insert(
      0,
      this.editDocmentMetaData(documentMetaTag)
    );
  }

  onDeleteMetaTag(index: number) {
    this.documentMetaTagsArray.removeAt(index);
  }

  buildDocumentMetaTag(): FormGroup {
    return this.fb.group({
      id: [''],
      documentId: [''],
      metatag: [''],
    });
  }

  pushValuesDocumentMetatagArray() {
    this.sub$.sink = this.documentService
      .getdocumentMetadataById(this.data.document.id)
      .subscribe((result: DocumentMetaData[]) => {
        if (result.length > 0) {
          result.map((documentMetatag) => {
            this.documentMetaTagsArray.push(
              this.editDocmentMetaData(documentMetatag)
            );
          });
        } else {
          this.documentMetaTagsArray.push(this.buildDocumentMetaTag());
        }
      });
  }

  onMetatagChange(event: any, index: number) {
    const email = this.documentMetaTagsArray.at(index).get('metatag').value;
    if (!email) {
      return;
    }
    const emailControl = this.documentMetaTagsArray.at(index).get('metatag');
    emailControl.setValidators([Validators.required]);
    emailControl.updateValueAndValidity();
  }

  editDocmentMetaData(documentMetatag: DocumentMetaData): FormGroup {
    return this.fb.group({
      id: [documentMetatag.id],
      documentId: [documentMetatag.documentId],
      metatag: [documentMetatag.metatag],
    });
  }
}
