"use strict";(self.webpackChunkdocument_management=self.webpackChunkdocument_management||[]).push([[884],{3824:($,g,n)=>{n.d(g,{u:()=>l});class l{fields="";orderBy="";searchQuery="";pageSize=30;skip=0;name="";totalCount=0;metaTags=""}},884:($,g,n)=>{n.r(g),n.d(g,{NLogModule:()=>Rt});var l=n(177),c=n(1188),v=n(3870),t=n(4438),L=n(1626),p=n(9437),D=n(7598);let S=(()=>{class e{httpClient;commonHttpErrorService;constructor(o,a){this.httpClient=o,this.commonHttpErrorService=a}getNLogs(o){const i=(new L.Nl).set("Fields",o.fields).set("OrderBy",o.orderBy).set("PageSize",o.pageSize.toString()).set("Skip",o.skip.toString()).set("SearchQuery",o.searchQuery).set("message",o.message.toString());return this.httpClient.get("NLog",{params:i,observe:"response"}).pipe((0,p.W)(this.commonHttpErrorService.handleError))}getLogDetails(o){return this.httpClient.get(`NLog/${o}`).pipe((0,p.W)(this.commonHttpErrorService.handleError))}static \u0275fac=function(a){return new(a||e)(t.KVO(L.Qq),t.KVO(D.T))};static \u0275prov=t.jDH({token:e,factory:e.\u0275fac,providedIn:"root"})}return e})(),R=(()=>{class e{nLogService;constructor(o){this.nLogService=o}resolve(o,a){const i=o.paramMap.get("id");return this.nLogService.getLogDetails(i)}static \u0275fac=function(a){return new(a||e)(t.KVO(S))};static \u0275prov=t.jDH({token:e,factory:e.\u0275fac})}return e})();var b=n(8),E=n(2243),C=n(9036),u=n(5464),T=n(3955),F=n(9519);const N=()=>["/logs"];function j(e,s){if(1&e&&(t.j41(0,"div",17)(1,"label",18),t.EFF(2),t.nI1(3,"translate"),t.k0s(),t.j41(4,"div",19),t.nrm(5,"textarea",20),t.k0s()()),2&e){const o=t.XpG();t.R7$(2),t.SpI(" ",t.bMT(3,2,"MESSAGE")," "),t.R7$(3),t.FS9("value",o.log.message)}}function y(e,s){if(1&e&&(t.j41(0,"div",17)(1,"label",18),t.EFF(2),t.nI1(3,"translate"),t.k0s(),t.j41(4,"div",19),t.nrm(5,"textarea",20),t.k0s()()),2&e){const o=t.XpG();t.R7$(2),t.SpI(" ",t.bMT(3,2,"LOGGER")," "),t.R7$(3),t.FS9("value",o.log.logger)}}function x(e,s){if(1&e&&(t.j41(0,"div",17)(1,"label",18),t.EFF(2),t.nI1(3,"translate"),t.k0s(),t.j41(4,"div",19),t.nrm(5,"textarea",20),t.k0s()()),2&e){const o=t.XpG();t.R7$(2),t.SpI(" ",t.bMT(3,2,"PROPERTIES")," "),t.R7$(3),t.FS9("value",o.log.properties)}}function G(e,s){if(1&e&&(t.j41(0,"div",17)(1,"label",18),t.EFF(2),t.nI1(3,"translate"),t.k0s(),t.j41(4,"div",19),t.nrm(5,"textarea",20),t.k0s()()),2&e){const o=t.XpG();t.R7$(2),t.SpI(" ",t.bMT(3,2,"CALLSITE")," "),t.R7$(3),t.FS9("value",o.log.callsite)}}function M(e,s){if(1&e&&(t.j41(0,"div",17)(1,"label",18),t.EFF(2),t.nI1(3,"translate"),t.k0s(),t.j41(4,"div",19),t.nrm(5,"textarea",22),t.k0s()()),2&e){const o=t.XpG();t.R7$(2),t.SpI(" ",t.bMT(3,2,"EXCEPTION")," "),t.R7$(3),t.FS9("value",o.log.exception)}}let k=(()=>{class e extends b.${activeRoute;translationService;log;constructor(o,a){super(),this.activeRoute=o,this.translationService=a}ngOnInit(){this.sub$.sink=this.activeRoute.data.subscribe(o=>{o.log&&(this.log=o.log)})}static \u0275fac=function(a){return new(a||e)(t.rXU(c.nX),t.rXU(E.L))};static \u0275cmp=t.VBU({type:e,selectors:[["app-n-log-detail"]],features:[t.Vt3],decls:36,vars:25,consts:[[1,"content"],[1,"container-fluid"],[1,"row","align-items-center"],[1,"col-md-6","mb-2"],[1,"mb-0","page-title"],[3,"code"],[1,"col-md-6","d-flex","justify-content-end","mb-2"],[1,"btn","btn-success","btn-sm","me-2",3,"routerLink"],["name","arrow-left-circle",1,"small-icon"],[1,"card"],[1,"body"],[1,"row"],[1,"col-md-12"],[1,"row","pb-2"],["for","staticEmail",1,"col-sm-2","col-form-label","font-weight-bold"],[1,"col-sm-4"],["readonly","",1,"form-control"],[1,"form-group","row"],["for","inputPassword",1,"col-sm-2","col-form-label","font-weight-bold"],[1,"col-sm-10"],["type","text","readonly","",1,"form-control",3,"value"],["class","form-group row",4,"ngIf"],["type","text","rows","10","readonly","",1,"form-control",3,"value"]],template:function(a,i){1&a&&(t.j41(0,"section",0)(1,"div",1)(2,"div",2)(3,"div",3)(4,"span",4),t.EFF(5),t.nI1(6,"translate"),t.nrm(7,"app-page-help-text",5),t.k0s()(),t.j41(8,"div",6)(9,"button",7),t.nrm(10,"i-feather",8),t.EFF(11),t.nI1(12,"translate"),t.k0s()()(),t.j41(13,"div",9)(14,"div",10)(15,"div",11)(16,"div",12)(17,"div",13)(18,"label",14),t.EFF(19),t.nI1(20,"translate"),t.k0s(),t.j41(21,"div",15)(22,"span",16),t.EFF(23),t.nI1(24,"utcToLocalTime"),t.k0s()()(),t.j41(25,"div",17)(26,"label",18),t.EFF(27),t.nI1(28,"translate"),t.k0s(),t.j41(29,"div",19),t.nrm(30,"input",20),t.k0s()(),t.DNE(31,j,6,4,"div",21)(32,y,6,4,"div",21)(33,x,6,4,"div",21)(34,G,6,4,"div",21)(35,M,6,4,"div",21),t.k0s()()()()()()),2&a&&(t.R7$(5),t.SpI("",t.bMT(6,13,"LOG_DETAIL")," "),t.R7$(2),t.Y8G("code","ERROR_LOGS"),t.R7$(2),t.Y8G("routerLink",t.lJ4(24,N)),t.R7$(2),t.SpI(" ",t.bMT(12,15,"BACK_TO_LIST")," "),t.R7$(8),t.SpI(" ",t.bMT(20,17,"DATE_TIME")," "),t.R7$(4),t.JRh(t.i5U(24,19,i.log.logged,"full")),t.R7$(4),t.SpI(" ",t.bMT(28,22,"LEVEL")," "),t.R7$(3),t.FS9("value",i.log.level),t.R7$(),t.Y8G("ngIf",i.log.message),t.R7$(),t.Y8G("ngIf",i.log.logger),t.R7$(),t.Y8G("ngIf",i.log.properties),t.R7$(),t.Y8G("ngIf",i.log.callsite),t.R7$(),t.Y8G("ngIf",i.log.exception))},dependencies:[l.bT,C.J,c.Wk,u.X,T.D9,F.o],styles:[".form-control[_ngcontent-%COMP%]:disabled, .form-control[readonly][_ngcontent-%COMP%]{background-color:#fff!important}"]})}return e})();var f=n(6695),d=n(2042),w=n(3824);class O extends w.u{message=""}var Y=n(7786),V=n(3726),I=n(8141),A=n(152),H=n(3294),h=n(4412),B=n(7673),X=n(980);class z{nLogService;nLogSubject=new h.t([]);responseHeaderSubject=new h.t(null);loadingSubject=new h.t(!1);loading$=this.loadingSubject.asObservable();_count=0;get count(){return this._count}responseHeaderSubject$=this.responseHeaderSubject.asObservable();constructor(s){this.nLogService=s}connect(){return this.nLogSubject.asObservable()}disconnect(){this.nLogSubject.complete(),this.loadingSubject.complete()}loadNLogs(s){this.loadingSubject.next(!0),this.nLogService.getNLogs(s).pipe((0,p.W)(()=>(0,B.of)([])),(0,X.j)(()=>this.loadingSubject.next(!1))).subscribe(o=>{const a=JSON.parse(o.headers.get("X-Pagination"));this.responseHeaderSubject.next(a);const i=[...o.body];this._count=i.length,this.nLogSubject.next(i)})}}var P=n(6292),r=n(9159);const J=["input"],U=()=>["footer"],Q=e=>["/logs",e],W=()=>[10,20,30];function K(e,s){1&e&&(t.j41(0,"th",34),t.EFF(1),t.nI1(2,"translate"),t.k0s()),2&e&&(t.R7$(),t.SpI(" ",t.bMT(2,1,"ACTION")," "))}function Z(e,s){if(1&e&&(t.j41(0,"td",35)(1,"button",36),t.nrm(2,"i-feather",37),t.j41(3,"span",38),t.EFF(4),t.nI1(5,"translate"),t.k0s()()()),2&e){const o=s.$implicit;t.R7$(),t.Y8G("routerLink",t.eq3(4,Q,o.id)),t.R7$(3),t.SpI(" ",t.bMT(5,2,"DETAIL"),"")}}function _(e,s){1&e&&(t.j41(0,"th",39),t.EFF(1),t.nI1(2,"translate"),t.k0s()),2&e&&(t.R7$(),t.SpI(" ",t.bMT(2,1,"DATE_TIME")," "))}function q(e,s){if(1&e&&(t.j41(0,"td",40),t.EFF(1),t.nI1(2,"utcToLocalTime"),t.k0s()),2&e){const o=s.$implicit;t.R7$(),t.SpI(" ",t.i5U(2,1,null==o?null:o.logged,"full")," ")}}function tt(e,s){1&e&&(t.j41(0,"th",41),t.EFF(1),t.nI1(2,"translate"),t.k0s()),2&e&&(t.R7$(),t.SpI(" ",t.bMT(2,1,"LEVEL")," "))}function et(e,s){1&e&&(t.j41(0,"span",47),t.EFF(1),t.nI1(2,"translate"),t.k0s()),2&e&&(t.R7$(),t.JRh(t.bMT(2,1,"LEVEL_FATAL")))}function ot(e,s){1&e&&(t.j41(0,"span",47),t.EFF(1),t.nI1(2,"translate"),t.k0s()),2&e&&(t.R7$(),t.JRh(t.bMT(2,1,"LEVEL_ERROR")))}function nt(e,s){1&e&&(t.j41(0,"span",48),t.EFF(1),t.nI1(2,"translate"),t.k0s()),2&e&&(t.R7$(),t.JRh(t.bMT(2,1,"LEVEL_WARN")))}function at(e,s){1&e&&(t.j41(0,"span",49),t.EFF(1),t.nI1(2,"translate"),t.k0s()),2&e&&(t.R7$(),t.JRh(t.bMT(2,1,"LEVEL_DEFAULT")))}function st(e,s){if(1&e&&(t.j41(0,"td",42),t.qex(1,43),t.DNE(2,et,3,3,"span",44)(3,ot,3,3,"span",44)(4,nt,3,3,"span",45)(5,at,3,3,"span",46),t.bVm(),t.k0s()),2&e){const o=s.$implicit;t.R7$(),t.Y8G("ngSwitch",null==o?null:o.level),t.R7$(),t.Y8G("ngSwitchCase","Fatal"),t.R7$(),t.Y8G("ngSwitchCase","Error"),t.R7$(),t.Y8G("ngSwitchCase","Warn")}}function it(e,s){1&e&&(t.j41(0,"th",50),t.EFF(1),t.nI1(2,"translate"),t.k0s()),2&e&&(t.R7$(),t.SpI(" ",t.bMT(2,1,"MESSAGE")," "))}function rt(e,s){if(1&e&&(t.j41(0,"td",51),t.EFF(1),t.k0s()),2&e){const o=s.$implicit;t.R7$(),t.SpI(" ",o.message," ")}}function lt(e,s){if(1&e&&(t.j41(0,"td",52),t.nrm(1,"mat-paginator",53),t.k0s()),2&e){const o=t.XpG();t.R7$(),t.Y8G("length",o.nLogResource.totalCount)("pageSize",o.nLogResource.pageSize)("pageSizeOptions",t.lJ4(3,W))}}function ct(e,s){1&e&&(t.j41(0,"tr")(1,"td",54)(2,"div",55)(3,"b"),t.EFF(4),t.nI1(5,"translate"),t.k0s()()()()),2&e&&(t.R7$(4),t.SpI(" ",t.bMT(5,1,"NO_DATA_FOUND"),""))}function mt(e,s){1&e&&t.nrm(0,"tr",56)}function gt(e,s){1&e&&t.nrm(0,"tr",57)}function dt(e,s){1&e&&t.nrm(0,"tr",58)}function pt(e,s){1&e&&(t.j41(0,"div",59)(1,"div",60)(2,"span",61),t.EFF(3,"Loading..."),t.k0s()()())}const ut=[{path:"",component:(()=>{class e extends b.${nLogService;translationService;breakpointsService;dataSource;logs=[];displayedColumns=["action","logged","level","message"];isLoadingResults=!0;nLogResource;loading$;paginator;sort;input;footerToDisplayed=["footer"];constructor(o,a,i){super(),this.nLogService=o,this.translationService=a,this.breakpointsService=i,this.nLogResource=new O,this.nLogResource.pageSize=10,this.nLogResource.orderBy="logged desc"}ngOnInit(){this.dataSource=new z(this.nLogService),this.dataSource.loadNLogs(this.nLogResource),this.getResourceParameter()}ngAfterViewInit(){this.sort.sortChange.subscribe(()=>this.paginator.pageIndex=0),this.sub$.sink=(0,Y.h)(this.sort.sortChange,this.paginator.page).pipe((0,I.M)(o=>{this.nLogResource.skip=this.paginator.pageIndex*this.paginator.pageSize,this.nLogResource.pageSize=this.paginator.pageSize,this.nLogResource.orderBy=this.sort.active+" "+this.sort.direction,this.dataSource.loadNLogs(this.nLogResource)})).subscribe(),this.sub$.sink=(0,V.R)(this.input.nativeElement,"keyup").pipe((0,A.B)(1e3),(0,H.F)(),(0,I.M)(()=>{this.paginator.pageIndex=0,this.nLogResource.message=this.input.nativeElement.value,this.dataSource.loadNLogs(this.nLogResource)})).subscribe()}getResourceParameter(){this.sub$.sink=this.dataSource.responseHeaderSubject$.subscribe(o=>{o&&(this.nLogResource.pageSize=o.pageSize,this.nLogResource.skip=o.skip,this.nLogResource.totalCount=o.totalCount)})}static \u0275fac=function(a){return new(a||e)(t.rXU(S),t.rXU(E.L),t.rXU(P.s))};static \u0275cmp=t.VBU({type:e,selectors:[["app-n-log-list"]],viewQuery:function(a,i){if(1&a&&(t.GBs(f.iy,5),t.GBs(d.B4,5),t.GBs(J,5)),2&a){let m;t.mGM(m=t.lsd())&&(i.paginator=m.first),t.mGM(m=t.lsd())&&(i.sort=m.first),t.mGM(m=t.lsd())&&(i.input=m.first)}},features:[t.Vt3],decls:38,vars:17,consts:[["input",""],[1,"content"],[1,"container-fluid"],[1,"row","align-items-center"],[1,"col-md-6","mb-2"],[1,"mb-0","page-title"],[3,"code"],[1,"card"],[1,"header"],[1,"d-flex"],[1,"form-control",3,"placeholder"],[1,"body"],[1,"table-responsive"],[1,"grid-height-medium"],["mat-table","","matSortDisableClear","","matSort","","matSortActive","logged","matSortDirection","desc",1,"w-100",3,"dataSource"],["matColumnDef","action"],["class","table-column-fix-150","mat-header-cell","",4,"matHeaderCellDef"],["mat-cell","","style","width: 10%;","mat-cell","",4,"matCellDef"],["matColumnDef","logged"],["class","table-column-200","mat-header-cell","","mat-sort-header","",4,"matHeaderCellDef"],["class","table-column-200","mat-cell","",4,"matCellDef"],["matColumnDef","level"],["mat-header-cell","","mat-sort-header","",4,"matHeaderCellDef"],["mat-cell","",4,"matCellDef"],["matColumnDef","message"],["class","table-column-500","mat-header-cell","","mat-sort-header","",4,"matHeaderCellDef"],["class","table-column-500","mat-cell","",4,"matCellDef"],["matColumnDef","footer"],["mat-footer-cell","","colspan","5",4,"matFooterCellDef"],[4,"matNoDataRow"],["mat-header-row","",4,"matHeaderRowDef","matHeaderRowDefSticky"],["mat-row","",4,"matRowDef","matRowDefColumns"],["mat-footer-row","",4,"matFooterRowDef","matFooterRowDefSticky"],["class","spinner-container",4,"ngIf"],["mat-header-cell","",1,"table-column-fix-150"],["mat-cell","","mat-cell","",2,"width","10%"],["type","button",1,"btn","btn-success","btn-sm","mr-3",3,"routerLink"],["name","info",1,"small-icon"],[1,"d-none","d-sm-inline"],["mat-header-cell","","mat-sort-header","",1,"table-column-200"],["mat-cell","",1,"table-column-200"],["mat-header-cell","","mat-sort-header",""],["mat-cell",""],[3,"ngSwitch"],["class","badge bg-danger",4,"ngSwitchCase"],["class","badge bg-warning",4,"ngSwitchCase"],["class","badge bg-primary",4,"ngSwitchDefault"],[1,"badge","bg-danger"],[1,"badge","bg-warning"],[1,"badge","bg-primary"],["mat-header-cell","","mat-sort-header","",1,"table-column-500"],["mat-cell","",1,"table-column-500"],["mat-footer-cell","","colspan","5"],[3,"length","pageSize","pageSizeOptions"],["colspan","5"],[1,"m-2"],["mat-header-row",""],["mat-row",""],["mat-footer-row",""],[1,"spinner-container"],["role","status",1,"spinner-border","text-primary"],[1,"visually-hidden"]],template:function(a,i){1&a&&(t.j41(0,"section",1)(1,"div",2)(2,"div",3)(3,"div",4)(4,"span",5),t.EFF(5),t.nI1(6,"translate"),t.nrm(7,"app-page-help-text",6),t.k0s()()(),t.j41(8,"div",7)(9,"div",8)(10,"div",9),t.nrm(11,"input",10,0),t.nI1(13,"translate"),t.k0s()(),t.j41(14,"div",11)(15,"div",12)(16,"div",13)(17,"table",14),t.qex(18,15),t.DNE(19,K,3,3,"th",16)(20,Z,6,6,"td",17),t.bVm(),t.qex(21,18),t.DNE(22,_,3,3,"th",19)(23,q,3,4,"td",20),t.bVm(),t.qex(24,21),t.DNE(25,tt,3,3,"th",22)(26,st,6,4,"td",23),t.bVm(),t.qex(27,24),t.DNE(28,it,3,3,"th",25)(29,rt,2,1,"td",26),t.bVm(),t.qex(30,27),t.DNE(31,lt,2,4,"td",28),t.bVm(),t.DNE(32,ct,6,3,"tr",29)(33,mt,1,0,"tr",30)(34,gt,1,0,"tr",31)(35,dt,1,0,"tr",32),t.k0s()()()()()()(),t.DNE(36,pt,4,0,"div",33),t.nI1(37,"async")),2&a&&(t.R7$(5),t.SpI("",t.bMT(6,10,"ERROR_LOGS")," "),t.R7$(2),t.Y8G("code","ERROR_LOGS"),t.R7$(4),t.FS9("placeholder",t.bMT(13,12,"SEARCH_BY_MESSAGE")),t.R7$(6),t.Y8G("dataSource",i.dataSource),t.R7$(16),t.Y8G("matHeaderRowDef",i.displayedColumns)("matHeaderRowDefSticky",!0),t.R7$(),t.Y8G("matRowDefColumns",i.displayedColumns),t.R7$(),t.Y8G("matFooterRowDef",t.lJ4(16,U))("matFooterRowDefSticky",!0),t.R7$(),t.Y8G("ngIf",t.bMT(37,14,i.dataSource.loading$)))},dependencies:[l.bT,l.ux,l.e1,l.fG,C.J,r.Zl,r.tL,r.ji,r.cC,r.YV,r.iL,r.Zq,r.xW,r.KS,r.$R,r.Qo,r.YZ,r.NB,r.iF,r.ky,d.B4,d.aE,f.iy,c.Wk,u.X,l.Jj,T.D9,F.o],styles:[".badge[_ngcontent-%COMP%]{font-weight:400;padding:.5em .6em}"]})}return e})(),data:{claimType:"error_logs_view_error_logs"},canActivate:[v.q]},{path:":id",component:k,canActivate:[v.q],data:{claimType:"error_logs_view_error_logs"},resolve:{log:R}}];let ft=(()=>{class e{static \u0275fac=function(a){return new(a||e)};static \u0275mod=t.$C({type:e});static \u0275inj=t.G2t({imports:[c.iI.forChild(ut),c.iI]})}return e})();var ht=n(9631),vt=n(3887),Lt=n(2798),St=n(3679);let Rt=(()=>{class e{static \u0275fac=function(a){return new(a||e)};static \u0275mod=t.$C({type:e});static \u0275inj=t.G2t({providers:[R],imports:[l.MD,vt.G,r.tP,d.NQ,f.Ou,ht.fS,Lt.Ve,ft,u.M,St.Y]})}return e})()}}]);