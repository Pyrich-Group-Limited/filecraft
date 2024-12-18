import { Component, OnInit, Renderer2 } from '@angular/core';
import {
  UntypedFormBuilder,
  UntypedFormGroup,
  Validators,
} from '@angular/forms';
import { BaseComponent } from '../base.component';
import { Router } from '@angular/router';
import { UserAuth } from '@core/domain-classes/user-auth';
import { SecurityService } from '@core/security/security.service';
import { ToastrService } from 'ngx-toastr';
import { CommonError } from '@core/error-handler/common-error';
import { TranslationService } from '@core/services/translation.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss'],
})
export class LoginComponent extends BaseComponent implements OnInit {
  logoUrl?: string;
  loginFormGroup: UntypedFormGroup;
  isLoading = false;
  lat: number;
  lng: number;

  constructor(
    private fb: UntypedFormBuilder,
    private router: Router,
    private securityService: SecurityService,
    private toastr: ToastrService,
    private renderer: Renderer2,
    private translationService: TranslationService
  ) {
    super();
  }

  ngOnInit(): void {
    this.createFormGroup();
    this.getCompanyProfile();
    navigator.geolocation.getCurrentPosition((position) => {
      this.lat = position.coords.latitude;
      this.lng = position.coords.longitude;
    });
  }

  onLoginSubmit() {
    if (this.loginFormGroup.valid) {
      this.isLoading = true;
      const userObject = {
        ...this.loginFormGroup.value,
        latitude: this.lat,
        longitude: this.lng,
      };
      this.sub$.sink = this.securityService.login(userObject).subscribe({
        next: (c: UserAuth) => {
          this.isLoading = false;
          this.toastr.success(
            this.translationService.getValue('USER_LOGIN_SUCCESSFULLY')
          );
          if (this.securityService.hasClaim('dashboard_view_dashboard')) {
            this.router.navigate(['/dashboard']);
          } else {
            this.router.navigate(['/']);
          }
        },
        error: (err: CommonError) => {
          this.isLoading = false;
          err.messages.forEach((msg) => {
            this.toastr.error(msg);
          });
        },
      });
    }
  }

  createFormGroup(): void {
    this.loginFormGroup = this.fb.group({
      userName: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required]],
    });
  }

  onRegistrationClick(): void {
    this.router.navigate(['/registration']);
  }

  setBackgroundImage(url: string): void {
    const authBg = document.querySelector('.auth-bg');
    if (authBg) {
      this.renderer.setStyle(authBg, 'background-image', `url(${url})`);
    }
  }

  getCompanyProfile(): void {
    this.securityService.companyProfile.subscribe((c) => {
      if (c) {
        this.logoUrl = c.logoUrl;
        this.setBackgroundImage(c.bannerUrl);
      }
    });
  }
}
