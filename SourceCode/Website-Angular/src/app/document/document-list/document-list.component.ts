import { SelectionModel } from '@angular/cdk/collections';
import { HttpEvent, HttpEventType, HttpResponse } from '@angular/common/http';
import {
  AfterViewInit,
  Component,
  ElementRef,
  OnInit,
  signal,
  ViewChild,
} from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { CommonDialogService } from '@core/common-dialog/common-dialog.service';
import { Category } from '@core/domain-classes/category';
import { DocumentAuditTrail } from '@core/domain-classes/document-audit-trail';
import { DocumentCategoryStatus } from '@core/domain-classes/document-category';
import { ResponseHeader } from '@core/domain-classes/document-header';
import { DocumentInfo } from '@core/domain-classes/document-info';
import { DocumentOperation } from '@core/domain-classes/document-operation';
import { DocumentResource } from '@core/domain-classes/document-resource';
import { DocumentView } from '@core/domain-classes/document-view';
import { DocumentVersion } from '@core/domain-classes/documentVersion';
import { CategoryService } from '@core/services/category.service';
import { ClonerService } from '@core/services/clone.service';
import { CommonService } from '@core/services/common.service';
import { TranslationService } from '@core/services/translation.service';
import { BasePreviewComponent } from '@shared/base-preview/base-preview.component';
import { OverlayPanel } from '@shared/overlay-panel/overlay-panel.service';
import { ToastrService } from 'ngx-toastr';
import { fromEvent, merge, Observable } from 'rxjs';
import { debounceTime, distinctUntilChanged, tap } from 'rxjs/operators';
import { BaseComponent } from 'src/app/base.component';
import { DocumentCommentComponent } from '../document-comment/document-comment.component';
import { DocumentEditComponent } from '../document-edit/document-edit.component';
import { DocumentPermissionListComponent } from '../document-permission/document-permission-list/document-permission-list.component';
import { DocumentPermissionMultipleComponent } from '../document-permission/document-permission-multiple/document-permission-multiple.component';
import { DocumentReminderComponent } from '../document-reminder/document-reminder.component';
import { DocumentUploadNewVersionComponent } from '../document-upload-new-version/document-upload-new-version.component';
import { DocumentVersionHistoryComponent } from '../document-version-history/document-version-history.component';
import { DocumentService } from '../document.service';
import { SendEmailComponent } from '../send-email/send-email.component';
import { DocumentDataSource } from './document-datasource';
import { DocumentSharedLinkComponent } from '../document-shared-link/document-shared-link.component';
import { DocumentShareableLink } from '@core/domain-classes/DocumentShareableLink';
import { StorageSetting } from 'src/app/storage-setting/storage-setting';
import { DocumentStatus } from 'src/app/document-status/document-status';
import { DocumentStatusService } from 'src/app/document-status/document-status.service';
import { StorageSettingService } from 'src/app/storage-setting/storage-setting.service';
import { MatSelectChange } from '@angular/material/select';
import { BreakpointsService } from '@core/services/breakpoints.service';


