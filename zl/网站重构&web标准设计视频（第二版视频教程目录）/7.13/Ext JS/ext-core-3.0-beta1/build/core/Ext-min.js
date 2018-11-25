/*
 * Ext Core Library 3.0 Beta
 * http://extjs.com/
 * Copyright(c) 2006-2009, Ext JS, LLC.
 * 
 * The MIT License
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 * 
 */


Ext={version:'3.0'};window.undefined=window.undefined;Ext.apply=function(o,c,defaults){if(defaults)Ext.apply(o,defaults)
if(o&&c&&typeof c=='object'){for(var p in c){o[p]=c[p];}}
return o;};(function(){var idSeed=0,ua=navigator.userAgent.toLowerCase(),check=function(r){return r.test(ua);},isStrict=document.compatMode=="CSS1Compat",isOpera=check(/opera/),isChrome=check(/chrome/),isWebKit=check(/webkit/),isSafari=!isChrome&&check(/safari/),isSafari3=isSafari&&check(/version\/3/),isSafari4=isSafari&&check(/version\/4/),isIE=!isOpera&&check(/msie/),isIE7=isIE&&check(/msie 7/),isIE8=isIE&&check(/msie 8/),isGecko=!isWebKit&&check(/gecko/),isGecko3=isGecko&&check(/rv:1\.9/),isBorderBox=isIE&&!isStrict,isWindows=check(/windows|win32/),isMac=check(/macintosh|mac os x/),isAir=check(/adobeair/),isLinux=check(/linux/),isSecure=/^https/i.test(window.location.protocol);if(isIE&&!isIE7){try{document.execCommand("BackgroundImageCache",false,true);}catch(e){}}
Ext.apply(Ext,{isStrict:isStrict,isSecure:isSecure,isReady:false,enableGarbageCollector:true,enableListenerCollection:false,applyIf:function(o,c){if(o){for(var p in c){if(Ext.isEmpty(o[p])){o[p]=c[p];}}}
return o;},id:function(el,prefix){return(el=Ext.getDom(el)||{}).id=el.id||(prefix||"ext-gen")+(++idSeed);},extend:function(){var io=function(o){for(var m in o){this[m]=o[m];}};var oc=Object.prototype.constructor;return function(sb,sp,overrides){if(Ext.isObject(sp)){overrides=sp;sp=sb;sb=overrides.constructor!=oc?overrides.constructor:function(){sp.apply(this,arguments);};}
var F=function(){},sbp,spp=sp.prototype;F.prototype=spp;sbp=sb.prototype=new F();sbp.constructor=sb;sb.superclass=spp;if(spp.constructor==oc){spp.constructor=sp;}
sb.override=function(o){Ext.override(sb,o);};sbp.superclass=sbp.supr=(function(){return spp;});sbp.override=io;Ext.override(sb,overrides);sb.extend=function(o){Ext.extend(sb,o);};return sb;};}(),override:function(origclass,overrides){if(overrides){var p=origclass.prototype;Ext.apply(p,overrides);if(Ext.isIE&&overrides.toString!=origclass.toString){p.toString=overrides.toString;}}},namespace:function(){var o,d;Ext.each(arguments,function(v){d=v.split(".");o=window[d[0]]=window[d[0]]||{};Ext.each(d.slice(1),function(v2){o=o[v2]=o[v2]||{};});});return o;},urlEncode:function(o,pre){var buf=[],key,e=encodeURIComponent;for(key in o){Ext.each(o[key]||key,function(val,i){buf.push("&",e(key),"=",val!=key?e(val):"");});}
if(!pre){buf.shift();pre="";}
return pre+buf.join('');},urlDecode:function(string,overwrite){var obj={},pairs=string.split('&'),d=decodeURIComponent,name,value;Ext.each(pairs,function(pair){pair=pair.split('=');name=d(pair[0]);value=d(pair[1]);obj[name]=overwrite||!obj[name]?value:[].concat(obj[name]).concat(value);});return obj;},toArray:function(){return isIE?function(a,i,j,res){res=[];Ext.each(a,function(v){res.push(v);});return res.slice(i||0,j||res.length);}:function(a,i,j){return Array.prototype.slice.call(a,i||0,j||a.length);}}(),each:function(array,fn,scope){if(Ext.isEmpty(array,true))return;if(typeof array.length=="undefined"||typeof array=="string"){array=[array];}
for(var i=0,len=array.length;i<len;i++){if(fn.call(scope||array[i],array[i],i,array)===false){return i;};}},getDom:function(el){if(!el||!document){return null;}
return el.dom?el.dom:(typeof el=='string'?document.getElementById(el):el);},getBody:function(){return Ext.get(document.body||document.documentElement);},removeNode:isIE?function(){var d;return function(n){if(n&&n.tagName!='BODY'){d=d||document.createElement('div');d.appendChild(n);d.innerHTML='';}}}():function(n){if(n&&n.parentNode&&n.tagName!='BODY'){n.parentNode.removeChild(n);}},isEmpty:function(v,allowBlank){return v===null||v===undefined||((Ext.isArray(v)&&!v.length))||(!allowBlank?v==='':false);},isArray:function(v){return Object.prototype.toString.apply(v)==='[object Array]';},isObject:function(v){return v&&typeof v=="object";},isPrimitive:function(v){var t=typeof v;return t=='string'||t=='number'||t=='boolean';},isFunction:function(v){return typeof v=="function";},isOpera:isOpera,isWebKit:isWebKit,isChrome:isChrome,isSafari:isSafari,isSafari3:isSafari3,isSafari4:isSafari4,isSafari2:isSafari&&!isSafari3,isIE:isIE,isIE6:isIE&&!isIE7&&!isIE8,isIE7:isIE7,isIE8:isIE8,isGecko:isGecko,isGecko2:isGecko&&!isGecko3,isGecko3:isGecko3,isBorderBox:isBorderBox,isLinux:isLinux,isWindows:isWindows,isMac:isMac,isAir:isAir});Ext.ns=Ext.namespace;})();Ext.ns("Ext","Ext.util","Ext.lib","Ext.data");Ext.apply(Function.prototype,{createInterceptor:function(fcn,scope){var method=this;return!Ext.isFunction(fcn)?this:function(){var me=this,args=arguments;fcn.target=me;fcn.method=method;return(fcn.apply(scope||me||window,args)!==false)?method.apply(me||window,args):null;};},createCallback:function(){var args=arguments,method=this;return function(){return method.apply(window,args);};},createDelegate:function(obj,args,appendArgs){var method=this;return function(){var callArgs=args||arguments;if(appendArgs===true){callArgs=Array.prototype.slice.call(arguments,0);callArgs=callArgs.concat(args);}else if(typeof appendArgs=="number"){callArgs=Array.prototype.slice.call(arguments,0);var applyArgs=[appendArgs,0].concat(args);Array.prototype.splice.apply(callArgs,applyArgs);}
return method.apply(obj||window,callArgs);};},defer:function(millis,obj,args,appendArgs){var fn=this.createDelegate(obj,args,appendArgs);if(millis){return setTimeout(fn,millis);}
fn();return 0;}});Ext.applyIf(String,{format:function(format){var args=Ext.toArray(arguments,1);return format.replace(/\{(\d+)\}/g,function(m,i){return args[i];});}});Ext.applyIf(Array.prototype,{indexOf:function(o){for(var i=0,len=this.length;i<len;i++){if(this[i]==o)return i;}
return-1;},remove:function(o){var index=this.indexOf(o);if(index!=-1){this.splice(index,1);}
return this;}});