var e={};Object.defineProperty(e,"__esModule",{value:true});function _defineProperties(e,t){for(var n=0;n<t.length;n++){var r=t[n];r.enumerable=r.enumerable||false;r.configurable=true;"value"in r&&(r.writable=true);Object.defineProperty(e,r.key,r)}}function _createClass(e,t,n){t&&_defineProperties(e.prototype,t);n&&_defineProperties(e,n);return e}function _extends(){_extends=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var n=arguments[t];for(var r in n)Object.prototype.hasOwnProperty.call(n,r)&&(e[r]=n[r])}return e};return _extends.apply(this,arguments)}function _inheritsLoose(e,t){e.prototype=Object.create(t.prototype);e.prototype.constructor=e;_setPrototypeOf(e,t)}function _getPrototypeOf(e){_getPrototypeOf=Object.setPrototypeOf?Object.getPrototypeOf:function _getPrototypeOf(e){return e.__proto__||Object.getPrototypeOf(e)};return _getPrototypeOf(e)}function _setPrototypeOf(e,t){_setPrototypeOf=Object.setPrototypeOf||function _setPrototypeOf(e,t){e.__proto__=t;return e};return _setPrototypeOf(e,t)}function _isNativeReflectConstruct(){if("undefined"===typeof Reflect||!Reflect.construct)return false;if(Reflect.construct.sham)return false;if("function"===typeof Proxy)return true;try{Boolean.prototype.valueOf.call(Reflect.construct(Boolean,[],(function(){})));return true}catch(e){return false}}function _construct(e,t,n){_construct=_isNativeReflectConstruct()?Reflect.construct:function _construct(e,t,n){var r=[null];r.push.apply(r,t);var i=Function.bind.apply(e,r);var a=new i;n&&_setPrototypeOf(a,n.prototype);return a};return _construct.apply(null,arguments)}function _isNativeFunction(e){return-1!==Function.toString.call(e).indexOf("[native code]")}function _wrapNativeSuper(e){var t="function"===typeof Map?new Map:void 0;_wrapNativeSuper=function _wrapNativeSuper(e){if(null===e||!_isNativeFunction(e))return e;if("function"!==typeof e)throw new TypeError("Super expression must either be null or a function");if("undefined"!==typeof t){if(t.has(e))return t.get(e);t.set(e,Wrapper)}function Wrapper(){return _construct(e,arguments,_getPrototypeOf(this).constructor)}Wrapper.prototype=Object.create(e.prototype,{constructor:{value:Wrapper,enumerable:false,writable:true,configurable:true}});return _setPrototypeOf(Wrapper,e)};return _wrapNativeSuper(e)}function _objectWithoutPropertiesLoose(e,t){if(null==e)return{};var n={};var r=Object.keys(e);var i,a;for(a=0;a<r.length;a++){i=r[a];t.indexOf(i)>=0||(n[i]=e[i])}return n}function _unsupportedIterableToArray(e,t){if(e){if("string"===typeof e)return _arrayLikeToArray(e,t);var n=Object.prototype.toString.call(e).slice(8,-1);"Object"===n&&e.constructor&&(n=e.constructor.name);return"Map"===n||"Set"===n?Array.from(e):"Arguments"===n||/^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n)?_arrayLikeToArray(e,t):void 0}}function _arrayLikeToArray(e,t){(null==t||t>e.length)&&(t=e.length);for(var n=0,r=new Array(t);n<t;n++)r[n]=e[n];return r}function _createForOfIteratorHelperLoose(e,t){var n="undefined"!==typeof Symbol&&e[Symbol.iterator]||e["@@iterator"];if(n)return(n=n.call(e)).next.bind(n);if(Array.isArray(e)||(n=_unsupportedIterableToArray(e))||t&&e&&"number"===typeof e.length){n&&(e=n);var r=0;return function(){return r>=e.length?{done:true}:{done:false,value:e[r++]}}}throw new TypeError("Invalid attempt to iterate non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method.")}var t=function(e){_inheritsLoose(LuxonError,e);function LuxonError(){return e.apply(this,arguments)||this}return LuxonError}(_wrapNativeSuper(Error));var n=function(e){_inheritsLoose(InvalidDateTimeError,e);function InvalidDateTimeError(t){return e.call(this,"Invalid DateTime: "+t.toMessage())||this}return InvalidDateTimeError}(t);var r=function(e){_inheritsLoose(InvalidIntervalError,e);function InvalidIntervalError(t){return e.call(this,"Invalid Interval: "+t.toMessage())||this}return InvalidIntervalError}(t);var i=function(e){_inheritsLoose(InvalidDurationError,e);function InvalidDurationError(t){return e.call(this,"Invalid Duration: "+t.toMessage())||this}return InvalidDurationError}(t);var a=function(e){_inheritsLoose(ConflictingSpecificationError,e);function ConflictingSpecificationError(){return e.apply(this,arguments)||this}return ConflictingSpecificationError}(t);var o=function(e){_inheritsLoose(InvalidUnitError,e);function InvalidUnitError(t){return e.call(this,"Invalid unit "+t)||this}return InvalidUnitError}(t);var s=function(e){_inheritsLoose(InvalidArgumentError,e);function InvalidArgumentError(){return e.apply(this,arguments)||this}return InvalidArgumentError}(t);var u=function(e){_inheritsLoose(ZoneIsAbstractError,e);function ZoneIsAbstractError(){return e.call(this,"Zone is an abstract class")||this}return ZoneIsAbstractError}(t);var l="numeric",c="short",f="long";var d={year:l,month:l,day:l};var m={year:l,month:c,day:l};var h={year:l,month:c,day:l,weekday:c};var v={year:l,month:f,day:l};var y={year:l,month:f,day:l,weekday:f};var g={hour:l,minute:l};var p={hour:l,minute:l,second:l};var T={hour:l,minute:l,second:l,timeZoneName:c};var O={hour:l,minute:l,second:l,timeZoneName:f};var w={hour:l,minute:l,hourCycle:"h23"};var S={hour:l,minute:l,second:l,hourCycle:"h23"};var k={hour:l,minute:l,second:l,hourCycle:"h23",timeZoneName:c};var I={hour:l,minute:l,second:l,hourCycle:"h23",timeZoneName:f};var D={year:l,month:l,day:l,hour:l,minute:l};var b={year:l,month:l,day:l,hour:l,minute:l,second:l};var x={year:l,month:c,day:l,hour:l,minute:l};var N={year:l,month:c,day:l,hour:l,minute:l,second:l};var F={year:l,month:c,day:l,weekday:c,hour:l,minute:l};var M={year:l,month:f,day:l,hour:l,minute:l,timeZoneName:c};var E={year:l,month:f,day:l,hour:l,minute:l,second:l,timeZoneName:c};var _={year:l,month:f,day:l,weekday:f,hour:l,minute:l,timeZoneName:f};var Z={year:l,month:f,day:l,weekday:f,hour:l,minute:l,second:l,timeZoneName:f};function isUndefined(e){return"undefined"===typeof e}function isNumber(e){return"number"===typeof e}function isInteger(e){return"number"===typeof e&&e%1===0}function isString(e){return"string"===typeof e}function isDate(e){return"[object Date]"===Object.prototype.toString.call(e)}function hasRelative(){try{return"undefined"!==typeof Intl&&!!Intl.RelativeTimeFormat}catch(e){return false}}function maybeArray(e){return Array.isArray(e)?e:[e]}function bestBy(e,t,n){if(0!==e.length)return e.reduce((function(e,r){var i=[t(r),r];return e&&n(e[0],i[0])===e[0]?e:i}),null)[1]}function pick(e,t){return t.reduce((function(t,n){t[n]=e[n];return t}),{})}function hasOwnProperty(e,t){return Object.prototype.hasOwnProperty.call(e,t)}function integerBetween(e,t,n){return isInteger(e)&&e>=t&&e<=n}function floorMod(e,t){return e-t*Math.floor(e/t)}function padStart(e,t){void 0===t&&(t=2);var n=e<0;var r;r=n?"-"+(""+-e).padStart(t,"0"):(""+e).padStart(t,"0");return r}function parseInteger(e){return isUndefined(e)||null===e||""===e?void 0:parseInt(e,10)}function parseFloating(e){return isUndefined(e)||null===e||""===e?void 0:parseFloat(e)}function parseMillis(e){if(!isUndefined(e)&&null!==e&&""!==e){var t=1e3*parseFloat("0."+e);return Math.floor(t)}}function roundTo(e,t,n){void 0===n&&(n=false);var r=Math.pow(10,t),i=n?Math.trunc:Math.round;return i(e*r)/r}function isLeapYear(e){return e%4===0&&(e%100!==0||e%400===0)}function daysInYear(e){return isLeapYear(e)?366:365}function daysInMonth(e,t){var n=floorMod(t-1,12)+1,r=e+(t-n)/12;return 2===n?isLeapYear(r)?29:28:[31,null,31,30,31,30,31,31,30,31,30,31][n-1]}function objToLocalTS(e){var t=Date.UTC(e.year,e.month-1,e.day,e.hour,e.minute,e.second,e.millisecond);if(e.year<100&&e.year>=0){t=new Date(t);t.setUTCFullYear(t.getUTCFullYear()-1900)}return+t}function weeksInWeekYear(e){var t=(e+Math.floor(e/4)-Math.floor(e/100)+Math.floor(e/400))%7,n=e-1,r=(n+Math.floor(n/4)-Math.floor(n/100)+Math.floor(n/400))%7;return 4===t||3===r?53:52}function untruncateYear(e){return e>99?e:e>60?1900+e:2e3+e}function parseZoneInfo(e,t,n,r){void 0===r&&(r=null);var i=new Date(e),a={hourCycle:"h23",year:"numeric",month:"2-digit",day:"2-digit",hour:"2-digit",minute:"2-digit"};r&&(a.timeZone=r);var o=_extends({timeZoneName:t},a);var s=new Intl.DateTimeFormat(n,o).formatToParts(i).find((function(e){return"timezonename"===e.type.toLowerCase()}));return s?s.value:null}function signedOffset(e,t){var n=parseInt(e,10);Number.isNaN(n)&&(n=0);var r=parseInt(t,10)||0,i=n<0||Object.is(n,-0)?-r:r;return 60*n+i}function asNumber(e){var t=Number(e);if("boolean"===typeof e||""===e||Number.isNaN(t))throw new s("Invalid unit value "+e);return t}function normalizeObject(e,t){var n={};for(var r in e)if(hasOwnProperty(e,r)){var i=e[r];if(void 0===i||null===i)continue;n[t(r)]=asNumber(i)}return n}function formatOffset(e,t){var n=Math.trunc(Math.abs(e/60)),r=Math.trunc(Math.abs(e%60)),i=e>=0?"+":"-";switch(t){case"short":return""+i+padStart(n,2)+":"+padStart(r,2);case"narrow":return""+i+n+(r>0?":"+r:"");case"techie":return""+i+padStart(n,2)+padStart(r,2);default:throw new RangeError("Value format "+t+" is out of range for property format")}}function timeObject(e){return pick(e,["hour","minute","second","millisecond"])}var L=/[A-Za-z_+-]{1,256}(?::?\/[A-Za-z0-9_+-]{1,256}(?:\/[A-Za-z0-9_+-]{1,256})?)?/;var C=["January","February","March","April","May","June","July","August","September","October","November","December"];var V=["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];var A=["J","F","M","A","M","J","J","A","S","O","N","D"];function months(e){switch(e){case"narrow":return[].concat(A);case"short":return[].concat(V);case"long":return[].concat(C);case"numeric":return["1","2","3","4","5","6","7","8","9","10","11","12"];case"2-digit":return["01","02","03","04","05","06","07","08","09","10","11","12"];default:return null}}var U=["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"];var R=["Mon","Tue","Wed","Thu","Fri","Sat","Sun"];var j=["M","T","W","T","F","S","S"];function weekdays(e){switch(e){case"narrow":return[].concat(j);case"short":return[].concat(R);case"long":return[].concat(U);case"numeric":return["1","2","3","4","5","6","7"];default:return null}}var z=["AM","PM"];var P=["Before Christ","Anno Domini"];var q=["BC","AD"];var W=["B","A"];function eras(e){switch(e){case"narrow":return[].concat(W);case"short":return[].concat(q);case"long":return[].concat(P);default:return null}}function meridiemForDateTime(e){return z[e.hour<12?0:1]}function weekdayForDateTime(e,t){return weekdays(t)[e.weekday-1]}function monthForDateTime(e,t){return months(t)[e.month-1]}function eraForDateTime(e,t){return eras(t)[e.year<0?0:1]}function formatRelativeTime(e,t,n,r){void 0===n&&(n="always");void 0===r&&(r=false);var i={years:["year","yr."],quarters:["quarter","qtr."],months:["month","mo."],weeks:["week","wk."],days:["day","day","days"],hours:["hour","hr."],minutes:["minute","min."],seconds:["second","sec."]};var a=-1===["hours","minutes","seconds"].indexOf(e);if("auto"===n&&a){var o="days"===e;switch(t){case 1:return o?"tomorrow":"next "+i[e][0];case-1:return o?"yesterday":"last "+i[e][0];case 0:return o?"today":"this "+i[e][0]}}var s=Object.is(t,-0)||t<0,u=Math.abs(t),l=1===u,c=i[e],f=r?l?c[1]:c[2]||c[1]:l?i[e][0]:e;return s?u+" "+f+" ago":"in "+u+" "+f}function stringifyTokens(e,t){var n="";for(var r,i=_createForOfIteratorHelperLoose(e);!(r=i()).done;){var a=r.value;a.literal?n+=a.val:n+=t(a.val)}return n}var Y={D:d,DD:m,DDD:v,DDDD:y,t:g,tt:p,ttt:T,tttt:O,T:w,TT:S,TTT:k,TTTT:I,f:D,ff:x,fff:M,ffff:_,F:b,FF:N,FFF:E,FFFF:Z};var H=function(){Formatter.create=function create(e,t){void 0===t&&(t={});return new Formatter(e,t)};Formatter.parseFormat=function parseFormat(e){var t=null,n="",r=false;var i=[];for(var a=0;a<e.length;a++){var o=e.charAt(a);if("'"===o){n.length>0&&i.push({literal:r,val:n});t=null;n="";r=!r}else if(r)n+=o;else if(o===t)n+=o;else{n.length>0&&i.push({literal:false,val:n});n=o;t=o}}n.length>0&&i.push({literal:r,val:n});return i};Formatter.macroTokenToFormatOpts=function macroTokenToFormatOpts(e){return Y[e]};function Formatter(e,t){this.opts=t;this.loc=e;this.systemLoc=null}var e=Formatter.prototype;e.formatWithSystemDefault=function formatWithSystemDefault(e,t){null===this.systemLoc&&(this.systemLoc=this.loc.redefaultToSystem());var n=this.systemLoc.dtFormatter(e,_extends({},this.opts,t));return n.format()};e.formatDateTime=function formatDateTime(e,t){void 0===t&&(t={});var n=this.loc.dtFormatter(e,_extends({},this.opts,t));return n.format()};e.formatDateTimeParts=function formatDateTimeParts(e,t){void 0===t&&(t={});var n=this.loc.dtFormatter(e,_extends({},this.opts,t));return n.formatToParts()};e.resolvedOptions=function resolvedOptions(e,t){void 0===t&&(t={});var n=this.loc.dtFormatter(e,_extends({},this.opts,t));return n.resolvedOptions()};e.num=function num(e,t){void 0===t&&(t=0);if(this.opts.forceSimple)return padStart(e,t);var n=_extends({},this.opts);t>0&&(n.padTo=t);return this.loc.numberFormatter(n).format(e)};e.formatDateTimeFromString=function formatDateTimeFromString(e,t){var n=this;var r="en"===this.loc.listingMode(),i=this.loc.outputCalendar&&"gregory"!==this.loc.outputCalendar,a=function string(t,r){return n.loc.extract(e,t,r)},o=function formatOffset(t){return e.isOffsetFixed&&0===e.offset&&t.allowZ?"Z":e.isValid?e.zone.formatOffset(e.ts,t.format):""},s=function meridiem(){return r?meridiemForDateTime(e):a({hour:"numeric",hourCycle:"h12"},"dayperiod")},u=function month(t,n){return r?monthForDateTime(e,t):a(n?{month:t}:{month:t,day:"numeric"},"month")},l=function weekday(t,n){return r?weekdayForDateTime(e,t):a(n?{weekday:t}:{weekday:t,month:"long",day:"numeric"},"weekday")},c=function maybeMacro(t){var r=Formatter.macroTokenToFormatOpts(t);return r?n.formatWithSystemDefault(e,r):t},f=function era(t){return r?eraForDateTime(e,t):a({era:t},"era")},d=function tokenToString(t){switch(t){case"S":return n.num(e.millisecond);case"u":case"SSS":return n.num(e.millisecond,3);case"s":return n.num(e.second);case"ss":return n.num(e.second,2);case"uu":return n.num(Math.floor(e.millisecond/10),2);case"uuu":return n.num(Math.floor(e.millisecond/100));case"m":return n.num(e.minute);case"mm":return n.num(e.minute,2);case"h":return n.num(e.hour%12===0?12:e.hour%12);case"hh":return n.num(e.hour%12===0?12:e.hour%12,2);case"H":return n.num(e.hour);case"HH":return n.num(e.hour,2);case"Z":return o({format:"narrow",allowZ:n.opts.allowZ});case"ZZ":return o({format:"short",allowZ:n.opts.allowZ});case"ZZZ":return o({format:"techie",allowZ:n.opts.allowZ});case"ZZZZ":return e.zone.offsetName(e.ts,{format:"short",locale:n.loc.locale});case"ZZZZZ":return e.zone.offsetName(e.ts,{format:"long",locale:n.loc.locale});case"z":return e.zoneName;case"a":return s();case"d":return i?a({day:"numeric"},"day"):n.num(e.day);case"dd":return i?a({day:"2-digit"},"day"):n.num(e.day,2);case"c":return n.num(e.weekday);case"ccc":return l("short",true);case"cccc":return l("long",true);case"ccccc":return l("narrow",true);case"E":return n.num(e.weekday);case"EEE":return l("short",false);case"EEEE":return l("long",false);case"EEEEE":return l("narrow",false);case"L":return i?a({month:"numeric",day:"numeric"},"month"):n.num(e.month);case"LL":return i?a({month:"2-digit",day:"numeric"},"month"):n.num(e.month,2);case"LLL":return u("short",true);case"LLLL":return u("long",true);case"LLLLL":return u("narrow",true);case"M":return i?a({month:"numeric"},"month"):n.num(e.month);case"MM":return i?a({month:"2-digit"},"month"):n.num(e.month,2);case"MMM":return u("short",false);case"MMMM":return u("long",false);case"MMMMM":return u("narrow",false);case"y":return i?a({year:"numeric"},"year"):n.num(e.year);case"yy":return i?a({year:"2-digit"},"year"):n.num(e.year.toString().slice(-2),2);case"yyyy":return i?a({year:"numeric"},"year"):n.num(e.year,4);case"yyyyyy":return i?a({year:"numeric"},"year"):n.num(e.year,6);case"G":return f("short");case"GG":return f("long");case"GGGGG":return f("narrow");case"kk":return n.num(e.weekYear.toString().slice(-2),2);case"kkkk":return n.num(e.weekYear,4);case"W":return n.num(e.weekNumber);case"WW":return n.num(e.weekNumber,2);case"o":return n.num(e.ordinal);case"ooo":return n.num(e.ordinal,3);case"q":return n.num(e.quarter);case"qq":return n.num(e.quarter,2);case"X":return n.num(Math.floor(e.ts/1e3));case"x":return n.num(e.ts);default:return c(t)}};return stringifyTokens(Formatter.parseFormat(t),d)};e.formatDurationFromString=function formatDurationFromString(e,t){var n=this;var r=function tokenToField(e){switch(e[0]){case"S":return"millisecond";case"s":return"second";case"m":return"minute";case"h":return"hour";case"d":return"day";case"w":return"week";case"M":return"month";case"y":return"year";default:return null}},i=function tokenToString(e){return function(t){var i=r(t);return i?n.num(e.get(i),t.length):t}},a=Formatter.parseFormat(t),o=a.reduce((function(e,t){var n=t.literal,r=t.val;return n?e:e.concat(r)}),[]),s=e.shiftTo.apply(e,o.map(r).filter((function(e){return e})));return stringifyTokens(a,i(s))};return Formatter}();var J=function(){function Invalid(e,t){this.reason=e;this.explanation=t}var e=Invalid.prototype;e.toMessage=function toMessage(){return this.explanation?this.reason+": "+this.explanation:this.reason};return Invalid}();var G=function(){function Zone(){}var e=Zone.prototype;
/**
   * Returns the offset's common name (such as EST) at the specified timestamp
   * @abstract
   * @param {number} ts - Epoch milliseconds for which to get the name
   * @param {Object} opts - Options to affect the format
   * @param {string} opts.format - What style of offset to return. Accepts 'long' or 'short'.
   * @param {string} opts.locale - What locale to return the offset name in.
   * @return {string}
   */e.offsetName=function offsetName(e,t){throw new u}
/**
   * Returns the offset's value as a string
   * @abstract
   * @param {number} ts - Epoch milliseconds for which to get the offset
   * @param {string} format - What style of offset to return.
   *                          Accepts 'narrow', 'short', or 'techie'. Returning '+6', '+06:00', or '+0600' respectively
   * @return {string}
   */;e.formatOffset=function formatOffset(e,t){throw new u}
/**
   * Return the offset in minutes for this zone at the specified timestamp.
   * @abstract
   * @param {number} ts - Epoch milliseconds for which to compute the offset
   * @return {number}
   */;e.offset=function offset(e){throw new u}
/**
   * Return whether this Zone is equal to another zone
   * @abstract
   * @param {Zone} otherZone - the zone to compare
   * @return {boolean}
   */;e.equals=function equals(e){throw new u}
/**
   * Return whether this Zone is valid.
   * @abstract
   * @type {boolean}
   */;_createClass(Zone,[{key:"type",get:
/**
     * The type of zone
     * @abstract
     * @type {string}
     */
function get(){throw new u}
/**
     * The name of this zone.
     * @abstract
     * @type {string}
     */},{key:"name",get:function get(){throw new u}},{key:"ianaName",get:function get(){return this.name}
/**
     * Returns whether the offset is known to be fixed for the whole year.
     * @abstract
     * @type {boolean}
     */},{key:"isUniversal",get:function get(){throw new u}},{key:"isValid",get:function get(){throw new u}}]);return Zone}();var $=null;var B=function(e){_inheritsLoose(SystemZone,e);function SystemZone(){return e.apply(this,arguments)||this}var t=SystemZone.prototype;t.offsetName=function offsetName(e,t){var n=t.format,r=t.locale;return parseZoneInfo(e,n,r)};t.formatOffset=function formatOffset$1(e,t){return formatOffset(this.offset(e),t)};t.offset=function offset(e){return-new Date(e).getTimezoneOffset()};t.equals=function equals(e){return"system"===e.type};_createClass(SystemZone,[{key:"type",get:function get(){return"system"}},{key:"name",get:function get(){return(new Intl.DateTimeFormat).resolvedOptions().timeZone}},{key:"isUniversal",get:function get(){return false}},{key:"isValid",get:function get(){return true}}],[{key:"instance",get:function get(){null===$&&($=new SystemZone);return $}}]);return SystemZone}(G);var Q={};function makeDTF(e){Q[e]||(Q[e]=new Intl.DateTimeFormat("en-US",{hour12:false,timeZone:e,year:"numeric",month:"2-digit",day:"2-digit",hour:"2-digit",minute:"2-digit",second:"2-digit",era:"short"}));return Q[e]}var K={year:0,month:1,day:2,era:3,hour:4,minute:5,second:6};function hackyOffset(e,t){var n=e.format(t).replace(/\u200E/g,""),r=/(\d+)\/(\d+)\/(\d+) (AD|BC),? (\d+):(\d+):(\d+)/.exec(n),i=r[1],a=r[2],o=r[3],s=r[4],u=r[5],l=r[6],c=r[7];return[o,i,a,s,u,l,c]}function partsOffset(e,t){var n=e.formatToParts(t);var r=[];for(var i=0;i<n.length;i++){var a=n[i],o=a.type,s=a.value;var u=K[o];"era"===o?r[u]=s:isUndefined(u)||(r[u]=parseInt(s,10))}return r}var X={};var ee=function(e){_inheritsLoose(IANAZone,e);
/**
   * @param {string} name - Zone name
   * @return {IANAZone}
   */IANAZone.create=function create(e){X[e]||(X[e]=new IANAZone(e));return X[e]};IANAZone.resetCache=function resetCache(){X={};Q={}}
/**
   * Returns whether the provided string is a valid specifier. This only checks the string's format, not that the specifier identifies a known zone; see isValidZone for that.
   * @param {string} s - The string to check validity on
   * @example IANAZone.isValidSpecifier("America/New_York") //=> true
   * @example IANAZone.isValidSpecifier("Sport~~blorp") //=> false
   * @deprecated This method returns false for some valid IANA names. Use isValidZone instead.
   * @return {boolean}
   */;IANAZone.isValidSpecifier=function isValidSpecifier(e){return this.isValidZone(e)}
/**
   * Returns whether the provided string identifies a real zone
   * @param {string} zone - The string to check
   * @example IANAZone.isValidZone("America/New_York") //=> true
   * @example IANAZone.isValidZone("Fantasia/Castle") //=> false
   * @example IANAZone.isValidZone("Sport~~blorp") //=> false
   * @return {boolean}
   */;IANAZone.isValidZone=function isValidZone(e){if(!e)return false;try{new Intl.DateTimeFormat("en-US",{timeZone:e}).format();return true}catch(e){return false}};function IANAZone(t){var n;n=e.call(this)||this;n.zoneName=t;n.valid=IANAZone.isValidZone(t);return n}var t=IANAZone.prototype;t.offsetName=function offsetName(e,t){var n=t.format,r=t.locale;return parseZoneInfo(e,n,r,this.name)};t.formatOffset=function formatOffset$1(e,t){return formatOffset(this.offset(e),t)};t.offset=function offset(e){var t=new Date(e);if(isNaN(t))return NaN;var n=makeDTF(this.name);var r=n.formatToParts?partsOffset(n,t):hackyOffset(n,t),i=r[0],a=r[1],o=r[2],s=r[3],u=r[4],l=r[5],c=r[6];"BC"===s&&(i=1-Math.abs(i));var f=24===u?0:u;var d=objToLocalTS({year:i,month:a,day:o,hour:f,minute:l,second:c,millisecond:0});var m=+t;var h=m%1e3;m-=h>=0?h:1e3+h;return(d-m)/6e4};t.equals=function equals(e){return"iana"===e.type&&e.name===this.name};_createClass(IANAZone,[{key:"type",get:function get(){return"iana"}},{key:"name",get:function get(){return this.zoneName}},{key:"isUniversal",get:function get(){return false}},{key:"isValid",get:function get(){return this.valid}}]);return IANAZone}(G);var te=null;var ne=function(e){_inheritsLoose(FixedOffsetZone,e);
/**
   * Get an instance with a specified offset
   * @param {number} offset - The offset in minutes
   * @return {FixedOffsetZone}
   */FixedOffsetZone.instance=function instance(e){return 0===e?FixedOffsetZone.utcInstance:new FixedOffsetZone(e)}
/**
   * Get an instance of FixedOffsetZone from a UTC offset string, like "UTC+6"
   * @param {string} s - The offset string to parse
   * @example FixedOffsetZone.parseSpecifier("UTC+6")
   * @example FixedOffsetZone.parseSpecifier("UTC+06")
   * @example FixedOffsetZone.parseSpecifier("UTC-6:00")
   * @return {FixedOffsetZone}
   */;FixedOffsetZone.parseSpecifier=function parseSpecifier(e){if(e){var t=e.match(/^utc(?:([+-]\d{1,2})(?::(\d{2}))?)?$/i);if(t)return new FixedOffsetZone(signedOffset(t[1],t[2]))}return null};function FixedOffsetZone(t){var n;n=e.call(this)||this;n.fixed=t;return n}var t=FixedOffsetZone.prototype;t.offsetName=function offsetName(){return this.name};t.formatOffset=function formatOffset$1(e,t){return formatOffset(this.fixed,t)};t.offset=function offset(){return this.fixed};t.equals=function equals(e){return"fixed"===e.type&&e.fixed===this.fixed};_createClass(FixedOffsetZone,[{key:"type",get:function get(){return"fixed"}},{key:"name",get:function get(){return 0===this.fixed?"UTC":"UTC"+formatOffset(this.fixed,"narrow")}},{key:"ianaName",get:function get(){return 0===this.fixed?"Etc/UTC":"Etc/GMT"+formatOffset(-this.fixed,"narrow")}},{key:"isUniversal",get:function get(){return true}},{key:"isValid",get:function get(){return true}}],[{key:"utcInstance",get:function get(){null===te&&(te=new FixedOffsetZone(0));return te}}]);return FixedOffsetZone}(G);var re=function(e){_inheritsLoose(InvalidZone,e);function InvalidZone(t){var n;n=e.call(this)||this;n.zoneName=t;return n}var t=InvalidZone.prototype;t.offsetName=function offsetName(){return null};t.formatOffset=function formatOffset(){return""};t.offset=function offset(){return NaN};t.equals=function equals(){return false};_createClass(InvalidZone,[{key:"type",get:function get(){return"invalid"}},{key:"name",get:function get(){return this.zoneName}},{key:"isUniversal",get:function get(){return false}},{key:"isValid",get:function get(){return false}}]);return InvalidZone}(G);function normalizeZone(e,t){if(isUndefined(e)||null===e)return t;if(e instanceof G)return e;if(isString(e)){var n=e.toLowerCase();return"local"===n||"system"===n?t:"utc"===n||"gmt"===n?ne.utcInstance:ne.parseSpecifier(n)||ee.create(e)}return isNumber(e)?ne.instance(e):"object"===typeof e&&e.offset&&"number"===typeof e.offset?e:new re(e)}var ie,ae=function now(){return Date.now()},oe="system",se=null,ue=null,le=null;var ce=function(){function Settings(){}Settings.resetCaches=function resetCaches(){we.resetCache();ee.resetCache()};_createClass(Settings,null,[{key:"now",get:
/**
     * Get the callback for returning the current timestamp.
     * @type {function}
     */
function get(){return ae}
/**
     * Set the callback for returning the current timestamp.
     * The function should return a number, which will be interpreted as an Epoch millisecond count
     * @type {function}
     * @example Settings.now = () => Date.now() + 3000 // pretend it is 3 seconds in the future
     * @example Settings.now = () => 0 // always pretend it's Jan 1, 1970 at midnight in UTC time
     */,set:function set(e){ae=e}
/**
     * Set the default time zone to create DateTimes in. Does not affect existing instances.
     * Use the value "system" to reset this value to the system's time zone.
     * @type {string}
     */},{key:"defaultZone",get:
/**
     * Get the default time zone object currently used to create DateTimes. Does not affect existing instances.
     * The default value is the system's time zone (the one set on the machine that runs this code).
     * @type {Zone}
     */
function get(){return normalizeZone(oe,B.instance)}
/**
     * Get the default locale to create DateTimes with. Does not affect existing instances.
     * @type {string}
     */,set:function set(e){oe=e}},{key:"defaultLocale",get:function get(){return se}
/**
     * Set the default locale to create DateTimes with. Does not affect existing instances.
     * @type {string}
     */,set:function set(e){se=e}
/**
     * Get the default numbering system to create DateTimes with. Does not affect existing instances.
     * @type {string}
     */},{key:"defaultNumberingSystem",get:function get(){return ue}
/**
     * Set the default numbering system to create DateTimes with. Does not affect existing instances.
     * @type {string}
     */,set:function set(e){ue=e}
/**
     * Get the default output calendar to create DateTimes with. Does not affect existing instances.
     * @type {string}
     */},{key:"defaultOutputCalendar",get:function get(){return le}
/**
     * Set the default output calendar to create DateTimes with. Does not affect existing instances.
     * @type {string}
     */,set:function set(e){le=e}
/**
     * Get whether Luxon will throw when it encounters invalid DateTimes, Durations, or Intervals
     * @type {boolean}
     */},{key:"throwOnInvalid",get:function get(){return ie}
/**
     * Set whether Luxon will throw when it encounters invalid DateTimes, Durations, or Intervals
     * @type {boolean}
     */,set:function set(e){ie=e}}]);return Settings}();var fe=["base"],de=["padTo","floor"];var me={};function getCachedLF(e,t){void 0===t&&(t={});var n=JSON.stringify([e,t]);var r=me[n];if(!r){r=new Intl.ListFormat(e,t);me[n]=r}return r}var he={};function getCachedDTF(e,t){void 0===t&&(t={});var n=JSON.stringify([e,t]);var r=he[n];if(!r){r=new Intl.DateTimeFormat(e,t);he[n]=r}return r}var ve={};function getCachedINF(e,t){void 0===t&&(t={});var n=JSON.stringify([e,t]);var r=ve[n];if(!r){r=new Intl.NumberFormat(e,t);ve[n]=r}return r}var ye={};function getCachedRTF(e,t){void 0===t&&(t={});var n=t;n.base;var r=_objectWithoutPropertiesLoose(n,fe);var i=JSON.stringify([e,r]);var a=ye[i];if(!a){a=new Intl.RelativeTimeFormat(e,t);ye[i]=a}return a}var ge=null;function systemLocale(){if(ge)return ge;ge=(new Intl.DateTimeFormat).resolvedOptions().locale;return ge}function parseLocaleString(e){var t=e.indexOf("-u-");if(-1===t)return[e];var n;var r=e.substring(0,t);try{n=getCachedDTF(e).resolvedOptions()}catch(e){n=getCachedDTF(r).resolvedOptions()}var i=n,a=i.numberingSystem,o=i.calendar;return[r,a,o]}function intlConfigString(e,t,n){if(n||t){e+="-u";n&&(e+="-ca-"+n);t&&(e+="-nu-"+t);return e}return e}function mapMonths(e){var t=[];for(var n=1;n<=12;n++){var r=Et.utc(2016,n,1);t.push(e(r))}return t}function mapWeekdays(e){var t=[];for(var n=1;n<=7;n++){var r=Et.utc(2016,11,13+n);t.push(e(r))}return t}function listStuff(e,t,n,r,i){var a=e.listingMode(n);return"error"===a?null:"en"===a?r(t):i(t)}function supportsFastNumbers(e){return(!e.numberingSystem||"latn"===e.numberingSystem)&&("latn"===e.numberingSystem||!e.locale||e.locale.startsWith("en")||"latn"===new Intl.DateTimeFormat(e.intl).resolvedOptions().numberingSystem)}var pe=function(){function PolyNumberFormatter(e,t,n){this.padTo=n.padTo||0;this.floor=n.floor||false;n.padTo;n.floor;var r=_objectWithoutPropertiesLoose(n,de);if(!t||Object.keys(r).length>0){var i=_extends({useGrouping:false},n);n.padTo>0&&(i.minimumIntegerDigits=n.padTo);this.inf=getCachedINF(e,i)}}var e=PolyNumberFormatter.prototype;e.format=function format(e){if(this.inf){var t=this.floor?Math.floor(e):e;return this.inf.format(t)}var n=this.floor?Math.floor(e):roundTo(e,3);return padStart(n,this.padTo)};return PolyNumberFormatter}();var Te=function(){function PolyDateFormatter(e,t,n){this.opts=n;var r;if(e.zone.isUniversal){var i=e.offset/60*-1;var a=i>=0?"Etc/GMT+"+i:"Etc/GMT"+i;if(0!==e.offset&&ee.create(a).valid){r=a;this.dt=e}else{r="UTC";n.timeZoneName?this.dt=e:this.dt=0===e.offset?e:Et.fromMillis(e.ts+60*e.offset*1e3)}}else if("system"===e.zone.type)this.dt=e;else{this.dt=e;r=e.zone.name}var o=_extends({},this.opts);r&&(o.timeZone=r);this.dtf=getCachedDTF(t,o)}var e=PolyDateFormatter.prototype;e.format=function format(){return this.dtf.format(this.dt.toJSDate())};e.formatToParts=function formatToParts(){return this.dtf.formatToParts(this.dt.toJSDate())};e.resolvedOptions=function resolvedOptions(){return this.dtf.resolvedOptions()};return PolyDateFormatter}();var Oe=function(){function PolyRelFormatter(e,t,n){this.opts=_extends({style:"long"},n);!t&&hasRelative()&&(this.rtf=getCachedRTF(e,n))}var e=PolyRelFormatter.prototype;e.format=function format(e,t){return this.rtf?this.rtf.format(e,t):formatRelativeTime(t,e,this.opts.numeric,"long"!==this.opts.style)};e.formatToParts=function formatToParts(e,t){return this.rtf?this.rtf.formatToParts(e,t):[]};return PolyRelFormatter}();var we=function(){Locale.fromOpts=function fromOpts(e){return Locale.create(e.locale,e.numberingSystem,e.outputCalendar,e.defaultToEN)};Locale.create=function create(e,t,n,r){void 0===r&&(r=false);var i=e||ce.defaultLocale;var a=i||(r?"en-US":systemLocale());var o=t||ce.defaultNumberingSystem;var s=n||ce.defaultOutputCalendar;return new Locale(a,o,s,i)};Locale.resetCache=function resetCache(){ge=null;he={};ve={};ye={}};Locale.fromObject=function fromObject(e){var t=void 0===e?{}:e,n=t.locale,r=t.numberingSystem,i=t.outputCalendar;return Locale.create(n,r,i)};function Locale(e,t,n,r){var i=parseLocaleString(e),a=i[0],o=i[1],s=i[2];this.locale=a;this.numberingSystem=t||o||null;this.outputCalendar=n||s||null;this.intl=intlConfigString(this.locale,this.numberingSystem,this.outputCalendar);this.weekdaysCache={format:{},standalone:{}};this.monthsCache={format:{},standalone:{}};this.meridiemCache=null;this.eraCache={};this.specifiedLocale=r;this.fastNumbersCached=null}var e=Locale.prototype;e.listingMode=function listingMode(){var e=this.isEnglish();var t=(null===this.numberingSystem||"latn"===this.numberingSystem)&&(null===this.outputCalendar||"gregory"===this.outputCalendar);return e&&t?"en":"intl"};e.clone=function clone(e){return e&&0!==Object.getOwnPropertyNames(e).length?Locale.create(e.locale||this.specifiedLocale,e.numberingSystem||this.numberingSystem,e.outputCalendar||this.outputCalendar,e.defaultToEN||false):this};e.redefaultToEN=function redefaultToEN(e){void 0===e&&(e={});return this.clone(_extends({},e,{defaultToEN:true}))};e.redefaultToSystem=function redefaultToSystem(e){void 0===e&&(e={});return this.clone(_extends({},e,{defaultToEN:false}))};e.months=function months$1(e,t,n){var r=this;void 0===t&&(t=false);void 0===n&&(n=true);return listStuff(this,e,n,months,(function(){var n=t?{month:e,day:"numeric"}:{month:e},i=t?"format":"standalone";r.monthsCache[i][e]||(r.monthsCache[i][e]=mapMonths((function(e){return r.extract(e,n,"month")})));return r.monthsCache[i][e]}))};e.weekdays=function weekdays$1(e,t,n){var r=this;void 0===t&&(t=false);void 0===n&&(n=true);return listStuff(this,e,n,weekdays,(function(){var n=t?{weekday:e,year:"numeric",month:"long",day:"numeric"}:{weekday:e},i=t?"format":"standalone";r.weekdaysCache[i][e]||(r.weekdaysCache[i][e]=mapWeekdays((function(e){return r.extract(e,n,"weekday")})));return r.weekdaysCache[i][e]}))};e.meridiems=function meridiems$1(e){var t=this;void 0===e&&(e=true);return listStuff(this,void 0,e,(function(){return z}),(function(){if(!t.meridiemCache){var e={hour:"numeric",hourCycle:"h12"};t.meridiemCache=[Et.utc(2016,11,13,9),Et.utc(2016,11,13,19)].map((function(n){return t.extract(n,e,"dayperiod")}))}return t.meridiemCache}))};e.eras=function eras$1(e,t){var n=this;void 0===t&&(t=true);return listStuff(this,e,t,eras,(function(){var t={era:e};n.eraCache[e]||(n.eraCache[e]=[Et.utc(-40,1,1),Et.utc(2017,1,1)].map((function(e){return n.extract(e,t,"era")})));return n.eraCache[e]}))};e.extract=function extract(e,t,n){var r=this.dtFormatter(e,t),i=r.formatToParts(),a=i.find((function(e){return e.type.toLowerCase()===n}));return a?a.value:null};e.numberFormatter=function numberFormatter(e){void 0===e&&(e={});return new pe(this.intl,e.forceSimple||this.fastNumbers,e)};e.dtFormatter=function dtFormatter(e,t){void 0===t&&(t={});return new Te(e,this.intl,t)};e.relFormatter=function relFormatter(e){void 0===e&&(e={});return new Oe(this.intl,this.isEnglish(),e)};e.listFormatter=function listFormatter(e){void 0===e&&(e={});return getCachedLF(this.intl,e)};e.isEnglish=function isEnglish(){return"en"===this.locale||"en-us"===this.locale.toLowerCase()||new Intl.DateTimeFormat(this.intl).resolvedOptions().locale.startsWith("en-us")};e.equals=function equals(e){return this.locale===e.locale&&this.numberingSystem===e.numberingSystem&&this.outputCalendar===e.outputCalendar};_createClass(Locale,[{key:"fastNumbers",get:function get(){null==this.fastNumbersCached&&(this.fastNumbersCached=supportsFastNumbers(this));return this.fastNumbersCached}}]);return Locale}();function combineRegexes(){for(var e=arguments.length,t=new Array(e),n=0;n<e;n++)t[n]=arguments[n];var r=t.reduce((function(e,t){return e+t.source}),"");return RegExp("^"+r+"$")}function combineExtractors(){for(var e=arguments.length,t=new Array(e),n=0;n<e;n++)t[n]=arguments[n];return function(e){return t.reduce((function(t,n){var r=t[0],i=t[1],a=t[2];var o=n(e,a),s=o[0],u=o[1],l=o[2];return[_extends({},r,s),u||i,l]}),[{},null,1]).slice(0,2)}}function parse(e){if(null==e)return[null,null];for(var t=arguments.length,n=new Array(t>1?t-1:0),r=1;r<t;r++)n[r-1]=arguments[r];for(var i=0,a=n;i<a.length;i++){var o=a[i],s=o[0],u=o[1];var l=s.exec(e);if(l)return u(l)}return[null,null]}function simpleParse(){for(var e=arguments.length,t=new Array(e),n=0;n<e;n++)t[n]=arguments[n];return function(e,n){var r={};var i;for(i=0;i<t.length;i++)r[t[i]]=parseInteger(e[n+i]);return[r,null,n+i]}}var Se=/(?:(Z)|([+-]\d\d)(?::?(\d\d))?)/;var ke="(?:"+Se.source+"?(?:\\[("+L.source+")\\])?)?";var Ie=/(\d\d)(?::?(\d\d)(?::?(\d\d)(?:[.,](\d{1,30}))?)?)?/;var De=RegExp(""+Ie.source+ke);var be=RegExp("(?:T"+De.source+")?");var xe=/([+-]\d{6}|\d{4})(?:-?(\d\d)(?:-?(\d\d))?)?/;var Ne=/(\d{4})-?W(\d\d)(?:-?(\d))?/;var Fe=/(\d{4})-?(\d{3})/;var Me=simpleParse("weekYear","weekNumber","weekDay");var Ee=simpleParse("year","ordinal");var _e=/(\d{4})-(\d\d)-(\d\d)/;var Ze=RegExp(Ie.source+" ?(?:"+Se.source+"|("+L.source+"))?");var Le=RegExp("(?: "+Ze.source+")?");function int(e,t,n){var r=e[t];return isUndefined(r)?n:parseInteger(r)}function extractISOYmd(e,t){var n={year:int(e,t),month:int(e,t+1,1),day:int(e,t+2,1)};return[n,null,t+3]}function extractISOTime(e,t){var n={hours:int(e,t,0),minutes:int(e,t+1,0),seconds:int(e,t+2,0),milliseconds:parseMillis(e[t+3])};return[n,null,t+4]}function extractISOOffset(e,t){var n=!e[t]&&!e[t+1],r=signedOffset(e[t+1],e[t+2]),i=n?null:ne.instance(r);return[{},i,t+3]}function extractIANAZone(e,t){var n=e[t]?ee.create(e[t]):null;return[{},n,t+1]}var Ce=RegExp("^T?"+Ie.source+"$");var Ve=/^-?P(?:(?:(-?\d{1,9}(?:\.\d{1,9})?)Y)?(?:(-?\d{1,9}(?:\.\d{1,9})?)M)?(?:(-?\d{1,9}(?:\.\d{1,9})?)W)?(?:(-?\d{1,9}(?:\.\d{1,9})?)D)?(?:T(?:(-?\d{1,9}(?:\.\d{1,9})?)H)?(?:(-?\d{1,9}(?:\.\d{1,9})?)M)?(?:(-?\d{1,20})(?:[.,](-?\d{1,9}))?S)?)?)$/;function extractISODuration(e){var t=e[0],n=e[1],r=e[2],i=e[3],a=e[4],o=e[5],s=e[6],u=e[7],l=e[8];var c="-"===t[0];var f=u&&"-"===u[0];var d=function maybeNegate(e,t){void 0===t&&(t=false);return void 0!==e&&(t||e&&c)?-e:e};return[{years:d(parseFloating(n)),months:d(parseFloating(r)),weeks:d(parseFloating(i)),days:d(parseFloating(a)),hours:d(parseFloating(o)),minutes:d(parseFloating(s)),seconds:d(parseFloating(u),"-0"===u),milliseconds:d(parseMillis(l),f)}]}var Ae={GMT:0,EDT:-240,EST:-300,CDT:-300,CST:-360,MDT:-360,MST:-420,PDT:-420,PST:-480};function fromStrings(e,t,n,r,i,a,o){var s={year:2===t.length?untruncateYear(parseInteger(t)):parseInteger(t),month:V.indexOf(n)+1,day:parseInteger(r),hour:parseInteger(i),minute:parseInteger(a)};o&&(s.second=parseInteger(o));e&&(s.weekday=e.length>3?U.indexOf(e)+1:R.indexOf(e)+1);return s}var Ue=/^(?:(Mon|Tue|Wed|Thu|Fri|Sat|Sun),\s)?(\d{1,2})\s(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s(\d{2,4})\s(\d\d):(\d\d)(?::(\d\d))?\s(?:(UT|GMT|[ECMP][SD]T)|([Zz])|(?:([+-]\d\d)(\d\d)))$/;function extractRFC2822(e){var t=e[1],n=e[2],r=e[3],i=e[4],a=e[5],o=e[6],s=e[7],u=e[8],l=e[9],c=e[10],f=e[11],d=fromStrings(t,i,r,n,a,o,s);var m;m=u?Ae[u]:l?0:signedOffset(c,f);return[d,new ne(m)]}function preprocessRFC2822(e){return e.replace(/\([^)]*\)|[\n\t]/g," ").replace(/(\s\s+)/g," ").trim()}var Re=/^(Mon|Tue|Wed|Thu|Fri|Sat|Sun), (\d\d) (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) (\d{4}) (\d\d):(\d\d):(\d\d) GMT$/,je=/^(Monday|Tuesday|Wedsday|Thursday|Friday|Saturday|Sunday), (\d\d)-(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)-(\d\d) (\d\d):(\d\d):(\d\d) GMT$/,ze=/^(Mon|Tue|Wed|Thu|Fri|Sat|Sun) (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) ( \d|\d\d) (\d\d):(\d\d):(\d\d) (\d{4})$/;function extractRFC1123Or850(e){var t=e[1],n=e[2],r=e[3],i=e[4],a=e[5],o=e[6],s=e[7],u=fromStrings(t,i,r,n,a,o,s);return[u,ne.utcInstance]}function extractASCII(e){var t=e[1],n=e[2],r=e[3],i=e[4],a=e[5],o=e[6],s=e[7],u=fromStrings(t,s,n,r,i,a,o);return[u,ne.utcInstance]}var Pe=combineRegexes(xe,be);var qe=combineRegexes(Ne,be);var We=combineRegexes(Fe,be);var Ye=combineRegexes(De);var He=combineExtractors(extractISOYmd,extractISOTime,extractISOOffset,extractIANAZone);var Je=combineExtractors(Me,extractISOTime,extractISOOffset,extractIANAZone);var Ge=combineExtractors(Ee,extractISOTime,extractISOOffset,extractIANAZone);var $e=combineExtractors(extractISOTime,extractISOOffset,extractIANAZone);function parseISODate(e){return parse(e,[Pe,He],[qe,Je],[We,Ge],[Ye,$e])}function parseRFC2822Date(e){return parse(preprocessRFC2822(e),[Ue,extractRFC2822])}function parseHTTPDate(e){return parse(e,[Re,extractRFC1123Or850],[je,extractRFC1123Or850],[ze,extractASCII])}function parseISODuration(e){return parse(e,[Ve,extractISODuration])}var Be=combineExtractors(extractISOTime);function parseISOTimeOnly(e){return parse(e,[Ce,Be])}var Qe=combineRegexes(_e,Le);var Ke=combineRegexes(Ze);var Xe=combineExtractors(extractISOTime,extractISOOffset,extractIANAZone);function parseSQL(e){return parse(e,[Qe,He],[Ke,Xe])}var et="Invalid Duration";var tt={weeks:{days:7,hours:168,minutes:10080,seconds:604800,milliseconds:6048e5},days:{hours:24,minutes:1440,seconds:86400,milliseconds:864e5},hours:{minutes:60,seconds:3600,milliseconds:36e5},minutes:{seconds:60,milliseconds:6e4},seconds:{milliseconds:1e3}},nt=_extends({years:{quarters:4,months:12,weeks:52,days:365,hours:8760,minutes:525600,seconds:31536e3,milliseconds:31536e6},quarters:{months:3,weeks:13,days:91,hours:2184,minutes:131040,seconds:7862400,milliseconds:78624e5},months:{weeks:4,days:30,hours:720,minutes:43200,seconds:2592e3,milliseconds:2592e6}},tt),rt=365.2425,it=30.436875,at=_extends({years:{quarters:4,months:12,weeks:rt/7,days:rt,hours:24*rt,minutes:24*rt*60,seconds:24*rt*60*60,milliseconds:24*rt*60*60*1e3},quarters:{months:3,weeks:rt/28,days:rt/4,hours:24*rt/4,minutes:24*rt*60/4,seconds:24*rt*60*60/4,milliseconds:24*rt*60*60*1e3/4},months:{weeks:it/7,days:it,hours:24*it,minutes:24*it*60,seconds:24*it*60*60,milliseconds:24*it*60*60*1e3}},tt);var ot=["years","quarters","months","weeks","days","hours","minutes","seconds","milliseconds"];var st=ot.slice(0).reverse();function clone$1(e,t,n){void 0===n&&(n=false);var r={values:n?t.values:_extends({},e.values,t.values||{}),loc:e.loc.clone(t.loc),conversionAccuracy:t.conversionAccuracy||e.conversionAccuracy};return new ut(r)}function antiTrunc(e){return e<0?Math.floor(e):Math.ceil(e)}function convert(e,t,n,r,i){var a=e[i][n],o=t[n]/a,s=Math.sign(o)===Math.sign(r[i]),u=!s&&0!==r[i]&&Math.abs(o)<=1?antiTrunc(o):Math.trunc(o);r[i]+=u;t[n]-=u*a}function normalizeValues(e,t){st.reduce((function(n,r){if(isUndefined(t[r]))return n;n&&convert(e,t,n,t,r);return r}),null)}var ut=function(){function Duration(e){var t="longterm"===e.conversionAccuracy||false;this.values=e.values;this.loc=e.loc||we.create();this.conversionAccuracy=t?"longterm":"casual";this.invalid=e.invalid||null;this.matrix=t?at:nt;this.isLuxonDuration=true}
/**
   * Create Duration from a number of milliseconds.
   * @param {number} count of milliseconds
   * @param {Object} opts - options for parsing
   * @param {string} [opts.locale='en-US'] - the locale to use
   * @param {string} opts.numberingSystem - the numbering system to use
   * @param {string} [opts.conversionAccuracy='casual'] - the conversion system to use
   * @return {Duration}
   */Duration.fromMillis=function fromMillis(e,t){return Duration.fromObject({milliseconds:e},t)}
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
   * @param {string} [opts.conversionAccuracy='casual'] - the conversion system to use
   * @return {Duration}
   */;Duration.fromObject=function fromObject(e,t){void 0===t&&(t={});if(null==e||"object"!==typeof e)throw new s("Duration.fromObject: argument expected to be an object, got "+(null===e?"null":typeof e));return new Duration({values:normalizeObject(e,Duration.normalizeUnit),loc:we.fromObject(t),conversionAccuracy:t.conversionAccuracy})}
/**
   * Create a Duration from DurationLike.
   *
   * @param {Object | number | Duration} durationLike
   * One of:
   * - object with keys like 'years' and 'hours'.
   * - number representing milliseconds
   * - Duration instance
   * @return {Duration}
   */;Duration.fromDurationLike=function fromDurationLike(e){if(isNumber(e))return Duration.fromMillis(e);if(Duration.isDuration(e))return e;if("object"===typeof e)return Duration.fromObject(e);throw new s("Unknown duration argument "+e+" of type "+typeof e)}
/**
   * Create a Duration from an ISO 8601 duration string.
   * @param {string} text - text to parse
   * @param {Object} opts - options for parsing
   * @param {string} [opts.locale='en-US'] - the locale to use
   * @param {string} opts.numberingSystem - the numbering system to use
   * @param {string} [opts.conversionAccuracy='casual'] - the conversion system to use
   * @see https://en.wikipedia.org/wiki/ISO_8601#Durations
   * @example Duration.fromISO('P3Y6M1W4DT12H30M5S').toObject() //=> { years: 3, months: 6, weeks: 1, days: 4, hours: 12, minutes: 30, seconds: 5 }
   * @example Duration.fromISO('PT23H').toObject() //=> { hours: 23 }
   * @example Duration.fromISO('P5Y3M').toObject() //=> { years: 5, months: 3 }
   * @return {Duration}
   */;Duration.fromISO=function fromISO(e,t){var n=parseISODuration(e),r=n[0];return r?Duration.fromObject(r,t):Duration.invalid("unparsable",'the input "'+e+"\" can't be parsed as ISO 8601")}
/**
   * Create a Duration from an ISO 8601 time string.
   * @param {string} text - text to parse
   * @param {Object} opts - options for parsing
   * @param {string} [opts.locale='en-US'] - the locale to use
   * @param {string} opts.numberingSystem - the numbering system to use
   * @param {string} [opts.conversionAccuracy='casual'] - the conversion system to use
   * @see https://en.wikipedia.org/wiki/ISO_8601#Times
   * @example Duration.fromISOTime('11:22:33.444').toObject() //=> { hours: 11, minutes: 22, seconds: 33, milliseconds: 444 }
   * @example Duration.fromISOTime('11:00').toObject() //=> { hours: 11, minutes: 0, seconds: 0 }
   * @example Duration.fromISOTime('T11:00').toObject() //=> { hours: 11, minutes: 0, seconds: 0 }
   * @example Duration.fromISOTime('1100').toObject() //=> { hours: 11, minutes: 0, seconds: 0 }
   * @example Duration.fromISOTime('T1100').toObject() //=> { hours: 11, minutes: 0, seconds: 0 }
   * @return {Duration}
   */;Duration.fromISOTime=function fromISOTime(e,t){var n=parseISOTimeOnly(e),r=n[0];return r?Duration.fromObject(r,t):Duration.invalid("unparsable",'the input "'+e+"\" can't be parsed as ISO 8601")}
/**
   * Create an invalid Duration.
   * @param {string} reason - simple string of why this datetime is invalid. Should not contain parameters or anything else data-dependent
   * @param {string} [explanation=null] - longer explanation, may include parameters and other useful debugging information
   * @return {Duration}
   */;Duration.invalid=function invalid(e,t){void 0===t&&(t=null);if(!e)throw new s("need to specify a reason the Duration is invalid");var invalid=e instanceof J?e:new J(e,t);if(ce.throwOnInvalid)throw new i(invalid);return new Duration({invalid:invalid})};Duration.normalizeUnit=function normalizeUnit(e){var t={year:"years",years:"years",quarter:"quarters",quarters:"quarters",month:"months",months:"months",week:"weeks",weeks:"weeks",day:"days",days:"days",hour:"hours",hours:"hours",minute:"minutes",minutes:"minutes",second:"seconds",seconds:"seconds",millisecond:"milliseconds",milliseconds:"milliseconds"}[e?e.toLowerCase():e];if(!t)throw new o(e);return t}
/**
   * Check if an object is a Duration. Works across context boundaries
   * @param {object} o
   * @return {boolean}
   */;Duration.isDuration=function isDuration(e){return e&&e.isLuxonDuration||false}
/**
   * Get  the locale of a Duration, such 'en-GB'
   * @type {string}
   */;var e=Duration.prototype;
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
   * * The duration will be converted to the set of units in the format string using {@link Duration#shiftTo} and the Durations's conversion accuracy setting.
   * @param {string} fmt - the format string
   * @param {Object} opts - options
   * @param {boolean} [opts.floor=true] - floor numerical values
   * @example Duration.fromObject({ years: 1, days: 6, seconds: 2 }).toFormat("y d s") //=> "1 6 2"
   * @example Duration.fromObject({ years: 1, days: 6, seconds: 2 }).toFormat("yy dd sss") //=> "01 06 002"
   * @example Duration.fromObject({ years: 1, days: 6, seconds: 2 }).toFormat("M S") //=> "12 518402000"
   * @return {string}
   */e.toFormat=function toFormat(e,t){void 0===t&&(t={});var n=_extends({},t,{floor:false!==t.round&&false!==t.floor});return this.isValid?H.create(this.loc,n).formatDurationFromString(this,e):et}
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
   */;e.toHuman=function toHuman(e){var t=this;void 0===e&&(e={});var n=ot.map((function(n){var r=t.values[n];return isUndefined(r)?null:t.loc.numberFormatter(_extends({style:"unit",unitDisplay:"long"},e,{unit:n.slice(0,-1)})).format(r)})).filter((function(e){return e}));return this.loc.listFormatter(_extends({type:"conjunction",style:e.listStyle||"narrow"},e)).format(n)};e.toObject=function toObject(){return this.isValid?_extends({},this.values):{}};e.toISO=function toISO(){if(!this.isValid)return null;var e="P";0!==this.years&&(e+=this.years+"Y");0===this.months&&0===this.quarters||(e+=this.months+3*this.quarters+"M");0!==this.weeks&&(e+=this.weeks+"W");0!==this.days&&(e+=this.days+"D");0===this.hours&&0===this.minutes&&0===this.seconds&&0===this.milliseconds||(e+="T");0!==this.hours&&(e+=this.hours+"H");0!==this.minutes&&(e+=this.minutes+"M");0===this.seconds&&0===this.milliseconds||(e+=roundTo(this.seconds+this.milliseconds/1e3,3)+"S");"P"===e&&(e+="T0S");return e}
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
   */;e.toISOTime=function toISOTime(e){void 0===e&&(e={});if(!this.isValid)return null;var t=this.toMillis();if(t<0||t>=864e5)return null;e=_extends({suppressMilliseconds:false,suppressSeconds:false,includePrefix:false,format:"extended"},e);var n=this.shiftTo("hours","minutes","seconds","milliseconds");var r="basic"===e.format?"hhmm":"hh:mm";if(!e.suppressSeconds||0!==n.seconds||0!==n.milliseconds){r+="basic"===e.format?"ss":":ss";e.suppressMilliseconds&&0===n.milliseconds||(r+=".SSS")}var i=n.toFormat(r);e.includePrefix&&(i="T"+i);return i};e.toJSON=function toJSON(){return this.toISO()};e.toString=function toString(){return this.toISO()};e.toMillis=function toMillis(){return this.as("milliseconds")};e.valueOf=function valueOf(){return this.toMillis()}
/**
   * Make this Duration longer by the specified amount. Return a newly-constructed Duration.
   * @param {Duration|Object|number} duration - The amount to add. Either a Luxon Duration, a number of milliseconds, the object argument to Duration.fromObject()
   * @return {Duration}
   */;e.plus=function plus(e){if(!this.isValid)return this;var t=Duration.fromDurationLike(e),n={};for(var r,i=_createForOfIteratorHelperLoose(ot);!(r=i()).done;){var a=r.value;(hasOwnProperty(t.values,a)||hasOwnProperty(this.values,a))&&(n[a]=t.get(a)+this.get(a))}return clone$1(this,{values:n},true)}
/**
   * Make this Duration shorter by the specified amount. Return a newly-constructed Duration.
   * @param {Duration|Object|number} duration - The amount to subtract. Either a Luxon Duration, a number of milliseconds, the object argument to Duration.fromObject()
   * @return {Duration}
   */;e.minus=function minus(e){if(!this.isValid)return this;var t=Duration.fromDurationLike(e);return this.plus(t.negate())}
/**
   * Scale this Duration by the specified amount. Return a newly-constructed Duration.
   * @param {function} fn - The function to apply to each unit. Arity is 1 or 2: the value of the unit and, optionally, the unit name. Must return a number.
   * @example Duration.fromObject({ hours: 1, minutes: 30 }).mapUnits(x => x * 2) //=> { hours: 2, minutes: 60 }
   * @example Duration.fromObject({ hours: 1, minutes: 30 }).mapUnits((x, u) => u === "hour" ? x * 2 : x) //=> { hours: 2, minutes: 30 }
   * @return {Duration}
   */;e.mapUnits=function mapUnits(e){if(!this.isValid)return this;var t={};for(var n=0,r=Object.keys(this.values);n<r.length;n++){var i=r[n];t[i]=asNumber(e(this.values[i],i))}return clone$1(this,{values:t},true)}
/**
   * Get the value of unit.
   * @param {string} unit - a unit such as 'minute' or 'day'
   * @example Duration.fromObject({years: 2, days: 3}).get('years') //=> 2
   * @example Duration.fromObject({years: 2, days: 3}).get('months') //=> 0
   * @example Duration.fromObject({years: 2, days: 3}).get('days') //=> 3
   * @return {number}
   */;e.get=function get(e){return this[Duration.normalizeUnit(e)]}
/**
   * "Set" the values of specified units. Return a newly-constructed Duration.
   * @param {Object} values - a mapping of units to numbers
   * @example dur.set({ years: 2017 })
   * @example dur.set({ hours: 8, minutes: 30 })
   * @return {Duration}
   */;e.set=function set(e){if(!this.isValid)return this;var t=_extends({},this.values,normalizeObject(e,Duration.normalizeUnit));return clone$1(this,{values:t})};e.reconfigure=function reconfigure(e){var t=void 0===e?{}:e,n=t.locale,r=t.numberingSystem,i=t.conversionAccuracy;var a=this.loc.clone({locale:n,numberingSystem:r}),o={loc:a};i&&(o.conversionAccuracy=i);return clone$1(this,o)}
/**
   * Return the length of the duration in the specified unit.
   * @param {string} unit - a unit such as 'minutes' or 'days'
   * @example Duration.fromObject({years: 1}).as('days') //=> 365
   * @example Duration.fromObject({years: 1}).as('months') //=> 12
   * @example Duration.fromObject({hours: 60}).as('days') //=> 2.5
   * @return {number}
   */;e.as=function as(e){return this.isValid?this.shiftTo(e).get(e):NaN};e.normalize=function normalize(){if(!this.isValid)return this;var e=this.toObject();normalizeValues(this.matrix,e);return clone$1(this,{values:e},true)};e.shiftTo=function shiftTo(){for(var e=arguments.length,t=new Array(e),n=0;n<e;n++)t[n]=arguments[n];if(!this.isValid)return this;if(0===t.length)return this;t=t.map((function(e){return Duration.normalizeUnit(e)}));var r={},i={},a=this.toObject();var o;for(var s,u=_createForOfIteratorHelperLoose(ot);!(s=u()).done;){var l=s.value;if(t.indexOf(l)>=0){o=l;var c=0;for(var f in i){c+=this.matrix[f][l]*i[f];i[f]=0}isNumber(a[l])&&(c+=a[l]);var d=Math.trunc(c);r[l]=d;i[l]=(1e3*c-1e3*d)/1e3;for(var m in a)ot.indexOf(m)>ot.indexOf(l)&&convert(this.matrix,a,m,r,l)}else isNumber(a[l])&&(i[l]=a[l])}for(var h in i)0!==i[h]&&(r[o]+=h===o?i[h]:i[h]/this.matrix[o][h]);return clone$1(this,{values:r},true).normalize()};e.negate=function negate(){if(!this.isValid)return this;var e={};for(var t=0,n=Object.keys(this.values);t<n.length;t++){var r=n[t];e[r]=0===this.values[r]?0:-this.values[r]}return clone$1(this,{values:e},true)}
/**
   * Get the years.
   * @type {number}
   */;
/**
   * Equality check
   * Two Durations are equal iff they have the same units and the same values for each unit.
   * @param {Duration} other
   * @return {boolean}
   */e.equals=function equals(e){if(!this.isValid||!e.isValid)return false;if(!this.loc.equals(e.loc))return false;function eq(e,t){return void 0===e||0===e?void 0===t||0===t:e===t}for(var t,n=_createForOfIteratorHelperLoose(ot);!(t=n()).done;){var r=t.value;if(!eq(this.values[r],e.values[r]))return false}return true};_createClass(Duration,[{key:"locale",get:function get(){return this.isValid?this.loc.locale:null}
/**
     * Get the numbering system of a Duration, such 'beng'. The numbering system is used when formatting the Duration
     *
     * @type {string}
     */},{key:"numberingSystem",get:function get(){return this.isValid?this.loc.numberingSystem:null}},{key:"years",get:function get(){return this.isValid?this.values.years||0:NaN}
/**
     * Get the quarters.
     * @type {number}
     */},{key:"quarters",get:function get(){return this.isValid?this.values.quarters||0:NaN}
/**
     * Get the months.
     * @type {number}
     */},{key:"months",get:function get(){return this.isValid?this.values.months||0:NaN}
/**
     * Get the weeks
     * @type {number}
     */},{key:"weeks",get:function get(){return this.isValid?this.values.weeks||0:NaN}
/**
     * Get the days.
     * @type {number}
     */},{key:"days",get:function get(){return this.isValid?this.values.days||0:NaN}
/**
     * Get the hours.
     * @type {number}
     */},{key:"hours",get:function get(){return this.isValid?this.values.hours||0:NaN}
/**
     * Get the minutes.
     * @type {number}
     */},{key:"minutes",get:function get(){return this.isValid?this.values.minutes||0:NaN}},{key:"seconds",get:function get(){return this.isValid?this.values.seconds||0:NaN}},{key:"milliseconds",get:function get(){return this.isValid?this.values.milliseconds||0:NaN}},{key:"isValid",get:function get(){return null===this.invalid}},{key:"invalidReason",get:function get(){return this.invalid?this.invalid.reason:null}
/**
     * Returns an explanation of why this Duration became invalid, or null if the Duration is valid
     * @type {string}
     */},{key:"invalidExplanation",get:function get(){return this.invalid?this.invalid.explanation:null}}]);return Duration}();var lt="Invalid Interval";function validateStartEnd(e,t){return e&&e.isValid?t&&t.isValid?t<e?ct.invalid("end before start","The end of an interval must be after its start, but you had start="+e.toISO()+" and end="+t.toISO()):null:ct.invalid("missing or invalid end"):ct.invalid("missing or invalid start")}var ct=function(){function Interval(e){this.s=e.start;this.e=e.end;this.invalid=e.invalid||null;this.isLuxonInterval=true}
/**
   * Create an invalid Interval.
   * @param {string} reason - simple string of why this Interval is invalid. Should not contain parameters or anything else data-dependent
   * @param {string} [explanation=null] - longer explanation, may include parameters and other useful debugging information
   * @return {Interval}
   */Interval.invalid=function invalid(e,t){void 0===t&&(t=null);if(!e)throw new s("need to specify a reason the Interval is invalid");var invalid=e instanceof J?e:new J(e,t);if(ce.throwOnInvalid)throw new r(invalid);return new Interval({invalid:invalid})}
/**
   * Create an Interval from a start DateTime and an end DateTime. Inclusive of the start but not the end.
   * @param {DateTime|Date|Object} start
   * @param {DateTime|Date|Object} end
   * @return {Interval}
   */;Interval.fromDateTimes=function fromDateTimes(e,t){var n=friendlyDateTime(e),r=friendlyDateTime(t);var i=validateStartEnd(n,r);return null==i?new Interval({start:n,end:r}):i}
/**
   * Create an Interval from a start DateTime and a Duration to extend to.
   * @param {DateTime|Date|Object} start
   * @param {Duration|Object|number} duration - the length of the Interval.
   * @return {Interval}
   */;Interval.after=function after(e,t){var n=ut.fromDurationLike(t),r=friendlyDateTime(e);return Interval.fromDateTimes(r,r.plus(n))}
/**
   * Create an Interval from an end DateTime and a Duration to extend backwards to.
   * @param {DateTime|Date|Object} end
   * @param {Duration|Object|number} duration - the length of the Interval.
   * @return {Interval}
   */;Interval.before=function before(e,t){var n=ut.fromDurationLike(t),r=friendlyDateTime(e);return Interval.fromDateTimes(r.minus(n),r)}
/**
   * Create an Interval from an ISO 8601 string.
   * Accepts `<start>/<end>`, `<start>/<duration>`, and `<duration>/<end>` formats.
   * @param {string} text - the ISO string to parse
   * @param {Object} [opts] - options to pass {@link DateTime#fromISO} and optionally {@link Duration#fromISO}
   * @see https://en.wikipedia.org/wiki/ISO_8601#Time_intervals
   * @return {Interval}
   */;Interval.fromISO=function fromISO(e,t){var n=(e||"").split("/",2),r=n[0],i=n[1];if(r&&i){var a,o;try{a=Et.fromISO(r,t);o=a.isValid}catch(i){o=false}var s,u;try{s=Et.fromISO(i,t);u=s.isValid}catch(i){u=false}if(o&&u)return Interval.fromDateTimes(a,s);if(o){var l=ut.fromISO(i,t);if(l.isValid)return Interval.after(a,l)}else if(u){var c=ut.fromISO(r,t);if(c.isValid)return Interval.before(s,c)}}return Interval.invalid("unparsable",'the input "'+e+"\" can't be parsed as ISO 8601")}
/**
   * Check if an object is an Interval. Works across context boundaries
   * @param {object} o
   * @return {boolean}
   */;Interval.isInterval=function isInterval(e){return e&&e.isLuxonInterval||false}
/**
   * Returns the start of the Interval
   * @type {DateTime}
   */;var e=Interval.prototype;
/**
   * Returns the length of the Interval in the specified unit.
   * @param {string} unit - the unit (such as 'hours' or 'days') to return the length in.
   * @return {number}
   */e.length=function length(e){void 0===e&&(e="milliseconds");return this.isValid?this.toDuration.apply(this,[e]).get(e):NaN}
/**
   * Returns the count of minutes, hours, days, months, or years included in the Interval, even in part.
   * Unlike {@link Interval#length} this counts sections of the calendar, not periods of time, e.g. specifying 'day'
   * asks 'what dates are included in this interval?', not 'how many days long is this interval?'
   * @param {string} [unit='milliseconds'] - the unit of time to count.
   * @return {number}
   */;e.count=function count(e){void 0===e&&(e="milliseconds");if(!this.isValid)return NaN;var t=this.start.startOf(e),n=this.end.startOf(e);return Math.floor(n.diff(t,e).get(e))+1}
/**
   * Returns whether this Interval's start and end are both in the same unit of time
   * @param {string} unit - the unit of time to check sameness on
   * @return {boolean}
   */;e.hasSame=function hasSame(e){return!!this.isValid&&(this.isEmpty()||this.e.minus(1).hasSame(this.s,e))};e.isEmpty=function isEmpty(){return this.s.valueOf()===this.e.valueOf()}
/**
   * Return whether this Interval's start is after the specified DateTime.
   * @param {DateTime} dateTime
   * @return {boolean}
   */;e.isAfter=function isAfter(e){return!!this.isValid&&this.s>e}
/**
   * Return whether this Interval's end is before the specified DateTime.
   * @param {DateTime} dateTime
   * @return {boolean}
   */;e.isBefore=function isBefore(e){return!!this.isValid&&this.e<=e}
/**
   * Return whether this Interval contains the specified DateTime.
   * @param {DateTime} dateTime
   * @return {boolean}
   */;e.contains=function contains(e){return!!this.isValid&&(this.s<=e&&this.e>e)}
/**
   * "Sets" the start and/or end dates. Returns a newly-constructed Interval.
   * @param {Object} values - the values to set
   * @param {DateTime} values.start - the starting DateTime
   * @param {DateTime} values.end - the ending DateTime
   * @return {Interval}
   */;e.set=function set(e){var t=void 0===e?{}:e,n=t.start,r=t.end;return this.isValid?Interval.fromDateTimes(n||this.s,r||this.e):this}
/**
   * Split this Interval at each of the specified DateTimes
   * @param {...DateTime} dateTimes - the unit of time to count.
   * @return {Array}
   */;e.splitAt=function splitAt(){var e=this;if(!this.isValid)return[];for(var t=arguments.length,n=new Array(t),r=0;r<t;r++)n[r]=arguments[r];var i=n.map(friendlyDateTime).filter((function(t){return e.contains(t)})).sort(),a=[];var o=this.s,s=0;while(o<this.e){var u=i[s]||this.e,l=+u>+this.e?this.e:u;a.push(Interval.fromDateTimes(o,l));o=l;s+=1}return a}
/**
   * Split this Interval into smaller Intervals, each of the specified length.
   * Left over time is grouped into a smaller interval
   * @param {Duration|Object|number} duration - The length of each resulting interval.
   * @return {Array}
   */;e.splitBy=function splitBy(e){var t=ut.fromDurationLike(e);if(!this.isValid||!t.isValid||0===t.as("milliseconds"))return[];var n,r=this.s,i=1;var a=[];while(r<this.e){var o=this.start.plus(t.mapUnits((function(e){return e*i})));n=+o>+this.e?this.e:o;a.push(Interval.fromDateTimes(r,n));r=n;i+=1}return a}
/**
   * Split this Interval into the specified number of smaller intervals.
   * @param {number} numberOfParts - The number of Intervals to divide the Interval into.
   * @return {Array}
   */;e.divideEqually=function divideEqually(e){return this.isValid?this.splitBy(this.length()/e).slice(0,e):[]}
/**
   * Return whether this Interval overlaps with the specified Interval
   * @param {Interval} other
   * @return {boolean}
   */;e.overlaps=function overlaps(e){return this.e>e.s&&this.s<e.e}
/**
   * Return whether this Interval's end is adjacent to the specified Interval's start.
   * @param {Interval} other
   * @return {boolean}
   */;e.abutsStart=function abutsStart(e){return!!this.isValid&&+this.e===+e.s}
/**
   * Return whether this Interval's start is adjacent to the specified Interval's end.
   * @param {Interval} other
   * @return {boolean}
   */;e.abutsEnd=function abutsEnd(e){return!!this.isValid&&+e.e===+this.s}
/**
   * Return whether this Interval engulfs the start and end of the specified Interval.
   * @param {Interval} other
   * @return {boolean}
   */;e.engulfs=function engulfs(e){return!!this.isValid&&(this.s<=e.s&&this.e>=e.e)}
/**
   * Return whether this Interval has the same start and end as the specified Interval.
   * @param {Interval} other
   * @return {boolean}
   */;e.equals=function equals(e){return!(!this.isValid||!e.isValid)&&(this.s.equals(e.s)&&this.e.equals(e.e))}
/**
   * Return an Interval representing the intersection of this Interval and the specified Interval.
   * Specifically, the resulting Interval has the maximum start time and the minimum end time of the two Intervals.
   * Returns null if the intersection is empty, meaning, the intervals don't intersect.
   * @param {Interval} other
   * @return {Interval}
   */;e.intersection=function intersection(e){if(!this.isValid)return this;var t=this.s>e.s?this.s:e.s,n=this.e<e.e?this.e:e.e;return t>=n?null:Interval.fromDateTimes(t,n)}
/**
   * Return an Interval representing the union of this Interval and the specified Interval.
   * Specifically, the resulting Interval has the minimum start time and the maximum end time of the two Intervals.
   * @param {Interval} other
   * @return {Interval}
   */;e.union=function union(e){if(!this.isValid)return this;var t=this.s<e.s?this.s:e.s,n=this.e>e.e?this.e:e.e;return Interval.fromDateTimes(t,n)}
/**
   * Merge an array of Intervals into a equivalent minimal set of Intervals.
   * Combines overlapping and adjacent Intervals.
   * @param {Array} intervals
   * @return {Array}
   */;Interval.merge=function merge(e){var t=e.sort((function(e,t){return e.s-t.s})).reduce((function(e,t){var n=e[0],r=e[1];return r?r.overlaps(t)||r.abutsStart(t)?[n,r.union(t)]:[n.concat([r]),t]:[n,t]}),[[],null]),n=t[0],r=t[1];r&&n.push(r);return n}
/**
   * Return an array of Intervals representing the spans of time that only appear in one of the specified Intervals.
   * @param {Array} intervals
   * @return {Array}
   */;Interval.xor=function xor(e){var t;var n=null,r=0;var i=[],a=e.map((function(e){return[{time:e.s,type:"s"},{time:e.e,type:"e"}]})),o=(t=Array.prototype).concat.apply(t,a),s=o.sort((function(e,t){return e.time-t.time}));for(var u,l=_createForOfIteratorHelperLoose(s);!(u=l()).done;){var c=u.value;r+="s"===c.type?1:-1;if(1===r)n=c.time;else{n&&+n!==+c.time&&i.push(Interval.fromDateTimes(n,c.time));n=null}}return Interval.merge(i)}
/**
   * Return an Interval representing the span of time in this Interval that doesn't overlap with any of the specified Intervals.
   * @param {...Interval} intervals
   * @return {Array}
   */;e.difference=function difference(){var e=this;for(var t=arguments.length,n=new Array(t),r=0;r<t;r++)n[r]=arguments[r];return Interval.xor([this].concat(n)).map((function(t){return e.intersection(t)})).filter((function(e){return e&&!e.isEmpty()}))};e.toString=function toString(){return this.isValid?"["+this.s.toISO()+" – "+this.e.toISO()+")":lt}
/**
   * Returns an ISO 8601-compliant string representation of this Interval.
   * @see https://en.wikipedia.org/wiki/ISO_8601#Time_intervals
   * @param {Object} opts - The same options as {@link DateTime#toISO}
   * @return {string}
   */;e.toISO=function toISO(e){return this.isValid?this.s.toISO(e)+"/"+this.e.toISO(e):lt};e.toISODate=function toISODate(){return this.isValid?this.s.toISODate()+"/"+this.e.toISODate():lt}
/**
   * Returns an ISO 8601-compliant string representation of time of this Interval.
   * The date components are ignored.
   * @see https://en.wikipedia.org/wiki/ISO_8601#Time_intervals
   * @param {Object} opts - The same options as {@link DateTime#toISO}
   * @return {string}
   */;e.toISOTime=function toISOTime(e){return this.isValid?this.s.toISOTime(e)+"/"+this.e.toISOTime(e):lt}
/**
   * Returns a string representation of this Interval formatted according to the specified format string.
   * @param {string} dateFormat - the format string. This string formats the start and end time. See {@link DateTime#toFormat} for details.
   * @param {Object} opts - options
   * @param {string} [opts.separator =  ' – '] - a separator to place between the start and end representations
   * @return {string}
   */;e.toFormat=function toFormat(e,t){var n=void 0===t?{}:t,r=n.separator,i=void 0===r?" – ":r;return this.isValid?""+this.s.toFormat(e)+i+this.e.toFormat(e):lt}
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
   */;e.toDuration=function toDuration(e,t){return this.isValid?this.e.diff(this.s,e,t):ut.invalid(this.invalidReason)}
/**
   * Run mapFn on the interval start and end, returning a new Interval from the resulting DateTimes
   * @param {function} mapFn
   * @return {Interval}
   * @example Interval.fromDateTimes(dt1, dt2).mapEndpoints(endpoint => endpoint.toUTC())
   * @example Interval.fromDateTimes(dt1, dt2).mapEndpoints(endpoint => endpoint.plus({ hours: 2 }))
   */;e.mapEndpoints=function mapEndpoints(e){return Interval.fromDateTimes(e(this.s),e(this.e))};_createClass(Interval,[{key:"start",get:function get(){return this.isValid?this.s:null}
/**
     * Returns the end of the Interval
     * @type {DateTime}
     */},{key:"end",get:function get(){return this.isValid?this.e:null}
/**
     * Returns whether this Interval's end is at least its start, meaning that the Interval isn't 'backwards'.
     * @type {boolean}
     */},{key:"isValid",get:function get(){return null===this.invalidReason}
/**
     * Returns an error code if this Interval is invalid, or null if the Interval is valid
     * @type {string}
     */},{key:"invalidReason",get:function get(){return this.invalid?this.invalid.reason:null}
/**
     * Returns an explanation of why this Interval became invalid, or null if the Interval is valid
     * @type {string}
     */},{key:"invalidExplanation",get:function get(){return this.invalid?this.invalid.explanation:null}}]);return Interval}();var ft=function(){function Info(){}
/**
   * Return whether the specified zone contains a DST.
   * @param {string|Zone} [zone='local'] - Zone to check. Defaults to the environment's local zone.
   * @return {boolean}
   */Info.hasDST=function hasDST(e){void 0===e&&(e=ce.defaultZone);var t=Et.now().setZone(e).set({month:12});return!e.isUniversal&&t.offset!==t.set({month:6}).offset}
/**
   * Return whether the specified zone is a valid IANA specifier.
   * @param {string} zone - Zone to check
   * @return {boolean}
   */;Info.isValidIANAZone=function isValidIANAZone(e){return ee.isValidZone(e)}
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
   */;Info.normalizeZone=function normalizeZone$1(e){return normalizeZone(e,ce.defaultZone)}
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
   */;Info.months=function months(e,t){void 0===e&&(e="long");var n=void 0===t?{}:t,r=n.locale,i=void 0===r?null:r,a=n.numberingSystem,o=void 0===a?null:a,s=n.locObj,u=void 0===s?null:s,l=n.outputCalendar,c=void 0===l?"gregory":l;return(u||we.create(i,o,c)).months(e)}
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
   */;Info.monthsFormat=function monthsFormat(e,t){void 0===e&&(e="long");var n=void 0===t?{}:t,r=n.locale,i=void 0===r?null:r,a=n.numberingSystem,o=void 0===a?null:a,s=n.locObj,u=void 0===s?null:s,l=n.outputCalendar,c=void 0===l?"gregory":l;return(u||we.create(i,o,c)).months(e,true)}
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
   */;Info.weekdays=function weekdays(e,t){void 0===e&&(e="long");var n=void 0===t?{}:t,r=n.locale,i=void 0===r?null:r,a=n.numberingSystem,o=void 0===a?null:a,s=n.locObj,u=void 0===s?null:s;return(u||we.create(i,o,null)).weekdays(e)}
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
   */;Info.weekdaysFormat=function weekdaysFormat(e,t){void 0===e&&(e="long");var n=void 0===t?{}:t,r=n.locale,i=void 0===r?null:r,a=n.numberingSystem,o=void 0===a?null:a,s=n.locObj,u=void 0===s?null:s;return(u||we.create(i,o,null)).weekdays(e,true)}
/**
   * Return an array of meridiems.
   * @param {Object} opts - options
   * @param {string} [opts.locale] - the locale code
   * @example Info.meridiems() //=> [ 'AM', 'PM' ]
   * @example Info.meridiems({ locale: 'my' }) //=> [ 'နံနက်', 'ညနေ' ]
   * @return {Array}
   */;Info.meridiems=function meridiems(e){var t=void 0===e?{}:e,n=t.locale,r=void 0===n?null:n;return we.create(r).meridiems()}
/**
   * Return an array of eras, such as ['BC', 'AD']. The locale can be specified, but the calendar system is always Gregorian.
   * @param {string} [length='short'] - the length of the era representation, such as "short" or "long".
   * @param {Object} opts - options
   * @param {string} [opts.locale] - the locale code
   * @example Info.eras() //=> [ 'BC', 'AD' ]
   * @example Info.eras('long') //=> [ 'Before Christ', 'Anno Domini' ]
   * @example Info.eras('long', { locale: 'fr' }) //=> [ 'avant Jésus-Christ', 'après Jésus-Christ' ]
   * @return {Array}
   */;Info.eras=function eras(e,t){void 0===e&&(e="short");var n=void 0===t?{}:t,r=n.locale,i=void 0===r?null:r;return we.create(i,null,"gregory").eras(e)};Info.features=function features(){return{relative:hasRelative()}};return Info}();function dayDiff(e,t){var n=function utcDayStart(e){return e.toUTC(0,{keepLocalTime:true}).startOf("day").valueOf()},r=n(t)-n(e);return Math.floor(ut.fromMillis(r).as("days"))}function highOrderDiffs(e,t,n){var r=[["years",function(e,t){return t.year-e.year}],["quarters",function(e,t){return t.quarter-e.quarter}],["months",function(e,t){return t.month-e.month+12*(t.year-e.year)}],["weeks",function(e,t){var n=dayDiff(e,t);return(n-n%7)/7}],["days",dayDiff]];var i={};var a,o;for(var s=0,u=r;s<u.length;s++){var l=u[s],c=l[0],f=l[1];if(n.indexOf(c)>=0){var d;a=c;var m=f(e,t);o=e.plus((d={},d[c]=m,d));if(o>t){var h;e=e.plus((h={},h[c]=m-1,h));m-=1}else e=o;i[c]=m}}return[e,i,o,a]}function _diff(e,t,n,r){var i=highOrderDiffs(e,t,n),a=i[0],o=i[1],s=i[2],u=i[3];var l=t-a;var c=n.filter((function(e){return["hours","minutes","seconds","milliseconds"].indexOf(e)>=0}));if(0===c.length){if(s<t){var f;s=a.plus((f={},f[u]=1,f))}s!==a&&(o[u]=(o[u]||0)+l/(s-a))}var d=ut.fromObject(o,r);if(c.length>0){var m;return(m=ut.fromMillis(l,r)).shiftTo.apply(m,c).plus(d)}return d}var dt={arab:"[٠-٩]",arabext:"[۰-۹]",bali:"[᭐-᭙]",beng:"[০-৯]",deva:"[०-९]",fullwide:"[０-９]",gujr:"[૦-૯]",hanidec:"[〇|一|二|三|四|五|六|七|八|九]",khmr:"[០-៩]",knda:"[೦-೯]",laoo:"[໐-໙]",limb:"[᥆-᥏]",mlym:"[൦-൯]",mong:"[᠐-᠙]",mymr:"[၀-၉]",orya:"[୦-୯]",tamldec:"[௦-௯]",telu:"[౦-౯]",thai:"[๐-๙]",tibt:"[༠-༩]",latn:"\\d"};var mt={arab:[1632,1641],arabext:[1776,1785],bali:[6992,7001],beng:[2534,2543],deva:[2406,2415],fullwide:[65296,65303],gujr:[2790,2799],khmr:[6112,6121],knda:[3302,3311],laoo:[3792,3801],limb:[6470,6479],mlym:[3430,3439],mong:[6160,6169],mymr:[4160,4169],orya:[2918,2927],tamldec:[3046,3055],telu:[3174,3183],thai:[3664,3673],tibt:[3872,3881]};var ht=dt.hanidec.replace(/[\[|\]]/g,"").split("");function parseDigits(e){var t=parseInt(e,10);if(isNaN(t)){t="";for(var n=0;n<e.length;n++){var r=e.charCodeAt(n);if(-1!==e[n].search(dt.hanidec))t+=ht.indexOf(e[n]);else for(var i in mt){var a=mt[i],o=a[0],s=a[1];r>=o&&r<=s&&(t+=r-o)}}return parseInt(t,10)}return t}function digitRegex(e,t){var n=e.numberingSystem;void 0===t&&(t="");return new RegExp(""+dt[n||"latn"]+t)}var vt="missing Intl.DateTimeFormat.formatToParts support";function intUnit(e,t){void 0===t&&(t=function post(e){return e});return{regex:e,deser:function deser(e){var n=e[0];return t(parseDigits(n))}}}var yt=String.fromCharCode(160);var gt="[ "+yt+"]";var pt=new RegExp(gt,"g");function fixListRegex(e){return e.replace(/\./g,"\\.?").replace(pt,gt)}function stripInsensitivities(e){return e.replace(/\./g,"").replace(pt," ").toLowerCase()}function oneOf(e,t){return null===e?null:{regex:RegExp(e.map(fixListRegex).join("|")),deser:function deser(n){var r=n[0];return e.findIndex((function(e){return stripInsensitivities(r)===stripInsensitivities(e)}))+t}}}function offset(e,t){return{regex:e,deser:function deser(e){var t=e[1],n=e[2];return signedOffset(t,n)},groups:t}}function simple(e){return{regex:e,deser:function deser(e){var t=e[0];return t}}}function escapeToken(e){return e.replace(/[\-\[\]{}()*+?.,\\\^$|#\s]/g,"\\$&")}function unitForToken(e,t){var n=digitRegex(t),r=digitRegex(t,"{2}"),i=digitRegex(t,"{3}"),a=digitRegex(t,"{4}"),o=digitRegex(t,"{6}"),s=digitRegex(t,"{1,2}"),u=digitRegex(t,"{1,3}"),l=digitRegex(t,"{1,6}"),c=digitRegex(t,"{1,9}"),f=digitRegex(t,"{2,4}"),d=digitRegex(t,"{4,6}"),m=function literal(e){return{regex:RegExp(escapeToken(e.val)),deser:function deser(e){var t=e[0];return t},literal:true}},h=function unitate(h){if(e.literal)return m(h);switch(h.val){case"G":return oneOf(t.eras("short",false),0);case"GG":return oneOf(t.eras("long",false),0);case"y":return intUnit(l);case"yy":return intUnit(f,untruncateYear);case"yyyy":return intUnit(a);case"yyyyy":return intUnit(d);case"yyyyyy":return intUnit(o);case"M":return intUnit(s);case"MM":return intUnit(r);case"MMM":return oneOf(t.months("short",true,false),1);case"MMMM":return oneOf(t.months("long",true,false),1);case"L":return intUnit(s);case"LL":return intUnit(r);case"LLL":return oneOf(t.months("short",false,false),1);case"LLLL":return oneOf(t.months("long",false,false),1);case"d":return intUnit(s);case"dd":return intUnit(r);case"o":return intUnit(u);case"ooo":return intUnit(i);case"HH":return intUnit(r);case"H":return intUnit(s);case"hh":return intUnit(r);case"h":return intUnit(s);case"mm":return intUnit(r);case"m":return intUnit(s);case"q":return intUnit(s);case"qq":return intUnit(r);case"s":return intUnit(s);case"ss":return intUnit(r);case"S":return intUnit(u);case"SSS":return intUnit(i);case"u":return simple(c);case"uu":return simple(s);case"uuu":return intUnit(n);case"a":return oneOf(t.meridiems(),0);case"kkkk":return intUnit(a);case"kk":return intUnit(f,untruncateYear);case"W":return intUnit(s);case"WW":return intUnit(r);case"E":case"c":return intUnit(n);case"EEE":return oneOf(t.weekdays("short",false,false),1);case"EEEE":return oneOf(t.weekdays("long",false,false),1);case"ccc":return oneOf(t.weekdays("short",true,false),1);case"cccc":return oneOf(t.weekdays("long",true,false),1);case"Z":case"ZZ":return offset(new RegExp("([+-]"+s.source+")(?::("+r.source+"))?"),2);case"ZZZ":return offset(new RegExp("([+-]"+s.source+")("+r.source+")?"),2);case"z":return simple(/[a-z_+-/]{1,256}?/i);default:return m(h)}};var v=h(e)||{invalidReason:vt};v.token=e;return v}var Tt={year:{"2-digit":"yy",numeric:"yyyyy"},month:{numeric:"M","2-digit":"MM",short:"MMM",long:"MMMM"},day:{numeric:"d","2-digit":"dd"},weekday:{short:"EEE",long:"EEEE"},dayperiod:"a",dayPeriod:"a",hour:{numeric:"h","2-digit":"hh"},minute:{numeric:"m","2-digit":"mm"},second:{numeric:"s","2-digit":"ss"}};function tokenForPart(e,t,n){var r=e.type,i=e.value;if("literal"===r)return{literal:true,val:i};var a=n[r];var o=Tt[r];"object"===typeof o&&(o=o[a]);return o?{literal:false,val:o}:void 0}function buildRegex(e){var t=e.map((function(e){return e.regex})).reduce((function(e,t){return e+"("+t.source+")"}),"");return["^"+t+"$",e]}function match(e,t,n){var r=e.match(t);if(r){var i={};var a=1;for(var o in n)if(hasOwnProperty(n,o)){var s=n[o],u=s.groups?s.groups+1:1;!s.literal&&s.token&&(i[s.token.val[0]]=s.deser(r.slice(a,a+u)));a+=u}return[r,i]}return[r,{}]}function dateTimeFromMatches(e){var t=function toField(e){switch(e){case"S":return"millisecond";case"s":return"second";case"m":return"minute";case"h":case"H":return"hour";case"d":return"day";case"o":return"ordinal";case"L":case"M":return"month";case"y":return"year";case"E":case"c":return"weekday";case"W":return"weekNumber";case"k":return"weekYear";case"q":return"quarter";default:return null}};var n=null;var r;isUndefined(e.z)||(n=ee.create(e.z));if(!isUndefined(e.Z)){n||(n=new ne(e.Z));r=e.Z}isUndefined(e.q)||(e.M=3*(e.q-1)+1);isUndefined(e.h)||(e.h<12&&1===e.a?e.h+=12:12===e.h&&0===e.a&&(e.h=0));0===e.G&&e.y&&(e.y=-e.y);isUndefined(e.u)||(e.S=parseMillis(e.u));var i=Object.keys(e).reduce((function(n,r){var i=t(r);i&&(n[i]=e[r]);return n}),{});return[i,n,r]}var Ot=null;function getDummyDateTime(){Ot||(Ot=Et.fromMillis(1555555555555));return Ot}function maybeExpandMacroToken(e,t){if(e.literal)return e;var n=H.macroTokenToFormatOpts(e.val);if(!n)return e;var r=H.create(t,n);var i=r.formatDateTimeParts(getDummyDateTime());var a=i.map((function(e){return tokenForPart(e,t,n)}));return a.includes(void 0)?e:a}function expandMacroTokens(e,t){var n;return(n=Array.prototype).concat.apply(n,e.map((function(e){return maybeExpandMacroToken(e,t)})))}function explainFromTokens(e,t,n){var r=expandMacroTokens(H.parseFormat(n),e),i=r.map((function(t){return unitForToken(t,e)})),o=i.find((function(e){return e.invalidReason}));if(o)return{input:t,tokens:r,invalidReason:o.invalidReason};var s=buildRegex(i),u=s[0],l=s[1],c=RegExp(u,"i"),f=match(t,c,l),d=f[0],m=f[1],h=m?dateTimeFromMatches(m):[null,null,void 0],v=h[0],y=h[1],g=h[2];if(hasOwnProperty(m,"a")&&hasOwnProperty(m,"H"))throw new a("Can't include meridiem when specifying 24-hour format");return{input:t,tokens:r,regex:c,rawMatches:d,matches:m,result:v,zone:y,specificOffset:g}}function parseFromTokens(e,t,n){var r=explainFromTokens(e,t,n),i=r.result,a=r.zone,o=r.specificOffset,s=r.invalidReason;return[i,a,o,s]}var wt=[0,31,59,90,120,151,181,212,243,273,304,334],St=[0,31,60,91,121,152,182,213,244,274,305,335];function unitOutOfRange(e,t){return new J("unit out of range","you specified "+t+" (of type "+typeof t+") as a "+e+", which is invalid")}function dayOfWeek(e,t,n){var r=new Date(Date.UTC(e,t-1,n));e<100&&e>=0&&r.setUTCFullYear(r.getUTCFullYear()-1900);var i=r.getUTCDay();return 0===i?7:i}function computeOrdinal(e,t,n){return n+(isLeapYear(e)?St:wt)[t-1]}function uncomputeOrdinal(e,t){var n=isLeapYear(e)?St:wt,r=n.findIndex((function(e){return e<t})),i=t-n[r];return{month:r+1,day:i}}function gregorianToWeek(e){var t=e.year,n=e.month,r=e.day,i=computeOrdinal(t,n,r),a=dayOfWeek(t,n,r);var o,s=Math.floor((i-a+10)/7);if(s<1){o=t-1;s=weeksInWeekYear(o)}else if(s>weeksInWeekYear(t)){o=t+1;s=1}else o=t;return _extends({weekYear:o,weekNumber:s,weekday:a},timeObject(e))}function weekToGregorian(e){var t=e.weekYear,n=e.weekNumber,r=e.weekday,i=dayOfWeek(t,1,4),a=daysInYear(t);var o,s=7*n+r-i-3;if(s<1){o=t-1;s+=daysInYear(o)}else if(s>a){o=t+1;s-=daysInYear(t)}else o=t;var u=uncomputeOrdinal(o,s),l=u.month,c=u.day;return _extends({year:o,month:l,day:c},timeObject(e))}function gregorianToOrdinal(e){var t=e.year,n=e.month,r=e.day;var i=computeOrdinal(t,n,r);return _extends({year:t,ordinal:i},timeObject(e))}function ordinalToGregorian(e){var t=e.year,n=e.ordinal;var r=uncomputeOrdinal(t,n),i=r.month,a=r.day;return _extends({year:t,month:i,day:a},timeObject(e))}function hasInvalidWeekData(e){var t=isInteger(e.weekYear),n=integerBetween(e.weekNumber,1,weeksInWeekYear(e.weekYear)),r=integerBetween(e.weekday,1,7);return t?n?!r&&unitOutOfRange("weekday",e.weekday):unitOutOfRange("week",e.week):unitOutOfRange("weekYear",e.weekYear)}function hasInvalidOrdinalData(e){var t=isInteger(e.year),n=integerBetween(e.ordinal,1,daysInYear(e.year));return t?!n&&unitOutOfRange("ordinal",e.ordinal):unitOutOfRange("year",e.year)}function hasInvalidGregorianData(e){var t=isInteger(e.year),n=integerBetween(e.month,1,12),r=integerBetween(e.day,1,daysInMonth(e.year,e.month));return t?n?!r&&unitOutOfRange("day",e.day):unitOutOfRange("month",e.month):unitOutOfRange("year",e.year)}function hasInvalidTimeData(e){var t=e.hour,n=e.minute,r=e.second,i=e.millisecond;var a=integerBetween(t,0,23)||24===t&&0===n&&0===r&&0===i,o=integerBetween(n,0,59),s=integerBetween(r,0,59),u=integerBetween(i,0,999);return a?o?s?!u&&unitOutOfRange("millisecond",i):unitOutOfRange("second",r):unitOutOfRange("minute",n):unitOutOfRange("hour",t)}var kt="Invalid DateTime";var It=864e13;function unsupportedZone(e){return new J("unsupported zone",'the zone "'+e.name+'" is not supported')}function possiblyCachedWeekData(e){null===e.weekData&&(e.weekData=gregorianToWeek(e.c));return e.weekData}function clone(e,t){var n={ts:e.ts,zone:e.zone,c:e.c,o:e.o,loc:e.loc,invalid:e.invalid};return new Et(_extends({},n,t,{old:n}))}function fixOffset(e,t,n){var r=e-60*t*1e3;var i=n.offset(r);if(t===i)return[r,t];r-=60*(i-t)*1e3;var a=n.offset(r);return i===a?[r,i]:[e-60*Math.min(i,a)*1e3,Math.max(i,a)]}function tsToObj(e,t){e+=60*t*1e3;var n=new Date(e);return{year:n.getUTCFullYear(),month:n.getUTCMonth()+1,day:n.getUTCDate(),hour:n.getUTCHours(),minute:n.getUTCMinutes(),second:n.getUTCSeconds(),millisecond:n.getUTCMilliseconds()}}function objToTS(e,t,n){return fixOffset(objToLocalTS(e),t,n)}function adjustTime(e,t){var n=e.o,r=e.c.year+Math.trunc(t.years),i=e.c.month+Math.trunc(t.months)+3*Math.trunc(t.quarters),a=_extends({},e.c,{year:r,month:i,day:Math.min(e.c.day,daysInMonth(r,i))+Math.trunc(t.days)+7*Math.trunc(t.weeks)}),o=ut.fromObject({years:t.years-Math.trunc(t.years),quarters:t.quarters-Math.trunc(t.quarters),months:t.months-Math.trunc(t.months),weeks:t.weeks-Math.trunc(t.weeks),days:t.days-Math.trunc(t.days),hours:t.hours,minutes:t.minutes,seconds:t.seconds,milliseconds:t.milliseconds}).as("milliseconds"),s=objToLocalTS(a);var u=fixOffset(s,n,e.zone),l=u[0],c=u[1];if(0!==o){l+=o;c=e.zone.offset(l)}return{ts:l,o:c}}function parseDataToDateTime(e,t,n,r,i,a){var o=n.setZone,s=n.zone;if(e&&0!==Object.keys(e).length){var u=t||s,l=Et.fromObject(e,_extends({},n,{zone:u,specificOffset:a}));return o?l:l.setZone(s)}return Et.invalid(new J("unparsable",'the input "'+i+"\" can't be parsed as "+r))}function toTechFormat(e,t,n){void 0===n&&(n=true);return e.isValid?H.create(we.create("en-US"),{allowZ:n,forceSimple:true}).formatDateTimeFromString(e,t):null}function _toISODate(e,t){var n=e.c.year>9999||e.c.year<0;var r="";n&&e.c.year>=0&&(r+="+");r+=padStart(e.c.year,n?6:4);if(t){r+="-";r+=padStart(e.c.month);r+="-";r+=padStart(e.c.day)}else{r+=padStart(e.c.month);r+=padStart(e.c.day)}return r}function _toISOTime(e,t,n,r,i,a){var o=padStart(e.c.hour);if(t){o+=":";o+=padStart(e.c.minute);0===e.c.second&&n||(o+=":")}else o+=padStart(e.c.minute);if(0!==e.c.second||!n){o+=padStart(e.c.second);if(0!==e.c.millisecond||!r){o+=".";o+=padStart(e.c.millisecond,3)}}if(i)if(e.isOffsetFixed&&0===e.offset&&!a)o+="Z";else if(e.o<0){o+="-";o+=padStart(Math.trunc(-e.o/60));o+=":";o+=padStart(Math.trunc(-e.o%60))}else{o+="+";o+=padStart(Math.trunc(e.o/60));o+=":";o+=padStart(Math.trunc(e.o%60))}a&&(o+="["+e.zone.ianaName+"]");return o}var Dt={month:1,day:1,hour:0,minute:0,second:0,millisecond:0},bt={weekNumber:1,weekday:1,hour:0,minute:0,second:0,millisecond:0},xt={ordinal:1,hour:0,minute:0,second:0,millisecond:0};var Nt=["year","month","day","hour","minute","second","millisecond"],Ft=["weekYear","weekNumber","weekday","hour","minute","second","millisecond"],Mt=["year","ordinal","hour","minute","second","millisecond"];function normalizeUnit(e){var t={year:"year",years:"year",month:"month",months:"month",day:"day",days:"day",hour:"hour",hours:"hour",minute:"minute",minutes:"minute",quarter:"quarter",quarters:"quarter",second:"second",seconds:"second",millisecond:"millisecond",milliseconds:"millisecond",weekday:"weekday",weekdays:"weekday",weeknumber:"weekNumber",weeksnumber:"weekNumber",weeknumbers:"weekNumber",weekyear:"weekYear",weekyears:"weekYear",ordinal:"ordinal"}[e.toLowerCase()];if(!t)throw new o(e);return t}function quickDT(e,t){var n=normalizeZone(t.zone,ce.defaultZone),r=we.fromObject(t),i=ce.now();var a,o;if(isUndefined(e.year))a=i;else{for(var s,u=_createForOfIteratorHelperLoose(Nt);!(s=u()).done;){var l=s.value;isUndefined(e[l])&&(e[l]=Dt[l])}var c=hasInvalidGregorianData(e)||hasInvalidTimeData(e);if(c)return Et.invalid(c);var f=n.offset(i);var d=objToTS(e,f,n);a=d[0];o=d[1]}return new Et({ts:a,zone:n,loc:r,o:o})}function diffRelative(e,t,n){var r=!!isUndefined(n.round)||n.round,i=function format(e,i){e=roundTo(e,r||n.calendary?0:2,true);var a=t.loc.clone(n).relFormatter(n);return a.format(e,i)},a=function differ(r){return n.calendary?t.hasSame(e,r)?0:t.startOf(r).diff(e.startOf(r),r).get(r):t.diff(e,r).get(r)};if(n.unit)return i(a(n.unit),n.unit);for(var o,s=_createForOfIteratorHelperLoose(n.units);!(o=s()).done;){var u=o.value;var l=a(u);if(Math.abs(l)>=1)return i(l,u)}return i(e>t?-0:0,n.units[n.units.length-1])}function lastOpts(e){var t,n={};if(e.length>0&&"object"===typeof e[e.length-1]){n=e[e.length-1];t=Array.from(e).slice(0,e.length-1)}else t=Array.from(e);return[n,t]}var Et=function(){function DateTime(e){var t=e.zone||ce.defaultZone;var n=e.invalid||(Number.isNaN(e.ts)?new J("invalid input"):null)||(t.isValid?null:unsupportedZone(t));this.ts=isUndefined(e.ts)?ce.now():e.ts;var r=null,i=null;if(!n){var a=e.old&&e.old.ts===this.ts&&e.old.zone.equals(t);if(a){var o=[e.old.c,e.old.o];r=o[0];i=o[1]}else{var s=t.offset(this.ts);r=tsToObj(this.ts,s);n=Number.isNaN(r.year)?new J("invalid input"):null;r=n?null:r;i=n?null:s}}this._zone=t;this.loc=e.loc||we.create();this.invalid=n;this.weekData=null;this.c=r;this.o=i;this.isLuxonDateTime=true}DateTime.now=function now(){return new DateTime({})}
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
   */;DateTime.local=function local(){var e=lastOpts(arguments),t=e[0],n=e[1],r=n[0],i=n[1],a=n[2],o=n[3],s=n[4],u=n[5],l=n[6];return quickDT({year:r,month:i,day:a,hour:o,minute:s,second:u,millisecond:l},t)}
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
   */;DateTime.utc=function utc(){var e=lastOpts(arguments),t=e[0],n=e[1],r=n[0],i=n[1],a=n[2],o=n[3],s=n[4],u=n[5],l=n[6];t.zone=ne.utcInstance;return quickDT({year:r,month:i,day:a,hour:o,minute:s,second:u,millisecond:l},t)}
/**
   * Create a DateTime from a JavaScript Date object. Uses the default zone.
   * @param {Date} date - a JavaScript Date object
   * @param {Object} options - configuration options for the DateTime
   * @param {string|Zone} [options.zone='local'] - the zone to place the DateTime into
   * @return {DateTime}
   */;DateTime.fromJSDate=function fromJSDate(e,t){void 0===t&&(t={});var n=isDate(e)?e.valueOf():NaN;if(Number.isNaN(n))return DateTime.invalid("invalid input");var r=normalizeZone(t.zone,ce.defaultZone);return r.isValid?new DateTime({ts:n,zone:r,loc:we.fromObject(t)}):DateTime.invalid(unsupportedZone(r))}
/**
   * Create a DateTime from a number of milliseconds since the epoch (meaning since 1 January 1970 00:00:00 UTC). Uses the default zone.
   * @param {number} milliseconds - a number of milliseconds since 1970 UTC
   * @param {Object} options - configuration options for the DateTime
   * @param {string|Zone} [options.zone='local'] - the zone to place the DateTime into
   * @param {string} [options.locale] - a locale to set on the resulting DateTime instance
   * @param {string} options.outputCalendar - the output calendar to set on the resulting DateTime instance
   * @param {string} options.numberingSystem - the numbering system to set on the resulting DateTime instance
   * @return {DateTime}
   */;DateTime.fromMillis=function fromMillis(e,t){void 0===t&&(t={});if(isNumber(e))return e<-It||e>It?DateTime.invalid("Timestamp out of range"):new DateTime({ts:e,zone:normalizeZone(t.zone,ce.defaultZone),loc:we.fromObject(t)});throw new s("fromMillis requires a numerical input, but received a "+typeof e+" with value "+e)}
/**
   * Create a DateTime from a number of seconds since the epoch (meaning since 1 January 1970 00:00:00 UTC). Uses the default zone.
   * @param {number} seconds - a number of seconds since 1970 UTC
   * @param {Object} options - configuration options for the DateTime
   * @param {string|Zone} [options.zone='local'] - the zone to place the DateTime into
   * @param {string} [options.locale] - a locale to set on the resulting DateTime instance
   * @param {string} options.outputCalendar - the output calendar to set on the resulting DateTime instance
   * @param {string} options.numberingSystem - the numbering system to set on the resulting DateTime instance
   * @return {DateTime}
   */;DateTime.fromSeconds=function fromSeconds(e,t){void 0===t&&(t={});if(isNumber(e))return new DateTime({ts:1e3*e,zone:normalizeZone(t.zone,ce.defaultZone),loc:we.fromObject(t)});throw new s("fromSeconds requires a numerical input")}
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
   */;DateTime.fromObject=function fromObject(e,t){void 0===t&&(t={});e=e||{};var n=normalizeZone(t.zone,ce.defaultZone);if(!n.isValid)return DateTime.invalid(unsupportedZone(n));var r=ce.now(),i=isUndefined(t.specificOffset)?n.offset(r):t.specificOffset,o=normalizeObject(e,normalizeUnit),s=!isUndefined(o.ordinal),u=!isUndefined(o.year),l=!isUndefined(o.month)||!isUndefined(o.day),c=u||l,f=o.weekYear||o.weekNumber,d=we.fromObject(t);if((c||s)&&f)throw new a("Can't mix weekYear/weekNumber units with year/month/day or ordinals");if(l&&s)throw new a("Can't mix ordinal dates with month/day");var m=f||o.weekday&&!c;var h,v,y=tsToObj(r,i);if(m){h=Ft;v=bt;y=gregorianToWeek(y)}else if(s){h=Mt;v=xt;y=gregorianToOrdinal(y)}else{h=Nt;v=Dt}var g=false;for(var p,T=_createForOfIteratorHelperLoose(h);!(p=T()).done;){var O=p.value;var w=o[O];isUndefined(w)?o[O]=g?v[O]:y[O]:g=true}var S=m?hasInvalidWeekData(o):s?hasInvalidOrdinalData(o):hasInvalidGregorianData(o),k=S||hasInvalidTimeData(o);if(k)return DateTime.invalid(k);var I=m?weekToGregorian(o):s?ordinalToGregorian(o):o,D=objToTS(I,i,n),b=D[0],x=D[1],N=new DateTime({ts:b,zone:n,o:x,loc:d});return o.weekday&&c&&e.weekday!==N.weekday?DateTime.invalid("mismatched weekday","you can't specify both a weekday of "+o.weekday+" and a date of "+N.toISO()):N}
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
   */;DateTime.fromISO=function fromISO(e,t){void 0===t&&(t={});var n=parseISODate(e),r=n[0],i=n[1];return parseDataToDateTime(r,i,t,"ISO 8601",e)}
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
   */;DateTime.fromRFC2822=function fromRFC2822(e,t){void 0===t&&(t={});var n=parseRFC2822Date(e),r=n[0],i=n[1];return parseDataToDateTime(r,i,t,"RFC 2822",e)}
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
   */;DateTime.fromHTTP=function fromHTTP(e,t){void 0===t&&(t={});var n=parseHTTPDate(e),r=n[0],i=n[1];return parseDataToDateTime(r,i,t,"HTTP",t)}
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
   */;DateTime.fromFormat=function fromFormat(e,t,n){void 0===n&&(n={});if(isUndefined(e)||isUndefined(t))throw new s("fromFormat requires an input string and a format");var r=n,i=r.locale,a=void 0===i?null:i,o=r.numberingSystem,u=void 0===o?null:o,l=we.fromOpts({locale:a,numberingSystem:u,defaultToEN:true}),c=parseFromTokens(l,e,t),f=c[0],d=c[1],m=c[2],h=c[3];return h?DateTime.invalid(h):parseDataToDateTime(f,d,n,"format "+t,e,m)}
/**
   * @deprecated use fromFormat instead
   */;DateTime.fromString=function fromString(e,t,n){void 0===n&&(n={});return DateTime.fromFormat(e,t,n)}
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
   */;DateTime.fromSQL=function fromSQL(e,t){void 0===t&&(t={});var n=parseSQL(e),r=n[0],i=n[1];return parseDataToDateTime(r,i,t,"SQL",e)}
/**
   * Create an invalid DateTime.
   * @param {string} reason - simple string of why this DateTime is invalid. Should not contain parameters or anything else data-dependent
   * @param {string} [explanation=null] - longer explanation, may include parameters and other useful debugging information
   * @return {DateTime}
   */;DateTime.invalid=function invalid(e,t){void 0===t&&(t=null);if(!e)throw new s("need to specify a reason the DateTime is invalid");var invalid=e instanceof J?e:new J(e,t);if(ce.throwOnInvalid)throw new n(invalid);return new DateTime({invalid:invalid})}
/**
   * Check if an object is an instance of DateTime. Works across context boundaries
   * @param {object} o
   * @return {boolean}
   */;DateTime.isDateTime=function isDateTime(e){return e&&e.isLuxonDateTime||false}
/**
   * Get the value of unit.
   * @param {string} unit - a unit such as 'minute' or 'day'
   * @example DateTime.local(2017, 7, 4).get('month'); //=> 7
   * @example DateTime.local(2017, 7, 4).get('day'); //=> 4
   * @return {number}
   */;var e=DateTime.prototype;e.get=function get(e){return this[e]}
/**
   * Returns whether the DateTime is valid. Invalid DateTimes occur when:
   * * The DateTime was created from invalid calendar information, such as the 13th month or February 30
   * * The DateTime was created by an operation on another invalid date
   * @type {boolean}
   */;
/**
   * Returns the resolved Intl options for this DateTime.
   * This is useful in understanding the behavior of formatting methods
   * @param {Object} opts - the same options as toLocaleString
   * @return {Object}
   */e.resolvedLocaleOptions=function resolvedLocaleOptions(e){void 0===e&&(e={});var t=H.create(this.loc.clone(e),e).resolvedOptions(this),n=t.locale,r=t.numberingSystem,i=t.calendar;return{locale:n,numberingSystem:r,outputCalendar:i}}
/**
   * "Set" the DateTime's zone to UTC. Returns a newly-constructed DateTime.
   *
   * Equivalent to {@link DateTime#setZone}('utc')
   * @param {number} [offset=0] - optionally, an offset from UTC in minutes
   * @param {Object} [opts={}] - options to pass to `setZone()`
   * @return {DateTime}
   */;e.toUTC=function toUTC(e,t){void 0===e&&(e=0);void 0===t&&(t={});return this.setZone(ne.instance(e),t)};e.toLocal=function toLocal(){return this.setZone(ce.defaultZone)}
/**
   * "Set" the DateTime's zone to specified zone. Returns a newly-constructed DateTime.
   *
   * By default, the setter keeps the underlying time the same (as in, the same timestamp), but the new instance will report different local times and consider DSTs when making computations, as with {@link DateTime#plus}. You may wish to use {@link DateTime#toLocal} and {@link DateTime#toUTC} which provide simple convenience wrappers for commonly used zones.
   * @param {string|Zone} [zone='local'] - a zone identifier. As a string, that can be any IANA zone supported by the host environment, or a fixed-offset name of the form 'UTC+3', or the strings 'local' or 'utc'. You may also supply an instance of a {@link DateTime#Zone} class.
   * @param {Object} opts - options
   * @param {boolean} [opts.keepLocalTime=false] - If true, adjust the underlying time so that the local time stays the same, but in the target zone. You should rarely need this.
   * @return {DateTime}
   */;e.setZone=function setZone(e,t){var n=void 0===t?{}:t,r=n.keepLocalTime,i=void 0!==r&&r,a=n.keepCalendarTime,o=void 0!==a&&a;e=normalizeZone(e,ce.defaultZone);if(e.equals(this.zone))return this;if(e.isValid){var s=this.ts;if(i||o){var u=e.offset(this.ts);var l=this.toObject();var c=objToTS(l,u,e);s=c[0]}return clone(this,{ts:s,zone:e})}return DateTime.invalid(unsupportedZone(e))}
/**
   * "Set" the locale, numberingSystem, or outputCalendar. Returns a newly-constructed DateTime.
   * @param {Object} properties - the properties to set
   * @example DateTime.local(2017, 5, 25).reconfigure({ locale: 'en-GB' })
   * @return {DateTime}
   */;e.reconfigure=function reconfigure(e){var t=void 0===e?{}:e,n=t.locale,r=t.numberingSystem,i=t.outputCalendar;var a=this.loc.clone({locale:n,numberingSystem:r,outputCalendar:i});return clone(this,{loc:a})};e.setLocale=function setLocale(e){return this.reconfigure({locale:e})}
/**
   * "Set" the values of specified units. Returns a newly-constructed DateTime.
   * You can only set units with this method; for "setting" metadata, see {@link DateTime#reconfigure} and {@link DateTime#setZone}.
   * @param {Object} values - a mapping of units to numbers
   * @example dt.set({ year: 2017 })
   * @example dt.set({ hour: 8, minute: 30 })
   * @example dt.set({ weekday: 5 })
   * @example dt.set({ year: 2005, ordinal: 234 })
   * @return {DateTime}
   */;e.set=function set(e){if(!this.isValid)return this;var t=normalizeObject(e,normalizeUnit),n=!isUndefined(t.weekYear)||!isUndefined(t.weekNumber)||!isUndefined(t.weekday),r=!isUndefined(t.ordinal),i=!isUndefined(t.year),o=!isUndefined(t.month)||!isUndefined(t.day),s=i||o,u=t.weekYear||t.weekNumber;if((s||r)&&u)throw new a("Can't mix weekYear/weekNumber units with year/month/day or ordinals");if(o&&r)throw new a("Can't mix ordinal dates with month/day");var l;if(n)l=weekToGregorian(_extends({},gregorianToWeek(this.c),t));else if(isUndefined(t.ordinal)){l=_extends({},this.toObject(),t);isUndefined(t.day)&&(l.day=Math.min(daysInMonth(l.year,l.month),l.day))}else l=ordinalToGregorian(_extends({},gregorianToOrdinal(this.c),t));var c=objToTS(l,this.o,this.zone),f=c[0],d=c[1];return clone(this,{ts:f,o:d})}
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
   */;e.plus=function plus(e){if(!this.isValid)return this;var t=ut.fromDurationLike(e);return clone(this,adjustTime(this,t))}
/**
   * Subtract a period of time to this DateTime and return the resulting DateTime
   * See {@link DateTime#plus}
   * @param {Duration|Object|number} duration - The amount to subtract. Either a Luxon Duration, a number of milliseconds, the object argument to Duration.fromObject()
   @return {DateTime}
   */;e.minus=function minus(e){if(!this.isValid)return this;var t=ut.fromDurationLike(e).negate();return clone(this,adjustTime(this,t))}
/**
   * "Set" this DateTime to the beginning of a unit of time.
   * @param {string} unit - The unit to go to the beginning of. Can be 'year', 'quarter', 'month', 'week', 'day', 'hour', 'minute', 'second', or 'millisecond'.
   * @example DateTime.local(2014, 3, 3).startOf('month').toISODate(); //=> '2014-03-01'
   * @example DateTime.local(2014, 3, 3).startOf('year').toISODate(); //=> '2014-01-01'
   * @example DateTime.local(2014, 3, 3).startOf('week').toISODate(); //=> '2014-03-03', weeks always start on Mondays
   * @example DateTime.local(2014, 3, 3, 5, 30).startOf('day').toISOTime(); //=> '00:00.000-05:00'
   * @example DateTime.local(2014, 3, 3, 5, 30).startOf('hour').toISOTime(); //=> '05:00:00.000-05:00'
   * @return {DateTime}
   */;e.startOf=function startOf(e){if(!this.isValid)return this;var t={},n=ut.normalizeUnit(e);switch(n){case"years":t.month=1;case"quarters":case"months":t.day=1;case"weeks":case"days":t.hour=0;case"hours":t.minute=0;case"minutes":t.second=0;case"seconds":t.millisecond=0;break}"weeks"===n&&(t.weekday=1);if("quarters"===n){var r=Math.ceil(this.month/3);t.month=3*(r-1)+1}return this.set(t)}
/**
   * "Set" this DateTime to the end (meaning the last millisecond) of a unit of time
   * @param {string} unit - The unit to go to the end of. Can be 'year', 'quarter', 'month', 'week', 'day', 'hour', 'minute', 'second', or 'millisecond'.
   * @example DateTime.local(2014, 3, 3).endOf('month').toISO(); //=> '2014-03-31T23:59:59.999-05:00'
   * @example DateTime.local(2014, 3, 3).endOf('year').toISO(); //=> '2014-12-31T23:59:59.999-05:00'
   * @example DateTime.local(2014, 3, 3).endOf('week').toISO(); // => '2014-03-09T23:59:59.999-05:00', weeks start on Mondays
   * @example DateTime.local(2014, 3, 3, 5, 30).endOf('day').toISO(); //=> '2014-03-03T23:59:59.999-05:00'
   * @example DateTime.local(2014, 3, 3, 5, 30).endOf('hour').toISO(); //=> '2014-03-03T05:59:59.999-05:00'
   * @return {DateTime}
   */;e.endOf=function endOf(e){var t;return this.isValid?this.plus((t={},t[e]=1,t)).startOf(e).minus(1):this}
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
   */;e.toFormat=function toFormat(e,t){void 0===t&&(t={});return this.isValid?H.create(this.loc.redefaultToEN(t)).formatDateTimeFromString(this,e):kt}
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
   * @example DateTime.now().toLocaleString({ locale: 'en-gb' }); //=> '20/04/2017'
   * @example DateTime.now().toLocaleString(DateTime.DATE_FULL); //=> 'April 20, 2017'
   * @example DateTime.now().toLocaleString(DateTime.TIME_SIMPLE); //=> '11:32 AM'
   * @example DateTime.now().toLocaleString(DateTime.DATETIME_SHORT); //=> '4/20/2017, 11:32 AM'
   * @example DateTime.now().toLocaleString({ weekday: 'long', month: 'long', day: '2-digit' }); //=> 'Thursday, April 20'
   * @example DateTime.now().toLocaleString({ weekday: 'short', month: 'short', day: '2-digit', hour: '2-digit', minute: '2-digit' }); //=> 'Thu, Apr 20, 11:27 AM'
   * @example DateTime.now().toLocaleString({ hour: '2-digit', minute: '2-digit', hourCycle: 'h23' }); //=> '11:32'
   * @return {string}
   */;e.toLocaleString=function toLocaleString(e,t){void 0===e&&(e=d);void 0===t&&(t={});return this.isValid?H.create(this.loc.clone(t),e).formatDateTime(this):kt}
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
   */;e.toLocaleParts=function toLocaleParts(e){void 0===e&&(e={});return this.isValid?H.create(this.loc.clone(e),e).formatDateTimeParts(this):[]}
/**
   * Returns an ISO 8601-compliant string representation of this DateTime
   * @param {Object} opts - options
   * @param {boolean} [opts.suppressMilliseconds=false] - exclude milliseconds from the format if they're 0
   * @param {boolean} [opts.suppressSeconds=false] - exclude seconds from the format if they're 0
   * @param {boolean} [opts.includeOffset=true] - include the offset, such as 'Z' or '-04:00'
   * @param {boolean} [opts.extendedZone=true] - add the time zone format extension
   * @param {string} [opts.format='extended'] - choose between the basic and extended format
   * @example DateTime.utc(1983, 5, 25).toISO() //=> '1982-05-25T00:00:00.000Z'
   * @example DateTime.now().toISO() //=> '2017-04-22T20:47:05.335-04:00'
   * @example DateTime.now().toISO({ includeOffset: false }) //=> '2017-04-22T20:47:05.335'
   * @example DateTime.now().toISO({ format: 'basic' }) //=> '20170422T204705.335-0400'
   * @return {string}
   */;e.toISO=function toISO(e){var t=void 0===e?{}:e,n=t.format,r=void 0===n?"extended":n,i=t.suppressSeconds,a=void 0!==i&&i,o=t.suppressMilliseconds,s=void 0!==o&&o,u=t.includeOffset,l=void 0===u||u,c=t.extendedZone,f=void 0!==c&&c;if(!this.isValid)return null;var d="extended"===r;var m=_toISODate(this,d);m+="T";m+=_toISOTime(this,d,a,s,l,f);return m}
/**
   * Returns an ISO 8601-compliant string representation of this DateTime's date component
   * @param {Object} opts - options
   * @param {string} [opts.format='extended'] - choose between the basic and extended format
   * @example DateTime.utc(1982, 5, 25).toISODate() //=> '1982-05-25'
   * @example DateTime.utc(1982, 5, 25).toISODate({ format: 'basic' }) //=> '19820525'
   * @return {string}
   */;e.toISODate=function toISODate(e){var t=void 0===e?{}:e,n=t.format,r=void 0===n?"extended":n;return this.isValid?_toISODate(this,"extended"===r):null};e.toISOWeekDate=function toISOWeekDate(){return toTechFormat(this,"kkkk-'W'WW-c")}
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
   */;e.toISOTime=function toISOTime(e){var t=void 0===e?{}:e,n=t.suppressMilliseconds,r=void 0!==n&&n,i=t.suppressSeconds,a=void 0!==i&&i,o=t.includeOffset,s=void 0===o||o,u=t.includePrefix,l=void 0!==u&&u,c=t.extendedZone,f=void 0!==c&&c,d=t.format,m=void 0===d?"extended":d;if(!this.isValid)return null;var h=l?"T":"";return h+_toISOTime(this,"extended"===m,a,r,s,f)};e.toRFC2822=function toRFC2822(){return toTechFormat(this,"EEE, dd LLL yyyy HH:mm:ss ZZZ",false)};e.toHTTP=function toHTTP(){return toTechFormat(this.toUTC(),"EEE, dd LLL yyyy HH:mm:ss 'GMT'")};e.toSQLDate=function toSQLDate(){return this.isValid?_toISODate(this,true):null}
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
   */;e.toSQLTime=function toSQLTime(e){var t=void 0===e?{}:e,n=t.includeOffset,r=void 0===n||n,i=t.includeZone,a=void 0!==i&&i,o=t.includeOffsetSpace,s=void 0===o||o;var u="HH:mm:ss.SSS";if(a||r){s&&(u+=" ");a?u+="z":r&&(u+="ZZ")}return toTechFormat(this,u,true)}
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
   */;e.toSQL=function toSQL(e){void 0===e&&(e={});return this.isValid?this.toSQLDate()+" "+this.toSQLTime(e):null};e.toString=function toString(){return this.isValid?this.toISO():kt};e.valueOf=function valueOf(){return this.toMillis()};e.toMillis=function toMillis(){return this.isValid?this.ts:NaN};e.toSeconds=function toSeconds(){return this.isValid?this.ts/1e3:NaN};e.toUnixInteger=function toUnixInteger(){return this.isValid?Math.floor(this.ts/1e3):NaN};e.toJSON=function toJSON(){return this.toISO()};e.toBSON=function toBSON(){return this.toJSDate()}
/**
   * Returns a JavaScript object with this DateTime's year, month, day, and so on.
   * @param opts - options for generating the object
   * @param {boolean} [opts.includeConfig=false] - include configuration attributes in the output
   * @example DateTime.now().toObject() //=> { year: 2017, month: 4, day: 22, hour: 20, minute: 49, second: 42, millisecond: 268 }
   * @return {Object}
   */;e.toObject=function toObject(e){void 0===e&&(e={});if(!this.isValid)return{};var t=_extends({},this.c);if(e.includeConfig){t.outputCalendar=this.outputCalendar;t.numberingSystem=this.loc.numberingSystem;t.locale=this.loc.locale}return t};e.toJSDate=function toJSDate(){return new Date(this.isValid?this.ts:NaN)}
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
   */;e.diff=function diff(e,t,n){void 0===t&&(t="milliseconds");void 0===n&&(n={});if(!this.isValid||!e.isValid)return ut.invalid("created by diffing an invalid DateTime");var r=_extends({locale:this.locale,numberingSystem:this.numberingSystem},n);var i=maybeArray(t).map(ut.normalizeUnit),a=e.valueOf()>this.valueOf(),o=a?this:e,s=a?e:this,u=_diff(o,s,i,r);return a?u.negate():u}
/**
   * Return the difference between this DateTime and right now.
   * See {@link DateTime#diff}
   * @param {string|string[]} [unit=['milliseconds']] - the unit or units units (such as 'hours' or 'days') to include in the duration
   * @param {Object} opts - options that affect the creation of the Duration
   * @param {string} [opts.conversionAccuracy='casual'] - the conversion system to use
   * @return {Duration}
   */;e.diffNow=function diffNow(e,t){void 0===e&&(e="milliseconds");void 0===t&&(t={});return this.diff(DateTime.now(),e,t)}
/**
   * Return an Interval spanning between this DateTime and another DateTime
   * @param {DateTime} otherDateTime - the other end point of the Interval
   * @return {Interval}
   */;e.until=function until(e){return this.isValid?ct.fromDateTimes(this,e):this}
/**
   * Return whether this DateTime is in the same unit of time as another DateTime.
   * Higher-order units must also be identical for this function to return `true`.
   * Note that time zones are **ignored** in this comparison, which compares the **local** calendar time. Use {@link DateTime#setZone} to convert one of the dates if needed.
   * @param {DateTime} otherDateTime - the other DateTime
   * @param {string} unit - the unit of time to check sameness on
   * @example DateTime.now().hasSame(otherDT, 'day'); //~> true if otherDT is in the same current calendar day
   * @return {boolean}
   */;e.hasSame=function hasSame(e,t){if(!this.isValid)return false;var n=e.valueOf();var r=this.setZone(e.zone,{keepLocalTime:true});return r.startOf(t)<=n&&n<=r.endOf(t)}
/**
   * Equality check
   * Two DateTimes are equal iff they represent the same millisecond, have the same zone and location, and are both valid.
   * To compare just the millisecond values, use `+dt1 === +dt2`.
   * @param {DateTime} other - the other DateTime
   * @return {boolean}
   */;e.equals=function equals(e){return this.isValid&&e.isValid&&this.valueOf()===e.valueOf()&&this.zone.equals(e.zone)&&this.loc.equals(e.loc)}
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
   */;e.toRelative=function toRelative(e){void 0===e&&(e={});if(!this.isValid)return null;var t=e.base||DateTime.fromObject({},{zone:this.zone}),n=e.padding?this<t?-e.padding:e.padding:0;var r=["years","months","days","hours","minutes","seconds"];var i=e.unit;if(Array.isArray(e.unit)){r=e.unit;i=void 0}return diffRelative(t,this.plus(n),_extends({},e,{numeric:"always",units:r,unit:i}))}
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
   */;e.toRelativeCalendar=function toRelativeCalendar(e){void 0===e&&(e={});return this.isValid?diffRelative(e.base||DateTime.fromObject({},{zone:this.zone}),this,_extends({},e,{numeric:"auto",units:["years","months","days"],calendary:true})):null}
/**
   * Return the min of several date times
   * @param {...DateTime} dateTimes - the DateTimes from which to choose the minimum
   * @return {DateTime} the min DateTime, or undefined if called with no argument
   */;DateTime.min=function min(){for(var e=arguments.length,t=new Array(e),n=0;n<e;n++)t[n]=arguments[n];if(!t.every(DateTime.isDateTime))throw new s("min requires all arguments be DateTimes");return bestBy(t,(function(e){return e.valueOf()}),Math.min)}
/**
   * Return the max of several date times
   * @param {...DateTime} dateTimes - the DateTimes from which to choose the maximum
   * @return {DateTime} the max DateTime, or undefined if called with no argument
   */;DateTime.max=function max(){for(var e=arguments.length,t=new Array(e),n=0;n<e;n++)t[n]=arguments[n];if(!t.every(DateTime.isDateTime))throw new s("max requires all arguments be DateTimes");return bestBy(t,(function(e){return e.valueOf()}),Math.max)}
/**
   * Explain how a string would be parsed by fromFormat()
   * @param {string} text - the string to parse
   * @param {string} fmt - the format the string is expected to be in (see description)
   * @param {Object} options - options taken by fromFormat()
   * @return {Object}
   */;DateTime.fromFormatExplain=function fromFormatExplain(e,t,n){void 0===n&&(n={});var r=n,i=r.locale,a=void 0===i?null:i,o=r.numberingSystem,s=void 0===o?null:o,u=we.fromOpts({locale:a,numberingSystem:s,defaultToEN:true});return explainFromTokens(u,e,t)}
/**
   * @deprecated use fromFormatExplain instead
   */;DateTime.fromStringExplain=function fromStringExplain(e,t,n){void 0===n&&(n={});return DateTime.fromFormatExplain(e,t,n)}
/**
   * {@link DateTime#toLocaleString} format like 10/14/1983
   * @type {Object}
   */;_createClass(DateTime,[{key:"isValid",get:function get(){return null===this.invalid}
/**
     * Returns an error code if this DateTime is invalid, or null if the DateTime is valid
     * @type {string}
     */},{key:"invalidReason",get:function get(){return this.invalid?this.invalid.reason:null}
/**
     * Returns an explanation of why this DateTime became invalid, or null if the DateTime is valid
     * @type {string}
     */},{key:"invalidExplanation",get:function get(){return this.invalid?this.invalid.explanation:null}
/**
     * Get the locale of a DateTime, such 'en-GB'. The locale is used when formatting the DateTime
     *
     * @type {string}
     */},{key:"locale",get:function get(){return this.isValid?this.loc.locale:null}
/**
     * Get the numbering system of a DateTime, such 'beng'. The numbering system is used when formatting the DateTime
     *
     * @type {string}
     */},{key:"numberingSystem",get:function get(){return this.isValid?this.loc.numberingSystem:null}
/**
     * Get the output calendar of a DateTime, such 'islamic'. The output calendar is used when formatting the DateTime
     *
     * @type {string}
     */},{key:"outputCalendar",get:function get(){return this.isValid?this.loc.outputCalendar:null}
/**
     * Get the time zone associated with this DateTime.
     * @type {Zone}
     */},{key:"zone",get:function get(){return this._zone}
/**
     * Get the name of the time zone.
     * @type {string}
     */},{key:"zoneName",get:function get(){return this.isValid?this.zone.name:null}
/**
     * Get the year
     * @example DateTime.local(2017, 5, 25).year //=> 2017
     * @type {number}
     */},{key:"year",get:function get(){return this.isValid?this.c.year:NaN}
/**
     * Get the quarter
     * @example DateTime.local(2017, 5, 25).quarter //=> 2
     * @type {number}
     */},{key:"quarter",get:function get(){return this.isValid?Math.ceil(this.c.month/3):NaN}
/**
     * Get the month (1-12).
     * @example DateTime.local(2017, 5, 25).month //=> 5
     * @type {number}
     */},{key:"month",get:function get(){return this.isValid?this.c.month:NaN}
/**
     * Get the day of the month (1-30ish).
     * @example DateTime.local(2017, 5, 25).day //=> 25
     * @type {number}
     */},{key:"day",get:function get(){return this.isValid?this.c.day:NaN}
/**
     * Get the hour of the day (0-23).
     * @example DateTime.local(2017, 5, 25, 9).hour //=> 9
     * @type {number}
     */},{key:"hour",get:function get(){return this.isValid?this.c.hour:NaN}
/**
     * Get the minute of the hour (0-59).
     * @example DateTime.local(2017, 5, 25, 9, 30).minute //=> 30
     * @type {number}
     */},{key:"minute",get:function get(){return this.isValid?this.c.minute:NaN}
/**
     * Get the second of the minute (0-59).
     * @example DateTime.local(2017, 5, 25, 9, 30, 52).second //=> 52
     * @type {number}
     */},{key:"second",get:function get(){return this.isValid?this.c.second:NaN}
/**
     * Get the millisecond of the second (0-999).
     * @example DateTime.local(2017, 5, 25, 9, 30, 52, 654).millisecond //=> 654
     * @type {number}
     */},{key:"millisecond",get:function get(){return this.isValid?this.c.millisecond:NaN}
/**
     * Get the week year
     * @see https://en.wikipedia.org/wiki/ISO_week_date
     * @example DateTime.local(2014, 12, 31).weekYear //=> 2015
     * @type {number}
     */},{key:"weekYear",get:function get(){return this.isValid?possiblyCachedWeekData(this).weekYear:NaN}
/**
     * Get the week number of the week year (1-52ish).
     * @see https://en.wikipedia.org/wiki/ISO_week_date
     * @example DateTime.local(2017, 5, 25).weekNumber //=> 21
     * @type {number}
     */},{key:"weekNumber",get:function get(){return this.isValid?possiblyCachedWeekData(this).weekNumber:NaN}
/**
     * Get the day of the week.
     * 1 is Monday and 7 is Sunday
     * @see https://en.wikipedia.org/wiki/ISO_week_date
     * @example DateTime.local(2014, 11, 31).weekday //=> 4
     * @type {number}
     */},{key:"weekday",get:function get(){return this.isValid?possiblyCachedWeekData(this).weekday:NaN}
/**
     * Get the ordinal (meaning the day of the year)
     * @example DateTime.local(2017, 5, 25).ordinal //=> 145
     * @type {number|DateTime}
     */},{key:"ordinal",get:function get(){return this.isValid?gregorianToOrdinal(this.c).ordinal:NaN}
/**
     * Get the human readable short month name, such as 'Oct'.
     * Defaults to the system's locale if no locale has been specified
     * @example DateTime.local(2017, 10, 30).monthShort //=> Oct
     * @type {string}
     */},{key:"monthShort",get:function get(){return this.isValid?ft.months("short",{locObj:this.loc})[this.month-1]:null}
/**
     * Get the human readable long month name, such as 'October'.
     * Defaults to the system's locale if no locale has been specified
     * @example DateTime.local(2017, 10, 30).monthLong //=> October
     * @type {string}
     */},{key:"monthLong",get:function get(){return this.isValid?ft.months("long",{locObj:this.loc})[this.month-1]:null}
/**
     * Get the human readable short weekday, such as 'Mon'.
     * Defaults to the system's locale if no locale has been specified
     * @example DateTime.local(2017, 10, 30).weekdayShort //=> Mon
     * @type {string}
     */},{key:"weekdayShort",get:function get(){return this.isValid?ft.weekdays("short",{locObj:this.loc})[this.weekday-1]:null}
/**
     * Get the human readable long weekday, such as 'Monday'.
     * Defaults to the system's locale if no locale has been specified
     * @example DateTime.local(2017, 10, 30).weekdayLong //=> Monday
     * @type {string}
     */},{key:"weekdayLong",get:function get(){return this.isValid?ft.weekdays("long",{locObj:this.loc})[this.weekday-1]:null}
/**
     * Get the UTC offset of this DateTime in minutes
     * @example DateTime.now().offset //=> -240
     * @example DateTime.utc().offset //=> 0
     * @type {number}
     */},{key:"offset",get:function get(){return this.isValid?+this.o:NaN}
/**
     * Get the short human name for the zone's current offset, for example "EST" or "EDT".
     * Defaults to the system's locale if no locale has been specified
     * @type {string}
     */},{key:"offsetNameShort",get:function get(){return this.isValid?this.zone.offsetName(this.ts,{format:"short",locale:this.locale}):null}
/**
     * Get the long human name for the zone's current offset, for example "Eastern Standard Time" or "Eastern Daylight Time".
     * Defaults to the system's locale if no locale has been specified
     * @type {string}
     */},{key:"offsetNameLong",get:function get(){return this.isValid?this.zone.offsetName(this.ts,{format:"long",locale:this.locale}):null}
/**
     * Get whether this zone's offset ever changes, as in a DST.
     * @type {boolean}
     */},{key:"isOffsetFixed",get:function get(){return this.isValid?this.zone.isUniversal:null}
/**
     * Get whether the DateTime is in a DST.
     * @type {boolean}
     */},{key:"isInDST",get:function get(){return!this.isOffsetFixed&&(this.offset>this.set({month:1,day:1}).offset||this.offset>this.set({month:5}).offset)}
/**
     * Returns true if this DateTime is in a leap year, false otherwise
     * @example DateTime.local(2016).isInLeapYear //=> true
     * @example DateTime.local(2013).isInLeapYear //=> false
     * @type {boolean}
     */},{key:"isInLeapYear",get:function get(){return isLeapYear(this.year)}
/**
     * Returns the number of days in this DateTime's month
     * @example DateTime.local(2016, 2).daysInMonth //=> 29
     * @example DateTime.local(2016, 3).daysInMonth //=> 31
     * @type {number}
     */},{key:"daysInMonth",get:function get(){return daysInMonth(this.year,this.month)}
/**
     * Returns the number of days in this DateTime's year
     * @example DateTime.local(2016).daysInYear //=> 366
     * @example DateTime.local(2013).daysInYear //=> 365
     * @type {number}
     */},{key:"daysInYear",get:function get(){return this.isValid?daysInYear(this.year):NaN}
/**
     * Returns the number of weeks in this DateTime's year
     * @see https://en.wikipedia.org/wiki/ISO_week_date
     * @example DateTime.local(2004).weeksInWeekYear //=> 53
     * @example DateTime.local(2013).weeksInWeekYear //=> 52
     * @type {number}
     */},{key:"weeksInWeekYear",get:function get(){return this.isValid?weeksInWeekYear(this.weekYear):NaN}}],[{key:"DATE_SHORT",get:function get(){return d}
/**
     * {@link DateTime#toLocaleString} format like 'Oct 14, 1983'
     * @type {Object}
     */},{key:"DATE_MED",get:function get(){return m}
/**
     * {@link DateTime#toLocaleString} format like 'Fri, Oct 14, 1983'
     * @type {Object}
     */},{key:"DATE_MED_WITH_WEEKDAY",get:function get(){return h}
/**
     * {@link DateTime#toLocaleString} format like 'October 14, 1983'
     * @type {Object}
     */},{key:"DATE_FULL",get:function get(){return v}
/**
     * {@link DateTime#toLocaleString} format like 'Tuesday, October 14, 1983'
     * @type {Object}
     */},{key:"DATE_HUGE",get:function get(){return y}
/**
     * {@link DateTime#toLocaleString} format like '09:30 AM'. Only 12-hour if the locale is.
     * @type {Object}
     */},{key:"TIME_SIMPLE",get:function get(){return g}
/**
     * {@link DateTime#toLocaleString} format like '09:30:23 AM'. Only 12-hour if the locale is.
     * @type {Object}
     */},{key:"TIME_WITH_SECONDS",get:function get(){return p}
/**
     * {@link DateTime#toLocaleString} format like '09:30:23 AM EDT'. Only 12-hour if the locale is.
     * @type {Object}
     */},{key:"TIME_WITH_SHORT_OFFSET",get:function get(){return T}
/**
     * {@link DateTime#toLocaleString} format like '09:30:23 AM Eastern Daylight Time'. Only 12-hour if the locale is.
     * @type {Object}
     */},{key:"TIME_WITH_LONG_OFFSET",get:function get(){return O}
/**
     * {@link DateTime#toLocaleString} format like '09:30', always 24-hour.
     * @type {Object}
     */},{key:"TIME_24_SIMPLE",get:function get(){return w}
/**
     * {@link DateTime#toLocaleString} format like '09:30:23', always 24-hour.
     * @type {Object}
     */},{key:"TIME_24_WITH_SECONDS",get:function get(){return S}
/**
     * {@link DateTime#toLocaleString} format like '09:30:23 EDT', always 24-hour.
     * @type {Object}
     */},{key:"TIME_24_WITH_SHORT_OFFSET",get:function get(){return k}
/**
     * {@link DateTime#toLocaleString} format like '09:30:23 Eastern Daylight Time', always 24-hour.
     * @type {Object}
     */},{key:"TIME_24_WITH_LONG_OFFSET",get:function get(){return I}
/**
     * {@link DateTime#toLocaleString} format like '10/14/1983, 9:30 AM'. Only 12-hour if the locale is.
     * @type {Object}
     */},{key:"DATETIME_SHORT",get:function get(){return D}
/**
     * {@link DateTime#toLocaleString} format like '10/14/1983, 9:30:33 AM'. Only 12-hour if the locale is.
     * @type {Object}
     */},{key:"DATETIME_SHORT_WITH_SECONDS",get:function get(){return b}
/**
     * {@link DateTime#toLocaleString} format like 'Oct 14, 1983, 9:30 AM'. Only 12-hour if the locale is.
     * @type {Object}
     */},{key:"DATETIME_MED",get:function get(){return x}
/**
     * {@link DateTime#toLocaleString} format like 'Oct 14, 1983, 9:30:33 AM'. Only 12-hour if the locale is.
     * @type {Object}
     */},{key:"DATETIME_MED_WITH_SECONDS",get:function get(){return N}
/**
     * {@link DateTime#toLocaleString} format like 'Fri, 14 Oct 1983, 9:30 AM'. Only 12-hour if the locale is.
     * @type {Object}
     */},{key:"DATETIME_MED_WITH_WEEKDAY",get:function get(){return F}
/**
     * {@link DateTime#toLocaleString} format like 'October 14, 1983, 9:30 AM EDT'. Only 12-hour if the locale is.
     * @type {Object}
     */},{key:"DATETIME_FULL",get:function get(){return M}
/**
     * {@link DateTime#toLocaleString} format like 'October 14, 1983, 9:30:33 AM EDT'. Only 12-hour if the locale is.
     * @type {Object}
     */},{key:"DATETIME_FULL_WITH_SECONDS",get:function get(){return E}
/**
     * {@link DateTime#toLocaleString} format like 'Friday, October 14, 1983, 9:30 AM Eastern Daylight Time'. Only 12-hour if the locale is.
     * @type {Object}
     */},{key:"DATETIME_HUGE",get:function get(){return _}
/**
     * {@link DateTime#toLocaleString} format like 'Friday, October 14, 1983, 9:30:33 AM Eastern Daylight Time'. Only 12-hour if the locale is.
     * @type {Object}
     */},{key:"DATETIME_HUGE_WITH_SECONDS",get:function get(){return Z}}]);return DateTime}();function friendlyDateTime(e){if(Et.isDateTime(e))return e;if(e&&e.valueOf&&isNumber(e.valueOf()))return Et.fromJSDate(e);if(e&&"object"===typeof e)return Et.fromObject(e);throw new s("Unknown datetime argument: "+e+", of type "+typeof e)}var _t="2.4.0";e.DateTime=Et;e.Duration=ut;e.FixedOffsetZone=ne;e.IANAZone=ee;e.Info=ft;e.Interval=ct;e.InvalidZone=re;e.Settings=ce;e.SystemZone=B;e.VERSION=_t;e.Zone=G;const Zt=e.__esModule;const Lt=e.DateTime,Ct=e.Duration,Vt=e.FixedOffsetZone,At=e.IANAZone,Ut=e.Info,Rt=e.Interval,jt=e.InvalidZone,zt=e.Settings,Pt=e.SystemZone,qt=e.VERSION,Wt=e.Zone;export{Lt as DateTime,Ct as Duration,Vt as FixedOffsetZone,At as IANAZone,Ut as Info,Rt as Interval,jt as InvalidZone,zt as Settings,Pt as SystemZone,qt as VERSION,Wt as Zone,Zt as __esModule,e as default};

