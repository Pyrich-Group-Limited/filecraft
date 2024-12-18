import { DataSource } from '@angular/cdk/table';
import { HttpResponse } from '@angular/common/http';
import { ResponseHeader } from '@core/domain-classes/response-header';
import { BehaviorSubject, Observable, of } from 'rxjs';
import { catchError, finalize } from 'rxjs/operators';
import { User } from '@core/domain-classes/user';
import { UserService } from '../user.service';
import { ResourceParameter } from '@core/domain-classes/resource-parameter';

export class UserDataSource implements DataSource<User> {
  private userSubject = new BehaviorSubject<User[]>([]);
  private responseHeaderSubject = new BehaviorSubject<ResponseHeader>(null);
  private loadingSubject = new BehaviorSubject<boolean>(false);

  public loading$ = this.loadingSubject.asObservable();
  private _count: number = 0;

  public get count(): number {
    return this._count;
  }

  public responseHeaderSubject$ = this.responseHeaderSubject.asObservable();

  constructor(private userService: UserService) {}

  connect(): Observable<User[]> {
    return this.userSubject.asObservable();
  }

  disconnect(): void {
    this.userSubject.complete();
    this.loadingSubject.complete();
  }

  loadUsers(userResource: ResourceParameter) {
    this.loadingSubject.next(true);
    this.userService
      .getUsers(userResource)
      .pipe(
        catchError(() => of([])),
        finalize(() => this.loadingSubject.next(false))
      )
      .subscribe((resp: HttpResponse<User[]>) => {
        const paginationParam = JSON.parse(
          resp.headers.get('X-Pagination')
        ) as ResponseHeader;
        this.responseHeaderSubject.next(paginationParam);
        const users = [...resp.body];
        this._count = users.length;
        this.userSubject.next(users);
      });
  }
}
