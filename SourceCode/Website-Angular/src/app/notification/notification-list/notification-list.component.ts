import {
  AfterViewInit,
  Component,
  ElementRef,
  OnInit,
  ViewChild,
} from '@angular/core';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { Router } from '@angular/router';
import { ResponseHeader } from '@core/domain-classes/document-header';
import { DocumentResource } from '@core/domain-classes/document-resource';
import { NotificationType, UserNotification } from '@core/domain-classes/notification';
import { OverlayPanel } from '@shared/overlay-panel/overlay-panel.service';
import { fromEvent, merge, Observable } from 'rxjs';
import { debounceTime, distinctUntilChanged, tap } from 'rxjs/operators';
import { BaseComponent } from 'src/app/base.component';
import { NotificationDataSource } from '../notification-datassource';
import { NotificationService } from '../notification.service';
import { BasePreviewComponent } from '@shared/base-preview/base-preview.component';
import { DocumentView } from '@core/domain-classes/document-view';
import { TranslationService } from '@core/services/translation.service';
import { ToastrService } from 'ngx-toastr';
import { ServiceResponse } from '../../core/domain-classes/service-response';

@Component({
  selector: 'app-notification-list',
  templateUrl: './notification-list.component.html',
  styleUrls: ['./notification-list.component.scss'],
})
export class NotificationListComponent
  extends BaseComponent
  implements OnInit, AfterViewInit
{
  dataSource: NotificationDataSource;
  notifications: UserNotification[] = [];
  displayedColumns: string[] = ['action', 'createdDate', 'message'];
  isLoadingResults = true;
  notificationResource: DocumentResource;
  loading$: Observable<boolean>;
  @ViewChild(MatPaginator) paginator: MatPaginator;
  @ViewChild(MatSort) sort: MatSort;
  @ViewChild('input') input: ElementRef;
  footerToDisplayed = ['footer'];

  constructor(
    private notificationService: NotificationService,
    private translationService: TranslationService,
    private toastrService: ToastrService,
    public overlay: OverlayPanel
  ) {
    super();
    this.notificationResource = new DocumentResource();
    this.notificationResource.pageSize = 10;
    this.notificationResource.orderBy = 'createdDate desc';
  }

  ngOnInit(): void {
    this.dataSource = new NotificationDataSource(this.notificationService);
    this.dataSource.loadNotifications(this.notificationResource);
    this.getResourceParameter();
  }

  ngAfterViewInit() {
    this.sort.sortChange.subscribe(() => (this.paginator.pageIndex = 0));

    this.sub$.sink = merge(this.sort.sortChange, this.paginator.page)
      .pipe(
        tap(() => {
          this.notificationResource.skip = this.paginator.pageIndex * this.paginator.pageSize;
          this.notificationResource.pageSize = this.paginator.pageSize;
          this.notificationResource.orderBy =
            this.sort.active + ' ' + this.sort.direction;
          this.dataSource.loadNotifications(this.notificationResource);
        })
      )
      .subscribe();

    this.sub$.sink = fromEvent(this.input.nativeElement, 'keyup')
      .pipe(
        debounceTime(1000),
        distinctUntilChanged(),
        tap(() => {
          this.paginator.pageIndex = 0;
          this.notificationResource.skip = 0;
          this.notificationResource.name = this.input.nativeElement.value;
          this.dataSource.loadNotifications(this.notificationResource);
        })
      )
      .subscribe();
  }
  getResourceParameter() {
    this.sub$.sink = this.dataSource.responseHeaderSubject$.subscribe(
      (c: ResponseHeader) => {
        if (c) {
          this.notificationResource.pageSize = c.pageSize;
          this.notificationResource.skip = c.skip;
          this.notificationResource.totalCount = c.totalCount;
        }
      }
    );
  }

  viewDocument(notification: UserNotification) {
    if (notification.notificationsType === NotificationType.REMINDER) {
      this.notificationService
        .checkReminderByDocumentId(notification.documentId)
        .subscribe((response : ServiceResponse<boolean>) => {
          if (response.data) {
            this.previewDocument(notification);
          } else {
            this.toastrService.error(
              this.translationService.getValue('YOU_ARE_NOT_AUTHORIZED_TO_VIEW_THIS_REMINDER')
            );
          }
        });
    } else if (notification.notificationsType === NotificationType.SHARE_USER) {
      this.notificationService
        .checkShareUserByDocumentId(notification.documentId)
        .subscribe((isShare : ServiceResponse<boolean>) => {
          if (isShare.data) {
            this.previewDocument(notification);
          } else {
            this.toastrService.error(
              this.translationService.getValue('YOU_ARE_NOT_AUTHORIZED_TO_VIEW_THIS_DOCUMENT')
            );
          }
        });
    }
  }

  previewDocument(notification: UserNotification) {
    this.sub$.sink = this.notificationService
      .markAsRead(notification.id)
      .subscribe(() => {});
    const urls = notification.url.split('.');
    const extension = urls[1];
    const documentView: DocumentView = {
      documentId: notification.documentId,
      name: notification.documentName,
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
}