@Component({
  selector: 'app-document-list',
  templateUrl: './document-list.component.html',
  styleUrls: ['./document-list.component.scss']
})
export class DocumentListComponent
  extends BaseComponent
  implements OnInit, AfterViewInit {
  step = signal(0);
  dataSource: DocumentDataSource;
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
  isLoadingResults = true;
  documentResource: DocumentResource;
  categories: Category[] = [];
  hierarchicalCategories: Category[] = [];
  storageSetting: StorageSetting<any>[] = [];
  documentStatuses: DocumentStatus[] = [];

  loading$: Observable<boolean>;
  @ViewChild(MatPaginator) paginator: MatPaginator;
  @ViewChild(MatSort) sort: MatSort;
  @ViewChild('input') input: ElementRef;
  @ViewChild('metatag') metatag: ElementRef;
  selection = new SelectionModel<DocumentInfo>(true, []);
  constructor(
    private documentService: DocumentService,
    private commonDialogService: CommonDialogService,
    private categoryService: CategoryService,
    private dialog: MatDialog,
    public overlay: OverlayPanel,
    public clonerService: ClonerService,
    private translationService: TranslationService,
    private commonService: CommonService,
    private toastrService: ToastrService,
    private documentStatusService: DocumentStatusService,
    private StorageSettingService: StorageSettingService,
    private breakpointsService: BreakpointsService
  ) {
    super();
    this.documentResource = new DocumentResource();
    this.documentResource.pageSize = 10;
    this.documentResource.orderBy = 'CreatedDate desc';
  }

  ngOnInit(): void {
    this.ismobileCheck();
    this.dataSource = new DocumentDataSource(this.documentService);
    this.dataSource.loadDocuments(this.documentResource);
    this.getCategories();
    this.getDocumentStatus();
    this.getStorageSetting();
    this.getResourceParameter();
  }
  ismobileCheck() {
    this.breakpointsService.isMobile$.subscribe((isMobile) => {
      this.step.set(isMobile ? 1 : 0);
    })
  }

  ngAfterViewInit() {
    this.sort.sortChange.subscribe(() => (this.paginator.pageIndex = 0));

    this.sub$.sink = merge(this.sort.sortChange, this.paginator.page)
      .pipe(
        tap((c: any) => {
          this.documentResource.pageSize = this.paginator.pageSize;
          this.documentResource.skip =
            this.paginator.pageIndex * this.paginator.pageSize;
          this.documentResource.pageSize = this.paginator.pageSize;
          this.documentResource.orderBy =
            this.sort.active + ' ' + this.sort.direction;
          this.dataSource.loadDocuments(this.documentResource);
        })
      )
      .subscribe();

    this.sub$.sink = fromEvent(this.input.nativeElement, 'keyup')
      .pipe(
        debounceTime(1000),
        distinctUntilChanged(),
        tap(() => {
          this.paginator.pageIndex = 0;
          this.documentResource.skip = 0;
          this.documentResource.name = this.input.nativeElement.value;
          this.dataSource.loadDocuments(this.documentResource);
        })
      )
      .subscribe();

    this.sub$.sink = fromEvent(this.metatag.nativeElement, 'keyup')
      .pipe(
        debounceTime(1000),
        distinctUntilChanged(),
        tap(() => {
          this.paginator.pageIndex = 0;
          this.documentResource.skip = 0;
          this.documentResource.metaTags = this.metatag.nativeElement.value;
          this.dataSource.loadDocuments(this.documentResource);
        })
      )
      .subscribe();
  }

  /** Whether the number of selected elements matches the total number of rows. */
  isAllSelected() {
    const numSelected = this.selection.selected.length;
    const numRows = this.dataSource.data.length;
    return numSelected === numRows;
  }
  /** Selects all rows if they are not all selected; otherwise clear selection. */
  masterToggle() {
    this.isAllSelected()
      ? this.selection.clear()
      : this.dataSource.data.forEach((row) => this.selection.select(row));
  }

  onCategoryChange(filtervalue: any) {
    if (filtervalue.value) {
      this.documentResource.categoryId = filtervalue.value;
    } else {
      this.documentResource.categoryId = '';
    }
    this.documentResource.skip = 0;
    this.paginator.pageIndex = 0;
    this.dataSource.loadDocuments(this.documentResource);
  }

  onCreatedDateChange(filtervalue: any) {
    if (filtervalue) {
      this.documentResource.createDate = filtervalue;
    } else {
      this.documentResource.createDate = null;
    }
    this.documentResource.skip = 0;
    this.paginator.pageIndex = 0;
    this.dataSource.loadDocuments(this.documentResource);
  }

  getCategories(): void {
    this.categoryService
      .getAllCategoriesForDropDown()
      .subscribe((c: Category[]) => {
        if (c && c.length > 0) {
          this.categories = [...c];
          this.setDeafLevel();
        }
      });
  }

  getDocumentStatus() {
    this.documentStatusService
      .getDocumentStatuss()
      .subscribe((c: DocumentStatus[]) => {
        if (c && c.length > 0) {
          this.documentStatuses = [...c];
        }
      });
  }

  getStorageSetting() {
    this.StorageSettingService.getStorageSettings().subscribe(
      (c: StorageSetting<any>[]) => {
        if (c && c.length > 0) {
          this.storageSetting = [...c];
        }
      }
    );
  }

  setDeafLevel(parent?: Category, parentId?: string) {
    const children = this.categories.filter((c) => c.parentId == parentId);
    if (children.length > 0) {
      children.map((c, index) => {
        c.deafLevel = parent ? parent.deafLevel + 1 : 0;
        c.index =
          (parent ? parent.index : 0) + index * Math.pow(0.1, c.deafLevel);
        this.hierarchicalCategories.push(c);
        this.setDeafLevel(c, c.id);
      });
    }
    return parent;
  }

  getResourceParameter() {
    this.sub$.sink = this.dataSource.responseHeaderSubject$.subscribe(
      (c: ResponseHeader) => {
        if (c) {
          this.documentResource.pageSize = c.pageSize;
          this.documentResource.skip = c.skip;
          this.documentResource.totalCount = c.totalCount;
        }
      }
    );
  }

  deleteDocument(document: DocumentInfo) {
    this.sub$.sink = this.commonDialogService
      .deleteConformationDialog(
        `${this.translationService.getValue(
          'ARE_YOU_SURE_YOU_WANT_TO_DELETE'
        )} ${document.name}`
      )
      .subscribe((isTrue: boolean) => {
        if (isTrue) {
          this.sub$.sink = this.documentService
            .deleteDocument(document.id)
            .subscribe(() => {
              this.addDocumentTrail(
                document.id,
                DocumentOperation.Deleted.toString()
              );
              this.toastrService.success(
                this.translationService.getValue(
                  'DOCUMENT_DELETED_SUCCESSFULLY'
                )
              );
              this.dataSource.loadDocuments(this.documentResource);
            });
        }
      });
  }

  removeDocumentPageIndexing(document: DocumentInfo) {
    this.isLoadingResults = true;
    this.sub$.sink = this.commonDialogService
      .deleteConformationDialog(
        `${this.translationService.getValue(
          'ARE_YOU_SURE_WANT_TO_REMOVE_DOCUMENT_PAGE_INDEXING'
        )} ${document.name}`,
        this.translationService.getValue(
          'DEEP_SEARCH_REMOVE_NOTE'
        )
      )
      .subscribe((isTrue: boolean) => {
        if (isTrue) {
          this.sub$.sink = this.documentService
            .removePageIndexing(document.id)
            .subscribe({
              next: (c: boolean) => {
                this.isLoadingResults = false;
                if (c) {
                  this.toastrService.success(
                    this.translationService.getValue(
                      'DOCUMENT_PAGE_INDEXING_IS_DELETED'
                    )
                  );
                  debugger;
                  this.dataSource.loadDocuments(this.documentResource);
                }
              }, error: () => {
                this.isLoadingResults = false;
              }
            });
        }
      });
  }
  addDocumentPageIndexing(document: DocumentInfo) {
    this.sub$.sink = this.documentService
      .addPageIndexing(document.id)
      .subscribe({
        next: (c: boolean) => {
          if (c) {
            this.toastrService.success(
              this.translationService.getValue(
                'DOCUMENT_PAGE_INDEXING_IS_ADDED'
              )
            );
            this.dataSource.loadDocuments(this.documentResource);
          }
        },
        error: () => {
          this.isLoadingResults = false;
        }
      });
  }

  getDocuments(): void {
    this.isLoadingResults = true;

    this.sub$.sink = this.documentService
      .getDocuments(this.documentResource)
      .subscribe({
        next: (resp: HttpResponse<DocumentInfo[]>) => {
          const paginationParam = JSON.parse(
            resp.headers.get('X-Pagination')
          ) as ResponseHeader;
          this.documentResource.pageSize = paginationParam.pageSize;
          this.documentResource.skip = paginationParam.skip;
          this.isLoadingResults = false;
        },
        error: (error) => {
          this.isLoadingResults = false;
        },
      });
  }

  onStatusChange(filterValue: MatSelectChange) {
    const documentStatus: DocumentStatus = filterValue.value;
    if (documentStatus) {
      this.documentResource.documentStatusId = documentStatus.id;
    } else {
      this.documentResource.documentStatusId = '';
    }
    this.documentResource.skip = 0;
    this.paginator.pageIndex = 0;
    this.dataSource.loadDocuments(this.documentResource);
  }

  onStorageChange(filterValue: MatSelectChange) {
    const storage: StorageSetting<any> = filterValue.value;
    if (storage) {
      this.documentResource.storageSettingId = storage.id;
    } else {
      this.documentResource.storageSettingId = '';
    }
    this.documentResource.skip = 0;
    this.paginator.pageIndex = 0;
    this.dataSource.loadDocuments(this.documentResource);
  }

  editDocument(documentInfo: DocumentInfo) {
    const documentCategories: DocumentCategoryStatus = {
      document: documentInfo,
      categories: this.categories,
      documentStatuses: this.documentStatuses,
    };
    const dialogRef = this.dialog.open(DocumentEditComponent, {
      width: '60vw',
      data: Object.assign({}, documentCategories),
    });

    this.sub$.sink = dialogRef.afterClosed().subscribe((result: string) => {
      if (result === 'loaded') {
        this.dataSource.loadDocuments(this.documentResource);
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
        this.dataSource.loadDocuments(this.documentResource);
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
          this.dataSource.loadDocuments(this.documentResource);
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
            this.dataSource.loadDocuments(this.documentResource);
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
