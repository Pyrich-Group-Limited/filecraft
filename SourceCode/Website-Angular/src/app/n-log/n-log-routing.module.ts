import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AuthGuard } from '@core/security/auth.guard';
import { LogDetailResolverService } from './log-detail-resolver';
import { NLogDetailComponent } from './n-log-detail/n-log-detail.component';
import { NLogListComponent } from './n-log-list/n-log-list.component';

const routes: Routes = [
  {
    path: '',
    component: NLogListComponent,
    data: { claimType: 'error_logs_view_error_logs' },
    canActivate: [AuthGuard],
  },
  {
    path: ':id',
    component: NLogDetailComponent,
    canActivate: [AuthGuard],
     data: { claimType: 'error_logs_view_error_logs' },
    resolve: { log: LogDetailResolverService },
  },
];

@NgModule({
  declarations: [],
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class NLogRoutingModule {}
