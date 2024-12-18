import { CommonModule, NgIf } from '@angular/common';
import { Component, inject, Inject, OnInit } from '@angular/core';
import { ReactiveFormsModule, UntypedFormBuilder, UntypedFormGroup, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogModule, MatDialogRef } from '@angular/material/dialog';
import { DocumentShareableLink } from '@core/domain-classes/DocumentShareableLink';
import { SharedModule } from '@shared/shared.module';
import { BaseComponent } from 'src/app/base.component';
import { DocumentService } from '../../document.service';
import { OverlayModule } from '@angular/cdk/overlay';
import { NgxDocViewerModule } from 'ngx-doc-viewer';
import { NgxExtendedPdfViewerModule } from 'ngx-extended-pdf-viewer';
import { PipesModule } from '@shared/pipes/pipes.module';
import { MatButtonModule } from '@angular/material/button'; // For Material buttons
import { MatIconModule } from '@angular/material/icon'; // For Material icons
import { MatInputModule } from '@angular/material/input'; // For Material input fields
import { MatFormFieldModule } from '@angular/material/form-field'; // For Material form fields
import { FeatherModule } from 'angular-feather';

@Component({
  selector: 'app-document-link-preview-password',
  standalone: true,
  imports: [
    SharedModule,
    NgIf,
    ReactiveFormsModule,
    CommonModule,
    OverlayModule,
    NgxDocViewerModule,
    NgxExtendedPdfViewerModule,
    PipesModule,
    MatDialogModule, 
    MatButtonModule,  
    MatIconModule,    
    MatInputModule,   
    MatFormFieldModule,
    FeatherModule 
  ],
  templateUrl: './document-link-preview-password.component.html',
  styleUrls: ['./document-link-preview-password.component.scss'] // Corrected "styleUrl" to "styleUrls"
})
export class DocumentLinkPreviewPasswordComponent extends BaseComponent implements OnInit {
  private documentService = inject(DocumentService);
  documentLinkForm: UntypedFormGroup;
  isPasswordInvalid = false;

  constructor(
    private dialogRef: MatDialogRef<DocumentLinkPreviewPasswordComponent>,
    @Inject(MAT_DIALOG_DATA) public data: DocumentShareableLink,
    private fb: UntypedFormBuilder
  ) {
    super();
  }

  ngOnInit(): void {
    this.createDocumentLinkForm();
  }

  createDocumentLinkForm() {
    this.documentLinkForm = this.fb.group({
      password: ['', [Validators.required]],
    });
  }

  checkPassword() {
    if (this.documentLinkForm.valid) {
      const password = this.documentLinkForm.get('password').value;
      this.dialogRef.close(password);
    } else {
      this.documentLinkForm.markAllAsTouched();
    }
  }
}
