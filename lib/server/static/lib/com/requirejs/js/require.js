/** vim: et:ts=4:sw=4:sts=4
 * @license RequireJS 2.1.9 Copyright (c) 2010-2012, The Dojo Foundation All Rights Reserved.
 * Available via the MIT or new BSD license.
 * see: http://github.com/jrburke/requirejs for details
 */
//Not using strict: uneven strict support in browsers, #392, and causes
//problems with requirejs.exec()/transpiler plugins that may not be strict.
/*jslint regexp: true, nomen: true, sloppy: true */
/*global window, navigator, document, importScripts, setTimeout, opera */
var requirejs,require,define;!function(global){function isFunction(a){return"[object Function]"===ostring.call(a)}function isArray(a){return"[object Array]"===ostring.call(a)}/**
     * Helper function for iterating over an array. If the func returns
     * a true value, it will break out of the loop.
     */
function each(a,b){if(a){var c;for(c=0;c<a.length&&(!a[c]||!b(a[c],c,a));c+=1);}}/**
     * Helper function for iterating over an array backwards. If the func
     * returns a true value, it will break out of the loop.
     */
function eachReverse(a,b){if(a){var c;for(c=a.length-1;c>-1&&(!a[c]||!b(a[c],c,a));c-=1);}}function hasProp(a,b){return hasOwn.call(a,b)}function getOwn(a,b){return hasProp(a,b)&&a[b]}/**
     * Cycles over properties in an object and calls a function for each
     * property value. If the function returns a truthy value, then the
     * iteration is stopped.
     */
function eachProp(a,b){var c;for(c in a)if(hasProp(a,c)&&b(a[c],c))break}/**
     * Simple function to mix in properties from source into target,
     * but only if target does not already have a property of the same name.
     */
function mixin(a,b,c,d){return b&&eachProp(b,function(b,e){(c||!hasProp(a,e))&&(d&&"string"!=typeof b?(a[e]||(a[e]={}),mixin(a[e],b,c,d)):a[e]=b)}),a}//Similar to Function.prototype.bind, but the 'this' object is specified
//first, since it is easier to read/figure out what 'this' will be.
function bind(a,b){return function(){return b.apply(a,arguments)}}function scripts(){return document.getElementsByTagName("script")}function defaultOnError(a){throw a}//Allow getting a global that expressed in
//dot notation, like 'a.b.c'.
function getGlobal(a){if(!a)return a;var b=global;return each(a.split("."),function(a){b=b[a]}),b}/**
     * Constructs an error with a pointer to an URL with more information.
     * @param {String} id the error ID that maps to an ID on a web page.
     * @param {String} message human readable error.
     * @param {Error} [err] the original error, if there is one.
     *
     * @returns {Error}
     */
function makeError(a,b,c,d){var e=new Error(b+"\nhttp://requirejs.org/docs/errors.html#"+a);return e.requireType=a,e.requireModules=d,c&&(e.originalError=c),e}function newContext(a){/**
         * Trims the . and .. from an array of path segments.
         * It will keep a leading path segment if a .. will become
         * the first path segment, to help with module name lookups,
         * which act like paths, but can be remapped. But the end result,
         * all paths that use this function should look normalized.
         * NOTE: this method MODIFIES the input array.
         * @param {Array} ary the array of path segments.
         */
function b(a){var b,c;for(b=0;a[b];b+=1)if(c=a[b],"."===c)a.splice(b,1),b-=1;else if(".."===c){if(1===b&&(".."===a[2]||".."===a[0]))//End of the line. Keep at least one non-dot
//path segment at the front so it can be mapped
//correctly to disk. Otherwise, there is likely
//no path mapping for a path starting with '..'.
//This can still fail, but catches the most reasonable
//uses of ..
break;b>0&&(a.splice(b-1,2),b-=2)}}/**
         * Given a relative module name, like ./something, normalize it to
         * a real name that can be mapped to a path.
         * @param {String} name the relative name
         * @param {String} baseName a real name that the name arg is relative
         * to.
         * @param {Boolean} applyMap apply the map config to the value. Should
         * only be done if this normalization is for a dependency ID.
         * @returns {String} normalized name
         */
function c(a,c,d){var e,f,g,h,i,j,k,l,m,n,o,p=c&&c.split("/"),q=p,r=x.map,s=r&&r["*"];//Apply map config if available.
if(//Adjust any relative paths.
a&&"."===a.charAt(0)&&(//If have a base name, try to normalize against it,
//otherwise, assume it is a top-level require that will
//be relative to baseUrl in the end.
c?(//If the baseName is a package name, then just treat it as one
//name to concat the name with.
q=getOwn(x.pkgs,c)?p=[c]:p.slice(0,p.length-1),a=q.concat(a.split("/")),b(a),//Some use of packages may use a . path to reference the
//'main' module name, so normalize for that.
f=getOwn(x.pkgs,e=a[0]),a=a.join("/"),f&&a===e+"/"+f.main&&(a=e)):0===a.indexOf("./")&&(// No baseName, so this is ID is resolved relative
// to baseUrl, pull off the leading dot.
a=a.substring(2))),d&&r&&(p||s)){for(h=a.split("/"),i=h.length;i>0;i-=1){if(k=h.slice(0,i).join("/"),p)//Find the longest baseName segment match in the config.
//So, do joins on the biggest to smallest lengths of baseParts.
for(j=p.length;j>0;j-=1)//baseName segment has config, find if it has one for
//this name.
if(g=getOwn(r,p.slice(0,j).join("/")),g&&(g=getOwn(g,k))){//Match, update name to the new value.
l=g,m=i;break}if(l)break;//Check for a star map match, but just hold on to it,
//if there is a shorter segment match later in a matching
//config, then favor over this star map.
!n&&s&&getOwn(s,k)&&(n=getOwn(s,k),o=i)}!l&&n&&(l=n,m=o),l&&(h.splice(0,m,l),a=h.join("/"))}return a}function d(a){isBrowser&&each(scripts(),function(b){return b.getAttribute("data-requiremodule")===a&&b.getAttribute("data-requirecontext")===u.contextName?(b.parentNode.removeChild(b),!0):void 0})}function e(a){var b=getOwn(x.paths,a);return b&&isArray(b)&&b.length>1?(//Pop off the first array value, since it failed, and
//retry
b.shift(),u.require.undef(a),u.require([a]),!0):void 0}//Turns a plugin!resource to [plugin, resource]
//with the plugin being undefined if the name
//did not have a plugin prefix.
function f(a){var b,c=a?a.indexOf("!"):-1;return c>-1&&(b=a.substring(0,c),a=a.substring(c+1,a.length)),[b,a]}/**
         * Creates a module mapping that includes plugin prefix, module
         * name, and path. If parentModuleMap is provided it will
         * also normalize the name via require.normalize()
         *
         * @param {String} name the module name
         * @param {String} [parentModuleMap] parent module map
         * for the module name, used to resolve relative names.
         * @param {Boolean} isNormalized: is the ID already normalized.
         * This is true if this call is done for a define() module ID.
         * @param {Boolean} applyMap: apply the map config to the ID.
         * Should only be true if this map is for a dependency.
         *
         * @returns {Object}
         */
function g(a,b,d,e){var g,h,i,j,k=null,l=b?b.name:null,m=a,n=!0,o="";//If no name, then it means it is a require call, generate an
//internal name.
return a||(n=!1,a="_@r"+(E+=1)),j=f(a),k=j[0],a=j[1],k&&(k=c(k,l,e),h=getOwn(C,k)),//Account for relative paths if there is a base name.
a&&(k?//Plugin is loaded, use its normalize method.
o=h&&h.normalize?h.normalize(a,function(a){return c(a,l,e)}):c(a,l,e):(//A regular module.
o=c(a,l,e),//Normalized name may be a plugin ID due to map config
//application in normalize. The map config values must
//already be normalized, so do not need to redo that part.
j=f(o),k=j[0],o=j[1],d=!0,g=u.nameToUrl(o))),//If the id is a plugin id that cannot be determined if it needs
//normalization, stamp it with a unique ID so two matching relative
//ids that may conflict can be separate.
i=!k||h||d?"":"_unnormalized"+(F+=1),{prefix:k,name:o,parentMap:b,unnormalized:!!i,url:g,originalName:m,isDefine:n,id:(k?k+"!"+o:o)+i}}function h(a){var b=a.id,c=getOwn(y,b);return c||(c=y[b]=new u.Module(a)),c}function i(a,b,c){var d=a.id,e=getOwn(y,d);!hasProp(C,d)||e&&!e.defineEmitComplete?(e=h(a),e.error&&"error"===b?c(e.error):e.on(b,c)):"defined"===b&&c(C[d])}function j(a,b){var c=a.requireModules,d=!1;b?b(a):(each(c,function(b){var c=getOwn(y,b);c&&(//Set error on module, so it skips timeout checks.
c.error=a,c.events.error&&(d=!0,c.emit("error",a)))}),d||req.onError(a))}/**
         * Internal method to transfer globalQueue items to this context's
         * defQueue.
         */
function k(){//Push all the globalDefQueue items into the context's defQueue
globalDefQueue.length&&(//Array splice in the values since the context code has a
//local var ref to defQueue, so cannot just reassign the one
//on context.
apsp.apply(B,[B.length-1,0].concat(globalDefQueue)),globalDefQueue=[])}function l(a){//Clean up machinery used for waiting modules.
delete y[a],delete z[a]}function m(a,b,c){var d=a.map.id;a.error?a.emit("error",a.error):(b[d]=!0,each(a.depMaps,function(d,e){var f=d.id,g=getOwn(y,f);//Only force things that have not completed
//being defined, so still in the registry,
//and only if it has not been matched up
//in the module already.
!g||a.depMatched[e]||c[f]||(getOwn(b,f)?(a.defineDep(e,C[f]),a.check()):m(g,b,c))}),c[d]=!0)}function n(){var a,b,c,f,g=1e3*x.waitSeconds,//It is possible to disable the wait interval by using waitSeconds of 0.
h=g&&u.startTime+g<(new Date).getTime(),i=[],k=[],l=!1,o=!0;//Do not bother if this call was a result of a cycle break.
if(!s){if(s=!0,//Figure out the state of all the modules.
eachProp(z,function(c){//Skip things that are not enabled or in error state.
if(a=c.map,b=a.id,c.enabled&&(a.isDefine||k.push(c),!c.error))//If the module should be executed, and it has not
//been inited and time is up, remember it.
if(!c.inited&&h)e(b)?(f=!0,l=!0):(i.push(b),d(b));else if(!c.inited&&c.fetched&&a.isDefine&&(l=!0,!a.prefix))//No reason to keep looking for unfinished
//loading. If the only stillLoading is a
//plugin resource though, keep going,
//because it may be that a plugin resource
//is waiting on a non-plugin cycle.
return o=!1}),h&&i.length)//If wait time expired, throw error of unloaded modules.
return c=makeError("timeout","Load timeout for modules: "+i,null,i),c.contextName=u.contextName,j(c);//Not expired, check for a cycle.
o&&each(k,function(a){m(a,{},{})}),//If still waiting on loads, and the waiting load is something
//other than a plugin resource, or there are still outstanding
//scripts, then just try back later.
h&&!f||!l||//Something is still waiting to load. Wait for it, but only
//if a timeout is not already in effect.
!isBrowser&&!isWebWorker||w||(w=setTimeout(function(){w=0,n()},50)),s=!1}}function o(a){//Skip modules already defined.
hasProp(C,a[0])||h(g(a[0],null,!0)).init(a[1],a[2])}function p(a,b,c,d){//Favor detachEvent because of IE9
//issue, see attachEvent/addEventListener comment elsewhere
//in this file.
a.detachEvent&&!isOpera?//Probably IE. If not it will throw an error, which will be
//useful to know.
d&&a.detachEvent(d,b):a.removeEventListener(c,b,!1)}/**
         * Given an event from a script node, get the requirejs info from it,
         * and then removes the event listeners on the node.
         * @param {Event} evt
         * @returns {Object}
         */
function q(a){//Using currentTarget instead of target for Firefox 2.0's sake. Not
//all old browsers will be supported, but this one was easy enough
//to support and still makes sense.
var b=a.currentTarget||a.srcElement;//Remove the listeners once here.
return p(b,u.onScriptLoad,"load","onreadystatechange"),p(b,u.onScriptError,"error"),{node:b,id:b&&b.getAttribute("data-requiremodule")}}function r(){var a;//Make sure any remaining defQueue items get properly processed.
for(//Any defined modules in the global queue, intake them now.
k();B.length;){if(a=B.shift(),null===a[0])return j(makeError("mismatch","Mismatched anonymous define() module: "+a[a.length-1]));//args are id, deps, factory. Should be normalized by the
//define() function.
o(a)}}var s,t,u,v,w,x={//Defaults. Do not set a default for map
//config to speed up normalize(), which
//will run faster if there is no default.
waitSeconds:7,baseUrl:"./",paths:{},pkgs:{},shim:{},config:{}},y={},//registry of just enabled modules, to speed
//cycle breaking code when lots of modules
//are registered, but not activated.
z={},A={},B=[],C={},D={},E=1,F=1;return v={require:function(a){return a.require?a.require:a.require=u.makeRequire(a.map)},exports:function(a){return a.usingExports=!0,a.map.isDefine?a.exports?a.exports:a.exports=C[a.map.id]={}:void 0},module:function(a){return a.module?a.module:a.module={id:a.map.id,uri:a.map.url,config:function(){var b,c=getOwn(x.pkgs,a.map.id);// For packages, only support config targeted
// at the main module.
return b=c?getOwn(x.config,a.map.id+"/"+c.main):getOwn(x.config,a.map.id),b||{}},exports:C[a.map.id]}}},t=function(a){this.events=getOwn(A,a.id)||{},this.map=a,this.shim=getOwn(x.shim,a.id),this.depExports=[],this.depMaps=[],this.depMatched=[],this.pluginMaps={},this.depCount=0},t.prototype={init:function(a,b,c,d){d=d||{},//Do not do more inits if already done. Can happen if there
//are multiple define calls for the same module. That is not
//a normal, common case, but it is also not unexpected.
this.inited||(this.factory=b,c?//Register for errors on this module.
this.on("error",c):this.events.error&&(//If no errback already, but there are error listeners
//on this module, set up an errback to pass to the deps.
c=bind(this,function(a){this.emit("error",a)})),//Do a copy of the dependency array, so that
//source inputs are not modified. For example
//"shim" deps are passed in here directly, and
//doing a direct modification of the depMaps array
//would affect that config.
this.depMaps=a&&a.slice(0),this.errback=c,//Indicate this module has be initialized
this.inited=!0,this.ignore=d.ignore,//Could have option to init this module in enabled mode,
//or could have been previously marked as enabled. However,
//the dependencies are not known until init is called. So
//if enabled previously, now trigger dependencies as enabled.
d.enabled||this.enabled?//Enable this module and dependencies.
//Will call this.check()
this.enable():this.check())},defineDep:function(a,b){//Because of cycles, defined callback for a given
//export can be called more than once.
this.depMatched[a]||(this.depMatched[a]=!0,this.depCount-=1,this.depExports[a]=b)},fetch:function(){if(!this.fetched){this.fetched=!0,u.startTime=(new Date).getTime();var a=this.map;//If the manager is for a plugin managed resource,
//ask the plugin to load it now.
//If the manager is for a plugin managed resource,
//ask the plugin to load it now.
return this.shim?(u.makeRequire(this.map,{enableBuildCallback:!0})(this.shim.deps||[],bind(this,function(){return a.prefix?this.callPlugin():this.load()})),void 0):a.prefix?this.callPlugin():this.load()}},load:function(){var a=this.map.url;//Regular dependency.
D[a]||(D[a]=!0,u.load(this.map.id,a))},/**
             * Checks if the module is ready to define itself, and if so,
             * define it.
             */
check:function(){if(this.enabled&&!this.enabling){var a,b,c=this.map.id,d=this.depExports,e=this.exports,f=this.factory;if(this.inited){if(this.error)this.emit("error",this.error);else if(!this.defining){if(//The factory could trigger another require call
//that would result in checking this module to
//define itself again. If already in the process
//of doing that, skip this work.
this.defining=!0,this.depCount<1&&!this.defined){if(isFunction(f)){//If there is an error listener, favor passing
//to that instead of throwing an error. However,
//only do it for define()'d  modules. require
//errbacks should not be called for failures in
//their callbacks (#699). However if a global
//onError is set, use that.
if(this.events.error&&this.map.isDefine||req.onError!==defaultOnError)try{e=u.execCb(c,f,d,e)}catch(g){a=g}else e=u.execCb(c,f,d,e);if(this.map.isDefine&&(//If setting exports via 'module' is in play,
//favor that over return value and exports. After that,
//favor a non-undefined return value over exports use.
b=this.module,b&&void 0!==b.exports&&//Make sure it is not already the exports value
b.exports!==this.exports?e=b.exports:void 0===e&&this.usingExports&&(//exports already set the defined value.
e=this.exports)),a)return a.requireMap=this.map,a.requireModules=this.map.isDefine?[this.map.id]:null,a.requireType=this.map.isDefine?"define":"require",j(this.error=a)}else//Just a literal value
e=f;this.exports=e,this.map.isDefine&&!this.ignore&&(C[c]=e,req.onResourceLoad&&req.onResourceLoad(u,this.map,this.depMaps)),//Clean up
l(c),this.defined=!0}//Finished the define stage. Allow calling check again
//to allow define notifications below in the case of a
//cycle.
this.defining=!1,this.defined&&!this.defineEmitted&&(this.defineEmitted=!0,this.emit("defined",this.exports),this.defineEmitComplete=!0)}}else this.fetch()}},callPlugin:function(){var a=this.map,b=a.id,//Map already normalized the prefix.
d=g(a.prefix);//Mark this as a dependency for this plugin, so it
//can be traced for cycles.
this.depMaps.push(d),i(d,"defined",bind(this,function(d){var e,f,k,m=this.map.name,n=this.map.parentMap?this.map.parentMap.name:null,o=u.makeRequire(a.parentMap,{enableBuildCallback:!0});//If current map is not normalized, wait for that
//normalized name to load instead of continuing.
//If current map is not normalized, wait for that
//normalized name to load instead of continuing.
return this.map.unnormalized?(//Normalize the ID if the plugin allows it.
d.normalize&&(m=d.normalize(m,function(a){return c(a,n,!0)})||""),//prefix and name should already be normalized, no need
//for applying map config again either.
f=g(a.prefix+"!"+m,this.map.parentMap),i(f,"defined",bind(this,function(a){this.init([],function(){return a},null,{enabled:!0,ignore:!0})})),k=getOwn(y,f.id),k&&(//Mark this as a dependency for this plugin, so it
//can be traced for cycles.
this.depMaps.push(f),this.events.error&&k.on("error",bind(this,function(a){this.emit("error",a)})),k.enable()),void 0):(e=bind(this,function(a){this.init([],function(){return a},null,{enabled:!0})}),e.error=bind(this,function(a){this.inited=!0,this.error=a,a.requireModules=[b],//Remove temp unnormalized modules for this module,
//since they will never be resolved otherwise now.
eachProp(y,function(a){0===a.map.id.indexOf(b+"_unnormalized")&&l(a.map.id)}),j(a)}),//Allow plugins to load other code without having to know the
//context or how to 'complete' the load.
e.fromText=bind(this,function(c,d){/*jslint evil: true */
var f=a.name,i=g(f),k=useInteractive;//As of 2.1.0, support just passing the text, to reinforce
//fromText only being called once per resource. Still
//support old style of passing moduleName but discard
//that moduleName in favor of the internal ref.
d&&(c=d),//Turn off interactive script matching for IE for any define
//calls in the text, then turn it back on at the end.
k&&(useInteractive=!1),//Prime the system by creating a module instance for
//it.
h(i),//Transfer any config to this other module.
hasProp(x.config,b)&&(x.config[f]=x.config[b]);try{req.exec(c)}catch(l){return j(makeError("fromtexteval","fromText eval for "+b+" failed: "+l,l,[b]))}k&&(useInteractive=!0),//Mark this as a dependency for the plugin
//resource
this.depMaps.push(i),//Support anonymous modules.
u.completeLoad(f),//Bind the value of that module to the value for this
//resource ID.
o([f],e)}),//Use parentName here since the plugin's name is not reliable,
//could be some weird string with no path that actually wants to
//reference the parentName's path.
d.load(a.name,o,e,x),void 0)})),u.enable(d,this),this.pluginMaps[d.id]=d},enable:function(){z[this.map.id]=this,this.enabled=!0,//Set flag mentioning that the module is enabling,
//so that immediate calls to the defined callbacks
//for dependencies do not trigger inadvertent load
//with the depCount still being zero.
this.enabling=!0,//Enable each dependency
each(this.depMaps,bind(this,function(a,b){var c,d,e;if("string"==typeof a){if(//Dependency needs to be converted to a depMap
//and wired up to this module.
a=g(a,this.map.isDefine?this.map:this.map.parentMap,!1,!this.skipMap),this.depMaps[b]=a,e=getOwn(v,a.id))return this.depExports[b]=e(this),void 0;this.depCount+=1,i(a,"defined",bind(this,function(a){this.defineDep(b,a),this.check()})),this.errback&&i(a,"error",bind(this,this.errback))}c=a.id,d=y[c],//Skip special modules like 'require', 'exports', 'module'
//Also, don't call enable if it is already enabled,
//important in circular dependency cases.
hasProp(v,c)||!d||d.enabled||u.enable(a,this)})),//Enable each plugin that is used in
//a dependency
eachProp(this.pluginMaps,bind(this,function(a){var b=getOwn(y,a.id);b&&!b.enabled&&u.enable(a,this)})),this.enabling=!1,this.check()},on:function(a,b){var c=this.events[a];c||(c=this.events[a]=[]),c.push(b)},emit:function(a,b){each(this.events[a],function(a){a(b)}),"error"===a&&//Now that the error handler was triggered, remove
//the listeners, since this broken Module instance
//can stay around for a while in the registry.
delete this.events[a]}},u={config:x,contextName:a,registry:y,defined:C,urlFetched:D,defQueue:B,Module:t,makeModuleMap:g,nextTick:req.nextTick,onError:j,/**
             * Set a configuration for the context.
             * @param {Object} cfg config object to integrate.
             */
configure:function(a){//Make sure the baseUrl ends in a slash.
a.baseUrl&&"/"!==a.baseUrl.charAt(a.baseUrl.length-1)&&(a.baseUrl+="/");//Save off the paths and packages since they require special processing,
//they are additive.
var b=x.pkgs,c=x.shim,d={paths:!0,config:!0,map:!0};eachProp(a,function(a,b){d[b]?"map"===b?(x.map||(x.map={}),mixin(x[b],a,!0,!0)):mixin(x[b],a,!0):x[b]=a}),//Merge shim
a.shim&&(eachProp(a.shim,function(a,b){//Normalize the structure
isArray(a)&&(a={deps:a}),!a.exports&&!a.init||a.exportsFn||(a.exportsFn=u.makeShimExports(a)),c[b]=a}),x.shim=c),//Adjust packages if necessary.
a.packages&&(each(a.packages,function(a){var c;a="string"==typeof a?{name:a}:a,c=a.location,//Create a brand new object on pkgs, since currentPackages can
//be passed in again, and config.pkgs is the internal transformed
//state for all package configs.
b[a.name]={name:a.name,location:c||a.name,//Remove leading dot in main, so main paths are normalized,
//and remove any trailing .js, since different package
//envs have different conventions: some use a module name,
//some use a file name.
main:(a.main||"main").replace(currDirRegExp,"").replace(jsSuffixRegExp,"")}}),//Done with modifications, assing packages back to context config
x.pkgs=b),//If there are any "waiting to execute" modules in the registry,
//update the maps for them, since their info, like URLs to load,
//may have changed.
eachProp(y,function(a,b){//If module already has init called, since it is too
//late to modify them, and ignore unnormalized ones
//since they are transient.
a.inited||a.map.unnormalized||(a.map=g(b))}),//If a deps array or a config callback is specified, then call
//require with those args. This is useful when require is defined as a
//config object before require.js is loaded.
(a.deps||a.callback)&&u.require(a.deps||[],a.callback)},makeShimExports:function(a){function b(){var b;return a.init&&(b=a.init.apply(global,arguments)),b||a.exports&&getGlobal(a.exports)}return b},makeRequire:function(b,e){function f(c,d,i){var k,l,m;return e.enableBuildCallback&&d&&isFunction(d)&&(d.__requireJsBuild=!0),"string"==typeof c?isFunction(d)?j(makeError("requireargs","Invalid require call"),i)://If require|exports|module are requested, get the
//value for them from the special handlers. Caveat:
//this only works while module is being defined.
b&&hasProp(v,c)?v[c](y[b.id])://Synchronous access to one module. If require.get is
//available (as in the Node adapter), prefer that.
req.get?req.get(u,c,b,f):(//Normalize module name, if it contains . or ..
l=g(c,b,!1,!0),k=l.id,hasProp(C,k)?C[k]:j(makeError("notloaded",'Module name "'+k+'" has not been loaded yet for context: '+a+(b?"":". Use require([])")))):(//Grab defines waiting in the global queue.
r(),//Mark all the dependencies as needing to be loaded.
u.nextTick(function(){//Some defines could have been added since the
//require call, collect them.
r(),m=h(g(null,b)),//Store if map config should be applied to this require
//call for dependencies.
m.skipMap=e.skipMap,m.init(c,d,i,{enabled:!0}),n()}),f)}return e=e||{},mixin(f,{isBrowser:isBrowser,/**
                     * Converts a module name + .extension into an URL path.
                     * *Requires* the use of a module name. It does not support using
                     * plain URLs like nameToUrl.
                     */
toUrl:function(a){var d,e=a.lastIndexOf("."),f=a.split("/")[0],g="."===f||".."===f;//Have a file extension alias, and it is not the
//dots from a relative path.
return-1!==e&&(!g||e>1)&&(d=a.substring(e,a.length),a=a.substring(0,e)),u.nameToUrl(c(a,b&&b.id,!0),d,!0)},defined:function(a){return hasProp(C,g(a,b,!1,!0).id)},specified:function(a){return a=g(a,b,!1,!0).id,hasProp(C,a)||hasProp(y,a)}}),//Only allow undef on top level require calls
b||(f.undef=function(a){//Bind any waiting define() calls to this context,
//fix for #408
k();var c=g(a,b,!0),e=getOwn(y,a);d(a),delete C[a],delete D[c.url],delete A[a],e&&(//Hold on to listeners in case the
//module will be attempted to be reloaded
//using a different config.
e.events.defined&&(A[a]=e.events),l(a))}),f},/**
             * Called to enable a module if it is still in the registry
             * awaiting enablement. A second arg, parent, the parent module,
             * is passed in for context, when this method is overriden by
             * the optimizer. Not shown here to keep code compact.
             */
enable:function(a){var b=getOwn(y,a.id);b&&h(a).enable()},/**
             * Internal method used by environment adapters to complete a load event.
             * A load event could be a script load or just a load pass from a synchronous
             * load call.
             * @param {String} moduleName the name of the module to potentially complete.
             */
completeLoad:function(a){var b,c,d,f=getOwn(x.shim,a)||{},g=f.exports;for(k();B.length;){if(c=B.shift(),null===c[0]){//If already found an anonymous module and bound it
//to this name, then this is some other anon module
//waiting for its completeLoad to fire.
if(c[0]=a,b)break;b=!0}else c[0]===a&&(//Found matching define call for this script!
b=!0);o(c)}if(//Do this after the cycle of callGetModule in case the result
//of those calls/init calls changes the registry.
d=getOwn(y,a),!b&&!hasProp(C,a)&&d&&!d.inited){if(!(!x.enforceDefine||g&&getGlobal(g)))return e(a)?void 0:j(makeError("nodefine","No define call for "+a,null,[a]));//A script that does not call define(), so just simulate
//the call for it.
o([a,f.deps||[],f.exportsFn])}n()},/**
             * Converts a module name to a file path. Supports cases where
             * moduleName may actually be just an URL.
             * Note that it **does not** call normalize on the moduleName,
             * it is assumed to have already been normalized. This is an
             * internal API, not a public one. Use toUrl for the public API.
             */
nameToUrl:function(a,b,c){var d,e,f,g,h,i,j,k,l;//If a colon is in the URL, it indicates a protocol is used and it is just
//an URL to a file, or if it starts with a slash, contains a query arg (i.e. ?)
//or ends with .js, then assume the user meant to use an url and not a module id.
//The slash is important for protocol-less URLs as well as full paths.
if(req.jsExtRegExp.test(a))//Just a plain path, not module name lookup, so just return it.
//Add extension if it is included. This is a bit wonky, only non-.js things pass
//an extension, this method probably needs to be reworked.
k=a+(b||"");else{//For each module name segment, see if there is a path
//registered for it. Start with most specific name
//and work up from it.
for(//A module that needs to be converted to a path.
d=x.paths,e=x.pkgs,h=a.split("/"),i=h.length;i>0;i-=1){if(j=h.slice(0,i).join("/"),f=getOwn(e,j),l=getOwn(d,j)){//If an array, it means there are a few choices,
//Choose the one that is desired
isArray(l)&&(l=l[0]),h.splice(0,i,l);break}if(f){//If module name is just the package name, then looking
//for the main module.
g=a===f.name?f.location+"/"+f.main:f.location,h.splice(0,i,g);break}}//Join the path parts together, then figure out if baseUrl is needed.
k=h.join("/"),k+=b||(/^data\:|\?/.test(k)||c?"":".js"),k=("/"===k.charAt(0)||k.match(/^[\w\+\.\-]+:/)?"":x.baseUrl)+k}return x.urlArgs?k+((-1===k.indexOf("?")?"?":"&")+x.urlArgs):k},//Delegates to req.load. Broken out as a separate function to
//allow overriding in the optimizer.
load:function(a,b){req.load(u,a,b)},/**
             * Executes a module callback function. Broken out as a separate function
             * solely to allow the build system to sequence the files in the built
             * layer in the right sequence.
             *
             * @private
             */
execCb:function(a,b,c,d){return b.apply(d,c)},/**
             * callback for script loads, used to check status of loading.
             *
             * @param {Event} evt the event from the browser for the script
             * that was loaded.
             */
onScriptLoad:function(a){//Using currentTarget instead of target for Firefox 2.0's sake. Not
//all old browsers will be supported, but this one was easy enough
//to support and still makes sense.
if("load"===a.type||readyRegExp.test((a.currentTarget||a.srcElement).readyState)){//Reset interactive script so a script node is not held onto for
//to long.
interactiveScript=null;//Pull out the name of the module and the context.
var b=q(a);u.completeLoad(b.id)}},/**
             * Callback for script errors.
             */
onScriptError:function(a){var b=q(a);return e(b.id)?void 0:j(makeError("scripterror","Script error for: "+b.id,a,[b.id]))}},u.require=u.makeRequire(),u}function getInteractiveScript(){return interactiveScript&&"interactive"===interactiveScript.readyState?interactiveScript:(eachReverse(scripts(),function(a){return"interactive"===a.readyState?interactiveScript=a:void 0}),interactiveScript)}var req,s,head,baseElement,dataMain,src,interactiveScript,currentlyAddingScript,mainScript,subPath,version="2.1.9",commentRegExp=/(\/\*([\s\S]*?)\*\/|([^:]|^)\/\/(.*)$)/gm,cjsRequireRegExp=/[^.]\s*require\s*\(\s*["']([^'"\s]+)["']\s*\)/g,jsSuffixRegExp=/\.js$/,currDirRegExp=/^\.\//,op=Object.prototype,ostring=op.toString,hasOwn=op.hasOwnProperty,ap=Array.prototype,apsp=ap.splice,isBrowser=!("undefined"==typeof window||"undefined"==typeof navigator||!window.document),isWebWorker=!isBrowser&&"undefined"!=typeof importScripts,//PS3 indicates loaded and complete, but need to wait for complete
//specifically. Sequence is 'loading', 'loaded', execution,
// then 'complete'. The UA check is unfortunate, but not sure how
//to feature test w/o causing perf issues.
readyRegExp=isBrowser&&"PLAYSTATION 3"===navigator.platform?/^complete$/:/^(complete|loaded)$/,defContextName="_",//Oh the tragedy, detecting opera. See the usage of isOpera for reason.
isOpera="undefined"!=typeof opera&&"[object Opera]"===opera.toString(),contexts={},cfg={},globalDefQueue=[],useInteractive=!1;if("undefined"==typeof define){if("undefined"!=typeof requirejs){if(isFunction(requirejs))//Do not overwrite and existing requirejs instance.
return;cfg=requirejs,requirejs=void 0}//Allow for a require config object
"undefined"==typeof require||isFunction(require)||(//assume it is a config object.
cfg=require,require=void 0),/**
     * Main entry point.
     *
     * If the only argument to require is a string, then the module that
     * is represented by that string is fetched for the appropriate context.
     *
     * If the first argument is an array, then it will be treated as an array
     * of dependency string names to fetch. An optional function callback can
     * be specified to execute when all of those dependencies are available.
     *
     * Make a local req variable to help Caja compliance (it assumes things
     * on a require that are not standardized), and to give a short
     * name for minification/local scope use.
     */
req=requirejs=function(a,b,c,d){//Find the right context, use default
var e,f,g=defContextName;// Determine if have config object in the call.
return isArray(a)||"string"==typeof a||(// deps is a config object
f=a,isArray(b)?(// Adjust args if there are dependencies
a=b,b=c,c=d):a=[]),f&&f.context&&(g=f.context),e=getOwn(contexts,g),e||(e=contexts[g]=req.s.newContext(g)),f&&e.configure(f),e.require(a,b,c)},/**
     * Support require.config() to make it easier to cooperate with other
     * AMD loaders on globally agreed names.
     */
req.config=function(a){return req(a)},/**
     * Execute something after the current tick
     * of the event loop. Override for other envs
     * that have a better solution than setTimeout.
     * @param  {Function} fn function to execute later.
     */
req.nextTick="undefined"!=typeof setTimeout?function(a){setTimeout(a,4)}:function(a){a()},/**
     * Export require as a global, but only if it does not already exist.
     */
require||(require=req),req.version=version,//Used to filter out dependencies that are already paths.
req.jsExtRegExp=/^\/|:|\?|\.js$/,req.isBrowser=isBrowser,s=req.s={contexts:contexts,newContext:newContext},//Create default context.
req({}),//Exports some context-sensitive methods on global require.
each(["toUrl","undef","defined","specified"],function(a){//Reference from contexts instead of early binding to default context,
//so that during builds, the latest instance of the default context
//with its config gets used.
req[a]=function(){var b=contexts[defContextName];return b.require[a].apply(b,arguments)}}),isBrowser&&(head=s.head=document.getElementsByTagName("head")[0],//If BASE tag is in play, using appendChild is a problem for IE6.
//When that browser dies, this can be removed. Details in this jQuery bug:
//http://dev.jquery.com/ticket/2709
baseElement=document.getElementsByTagName("base")[0],baseElement&&(head=s.head=baseElement.parentNode)),/**
     * Any errors that require explicitly generates will be passed to this
     * function. Intercept/override it if you want custom error handling.
     * @param {Error} err the error object.
     */
req.onError=defaultOnError,/**
     * Creates the node for the load command. Only used in browser envs.
     */
req.createNode=function(a){var b=a.xhtml?document.createElementNS("http://www.w3.org/1999/xhtml","html:script"):document.createElement("script");return b.type=a.scriptType||"text/javascript",b.charset="utf-8",b.async=!0,b},/**
     * Does the request to load a module for the browser case.
     * Make this a separate function to allow other environments
     * to override it.
     *
     * @param {Object} context the require context to find state.
     * @param {String} moduleName the name of the module.
     * @param {Object} url the URL to the module.
     */
req.load=function(a,b,c){var d,e=a&&a.config||{};if(isBrowser)//In the browser so use a script tag
return d=req.createNode(e,b,c),d.setAttribute("data-requirecontext",a.contextName),d.setAttribute("data-requiremodule",b),//Set up load listener. Test attachEvent first because IE9 has
//a subtle issue in its addEventListener and script onload firings
//that do not match the behavior of all other browsers with
//addEventListener support, which fire the onload event for a
//script right after the script execution. See:
//https://connect.microsoft.com/IE/feedback/details/648057/script-onload-event-is-not-fired-immediately-after-script-execution
//UNFORTUNATELY Opera implements attachEvent but does not follow the script
//script execution mode.
!d.attachEvent||d.attachEvent.toString&&d.attachEvent.toString().indexOf("[native code")<0||isOpera?(d.addEventListener("load",a.onScriptLoad,!1),d.addEventListener("error",a.onScriptError,!1)):(//Probably IE. IE (at least 6-8) do not fire
//script onload right after executing the script, so
//we cannot tie the anonymous define call to a name.
//However, IE reports the script as being in 'interactive'
//readyState at the time of the define call.
useInteractive=!0,d.attachEvent("onreadystatechange",a.onScriptLoad)),d.src=c,//For some cache cases in IE 6-8, the script executes before the end
//of the appendChild execution, so to tie an anonymous define
//call to the module name (which is stored on the node), hold on
//to a reference to this node, but clear after the DOM insertion.
currentlyAddingScript=d,baseElement?head.insertBefore(d,baseElement):head.appendChild(d),currentlyAddingScript=null,d;if(isWebWorker)try{//In a web worker, use importScripts. This is not a very
//efficient use of importScripts, importScripts will block until
//its script is downloaded and evaluated. However, if web workers
//are in play, the expectation that a build has been done so that
//only one script needs to be loaded anyway. This may need to be
//reevaluated if other use cases become common.
importScripts(c),//Account for anonymous modules
a.completeLoad(b)}catch(f){a.onError(makeError("importscripts","importScripts failed for "+b+" at "+c,f,[b]))}},//Look for a data-main script attribute, which could also adjust the baseUrl.
isBrowser&&!cfg.skipDataMain&&//Figure out baseUrl. Get it from the script tag with require.js in it.
eachReverse(scripts(),function(a){//Set the 'head' where we can append children by
//using the script's parent.
return head||(head=a.parentNode),//Look for a data-main attribute to set main script for the page
//to load. If it is there, the path to data main becomes the
//baseUrl, if it is not already set.
dataMain=a.getAttribute("data-main"),dataMain?(//Preserve dataMain in case it is a path (i.e. contains '?')
mainScript=dataMain,//Set final baseUrl if there is not already an explicit one.
cfg.baseUrl||(//Pull off the directory of data-main for use as the
//baseUrl.
src=mainScript.split("/"),mainScript=src.pop(),subPath=src.length?src.join("/")+"/":"./",cfg.baseUrl=subPath),//Strip off any trailing .js since mainScript is now
//like a module name.
mainScript=mainScript.replace(jsSuffixRegExp,""),//If mainScript is still a path, fall back to dataMain
req.jsExtRegExp.test(mainScript)&&(mainScript=dataMain),//Put the data-main script in the files to load.
cfg.deps=cfg.deps?cfg.deps.concat(mainScript):[mainScript],!0):void 0}),/**
     * The function that handles definitions of modules. Differs from
     * require() in that a string for the module should be the first argument,
     * and the function to execute after dependencies are loaded should
     * return a value to define the module corresponding to the first argument's
     * name.
     */
define=function(a,b,c){var d,e;//Allow for anonymous modules
"string"!=typeof a&&(//Adjust args appropriately
c=b,b=a,a=null),//This module may not have dependencies
isArray(b)||(c=b,b=null),//If no name, and callback is a function, then figure out if it a
//CommonJS thing with dependencies.
!b&&isFunction(c)&&(b=[],//Remove comments from the callback string,
//look for require calls, and pull them into the dependencies,
//but only if there are function args.
c.length&&(c.toString().replace(commentRegExp,"").replace(cjsRequireRegExp,function(a,c){b.push(c)}),//May be a CommonJS thing even without require calls, but still
//could use exports, and module. Avoid doing exports and module
//work though if it just needs require.
//REQUIRES the function to expect the CommonJS variables in the
//order listed below.
b=(1===c.length?["require"]:["require","exports","module"]).concat(b))),//If in IE 6-8 and hit an anonymous define() call, do the interactive
//work.
useInteractive&&(d=currentlyAddingScript||getInteractiveScript(),d&&(a||(a=d.getAttribute("data-requiremodule")),e=contexts[d.getAttribute("data-requirecontext")])),//Always save off evaluating the def call until the script onload handler.
//This allows multiple modules to be in a file without prematurely
//tracing dependencies, and allows for anonymous module support,
//where the module name is not known until the script onload event
//occurs. If no context, use the global queue, and get it processed
//in the onscript load callback.
(e?e.defQueue:globalDefQueue).push([a,b,c])},define.amd={jQuery:!0},/**
     * Executes the text. Normally just uses eval, but can be modified
     * to use a better, environment-specific call. Only used for transpiling
     * loader plugins, not for plain JS modules.
     * @param {String} text the text to execute/evaluate.
     */
req.exec=function(text){/*jslint evil: true */
return eval(text)},//Set up with config info.
req(cfg)}}(this);