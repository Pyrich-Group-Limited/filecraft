import { HttpClient, HttpParams, HttpResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { DocumentInfo } from '@core/domain-classes/document-info';
import { DocumentResource } from '@core/domain-classes/document-resource';
import { DocumentShareableLink } from '@core/domain-classes/DocumentShareableLink';
import { DocumentVersion } from '@core/domain-classes/documentVersion';
import { ServiceResponse } from '@core/domain-classes/service-response';
import { CommonError } from '@core/error-handler/common-error';
import { CommonHttpErrorService } from '@core/error-handler/common-http-error.service';
import { Observable } from 'rxjs';
import { catchError, map } from 'rxjs/operators';

@Injectable({
  providedIn: 'root',
})
export class DocumentService {
  constructor(
    private httpClient: HttpClient,
    private commonHttpErrorService: CommonHttpErrorService
  ) { }

  updateDocument(
    document: DocumentInfo
  ): Observable<DocumentInfo | CommonError> {
    const url = `document/${document.id}`;
    return this.httpClient
      .put<DocumentInfo>(url, document)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  addDocument(document: DocumentInfo): Observable<DocumentInfo | CommonError> {
    document.documentMetaDatas = document.documentMetaDatas?.filter(
      (c) => c.metatag
    );
    const url = `document`;
    const formData = new FormData();
    formData.append('files', document.files);
    formData.append('name', document.name);
    formData.append('categoryId', document.categoryId);
    formData.append('documentStatusId', document.documentStatusId);
    formData.append('storageSettingId', document.storageSettingId);
    formData.append('categoryName', document.categoryName);
    formData.append('description', document.description);
    formData.append(
      'documentMetaDataString',
      JSON.stringify(document.documentMetaDatas)
    );
    formData.append(
      'documentRolePermissionString',
      JSON.stringify(document.documentRolePermissions ?? [])
    );

    formData.append(
      'documentUserPermissionString',
      JSON.stringify(document.documentUserPermissions ?? [])
    );
    return this.httpClient
      .post<DocumentInfo>(url, formData)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  deleteDocument(id: string): Observable<void | CommonError> {
    const url = `document/${id}`;
    return this.httpClient
      .delete<void>(url)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  getDocument(id: string): Observable<DocumentInfo | CommonError> {
    const url = `document/${id}`;
    return this.httpClient
      .get<DocumentInfo>(url)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  getDocuments(
    resource: DocumentResource
  ): Observable<HttpResponse<DocumentInfo[]> | CommonError> {
    const url = `documents`;
    const customParams = new HttpParams()
      .set('Fields', resource.fields)
      .set('OrderBy', resource.orderBy)
      .set(
        'createDateString',
        resource.createDate ? resource.createDate.toString() : ''
      )
      .set('PageSize', resource.pageSize.toString())
      .set('Skip', resource.skip.toString())
      .set('SearchQuery', resource.searchQuery)
      .set('categoryId', resource.categoryId)
      .set('documentStatusId', resource.documentStatusId)
      .set('storageSettingId', resource.storageSettingId)
      .set('name', resource.name)
      .set('metaTags', resource.metaTags)
      .set('id', resource.id.toString());

    return this.httpClient
      .get<DocumentInfo[]>(url, {
        params: customParams,
        observe: 'response',
      })
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  getDocumentsByDeepSearch(
    searchQuery: string
  ): Observable<DocumentInfo[] | CommonError> {
    const url = `document/deepSearch?searchQuery=${searchQuery}`;
    return this.httpClient.get<DocumentInfo[]>(url)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  removePageIndexing(id: string): Observable<boolean | CommonError> {
    const url = `document/${id}/remove/pageindexing`;
    return this.httpClient.post<ServiceResponse<boolean>>(url, null)
      .pipe(
        map((response) => response.data),
        catchError(this.commonHttpErrorService.handleError)
      );
  }
  addPageIndexing(id: string): Observable<boolean | CommonError> {
    const url = `document/${id}/add/pageindexing`;
    return this.httpClient.post<ServiceResponse<boolean>>(url, null)
      .pipe(
        map((response) => response.data),
        catchError(this.commonHttpErrorService.handleError)
      );
  }


  saveNewVersionDocument(document): Observable<DocumentInfo | CommonError> {
    const url = `documentVersion`;
    const formData = new FormData();
    formData.append('files', document.files);
    formData.append('url', document.url);
    formData.append('documentId', document.documentId);
    return this.httpClient
      .post<DocumentInfo>(url, formData)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  getDocumentVersion(id: string) {
    const url = `documentversion/${id}`;
    return this.httpClient
      .get<DocumentVersion[]>(url)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  restoreDocumentVersion(id: string, versionId: string) {
    const url = `documentversion/${id}/restore/${versionId}`;
    return this.httpClient
      .post<boolean>(url, {})
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  getdocumentMetadataById(id: string) {
    const url = `document/${id}/getMetatag`;
    return this.httpClient
      .get(url)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  getDocumentShareableLink(
    id: string
  ): Observable<DocumentShareableLink | CommonError> {
    const url = `DocumentShareableLink/${id}`;
    return this.httpClient
      .get<DocumentShareableLink>(url)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  createDocumentShareableLink(
    link: DocumentShareableLink
  ): Observable<DocumentShareableLink | CommonError> {
    const url = `DocumentShareableLink`;
    return this.httpClient
      .post<DocumentShareableLink>(url, link)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  deleteDocumentShareableLInk(id: string): Observable<boolean | CommonError> {
    const url = `DocumentShareableLink/${id}`;
    return this.httpClient
      .delete<boolean>(url)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  getLinkInfoByCode(
    code: string
  ): Observable<DocumentShareableLink | CommonError> {
    const url = `DocumentShareableLink/${code}/info`;
    return this.httpClient
      .get<DocumentShareableLink>(url)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  getDocumentByCode(code: string): Observable<DocumentInfo | CommonError> {
    const url = `DocumentShareableLink/${code}/document`;
    return this.httpClient
      .get<DocumentInfo>(url)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }
}
