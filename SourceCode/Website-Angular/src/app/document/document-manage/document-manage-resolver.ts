import { Injectable } from '@angular/core';
import { Router, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { CommonError } from '@core/error-handler/common-error';
import { Observable, of } from 'rxjs';
import { take, mergeMap } from 'rxjs/operators';
import { DocumentInfo } from '../../core/domain-classes/document-info';
import { DocumentService } from '../document.service';

@Injectable({
  providedIn: 'root'
})
export class DocumentManageResolver  {
  constructor(
    private documentService: DocumentService,
    private router: Router) { }
  resolve(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): Observable<DocumentInfo | CommonError> | null  {
    const id = route.paramMap.get('id');
    if (id === 'add') {
      return null;
    }
    return this.documentService.getDocument(id)
      .pipe(
        take(1),
        mergeMap(documentInfo => {
          if (documentInfo) {
            return of(documentInfo);
          } else {
            this.router.navigate(['/document']);
           return of(null);
          }
        })
      );
  }
}
