import { Injectable } from '@angular/core';
import {
  HttpClient,
  HttpEvent,
  HttpParams,
  HttpResponse,
} from '@angular/common/http';
import { CommonError } from '@core/error-handler/common-error';
import { CommonHttpErrorService } from '@core/error-handler/common-http-error.service';
import { BehaviorSubject, Observable, of } from 'rxjs';
import { User } from '@core/domain-classes/user';
import { catchError, shareReplay, tap } from 'rxjs/operators';
import { Role } from '@core/domain-classes/role';
import { DocumentAuditTrail } from '@core/domain-classes/document-audit-trail';
import {
  reminderFrequencies,
  ReminderFrequency,
} from '@core/domain-classes/reminder-frequency';
import { DocumentInfo } from '@core/domain-classes/document-info';
import { ReminderResourceParameter } from '@core/domain-classes/reminder-resource-parameter';
import { Reminder } from '@core/domain-classes/reminder';
import { DocumentView } from '@core/domain-classes/document-view';
import { EmailSMTPSetting } from '@core/domain-classes/email-smtp-setting';
import { ServiceResponse } from '@core/domain-classes/service-response';
import { PageHelper } from '@core/domain-classes/pageHelper';
import { B } from '@fullcalendar/core/internal-common';

@Injectable({ providedIn: 'root' })
export class CommonService {
  constructor(
    private httpClient: HttpClient,
    private commonHttpErrorService: CommonHttpErrorService
  ) { }
  private _IsSmtpConfigured$: BehaviorSubject<boolean> = new BehaviorSubject<boolean>(null);
  public get IsSmtpConfigured(): Observable<boolean> {
    return this._IsSmtpConfigured$.asObservable();
  }


  private _sideMenuStatus$: BehaviorSubject<boolean> = new BehaviorSubject<boolean>(false);
  public get sideMenuStatus$(): Observable<boolean> {
    return this._sideMenuStatus$.asObservable();
  }
  public setSideMenuStatus(flag: boolean) {
    this._sideMenuStatus$.next(flag);
  }


  setIsSmtpConfigured(value: boolean) {
    this._IsSmtpConfigured$.next(value);
  }

