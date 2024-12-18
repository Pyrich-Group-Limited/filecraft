import { Component, OnInit, inject, OnDestroy, Output, EventEmitter, Input } from '@angular/core';
import { FormBuilder, FormsModule } from '@angular/forms';
import { MatDialog, MatDialogModule } from '@angular/material/dialog';
import { MatTableModule } from '@angular/material/table';
import { SubSink } from 'SubSink';
import { ToastrService } from 'ngx-toastr';
import { DocumentStatusService } from '../document-status.service';
import { ManageDocumentStatusComponent } from '../manage-document-status/manage-document-status.component';
import { CommonDialogService } from '@core/common-dialog/common-dialog.service';
import { TranslationService } from '@core/services/translation.service';
import { DocumentStatus } from '../document-status';
import { RouterModule } from '@angular/router';
import { TranslateModule } from '@ngx-translate/core';
import { CommonModule } from '@angular/common';
import { MatSlideToggleModule } from '@angular/material/slide-toggle';
import { SharedModule } from '@shared/shared.module';
import { ColorPickerModule } from 'ngx-color-picker';
import { FeatherModule } from 'angular-feather';
import { BreakpointsService } from '@core/services/breakpoints.service';

@Component({
  selector: 'app-document-status-list',
  standalone: true,
  imports: [
    RouterModule,
    TranslateModule,
    MatTableModule,
    CommonModule,
    MatSlideToggleModule,
    FormsModule,
    SharedModule,
    MatDialogModule,
    ColorPickerModule,
    FeatherModule
  ],
  templateUrl: './document-status-list.component.html',
  styleUrls: ['./document-status-list.component.scss'],
})
export class DocumentStatusListComponent implements OnInit, OnDestroy {
  @Input() documentStatus: DocumentStatus;
  documentStatuses: DocumentStatus[] = [];
  displayedColumns: string[] = ['action', 'name', 'description', 'colorCode'];
  isLoadingResults = false;

  private subs = new SubSink();
  private documentStatusService = inject(DocumentStatusService);
  private dialog = inject(MatDialog);
  private toastrService = inject(ToastrService);
  private translationService = inject(TranslationService);
  private commonDialogService = inject(CommonDialogService);

  constructor(private fb: FormBuilder) { }

  ngOnInit(): void {
    this.getDocumentStatus();
  }

  getDocumentStatus(): void {
    this.isLoadingResults = true;
    this.documentStatusService.getDocumentStatuss().subscribe({
      next: (data: DocumentStatus[]) => {
        this.documentStatuses = data;
        this.isLoadingResults = false;
      },
      error: (error) => {
        this.isLoadingResults = false;
      },
    });
  }

  onCreateDocumentStatus(): void {
    const dialogRef = this.dialog.open(ManageDocumentStatusComponent, {
      width: '500px',
    });
    this.subs.sink = dialogRef.afterClosed().subscribe((result: DocumentStatus) => {
      if (result) {
        this.documentStatuses = [result, ...this.documentStatuses];
      }
    });
  }

  onEditDocumentStatus(documentStatus: DocumentStatus): void {
    const dialogRef = this.dialog.open(ManageDocumentStatusComponent, {
      width: '500px',
      data: { ...documentStatus }
    });

    this.subs.sink = dialogRef.afterClosed().subscribe((result: DocumentStatus) => {
      if (result) {
        this.documentStatuses = this.documentStatuses.map(item =>
          item.id === result.id ? { ...item, ...result } : item
        );
      }
    });
  }

  deleteDocumentStatus(id: string): void {
    this.subs.sink = this.commonDialogService
      .deleteConformationDialog(
        this.translationService.getValue('ARE_YOU_SURE_YOU_WANT_TO_DELETE')
      )
      .subscribe((isConfirmed) => {
        if (isConfirmed) {
          this.isLoadingResults = true;
          this.documentStatusService.deleteDocumentStatus(id).subscribe({
            next: () => {
              this.isLoadingResults = false;
              this.getDocumentStatus();
              this.toastrService.success(
                this.translationService.getValue(
                  'DOCUMENT_STATUS_DELETED_SUCCESSFULLY'
                )
              );
            },
            error: (error) => {
              this.isLoadingResults = false;
            }
          });
        }
      });
  }

  ngOnDestroy(): void {
    this.subs.unsubscribe();
  }
}
