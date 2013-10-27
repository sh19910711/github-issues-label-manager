/*!
  backbone.fetch-cache v1.1.2
  by Andy Appleton - https://github.com/mrappleton/backbone-fetch-cache.git
 */
// AMD wrapper from https://github.com/umdjs/umd/blob/master/amdWebGlobal.js
!function(a,b){"function"==typeof define&&define.amd?// AMD. Register as an anonymous module and set browser global
define(["underscore","backbone","jquery"],function(c,d,e){return a.Backbone=b(c,d,e)}):// Browser globals
a.Backbone=b(a._,a.Backbone,a.jQuery)}(this,function(a,b,c){// Shared methods
function d(b,d){var e;// Need url to use as cache key so return if we can't get it
// Need url to use as cache key so return if we can't get it
return(e=d&&d.url?d.url:a.isFunction(b.url)?b.url():b.url)?d&&d.data?e+"?"+c.param(d.data):e:void 0}function e(a,c,d){c=c||{};var e=b.fetchCache.getCacheKey(a,c),f=!1;// Need url to use as cache key so return if we can't get it
e&&// Never set the cache if user has explicitly said not to
c.cache!==!1&&// Don't set the cache unless cache: true or prefill: true option is passed
(c.cache||c.prefill)&&(c.expires!==!1&&(f=(new Date).getTime()+1e3*(c.expires||300)),b.fetchCache._cache[e]={expires:f,value:d},b.fetchCache.setLocalStorage())}function f(a){delete b.fetchCache._cache[a],b.fetchCache.setLocalStorage()}function g(){if(k&&b.fetchCache.localStorage)try{localStorage.setItem("backboneCache",JSON.stringify(b.fetchCache._cache))}catch(a){var c=a.code||a.number||a.message;if(22!==c)throw a;this._deleteCacheWithPriority()}}function h(){if(k&&b.fetchCache.localStorage){var a=localStorage.getItem("backboneCache")||"{}";b.fetchCache._cache=JSON.parse(a)}}function i(a){return window.setTimeout(a,0)}// Setup
var j={modelFetch:b.Model.prototype.fetch,modelSync:b.Model.prototype.sync,collectionFetch:b.Collection.prototype.fetch},k=function(){var a="undefined"!=typeof window.localStorage;if(a)try{// impossible to write on some platforms when private browsing is on and
// throws an exception = local storage not supported.
localStorage.setItem("test_support","test_support"),localStorage.removeItem("test_support")}catch(b){a=!1}return a}();return b.fetchCache=b.fetchCache||{},b.fetchCache._cache=b.fetchCache._cache||{},b.fetchCache.priorityFn=function(a,b){return a&&a.expires&&b&&b.expires?a.expires-b.expires:a},b.fetchCache._prioritize=function(){var b=a.values(this._cache).sort(this.priorityFn),c=a.indexOf(a.values(this._cache),b[0]);return a.keys(this._cache)[c]},b.fetchCache._deleteCacheWithPriority=function(){b.fetchCache._cache[this._prioritize()]=null,delete b.fetchCache._cache[this._prioritize()],b.fetchCache.setLocalStorage()},"undefined"==typeof b.fetchCache.localStorage&&(b.fetchCache.localStorage=!0),// Instance methods
b.Model.prototype.fetch=function(d){function e(){m.set(k,d),a.isFunction(d.prefillSuccess)&&d.prefillSuccess(m,k,d),// Trigger sync events
m.trigger("cachesync",m,k,d),m.trigger("sync",m,k,d),// Notify progress if we're still waiting for an AJAX call to happen...
d.prefill?l.notify(m):(a.isFunction(d.success)&&d.success(m,k,d),l.resolve(m))}d=a.defaults(d||{},{parse:!0});var f=b.fetchCache.getCacheKey(this,d),g=b.fetchCache._cache[f],h=!1,k=!1,l=new c.Deferred,m=this;return g&&(h=g.expires,h=h&&g.expires<(new Date).getTime(),k=g.value),h||!d.cache&&!d.prefill||!k||(// Ensure that cache resolution adhers to async option, defaults to true.
null==d.async&&(d.async=!0),d.async?i(e):e(),d.prefill)?(// Delegate to the actual fetch method and store the attributes in the cache
j.modelFetch.apply(this,arguments).done(a.bind(l.resolve,this,this)).done(a.bind(b.fetchCache.setCache,null,this,d)).fail(a.bind(l.reject,this,this)),l.promise()):l.promise()},// Override Model.prototype.sync and try to clear cache items if it looks
// like they are being updated.
b.Model.prototype.sync=function(a,c){// Only empty the cache if we're doing a create, update, patch or delete.
if("read"===a)return j.modelSync.apply(this,arguments);var d,e,g=c.collection,h=[];// Empty cache for all found keys
for(// Build up a list of keys to delete from the cache, starting with this
h.push(b.fetchCache.getCacheKey(c)),// If this model has a collection, also try to delete the cache for that
g&&h.push(b.fetchCache.getCacheKey(g)),d=0,e=h.length;e>d;d++)f(h[d]);return j.modelSync.apply(this,arguments)},b.Collection.prototype.fetch=function(d){function e(){m[d.reset?"reset":"set"](k,d),a.isFunction(d.prefillSuccess)&&d.prefillSuccess(m),// Trigger sync events
m.trigger("cachesync",m,k,d),m.trigger("sync",m,k,d),// Notify progress if we're still waiting for an AJAX call to happen...
d.prefill?l.notify(m):(a.isFunction(d.success)&&d.success(m,k,d),l.resolve(m))}d=a.defaults(d||{},{parse:!0});var f=b.fetchCache.getCacheKey(this,d),g=b.fetchCache._cache[f],h=!1,k=!1,l=new c.Deferred,m=this;return g&&(h=g.expires,h=h&&g.expires<(new Date).getTime(),k=g.value),h||!d.cache&&!d.prefill||!k||(// Ensure that cache resolution adhers to async option, defaults to true.
null==d.async&&(d.async=!0),d.async?i(e):e(),d.prefill)?(// Delegate to the actual fetch method and store the attributes in the cache
j.collectionFetch.apply(this,arguments).done(a.bind(l.resolve,this,this)).done(a.bind(b.fetchCache.setCache,null,this,d)).fail(a.bind(l.reject,this,this)),l.promise()):l.promise()},// Prime the cache from localStorage on initialization
h(),// Exports
b.fetchCache._superMethods=j,b.fetchCache.setCache=e,b.fetchCache.getCacheKey=d,b.fetchCache.clearItem=f,b.fetchCache.setLocalStorage=g,b.fetchCache.getLocalStorage=h,b});