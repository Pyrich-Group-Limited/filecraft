import { HttpResponse } from '@angular/common/http';
import {
  AfterViewInit,
  Component,
  ElementRef,
  OnInit,
  signal,
  ViewChild,
} from '@angular/core';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { Category } from '@core/domain-classes/category';
import { ResponseHeader } from '@core/domain-classes/document-header';
import { DocumentInfo } from '@core/domain-classes/document-info';
import { DocumentResource } from '@core/domain-classes/document-resource';
import { CategoryService } from '@core/services/category.service';
import { OverlayPanel } from '@shared/overlay-panel/overlay-panel.service';
import { fromEvent, merge, Observable } from 'rxjs';
import { debounceTime, distinctUntilChanged, tap } from 'rxjs/operators';
import { BaseComponent } from 'src/app/base.component';
import { DocumentLibraryService } from '../document-library.service';
import { DocumentLibraryDataSource } from './document-library-datasource';
import { SelectionModel } from '@angular/cdk/collections';
import { BasePreviewComponent } from '@shared/base-preview/base-preview.component';
import { DocumentView } from '@core/domain-classes/document-view';
import { DocumentReminderComponent } from '../document-reminder/document-reminder.component';
import { MatDialog } from '@angular/material/dialog';
import { AddDocumentComponent } from '../add-document/add-document.component';
import { ReminderListComponent } from '../reminder-list/reminder-list.component';
import { DocumentCommentComponent } from 'src/app/document/document-comment/document-comment.component';
import { ClonerService } from '@core/services/clone.service';
import { DocumentVersion } from '@core/domain-classes/documentVersion';
import { DocumentVersionHistoryComponent } from 'src/app/document/document-version-history/document-version-history.component';
import { DocumentService } from 'src/app/document/document.service';
import { DocumentAuditTrail } from '@core/domain-classes/document-audit-trail';
import { CommonService } from '@core/services/common.service';
import { DocumentShareableLink } from '@core/domain-classes/DocumentShareableLink';
import { DocumentSharedLinkComponent } from 'src/app/document/document-shared-link/document-shared-link.component';
import { StorageSetting } from 'src/app/storage-setting/storage-setting';
import { DocumentStatus } from 'src/app/document-status/document-status';
import { DocumentStatusService } from 'src/app/document-status/document-status.service';
import { StorageSettingService } from 'src/app/storage-setting/storage-setting.service';
import { MatSelectChange } from '@angular/material/select';
import { BreakpointsService } from '@core/services/breakpoints.service';

@Component({
  selector: 'app-document-library-list',
  templateUrl: './document-library-list.component.html',
  styleUrls: ['./document-library-list.component.scss'],
})
export class DocumentLibraryListComponent
  extends BaseComponent
  implements OnInit, AfterViewInit {
  dataSource: DocumentLibraryDataSource;
  documents: DocumentInfo[] = [];
  displayedColumns: string[] = [
    'action',
    'name',
    'categoryName',
    'createdDate',
    'documentStatus',
    'storageType',
    'expiredDate',
    'createdBy',
  ];
  footerToDisplayed = ['footer'];
  isLoadingResults = true;
  documentResource: DocumentResource;
  categories: Category[] = [];
  hierarchicalCategories: Category[] = [];
  storageSettinges: StorageSetting<any>[] = [];
  documentStatuses: DocumentStatus[] = [];
  loading$: Observable<boolean>;
  @ViewChild(MatPaginator) paginator: MatPaginator;
  @ViewChild(MatSort) sort: MatSort;
  @ViewChild('input') input: ElementRef;
  @ViewChild('metatag') metatag: ElementRef;
  selection = new SelectionModel<DocumentInfo>(true, []);
  step = signal(0);

  constructor(
    private documentLibraryService: DocumentLibraryService,
    private categoryService: CategoryService,
    public overlay: OverlayPanel,
    public clonerService: ClonerService,
    private documentService: DocumentService,
    private commonService: CommonService,
    private documentStatusService: DocumentStatusService,
    private StorageSettingService: StorageSettingService,
    private dialog: MatDialog,
    private breakpointsService: BreakpointsService
  ) {
    super();
    this.documentResource = new DocumentResource();
    this.documentResource.pageSize = 10;
    this.documentResource.orderBy = 'CreatedDate desc';
  }

  ngOnInit(): void {
    this.ismobileCheck();
    this.dataSource = new DocumentLibraryDataSource(
      this.documentLibraryService
    );
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
    this.sub$.sink = this.sort.sortChange.subscribe(
      () => (this.paginator.pageIndex = 0)
    );

    this.sub$.sink = merge(this.sort.sortChange, this.paginator.page)
      .pipe(
        tap(() => {
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

  onCategoryChange(filtervalue: any) {
    if (filtervalue.value) {
      this.documentResource.categoryId = filtervalue.value;
    } else {
      this.documentResource.categoryId = '';
    }
    this.paginator.pageIndex = 0;
    this.documentResource.skip = 0;
    this.dataSource.loadDocuments(this.documentResource);
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

  getCategories(): void {
    this.categoryService
      .getAllCategoriesForDropDown()
      .subscribe((c: Category[]) => {
        if (c && c.length > 0) {
          this.categories = c;
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
          this.storageSettinges = [...c];
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

  getDocuments(): void {
    this.isLoadingResults = true;
    this.sub$.sink = this.documentLibraryService
      .getDocuments(this.documentResource)
      .subscribe(
        (resp: HttpResponse<DocumentInfo[]>) => {
          const paginationParam = JSON.parse(
            resp.headers.get('X-Pagination')
          ) as ResponseHeader;
          this.documentResource.pageSize = paginationParam.pageSize;
          this.documentResource.skip = paginationParam.skip;
          this.documents = [...resp.body];
          this.isLoadingResults = false;
        },
        () => (this.isLoadingResults = false)
      );
  }

  addReminder(documentInfo: DocumentInfo) {
    this.dialog.open(DocumentReminderComponent, {
      data: documentInfo,
      width: '80vw',
      maxHeight: '80vh',
    });
  }

  onReminderList() {
    this.dialog.open(ReminderListComponent, {
      data: null,
      maxWidth: '80vw',
      maxHeight: '80vh',
    });
  }

  onAddDocument() {
    const dialogRef = this.dialog.open(AddDocumentComponent, {
      data: null,
      maxWidth: '60vw',
      maxHeight: '80vh',
    });

    this.sub$.sink = dialogRef.afterClosed().subscribe((result: boolean) => {
      if (result) {
        this.dataSource.loadDocuments(this.documentResource);
      }
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

  addDocumentTrail(id: string, operation: string) {
    const objDocumentAuditTrail: DocumentAuditTrail = {
      documentId: id,
      operationName: operation,
    };
    this.sub$.sink = this.commonService
      .addDocumentAuditTrail(objDocumentAuditTrail)
      .subscribe((c) => { });
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

  onVersionHistoryClick(document: DocumentInfo): void {
    let isAssignUser = true;
    let documentInfo = this.clonerService.deepClone<DocumentInfo>(document);
    this.sub$.sink = this.documentService
      .getDocumentVersion(document.id)
      .subscribe((documentVersions: DocumentVersion[]) => {
        documentInfo.documentVersions = documentVersions;
        this.dialog.open(DocumentVersionHistoryComponent, {
          maxWidth: '80vw',
          panelClass: 'full-width-dialog',
          data: Object.assign(documentInfo, { isAssignUser }),
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
          autoFocus: false,
        });
      });
  }
}
