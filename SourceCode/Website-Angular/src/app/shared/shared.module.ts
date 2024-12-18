import { OverlayModule } from '@angular/cdk/overlay';
import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { NgxDocViewerModule } from 'ngx-doc-viewer';
import { NgxExtendedPdfViewerModule } from 'ngx-extended-pdf-viewer';
import { BasePreviewComponent } from './base-preview/base-preview.component';
import { HasClaimDirective } from './has-claim.directive';
import { PipesModule } from './pipes/pipes.module';
import { ImagePreviewComponent } from './image-preview/image-preview.component';
import { OfficeViewerComponent } from './office-viewer/office-viewer.component';
import { PdfViewerComponent } from './pdf-viewer/pdf-viewer.component';
import { TextPreviewComponent } from './text-preview/text-preview.component';
import { AudioPreviewComponent } from './audio-preview/audio-preview.component';
import { VideoPreviewComponent } from './video-preview/video-preview.component';
import { TranslateModule } from '@ngx-translate/core';
import { FeatherIconsComponent } from './feather-icons/feather-icons.component';
import { FeatherModule } from 'angular-feather';
import { FormsModule } from '@angular/forms';
import { CKEditorModule } from '@ckeditor/ckeditor5-angular';
import { PageHelpPreviewComponent } from './page-help-preview/page-help-preview.component';
import { PageHelpTextComponent } from './page-help-text/page-help-text.component';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule, MatIconButton } from '@angular/material/button';
import { MatDialogModule } from '@angular/material/dialog';


@NgModule({
  exports: [
    HasClaimDirective,
    OverlayModule,
    ImagePreviewComponent,
    BasePreviewComponent,
    AudioPreviewComponent,
    VideoPreviewComponent,
    TranslateModule,
    FeatherIconsComponent,
    PageHelpPreviewComponent,
    PageHelpTextComponent
  ],
  declarations: [
    HasClaimDirective,
    ImagePreviewComponent,
    BasePreviewComponent,
    PdfViewerComponent,
    TextPreviewComponent,
    OfficeViewerComponent,
    AudioPreviewComponent,
    VideoPreviewComponent,
    FeatherIconsComponent,
    PageHelpPreviewComponent,
    PageHelpTextComponent
  ],
  imports: [
    CommonModule,
    OverlayModule,
    NgxDocViewerModule,
    NgxExtendedPdfViewerModule,
    PipesModule,
    FeatherModule,
    FormsModule,
    CKEditorModule,
    MatTooltipModule,
    TranslateModule,
    FeatherModule,
    MatIconModule,
    MatDialogModule,
    MatIconButton
  ]
})
export class SharedModule { }

