import { BrowserModule } from '@angular/platform-browser';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { NgModule } from '@angular/core';
import { ToastrModule } from 'ngx-toastr';
import { AppComponent } from './app.component';
import { CoreModule } from './core/core.module';
import { HttpClient, provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { AppRoutingModule } from './app-routing.module';
import { HttpInterceptorModule } from './http-interceptor.module';
import { AppStoreModule } from './store/app-store.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PendingInterceptorModule } from '@shared/loading-indicator/pending-interceptor.module';
import { TranslateLoader, TranslateModule } from '@ngx-translate/core';
import { createTranslateLoader } from './translater-loader';
import { MatNativeDateModule } from '@angular/material/core';

@NgModule({
  declarations: [
    AppComponent,
  ],
  bootstrap: [AppComponent], imports: [BrowserModule,
    BrowserAnimationsModule,
    FormsModule,
    ReactiveFormsModule,
    AppRoutingModule,
    CoreModule,
    MatNativeDateModule,
    TranslateModule.forRoot({
      loader: {
        provide: TranslateLoader,
        useFactory: (createTranslateLoader),
        deps: [HttpClient]
      }
    }),
    ToastrModule.forRoot(),
    HttpInterceptorModule,
    AppStoreModule,
    PendingInterceptorModule], providers: [provideHttpClient(withInterceptorsFromDi())]
})
export class AppModule { }
