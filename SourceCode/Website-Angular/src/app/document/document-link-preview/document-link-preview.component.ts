import { Component, inject, Input, OnInit } from '@angular/core';
import { MatDialog, MatDialogModule } from '@angular/material/dialog';
import { ActivatedRoute, RouterModule } from '@angular/router';
import { DocumentShareableLink } from '@core/domain-classes/DocumentShareableLink';
import { ClonerService } from '@core/services/clone.service';
import { OverlayPanel } from '@shared/overlay-panel/overlay-panel.service';
import { DocumentLinkPreviewPasswordComponent } from './document-link-preview-password/document-link-preview-password.component';
import { DocumentInfo } from '@core/domain-classes/document-info';
import { BasePreviewComponent } from '@shared/base-preview/base-preview.component';
import { DocumentService } from 'src/app/document/document.service';
import { DocumentView } from '@core/domain-classes/document-view';
import { SharedModule } from '@shared/shared.module';
import { CommonModule, NgIf } from '@angular/common';
import { ReactiveFormsModule } from '@angular/forms';
import { OverlayModule } from '@angular/cdk/overlay';
import { NgxDocViewerModule } from 'ngx-doc-viewer';
import { NgxExtendedPdfViewerModule } from 'ngx-extended-pdf-viewer';
import { PipesModule } from '@shared/pipes/pipes.module';
import { MatButtonModule } from '@angular/material/button'; // For Material buttons
import { MatIconModule } from '@angular/material/icon'; // For Material icons

@Component({
  selector: 'app-document-link-preview',
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
    MatDialogModule, // Required for MatDialog
    RouterModule, // Required for ActivatedRoute
    MatButtonModule, // For buttons
    MatIconModule, // For icons
  ],
  templateUrl: './document-link-preview.component.html',
  styleUrls: ['./document-link-preview.component.scss'], // Corrected "styleUrl" to "styleUrls"
})
export class DocumentLinkPreviewComponent implements OnInit {
  @Input() documents: DocumentInfo[] = [];
  isLinkExpired = false;
  code: string;
  private route = inject(ActivatedRoute);
  private overlay = inject(OverlayPanel);
  private dialog = inject(MatDialog);
  private clonerService = inject(ClonerService);
  private documentService = inject(DocumentService);

  ngOnInit(): void {
    this.code = this.route.snapshot.params.code;
    this.getLinkInfo();
  }

  getLinkInfo() {
    this.documentService.getLinkInfoByCode(this.code).subscribe({
      next: (info: DocumentShareableLink) => {
        if (info.isLinkExpired) {
          this.isLinkExpired = true;
        } else {
          this.getDocument(info);
        }
      },
      error: () => {
        this.isLinkExpired = true;
      },
    });
  }

  getDocument(info: DocumentShareableLink) {
    this.documentService.getDocumentByCode(this.code).subscribe(
      (document: DocumentInfo) => {
        const urls = document.url.split('.');
        const extension = urls[1];
        const documentView: DocumentView = {
          documentId: this.code,
          name: document.name,
          extension: extension,
          isVersion: false,
          isFromPublicPreview: true,
          isPreviewDownloadEnabled: document.isAllowDownload,
        };
        if (info.hasPassword) {
          this.openForgotPasswordDialog(info, documentView);
        } else {
          this.overlay.open(BasePreviewComponent, {
            position: 'center',
            origin: 'global',
            panelClass: ['file-preview-overlay-container', 'white-background'],
            data: documentView,
            closeOnBackdropClick: false,
          });
        }
      },
      () => {
        this.isLinkExpired = true;
      }
    );
  }

  openForgotPasswordDialog(
    info: DocumentShareableLink,
    documentView: DocumentView
  ) {
    const dialogRef = this.dialog.open(DocumentLinkPreviewPasswordComponent, {
      data: { linkInfo: info, docView: documentView },
      disableClose: true,
      backdropClass: 'black-background',
      width: '500px',
    });
    dialogRef.afterClosed().subscribe((password: string) => {
      documentView.linkPassword = password;
      const overlayRef = this.overlay.open(BasePreviewComponent, {
        position: 'center',
        origin: 'global',
        panelClass: ['file-preview-overlay-container', 'white-background'],
        data: documentView,
        closeOnBackdropClick: false,
      });

      overlayRef.afterClosed().subscribe(() => {
        this.openForgotPasswordDialog(info, documentView);
      });
    });
  }
}
