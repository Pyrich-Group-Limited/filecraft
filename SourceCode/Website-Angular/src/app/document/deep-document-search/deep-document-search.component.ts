import { SelectionModel } from '@angular/cdk/collections';
import { AfterViewInit, Component, OnInit } from '@angular/core';
import { DocumentInfo } from '@core/domain-classes/document-info';
import { BaseComponent } from 'src/app/base.component';
import { DocumentService } from '../document.service';
import { CommonDialogService } from '@core/common-dialog/common-dialog.service';
import { MatDialog } from '@angular/material/dialog';
import { OverlayPanel } from '@shared/overlay-panel/overlay-panel.service';
import { ClonerService } from '@core/services/clone.service';
import { TranslationService } from '@core/services/translation.service';
import { CommonService } from '@core/services/common.service';
import { ToastrService } from 'ngx-toastr';
import { DocumentOperation } from '@core/domain-classes/document-operation';
import { DocumentCategoryStatus } from '@core/domain-classes/document-category';
import { DocumentCommentComponent } from '../document-comment/document-comment.component';
import { DocumentPermissionListComponent } from '../document-permission/document-permission-list/document-permission-list.component';
import { DocumentPermissionMultipleComponent } from '../document-permission/document-permission-multiple/document-permission-multiple.component';
import { DocumentUploadNewVersionComponent } from '../document-upload-new-version/document-upload-new-version.component';
import { DocumentView } from '@core/domain-classes/document-view';
import { HttpEvent, HttpEventType, HttpResponse } from '@angular/common/http';
import { DocumentAuditTrail } from '@core/domain-classes/document-audit-trail';
import { SendEmailComponent } from '../send-email/send-email.component';
import { DocumentReminderComponent } from '../document-reminder/document-reminder.component';
import { BasePreviewComponent } from '@shared/base-preview/base-preview.component';
import { DocumentVersion } from '@core/domain-classes/documentVersion';
import { DocumentVersionHistoryComponent } from '../document-version-history/document-version-history.component';
import { DocumentShareableLink } from '@core/domain-classes/DocumentShareableLink';
import { DocumentSharedLinkComponent } from '../document-shared-link/document-shared-link.component';
import { MatTableDataSource } from '@angular/material/table';
import { DocumentEditComponent } from '../document-edit/document-edit.component';