  getUsersForDropdown(): Observable<User[] | CommonError> {
    const url = `user/dropdown`;
    return this.httpClient
      .get<User[]>(url)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  getRoles(): Observable<Role[] | CommonError> {
    const url = `role`;
    return this.httpClient
      .get<Role[]>(url)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  getReminder(id: string): Observable<Reminder | CommonError> {
    const url = `reminder/${id}`;
    return this.httpClient
      .get<Reminder>(url)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  addDocumentAuditTrail(
    documentAuditTrail: DocumentAuditTrail
  ): Observable<DocumentAuditTrail> {
    return this.httpClient.post<DocumentAuditTrail>(
      'documentAuditTrail',
      documentAuditTrail
    );
  }

  downloadDocument(
    documentView: DocumentView
  ): Observable<HttpEvent<Blob> | CommonError> {
    let url = '';
    if (documentView.isFromPublicPreview) {
      const passowrd = documentView.linkPassword
        ? encodeURIComponent(documentView.linkPassword)
        : '';
      url = `DocumentShareableLink/${documentView.documentId}/download?password=${passowrd}`;
    } else {
      url = `document/${documentView.documentId}/download?isVersion=${documentView.isVersion}`;
    }
    return this.httpClient
      .get(url, {
        reportProgress: true,
        observe: 'events',
        responseType: 'blob',
      })
      .pipe(
        catchError((error) =>
          this.commonHttpErrorService.handleError(
            this.blobToString(error.error)
          )
        )
      );
  }

  isDownloadFlag(documentId: string): Observable<boolean> {
    const url = `document/${documentId}/isDownloadFlag`;
    return this.httpClient.get<boolean>(url);
  }

  getDocumentToken(
    documentView: DocumentView
  ): Observable<{ [key: string]: string }> {
    let url = '';
    if (documentView.isFromPublicPreview) {
      url = `DocumentShareableLink/${documentView.documentId}/token`;
    } else {
      url = `documentToken/${documentView.documentId}/token`;
    }
    return this.httpClient.get<{ [key: string]: string }>(url);
  }

  deleteDocumentToken(token: string): Observable<boolean> {
    const url = `documentToken/${token}`;
    return this.httpClient.delete<boolean>(url);
  }

  readDocument(
    documentView: DocumentView
  ): Observable<{ [key: string]: string[] } | CommonError> {
    let url = '';
    if (documentView.isFromPublicPreview) {
      const passowrd = documentView.linkPassword
        ? encodeURIComponent(documentView.linkPassword)
        : '';
      url = `DocumentShareableLink/${documentView.documentId}/readtext?password=${passowrd}`;
    } else {
      url = `document/${documentView.documentId}/readText?isVersion=${documentView.isVersion}`;
    }
    return this.httpClient.get<{ [key: string]: string[] }>(url);
  }

  getReminderFrequency(): Observable<ReminderFrequency[]> {
    return of(reminderFrequencies);
  }

  addDocumentWithAssign(
    document: DocumentInfo
  ): Observable<DocumentInfo | CommonError> {
    document.documentMetaDatas = document.documentMetaDatas?.filter(
      (c) => c.metatag
    );
    const url = `document/assign`;
    const formData = new FormData();
    formData.append('files', document.files);
    formData.append('name', document.name);
    formData.append('categoryId', document.categoryId);
    formData.append('documentStatusId', document.documentStatusId);
    formData.append('storageSettingId', document.storageSettingId);
    formData.append('description', document.description);
    formData.append(
      'documentMetaDataString',
      JSON.stringify(document.documentMetaDatas)
    );
    return this.httpClient
      .post<DocumentInfo>(url, formData)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  getAllRemindersForCurrentUser(
    resourceParams: ReminderResourceParameter
  ): Observable<HttpResponse<Reminder[]>> {
    const url = 'reminder/all/currentuser';
    const customParams = new HttpParams()
      .set('Fields', resourceParams.fields ? resourceParams.fields : '')
      .set('OrderBy', resourceParams.orderBy ? resourceParams.orderBy : '')
      .set('PageSize', resourceParams.pageSize.toString())
      .set('Skip', resourceParams.skip.toString())
      .set(
        'SearchQuery',
        resourceParams.searchQuery ? resourceParams.searchQuery : ''
      )
      .set('subject', resourceParams.subject ? resourceParams.subject : '')
      .set('message', resourceParams.message ? resourceParams.message : '')
      .set(
        'frequency',
        resourceParams.frequency ? resourceParams.frequency : ''
      );

    return this.httpClient.get<Reminder[]>(url, {
      params: customParams,
      observe: 'response',
    });
  }

  deleteReminderCurrentUser(reminderId: string): Observable<boolean> {
    const url = `reminder/${reminderId}/currentuser`;
    return this.httpClient.delete<boolean>(url);
  }

  private blobToString(blob) {
    const url = URL.createObjectURL(blob);
    const xmlRequest = new XMLHttpRequest();
    xmlRequest.open('GET', url, false);
    xmlRequest.send();
    URL.revokeObjectURL(url);
    return JSON.parse(xmlRequest.responseText);
  }

  checkEmailSMTPSetting(): Observable<ServiceResponse<boolean> | CommonError> {
    const url = 'EmailSMTPSetting/check';
    return this.httpClient.get<ServiceResponse<boolean>>(url)
      .pipe(
        shareReplay(1),
        tap((response) => { this._IsSmtpConfigured$.next(response.data); }),
        catchError(this.commonHttpErrorService.handleError)
      );
  }

  getPageHelperText(code: string): Observable<PageHelper | CommonError> {
    const url = `pagehelper/code/${code}`;
    return this.httpClient.get<PageHelper>(url);
  }
}
