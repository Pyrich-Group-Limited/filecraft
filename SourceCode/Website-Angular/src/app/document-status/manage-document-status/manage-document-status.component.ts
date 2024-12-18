import { Component, Inject, inject, OnInit } from '@angular/core';
import {
  FormGroup,
  FormBuilder,
  Validators,
  ReactiveFormsModule,
} from '@angular/forms';
import {
  MAT_DIALOG_DATA,
  MatDialogModule,
  MatDialogRef,
} from '@angular/material/dialog';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { DocumentStatusService } from '../document-status.service';
import { ToastrService } from 'ngx-toastr';
import { Router, RouterModule } from '@angular/router';
import { DocumentStatus } from '../document-status';
import { TranslateModule } from '@ngx-translate/core';
import { CommonModule } from '@angular/common';
import { ColorPickerModule } from 'ngx-color-picker';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { FeatherModule } from 'angular-feather';
import { TranslationService } from '@core/services/translation.service';
import { SharedModule } from '@shared/shared.module';

@Component({
  selector: 'app-manage-document-status',
  standalone: true,
  imports: [
    ReactiveFormsModule,
    MatDialogModule,
    MatFormFieldModule,
    MatInputModule,
    RouterModule,
    TranslateModule,
    CommonModule,
    ColorPickerModule,
    MatIconModule,
    MatButtonModule,
    FeatherModule,
    SharedModule
  ],
  templateUrl: './manage-document-status.component.html',
  styleUrl: './manage-document-status.component.scss',
})
export class ManageDocumentStatusComponent implements OnInit {
  public isLoading: boolean = false;
  isEditMode: boolean = false;
  documentStatusForm: FormGroup;
  colorCode: string = '#ffffff'; // default color

  public dialogRef = inject(MatDialogRef<ManageDocumentStatusComponent>);
  public documentStatusService = inject(DocumentStatusService);
  private toastrService = inject(ToastrService);
  private translationService = inject(TranslationService);
  private fb = inject(FormBuilder);
  private router = inject(Router);

  constructor(@Inject(MAT_DIALOG_DATA) public data: DocumentStatus) {}

  ngOnInit(): void {
    this.createDocumentStatusForm();
  }

  createDocumentStatusForm(): void {
    this.colorCode = this.data?.colorCode ?? '#ffffff';
    this.documentStatusForm = this.fb.group({
      name: [
        this.data?.name ?? '',
        [Validators.required],
      ],
      description: [this.data?.description ?? '', Validators.required],
    });
  }

  saveDocumentStatus(): void {
    if (!this.documentStatusForm.valid) {
      this.documentStatusForm.markAllAsTouched(); 
      return; 
    }

    this.isLoading = true;

    if (this.data) {
      const id = this.data.id;
      const documentStatus = {
        ...this.documentStatusForm.value,
        id: id,
        colorCode: this.colorCode,
      };
      this.documentStatusService.updateDocumentStatus(documentStatus).subscribe({
        next: (c) => {
          this.toastrService.success(this.translationService.getValue('DOCUMENT_STATUS_UPDATED_SUCCESSFULLY'));
          this.dialogRef.close(c);
          this.isLoading = false;
        },
        error: () => {
          this.isLoading = false;
        },
      });
    } else {
      const documentStatus = {
        ...this.documentStatusForm.value,
        colorCode: this.colorCode,
      };
      this.documentStatusService.addDocumentStatus(documentStatus).subscribe({
        next: (c) => {
          this.toastrService.success(this.translationService.getValue('DOCUMENT_STATUS_CREATED_SUCCESSFULLY'));
          this.dialogRef.close(c);
          this.isLoading = false;
        },
        error: () => {
          this.isLoading = false;
        },
      });
    }
  }

  closeDialog() {
    this.dialogRef.close();
  }
}