@Component({
  selector: 'app-deep-document-search',
  templateUrl: './deep-document-search.component.html',
  styleUrl: './deep-document-search.component.scss'
})
export class DeepDocumentSearchComponent extends BaseComponent
  implements OnInit, AfterViewInit {
  displayedColumns: string[] = [
    'select',
    'action',
    'name',
    'categoryName',
    'documentStatus',
    'storageType',
    'createdDate',
    'createdBy',
  ];
  footerToDisplayed = ['footer'];
  isLoadingResults = false;
  dataSource = [];
  searchQuery: string = '';
  isExactMatch: boolean = false;

  selection = new SelectionModel<DocumentInfo>(true, []);
  constructor(
    private documentService: DocumentService,
    private commonDialogService: CommonDialogService,
    private dialog: MatDialog,
    public overlay: OverlayPanel,
    public clonerService: ClonerService,
    private translationService: TranslationService,
    private commonService: CommonService,
    private toastrService: ToastrService
  ) {
    super();
  }

  ngOnInit(): void {
  }

  ngAfterViewInit() {

  }

  /** Whether the number of selected elements matches the total number of rows. */
  isAllSelected() {
    const numSelected = this.selection.selected.length;
    const numRows = this.dataSource.length;
    return numSelected === numRows;
  }
  /** Selects all rows if they are not all selected; otherwise clear selection. */
  masterToggle() {
    this.isAllSelected()
      ? this.selection.clear()
      : this.dataSource.forEach((row) => this.selection.select(row));
  }

  searchDocuments(): void {
    if (this.searchQuery) {
      this.isLoadingResults = true;
      let searchQuery = this.searchQuery.trim();
      if (this.isExactMatch) {
        searchQuery = `"${searchQuery}"`;
      }
      this.sub$.sink = this.documentService
        .getDocumentsByDeepSearch(searchQuery)
        .subscribe({
          next: (resp: DocumentInfo[]) => {
            this.isLoadingResults = false;
            if (resp.length > 0) {
              this.dataSource = [...resp];
            } else {
              this.dataSource = [];
              this.toastrService.info(`${this.translationService.getValue('NO_DATA_FOUND')}`);
            }
          },
          error: (error) => {
            this.dataSource = [];
            this.isLoadingResults = false;
          },
        });
    }
  }


  removeDocumentPageIndexing(document: DocumentInfo) {
    this.sub$.sink = this.commonDialogService
      .deleteConformationDialog(
        `${this.translationService.getValue(
          'ARE_YOU_SURE_WANT_TO_REMOVE_DOCUMENT_PAGE_INDEXING'
        )
        } :: ${document.name}`,
        this.translationService.getValue(
          'DEEP_SEARCH_REMOVE_NOTE'
        )
      )
      .subscribe((isTrue: boolean) => {
        if (isTrue) {
          this.sub$.sink = this.documentService
            .removePageIndexing(document.id)
            .subscribe((c: boolean) => {
              if (c) {
                this.searchDocuments();
                this.toastrService.success(
                  this.translationService.getValue(
                    'DOCUMENT_PAGE_INDEXING_IS_DELETED'
                  )
                );
              }
            });
        }
      });
  }

  editDocument(documentInfo: DocumentInfo) {
    const documentCategories: DocumentCategoryStatus = {
      document: documentInfo,
      categories: [],
      documentStatuses: [],
    };
    const dialogRef = this.dialog.open(DocumentEditComponent, {
      width: '60vw',
      data: Object.assign({}, documentCategories),
    });

    this.sub$.sink = dialogRef.afterClosed().subscribe((result: string) => {
      if (result === 'loaded') {

      }
    });
  }


  addComment(document: Document) {
    const dialogRef = this.dialog.open(DocumentCommentComponent, {
      width: '800px',
      maxHeight: '70vh',
      data: Object.assign({}, document),
    });

    this.sub$.sink = dialogRef.afterClosed().subscribe((result: string) => {
      if (result === 'loaded') {

      }
    });
  }

  manageDocumentPermission(documentInfo: DocumentInfo) {
    this.dialog.open(DocumentPermissionListComponent, {
      data: documentInfo,
      width: '80vw',
      maxHeight: '80vh',
    });
  }
  onSharedSelectDocument() {
    const dialogRef = this.dialog.open(DocumentPermissionMultipleComponent, {
      data: this.selection.selected,
      width: '60vw',
      maxHeight: '80vh',
    });
    dialogRef.afterClosed().subscribe(() => {
      this.selection.clear();
    });
  }

  uploadNewVersion(document: Document) {
    const dialogRef = this.dialog.open(DocumentUploadNewVersionComponent, {
      width: '800px',
      maxHeight: '70vh',
      data: Object.assign({}, document),
    });

    this.sub$.sink = dialogRef
      .afterClosed()
      .subscribe((isNewVersionUploaded: boolean) => {
        if (isNewVersionUploaded) {
        }
      });
  }

  downloadDocument(documentInfo: DocumentInfo) {
    const docuView: DocumentView = {
      documentId: documentInfo.id,
      name: '',
      extension: documentInfo.url.split('.')[1],
      isVersion: false,
      isFromPublicPreview: false,
      isPreviewDownloadEnabled: false,
    };
    this.sub$.sink = this.commonService.downloadDocument(docuView).subscribe({
      next: (event: HttpEvent<Blob>) => {
        if (event.type === HttpEventType.Response) {
          this.addDocumentTrail(
            documentInfo.id,
            DocumentOperation.Download.toString()
          );
          this.downloadFile(event, documentInfo);
        }
      },
      error: (error) => {
        this.toastrService.error(
          this.translationService.getValue('ERROR_WHILE_DOWNLOADING_DOCUMENT')
        );
      }
    });
  }

  addDocumentTrail(id: string, operation: string) {
    const objDocumentAuditTrail: DocumentAuditTrail = {
      documentId: id,
      operationName: operation,
    };
    this.sub$.sink = this.commonService
      .addDocumentAuditTrail(objDocumentAuditTrail)
      .subscribe((c) => { });
  }

  sendEmail(documentInfo: DocumentInfo) {
    this.dialog.open(SendEmailComponent, {
      data: documentInfo,
      width: '80vw',
      maxHeight: '80vh',
    });
  }

  addReminder(documentInfo: DocumentInfo) {
    this.dialog.open(DocumentReminderComponent, {
      data: documentInfo,
      width: '80vw',
      maxHeight: '80vh',
    });
  }

  onDocumentView(document: DocumentInfo) {
    const urls = document.url.split('.');
    const extension = urls[1];
    const documentView: DocumentView = {
      documentId: document.id,
      name: document.name,
      extension: extension,
      isVersion: false,
      isFromPublicPreview: false,
      isPreviewDownloadEnabled: false,
    };
    this.overlay.open(BasePreviewComponent, {
      position: 'center',
      origin: 'global',
      panelClass: ['file-preview-overlay-container', 'white-background'],
      data: documentView,
    });
  }

  private downloadFile(data: HttpResponse<Blob>, documentInfo: DocumentInfo) {
    const downloadedFile = new Blob([data.body], { type: data.body.type });
    const a = document.createElement('a');
    a.setAttribute('style', 'display:none;');
    document.body.appendChild(a);
    a.download = documentInfo.name;
    a.href = URL.createObjectURL(downloadedFile);
    a.target = '_blank';
    a.click();
    document.body.removeChild(a);
  }

  onVersionHistoryClick(document: DocumentInfo): void {
    let documentInfo = this.clonerService.deepClone<DocumentInfo>(document);
    this.sub$.sink = this.documentService
      .getDocumentVersion(document.id)
      .subscribe((documentVersions: DocumentVersion[]) => {
        documentInfo.documentVersions = documentVersions;
        const dialogRef = this.dialog.open(DocumentVersionHistoryComponent, {
          maxWidth: '80vw',
          panelClass: 'full-width-dialog',
          data: Object.assign({}, documentInfo),
        });
        dialogRef.afterClosed().subscribe((result: boolean) => {
          if (result) {
          }
        });
      });
  }

  onCreateShareableLink(document: DocumentInfo): void {
    this.sub$.sink = this.documentService
      .getDocumentShareableLink(document.id)
      .subscribe((link: DocumentShareableLink) => {
        this.dialog.open(DocumentSharedLinkComponent, {
          width: '500px',
          data: { document, link },
        });
      });
  }
}
