class LuxonError extends Error{}class InvalidDateTimeError extends LuxonError{constructor(e){super(`Invalid DateTime: ${e.toMessage()}`)}}class InvalidIntervalError extends LuxonError{constructor(e){super(`Invalid Interval: ${e.toMessage()}`)}}class InvalidDurationError extends LuxonError{constructor(e){super(`Invalid Duration: ${e.toMessage()}`)}}class ConflictingSpecificationError extends LuxonError{}class InvalidUnitError extends LuxonError{constructor(e){super(`Invalid unit ${e}`)}}class InvalidArgumentError extends LuxonError{}class ZoneIsAbstractError extends LuxonError{constructor(){super("Zone is an abstract class")}}const e="numeric",t="short",n="long";const r={year:e,month:e,day:e};const s={year:e,month:t,day:e};const i={year:e,month:t,day:e,weekday:t};const a={year:e,month:n,day:e};const o={year:e,month:n,day:e,weekday:n};const u={hour:e,minute:e};const l={hour:e,minute:e,second:e};const c={hour:e,minute:e,second:e,timeZoneName:t};const d={hour:e,minute:e,second:e,timeZoneName:n};const m={hour:e,minute:e,hourCycle:"h23"};const h={hour:e,minute:e,second:e,hourCycle:"h23"};const f={hour:e,minute:e,second:e,hourCycle:"h23",timeZoneName:t};const y={hour:e,minute:e,second:e,hourCycle:"h23",timeZoneName:n};const g={year:e,month:e,day:e,hour:e,minute:e};const p={year:e,month:e,day:e,hour:e,minute:e,second:e};const T={year:e,month:t,day:e,hour:e,minute:e};const w={year:e,month:t,day:e,hour:e,minute:e,second:e};const O={year:e,month:t,day:e,weekday:t,hour:e,minute:e};const S={year:e,month:n,day:e,hour:e,minute:e,timeZoneName:t};const v={year:e,month:n,day:e,hour:e,minute:e,second:e,timeZoneName:t};const D={year:e,month:n,day:e,weekday:n,hour:e,minute:e,timeZoneName:n};const I={year:e,month:n,day:e,weekday:n,hour:e,minute:e,second:e,timeZoneName:n};class Zone{
/**
   * The type of zone
   * @abstract
   * @type {string}
   */
get type(){throw new ZoneIsAbstractError}
/**
   * The name of this zone.
   * @abstract
   * @type {string}
   */get name(){throw new ZoneIsAbstractError}get ianaName(){return this.name}
/**
   * Returns whether the offset is known to be fixed for the whole year.
   * @abstract
   * @type {boolean}
   */get isUniversal(){throw new ZoneIsAbstractError}
/**
   * Returns the offset's common name (such as EST) at the specified timestamp
   * @abstract
   * @param {number} ts - Epoch milliseconds for which to get the name
   * @param {Object} opts - Options to affect the format
   * @param {string} opts.format - What style of offset to return. Accepts 'long' or 'short'.
   * @param {string} opts.locale - What locale to return the offset name in.
   * @return {string}
   */offsetName(e,t){throw new ZoneIsAbstractError}
/**
   * Returns the offset's value as a string
   * @abstract
   * @param {number} ts - Epoch milliseconds for which to get the offset
   * @param {string} format - What style of offset to return.
   *                          Accepts 'narrow', 'short', or 'techie'. Returning '+6', '+06:00', or '+0600' respectively
   * @return {string}
   */formatOffset(e,t){throw new ZoneIsAbstractError}
/**
   * Return the offset in minutes for this zone at the specified timestamp.
   * @abstract
   * @param {number} ts - Epoch milliseconds for which to compute the offset
   * @return {number}
   */offset(e){throw new ZoneIsAbstractError}
/**
   * Return whether this Zone is equal to another zone
   * @abstract
   * @param {Zone} otherZone - the zone to compare
   * @return {boolean}
   */equals(e){throw new ZoneIsAbstractError}
/**
   * Return whether this Zone is valid.
   * @abstract
   * @type {boolean}
   */get isValid(){throw new ZoneIsAbstractError}}let b=null;class SystemZone extends Zone{static get instance(){null===b&&(b=new SystemZone);return b}get type(){return"system"}get name(){return(new Intl.DateTimeFormat).resolvedOptions().timeZone}get isUniversal(){return false}offsetName(e,{format:t,locale:n}){return parseZoneInfo(e,t,n)}formatOffset(e,t){return formatOffset(this.offset(e),t)}offset(e){return-new Date(e).getTimezoneOffset()}equals(e){return"system"===e.type}get isValid(){return true}}let k={};function makeDTF(e){k[e]||(k[e]=new Intl.DateTimeFormat("en-US",{hour12:false,timeZone:e,year:"numeric",month:"2-digit",day:"2-digit",hour:"2-digit",minute:"2-digit",second:"2-digit",era:"short"}));return k[e]}const x={year:0,month:1,day:2,era:3,hour:4,minute:5,second:6};function hackyOffset(e,t){const n=e.format(t).replace(/\u200E/g,""),r=/(\d+)\/(\d+)\/(\d+) (AD|BC),? (\d+):(\d+):(\d+)/.exec(n),[,s,i,a,o,u,l,c]=r;return[a,s,i,o,u,l,c]}function partsOffset(e,t){const n=e.formatToParts(t);const r=[];for(let e=0;e<n.length;e++){const{type:t,value:s}=n[e];const i=x[t];"era"===t?r[i]=s:isUndefined(i)||(r[i]=parseInt(s,10))}return r}let N={};class IANAZone extends Zone{
/**
   * @param {string} name - Zone name
   * @return {IANAZone}
   */
static create(e){N[e]||(N[e]=new IANAZone(e));return N[e]}static resetCache(){N={};k={}}
/**
   * Returns whether the provided string is a valid specifier. This only checks the string's format, not that the specifier identifies a known zone; see isValidZone for that.
   * @param {string} s - The string to check validity on
   * @example IANAZone.isValidSpecifier("America/New_York") //=> true
   * @example IANAZone.isValidSpecifier("Sport~~blorp") //=> false
   * @deprecated This method returns false for some valid IANA names. Use isValidZone instead.
   * @return {boolean}
   */static isValidSpecifier(e){return this.isValidZone(e)}
/**
   * Returns whether the provided string identifies a real zone
   * @param {string} zone - The string to check
   * @example IANAZone.isValidZone("America/New_York") //=> true
   * @example IANAZone.isValidZone("Fantasia/Castle") //=> false
   * @example IANAZone.isValidZone("Sport~~blorp") //=> false
   * @return {boolean}
   */static isValidZone(e){if(!e)return false;try{new Intl.DateTimeFormat("en-US",{timeZone:e}).format();return true}catch(e){return false}}constructor(e){super();this.zoneName=e;this.valid=IANAZone.isValidZone(e)}get type(){return"iana"}get name(){return this.zoneName}get isUniversal(){return false}offsetName(e,{format:t,locale:n}){return parseZoneInfo(e,t,n,this.name)}formatOffset(e,t){return formatOffset(this.offset(e),t)}offset(e){const t=new Date(e);if(isNaN(t))return NaN;const n=makeDTF(this.name);let[r,s,i,a,o,u,l]=n.formatToParts?partsOffset(n,t):hackyOffset(n,t);"BC"===a&&(r=1-Math.abs(r));const c=24===o?0:o;const d=objToLocalTS({year:r,month:s,day:i,hour:c,minute:u,second:l,millisecond:0});let m=+t;const h=m%1e3;m-=h>=0?h:1e3+h;return(d-m)/6e4}equals(e){return"iana"===e.type&&e.name===this.name}get isValid(){return this.valid}}let M={};function getCachedLF(e,t={}){const n=JSON.stringify([e,t]);let r=M[n];if(!r){r=new Intl.ListFormat(e,t);M[n]=r}return r}let F={};function getCachedDTF(e,t={}){const n=JSON.stringify([e,t]);let r=F[n];if(!r){r=new Intl.DateTimeFormat(e,t);F[n]=r}return r}let E={};function getCachedINF(e,t={}){const n=JSON.stringify([e,t]);let r=E[n];if(!r){r=new Intl.NumberFormat(e,t);E[n]=r}return r}let Z={};function getCachedRTF(e,t={}){const{base:n,...r}=t;const s=JSON.stringify([e,r]);let i=Z[s];if(!i){i=new Intl.RelativeTimeFormat(e,t);Z[s]=i}return i}let C=null;function systemLocale(){if(C)return C;C=(new Intl.DateTimeFormat).resolvedOptions().locale;return C}function parseLocaleString(e){const t=e.indexOf("-x-");-1!==t&&(e=e.substring(0,t));const n=e.indexOf("-u-");if(-1===n)return[e];{let t;let r;try{t=getCachedDTF(e).resolvedOptions();r=e}catch(s){const i=e.substring(0,n);t=getCachedDTF(i).resolvedOptions();r=i}const{numberingSystem:s,calendar:i}=t;return[r,s,i]}}function intlConfigString(e,t,n){if(n||t){e.includes("-u-")||(e+="-u");n&&(e+=`-ca-${n}`);t&&(e+=`-nu-${t}`);return e}return e}function mapMonths(e){const t=[];for(let n=1;n<=12;n++){const r=DateTime.utc(2016,n,1);t.push(e(r))}return t}function mapWeekdays(e){const t=[];for(let n=1;n<=7;n++){const r=DateTime.utc(2016,11,13+n);t.push(e(r))}return t}function listStuff(e,t,n,r,s){const i=e.listingMode(n);return"error"===i?null:"en"===i?r(t):s(t)}function supportsFastNumbers(e){return(!e.numberingSystem||"latn"===e.numberingSystem)&&("latn"===e.numberingSystem||!e.locale||e.locale.startsWith("en")||"latn"===new Intl.DateTimeFormat(e.intl).resolvedOptions().numberingSystem)}class PolyNumberFormatter{constructor(e,t,n){this.padTo=n.padTo||0;this.floor=n.floor||false;const{padTo:r,floor:s,...i}=n;if(!t||Object.keys(i).length>0){const t={useGrouping:false,...n};n.padTo>0&&(t.minimumIntegerDigits=n.padTo);this.inf=getCachedINF(e,t)}}format(e){if(this.inf){const t=this.floor?Math.floor(e):e;return this.inf.format(t)}{const t=this.floor?Math.floor(e):roundTo(e,3);return padStart(t,this.padTo)}}}class PolyDateFormatter{constructor(e,t,n){this.opts=n;this.originalZone=void 0;let r;if(this.opts.timeZone)this.dt=e;else if("fixed"===e.zone.type){const t=e.offset/60*-1;const n=t>=0?`Etc/GMT+${t}`:`Etc/GMT${t}`;if(0!==e.offset&&IANAZone.create(n).valid){r=n;this.dt=e}else{r="UTC";this.dt=0===e.offset?e:e.setZone("UTC").plus({minutes:e.offset});this.originalZone=e.zone}}else if("system"===e.zone.type)this.dt=e;else if("iana"===e.zone.type){this.dt=e;r=e.zone.name}else{r="UTC";this.dt=e.setZone("UTC").plus({minutes:e.offset});this.originalZone=e.zone}const s={...this.opts};s.timeZone=s.timeZone||r;this.dtf=getCachedDTF(t,s)}format(){return this.originalZone?this.formatToParts().map((({value:e})=>e)).join(""):this.dtf.format(this.dt.toJSDate())}formatToParts(){const e=this.dtf.formatToParts(this.dt.toJSDate());return this.originalZone?e.map((e=>{if("timeZoneName"===e.type){const t=this.originalZone.offsetName(this.dt.ts,{locale:this.dt.locale,format:this.opts.timeZoneName});return{...e,value:t}}return e})):e}resolvedOptions(){return this.dtf.resolvedOptions()}}class PolyRelFormatter{constructor(e,t,n){this.opts={style:"long",...n};!t&&hasRelative()&&(this.rtf=getCachedRTF(e,n))}format(e,t){return this.rtf?this.rtf.format(e,t):formatRelativeTime(t,e,this.opts.numeric,"long"!==this.opts.style)}formatToParts(e,t){return this.rtf?this.rtf.formatToParts(e,t):[]}}class Locale{static fromOpts(e){return Locale.create(e.locale,e.numberingSystem,e.outputCalendar,e.defaultToEN)}static create(e,t,n,r=false){const s=e||Settings.defaultLocale;const i=s||(r?"en-US":systemLocale());const a=t||Settings.defaultNumberingSystem;const o=n||Settings.defaultOutputCalendar;return new Locale(i,a,o,s)}static resetCache(){C=null;F={};E={};Z={}}static fromObject({locale:e,numberingSystem:t,outputCalendar:n}={}){return Locale.create(e,t,n)}constructor(e,t,n,r){const[s,i,a]=parseLocaleString(e);this.locale=s;this.numberingSystem=t||i||null;this.outputCalendar=n||a||null;this.intl=intlConfigString(this.locale,this.numberingSystem,this.outputCalendar);this.weekdaysCache={format:{},standalone:{}};this.monthsCache={format:{},standalone:{}};this.meridiemCache=null;this.eraCache={};this.specifiedLocale=r;this.fastNumbersCached=null}get fastNumbers(){null==this.fastNumbersCached&&(this.fastNumbersCached=supportsFastNumbers(this));return this.fastNumbersCached}listingMode(){const e=this.isEnglish();const t=(null===this.numberingSystem||"latn"===this.numberingSystem)&&(null===this.outputCalendar||"gregory"===this.outputCalendar);return e&&t?"en":"intl"}clone(e){return e&&0!==Object.getOwnPropertyNames(e).length?Locale.create(e.locale||this.specifiedLocale,e.numberingSystem||this.numberingSystem,e.outputCalendar||this.outputCalendar,e.defaultToEN||false):this}redefaultToEN(e={}){return this.clone({...e,defaultToEN:true})}redefaultToSystem(e={}){return this.clone({...e,defaultToEN:false})}months(e,t=false,n=true){return listStuff(this,e,n,months,(()=>{const n=t?{month:e,day:"numeric"}:{month:e},r=t?"format":"standalone";this.monthsCache[r][e]||(this.monthsCache[r][e]=mapMonths((e=>this.extract(e,n,"month"))));return this.monthsCache[r][e]}))}weekdays(e,t=false,n=true){return listStuff(this,e,n,weekdays,(()=>{const n=t?{weekday:e,year:"numeric",month:"long",day:"numeric"}:{weekday:e},r=t?"format":"standalone";this.weekdaysCache[r][e]||(this.weekdaysCache[r][e]=mapWeekdays((e=>this.extract(e,n,"weekday"))));return this.weekdaysCache[r][e]}))}meridiems(e=true){return listStuff(this,void 0,e,(()=>H),(()=>{if(!this.meridiemCache){const e={hour:"numeric",hourCycle:"h12"};this.meridiemCache=[DateTime.utc(2016,11,13,9),DateTime.utc(2016,11,13,19)].map((t=>this.extract(t,e,"dayperiod")))}return this.meridiemCache}))}eras(e,t=true){return listStuff(this,e,t,eras,(()=>{const t={era:e};this.eraCache[e]||(this.eraCache[e]=[DateTime.utc(-40,1,1),DateTime.utc(2017,1,1)].map((e=>this.extract(e,t,"era"))));return this.eraCache[e]}))}extract(e,t,n){const r=this.dtFormatter(e,t),s=r.formatToParts(),i=s.find((e=>e.type.toLowerCase()===n));return i?i.value:null}numberFormatter(e={}){return new PolyNumberFormatter(this.intl,e.forceSimple||this.fastNumbers,e)}dtFormatter(e,t={}){return new PolyDateFormatter(e,this.intl,t)}relFormatter(e={}){return new PolyRelFormatter(this.intl,this.isEnglish(),e)}listFormatter(e={}){return getCachedLF(this.intl,e)}isEnglish(){return"en"===this.locale||"en-us"===this.locale.toLowerCase()||new Intl.DateTimeFormat(this.intl).resolvedOptions().locale.startsWith("en-us")}equals(e){return this.locale===e.locale&&this.numberingSystem===e.numberingSystem&&this.outputCalendar===e.outputCalendar}}let L=null;class FixedOffsetZone extends Zone{static get utcInstance(){null===L&&(L=new FixedOffsetZone(0));return L}
/**
   * Get an instance with a specified offset
   * @param {number} offset - The offset in minutes
   * @return {FixedOffsetZone}
   */static instance(e){return 0===e?FixedOffsetZone.utcInstance:new FixedOffsetZone(e)}
/**
   * Get an instance of FixedOffsetZone from a UTC offset string, like "UTC+6"
   * @param {string} s - The offset string to parse
   * @example FixedOffsetZone.parseSpecifier("UTC+6")
   * @example FixedOffsetZone.parseSpecifier("UTC+06")
   * @example FixedOffsetZone.parseSpecifier("UTC-6:00")
   * @return {FixedOffsetZone}
   */static parseSpecifier(e){if(e){const t=e.match(/^utc(?:([+-]\d{1,2})(?::(\d{2}))?)?$/i);if(t)return new FixedOffsetZone(signedOffset(t[1],t[2]))}return null}constructor(e){super();this.fixed=e}get type(){return"fixed"}get name(){return 0===this.fixed?"UTC":`UTC${formatOffset(this.fixed,"narrow")}`}get ianaName(){return 0===this.fixed?"Etc/UTC":`Etc/GMT${formatOffset(-this.fixed,"narrow")}`}offsetName(){return this.name}formatOffset(e,t){return formatOffset(this.fixed,t)}get isUniversal(){return true}offset(){return this.fixed}equals(e){return"fixed"===e.type&&e.fixed===this.fixed}get isValid(){return true}}class InvalidZone extends Zone{constructor(e){super();this.zoneName=e}get type(){return"invalid"}get name(){return this.zoneName}get isUniversal(){return false}offsetName(){return null}formatOffset(){return""}offset(){return NaN}equals(){return false}get isValid(){return false}}function normalizeZone(e,t){if(isUndefined(e)||null===e)return t;if(e instanceof Zone)return e;if(isString(e)){const n=e.toLowerCase();return"default"===n?t:"local"===n||"system"===n?SystemZone.instance:"utc"===n||"gmt"===n?FixedOffsetZone.utcInstance:FixedOffsetZone.parseSpecifier(n)||IANAZone.create(e)}return isNumber(e)?FixedOffsetZone.instance(e):"object"===typeof e&&e.offset&&"number"===typeof e.offset?e:new InvalidZone(e)}let V,now=()=>Date.now(),U="system",A=null,$=null,z=null,R=60;class Settings{
/**
   * Get the callback for returning the current timestamp.
   * @type {function}
   */
static get now(){return now}
/**
   * Set the callback for returning the current timestamp.
   * The function should return a number, which will be interpreted as an Epoch millisecond count
   * @type {function}
   * @example Settings.now = () => Date.now() + 3000 // pretend it is 3 seconds in the future
   * @example Settings.now = () => 0 // always pretend it's Jan 1, 1970 at midnight in UTC time
   */static set now(e){now=e}
/**
   * Set the default time zone to create DateTimes in. Does not affect existing instances.
   * Use the value "system" to reset this value to the system's time zone.
   * @type {string}
   */static set defaultZone(e){U=e}
/**
   * Get the default time zone object currently used to create DateTimes. Does not affect existing instances.
   * The default value is the system's time zone (the one set on the machine that runs this code).
   * @type {Zone}
   */static get defaultZone(){return normalizeZone(U,SystemZone.instance)}
/**
   * Get the default locale to create DateTimes with. Does not affect existing instances.
   * @type {string}
   */static get defaultLocale(){return A}
/**
   * Set the default locale to create DateTimes with. Does not affect existing instances.
   * @type {string}
   */static set defaultLocale(e){A=e}
/**
   * Get the default numbering system to create DateTimes with. Does not affect existing instances.
   * @type {string}
   */static get defaultNumberingSystem(){return $}
/**
   * Set the default numbering system to create DateTimes with. Does not affect existing instances.
   * @type {string}
   */static set defaultNumberingSystem(e){$=e}
/**
   * Get the default output calendar to create DateTimes with. Does not affect existing instances.
   * @type {string}
   */static get defaultOutputCalendar(){return z}
/**
   * Set the default output calendar to create DateTimes with. Does not affect existing instances.
   * @type {string}
   */static set defaultOutputCalendar(e){z=e}
/**
   * Get the cutoff year after which a string encoding a year as two digits is interpreted to occur in the current century.
   * @type {number}
   */static get twoDigitCutoffYear(){return R}
/**
   * Set the cutoff year after which a string encoding a year as two digits is interpreted to occur in the current century.
   * @type {number}
   * @example Settings.twoDigitCutoffYear = 0 // cut-off year is 0, so all 'yy' are interpretted as current century
   * @example Settings.twoDigitCutoffYear = 50 // '49' -> 1949; '50' -> 2050
   * @example Settings.twoDigitCutoffYear = 1950 // interpretted as 50
   * @example Settings.twoDigitCutoffYear = 2050 // ALSO interpretted as 50
   */static set twoDigitCutoffYear(e){R=e%100}
/**
   * Get whether Luxon will throw when it encounters invalid DateTimes, Durations, or Intervals
   * @type {boolean}
   */static get throwOnInvalid(){return V}
/**
   * Set whether Luxon will throw when it encounters invalid DateTimes, Durations, or Intervals
   * @type {boolean}
   */static set throwOnInvalid(e){V=e}static resetCaches(){Locale.resetCache();IANAZone.resetCache()}}function isUndefined(e){return"undefined"===typeof e}function isNumber(e){return"number"===typeof e}function isInteger(e){return"number"===typeof e&&e%1===0}function isString(e){return"string"===typeof e}function isDate(e){return"[object Date]"===Object.prototype.toString.call(e)}function hasRelative(){try{return"undefined"!==typeof Intl&&!!Intl.RelativeTimeFormat}catch(e){return false}}function maybeArray(e){return Array.isArray(e)?e:[e]}function bestBy(e,t,n){if(0!==e.length)return e.reduce(((e,r)=>{const s=[t(r),r];return e&&n(e[0],s[0])===e[0]?e:s}),null)[1]}function pick(e,t){return t.reduce(((t,n)=>{t[n]=e[n];return t}),{})}function hasOwnProperty(e,t){return Object.prototype.hasOwnProperty.call(e,t)}function integerBetween(e,t,n){return isInteger(e)&&e>=t&&e<=n}function floorMod(e,t){return e-t*Math.floor(e/t)}function padStart(e,t=2){const n=e<0;let r;r=n?"-"+(""+-e).padStart(t,"0"):(""+e).padStart(t,"0");return r}function parseInteger(e){return isUndefined(e)||null===e||""===e?void 0:parseInt(e,10)}function parseFloating(e){return isUndefined(e)||null===e||""===e?void 0:parseFloat(e)}function parseMillis(e){if(!isUndefined(e)&&null!==e&&""!==e){const t=1e3*parseFloat("0."+e);return Math.floor(t)}}function roundTo(e,t,n=false){const r=10**t,s=n?Math.trunc:Math.round;return s(e*r)/r}function isLeapYear(e){return e%4===0&&(e%100!==0||e%400===0)}function daysInYear(e){return isLeapYear(e)?366:365}function daysInMonth(e,t){const n=floorMod(t-1,12)+1,r=e+(t-n)/12;return 2===n?isLeapYear(r)?29:28:[31,null,31,30,31,30,31,31,30,31,30,31][n-1]}function objToLocalTS(e){let t=Date.UTC(e.year,e.month-1,e.day,e.hour,e.minute,e.second,e.millisecond);if(e.year<100&&e.year>=0){t=new Date(t);t.setUTCFullYear(e.year,e.month-1,e.day)}return+t}function weeksInWeekYear(e){const t=(e+Math.floor(e/4)-Math.floor(e/100)+Math.floor(e/400))%7,n=e-1,r=(n+Math.floor(n/4)-Math.floor(n/100)+Math.floor(n/400))%7;return 4===t||3===r?53:52}function untruncateYear(e){return e>99?e:e>Settings.twoDigitCutoffYear?1900+e:2e3+e}function parseZoneInfo(e,t,n,r=null){const s=new Date(e),i={hourCycle:"h23",year:"numeric",month:"2-digit",day:"2-digit",hour:"2-digit",minute:"2-digit"};r&&(i.timeZone=r);const a={timeZoneName:t,...i};const o=new Intl.DateTimeFormat(n,a).formatToParts(s).find((e=>"timezonename"===e.type.toLowerCase()));return o?o.value:null}function signedOffset(e,t){let n=parseInt(e,10);Number.isNaN(n)&&(n=0);const r=parseInt(t,10)||0,s=n<0||Object.is(n,-0)?-r:r;return 60*n+s}function asNumber(e){const t=Number(e);if("boolean"===typeof e||""===e||Number.isNaN(t))throw new InvalidArgumentError(`Invalid unit value ${e}`);return t}function normalizeObject(e,t){const n={};for(const r in e)if(hasOwnProperty(e,r)){const s=e[r];if(void 0===s||null===s)continue;n[t(r)]=asNumber(s)}return n}function formatOffset(e,t){const n=Math.trunc(Math.abs(e/60)),r=Math.trunc(Math.abs(e%60)),s=e>=0?"+":"-";switch(t){case"short":return`${s}${padStart(n,2)}:${padStart(r,2)}`;case"narrow":return`${s}${n}${r>0?`:${r}`:""}`;case"techie":return`${s}${padStart(n,2)}${padStart(r,2)}`;default:throw new RangeError(`Value format ${t} is out of range for property format`)}}function timeObject(e){return pick(e,["hour","minute","second","millisecond"])}const j=["January","February","March","April","May","June","July","August","September","October","November","December"];const q=["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];const W=["J","F","M","A","M","J","J","A","S","O","N","D"];function months(e){switch(e){case"narrow":return[...W];case"short":return[...q];case"long":return[...j];case"numeric":return["1","2","3","4","5","6","7","8","9","10","11","12"];case"2-digit":return["01","02","03","04","05","06","07","08","09","10","11","12"];default:return null}}const Y=["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"];const _=["Mon","Tue","Wed","Thu","Fri","Sat","Sun"];const P=["M","T","W","T","F","S","S"];function weekdays(e){switch(e){case"narrow":return[...P];case"short":return[..._];case"long":return[...Y];case"numeric":return["1","2","3","4","5","6","7"];default:return null}}const H=["AM","PM"];const G=["Before Christ","Anno Domini"];const J=["BC","AD"];const B=["B","A"];function eras(e){switch(e){case"narrow":return[...B];case"short":return[...J];case"long":return[...G];default:return null}}function meridiemForDateTime(e){return H[e.hour<12?0:1]}function weekdayForDateTime(e,t){return weekdays(t)[e.weekday-1]}function monthForDateTime(e,t){return months(t)[e.month-1]}function eraForDateTime(e,t){return eras(t)[e.year<0?0:1]}function formatRelativeTime(e,t,n="always",r=false){const s={years:["year","yr."],quarters:["quarter","qtr."],months:["month","mo."],weeks:["week","wk."],days:["day","day","days"],hours:["hour","hr."],minutes:["minute","min."],seconds:["second","sec."]};const i=-1===["hours","minutes","seconds"].indexOf(e);if("auto"===n&&i){const n="days"===e;switch(t){case 1:return n?"tomorrow":`next ${s[e][0]}`;case-1:return n?"yesterday":`last ${s[e][0]}`;case 0:return n?"today":`this ${s[e][0]}`;default:}}const a=Object.is(t,-0)||t<0,o=Math.abs(t),u=1===o,l=s[e],c=r?u?l[1]:l[2]||l[1]:u?s[e][0]:e;return a?`${o} ${c} ago`:`in ${o} ${c}`}function stringifyTokens(e,t){let n="";for(const r of e)r.literal?n+=r.val:n+=t(r.val);return n}const Q={D:r,DD:s,DDD:a,DDDD:o,t:u,tt:l,ttt:c,tttt:d,T:m,TT:h,TTT:f,TTTT:y,f:g,ff:T,fff:S,ffff:D,F:p,FF:w,FFF:v,FFFF:I};class Formatter{static create(e,t={}){return new Formatter(e,t)}static parseFormat(e){let t=null,n="",r=false;const s=[];for(let i=0;i<e.length;i++){const a=e.charAt(i);if("'"===a){n.length>0&&s.push({literal:r||/^\s+$/.test(n),val:n});t=null;n="";r=!r}else if(r)n+=a;else if(a===t)n+=a;else{n.length>0&&s.push({literal:/^\s+$/.test(n),val:n});n=a;t=a}}n.length>0&&s.push({literal:r||/^\s+$/.test(n),val:n});return s}static macroTokenToFormatOpts(e){return Q[e]}constructor(e,t){this.opts=t;this.loc=e;this.systemLoc=null}formatWithSystemDefault(e,t){null===this.systemLoc&&(this.systemLoc=this.loc.redefaultToSystem());const n=this.systemLoc.dtFormatter(e,{...this.opts,...t});return n.format()}formatDateTime(e,t={}){const n=this.loc.dtFormatter(e,{...this.opts,...t});return n.format()}formatDateTimeParts(e,t={}){const n=this.loc.dtFormatter(e,{...this.opts,...t});return n.formatToParts()}formatInterval(e,t={}){const n=this.loc.dtFormatter(e.start,{...this.opts,...t});return n.dtf.formatRange(e.start.toJSDate(),e.end.toJSDate())}resolvedOptions(e,t={}){const n=this.loc.dtFormatter(e,{...this.opts,...t});return n.resolvedOptions()}num(e,t=0){if(this.opts.forceSimple)return padStart(e,t);const n={...this.opts};t>0&&(n.padTo=t);return this.loc.numberFormatter(n).format(e)}formatDateTimeFromString(e,t){const n="en"===this.loc.listingMode(),r=this.loc.outputCalendar&&"gregory"!==this.loc.outputCalendar,string=(t,n)=>this.loc.extract(e,t,n),formatOffset=t=>e.isOffsetFixed&&0===e.offset&&t.allowZ?"Z":e.isValid?e.zone.formatOffset(e.ts,t.format):"",meridiem=()=>n?meridiemForDateTime(e):string({hour:"numeric",hourCycle:"h12"},"dayperiod"),month=(t,r)=>n?monthForDateTime(e,t):string(r?{month:t}:{month:t,day:"numeric"},"month"),weekday=(t,r)=>n?weekdayForDateTime(e,t):string(r?{weekday:t}:{weekday:t,month:"long",day:"numeric"},"weekday"),maybeMacro=t=>{const n=Formatter.macroTokenToFormatOpts(t);return n?this.formatWithSystemDefault(e,n):t},era=t=>n?eraForDateTime(e,t):string({era:t},"era"),tokenToString=t=>{switch(t){case"S":return this.num(e.millisecond);case"u":case"SSS":return this.num(e.millisecond,3);case"s":return this.num(e.second);case"ss":return this.num(e.second,2);case"uu":return this.num(Math.floor(e.millisecond/10),2);case"uuu":return this.num(Math.floor(e.millisecond/100));case"m":return this.num(e.minute);case"mm":return this.num(e.minute,2);case"h":return this.num(e.hour%12===0?12:e.hour%12);case"hh":return this.num(e.hour%12===0?12:e.hour%12,2);case"H":return this.num(e.hour);case"HH":return this.num(e.hour,2);case"Z":return formatOffset({format:"narrow",allowZ:this.opts.allowZ});case"ZZ":return formatOffset({format:"short",allowZ:this.opts.allowZ});case"ZZZ":return formatOffset({format:"techie",allowZ:this.opts.allowZ});case"ZZZZ":return e.zone.offsetName(e.ts,{format:"short",locale:this.loc.locale});case"ZZZZZ":return e.zone.offsetName(e.ts,{format:"long",locale:this.loc.locale});case"z":return e.zoneName;case"a":return meridiem();case"d":return r?string({day:"numeric"},"day"):this.num(e.day);case"dd":return r?string({day:"2-digit"},"day"):this.num(e.day,2);case"c":return this.num(e.weekday);case"ccc":return weekday("short",true);case"cccc":return weekday("long",true);case"ccccc":return weekday("narrow",true);case"E":return this.num(e.weekday);case"EEE":return weekday("short",false);case"EEEE":return weekday("long",false);case"EEEEE":return weekday("narrow",false);case"L":return r?string({month:"numeric",day:"numeric"},"month"):this.num(e.month);case"LL":return r?string({month:"2-digit",day:"numeric"},"month"):this.num(e.month,2);case"LLL":return month("short",true);case"LLLL":return month("long",true);case"LLLLL":return month("narrow",true);case"M":return r?string({month:"numeric"},"month"):this.num(e.month);case"MM":return r?string({month:"2-digit"},"month"):this.num(e.month,2);case"MMM":return month("short",false);case"MMMM":return month("long",false);case"MMMMM":return month("narrow",false);case"y":return r?string({year:"numeric"},"year"):this.num(e.year);case"yy":return r?string({year:"2-digit"},"year"):this.num(e.year.toString().slice(-2),2);case"yyyy":return r?string({year:"numeric"},"year"):this.num(e.year,4);case"yyyyyy":return r?string({year:"numeric"},"year"):this.num(e.year,6);case"G":return era("short");case"GG":return era("long");case"GGGGG":return era("narrow");case"kk":return this.num(e.weekYear.toString().slice(-2),2);case"kkkk":return this.num(e.weekYear,4);case"W":return this.num(e.weekNumber);case"WW":return this.num(e.weekNumber,2);case"o":return this.num(e.ordinal);case"ooo":return this.num(e.ordinal,3);case"q":return this.num(e.quarter);case"qq":return this.num(e.quarter,2);case"X":return this.num(Math.floor(e.ts/1e3));case"x":return this.num(e.ts);default:return maybeMacro(t)}};return stringifyTokens(Formatter.parseFormat(t),tokenToString)}formatDurationFromString(e,t){const tokenToField=e=>{switch(e[0]){case"S":return"millisecond";case"s":return"second";case"m":return"minute";case"h":return"hour";case"d":return"day";case"w":return"week";case"M":return"month";case"y":return"year";default:return null}},tokenToString=e=>t=>{const n=tokenToField(t);return n?this.num(e.get(n),t.length):t},n=Formatter.parseFormat(t),r=n.reduce(((e,{literal:t,val:n})=>t?e:e.concat(n)),[]),s=e.shiftTo(...r.map(tokenToField).filter((e=>e)));return stringifyTokens(n,tokenToString(s))}}class Invalid{constructor(e,t){this.reason=e;this.explanation=t}toMessage(){return this.explanation?`${this.reason}: ${this.explanation}`:this.reason}}const K=/[A-Za-z_+-]{1,256}(?::?\/[A-Za-z0-9_+-]{1,256}(?:\/[A-Za-z0-9_+-]{1,256})?)?/;function combineRegexes(...e){const t=e.reduce(((e,t)=>e+t.source),"");return RegExp(`^${t}$`)}function combineExtractors(...e){return t=>e.reduce((([e,n,r],s)=>{const[i,a,o]=s(t,r);return[{...e,...i},a||n,o]}),[{},null,1]).slice(0,2)}function parse(e,...t){if(null==e)return[null,null];for(const[n,r]of t){const t=n.exec(e);if(t)return r(t)}return[null,null]}function simpleParse(...e){return(t,n)=>{const r={};let s;for(s=0;s<e.length;s++)r[e[s]]=parseInteger(t[n+s]);return[r,null,n+s]}}const X=/(?:(Z)|([+-]\d\d)(?::?(\d\d))?)/;const ee=`(?:${X.source}?(?:\\[(${K.source})\\])?)?`;const te=/(\d\d)(?::?(\d\d)(?::?(\d\d)(?:[.,](\d{1,30}))?)?)?/;const ne=RegExp(`${te.source}${ee}`);const re=RegExp(`(?:T${ne.source})?`);const se=/([+-]\d{6}|\d{4})(?:-?(\d\d)(?:-?(\d\d))?)?/;const ie=/(\d{4})-?W(\d\d)(?:-?(\d))?/;const ae=/(\d{4})-?(\d{3})/;const oe=simpleParse("weekYear","weekNumber","weekDay");const ue=simpleParse("year","ordinal");const le=/(\d{4})-(\d\d)-(\d\d)/;const ce=RegExp(`${te.source} ?(?:${X.source}|(${K.source}))?`);const de=RegExp(`(?: ${ce.source})?`);function int(e,t,n){const r=e[t];return isUndefined(r)?n:parseInteger(r)}function extractISOYmd(e,t){const n={year:int(e,t),month:int(e,t+1,1),day:int(e,t+2,1)};return[n,null,t+3]}function extractISOTime(e,t){const n={hours:int(e,t,0),minutes:int(e,t+1,0),seconds:int(e,t+2,0),milliseconds:parseMillis(e[t+3])};return[n,null,t+4]}function extractISOOffset(e,t){const n=!e[t]&&!e[t+1],r=signedOffset(e[t+1],e[t+2]),s=n?null:FixedOffsetZone.instance(r);return[{},s,t+3]}function extractIANAZone(e,t){const n=e[t]?IANAZone.create(e[t]):null;return[{},n,t+1]}const me=RegExp(`^T?${te.source}$`);const he=/^-?P(?:(?:(-?\d{1,20}(?:\.\d{1,20})?)Y)?(?:(-?\d{1,20}(?:\.\d{1,20})?)M)?(?:(-?\d{1,20}(?:\.\d{1,20})?)W)?(?:(-?\d{1,20}(?:\.\d{1,20})?)D)?(?:T(?:(-?\d{1,20}(?:\.\d{1,20})?)H)?(?:(-?\d{1,20}(?:\.\d{1,20})?)M)?(?:(-?\d{1,20})(?:[.,](-?\d{1,20}))?S)?)?)$/;function extractISODuration(e){const[t,n,r,s,i,a,o,u,l]=e;const c="-"===t[0];const d=u&&"-"===u[0];const maybeNegate=(e,t=false)=>void 0!==e&&(t||e&&c)?-e:e;return[{years:maybeNegate(parseFloating(n)),months:maybeNegate(parseFloating(r)),weeks:maybeNegate(parseFloating(s)),days:maybeNegate(parseFloating(i)),hours:maybeNegate(parseFloating(a)),minutes:maybeNegate(parseFloating(o)),seconds:maybeNegate(parseFloating(u),"-0"===u),milliseconds:maybeNegate(parseMillis(l),d)}]}const fe={GMT:0,EDT:-240,EST:-300,CDT:-300,CST:-360,MDT:-360,MST:-420,PDT:-420,PST:-480};function fromStrings(e,t,n,r,s,i,a){const o={year:2===t.length?untruncateYear(parseInteger(t)):parseInteger(t),month:q.indexOf(n)+1,day:parseInteger(r),hour:parseInteger(s),minute:parseInteger(i)};a&&(o.second=parseInteger(a));e&&(o.weekday=e.length>3?Y.indexOf(e)+1:_.indexOf(e)+1);return o}const ye=/^(?:(Mon|Tue|Wed|Thu|Fri|Sat|Sun),\s)?(\d{1,2})\s(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s(\d{2,4})\s(\d\d):(\d\d)(?::(\d\d))?\s(?:(UT|GMT|[ECMP][SD]T)|([Zz])|(?:([+-]\d\d)(\d\d)))$/;function extractRFC2822(e){const[,t,n,r,s,i,a,o,u,l,c,d]=e,m=fromStrings(t,s,r,n,i,a,o);let h;h=u?fe[u]:l?0:signedOffset(c,d);return[m,new FixedOffsetZone(h)]}function preprocessRFC2822(e){return e.replace(/\([^()]*\)|[\n\t]/g," ").replace(/(\s\s+)/g," ").trim()}const ge=/^(Mon|Tue|Wed|Thu|Fri|Sat|Sun), (\d\d) (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) (\d{4}) (\d\d):(\d\d):(\d\d) GMT$/,pe=/^(Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday), (\d\d)-(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)-(\d\d) (\d\d):(\d\d):(\d\d) GMT$/,Te=/^(Mon|Tue|Wed|Thu|Fri|Sat|Sun) (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) ( \d|\d\d) (\d\d):(\d\d):(\d\d) (\d{4})$/;function extractRFC1123Or850(e){const[,t,n,r,s,i,a,o]=e,u=fromStrings(t,s,r,n,i,a,o);return[u,FixedOffsetZone.utcInstance]}function extractASCII(e){const[,t,n,r,s,i,a,o]=e,u=fromStrings(t,o,n,r,s,i,a);return[u,FixedOffsetZone.utcInstance]}const we=combineRegexes(se,re);const Oe=combineRegexes(ie,re);const Se=combineRegexes(ae,re);const ve=combineRegexes(ne);const De=combineExtractors(extractISOYmd,extractISOTime,extractISOOffset,extractIANAZone);const Ie=combineExtractors(oe,extractISOTime,extractISOOffset,extractIANAZone);const be=combineExtractors(ue,extractISOTime,extractISOOffset,extractIANAZone);const ke=combineExtractors(extractISOTime,extractISOOffset,extractIANAZone);function parseISODate(e){return parse(e,[we,De],[Oe,Ie],[Se,be],[ve,ke])}function parseRFC2822Date(e){return parse(preprocessRFC2822(e),[ye,extractRFC2822])}function parseHTTPDate(e){return parse(e,[ge,extractRFC1123Or850],[pe,extractRFC1123Or850],[Te,extractASCII])}function parseISODuration(e){return parse(e,[he,extractISODuration])}const xe=combineExtractors(extractISOTime);function parseISOTimeOnly(e){return parse(e,[me,xe])}const Ne=combineRegexes(le,de);const Me=combineRegexes(ce);const Fe=combineExtractors(extractISOTime,extractISOOffset,extractIANAZone);function parseSQL(e){return parse(e,[Ne,De],[Me,Fe])}const Ee="Invalid Duration";const Ze={weeks:{days:7,hours:168,minutes:10080,seconds:604800,milliseconds:6048e5},days:{hours:24,minutes:1440,seconds:86400,milliseconds:864e5},hours:{minutes:60,seconds:3600,milliseconds:36e5},minutes:{seconds:60,milliseconds:6e4},seconds:{milliseconds:1e3}},Ce={years:{quarters:4,months:12,weeks:52,days:365,hours:8760,minutes:525600,seconds:31536e3,milliseconds:31536e6},quarters:{months:3,weeks:13,days:91,hours:2184,minutes:131040,seconds:7862400,milliseconds:78624e5},months:{weeks:4,days:30,hours:720,minutes:43200,seconds:2592e3,milliseconds:2592e6},...Ze},Le=365.2425,Ve=30.436875,Ue={years:{quarters:4,months:12,weeks:Le/7,days:Le,hours:24*Le,minutes:24*Le*60,seconds:24*Le*60*60,milliseconds:24*Le*60*60*1e3},quarters:{months:3,weeks:Le/28,days:Le/4,hours:24*Le/4,minutes:24*Le*60/4,seconds:24*Le*60*60/4,milliseconds:24*Le*60*60*1e3/4},months:{weeks:Ve/7,days:Ve,hours:24*Ve,minutes:24*Ve*60,seconds:24*Ve*60*60,milliseconds:24*Ve*60*60*1e3},...Ze};const Ae=["years","quarters","months","weeks","days","hours","minutes","seconds","milliseconds"];const $e=Ae.slice(0).reverse();function clone$1(e,t,n=false){const r={values:n?t.values:{...e.values,...t.values||{}},loc:e.loc.clone(t.loc),conversionAccuracy:t.conversionAccuracy||e.conversionAccuracy,matrix:t.matrix||e.matrix};return new Duration(r)}function antiTrunc(e){return e<0?Math.floor(e):Math.ceil(e)}function convert(e,t,n,r,s){const i=e[s][n],a=t[n]/i,o=Math.sign(a)===Math.sign(r[s]),u=!o&&0!==r[s]&&Math.abs(a)<=1?antiTrunc(a):Math.trunc(a);r[s]+=u;t[n]-=u*i}function normalizeValues(e,t){$e.reduce(((n,r)=>{if(isUndefined(t[r]))return n;n&&convert(e,t,n,t,r);return r}),null)}function removeZeroes(e){const t={};for(const[n,r]of Object.entries(e))0!==r&&(t[n]=r);return t}class Duration{constructor(e){const t="longterm"===e.conversionAccuracy||false;let n=t?Ue:Ce;e.matrix&&(n=e.matrix);this.values=e.values;this.loc=e.loc||Locale.create();this.conversionAccuracy=t?"longterm":"casual";this.invalid=e.invalid||null;this.matrix=n;this.isLuxonDuration=true}
/**
   * Create Duration from a number of milliseconds.
   * @param {number} count of milliseconds
   * @param {Object} opts - options for parsing
   * @param {string} [opts.locale='en-US'] - the locale to use
   * @param {string} opts.numberingSystem - the numbering system to use
   * @param {string} [opts.conversionAccuracy='casual'] - the conversion system to use
   * @return {Duration}
   */static fromMillis(e,t){return Duration.fromObject({milliseconds:e},t)}
/**
   * Create a Duration from a JavaScript object with keys like 'years' and 'hours'.
   * If this object is empty then a zero milliseconds duration is returned.
   * @param {Object} obj - the object to create the DateTime from
   * @param {number} obj.years
   * @param {number} obj.quarters
   * @param {number} obj.months
   * @param {number} obj.weeks
   * @param {number} obj.days
   * @param {number} obj.hours
   * @param {number} obj.minutes
   * @param {number} obj.seconds
   * @param {number} obj.milliseconds
   * @param {Object} [opts=[]] - options for creating this Duration
   * @param {string} [opts.locale='en-US'] - the locale to use
   * @param {string} opts.numberingSystem - the numbering system to use
   * @param {string} [opts.conversionAccuracy='casual'] - the preset conversion system to use
   * @param {string} [opts.matrix=Object] - the custom conversion system to use
   * @return {Duration}
   */static fromObject(e,t={}){if(null==e||"object"!==typeof e)throw new InvalidArgumentError("Duration.fromObject: argument expected to be an object, got "+(null===e?"null":typeof e));return new Duration({values:normalizeObject(e,Duration.normalizeUnit),loc:Locale.fromObject(t),conversionAccuracy:t.conversionAccuracy,matrix:t.matrix})}
/**
   * Create a Duration from DurationLike.
   *
   * @param {Object | number | Duration} durationLike
   * One of:
   * - object with keys like 'years' and 'hours'.
   * - number representing milliseconds
   * - Duration instance
   * @return {Duration}
   */static fromDurationLike(e){if(isNumber(e))return Duration.fromMillis(e);if(Duration.isDuration(e))return e;if("object"===typeof e)return Duration.fromObject(e);throw new InvalidArgumentError(`Unknown duration argument ${e} of type ${typeof e}`)}
/**
   * Create a Duration from an ISO 8601 duration string.
   * @param {string} text - text to parse
   * @param {Object} opts - options for parsing
   * @param {string} [opts.locale='en-US'] - the locale to use
   * @param {string} opts.numberingSystem - the numbering system to use
   * @param {string} [opts.conversionAccuracy='casual'] - the preset conversion system to use
   * @param {string} [opts.matrix=Object] - the preset conversion system to use
   * @see https://en.wikipedia.org/wiki/ISO_8601#Durations
   * @example Duration.fromISO('P3Y6M1W4DT12H30M5S').toObject() //=> { years: 3, months: 6, weeks: 1, days: 4, hours: 12, minutes: 30, seconds: 5 }
   * @example Duration.fromISO('PT23H').toObject() //=> { hours: 23 }
   * @example Duration.fromISO('P5Y3M').toObject() //=> { years: 5, months: 3 }
   * @return {Duration}
   */static fromISO(e,t){const[n]=parseISODuration(e);return n?Duration.fromObject(n,t):Duration.invalid("unparsable",`the input "${e}" can't be parsed as ISO 8601`)}
/**
   * Create a Duration from an ISO 8601 time string.
   * @param {string} text - text to parse
   * @param {Object} opts - options for parsing
   * @param {string} [opts.locale='en-US'] - the locale to use
   * @param {string} opts.numberingSystem - the numbering system to use
   * @param {string} [opts.conversionAccuracy='casual'] - the preset conversion system to use
   * @param {string} [opts.matrix=Object] - the conversion system to use
   * @see https://en.wikipedia.org/wiki/ISO_8601#Times
   * @example Duration.fromISOTime('11:22:33.444').toObject() //=> { hours: 11, minutes: 22, seconds: 33, milliseconds: 444 }
   * @example Duration.fromISOTime('11:00').toObject() //=> { hours: 11, minutes: 0, seconds: 0 }
   * @example Duration.fromISOTime('T11:00').toObject() //=> { hours: 11, minutes: 0, seconds: 0 }
   * @example Duration.fromISOTime('1100').toObject() //=> { hours: 11, minutes: 0, seconds: 0 }
   * @example Duration.fromISOTime('T1100').toObject() //=> { hours: 11, minutes: 0, seconds: 0 }
   * @return {Duration}
   */static fromISOTime(e,t){const[n]=parseISOTimeOnly(e);return n?Duration.fromObject(n,t):Duration.invalid("unparsable",`the input "${e}" can't be parsed as ISO 8601`)}
/**
   * Create an invalid Duration.
   * @param {string} reason - simple string of why this datetime is invalid. Should not contain parameters or anything else data-dependent
   * @param {string} [explanation=null] - longer explanation, may include parameters and other useful debugging information
   * @return {Duration}
   */static invalid(e,t=null){if(!e)throw new InvalidArgumentError("need to specify a reason the Duration is invalid");const n=e instanceof Invalid?e:new Invalid(e,t);if(Settings.throwOnInvalid)throw new InvalidDurationError(n);return new Duration({invalid:n})}static normalizeUnit(e){const t={year:"years",years:"years",quarter:"quarters",quarters:"quarters",month:"months",months:"months",week:"weeks",weeks:"weeks",day:"days",days:"days",hour:"hours",hours:"hours",minute:"minutes",minutes:"minutes",second:"seconds",seconds:"seconds",millisecond:"milliseconds",milliseconds:"milliseconds"}[e?e.toLowerCase():e];if(!t)throw new InvalidUnitError(e);return t}
/**
   * Check if an object is a Duration. Works across context boundaries
   * @param {object} o
   * @return {boolean}
   */static isDuration(e){return e&&e.isLuxonDuration||false}
/**
   * Get  the locale of a Duration, such 'en-GB'
   * @type {string}
   */get locale(){return this.isValid?this.loc.locale:null}
/**
   * Get the numbering system of a Duration, such 'beng'. The numbering system is used when formatting the Duration
   *
   * @type {string}
   */get numberingSystem(){return this.isValid?this.loc.numberingSystem:null}
/**
   * Returns a string representation of this Duration formatted according to the specified format string. You may use these tokens:
   * * `S` for milliseconds
   * * `s` for seconds
   * * `m` for minutes
   * * `h` for hours
   * * `d` for days
   * * `w` for weeks
   * * `M` for months
   * * `y` for years
   * Notes:
   * * Add padding by repeating the token, e.g. "yy" pads the years to two digits, "hhhh" pads the hours out to four digits
   * * Tokens can be escaped by wrapping with single quotes.
   * * The duration will be converted to the set of units in the format string using {@link Duration#shiftTo} and the Durations's conversion accuracy setting.
   * @param {string} fmt - the format string
   * @param {Object} opts - options
   * @param {boolean} [opts.floor=true] - floor numerical values
   * @example Duration.fromObject({ years: 1, days: 6, seconds: 2 }).toFormat("y d s") //=> "1 6 2"
   * @example Duration.fromObject({ years: 1, days: 6, seconds: 2 }).toFormat("yy dd sss") //=> "01 06 002"
   * @example Duration.fromObject({ years: 1, days: 6, seconds: 2 }).toFormat("M S") //=> "12 518402000"
   * @return {string}
   */toFormat(e,t={}){const n={...t,floor:false!==t.round&&false!==t.floor};return this.isValid?Formatter.create(this.loc,n).formatDurationFromString(this,e):Ee}
/**
   * Returns a string representation of a Duration with all units included.
   * To modify its behavior use the `listStyle` and any Intl.NumberFormat option, though `unitDisplay` is especially relevant.
   * @see https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Intl/NumberFormat
   * @param opts - On option object to override the formatting. Accepts the same keys as the options parameter of the native `Int.NumberFormat` constructor, as well as `listStyle`.
   * @example
   * ```js
   * var dur = Duration.fromObject({ days: 1, hours: 5, minutes: 6 })
   * dur.toHuman() //=> '1 day, 5 hours, 6 minutes'
   * dur.toHuman({ listStyle: "long" }) //=> '1 day, 5 hours, and 6 minutes'
   * dur.toHuman({ unitDisplay: "short" }) //=> '1 day, 5 hr, 6 min'
   * ```
   */toHuman(e={}){const t=Ae.map((t=>{const n=this.values[t];return isUndefined(n)?null:this.loc.numberFormatter({style:"unit",unitDisplay:"long",...e,unit:t.slice(0,-1)}).format(n)})).filter((e=>e));return this.loc.listFormatter({type:"conjunction",style:e.listStyle||"narrow",...e}).format(t)}toObject(){return this.isValid?{...this.values}:{}}toISO(){if(!this.isValid)return null;let e="P";0!==this.years&&(e+=this.years+"Y");0===this.months&&0===this.quarters||(e+=this.months+3*this.quarters+"M");0!==this.weeks&&(e+=this.weeks+"W");0!==this.days&&(e+=this.days+"D");0===this.hours&&0===this.minutes&&0===this.seconds&&0===this.milliseconds||(e+="T");0!==this.hours&&(e+=this.hours+"H");0!==this.minutes&&(e+=this.minutes+"M");0===this.seconds&&0===this.milliseconds||(e+=roundTo(this.seconds+this.milliseconds/1e3,3)+"S");"P"===e&&(e+="T0S");return e}
/**
   * Returns an ISO 8601-compliant string representation of this Duration, formatted as a time of day.
   * Note that this will return null if the duration is invalid, negative, or equal to or greater than 24 hours.
   * @see https://en.wikipedia.org/wiki/ISO_8601#Times
   * @param {Object} opts - options
   * @param {boolean} [opts.suppressMilliseconds=false] - exclude milliseconds from the format if they're 0
   * @param {boolean} [opts.suppressSeconds=false] - exclude seconds from the format if they're 0
   * @param {boolean} [opts.includePrefix=false] - include the `T` prefix
   * @param {string} [opts.format='extended'] - choose between the basic and extended format
   * @example Duration.fromObject({ hours: 11 }).toISOTime() //=> '11:00:00.000'
   * @example Duration.fromObject({ hours: 11 }).toISOTime({ suppressMilliseconds: true }) //=> '11:00:00'
   * @example Duration.fromObject({ hours: 11 }).toISOTime({ suppressSeconds: true }) //=> '11:00'
   * @example Duration.fromObject({ hours: 11 }).toISOTime({ includePrefix: true }) //=> 'T11:00:00.000'
   * @example Duration.fromObject({ hours: 11 }).toISOTime({ format: 'basic' }) //=> '110000.000'
   * @return {string}
   */toISOTime(e={}){if(!this.isValid)return null;const t=this.toMillis();if(t<0||t>=864e5)return null;e={suppressMilliseconds:false,suppressSeconds:false,includePrefix:false,format:"extended",...e};const n=this.shiftTo("hours","minutes","seconds","milliseconds");let r="basic"===e.format?"hhmm":"hh:mm";if(!e.suppressSeconds||0!==n.seconds||0!==n.milliseconds){r+="basic"===e.format?"ss":":ss";e.suppressMilliseconds&&0===n.milliseconds||(r+=".SSS")}let s=n.toFormat(r);e.includePrefix&&(s="T"+s);return s}toJSON(){return this.toISO()}toString(){return this.toISO()}toMillis(){return this.as("milliseconds")}valueOf(){return this.toMillis()}
/**
   * Make this Duration longer by the specified amount. Return a newly-constructed Duration.
   * @param {Duration|Object|number} duration - The amount to add. Either a Luxon Duration, a number of milliseconds, the object argument to Duration.fromObject()
   * @return {Duration}
   */plus(e){if(!this.isValid)return this;const t=Duration.fromDurationLike(e),n={};for(const e of Ae)(hasOwnProperty(t.values,e)||hasOwnProperty(this.values,e))&&(n[e]=t.get(e)+this.get(e));return clone$1(this,{values:n},true)}
/**
   * Make this Duration shorter by the specified amount. Return a newly-constructed Duration.
   * @param {Duration|Object|number} duration - The amount to subtract. Either a Luxon Duration, a number of milliseconds, the object argument to Duration.fromObject()
   * @return {Duration}
   */minus(e){if(!this.isValid)return this;const t=Duration.fromDurationLike(e);return this.plus(t.negate())}
/**
   * Scale this Duration by the specified amount. Return a newly-constructed Duration.
   * @param {function} fn - The function to apply to each unit. Arity is 1 or 2: the value of the unit and, optionally, the unit name. Must return a number.
   * @example Duration.fromObject({ hours: 1, minutes: 30 }).mapUnits(x => x * 2) //=> { hours: 2, minutes: 60 }
   * @example Duration.fromObject({ hours: 1, minutes: 30 }).mapUnits((x, u) => u === "hours" ? x * 2 : x) //=> { hours: 2, minutes: 30 }
   * @return {Duration}
   */mapUnits(e){if(!this.isValid)return this;const t={};for(const n of Object.keys(this.values))t[n]=asNumber(e(this.values[n],n));return clone$1(this,{values:t},true)}
/**
   * Get the value of unit.
   * @param {string} unit - a unit such as 'minute' or 'day'
   * @example Duration.fromObject({years: 2, days: 3}).get('years') //=> 2
   * @example Duration.fromObject({years: 2, days: 3}).get('months') //=> 0
   * @example Duration.fromObject({years: 2, days: 3}).get('days') //=> 3
   * @return {number}
   */get(e){return this[Duration.normalizeUnit(e)]}
/**
   * "Set" the values of specified units. Return a newly-constructed Duration.
   * @param {Object} values - a mapping of units to numbers
   * @example dur.set({ years: 2017 })
   * @example dur.set({ hours: 8, minutes: 30 })
   * @return {Duration}
   */set(e){if(!this.isValid)return this;const t={...this.values,...normalizeObject(e,Duration.normalizeUnit)};return clone$1(this,{values:t})}reconfigure({locale:e,numberingSystem:t,conversionAccuracy:n,matrix:r}={}){const s=this.loc.clone({locale:e,numberingSystem:t});const i={loc:s,matrix:r,conversionAccuracy:n};return clone$1(this,i)}
/**
   * Return the length of the duration in the specified unit.
   * @param {string} unit - a unit such as 'minutes' or 'days'
   * @example Duration.fromObject({years: 1}).as('days') //=> 365
   * @example Duration.fromObject({years: 1}).as('months') //=> 12
   * @example Duration.fromObject({hours: 60}).as('days') //=> 2.5
   * @return {number}
   */as(e){return this.isValid?this.shiftTo(e).get(e):NaN}normalize(){if(!this.isValid)return this;const e=this.toObject();normalizeValues(this.matrix,e);return clone$1(this,{values:e},true)}rescale(){if(!this.isValid)return this;const e=removeZeroes(this.normalize().shiftToAll().toObject());return clone$1(this,{values:e},true)}shiftTo(...e){if(!this.isValid)return this;if(0===e.length)return this;e=e.map((e=>Duration.normalizeUnit(e)));const t={},n={},r=this.toObject();let s;for(const i of Ae)if(e.indexOf(i)>=0){s=i;let e=0;for(const t in n){e+=this.matrix[t][i]*n[t];n[t]=0}isNumber(r[i])&&(e+=r[i]);const a=Math.trunc(e);t[i]=a;n[i]=(1e3*e-1e3*a)/1e3;for(const e in r)Ae.indexOf(e)>Ae.indexOf(i)&&convert(this.matrix,r,e,t,i)}else isNumber(r[i])&&(n[i]=r[i]);for(const e in n)0!==n[e]&&(t[s]+=e===s?n[e]:n[e]/this.matrix[s][e]);return clone$1(this,{values:t},true).normalize()}shiftToAll(){return this.isValid?this.shiftTo("years","months","weeks","days","hours","minutes","seconds","milliseconds"):this}negate(){if(!this.isValid)return this;const e={};for(const t of Object.keys(this.values))e[t]=0===this.values[t]?0:-this.values[t];return clone$1(this,{values:e},true)}
/**
   * Get the years.
   * @type {number}
   */get years(){return this.isValid?this.values.years||0:NaN}
/**
   * Get the quarters.
   * @type {number}
   */get quarters(){return this.isValid?this.values.quarters||0:NaN}
/**
   * Get the months.
   * @type {number}
   */get months(){return this.isValid?this.values.months||0:NaN}
/**
   * Get the weeks
   * @type {number}
   */get weeks(){return this.isValid?this.values.weeks||0:NaN}
/**
   * Get the days.
   * @type {number}
   */get days(){return this.isValid?this.values.days||0:NaN}
/**
   * Get the hours.
   * @type {number}
   */get hours(){return this.isValid?this.values.hours||0:NaN}
/**
   * Get the minutes.
   * @type {number}
   */get minutes(){return this.isValid?this.values.minutes||0:NaN}get seconds(){return this.isValid?this.values.seconds||0:NaN}get milliseconds(){return this.isValid?this.values.milliseconds||0:NaN}get isValid(){return null===this.invalid}get invalidReason(){return this.invalid?this.invalid.reason:null}
/**
   * Returns an explanation of why this Duration became invalid, or null if the Duration is valid
   * @type {string}
   */get invalidExplanation(){return this.invalid?this.invalid.explanation:null}
/**
   * Equality check
   * Two Durations are equal iff they have the same units and the same values for each unit.
   * @param {Duration} other
   * @return {boolean}
   */equals(e){if(!this.isValid||!e.isValid)return false;if(!this.loc.equals(e.loc))return false;function eq(e,t){return void 0===e||0===e?void 0===t||0===t:e===t}for(const t of Ae)if(!eq(this.values[t],e.values[t]))return false;return true}}const ze="Invalid Interval";function validateStartEnd(e,t){return e&&e.isValid?t&&t.isValid?t<e?Interval.invalid("end before start",`The end of an interval must be after its start, but you had start=${e.toISO()} and end=${t.toISO()}`):null:Interval.invalid("missing or invalid end"):Interval.invalid("missing or invalid start")}class Interval{constructor(e){this.s=e.start;this.e=e.end;this.invalid=e.invalid||null;this.isLuxonInterval=true}
/**
   * Create an invalid Interval.
   * @param {string} reason - simple string of why this Interval is invalid. Should not contain parameters or anything else data-dependent
   * @param {string} [explanation=null] - longer explanation, may include parameters and other useful debugging information
   * @return {Interval}
   */static invalid(e,t=null){if(!e)throw new InvalidArgumentError("need to specify a reason the Interval is invalid");const n=e instanceof Invalid?e:new Invalid(e,t);if(Settings.throwOnInvalid)throw new InvalidIntervalError(n);return new Interval({invalid:n})}
/**
   * Create an Interval from a start DateTime and an end DateTime. Inclusive of the start but not the end.
   * @param {DateTime|Date|Object} start
   * @param {DateTime|Date|Object} end
   * @return {Interval}
   */static fromDateTimes(e,t){const n=friendlyDateTime(e),r=friendlyDateTime(t);const s=validateStartEnd(n,r);return null==s?new Interval({start:n,end:r}):s}
/**
   * Create an Interval from a start DateTime and a Duration to extend to.
   * @param {DateTime|Date|Object} start
   * @param {Duration|Object|number} duration - the length of the Interval.
   * @return {Interval}
   */static after(e,t){const n=Duration.fromDurationLike(t),r=friendlyDateTime(e);return Interval.fromDateTimes(r,r.plus(n))}
/**
   * Create an Interval from an end DateTime and a Duration to extend backwards to.
   * @param {DateTime|Date|Object} end
   * @param {Duration|Object|number} duration - the length of the Interval.
   * @return {Interval}
   */static before(e,t){const n=Duration.fromDurationLike(t),r=friendlyDateTime(e);return Interval.fromDateTimes(r.minus(n),r)}
/**
   * Create an Interval from an ISO 8601 string.
   * Accepts `<start>/<end>`, `<start>/<duration>`, and `<duration>/<end>` formats.
   * @param {string} text - the ISO string to parse
   * @param {Object} [opts] - options to pass {@link DateTime#fromISO} and optionally {@link Duration#fromISO}
   * @see https://en.wikipedia.org/wiki/ISO_8601#Time_intervals
   * @return {Interval}
   */static fromISO(e,t){const[n,r]=(e||"").split("/",2);if(n&&r){let e,s;try{e=DateTime.fromISO(n,t);s=e.isValid}catch(r){s=false}let i,a;try{i=DateTime.fromISO(r,t);a=i.isValid}catch(r){a=false}if(s&&a)return Interval.fromDateTimes(e,i);if(s){const n=Duration.fromISO(r,t);if(n.isValid)return Interval.after(e,n)}else if(a){const e=Duration.fromISO(n,t);if(e.isValid)return Interval.before(i,e)}}return Interval.invalid("unparsable",`the input "${e}" can't be parsed as ISO 8601`)}
/**
   * Check if an object is an Interval. Works across context boundaries
   * @param {object} o
   * @return {boolean}
   */static isInterval(e){return e&&e.isLuxonInterval||false}
/**
   * Returns the start of the Interval
   * @type {DateTime}
   */get start(){return this.isValid?this.s:null}
/**
   * Returns the end of the Interval
   * @type {DateTime}
   */get end(){return this.isValid?this.e:null}
/**
   * Returns whether this Interval's end is at least its start, meaning that the Interval isn't 'backwards'.
   * @type {boolean}
   */get isValid(){return null===this.invalidReason}
/**
   * Returns an error code if this Interval is invalid, or null if the Interval is valid
   * @type {string}
   */get invalidReason(){return this.invalid?this.invalid.reason:null}
/**
   * Returns an explanation of why this Interval became invalid, or null if the Interval is valid
   * @type {string}
   */get invalidExplanation(){return this.invalid?this.invalid.explanation:null}
/**
   * Returns the length of the Interval in the specified unit.
   * @param {string} unit - the unit (such as 'hours' or 'days') to return the length in.
   * @return {number}
   */length(e="milliseconds"){return this.isValid?this.toDuration(e).get(e):NaN}
/**
   * Returns the count of minutes, hours, days, months, or years included in the Interval, even in part.
   * Unlike {@link Interval#length} this counts sections of the calendar, not periods of time, e.g. specifying 'day'
   * asks 'what dates are included in this interval?', not 'how many days long is this interval?'
   * @param {string} [unit='milliseconds'] - the unit of time to count.
   * @return {number}
   */count(e="milliseconds"){if(!this.isValid)return NaN;const t=this.start.startOf(e),n=this.end.startOf(e);return Math.floor(n.diff(t,e).get(e))+(n.valueOf()!==this.end.valueOf())}
/**
   * Returns whether this Interval's start and end are both in the same unit of time
   * @param {string} unit - the unit of time to check sameness on
   * @return {boolean}
   */hasSame(e){return!!this.isValid&&(this.isEmpty()||this.e.minus(1).hasSame(this.s,e))}isEmpty(){return this.s.valueOf()===this.e.valueOf()}
/**
   * Return whether this Interval's start is after the specified DateTime.
   * @param {DateTime} dateTime
   * @return {boolean}
   */isAfter(e){return!!this.isValid&&this.s>e}
/**
   * Return whether this Interval's end is before the specified DateTime.
   * @param {DateTime} dateTime
   * @return {boolean}
   */isBefore(e){return!!this.isValid&&this.e<=e}
/**
   * Return whether this Interval contains the specified DateTime.
   * @param {DateTime} dateTime
   * @return {boolean}
   */contains(e){return!!this.isValid&&(this.s<=e&&this.e>e)}
/**
   * "Sets" the start and/or end dates. Returns a newly-constructed Interval.
   * @param {Object} values - the values to set
   * @param {DateTime} values.start - the starting DateTime
   * @param {DateTime} values.end - the ending DateTime
   * @return {Interval}
   */set({start:e,end:t}={}){return this.isValid?Interval.fromDateTimes(e||this.s,t||this.e):this}
/**
   * Split this Interval at each of the specified DateTimes
   * @param {...DateTime} dateTimes - the unit of time to count.
   * @return {Array}
   */splitAt(...e){if(!this.isValid)return[];const t=e.map(friendlyDateTime).filter((e=>this.contains(e))).sort(),n=[];let{s:r}=this,s=0;while(r<this.e){const e=t[s]||this.e,i=+e>+this.e?this.e:e;n.push(Interval.fromDateTimes(r,i));r=i;s+=1}return n}
/**
   * Split this Interval into smaller Intervals, each of the specified length.
   * Left over time is grouped into a smaller interval
   * @param {Duration|Object|number} duration - The length of each resulting interval.
   * @return {Array}
   */splitBy(e){const t=Duration.fromDurationLike(e);if(!this.isValid||!t.isValid||0===t.as("milliseconds"))return[];let n,{s:r}=this,s=1;const i=[];while(r<this.e){const e=this.start.plus(t.mapUnits((e=>e*s)));n=+e>+this.e?this.e:e;i.push(Interval.fromDateTimes(r,n));r=n;s+=1}return i}
/**
   * Split this Interval into the specified number of smaller intervals.
   * @param {number} numberOfParts - The number of Intervals to divide the Interval into.
   * @return {Array}
   */divideEqually(e){return this.isValid?this.splitBy(this.length()/e).slice(0,e):[]}
/**
   * Return whether this Interval overlaps with the specified Interval
   * @param {Interval} other
   * @return {boolean}
   */overlaps(e){return this.e>e.s&&this.s<e.e}
/**
   * Return whether this Interval's end is adjacent to the specified Interval's start.
   * @param {Interval} other
   * @return {boolean}
   */abutsStart(e){return!!this.isValid&&+this.e===+e.s}
/**
   * Return whether this Interval's start is adjacent to the specified Interval's end.
   * @param {Interval} other
   * @return {boolean}
   */abutsEnd(e){return!!this.isValid&&+e.e===+this.s}
/**
   * Return whether this Interval engulfs the start and end of the specified Interval.
   * @param {Interval} other
   * @return {boolean}
   */engulfs(e){return!!this.isValid&&(this.s<=e.s&&this.e>=e.e)}
/**
   * Return whether this Interval has the same start and end as the specified Interval.
   * @param {Interval} other
   * @return {boolean}
   */equals(e){return!(!this.isValid||!e.isValid)&&(this.s.equals(e.s)&&this.e.equals(e.e))}
/**
   * Return an Interval representing the intersection of this Interval and the specified Interval.
   * Specifically, the resulting Interval has the maximum start time and the minimum end time of the two Intervals.
   * Returns null if the intersection is empty, meaning, the intervals don't intersect.
   * @param {Interval} other
   * @return {Interval}
   */intersection(e){if(!this.isValid)return this;const t=this.s>e.s?this.s:e.s,n=this.e<e.e?this.e:e.e;return t>=n?null:Interval.fromDateTimes(t,n)}
/**
   * Return an Interval representing the union of this Interval and the specified Interval.
   * Specifically, the resulting Interval has the minimum start time and the maximum end time of the two Intervals.
   * @param {Interval} other
   * @return {Interval}
   */union(e){if(!this.isValid)return this;const t=this.s<e.s?this.s:e.s,n=this.e>e.e?this.e:e.e;return Interval.fromDateTimes(t,n)}
/**
   * Merge an array of Intervals into a equivalent minimal set of Intervals.
   * Combines overlapping and adjacent Intervals.
   * @param {Array} intervals
   * @return {Array}
   */static merge(e){const[t,n]=e.sort(((e,t)=>e.s-t.s)).reduce((([e,t],n)=>t?t.overlaps(n)||t.abutsStart(n)?[e,t.union(n)]:[e.concat([t]),n]:[e,n]),[[],null]);n&&t.push(n);return t}
/**
   * Return an array of Intervals representing the spans of time that only appear in one of the specified Intervals.
   * @param {Array} intervals
   * @return {Array}
   */static xor(e){let t=null,n=0;const r=[],s=e.map((e=>[{time:e.s,type:"s"},{time:e.e,type:"e"}])),i=Array.prototype.concat(...s),a=i.sort(((e,t)=>e.time-t.time));for(const e of a){n+="s"===e.type?1:-1;if(1===n)t=e.time;else{t&&+t!==+e.time&&r.push(Interval.fromDateTimes(t,e.time));t=null}}return Interval.merge(r)}
/**
   * Return an Interval representing the span of time in this Interval that doesn't overlap with any of the specified Intervals.
   * @param {...Interval} intervals
   * @return {Array}
   */difference(...e){return Interval.xor([this].concat(e)).map((e=>this.intersection(e))).filter((e=>e&&!e.isEmpty()))}toString(){return this.isValid?`[${this.s.toISO()} – ${this.e.toISO()})`:ze}
/**
   * Returns a localized string representing this Interval. Accepts the same options as the
   * Intl.DateTimeFormat constructor and any presets defined by Luxon, such as
   * {@link DateTime.DATE_FULL} or {@link DateTime.TIME_SIMPLE}. The exact behavior of this method
   * is browser-specific, but in general it will return an appropriate representation of the
   * Interval in the assigned locale. Defaults to the system's locale if no locale has been
   * specified.
   * @see https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DateTimeFormat
   * @param {Object} [formatOpts=DateTime.DATE_SHORT] - Either a DateTime preset or
   * Intl.DateTimeFormat constructor options.
   * @param {Object} opts - Options to override the configuration of the start DateTime.
   * @example Interval.fromISO('2022-11-07T09:00Z/2022-11-08T09:00Z').toLocaleString(); //=> 11/7/2022 – 11/8/2022
   * @example Interval.fromISO('2022-11-07T09:00Z/2022-11-08T09:00Z').toLocaleString(DateTime.DATE_FULL); //=> November 7 – 8, 2022
   * @example Interval.fromISO('2022-11-07T09:00Z/2022-11-08T09:00Z').toLocaleString(DateTime.DATE_FULL, { locale: 'fr-FR' }); //=> 7–8 novembre 2022
   * @example Interval.fromISO('2022-11-07T17:00Z/2022-11-07T19:00Z').toLocaleString(DateTime.TIME_SIMPLE); //=> 6:00 – 8:00 PM
   * @example Interval.fromISO('2022-11-07T17:00Z/2022-11-07T19:00Z').toLocaleString({ weekday: 'short', month: 'short', day: '2-digit', hour: '2-digit', minute: '2-digit' }); //=> Mon, Nov 07, 6:00 – 8:00 p
   * @return {string}
   */toLocaleString(e=r,t={}){return this.isValid?Formatter.create(this.s.loc.clone(t),e).formatInterval(this):ze}
/**
   * Returns an ISO 8601-compliant string representation of this Interval.
   * @see https://en.wikipedia.org/wiki/ISO_8601#Time_intervals
   * @param {Object} opts - The same options as {@link DateTime#toISO}
   * @return {string}
   */toISO(e){return this.isValid?`${this.s.toISO(e)}/${this.e.toISO(e)}`:ze}toISODate(){return this.isValid?`${this.s.toISODate()}/${this.e.toISODate()}`:ze}
/**
   * Returns an ISO 8601-compliant string representation of time of this Interval.
   * The date components are ignored.
   * @see https://en.wikipedia.org/wiki/ISO_8601#Time_intervals
   * @param {Object} opts - The same options as {@link DateTime#toISO}
   * @return {string}
   */toISOTime(e){return this.isValid?`${this.s.toISOTime(e)}/${this.e.toISOTime(e)}`:ze}
/**
   * Returns a string representation of this Interval formatted according to the specified format
   * string. **You may not want this.** See {@link Interval#toLocaleString} for a more flexible
   * formatting tool.
   * @param {string} dateFormat - The format string. This string formats the start and end time.
   * See {@link DateTime#toFormat} for details.
   * @param {Object} opts - Options.
   * @param {string} [opts.separator =  ' – '] - A separator to place between the start and end
   * representations.
   * @return {string}
   */toFormat(e,{separator:t=" – "}={}){return this.isValid?`${this.s.toFormat(e)}${t}${this.e.toFormat(e)}`:ze}
/**
   * Return a Duration representing the time spanned by this interval.
   * @param {string|string[]} [unit=['milliseconds']] - the unit or units (such as 'hours' or 'days') to include in the duration.
   * @param {Object} opts - options that affect the creation of the Duration
   * @param {string} [opts.conversionAccuracy='casual'] - the conversion system to use
   * @example Interval.fromDateTimes(dt1, dt2).toDuration().toObject() //=> { milliseconds: 88489257 }
   * @example Interval.fromDateTimes(dt1, dt2).toDuration('days').toObject() //=> { days: 1.0241812152777778 }
   * @example Interval.fromDateTimes(dt1, dt2).toDuration(['hours', 'minutes']).toObject() //=> { hours: 24, minutes: 34.82095 }
   * @example Interval.fromDateTimes(dt1, dt2).toDuration(['hours', 'minutes', 'seconds']).toObject() //=> { hours: 24, minutes: 34, seconds: 49.257 }
   * @example Interval.fromDateTimes(dt1, dt2).toDuration('seconds').toObject() //=> { seconds: 88489.257 }
   * @return {Duration}
   */toDuration(e,t){return this.isValid?this.e.diff(this.s,e,t):Duration.invalid(this.invalidReason)}
/**
   * Run mapFn on the interval start and end, returning a new Interval from the resulting DateTimes
   * @param {function} mapFn
   * @return {Interval}
   * @example Interval.fromDateTimes(dt1, dt2).mapEndpoints(endpoint => endpoint.toUTC())
   * @example Interval.fromDateTimes(dt1, dt2).mapEndpoints(endpoint => endpoint.plus({ hours: 2 }))
   */mapEndpoints(e){return Interval.fromDateTimes(e(this.s),e(this.e))}}class Info{
/**
   * Return whether the specified zone contains a DST.
   * @param {string|Zone} [zone='local'] - Zone to check. Defaults to the environment's local zone.
   * @return {boolean}
   */
static hasDST(e=Settings.defaultZone){const t=DateTime.now().setZone(e).set({month:12});return!e.isUniversal&&t.offset!==t.set({month:6}).offset}
/**
   * Return whether the specified zone is a valid IANA specifier.
   * @param {string} zone - Zone to check
   * @return {boolean}
   */static isValidIANAZone(e){return IANAZone.isValidZone(e)}
/**
   * Converts the input into a {@link Zone} instance.
   *
   * * If `input` is already a Zone instance, it is returned unchanged.
   * * If `input` is a string containing a valid time zone name, a Zone instance
   *   with that name is returned.
   * * If `input` is a string that doesn't refer to a known time zone, a Zone
   *   instance with {@link Zone#isValid} == false is returned.
   * * If `input is a number, a Zone instance with the specified fixed offset
   *   in minutes is returned.
   * * If `input` is `null` or `undefined`, the default zone is returned.
   * @param {string|Zone|number} [input] - the value to be converted
   * @return {Zone}
   */static normalizeZone(e){return normalizeZone(e,Settings.defaultZone)}
/**
   * Return an array of standalone month names.
   * @see https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DateTimeFormat
   * @param {string} [length='long'] - the length of the month representation, such as "numeric", "2-digit", "narrow", "short", "long"
   * @param {Object} opts - options
   * @param {string} [opts.locale] - the locale code
   * @param {string} [opts.numberingSystem=null] - the numbering system
   * @param {string} [opts.locObj=null] - an existing locale object to use
   * @param {string} [opts.outputCalendar='gregory'] - the calendar
   * @example Info.months()[0] //=> 'January'
   * @example Info.months('short')[0] //=> 'Jan'
   * @example Info.months('numeric')[0] //=> '1'
   * @example Info.months('short', { locale: 'fr-CA' } )[0] //=> 'janv.'
   * @example Info.months('numeric', { locale: 'ar' })[0] //=> '١'
   * @example Info.months('long', { outputCalendar: 'islamic' })[0] //=> 'Rabiʻ I'
   * @return {Array}
   */static months(e="long",{locale:t=null,numberingSystem:n=null,locObj:r=null,outputCalendar:s="gregory"}={}){return(r||Locale.create(t,n,s)).months(e)}
/**
   * Return an array of format month names.
   * Format months differ from standalone months in that they're meant to appear next to the day of the month. In some languages, that
   * changes the string.
   * See {@link Info#months}
   * @param {string} [length='long'] - the length of the month representation, such as "numeric", "2-digit", "narrow", "short", "long"
   * @param {Object} opts - options
   * @param {string} [opts.locale] - the locale code
   * @param {string} [opts.numberingSystem=null] - the numbering system
   * @param {string} [opts.locObj=null] - an existing locale object to use
   * @param {string} [opts.outputCalendar='gregory'] - the calendar
   * @return {Array}
   */static monthsFormat(e="long",{locale:t=null,numberingSystem:n=null,locObj:r=null,outputCalendar:s="gregory"}={}){return(r||Locale.create(t,n,s)).months(e,true)}
/**
   * Return an array of standalone week names.
   * @see https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DateTimeFormat
   * @param {string} [length='long'] - the length of the weekday representation, such as "narrow", "short", "long".
   * @param {Object} opts - options
   * @param {string} [opts.locale] - the locale code
   * @param {string} [opts.numberingSystem=null] - the numbering system
   * @param {string} [opts.locObj=null] - an existing locale object to use
   * @example Info.weekdays()[0] //=> 'Monday'
   * @example Info.weekdays('short')[0] //=> 'Mon'
   * @example Info.weekdays('short', { locale: 'fr-CA' })[0] //=> 'lun.'
   * @example Info.weekdays('short', { locale: 'ar' })[0] //=> 'الاثنين'
   * @return {Array}
   */static weekdays(e="long",{locale:t=null,numberingSystem:n=null,locObj:r=null}={}){return(r||Locale.create(t,n,null)).weekdays(e)}
/**
   * Return an array of format week names.
   * Format weekdays differ from standalone weekdays in that they're meant to appear next to more date information. In some languages, that
   * changes the string.
   * See {@link Info#weekdays}
   * @param {string} [length='long'] - the length of the month representation, such as "narrow", "short", "long".
   * @param {Object} opts - options
   * @param {string} [opts.locale=null] - the locale code
   * @param {string} [opts.numberingSystem=null] - the numbering system
   * @param {string} [opts.locObj=null] - an existing locale object to use
   * @return {Array}
   */static weekdaysFormat(e="long",{locale:t=null,numberingSystem:n=null,locObj:r=null}={}){return(r||Locale.create(t,n,null)).weekdays(e,true)}
/**
   * Return an array of meridiems.
   * @param {Object} opts - options
   * @param {string} [opts.locale] - the locale code
   * @example Info.meridiems() //=> [ 'AM', 'PM' ]
   * @example Info.meridiems({ locale: 'my' }) //=> [ 'နံနက်', 'ညနေ' ]
   * @return {Array}
   */static meridiems({locale:e=null}={}){return Locale.create(e).meridiems()}
/**
   * Return an array of eras, such as ['BC', 'AD']. The locale can be specified, but the calendar system is always Gregorian.
   * @param {string} [length='short'] - the length of the era representation, such as "short" or "long".
   * @param {Object} opts - options
   * @param {string} [opts.locale] - the locale code
   * @example Info.eras() //=> [ 'BC', 'AD' ]
   * @example Info.eras('long') //=> [ 'Before Christ', 'Anno Domini' ]
   * @example Info.eras('long', { locale: 'fr' }) //=> [ 'avant Jésus-Christ', 'après Jésus-Christ' ]
   * @return {Array}
   */static eras(e="short",{locale:t=null}={}){return Locale.create(t,null,"gregory").eras(e)}static features(){return{relative:hasRelative()}}}function dayDiff(e,t){const utcDayStart=e=>e.toUTC(0,{keepLocalTime:true}).startOf("day").valueOf(),n=utcDayStart(t)-utcDayStart(e);return Math.floor(Duration.fromMillis(n).as("days"))}function highOrderDiffs(e,t,n){const r=[["years",(e,t)=>t.year-e.year],["quarters",(e,t)=>t.quarter-e.quarter+4*(t.year-e.year)],["months",(e,t)=>t.month-e.month+12*(t.year-e.year)],["weeks",(e,t)=>{const n=dayDiff(e,t);return(n-n%7)/7}],["days",dayDiff]];const s={};const i=e;let a,o;for(const[u,l]of r)if(n.indexOf(u)>=0){a=u;s[u]=l(e,t);o=i.plus(s);if(o>t){s[u]--;e=i.plus(s)}else e=o}return[e,s,o,a]}function diff(e,t,n,r){let[s,i,a,o]=highOrderDiffs(e,t,n);const u=t-s;const l=n.filter((e=>["hours","minutes","seconds","milliseconds"].indexOf(e)>=0));if(0===l.length){a<t&&(a=s.plus({[o]:1}));a!==s&&(i[o]=(i[o]||0)+u/(a-s))}const c=Duration.fromObject(i,r);return l.length>0?Duration.fromMillis(u,r).shiftTo(...l).plus(c):c}const Re={arab:"[٠-٩]",arabext:"[۰-۹]",bali:"[᭐-᭙]",beng:"[০-৯]",deva:"[०-९]",fullwide:"[０-９]",gujr:"[૦-૯]",hanidec:"[〇|一|二|三|四|五|六|七|八|九]",khmr:"[០-៩]",knda:"[೦-೯]",laoo:"[໐-໙]",limb:"[᥆-᥏]",mlym:"[൦-൯]",mong:"[᠐-᠙]",mymr:"[၀-၉]",orya:"[୦-୯]",tamldec:"[௦-௯]",telu:"[౦-౯]",thai:"[๐-๙]",tibt:"[༠-༩]",latn:"\\d"};const je={arab:[1632,1641],arabext:[1776,1785],bali:[6992,7001],beng:[2534,2543],deva:[2406,2415],fullwide:[65296,65303],gujr:[2790,2799],khmr:[6112,6121],knda:[3302,3311],laoo:[3792,3801],limb:[6470,6479],mlym:[3430,3439],mong:[6160,6169],mymr:[4160,4169],orya:[2918,2927],tamldec:[3046,3055],telu:[3174,3183],thai:[3664,3673],tibt:[3872,3881]};const qe=Re.hanidec.replace(/[\[|\]]/g,"").split("");function parseDigits(e){let t=parseInt(e,10);if(isNaN(t)){t="";for(let n=0;n<e.length;n++){const r=e.charCodeAt(n);if(-1!==e[n].search(Re.hanidec))t+=qe.indexOf(e[n]);else for(const e in je){const[n,s]=je[e];r>=n&&r<=s&&(t+=r-n)}}return parseInt(t,10)}return t}function digitRegex({numberingSystem:e},t=""){return new RegExp(`${Re[e||"latn"]}${t}`)}const We="missing Intl.DateTimeFormat.formatToParts support";function intUnit(e,t=(e=>e)){return{regex:e,deser:([e])=>t(parseDigits(e))}}const Ye=String.fromCharCode(160);const _e=`[ ${Ye}]`;const Pe=new RegExp(_e,"g");function fixListRegex(e){return e.replace(/\./g,"\\.?").replace(Pe,_e)}function stripInsensitivities(e){return e.replace(/\./g,"").replace(Pe," ").toLowerCase()}function oneOf(e,t){return null===e?null:{regex:RegExp(e.map(fixListRegex).join("|")),deser:([n])=>e.findIndex((e=>stripInsensitivities(n)===stripInsensitivities(e)))+t}}function offset(e,t){return{regex:e,deser:([,e,t])=>signedOffset(e,t),groups:t}}function simple(e){return{regex:e,deser:([e])=>e}}function escapeToken(e){return e.replace(/[\-\[\]{}()*+?.,\\\^$|#\s]/g,"\\$&")}function unitForToken(e,t){const n=digitRegex(t),r=digitRegex(t,"{2}"),s=digitRegex(t,"{3}"),i=digitRegex(t,"{4}"),a=digitRegex(t,"{6}"),o=digitRegex(t,"{1,2}"),u=digitRegex(t,"{1,3}"),l=digitRegex(t,"{1,6}"),c=digitRegex(t,"{1,9}"),d=digitRegex(t,"{2,4}"),m=digitRegex(t,"{4,6}"),literal=e=>({regex:RegExp(escapeToken(e.val)),deser:([e])=>e,literal:true}),unitate=h=>{if(e.literal)return literal(h);switch(h.val){case"G":return oneOf(t.eras("short",false),0);case"GG":return oneOf(t.eras("long",false),0);case"y":return intUnit(l);case"yy":return intUnit(d,untruncateYear);case"yyyy":return intUnit(i);case"yyyyy":return intUnit(m);case"yyyyyy":return intUnit(a);case"M":return intUnit(o);case"MM":return intUnit(r);case"MMM":return oneOf(t.months("short",true,false),1);case"MMMM":return oneOf(t.months("long",true,false),1);case"L":return intUnit(o);case"LL":return intUnit(r);case"LLL":return oneOf(t.months("short",false,false),1);case"LLLL":return oneOf(t.months("long",false,false),1);case"d":return intUnit(o);case"dd":return intUnit(r);case"o":return intUnit(u);case"ooo":return intUnit(s);case"HH":return intUnit(r);case"H":return intUnit(o);case"hh":return intUnit(r);case"h":return intUnit(o);case"mm":return intUnit(r);case"m":return intUnit(o);case"q":return intUnit(o);case"qq":return intUnit(r);case"s":return intUnit(o);case"ss":return intUnit(r);case"S":return intUnit(u);case"SSS":return intUnit(s);case"u":return simple(c);case"uu":return simple(o);case"uuu":return intUnit(n);case"a":return oneOf(t.meridiems(),0);case"kkkk":return intUnit(i);case"kk":return intUnit(d,untruncateYear);case"W":return intUnit(o);case"WW":return intUnit(r);case"E":case"c":return intUnit(n);case"EEE":return oneOf(t.weekdays("short",false,false),1);case"EEEE":return oneOf(t.weekdays("long",false,false),1);case"ccc":return oneOf(t.weekdays("short",true,false),1);case"cccc":return oneOf(t.weekdays("long",true,false),1);case"Z":case"ZZ":return offset(new RegExp(`([+-]${o.source})(?::(${r.source}))?`),2);case"ZZZ":return offset(new RegExp(`([+-]${o.source})(${r.source})?`),2);case"z":return simple(/[a-z_+-/]{1,256}?/i);case" ":return simple(/[^\S\n\r]/);default:return literal(h)}};const h=unitate(e)||{invalidReason:We};h.token=e;return h}const He={year:{"2-digit":"yy",numeric:"yyyyy"},month:{numeric:"M","2-digit":"MM",short:"MMM",long:"MMMM"},day:{numeric:"d","2-digit":"dd"},weekday:{short:"EEE",long:"EEEE"},dayperiod:"a",dayPeriod:"a",hour:{numeric:"h","2-digit":"hh"},minute:{numeric:"m","2-digit":"mm"},second:{numeric:"s","2-digit":"ss"},timeZoneName:{long:"ZZZZZ",short:"ZZZ"}};function tokenForPart(e,t){const{type:n,value:r}=e;if("literal"===n){const e=/^\s+$/.test(r);return{literal:!e,val:e?" ":r}}const s=t[n];let i=He[n];"object"===typeof i&&(i=i[s]);if(i)return{literal:false,val:i}}function buildRegex(e){const t=e.map((e=>e.regex)).reduce(((e,t)=>`${e}(${t.source})`),"");return[`^${t}$`,e]}function match(e,t,n){const r=e.match(t);if(r){const e={};let t=1;for(const s in n)if(hasOwnProperty(n,s)){const i=n[s],a=i.groups?i.groups+1:1;!i.literal&&i.token&&(e[i.token.val[0]]=i.deser(r.slice(t,t+a)));t+=a}return[r,e]}return[r,{}]}function dateTimeFromMatches(e){const toField=e=>{switch(e){case"S":return"millisecond";case"s":return"second";case"m":return"minute";case"h":case"H":return"hour";case"d":return"day";case"o":return"ordinal";case"L":case"M":return"month";case"y":return"year";case"E":case"c":return"weekday";case"W":return"weekNumber";case"k":return"weekYear";case"q":return"quarter";default:return null}};let t=null;let n;isUndefined(e.z)||(t=IANAZone.create(e.z));if(!isUndefined(e.Z)){t||(t=new FixedOffsetZone(e.Z));n=e.Z}isUndefined(e.q)||(e.M=3*(e.q-1)+1);isUndefined(e.h)||(e.h<12&&1===e.a?e.h+=12:12===e.h&&0===e.a&&(e.h=0));0===e.G&&e.y&&(e.y=-e.y);isUndefined(e.u)||(e.S=parseMillis(e.u));const r=Object.keys(e).reduce(((t,n)=>{const r=toField(n);r&&(t[r]=e[n]);return t}),{});return[r,t,n]}let Ge=null;function getDummyDateTime(){Ge||(Ge=DateTime.fromMillis(1555555555555));return Ge}function maybeExpandMacroToken(e,t){if(e.literal)return e;const n=Formatter.macroTokenToFormatOpts(e.val);const r=formatOptsToTokens(n,t);return null==r||r.includes(void 0)?e:r}function expandMacroTokens(e,t){return Array.prototype.concat(...e.map((e=>maybeExpandMacroToken(e,t))))}function explainFromTokens(e,t,n){const r=expandMacroTokens(Formatter.parseFormat(n),e),s=r.map((t=>unitForToken(t,e))),i=s.find((e=>e.invalidReason));if(i)return{input:t,tokens:r,invalidReason:i.invalidReason};{const[e,n]=buildRegex(s),i=RegExp(e,"i"),[a,o]=match(t,i,n),[u,l,c]=o?dateTimeFromMatches(o):[null,null,void 0];if(hasOwnProperty(o,"a")&&hasOwnProperty(o,"H"))throw new ConflictingSpecificationError("Can't include meridiem when specifying 24-hour format");return{input:t,tokens:r,regex:i,rawMatches:a,matches:o,result:u,zone:l,specificOffset:c}}}function parseFromTokens(e,t,n){const{result:r,zone:s,specificOffset:i,invalidReason:a}=explainFromTokens(e,t,n);return[r,s,i,a]}function formatOptsToTokens(e,t){if(!e)return null;const n=Formatter.create(t,e);const r=n.formatDateTimeParts(getDummyDateTime());return r.map((t=>tokenForPart(t,e)))}const Je=[0,31,59,90,120,151,181,212,243,273,304,334],Be=[0,31,60,91,121,152,182,213,244,274,305,335];function unitOutOfRange(e,t){return new Invalid("unit out of range",`you specified ${t} (of type ${typeof t}) as a ${e}, which is invalid`)}function dayOfWeek(e,t,n){const r=new Date(Date.UTC(e,t-1,n));e<100&&e>=0&&r.setUTCFullYear(r.getUTCFullYear()-1900);const s=r.getUTCDay();return 0===s?7:s}function computeOrdinal(e,t,n){return n+(isLeapYear(e)?Be:Je)[t-1]}function uncomputeOrdinal(e,t){const n=isLeapYear(e)?Be:Je,r=n.findIndex((e=>e<t)),s=t-n[r];return{month:r+1,day:s}}function gregorianToWeek(e){const{year:t,month:n,day:r}=e,s=computeOrdinal(t,n,r),i=dayOfWeek(t,n,r);let a,o=Math.floor((s-i+10)/7);if(o<1){a=t-1;o=weeksInWeekYear(a)}else if(o>weeksInWeekYear(t)){a=t+1;o=1}else a=t;return{weekYear:a,weekNumber:o,weekday:i,...timeObject(e)}}function weekToGregorian(e){const{weekYear:t,weekNumber:n,weekday:r}=e,s=dayOfWeek(t,1,4),i=daysInYear(t);let a,o=7*n+r-s-3;if(o<1){a=t-1;o+=daysInYear(a)}else if(o>i){a=t+1;o-=daysInYear(t)}else a=t;const{month:u,day:l}=uncomputeOrdinal(a,o);return{year:a,month:u,day:l,...timeObject(e)}}function gregorianToOrdinal(e){const{year:t,month:n,day:r}=e;const s=computeOrdinal(t,n,r);return{year:t,ordinal:s,...timeObject(e)}}function ordinalToGregorian(e){const{year:t,ordinal:n}=e;const{month:r,day:s}=uncomputeOrdinal(t,n);return{year:t,month:r,day:s,...timeObject(e)}}function hasInvalidWeekData(e){const t=isInteger(e.weekYear),n=integerBetween(e.weekNumber,1,weeksInWeekYear(e.weekYear)),r=integerBetween(e.weekday,1,7);return t?n?!r&&unitOutOfRange("weekday",e.weekday):unitOutOfRange("week",e.week):unitOutOfRange("weekYear",e.weekYear)}function hasInvalidOrdinalData(e){const t=isInteger(e.year),n=integerBetween(e.ordinal,1,daysInYear(e.year));return t?!n&&unitOutOfRange("ordinal",e.ordinal):unitOutOfRange("year",e.year)}function hasInvalidGregorianData(e){const t=isInteger(e.year),n=integerBetween(e.month,1,12),r=integerBetween(e.day,1,daysInMonth(e.year,e.month));return t?n?!r&&unitOutOfRange("day",e.day):unitOutOfRange("month",e.month):unitOutOfRange("year",e.year)}function hasInvalidTimeData(e){const{hour:t,minute:n,second:r,millisecond:s}=e;const i=integerBetween(t,0,23)||24===t&&0===n&&0===r&&0===s,a=integerBetween(n,0,59),o=integerBetween(r,0,59),u=integerBetween(s,0,999);return i?a?o?!u&&unitOutOfRange("millisecond",s):unitOutOfRange("second",r):unitOutOfRange("minute",n):unitOutOfRange("hour",t)}const Qe="Invalid DateTime";const Ke=864e13;function unsupportedZone(e){return new Invalid("unsupported zone",`the zone "${e.name}" is not supported`)}function possiblyCachedWeekData(e){null===e.weekData&&(e.weekData=gregorianToWeek(e.c));return e.weekData}function clone(e,t){const n={ts:e.ts,zone:e.zone,c:e.c,o:e.o,loc:e.loc,invalid:e.invalid};return new DateTime({...n,...t,old:n})}function fixOffset(e,t,n){let r=e-60*t*1e3;const s=n.offset(r);if(t===s)return[r,t];r-=60*(s-t)*1e3;const i=n.offset(r);return s===i?[r,s]:[e-60*Math.min(s,i)*1e3,Math.max(s,i)]}function tsToObj(e,t){e+=60*t*1e3;const n=new Date(e);return{year:n.getUTCFullYear(),month:n.getUTCMonth()+1,day:n.getUTCDate(),hour:n.getUTCHours(),minute:n.getUTCMinutes(),second:n.getUTCSeconds(),millisecond:n.getUTCMilliseconds()}}function objToTS(e,t,n){return fixOffset(objToLocalTS(e),t,n)}function adjustTime(e,t){const n=e.o,r=e.c.year+Math.trunc(t.years),s=e.c.month+Math.trunc(t.months)+3*Math.trunc(t.quarters),i={...e.c,year:r,month:s,day:Math.min(e.c.day,daysInMonth(r,s))+Math.trunc(t.days)+7*Math.trunc(t.weeks)},a=Duration.fromObject({years:t.years-Math.trunc(t.years),quarters:t.quarters-Math.trunc(t.quarters),months:t.months-Math.trunc(t.months),weeks:t.weeks-Math.trunc(t.weeks),days:t.days-Math.trunc(t.days),hours:t.hours,minutes:t.minutes,seconds:t.seconds,milliseconds:t.milliseconds}).as("milliseconds"),o=objToLocalTS(i);let[u,l]=fixOffset(o,n,e.zone);if(0!==a){u+=a;l=e.zone.offset(u)}return{ts:u,o:l}}function parseDataToDateTime(e,t,n,r,s,i){const{setZone:a,zone:o}=n;if(e&&0!==Object.keys(e).length||t){const r=t||o,s=DateTime.fromObject(e,{...n,zone:r,specificOffset:i});return a?s:s.setZone(o)}return DateTime.invalid(new Invalid("unparsable",`the input "${s}" can't be parsed as ${r}`))}function toTechFormat(e,t,n=true){return e.isValid?Formatter.create(Locale.create("en-US"),{allowZ:n,forceSimple:true}).formatDateTimeFromString(e,t):null}function toISODate(e,t){const n=e.c.year>9999||e.c.year<0;let r="";n&&e.c.year>=0&&(r+="+");r+=padStart(e.c.year,n?6:4);if(t){r+="-";r+=padStart(e.c.month);r+="-";r+=padStart(e.c.day)}else{r+=padStart(e.c.month);r+=padStart(e.c.day)}return r}function toISOTime(e,t,n,r,s,i){let a=padStart(e.c.hour);if(t){a+=":";a+=padStart(e.c.minute);0===e.c.second&&n||(a+=":")}else a+=padStart(e.c.minute);if(0!==e.c.second||!n){a+=padStart(e.c.second);if(0!==e.c.millisecond||!r){a+=".";a+=padStart(e.c.millisecond,3)}}if(s)if(e.isOffsetFixed&&0===e.offset&&!i)a+="Z";else if(e.o<0){a+="-";a+=padStart(Math.trunc(-e.o/60));a+=":";a+=padStart(Math.trunc(-e.o%60))}else{a+="+";a+=padStart(Math.trunc(e.o/60));a+=":";a+=padStart(Math.trunc(e.o%60))}i&&(a+="["+e.zone.ianaName+"]");return a}const Xe={month:1,day:1,hour:0,minute:0,second:0,millisecond:0},et={weekNumber:1,weekday:1,hour:0,minute:0,second:0,millisecond:0},tt={ordinal:1,hour:0,minute:0,second:0,millisecond:0};const nt=["year","month","day","hour","minute","second","millisecond"],rt=["weekYear","weekNumber","weekday","hour","minute","second","millisecond"],st=["year","ordinal","hour","minute","second","millisecond"];function normalizeUnit(e){const t={year:"year",years:"year",month:"month",months:"month",day:"day",days:"day",hour:"hour",hours:"hour",minute:"minute",minutes:"minute",quarter:"quarter",quarters:"quarter",second:"second",seconds:"second",millisecond:"millisecond",milliseconds:"millisecond",weekday:"weekday",weekdays:"weekday",weeknumber:"weekNumber",weeksnumber:"weekNumber",weeknumbers:"weekNumber",weekyear:"weekYear",weekyears:"weekYear",ordinal:"ordinal"}[e.toLowerCase()];if(!t)throw new InvalidUnitError(e);return t}function quickDT(e,t){const n=normalizeZone(t.zone,Settings.defaultZone),r=Locale.fromObject(t),s=Settings.now();let i,a;if(isUndefined(e.year))i=s;else{for(const t of nt)isUndefined(e[t])&&(e[t]=Xe[t]);const t=hasInvalidGregorianData(e)||hasInvalidTimeData(e);if(t)return DateTime.invalid(t);const r=n.offset(s);[i,a]=objToTS(e,r,n)}return new DateTime({ts:i,zone:n,loc:r,o:a})}function diffRelative(e,t,n){const r=!!isUndefined(n.round)||n.round,format=(e,s)=>{e=roundTo(e,r||n.calendary?0:2,true);const i=t.loc.clone(n).relFormatter(n);return i.format(e,s)},differ=r=>n.calendary?t.hasSame(e,r)?0:t.startOf(r).diff(e.startOf(r),r).get(r):t.diff(e,r).get(r);if(n.unit)return format(differ(n.unit),n.unit);for(const e of n.units){const t=differ(e);if(Math.abs(t)>=1)return format(t,e)}return format(e>t?-0:0,n.units[n.units.length-1])}function lastOpts(e){let t,n={};if(e.length>0&&"object"===typeof e[e.length-1]){n=e[e.length-1];t=Array.from(e).slice(0,e.length-1)}else t=Array.from(e);return[n,t]}class DateTime{constructor(e){const t=e.zone||Settings.defaultZone;let n=e.invalid||(Number.isNaN(e.ts)?new Invalid("invalid input"):null)||(t.isValid?null:unsupportedZone(t));this.ts=isUndefined(e.ts)?Settings.now():e.ts;let r=null,s=null;if(!n){const i=e.old&&e.old.ts===this.ts&&e.old.zone.equals(t);if(i)[r,s]=[e.old.c,e.old.o];else{const e=t.offset(this.ts);r=tsToObj(this.ts,e);n=Number.isNaN(r.year)?new Invalid("invalid input"):null;r=n?null:r;s=n?null:e}}this._zone=t;this.loc=e.loc||Locale.create();this.invalid=n;this.weekData=null;this.c=r;this.o=s;this.isLuxonDateTime=true}static now(){return new DateTime({})}
/**
   * Create a local DateTime
   * @param {number} [year] - The calendar year. If omitted (as in, call `local()` with no arguments), the current time will be used
   * @param {number} [month=1] - The month, 1-indexed
   * @param {number} [day=1] - The day of the month, 1-indexed
   * @param {number} [hour=0] - The hour of the day, in 24-hour time
   * @param {number} [minute=0] - The minute of the hour, meaning a number between 0 and 59
   * @param {number} [second=0] - The second of the minute, meaning a number between 0 and 59
   * @param {number} [millisecond=0] - The millisecond of the second, meaning a number between 0 and 999
   * @example DateTime.local()                                  //~> now
   * @example DateTime.local({ zone: "America/New_York" })      //~> now, in US east coast time
   * @example DateTime.local(2017)                              //~> 2017-01-01T00:00:00
   * @example DateTime.local(2017, 3)                           //~> 2017-03-01T00:00:00
   * @example DateTime.local(2017, 3, 12, { locale: "fr" })     //~> 2017-03-12T00:00:00, with a French locale
   * @example DateTime.local(2017, 3, 12, 5)                    //~> 2017-03-12T05:00:00
   * @example DateTime.local(2017, 3, 12, 5, { zone: "utc" })   //~> 2017-03-12T05:00:00, in UTC
   * @example DateTime.local(2017, 3, 12, 5, 45)                //~> 2017-03-12T05:45:00
   * @example DateTime.local(2017, 3, 12, 5, 45, 10)            //~> 2017-03-12T05:45:10
   * @example DateTime.local(2017, 3, 12, 5, 45, 10, 765)       //~> 2017-03-12T05:45:10.765
   * @return {DateTime}
   */static local(){const[e,t]=lastOpts(arguments),[n,r,s,i,a,o,u]=t;return quickDT({year:n,month:r,day:s,hour:i,minute:a,second:o,millisecond:u},e)}
/**
   * Create a DateTime in UTC
   * @param {number} [year] - The calendar year. If omitted (as in, call `utc()` with no arguments), the current time will be used
   * @param {number} [month=1] - The month, 1-indexed
   * @param {number} [day=1] - The day of the month
   * @param {number} [hour=0] - The hour of the day, in 24-hour time
   * @param {number} [minute=0] - The minute of the hour, meaning a number between 0 and 59
   * @param {number} [second=0] - The second of the minute, meaning a number between 0 and 59
   * @param {number} [millisecond=0] - The millisecond of the second, meaning a number between 0 and 999
   * @param {Object} options - configuration options for the DateTime
   * @param {string} [options.locale] - a locale to set on the resulting DateTime instance
   * @param {string} [options.outputCalendar] - the output calendar to set on the resulting DateTime instance
   * @param {string} [options.numberingSystem] - the numbering system to set on the resulting DateTime instance
   * @example DateTime.utc()                                              //~> now
   * @example DateTime.utc(2017)                                          //~> 2017-01-01T00:00:00Z
   * @example DateTime.utc(2017, 3)                                       //~> 2017-03-01T00:00:00Z
   * @example DateTime.utc(2017, 3, 12)                                   //~> 2017-03-12T00:00:00Z
   * @example DateTime.utc(2017, 3, 12, 5)                                //~> 2017-03-12T05:00:00Z
   * @example DateTime.utc(2017, 3, 12, 5, 45)                            //~> 2017-03-12T05:45:00Z
   * @example DateTime.utc(2017, 3, 12, 5, 45, { locale: "fr" })          //~> 2017-03-12T05:45:00Z with a French locale
   * @example DateTime.utc(2017, 3, 12, 5, 45, 10)                        //~> 2017-03-12T05:45:10Z
   * @example DateTime.utc(2017, 3, 12, 5, 45, 10, 765, { locale: "fr" }) //~> 2017-03-12T05:45:10.765Z with a French locale
   * @return {DateTime}
   */static utc(){const[e,t]=lastOpts(arguments),[n,r,s,i,a,o,u]=t;e.zone=FixedOffsetZone.utcInstance;return quickDT({year:n,month:r,day:s,hour:i,minute:a,second:o,millisecond:u},e)}
/**
   * Create a DateTime from a JavaScript Date object. Uses the default zone.
   * @param {Date} date - a JavaScript Date object
   * @param {Object} options - configuration options for the DateTime
   * @param {string|Zone} [options.zone='local'] - the zone to place the DateTime into
   * @return {DateTime}
   */static fromJSDate(e,t={}){const n=isDate(e)?e.valueOf():NaN;if(Number.isNaN(n))return DateTime.invalid("invalid input");const r=normalizeZone(t.zone,Settings.defaultZone);return r.isValid?new DateTime({ts:n,zone:r,loc:Locale.fromObject(t)}):DateTime.invalid(unsupportedZone(r))}
/**
   * Create a DateTime from a number of milliseconds since the epoch (meaning since 1 January 1970 00:00:00 UTC). Uses the default zone.
   * @param {number} milliseconds - a number of milliseconds since 1970 UTC
   * @param {Object} options - configuration options for the DateTime
   * @param {string|Zone} [options.zone='local'] - the zone to place the DateTime into
   * @param {string} [options.locale] - a locale to set on the resulting DateTime instance
   * @param {string} options.outputCalendar - the output calendar to set on the resulting DateTime instance
   * @param {string} options.numberingSystem - the numbering system to set on the resulting DateTime instance
   * @return {DateTime}
   */static fromMillis(e,t={}){if(isNumber(e))return e<-Ke||e>Ke?DateTime.invalid("Timestamp out of range"):new DateTime({ts:e,zone:normalizeZone(t.zone,Settings.defaultZone),loc:Locale.fromObject(t)});throw new InvalidArgumentError(`fromMillis requires a numerical input, but received a ${typeof e} with value ${e}`)}
/**
   * Create a DateTime from a number of seconds since the epoch (meaning since 1 January 1970 00:00:00 UTC). Uses the default zone.
   * @param {number} seconds - a number of seconds since 1970 UTC
   * @param {Object} options - configuration options for the DateTime
   * @param {string|Zone} [options.zone='local'] - the zone to place the DateTime into
   * @param {string} [options.locale] - a locale to set on the resulting DateTime instance
   * @param {string} options.outputCalendar - the output calendar to set on the resulting DateTime instance
   * @param {string} options.numberingSystem - the numbering system to set on the resulting DateTime instance
   * @return {DateTime}
   */static fromSeconds(e,t={}){if(isNumber(e))return new DateTime({ts:1e3*e,zone:normalizeZone(t.zone,Settings.defaultZone),loc:Locale.fromObject(t)});throw new InvalidArgumentError("fromSeconds requires a numerical input")}
/**
   * Create a DateTime from a JavaScript object with keys like 'year' and 'hour' with reasonable defaults.
   * @param {Object} obj - the object to create the DateTime from
   * @param {number} obj.year - a year, such as 1987
   * @param {number} obj.month - a month, 1-12
   * @param {number} obj.day - a day of the month, 1-31, depending on the month
   * @param {number} obj.ordinal - day of the year, 1-365 or 366
   * @param {number} obj.weekYear - an ISO week year
   * @param {number} obj.weekNumber - an ISO week number, between 1 and 52 or 53, depending on the year
   * @param {number} obj.weekday - an ISO weekday, 1-7, where 1 is Monday and 7 is Sunday
   * @param {number} obj.hour - hour of the day, 0-23
   * @param {number} obj.minute - minute of the hour, 0-59
   * @param {number} obj.second - second of the minute, 0-59
   * @param {number} obj.millisecond - millisecond of the second, 0-999
   * @param {Object} opts - options for creating this DateTime
   * @param {string|Zone} [opts.zone='local'] - interpret the numbers in the context of a particular zone. Can take any value taken as the first argument to setZone()
   * @param {string} [opts.locale='system's locale'] - a locale to set on the resulting DateTime instance
   * @param {string} opts.outputCalendar - the output calendar to set on the resulting DateTime instance
   * @param {string} opts.numberingSystem - the numbering system to set on the resulting DateTime instance
   * @example DateTime.fromObject({ year: 1982, month: 5, day: 25}).toISODate() //=> '1982-05-25'
   * @example DateTime.fromObject({ year: 1982 }).toISODate() //=> '1982-01-01'
   * @example DateTime.fromObject({ hour: 10, minute: 26, second: 6 }) //~> today at 10:26:06
   * @example DateTime.fromObject({ hour: 10, minute: 26, second: 6 }, { zone: 'utc' }),
   * @example DateTime.fromObject({ hour: 10, minute: 26, second: 6 }, { zone: 'local' })
   * @example DateTime.fromObject({ hour: 10, minute: 26, second: 6 }, { zone: 'America/New_York' })
   * @example DateTime.fromObject({ weekYear: 2016, weekNumber: 2, weekday: 3 }).toISODate() //=> '2016-01-13'
   * @return {DateTime}
   */static fromObject(e,t={}){e=e||{};const n=normalizeZone(t.zone,Settings.defaultZone);if(!n.isValid)return DateTime.invalid(unsupportedZone(n));const r=Settings.now(),s=isUndefined(t.specificOffset)?n.offset(r):t.specificOffset,i=normalizeObject(e,normalizeUnit),a=!isUndefined(i.ordinal),o=!isUndefined(i.year),u=!isUndefined(i.month)||!isUndefined(i.day),l=o||u,c=i.weekYear||i.weekNumber,d=Locale.fromObject(t);if((l||a)&&c)throw new ConflictingSpecificationError("Can't mix weekYear/weekNumber units with year/month/day or ordinals");if(u&&a)throw new ConflictingSpecificationError("Can't mix ordinal dates with month/day");const m=c||i.weekday&&!l;let h,f,y=tsToObj(r,s);if(m){h=rt;f=et;y=gregorianToWeek(y)}else if(a){h=st;f=tt;y=gregorianToOrdinal(y)}else{h=nt;f=Xe}let g=false;for(const e of h){const t=i[e];isUndefined(t)?i[e]=g?f[e]:y[e]:g=true}const p=m?hasInvalidWeekData(i):a?hasInvalidOrdinalData(i):hasInvalidGregorianData(i),T=p||hasInvalidTimeData(i);if(T)return DateTime.invalid(T);const w=m?weekToGregorian(i):a?ordinalToGregorian(i):i,[O,S]=objToTS(w,s,n),v=new DateTime({ts:O,zone:n,o:S,loc:d});return i.weekday&&l&&e.weekday!==v.weekday?DateTime.invalid("mismatched weekday",`you can't specify both a weekday of ${i.weekday} and a date of ${v.toISO()}`):v}
/**
   * Create a DateTime from an ISO 8601 string
   * @param {string} text - the ISO string
   * @param {Object} opts - options to affect the creation
   * @param {string|Zone} [opts.zone='local'] - use this zone if no offset is specified in the input string itself. Will also convert the time to this zone
   * @param {boolean} [opts.setZone=false] - override the zone with a fixed-offset zone specified in the string itself, if it specifies one
   * @param {string} [opts.locale='system's locale'] - a locale to set on the resulting DateTime instance
   * @param {string} [opts.outputCalendar] - the output calendar to set on the resulting DateTime instance
   * @param {string} [opts.numberingSystem] - the numbering system to set on the resulting DateTime instance
   * @example DateTime.fromISO('2016-05-25T09:08:34.123')
   * @example DateTime.fromISO('2016-05-25T09:08:34.123+06:00')
   * @example DateTime.fromISO('2016-05-25T09:08:34.123+06:00', {setZone: true})
   * @example DateTime.fromISO('2016-05-25T09:08:34.123', {zone: 'utc'})
   * @example DateTime.fromISO('2016-W05-4')
   * @return {DateTime}
   */static fromISO(e,t={}){const[n,r]=parseISODate(e);return parseDataToDateTime(n,r,t,"ISO 8601",e)}
/**
   * Create a DateTime from an RFC 2822 string
   * @param {string} text - the RFC 2822 string
   * @param {Object} opts - options to affect the creation
   * @param {string|Zone} [opts.zone='local'] - convert the time to this zone. Since the offset is always specified in the string itself, this has no effect on the interpretation of string, merely the zone the resulting DateTime is expressed in.
   * @param {boolean} [opts.setZone=false] - override the zone with a fixed-offset zone specified in the string itself, if it specifies one
   * @param {string} [opts.locale='system's locale'] - a locale to set on the resulting DateTime instance
   * @param {string} opts.outputCalendar - the output calendar to set on the resulting DateTime instance
   * @param {string} opts.numberingSystem - the numbering system to set on the resulting DateTime instance
   * @example DateTime.fromRFC2822('25 Nov 2016 13:23:12 GMT')
   * @example DateTime.fromRFC2822('Fri, 25 Nov 2016 13:23:12 +0600')
   * @example DateTime.fromRFC2822('25 Nov 2016 13:23 Z')
   * @return {DateTime}
   */static fromRFC2822(e,t={}){const[n,r]=parseRFC2822Date(e);return parseDataToDateTime(n,r,t,"RFC 2822",e)}
/**
   * Create a DateTime from an HTTP header date
   * @see https://www.w3.org/Protocols/rfc2616/rfc2616-sec3.html#sec3.3.1
   * @param {string} text - the HTTP header date
   * @param {Object} opts - options to affect the creation
   * @param {string|Zone} [opts.zone='local'] - convert the time to this zone. Since HTTP dates are always in UTC, this has no effect on the interpretation of string, merely the zone the resulting DateTime is expressed in.
   * @param {boolean} [opts.setZone=false] - override the zone with the fixed-offset zone specified in the string. For HTTP dates, this is always UTC, so this option is equivalent to setting the `zone` option to 'utc', but this option is included for consistency with similar methods.
   * @param {string} [opts.locale='system's locale'] - a locale to set on the resulting DateTime instance
   * @param {string} opts.outputCalendar - the output calendar to set on the resulting DateTime instance
   * @param {string} opts.numberingSystem - the numbering system to set on the resulting DateTime instance
   * @example DateTime.fromHTTP('Sun, 06 Nov 1994 08:49:37 GMT')
   * @example DateTime.fromHTTP('Sunday, 06-Nov-94 08:49:37 GMT')
   * @example DateTime.fromHTTP('Sun Nov  6 08:49:37 1994')
   * @return {DateTime}
   */static fromHTTP(e,t={}){const[n,r]=parseHTTPDate(e);return parseDataToDateTime(n,r,t,"HTTP",t)}
/**
   * Create a DateTime from an input string and format string.
   * Defaults to en-US if no locale has been specified, regardless of the system's locale. For a table of tokens and their interpretations, see [here](https://moment.github.io/luxon/#/parsing?id=table-of-tokens).
   * @param {string} text - the string to parse
   * @param {string} fmt - the format the string is expected to be in (see the link below for the formats)
   * @param {Object} opts - options to affect the creation
   * @param {string|Zone} [opts.zone='local'] - use this zone if no offset is specified in the input string itself. Will also convert the DateTime to this zone
   * @param {boolean} [opts.setZone=false] - override the zone with a zone specified in the string itself, if it specifies one
   * @param {string} [opts.locale='en-US'] - a locale string to use when parsing. Will also set the DateTime to this locale
   * @param {string} opts.numberingSystem - the numbering system to use when parsing. Will also set the resulting DateTime to this numbering system
   * @param {string} opts.outputCalendar - the output calendar to set on the resulting DateTime instance
   * @return {DateTime}
   */static fromFormat(e,t,n={}){if(isUndefined(e)||isUndefined(t))throw new InvalidArgumentError("fromFormat requires an input string and a format");const{locale:r=null,numberingSystem:s=null}=n,i=Locale.fromOpts({locale:r,numberingSystem:s,defaultToEN:true}),[a,o,u,l]=parseFromTokens(i,e,t);return l?DateTime.invalid(l):parseDataToDateTime(a,o,n,`format ${t}`,e,u)}
/**
   * @deprecated use fromFormat instead
   */static fromString(e,t,n={}){return DateTime.fromFormat(e,t,n)}
/**
   * Create a DateTime from a SQL date, time, or datetime
   * Defaults to en-US if no locale has been specified, regardless of the system's locale
   * @param {string} text - the string to parse
   * @param {Object} opts - options to affect the creation
   * @param {string|Zone} [opts.zone='local'] - use this zone if no offset is specified in the input string itself. Will also convert the DateTime to this zone
   * @param {boolean} [opts.setZone=false] - override the zone with a zone specified in the string itself, if it specifies one
   * @param {string} [opts.locale='en-US'] - a locale string to use when parsing. Will also set the DateTime to this locale
   * @param {string} opts.numberingSystem - the numbering system to use when parsing. Will also set the resulting DateTime to this numbering system
   * @param {string} opts.outputCalendar - the output calendar to set on the resulting DateTime instance
   * @example DateTime.fromSQL('2017-05-15')
   * @example DateTime.fromSQL('2017-05-15 09:12:34')
   * @example DateTime.fromSQL('2017-05-15 09:12:34.342')
   * @example DateTime.fromSQL('2017-05-15 09:12:34.342+06:00')
   * @example DateTime.fromSQL('2017-05-15 09:12:34.342 America/Los_Angeles')
   * @example DateTime.fromSQL('2017-05-15 09:12:34.342 America/Los_Angeles', { setZone: true })
   * @example DateTime.fromSQL('2017-05-15 09:12:34.342', { zone: 'America/Los_Angeles' })
   * @example DateTime.fromSQL('09:12:34.342')
   * @return {DateTime}
   */static fromSQL(e,t={}){const[n,r]=parseSQL(e);return parseDataToDateTime(n,r,t,"SQL",e)}
/**
   * Create an invalid DateTime.
   * @param {DateTime} reason - simple string of why this DateTime is invalid. Should not contain parameters or anything else data-dependent
   * @param {string} [explanation=null] - longer explanation, may include parameters and other useful debugging information
   * @return {DateTime}
   */static invalid(e,t=null){if(!e)throw new InvalidArgumentError("need to specify a reason the DateTime is invalid");const n=e instanceof Invalid?e:new Invalid(e,t);if(Settings.throwOnInvalid)throw new InvalidDateTimeError(n);return new DateTime({invalid:n})}
/**
   * Check if an object is an instance of DateTime. Works across context boundaries
   * @param {object} o
   * @return {boolean}
   */static isDateTime(e){return e&&e.isLuxonDateTime||false}
/**
   * Produce the format string for a set of options
   * @param formatOpts
   * @param localeOpts
   * @returns {string}
   */static parseFormatForOpts(e,t={}){const n=formatOptsToTokens(e,Locale.fromObject(t));return n?n.map((e=>e?e.val:null)).join(""):null}
/**
   * Produce the the fully expanded format token for the locale
   * Does NOT quote characters, so quoted tokens will not round trip correctly
   * @param fmt
   * @param localeOpts
   * @returns {string}
   */static expandFormat(e,t={}){const n=expandMacroTokens(Formatter.parseFormat(e),Locale.fromObject(t));return n.map((e=>e.val)).join("")}
/**
   * Get the value of unit.
   * @param {string} unit - a unit such as 'minute' or 'day'
   * @example DateTime.local(2017, 7, 4).get('month'); //=> 7
   * @example DateTime.local(2017, 7, 4).get('day'); //=> 4
   * @return {number}
   */
get(e){return this[e]}
/**
   * Returns whether the DateTime is valid. Invalid DateTimes occur when:
   * * The DateTime was created from invalid calendar information, such as the 13th month or February 30
   * * The DateTime was created by an operation on another invalid date
   * @type {boolean}
   */get isValid(){return null===this.invalid}
/**
   * Returns an error code if this DateTime is invalid, or null if the DateTime is valid
   * @type {string}
   */get invalidReason(){return this.invalid?this.invalid.reason:null}
/**
   * Returns an explanation of why this DateTime became invalid, or null if the DateTime is valid
   * @type {string}
   */get invalidExplanation(){return this.invalid?this.invalid.explanation:null}
/**
   * Get the locale of a DateTime, such 'en-GB'. The locale is used when formatting the DateTime
   *
   * @type {string}
   */get locale(){return this.isValid?this.loc.locale:null}
/**
   * Get the numbering system of a DateTime, such 'beng'. The numbering system is used when formatting the DateTime
   *
   * @type {string}
   */get numberingSystem(){return this.isValid?this.loc.numberingSystem:null}
/**
   * Get the output calendar of a DateTime, such 'islamic'. The output calendar is used when formatting the DateTime
   *
   * @type {string}
   */get outputCalendar(){return this.isValid?this.loc.outputCalendar:null}
/**
   * Get the time zone associated with this DateTime.
   * @type {Zone}
   */get zone(){return this._zone}
/**
   * Get the name of the time zone.
   * @type {string}
   */get zoneName(){return this.isValid?this.zone.name:null}
/**
   * Get the year
   * @example DateTime.local(2017, 5, 25).year //=> 2017
   * @type {number}
   */get year(){return this.isValid?this.c.year:NaN}
/**
   * Get the quarter
   * @example DateTime.local(2017, 5, 25).quarter //=> 2
   * @type {number}
   */get quarter(){return this.isValid?Math.ceil(this.c.month/3):NaN}
/**
   * Get the month (1-12).
   * @example DateTime.local(2017, 5, 25).month //=> 5
   * @type {number}
   */get month(){return this.isValid?this.c.month:NaN}
/**
   * Get the day of the month (1-30ish).
   * @example DateTime.local(2017, 5, 25).day //=> 25
   * @type {number}
   */get day(){return this.isValid?this.c.day:NaN}
/**
   * Get the hour of the day (0-23).
   * @example DateTime.local(2017, 5, 25, 9).hour //=> 9
   * @type {number}
   */get hour(){return this.isValid?this.c.hour:NaN}
/**
   * Get the minute of the hour (0-59).
   * @example DateTime.local(2017, 5, 25, 9, 30).minute //=> 30
   * @type {number}
   */get minute(){return this.isValid?this.c.minute:NaN}
/**
   * Get the second of the minute (0-59).
   * @example DateTime.local(2017, 5, 25, 9, 30, 52).second //=> 52
   * @type {number}
   */get second(){return this.isValid?this.c.second:NaN}
/**
   * Get the millisecond of the second (0-999).
   * @example DateTime.local(2017, 5, 25, 9, 30, 52, 654).millisecond //=> 654
   * @type {number}
   */get millisecond(){return this.isValid?this.c.millisecond:NaN}
/**
   * Get the week year
   * @see https://en.wikipedia.org/wiki/ISO_week_date
   * @example DateTime.local(2014, 12, 31).weekYear //=> 2015
   * @type {number}
   */get weekYear(){return this.isValid?possiblyCachedWeekData(this).weekYear:NaN}
/**
   * Get the week number of the week year (1-52ish).
   * @see https://en.wikipedia.org/wiki/ISO_week_date
   * @example DateTime.local(2017, 5, 25).weekNumber //=> 21
   * @type {number}
   */get weekNumber(){return this.isValid?possiblyCachedWeekData(this).weekNumber:NaN}
/**
   * Get the day of the week.
   * 1 is Monday and 7 is Sunday
   * @see https://en.wikipedia.org/wiki/ISO_week_date
   * @example DateTime.local(2014, 11, 31).weekday //=> 4
   * @type {number}
   */get weekday(){return this.isValid?possiblyCachedWeekData(this).weekday:NaN}
/**
   * Get the ordinal (meaning the day of the year)
   * @example DateTime.local(2017, 5, 25).ordinal //=> 145
   * @type {number|DateTime}
   */get ordinal(){return this.isValid?gregorianToOrdinal(this.c).ordinal:NaN}
/**
   * Get the human readable short month name, such as 'Oct'.
   * Defaults to the system's locale if no locale has been specified
   * @example DateTime.local(2017, 10, 30).monthShort //=> Oct
   * @type {string}
   */get monthShort(){return this.isValid?Info.months("short",{locObj:this.loc})[this.month-1]:null}
/**
   * Get the human readable long month name, such as 'October'.
   * Defaults to the system's locale if no locale has been specified
   * @example DateTime.local(2017, 10, 30).monthLong //=> October
   * @type {string}
   */get monthLong(){return this.isValid?Info.months("long",{locObj:this.loc})[this.month-1]:null}
/**
   * Get the human readable short weekday, such as 'Mon'.
   * Defaults to the system's locale if no locale has been specified
   * @example DateTime.local(2017, 10, 30).weekdayShort //=> Mon
   * @type {string}
   */get weekdayShort(){return this.isValid?Info.weekdays("short",{locObj:this.loc})[this.weekday-1]:null}
/**
   * Get the human readable long weekday, such as 'Monday'.
   * Defaults to the system's locale if no locale has been specified
   * @example DateTime.local(2017, 10, 30).weekdayLong //=> Monday
   * @type {string}
   */get weekdayLong(){return this.isValid?Info.weekdays("long",{locObj:this.loc})[this.weekday-1]:null}
/**
   * Get the UTC offset of this DateTime in minutes
   * @example DateTime.now().offset //=> -240
   * @example DateTime.utc().offset //=> 0
   * @type {number}
   */get offset(){return this.isValid?+this.o:NaN}
/**
   * Get the short human name for the zone's current offset, for example "EST" or "EDT".
   * Defaults to the system's locale if no locale has been specified
   * @type {string}
   */get offsetNameShort(){return this.isValid?this.zone.offsetName(this.ts,{format:"short",locale:this.locale}):null}
/**
   * Get the long human name for the zone's current offset, for example "Eastern Standard Time" or "Eastern Daylight Time".
   * Defaults to the system's locale if no locale has been specified
   * @type {string}
   */get offsetNameLong(){return this.isValid?this.zone.offsetName(this.ts,{format:"long",locale:this.locale}):null}
/**
   * Get whether this zone's offset ever changes, as in a DST.
   * @type {boolean}
   */get isOffsetFixed(){return this.isValid?this.zone.isUniversal:null}
/**
   * Get whether the DateTime is in a DST.
   * @type {boolean}
   */get isInDST(){return!this.isOffsetFixed&&(this.offset>this.set({month:1,day:1}).offset||this.offset>this.set({month:5}).offset)}
/**
   * Returns true if this DateTime is in a leap year, false otherwise
   * @example DateTime.local(2016).isInLeapYear //=> true
   * @example DateTime.local(2013).isInLeapYear //=> false
   * @type {boolean}
   */get isInLeapYear(){return isLeapYear(this.year)}
/**
   * Returns the number of days in this DateTime's month
   * @example DateTime.local(2016, 2).daysInMonth //=> 29
   * @example DateTime.local(2016, 3).daysInMonth //=> 31
   * @type {number}
   */get daysInMonth(){return daysInMonth(this.year,this.month)}
/**
   * Returns the number of days in this DateTime's year
   * @example DateTime.local(2016).daysInYear //=> 366
   * @example DateTime.local(2013).daysInYear //=> 365
   * @type {number}
   */get daysInYear(){return this.isValid?daysInYear(this.year):NaN}
/**
   * Returns the number of weeks in this DateTime's year
   * @see https://en.wikipedia.org/wiki/ISO_week_date
   * @example DateTime.local(2004).weeksInWeekYear //=> 53
   * @example DateTime.local(2013).weeksInWeekYear //=> 52
   * @type {number}
   */get weeksInWeekYear(){return this.isValid?weeksInWeekYear(this.weekYear):NaN}
/**
   * Returns the resolved Intl options for this DateTime.
   * This is useful in understanding the behavior of formatting methods
   * @param {Object} opts - the same options as toLocaleString
   * @return {Object}
   */resolvedLocaleOptions(e={}){const{locale:t,numberingSystem:n,calendar:r}=Formatter.create(this.loc.clone(e),e).resolvedOptions(this);return{locale:t,numberingSystem:n,outputCalendar:r}}
/**
   * "Set" the DateTime's zone to UTC. Returns a newly-constructed DateTime.
   *
   * Equivalent to {@link DateTime#setZone}('utc')
   * @param {number} [offset=0] - optionally, an offset from UTC in minutes
   * @param {Object} [opts={}] - options to pass to `setZone()`
   * @return {DateTime}
   */
toUTC(e=0,t={}){return this.setZone(FixedOffsetZone.instance(e),t)}toLocal(){return this.setZone(Settings.defaultZone)}
/**
   * "Set" the DateTime's zone to specified zone. Returns a newly-constructed DateTime.
   *
   * By default, the setter keeps the underlying time the same (as in, the same timestamp), but the new instance will report different local times and consider DSTs when making computations, as with {@link DateTime#plus}. You may wish to use {@link DateTime#toLocal} and {@link DateTime#toUTC} which provide simple convenience wrappers for commonly used zones.
   * @param {string|Zone} [zone='local'] - a zone identifier. As a string, that can be any IANA zone supported by the host environment, or a fixed-offset name of the form 'UTC+3', or the strings 'local' or 'utc'. You may also supply an instance of a {@link DateTime#Zone} class.
   * @param {Object} opts - options
   * @param {boolean} [opts.keepLocalTime=false] - If true, adjust the underlying time so that the local time stays the same, but in the target zone. You should rarely need this.
   * @return {DateTime}
   */setZone(e,{keepLocalTime:t=false,keepCalendarTime:n=false}={}){e=normalizeZone(e,Settings.defaultZone);if(e.equals(this.zone))return this;if(e.isValid){let r=this.ts;if(t||n){const t=e.offset(this.ts);const n=this.toObject();[r]=objToTS(n,t,e)}return clone(this,{ts:r,zone:e})}return DateTime.invalid(unsupportedZone(e))}
/**
   * "Set" the locale, numberingSystem, or outputCalendar. Returns a newly-constructed DateTime.
   * @param {Object} properties - the properties to set
   * @example DateTime.local(2017, 5, 25).reconfigure({ locale: 'en-GB' })
   * @return {DateTime}
   */reconfigure({locale:e,numberingSystem:t,outputCalendar:n}={}){const r=this.loc.clone({locale:e,numberingSystem:t,outputCalendar:n});return clone(this,{loc:r})}setLocale(e){return this.reconfigure({locale:e})}
/**
   * "Set" the values of specified units. Returns a newly-constructed DateTime.
   * You can only set units with this method; for "setting" metadata, see {@link DateTime#reconfigure} and {@link DateTime#setZone}.
   * @param {Object} values - a mapping of units to numbers
   * @example dt.set({ year: 2017 })
   * @example dt.set({ hour: 8, minute: 30 })
   * @example dt.set({ weekday: 5 })
   * @example dt.set({ year: 2005, ordinal: 234 })
   * @return {DateTime}
   */set(e){if(!this.isValid)return this;const t=normalizeObject(e,normalizeUnit),n=!isUndefined(t.weekYear)||!isUndefined(t.weekNumber)||!isUndefined(t.weekday),r=!isUndefined(t.ordinal),s=!isUndefined(t.year),i=!isUndefined(t.month)||!isUndefined(t.day),a=s||i,o=t.weekYear||t.weekNumber;if((a||r)&&o)throw new ConflictingSpecificationError("Can't mix weekYear/weekNumber units with year/month/day or ordinals");if(i&&r)throw new ConflictingSpecificationError("Can't mix ordinal dates with month/day");let u;if(n)u=weekToGregorian({...gregorianToWeek(this.c),...t});else if(isUndefined(t.ordinal)){u={...this.toObject(),...t};isUndefined(t.day)&&(u.day=Math.min(daysInMonth(u.year,u.month),u.day))}else u=ordinalToGregorian({...gregorianToOrdinal(this.c),...t});const[l,c]=objToTS(u,this.o,this.zone);return clone(this,{ts:l,o:c})}
/**
   * Add a period of time to this DateTime and return the resulting DateTime
   *
   * Adding hours, minutes, seconds, or milliseconds increases the timestamp by the right number of milliseconds. Adding days, months, or years shifts the calendar, accounting for DSTs and leap years along the way. Thus, `dt.plus({ hours: 24 })` may result in a different time than `dt.plus({ days: 1 })` if there's a DST shift in between.
   * @param {Duration|Object|number} duration - The amount to add. Either a Luxon Duration, a number of milliseconds, the object argument to Duration.fromObject()
   * @example DateTime.now().plus(123) //~> in 123 milliseconds
   * @example DateTime.now().plus({ minutes: 15 }) //~> in 15 minutes
   * @example DateTime.now().plus({ days: 1 }) //~> this time tomorrow
   * @example DateTime.now().plus({ days: -1 }) //~> this time yesterday
   * @example DateTime.now().plus({ hours: 3, minutes: 13 }) //~> in 3 hr, 13 min
   * @example DateTime.now().plus(Duration.fromObject({ hours: 3, minutes: 13 })) //~> in 3 hr, 13 min
   * @return {DateTime}
   */plus(e){if(!this.isValid)return this;const t=Duration.fromDurationLike(e);return clone(this,adjustTime(this,t))}
/**
   * Subtract a period of time to this DateTime and return the resulting DateTime
   * See {@link DateTime#plus}
   * @param {Duration|Object|number} duration - The amount to subtract. Either a Luxon Duration, a number of milliseconds, the object argument to Duration.fromObject()
   @return {DateTime}
   */minus(e){if(!this.isValid)return this;const t=Duration.fromDurationLike(e).negate();return clone(this,adjustTime(this,t))}
/**
   * "Set" this DateTime to the beginning of a unit of time.
   * @param {string} unit - The unit to go to the beginning of. Can be 'year', 'quarter', 'month', 'week', 'day', 'hour', 'minute', 'second', or 'millisecond'.
   * @example DateTime.local(2014, 3, 3).startOf('month').toISODate(); //=> '2014-03-01'
   * @example DateTime.local(2014, 3, 3).startOf('year').toISODate(); //=> '2014-01-01'
   * @example DateTime.local(2014, 3, 3).startOf('week').toISODate(); //=> '2014-03-03', weeks always start on Mondays
   * @example DateTime.local(2014, 3, 3, 5, 30).startOf('day').toISOTime(); //=> '00:00.000-05:00'
   * @example DateTime.local(2014, 3, 3, 5, 30).startOf('hour').toISOTime(); //=> '05:00:00.000-05:00'
   * @return {DateTime}
   */startOf(e){if(!this.isValid)return this;const t={},n=Duration.normalizeUnit(e);switch(n){case"years":t.month=1;case"quarters":case"months":t.day=1;case"weeks":case"days":t.hour=0;case"hours":t.minute=0;case"minutes":t.second=0;case"seconds":t.millisecond=0;break;case"milliseconds":break}"weeks"===n&&(t.weekday=1);if("quarters"===n){const e=Math.ceil(this.month/3);t.month=3*(e-1)+1}return this.set(t)}
/**
   * "Set" this DateTime to the end (meaning the last millisecond) of a unit of time
   * @param {string} unit - The unit to go to the end of. Can be 'year', 'quarter', 'month', 'week', 'day', 'hour', 'minute', 'second', or 'millisecond'.
   * @example DateTime.local(2014, 3, 3).endOf('month').toISO(); //=> '2014-03-31T23:59:59.999-05:00'
   * @example DateTime.local(2014, 3, 3).endOf('year').toISO(); //=> '2014-12-31T23:59:59.999-05:00'
   * @example DateTime.local(2014, 3, 3).endOf('week').toISO(); // => '2014-03-09T23:59:59.999-05:00', weeks start on Mondays
   * @example DateTime.local(2014, 3, 3, 5, 30).endOf('day').toISO(); //=> '2014-03-03T23:59:59.999-05:00'
   * @example DateTime.local(2014, 3, 3, 5, 30).endOf('hour').toISO(); //=> '2014-03-03T05:59:59.999-05:00'
   * @return {DateTime}
   */endOf(e){return this.isValid?this.plus({[e]:1}).startOf(e).minus(1):this}
/**
   * Returns a string representation of this DateTime formatted according to the specified format string.
   * **You may not want this.** See {@link DateTime#toLocaleString} for a more flexible formatting tool. For a table of tokens and their interpretations, see [here](https://moment.github.io/luxon/#/formatting?id=table-of-tokens).
   * Defaults to en-US if no locale has been specified, regardless of the system's locale.
   * @param {string} fmt - the format string
   * @param {Object} opts - opts to override the configuration options on this DateTime
   * @example DateTime.now().toFormat('yyyy LLL dd') //=> '2017 Apr 22'
   * @example DateTime.now().setLocale('fr').toFormat('yyyy LLL dd') //=> '2017 avr. 22'
   * @example DateTime.now().toFormat('yyyy LLL dd', { locale: "fr" }) //=> '2017 avr. 22'
   * @example DateTime.now().toFormat("HH 'hours and' mm 'minutes'") //=> '20 hours and 55 minutes'
   * @return {string}
   */
toFormat(e,t={}){return this.isValid?Formatter.create(this.loc.redefaultToEN(t)).formatDateTimeFromString(this,e):Qe}
/**
   * Returns a localized string representing this date. Accepts the same options as the Intl.DateTimeFormat constructor and any presets defined by Luxon, such as `DateTime.DATE_FULL` or `DateTime.TIME_SIMPLE`.
   * The exact behavior of this method is browser-specific, but in general it will return an appropriate representation
   * of the DateTime in the assigned locale.
   * Defaults to the system's locale if no locale has been specified
   * @see https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DateTimeFormat
   * @param formatOpts {Object} - Intl.DateTimeFormat constructor options and configuration options
   * @param {Object} opts - opts to override the configuration options on this DateTime
   * @example DateTime.now().toLocaleString(); //=> 4/20/2017
   * @example DateTime.now().setLocale('en-gb').toLocaleString(); //=> '20/04/2017'
   * @example DateTime.now().toLocaleString(DateTime.DATE_FULL); //=> 'April 20, 2017'
   * @example DateTime.now().toLocaleString(DateTime.DATE_FULL, { locale: 'fr' }); //=> '28 août 2022'
   * @example DateTime.now().toLocaleString(DateTime.TIME_SIMPLE); //=> '11:32 AM'
   * @example DateTime.now().toLocaleString(DateTime.DATETIME_SHORT); //=> '4/20/2017, 11:32 AM'
   * @example DateTime.now().toLocaleString({ weekday: 'long', month: 'long', day: '2-digit' }); //=> 'Thursday, April 20'
   * @example DateTime.now().toLocaleString({ weekday: 'short', month: 'short', day: '2-digit', hour: '2-digit', minute: '2-digit' }); //=> 'Thu, Apr 20, 11:27 AM'
   * @example DateTime.now().toLocaleString({ hour: '2-digit', minute: '2-digit', hourCycle: 'h23' }); //=> '11:32'
   * @return {string}
   */toLocaleString(e=r,t={}){return this.isValid?Formatter.create(this.loc.clone(t),e).formatDateTime(this):Qe}
/**
   * Returns an array of format "parts", meaning individual tokens along with metadata. This is allows callers to post-process individual sections of the formatted output.
   * Defaults to the system's locale if no locale has been specified
   * @see https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DateTimeFormat/formatToParts
   * @param opts {Object} - Intl.DateTimeFormat constructor options, same as `toLocaleString`.
   * @example DateTime.now().toLocaleParts(); //=> [
   *                                   //=>   { type: 'day', value: '25' },
   *                                   //=>   { type: 'literal', value: '/' },
   *                                   //=>   { type: 'month', value: '05' },
   *                                   //=>   { type: 'literal', value: '/' },
   *                                   //=>   { type: 'year', value: '1982' }
   *                                   //=> ]
   */toLocaleParts(e={}){return this.isValid?Formatter.create(this.loc.clone(e),e).formatDateTimeParts(this):[]}
/**
   * Returns an ISO 8601-compliant string representation of this DateTime
   * @param {Object} opts - options
   * @param {boolean} [opts.suppressMilliseconds=false] - exclude milliseconds from the format if they're 0
   * @param {boolean} [opts.suppressSeconds=false] - exclude seconds from the format if they're 0
   * @param {boolean} [opts.includeOffset=true] - include the offset, such as 'Z' or '-04:00'
   * @param {boolean} [opts.extendedZone=false] - add the time zone format extension
   * @param {string} [opts.format='extended'] - choose between the basic and extended format
   * @example DateTime.utc(1983, 5, 25).toISO() //=> '1982-05-25T00:00:00.000Z'
   * @example DateTime.now().toISO() //=> '2017-04-22T20:47:05.335-04:00'
   * @example DateTime.now().toISO({ includeOffset: false }) //=> '2017-04-22T20:47:05.335'
   * @example DateTime.now().toISO({ format: 'basic' }) //=> '20170422T204705.335-0400'
   * @return {string}
   */toISO({format:e="extended",suppressSeconds:t=false,suppressMilliseconds:n=false,includeOffset:r=true,extendedZone:s=false}={}){if(!this.isValid)return null;const i="extended"===e;let a=toISODate(this,i);a+="T";a+=toISOTime(this,i,t,n,r,s);return a}
/**
   * Returns an ISO 8601-compliant string representation of this DateTime's date component
   * @param {Object} opts - options
   * @param {string} [opts.format='extended'] - choose between the basic and extended format
   * @example DateTime.utc(1982, 5, 25).toISODate() //=> '1982-05-25'
   * @example DateTime.utc(1982, 5, 25).toISODate({ format: 'basic' }) //=> '19820525'
   * @return {string}
   */toISODate({format:e="extended"}={}){return this.isValid?toISODate(this,"extended"===e):null}toISOWeekDate(){return toTechFormat(this,"kkkk-'W'WW-c")}
/**
   * Returns an ISO 8601-compliant string representation of this DateTime's time component
   * @param {Object} opts - options
   * @param {boolean} [opts.suppressMilliseconds=false] - exclude milliseconds from the format if they're 0
   * @param {boolean} [opts.suppressSeconds=false] - exclude seconds from the format if they're 0
   * @param {boolean} [opts.includeOffset=true] - include the offset, such as 'Z' or '-04:00'
   * @param {boolean} [opts.extendedZone=true] - add the time zone format extension
   * @param {boolean} [opts.includePrefix=false] - include the `T` prefix
   * @param {string} [opts.format='extended'] - choose between the basic and extended format
   * @example DateTime.utc().set({ hour: 7, minute: 34 }).toISOTime() //=> '07:34:19.361Z'
   * @example DateTime.utc().set({ hour: 7, minute: 34, seconds: 0, milliseconds: 0 }).toISOTime({ suppressSeconds: true }) //=> '07:34Z'
   * @example DateTime.utc().set({ hour: 7, minute: 34 }).toISOTime({ format: 'basic' }) //=> '073419.361Z'
   * @example DateTime.utc().set({ hour: 7, minute: 34 }).toISOTime({ includePrefix: true }) //=> 'T07:34:19.361Z'
   * @return {string}
   */toISOTime({suppressMilliseconds:e=false,suppressSeconds:t=false,includeOffset:n=true,includePrefix:r=false,extendedZone:s=false,format:i="extended"}={}){if(!this.isValid)return null;let a=r?"T":"";return a+toISOTime(this,"extended"===i,t,e,n,s)}toRFC2822(){return toTechFormat(this,"EEE, dd LLL yyyy HH:mm:ss ZZZ",false)}toHTTP(){return toTechFormat(this.toUTC(),"EEE, dd LLL yyyy HH:mm:ss 'GMT'")}toSQLDate(){return this.isValid?toISODate(this,true):null}
/**
   * Returns a string representation of this DateTime appropriate for use in SQL Time
   * @param {Object} opts - options
   * @param {boolean} [opts.includeZone=false] - include the zone, such as 'America/New_York'. Overrides includeOffset.
   * @param {boolean} [opts.includeOffset=true] - include the offset, such as 'Z' or '-04:00'
   * @param {boolean} [opts.includeOffsetSpace=true] - include the space between the time and the offset, such as '05:15:16.345 -04:00'
   * @example DateTime.utc().toSQL() //=> '05:15:16.345'
   * @example DateTime.now().toSQL() //=> '05:15:16.345 -04:00'
   * @example DateTime.now().toSQL({ includeOffset: false }) //=> '05:15:16.345'
   * @example DateTime.now().toSQL({ includeZone: false }) //=> '05:15:16.345 America/New_York'
   * @return {string}
   */toSQLTime({includeOffset:e=true,includeZone:t=false,includeOffsetSpace:n=true}={}){let r="HH:mm:ss.SSS";if(t||e){n&&(r+=" ");t?r+="z":e&&(r+="ZZ")}return toTechFormat(this,r,true)}
/**
   * Returns a string representation of this DateTime appropriate for use in SQL DateTime
   * @param {Object} opts - options
   * @param {boolean} [opts.includeZone=false] - include the zone, such as 'America/New_York'. Overrides includeOffset.
   * @param {boolean} [opts.includeOffset=true] - include the offset, such as 'Z' or '-04:00'
   * @param {boolean} [opts.includeOffsetSpace=true] - include the space between the time and the offset, such as '05:15:16.345 -04:00'
   * @example DateTime.utc(2014, 7, 13).toSQL() //=> '2014-07-13 00:00:00.000 Z'
   * @example DateTime.local(2014, 7, 13).toSQL() //=> '2014-07-13 00:00:00.000 -04:00'
   * @example DateTime.local(2014, 7, 13).toSQL({ includeOffset: false }) //=> '2014-07-13 00:00:00.000'
   * @example DateTime.local(2014, 7, 13).toSQL({ includeZone: true }) //=> '2014-07-13 00:00:00.000 America/New_York'
   * @return {string}
   */toSQL(e={}){return this.isValid?`${this.toSQLDate()} ${this.toSQLTime(e)}`:null}toString(){return this.isValid?this.toISO():Qe}valueOf(){return this.toMillis()}toMillis(){return this.isValid?this.ts:NaN}toSeconds(){return this.isValid?this.ts/1e3:NaN}toUnixInteger(){return this.isValid?Math.floor(this.ts/1e3):NaN}toJSON(){return this.toISO()}toBSON(){return this.toJSDate()}
/**
   * Returns a JavaScript object with this DateTime's year, month, day, and so on.
   * @param opts - options for generating the object
   * @param {boolean} [opts.includeConfig=false] - include configuration attributes in the output
   * @example DateTime.now().toObject() //=> { year: 2017, month: 4, day: 22, hour: 20, minute: 49, second: 42, millisecond: 268 }
   * @return {Object}
   */toObject(e={}){if(!this.isValid)return{};const t={...this.c};if(e.includeConfig){t.outputCalendar=this.outputCalendar;t.numberingSystem=this.loc.numberingSystem;t.locale=this.loc.locale}return t}toJSDate(){return new Date(this.isValid?this.ts:NaN)}
/**
   * Return the difference between two DateTimes as a Duration.
   * @param {DateTime} otherDateTime - the DateTime to compare this one to
   * @param {string|string[]} [unit=['milliseconds']] - the unit or array of units (such as 'hours' or 'days') to include in the duration.
   * @param {Object} opts - options that affect the creation of the Duration
   * @param {string} [opts.conversionAccuracy='casual'] - the conversion system to use
   * @example
   * var i1 = DateTime.fromISO('1982-05-25T09:45'),
   *     i2 = DateTime.fromISO('1983-10-14T10:30');
   * i2.diff(i1).toObject() //=> { milliseconds: 43807500000 }
   * i2.diff(i1, 'hours').toObject() //=> { hours: 12168.75 }
   * i2.diff(i1, ['months', 'days']).toObject() //=> { months: 16, days: 19.03125 }
   * i2.diff(i1, ['months', 'days', 'hours']).toObject() //=> { months: 16, days: 19, hours: 0.75 }
   * @return {Duration}
   */
diff(e,t="milliseconds",n={}){if(!this.isValid||!e.isValid)return Duration.invalid("created by diffing an invalid DateTime");const r={locale:this.locale,numberingSystem:this.numberingSystem,...n};const s=maybeArray(t).map(Duration.normalizeUnit),i=e.valueOf()>this.valueOf(),a=i?this:e,o=i?e:this,u=diff(a,o,s,r);return i?u.negate():u}
/**
   * Return the difference between this DateTime and right now.
   * See {@link DateTime#diff}
   * @param {string|string[]} [unit=['milliseconds']] - the unit or units units (such as 'hours' or 'days') to include in the duration
   * @param {Object} opts - options that affect the creation of the Duration
   * @param {string} [opts.conversionAccuracy='casual'] - the conversion system to use
   * @return {Duration}
   */diffNow(e="milliseconds",t={}){return this.diff(DateTime.now(),e,t)}
/**
   * Return an Interval spanning between this DateTime and another DateTime
   * @param {DateTime} otherDateTime - the other end point of the Interval
   * @return {Interval}
   */until(e){return this.isValid?Interval.fromDateTimes(this,e):this}
/**
   * Return whether this DateTime is in the same unit of time as another DateTime.
   * Higher-order units must also be identical for this function to return `true`.
   * Note that time zones are **ignored** in this comparison, which compares the **local** calendar time. Use {@link DateTime#setZone} to convert one of the dates if needed.
   * @param {DateTime} otherDateTime - the other DateTime
   * @param {string} unit - the unit of time to check sameness on
   * @example DateTime.now().hasSame(otherDT, 'day'); //~> true if otherDT is in the same current calendar day
   * @return {boolean}
   */hasSame(e,t){if(!this.isValid)return false;const n=e.valueOf();const r=this.setZone(e.zone,{keepLocalTime:true});return r.startOf(t)<=n&&n<=r.endOf(t)}
/**
   * Equality check
   * Two DateTimes are equal if and only if they represent the same millisecond, have the same zone and location, and are both valid.
   * To compare just the millisecond values, use `+dt1 === +dt2`.
   * @param {DateTime} other - the other DateTime
   * @return {boolean}
   */equals(e){return this.isValid&&e.isValid&&this.valueOf()===e.valueOf()&&this.zone.equals(e.zone)&&this.loc.equals(e.loc)}
/**
   * Returns a string representation of a this time relative to now, such as "in two days". Can only internationalize if your
   * platform supports Intl.RelativeTimeFormat. Rounds down by default.
   * @param {Object} options - options that affect the output
   * @param {DateTime} [options.base=DateTime.now()] - the DateTime to use as the basis to which this time is compared. Defaults to now.
   * @param {string} [options.style="long"] - the style of units, must be "long", "short", or "narrow"
   * @param {string|string[]} options.unit - use a specific unit or array of units; if omitted, or an array, the method will pick the best unit. Use an array or one of "years", "quarters", "months", "weeks", "days", "hours", "minutes", or "seconds"
   * @param {boolean} [options.round=true] - whether to round the numbers in the output.
   * @param {number} [options.padding=0] - padding in milliseconds. This allows you to round up the result if it fits inside the threshold. Don't use in combination with {round: false} because the decimal output will include the padding.
   * @param {string} options.locale - override the locale of this DateTime
   * @param {string} options.numberingSystem - override the numberingSystem of this DateTime. The Intl system may choose not to honor this
   * @example DateTime.now().plus({ days: 1 }).toRelative() //=> "in 1 day"
   * @example DateTime.now().setLocale("es").toRelative({ days: 1 }) //=> "dentro de 1 día"
   * @example DateTime.now().plus({ days: 1 }).toRelative({ locale: "fr" }) //=> "dans 23 heures"
   * @example DateTime.now().minus({ days: 2 }).toRelative() //=> "2 days ago"
   * @example DateTime.now().minus({ days: 2 }).toRelative({ unit: "hours" }) //=> "48 hours ago"
   * @example DateTime.now().minus({ hours: 36 }).toRelative({ round: false }) //=> "1.5 days ago"
   */toRelative(e={}){if(!this.isValid)return null;const t=e.base||DateTime.fromObject({},{zone:this.zone}),n=e.padding?this<t?-e.padding:e.padding:0;let r=["years","months","days","hours","minutes","seconds"];let s=e.unit;if(Array.isArray(e.unit)){r=e.unit;s=void 0}return diffRelative(t,this.plus(n),{...e,numeric:"always",units:r,unit:s})}
/**
   * Returns a string representation of this date relative to today, such as "yesterday" or "next month".
   * Only internationalizes on platforms that supports Intl.RelativeTimeFormat.
   * @param {Object} options - options that affect the output
   * @param {DateTime} [options.base=DateTime.now()] - the DateTime to use as the basis to which this time is compared. Defaults to now.
   * @param {string} options.locale - override the locale of this DateTime
   * @param {string} options.unit - use a specific unit; if omitted, the method will pick the unit. Use one of "years", "quarters", "months", "weeks", or "days"
   * @param {string} options.numberingSystem - override the numberingSystem of this DateTime. The Intl system may choose not to honor this
   * @example DateTime.now().plus({ days: 1 }).toRelativeCalendar() //=> "tomorrow"
   * @example DateTime.now().setLocale("es").plus({ days: 1 }).toRelative() //=> ""mañana"
   * @example DateTime.now().plus({ days: 1 }).toRelativeCalendar({ locale: "fr" }) //=> "demain"
   * @example DateTime.now().minus({ days: 2 }).toRelativeCalendar() //=> "2 days ago"
   */toRelativeCalendar(e={}){return this.isValid?diffRelative(e.base||DateTime.fromObject({},{zone:this.zone}),this,{...e,numeric:"auto",units:["years","months","days"],calendary:true}):null}
/**
   * Return the min of several date times
   * @param {...DateTime} dateTimes - the DateTimes from which to choose the minimum
   * @return {DateTime} the min DateTime, or undefined if called with no argument
   */static min(...e){if(!e.every(DateTime.isDateTime))throw new InvalidArgumentError("min requires all arguments be DateTimes");return bestBy(e,(e=>e.valueOf()),Math.min)}
/**
   * Return the max of several date times
   * @param {...DateTime} dateTimes - the DateTimes from which to choose the maximum
   * @return {DateTime} the max DateTime, or undefined if called with no argument
   */static max(...e){if(!e.every(DateTime.isDateTime))throw new InvalidArgumentError("max requires all arguments be DateTimes");return bestBy(e,(e=>e.valueOf()),Math.max)}
/**
   * Explain how a string would be parsed by fromFormat()
   * @param {string} text - the string to parse
   * @param {string} fmt - the format the string is expected to be in (see description)
   * @param {Object} options - options taken by fromFormat()
   * @return {Object}
   */
static fromFormatExplain(e,t,n={}){const{locale:r=null,numberingSystem:s=null}=n,i=Locale.fromOpts({locale:r,numberingSystem:s,defaultToEN:true});return explainFromTokens(i,e,t)}
/**
   * @deprecated use fromFormatExplain instead
   */static fromStringExplain(e,t,n={}){return DateTime.fromFormatExplain(e,t,n)}
/**
   * {@link DateTime#toLocaleString} format like 10/14/1983
   * @type {Object}
   */
static get DATE_SHORT(){return r}
/**
   * {@link DateTime#toLocaleString} format like 'Oct 14, 1983'
   * @type {Object}
   */static get DATE_MED(){return s}
/**
   * {@link DateTime#toLocaleString} format like 'Fri, Oct 14, 1983'
   * @type {Object}
   */static get DATE_MED_WITH_WEEKDAY(){return i}
/**
   * {@link DateTime#toLocaleString} format like 'October 14, 1983'
   * @type {Object}
   */static get DATE_FULL(){return a}
/**
   * {@link DateTime#toLocaleString} format like 'Tuesday, October 14, 1983'
   * @type {Object}
   */static get DATE_HUGE(){return o}
/**
   * {@link DateTime#toLocaleString} format like '09:30 AM'. Only 12-hour if the locale is.
   * @type {Object}
   */static get TIME_SIMPLE(){return u}
/**
   * {@link DateTime#toLocaleString} format like '09:30:23 AM'. Only 12-hour if the locale is.
   * @type {Object}
   */static get TIME_WITH_SECONDS(){return l}
/**
   * {@link DateTime#toLocaleString} format like '09:30:23 AM EDT'. Only 12-hour if the locale is.
   * @type {Object}
   */static get TIME_WITH_SHORT_OFFSET(){return c}
/**
   * {@link DateTime#toLocaleString} format like '09:30:23 AM Eastern Daylight Time'. Only 12-hour if the locale is.
   * @type {Object}
   */static get TIME_WITH_LONG_OFFSET(){return d}
/**
   * {@link DateTime#toLocaleString} format like '09:30', always 24-hour.
   * @type {Object}
   */static get TIME_24_SIMPLE(){return m}
/**
   * {@link DateTime#toLocaleString} format like '09:30:23', always 24-hour.
   * @type {Object}
   */static get TIME_24_WITH_SECONDS(){return h}
/**
   * {@link DateTime#toLocaleString} format like '09:30:23 EDT', always 24-hour.
   * @type {Object}
   */static get TIME_24_WITH_SHORT_OFFSET(){return f}
/**
   * {@link DateTime#toLocaleString} format like '09:30:23 Eastern Daylight Time', always 24-hour.
   * @type {Object}
   */static get TIME_24_WITH_LONG_OFFSET(){return y}
/**
   * {@link DateTime#toLocaleString} format like '10/14/1983, 9:30 AM'. Only 12-hour if the locale is.
   * @type {Object}
   */static get DATETIME_SHORT(){return g}
/**
   * {@link DateTime#toLocaleString} format like '10/14/1983, 9:30:33 AM'. Only 12-hour if the locale is.
   * @type {Object}
   */static get DATETIME_SHORT_WITH_SECONDS(){return p}
/**
   * {@link DateTime#toLocaleString} format like 'Oct 14, 1983, 9:30 AM'. Only 12-hour if the locale is.
   * @type {Object}
   */static get DATETIME_MED(){return T}
/**
   * {@link DateTime#toLocaleString} format like 'Oct 14, 1983, 9:30:33 AM'. Only 12-hour if the locale is.
   * @type {Object}
   */static get DATETIME_MED_WITH_SECONDS(){return w}
/**
   * {@link DateTime#toLocaleString} format like 'Fri, 14 Oct 1983, 9:30 AM'. Only 12-hour if the locale is.
   * @type {Object}
   */static get DATETIME_MED_WITH_WEEKDAY(){return O}
/**
   * {@link DateTime#toLocaleString} format like 'October 14, 1983, 9:30 AM EDT'. Only 12-hour if the locale is.
   * @type {Object}
   */static get DATETIME_FULL(){return S}
/**
   * {@link DateTime#toLocaleString} format like 'October 14, 1983, 9:30:33 AM EDT'. Only 12-hour if the locale is.
   * @type {Object}
   */static get DATETIME_FULL_WITH_SECONDS(){return v}
/**
   * {@link DateTime#toLocaleString} format like 'Friday, October 14, 1983, 9:30 AM Eastern Daylight Time'. Only 12-hour if the locale is.
   * @type {Object}
   */static get DATETIME_HUGE(){return D}
/**
   * {@link DateTime#toLocaleString} format like 'Friday, October 14, 1983, 9:30:33 AM Eastern Daylight Time'. Only 12-hour if the locale is.
   * @type {Object}
   */static get DATETIME_HUGE_WITH_SECONDS(){return I}}function friendlyDateTime(e){if(DateTime.isDateTime(e))return e;if(e&&e.valueOf&&isNumber(e.valueOf()))return DateTime.fromJSDate(e);if(e&&"object"===typeof e)return DateTime.fromObject(e);throw new InvalidArgumentError(`Unknown datetime argument: ${e}, of type ${typeof e}`)}const it="3.3.0";export{DateTime,Duration,FixedOffsetZone,IANAZone,Info,Interval,InvalidZone,Settings,SystemZone,it as VERSION,Zone};

