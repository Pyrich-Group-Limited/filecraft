"use strict";(self.webpackChunkdocument_management=self.webpackChunkdocument_management||[]).push([[798],{2798:(oe,R,r)=>{r.d(R,{$2:()=>te,VO:()=>ee,Ve:()=>ie});var _=r(7987),S=r(177),t=r(4438),p=r(6600),b=r(3719),E=r(7333),f=r(9888),B=r(8203),L=r(5024),o=r(7336),v=r(9417),y=r(1413),W=r(9030),C=r(7786),k=r(9172),D=r(5558),w=r(5964),I=r(6354),F=r(3294),g=r(6977),K=r(6697),c=r(9969);const V=["trigger"],U=["panel"],j=[[["mat-select-trigger"]],"*"],G=["mat-select-trigger","*"];function X(n,u){if(1&n&&(t.j41(0,"span",4),t.EFF(1),t.k0s()),2&n){const e=t.XpG();t.R7$(),t.JRh(e.placeholder)}}function z(n,u){1&n&&t.SdG(0)}function N(n,u){if(1&n&&(t.j41(0,"span",11),t.EFF(1),t.k0s()),2&n){const e=t.XpG(2);t.R7$(),t.JRh(e.triggerValue)}}function Q(n,u){if(1&n&&(t.j41(0,"span",5),t.DNE(1,z,1,0)(2,N,2,1,"span",11),t.k0s()),2&n){const e=t.XpG();t.R7$(),t.vxM(e.customTrigger?1:2)}}function Y(n,u){if(1&n){const e=t.RV6();t.j41(0,"div",12,1),t.bIt("@transformPanel.done",function(a){t.eBV(e);const s=t.XpG();return t.Njj(s._panelDoneAnimatingStream.next(a.toState))})("keydown",function(a){t.eBV(e);const s=t.XpG();return t.Njj(s._handleKeydown(a))}),t.SdG(2,1),t.k0s()}if(2&n){const e=t.XpG();t.ZvI("mat-mdc-select-panel mdc-menu-surface mdc-menu-surface--open ",e._getPanelTheme(),""),t.Y8G("ngClass",e.panelClass)("@transformPanel","showing"),t.BMQ("id",e.id+"-panel")("aria-multiselectable",e.multiple)("aria-label",e.ariaLabel||null)("aria-labelledby",e._getPanelAriaLabelledby())}}const $={transformPanelWrap:(0,c.hZ)("transformPanelWrap",[(0,c.kY)("* => void",(0,c.P)("@transformPanel",[(0,c.MA)()],{optional:!0}))]),transformPanel:(0,c.hZ)("transformPanel",[(0,c.wk)("void",(0,c.iF)({opacity:0,transform:"scale(1, 0.8)"})),(0,c.kY)("void => showing",(0,c.i0)("120ms cubic-bezier(0, 0, 0.2, 1)",(0,c.iF)({opacity:1,transform:"scale(1, 1)"}))),(0,c.kY)("* => void",(0,c.i0)("100ms linear",(0,c.iF)({opacity:0})))])};let A=0;const T=new t.nKC("mat-select-scroll-strategy",{providedIn:"root",factory:()=>{const n=(0,t.WQX)(_.hJ);return()=>n.scrollStrategies.reposition()}}),J=new t.nKC("MAT_SELECT_CONFIG"),Z={provide:T,deps:[_.hJ],useFactory:function H(n){return()=>n.scrollStrategies.reposition()}},x=new t.nKC("MatSelectTrigger");class q{constructor(u,e){this.source=u,this.value=e}}let ee=(()=>{class n{_scrollOptionIntoView(e){const i=this.options.toArray()[e];if(i){const a=this.panel.nativeElement,s=(0,p.jb)(e,this.options,this.optionGroups),l=i._getHostElement();a.scrollTop=0===e&&1===s?0:(0,p.TL)(l.offsetTop,l.offsetHeight,a.scrollTop,a.offsetHeight)}}_positioningSettled(){this._scrollOptionIntoView(this._keyManager.activeItemIndex||0)}_getChangeEvent(e){return new q(this,e)}get focused(){return this._focused||this._panelOpen}get hideSingleSelectionIndicator(){return this._hideSingleSelectionIndicator}set hideSingleSelectionIndicator(e){this._hideSingleSelectionIndicator=e,this._syncParentProperties()}get placeholder(){return this._placeholder}set placeholder(e){this._placeholder=e,this.stateChanges.next()}get required(){return this._required??this.ngControl?.control?.hasValidator(v.k0.required)??!1}set required(e){this._required=e,this.stateChanges.next()}get multiple(){return this._multiple}set multiple(e){this._multiple=e}get compareWith(){return this._compareWith}set compareWith(e){this._compareWith=e,this._selectionModel&&this._initializeSelection()}get value(){return this._value}set value(e){this._assignValue(e)&&this._onChange(e)}get errorStateMatcher(){return this._errorStateTracker.matcher}set errorStateMatcher(e){this._errorStateTracker.matcher=e}get id(){return this._id}set id(e){this._id=e||this._uid,this.stateChanges.next()}get errorState(){return this._errorStateTracker.errorState}set errorState(e){this._errorStateTracker.errorState=e}constructor(e,i,a,s,l,m,d,ae,ne,P,se,re,le,M){this._viewportRuler=e,this._changeDetectorRef=i,this._elementRef=l,this._dir=m,this._parentFormField=ne,this.ngControl=P,this._liveAnnouncer=le,this._defaultOptions=M,this._positions=[{originX:"start",originY:"bottom",overlayX:"start",overlayY:"top"},{originX:"end",originY:"bottom",overlayX:"end",overlayY:"top"},{originX:"start",originY:"top",overlayX:"start",overlayY:"bottom",panelClass:"mat-mdc-select-panel-above"},{originX:"end",originY:"top",overlayX:"end",overlayY:"bottom",panelClass:"mat-mdc-select-panel-above"}],this._panelOpen=!1,this._compareWith=(h,O)=>h===O,this._uid="mat-select-"+A++,this._triggerAriaLabelledBy=null,this._destroy=new y.B,this.stateChanges=new y.B,this.disableAutomaticLabeling=!0,this._onChange=()=>{},this._onTouched=()=>{},this._valueId="mat-select-value-"+A++,this._panelDoneAnimatingStream=new y.B,this._overlayPanelClass=this._defaultOptions?.overlayPanelClass||"",this._focused=!1,this.controlType="mat-select",this.disabled=!1,this.disableRipple=!1,this.tabIndex=0,this._hideSingleSelectionIndicator=this._defaultOptions?.hideSingleSelectionIndicator??!1,this._multiple=!1,this.disableOptionCentering=this._defaultOptions?.disableOptionCentering??!1,this.ariaLabel="",this.panelWidth=this._defaultOptions&&typeof this._defaultOptions.panelWidth<"u"?this._defaultOptions.panelWidth:"auto",this._initialized=new y.B,this.optionSelectionChanges=(0,W.v)(()=>{const h=this.options;return h?h.changes.pipe((0,k.Z)(h),(0,D.n)(()=>(0,C.h)(...h.map(O=>O.onSelectionChange)))):this._initialized.pipe((0,D.n)(()=>this.optionSelectionChanges))}),this.openedChange=new t.bkB,this._openedStream=this.openedChange.pipe((0,w.p)(h=>h),(0,I.T)(()=>{})),this._closedStream=this.openedChange.pipe((0,w.p)(h=>!h),(0,I.T)(()=>{})),this.selectionChange=new t.bkB,this.valueChange=new t.bkB,this._trackedModal=null,this._skipPredicate=h=>!this.panelOpen&&h.disabled,this.ngControl&&(this.ngControl.valueAccessor=this),null!=M?.typeaheadDebounceInterval&&(this.typeaheadDebounceInterval=M.typeaheadDebounceInterval),this._errorStateTracker=new p.X0(s,P,ae,d,this.stateChanges),this._scrollStrategyFactory=re,this._scrollStrategy=this._scrollStrategyFactory(),this.tabIndex=parseInt(se)||0,this.id=this.id}ngOnInit(){this._selectionModel=new L.CB(this.multiple),this.stateChanges.next(),this._panelDoneAnimatingStream.pipe((0,F.F)(),(0,g.Q)(this._destroy)).subscribe(()=>this._panelDoneAnimating(this.panelOpen)),this._viewportRuler.change().pipe((0,g.Q)(this._destroy)).subscribe(()=>{this.panelOpen&&(this._overlayWidth=this._getOverlayWidth(this._preferredOverlayOrigin),this._changeDetectorRef.detectChanges())})}ngAfterContentInit(){this._initialized.next(),this._initialized.complete(),this._initKeyManager(),this._selectionModel.changed.pipe((0,g.Q)(this._destroy)).subscribe(e=>{e.added.forEach(i=>i.select()),e.removed.forEach(i=>i.deselect())}),this.options.changes.pipe((0,k.Z)(null),(0,g.Q)(this._destroy)).subscribe(()=>{this._resetOptions(),this._initializeSelection()})}ngDoCheck(){const e=this._getTriggerAriaLabelledby(),i=this.ngControl;if(e!==this._triggerAriaLabelledBy){const a=this._elementRef.nativeElement;this._triggerAriaLabelledBy=e,e?a.setAttribute("aria-labelledby",e):a.removeAttribute("aria-labelledby")}i&&(this._previousControl!==i.control&&(void 0!==this._previousControl&&null!==i.disabled&&i.disabled!==this.disabled&&(this.disabled=i.disabled),this._previousControl=i.control),this.updateErrorState())}ngOnChanges(e){(e.disabled||e.userAriaDescribedBy)&&this.stateChanges.next(),e.typeaheadDebounceInterval&&this._keyManager&&this._keyManager.withTypeAhead(this.typeaheadDebounceInterval)}ngOnDestroy(){this._keyManager?.destroy(),this._destroy.next(),this._destroy.complete(),this.stateChanges.complete(),this._clearFromModal()}toggle(){this.panelOpen?this.close():this.open()}open(){this._canOpen()&&(this._parentFormField&&(this._preferredOverlayOrigin=this._parentFormField.getConnectedOverlayOrigin()),this._overlayWidth=this._getOverlayWidth(this._preferredOverlayOrigin),this._applyModalPanelOwnership(),this._panelOpen=!0,this._keyManager.withHorizontalOrientation(null),this._highlightCorrectOption(),this._changeDetectorRef.markForCheck(),this.stateChanges.next())}_applyModalPanelOwnership(){const e=this._elementRef.nativeElement.closest('body > .cdk-overlay-container [aria-modal="true"]');if(!e)return;const i=`${this.id}-panel`;this._trackedModal&&(0,f.Ae)(this._trackedModal,"aria-owns",i),(0,f.px)(e,"aria-owns",i),this._trackedModal=e}_clearFromModal(){this._trackedModal&&((0,f.Ae)(this._trackedModal,"aria-owns",`${this.id}-panel`),this._trackedModal=null)}close(){this._panelOpen&&(this._panelOpen=!1,this._keyManager.withHorizontalOrientation(this._isRtl()?"rtl":"ltr"),this._changeDetectorRef.markForCheck(),this._onTouched(),this.stateChanges.next())}writeValue(e){this._assignValue(e)}registerOnChange(e){this._onChange=e}registerOnTouched(e){this._onTouched=e}setDisabledState(e){this.disabled=e,this._changeDetectorRef.markForCheck(),this.stateChanges.next()}get panelOpen(){return this._panelOpen}get selected(){return this.multiple?this._selectionModel?.selected||[]:this._selectionModel?.selected[0]}get triggerValue(){if(this.empty)return"";if(this._multiple){const e=this._selectionModel.selected.map(i=>i.viewValue);return this._isRtl()&&e.reverse(),e.join(", ")}return this._selectionModel.selected[0].viewValue}updateErrorState(){this._errorStateTracker.updateErrorState()}_isRtl(){return!!this._dir&&"rtl"===this._dir.value}_handleKeydown(e){this.disabled||(this.panelOpen?this._handleOpenKeydown(e):this._handleClosedKeydown(e))}_handleClosedKeydown(e){const i=e.keyCode,a=i===o.n6||i===o.i7||i===o.UQ||i===o.LE,s=i===o.Fm||i===o.t6,l=this._keyManager;if(!l.isTyping()&&s&&!(0,o.rp)(e)||(this.multiple||e.altKey)&&a)e.preventDefault(),this.open();else if(!this.multiple){const m=this.selected;l.onKeydown(e);const d=this.selected;d&&m!==d&&this._liveAnnouncer.announce(d.viewValue,1e4)}}_handleOpenKeydown(e){const i=this._keyManager,a=e.keyCode,s=a===o.n6||a===o.i7,l=i.isTyping();if(s&&e.altKey)e.preventDefault(),this.close();else if(l||a!==o.Fm&&a!==o.t6||!i.activeItem||(0,o.rp)(e))if(!l&&this._multiple&&a===o.A&&e.ctrlKey){e.preventDefault();const m=this.options.some(d=>!d.disabled&&!d.selected);this.options.forEach(d=>{d.disabled||(m?d.select():d.deselect())})}else{const m=i.activeItemIndex;i.onKeydown(e),this._multiple&&s&&e.shiftKey&&i.activeItem&&i.activeItemIndex!==m&&i.activeItem._selectViaInteraction()}else e.preventDefault(),i.activeItem._selectViaInteraction()}_onFocus(){this.disabled||(this._focused=!0,this.stateChanges.next())}_onBlur(){this._focused=!1,this._keyManager?.cancelTypeahead(),!this.disabled&&!this.panelOpen&&(this._onTouched(),this._changeDetectorRef.markForCheck(),this.stateChanges.next())}_onAttached(){this._overlayDir.positionChange.pipe((0,K.s)(1)).subscribe(()=>{this._changeDetectorRef.detectChanges(),this._positioningSettled()})}_getPanelTheme(){return this._parentFormField?`mat-${this._parentFormField.color}`:""}get empty(){return!this._selectionModel||this._selectionModel.isEmpty()}_initializeSelection(){Promise.resolve().then(()=>{this.ngControl&&(this._value=this.ngControl.value),this._setSelectionByValue(this._value),this.stateChanges.next()})}_setSelectionByValue(e){if(this.options.forEach(i=>i.setInactiveStyles()),this._selectionModel.clear(),this.multiple&&e)Array.isArray(e),e.forEach(i=>this._selectOptionByValue(i)),this._sortValues();else{const i=this._selectOptionByValue(e);i?this._keyManager.updateActiveItem(i):this.panelOpen||this._keyManager.updateActiveItem(-1)}this._changeDetectorRef.markForCheck()}_selectOptionByValue(e){const i=this.options.find(a=>{if(this._selectionModel.isSelected(a))return!1;try{return null!=a.value&&this._compareWith(a.value,e)}catch{return!1}});return i&&this._selectionModel.select(i),i}_assignValue(e){return!!(e!==this._value||this._multiple&&Array.isArray(e))&&(this.options&&this._setSelectionByValue(e),this._value=e,!0)}_getOverlayWidth(e){return"auto"===this.panelWidth?(e instanceof _.$Q?e.elementRef:e||this._elementRef).nativeElement.getBoundingClientRect().width:null===this.panelWidth?"":this.panelWidth}_syncParentProperties(){if(this.options)for(const e of this.options)e._changeDetectorRef.markForCheck()}_initKeyManager(){this._keyManager=new f.Au(this.options).withTypeAhead(this.typeaheadDebounceInterval).withVerticalOrientation().withHorizontalOrientation(this._isRtl()?"rtl":"ltr").withHomeAndEnd().withPageUpDown().withAllowedModifierKeys(["shiftKey"]).skipPredicate(this._skipPredicate),this._keyManager.tabOut.subscribe(()=>{this.panelOpen&&(!this.multiple&&this._keyManager.activeItem&&this._keyManager.activeItem._selectViaInteraction(),this.focus(),this.close())}),this._keyManager.change.subscribe(()=>{this._panelOpen&&this.panel?this._scrollOptionIntoView(this._keyManager.activeItemIndex||0):!this._panelOpen&&!this.multiple&&this._keyManager.activeItem&&this._keyManager.activeItem._selectViaInteraction()})}_resetOptions(){const e=(0,C.h)(this.options.changes,this._destroy);this.optionSelectionChanges.pipe((0,g.Q)(e)).subscribe(i=>{this._onSelect(i.source,i.isUserInput),i.isUserInput&&!this.multiple&&this._panelOpen&&(this.close(),this.focus())}),(0,C.h)(...this.options.map(i=>i._stateChanges)).pipe((0,g.Q)(e)).subscribe(()=>{this._changeDetectorRef.detectChanges(),this.stateChanges.next()})}_onSelect(e,i){const a=this._selectionModel.isSelected(e);null!=e.value||this._multiple?(a!==e.selected&&(e.selected?this._selectionModel.select(e):this._selectionModel.deselect(e)),i&&this._keyManager.setActiveItem(e),this.multiple&&(this._sortValues(),i&&this.focus())):(e.deselect(),this._selectionModel.clear(),null!=this.value&&this._propagateChanges(e.value)),a!==this._selectionModel.isSelected(e)&&this._propagateChanges(),this.stateChanges.next()}_sortValues(){if(this.multiple){const e=this.options.toArray();this._selectionModel.sort((i,a)=>this.sortComparator?this.sortComparator(i,a,e):e.indexOf(i)-e.indexOf(a)),this.stateChanges.next()}}_propagateChanges(e){let i;i=this.multiple?this.selected.map(a=>a.value):this.selected?this.selected.value:e,this._value=i,this.valueChange.emit(i),this._onChange(i),this.selectionChange.emit(this._getChangeEvent(i)),this._changeDetectorRef.markForCheck()}_highlightCorrectOption(){if(this._keyManager)if(this.empty){let e=-1;for(let i=0;i<this.options.length;i++)if(!this.options.get(i).disabled){e=i;break}this._keyManager.setActiveItem(e)}else this._keyManager.setActiveItem(this._selectionModel.selected[0])}_canOpen(){return!this._panelOpen&&!this.disabled&&this.options?.length>0}focus(e){this._elementRef.nativeElement.focus(e)}_getPanelAriaLabelledby(){if(this.ariaLabel)return null;const e=this._parentFormField?.getLabelId();return this.ariaLabelledby?(e?e+" ":"")+this.ariaLabelledby:e}_getAriaActiveDescendant(){return this.panelOpen&&this._keyManager&&this._keyManager.activeItem?this._keyManager.activeItem.id:null}_getTriggerAriaLabelledby(){if(this.ariaLabel)return null;const e=this._parentFormField?.getLabelId();let i=(e?e+" ":"")+this._valueId;return this.ariaLabelledby&&(i+=" "+this.ariaLabelledby),i}_panelDoneAnimating(e){this.openedChange.emit(e)}setDescribedByIds(e){e.length?this._elementRef.nativeElement.setAttribute("aria-describedby",e.join(" ")):this._elementRef.nativeElement.removeAttribute("aria-describedby")}onContainerClick(){this.focus(),this.open()}get shouldLabelFloat(){return this.panelOpen||!this.empty||this.focused&&!!this.placeholder}static{this.\u0275fac=function(i){return new(i||n)(t.rXU(E.Xj),t.rXU(t.gRc),t.rXU(t.SKi),t.rXU(p.es),t.rXU(t.aKT),t.rXU(B.dS,8),t.rXU(v.cV,8),t.rXU(v.j4,8),t.rXU(b.xb,8),t.rXU(v.vO,10),t.kS0("tabindex"),t.rXU(T),t.rXU(f.Ai),t.rXU(J,8))}}static{this.\u0275cmp=t.VBU({type:n,selectors:[["mat-select"]],contentQueries:function(i,a,s){if(1&i&&(t.wni(s,x,5),t.wni(s,p.wT,5),t.wni(s,p.QC,5)),2&i){let l;t.mGM(l=t.lsd())&&(a.customTrigger=l.first),t.mGM(l=t.lsd())&&(a.options=l),t.mGM(l=t.lsd())&&(a.optionGroups=l)}},viewQuery:function(i,a){if(1&i&&(t.GBs(V,5),t.GBs(U,5),t.GBs(_.WB,5)),2&i){let s;t.mGM(s=t.lsd())&&(a.trigger=s.first),t.mGM(s=t.lsd())&&(a.panel=s.first),t.mGM(s=t.lsd())&&(a._overlayDir=s.first)}},hostAttrs:["role","combobox","aria-haspopup","listbox",1,"mat-mdc-select"],hostVars:19,hostBindings:function(i,a){1&i&&t.bIt("keydown",function(l){return a._handleKeydown(l)})("focus",function(){return a._onFocus()})("blur",function(){return a._onBlur()}),2&i&&(t.BMQ("id",a.id)("tabindex",a.disabled?-1:a.tabIndex)("aria-controls",a.panelOpen?a.id+"-panel":null)("aria-expanded",a.panelOpen)("aria-label",a.ariaLabel||null)("aria-required",a.required.toString())("aria-disabled",a.disabled.toString())("aria-invalid",a.errorState)("aria-activedescendant",a._getAriaActiveDescendant()),t.AVh("mat-mdc-select-disabled",a.disabled)("mat-mdc-select-invalid",a.errorState)("mat-mdc-select-required",a.required)("mat-mdc-select-empty",a.empty)("mat-mdc-select-multiple",a.multiple))},inputs:{userAriaDescribedBy:[0,"aria-describedby","userAriaDescribedBy"],panelClass:"panelClass",disabled:[2,"disabled","disabled",t.L39],disableRipple:[2,"disableRipple","disableRipple",t.L39],tabIndex:[2,"tabIndex","tabIndex",e=>null==e?0:(0,t.Udg)(e)],hideSingleSelectionIndicator:[2,"hideSingleSelectionIndicator","hideSingleSelectionIndicator",t.L39],placeholder:"placeholder",required:[2,"required","required",t.L39],multiple:[2,"multiple","multiple",t.L39],disableOptionCentering:[2,"disableOptionCentering","disableOptionCentering",t.L39],compareWith:"compareWith",value:"value",ariaLabel:[0,"aria-label","ariaLabel"],ariaLabelledby:[0,"aria-labelledby","ariaLabelledby"],errorStateMatcher:"errorStateMatcher",typeaheadDebounceInterval:[2,"typeaheadDebounceInterval","typeaheadDebounceInterval",t.Udg],sortComparator:"sortComparator",id:"id",panelWidth:"panelWidth"},outputs:{openedChange:"openedChange",_openedStream:"opened",_closedStream:"closed",selectionChange:"selectionChange",valueChange:"valueChange"},exportAs:["matSelect"],standalone:!0,features:[t.Jv_([{provide:b.qT,useExisting:n},{provide:p.is,useExisting:n}]),t.GFd,t.OA$,t.aNF],ngContentSelectors:G,decls:11,vars:8,consts:[["fallbackOverlayOrigin","cdkOverlayOrigin","trigger",""],["panel",""],["cdk-overlay-origin","",1,"mat-mdc-select-trigger",3,"click"],[1,"mat-mdc-select-value"],[1,"mat-mdc-select-placeholder","mat-mdc-select-min-line"],[1,"mat-mdc-select-value-text"],[1,"mat-mdc-select-arrow-wrapper"],[1,"mat-mdc-select-arrow"],["viewBox","0 0 24 24","width","24px","height","24px","focusable","false","aria-hidden","true"],["d","M7 10l5 5 5-5z"],["cdk-connected-overlay","","cdkConnectedOverlayLockPosition","","cdkConnectedOverlayHasBackdrop","","cdkConnectedOverlayBackdropClass","cdk-overlay-transparent-backdrop",3,"backdropClick","attach","detach","cdkConnectedOverlayPanelClass","cdkConnectedOverlayScrollStrategy","cdkConnectedOverlayOrigin","cdkConnectedOverlayOpen","cdkConnectedOverlayPositions","cdkConnectedOverlayWidth"],[1,"mat-mdc-select-min-line"],["role","listbox","tabindex","-1",3,"keydown","ngClass"]],template:function(i,a){if(1&i){const s=t.RV6();t.NAR(j),t.j41(0,"div",2,0),t.bIt("click",function(){return t.eBV(s),t.Njj(a.open())}),t.j41(3,"div",3),t.DNE(4,X,2,1,"span",4)(5,Q,3,1,"span",5),t.k0s(),t.j41(6,"div",6)(7,"div",7),t.qSk(),t.j41(8,"svg",8),t.nrm(9,"path",9),t.k0s()()()(),t.DNE(10,Y,3,9,"ng-template",10),t.bIt("backdropClick",function(){return t.eBV(s),t.Njj(a.close())})("attach",function(){return t.eBV(s),t.Njj(a._onAttached())})("detach",function(){return t.eBV(s),t.Njj(a.close())})}if(2&i){const s=t.sdS(1);t.R7$(3),t.BMQ("id",a._valueId),t.R7$(),t.vxM(a.empty?4:5),t.R7$(6),t.Y8G("cdkConnectedOverlayPanelClass",a._overlayPanelClass)("cdkConnectedOverlayScrollStrategy",a._scrollStrategy)("cdkConnectedOverlayOrigin",a._preferredOverlayOrigin||s)("cdkConnectedOverlayOpen",a.panelOpen)("cdkConnectedOverlayPositions",a._positions)("cdkConnectedOverlayWidth",a._overlayWidth)}},dependencies:[_.$Q,_.WB,S.YU],styles:['.mat-mdc-select{display:inline-block;width:100%;outline:none;-moz-osx-font-smoothing:grayscale;-webkit-font-smoothing:antialiased;color:var(--mat-select-enabled-trigger-text-color, var(--mat-app-on-surface));font-family:var(--mat-select-trigger-text-font, var(--mat-app-body-large-font));line-height:var(--mat-select-trigger-text-line-height, var(--mat-app-body-large-line-height));font-size:var(--mat-select-trigger-text-size, var(--mat-app-body-large-size));font-weight:var(--mat-select-trigger-text-weight, var(--mat-app-body-large-weight));letter-spacing:var(--mat-select-trigger-text-tracking, var(--mat-app-body-large-tracking))}div.mat-mdc-select-panel{box-shadow:var(--mat-select-container-elevation-shadow)}.mat-mdc-select-disabled{color:var(--mat-select-disabled-trigger-text-color)}.mat-mdc-select-trigger{display:inline-flex;align-items:center;cursor:pointer;position:relative;box-sizing:border-box;width:100%}.mat-mdc-select-disabled .mat-mdc-select-trigger{-webkit-user-select:none;user-select:none;cursor:default}.mat-mdc-select-value{width:100%;overflow:hidden;text-overflow:ellipsis;white-space:nowrap}.mat-mdc-select-value-text{white-space:nowrap;overflow:hidden;text-overflow:ellipsis}.mat-mdc-select-arrow-wrapper{height:24px;flex-shrink:0;display:inline-flex;align-items:center}.mat-form-field-appearance-fill .mdc-text-field--no-label .mat-mdc-select-arrow-wrapper{transform:none}.mat-mdc-form-field .mat-mdc-select.mat-mdc-select-invalid .mat-mdc-select-arrow,.mat-form-field-invalid:not(.mat-form-field-disabled) .mat-mdc-form-field-infix::after{color:var(--mat-select-invalid-arrow-color, var(--mat-app-error))}.mat-mdc-select-arrow{width:10px;height:5px;position:relative;color:var(--mat-select-enabled-arrow-color, var(--mat-app-on-surface-variant))}.mat-mdc-form-field.mat-focused .mat-mdc-select-arrow{color:var(--mat-select-focused-arrow-color, var(--mat-app-primary))}.mat-mdc-form-field .mat-mdc-select.mat-mdc-select-disabled .mat-mdc-select-arrow{color:var(--mat-select-disabled-arrow-color)}.mat-mdc-select-arrow svg{fill:currentColor;position:absolute;top:50%;left:50%;transform:translate(-50%, -50%)}.cdk-high-contrast-active .mat-mdc-select-arrow svg{fill:CanvasText}.mat-mdc-select-disabled .cdk-high-contrast-active .mat-mdc-select-arrow svg{fill:GrayText}div.mat-mdc-select-panel{width:100%;max-height:275px;outline:0;overflow:auto;padding:8px 0;border-radius:4px;box-sizing:border-box;position:static;background-color:var(--mat-select-panel-background-color, var(--mat-app-surface-container))}.cdk-high-contrast-active div.mat-mdc-select-panel{outline:solid 1px}.cdk-overlay-pane:not(.mat-mdc-select-panel-above) div.mat-mdc-select-panel{border-top-left-radius:0;border-top-right-radius:0;transform-origin:top center}.mat-mdc-select-panel-above div.mat-mdc-select-panel{border-bottom-left-radius:0;border-bottom-right-radius:0;transform-origin:bottom center}div.mat-mdc-select-panel .mat-mdc-option{--mdc-list-list-item-container-color: var(--mat-select-panel-background-color)}.mat-mdc-select-placeholder{transition:color 400ms 133.3333333333ms cubic-bezier(0.25, 0.8, 0.25, 1);color:var(--mat-select-placeholder-text-color, var(--mat-app-on-surface-variant))}._mat-animation-noopable .mat-mdc-select-placeholder{transition:none}.mat-form-field-hide-placeholder .mat-mdc-select-placeholder{color:rgba(0,0,0,0);-webkit-text-fill-color:rgba(0,0,0,0);transition:none;display:block}.mat-mdc-form-field-type-mat-select:not(.mat-form-field-disabled) .mat-mdc-text-field-wrapper{cursor:pointer}.mat-mdc-form-field-type-mat-select.mat-form-field-appearance-fill .mat-mdc-floating-label{max-width:calc(100% - 18px)}.mat-mdc-form-field-type-mat-select.mat-form-field-appearance-fill .mdc-floating-label--float-above{max-width:calc(100%/0.75 - 24px)}.mat-mdc-form-field-type-mat-select.mat-form-field-appearance-outline .mdc-notched-outline__notch{max-width:calc(100% - 60px)}.mat-mdc-form-field-type-mat-select.mat-form-field-appearance-outline .mdc-text-field--label-floating .mdc-notched-outline__notch{max-width:calc(100% - 24px)}.mat-mdc-select-min-line:empty::before{content:" ";white-space:pre;width:1px;display:inline-block;visibility:hidden}.mat-form-field-appearance-fill .mat-mdc-select-arrow-wrapper{transform:var(--mat-select-arrow-transform)}'],encapsulation:2,data:{animation:[$.transformPanel]},changeDetection:0})}}return n})(),te=(()=>{class n{static{this.\u0275fac=function(i){return new(i||n)}}static{this.\u0275dir=t.FsC({type:n,selectors:[["mat-select-trigger"]],standalone:!0,features:[t.Jv_([{provide:x,useExisting:n}])]})}}return n})(),ie=(()=>{class n{static{this.\u0275fac=function(i){return new(i||n)}}static{this.\u0275mod=t.$C({type:n})}static{this.\u0275inj=t.G2t({providers:[Z],imports:[S.MD,_.z_,p.Sy,p.yE,E.Gj,b.RG,p.Sy,p.yE]})}}return n})()}}]);