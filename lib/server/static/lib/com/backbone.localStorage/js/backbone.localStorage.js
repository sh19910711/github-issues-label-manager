/**
 * Backbone localStorage Adapter
 * Version 1.1.7
 *
 * https://github.com/jeromegn/Backbone.localStorage
 */
!function(a,b){"object"==typeof exports&&"function"==typeof require?module.exports=b(require("underscore"),require("backbone")):"function"==typeof define&&define.amd?// AMD. Register as an anonymous module.
define(["underscore","backbone"],function(c,d){// Use global variables if the locals are undefined.
return b(c||a._,d||a.Backbone)}):// RequireJS isn't being used. Assume underscore and backbone are loaded in <script> tags
b(_,Backbone)}(this,function(a,b){// A simple module to replace `Backbone.sync` with *localStorage*-based
// persistence. Models are given GUIDS, and saved into a JSON object. Simple
// as that.
// Hold reference to Underscore.js and Backbone.js in the closure in order
// to make things work even if they are removed from the global namespace
// Generate four random hex digits.
function c(){return(65536*(1+Math.random())|0).toString(16).substring(1)}// Generate a pseudo-GUID by concatenating random hexadecimal.
function d(){return c()+c()+"-"+c()+"-"+c()+"-"+c()+"-"+c()+c()+c()}// Our Store is represented by a single JS object in *localStorage*. Create it
// with a meaningful name, like the name you'd give a table.
// window.Store is deprectated, use Backbone.LocalStorage instead
return b.LocalStorage=window.Store=function(a){if(!this.localStorage)throw"Backbone.localStorage: Environment does not support localStorage.";this.name=a;var b=this.localStorage().getItem(this.name);this.records=b&&b.split(",")||[]},a.extend(b.LocalStorage.prototype,{// Save the current state of the **Store** to *localStorage*.
save:function(){this.localStorage().setItem(this.name,this.records.join(","))},// Add a model, giving it a (hopefully)-unique GUID, if it doesn't already
// have an id of it's own.
create:function(a){return a.id||(a.id=d(),a.set(a.idAttribute,a.id)),this.localStorage().setItem(this.name+"-"+a.id,JSON.stringify(a)),this.records.push(a.id.toString()),this.save(),this.find(a)},// Update a model by replacing its copy in `this.data`.
update:function(b){return this.localStorage().setItem(this.name+"-"+b.id,JSON.stringify(b)),a.include(this.records,b.id.toString())||this.records.push(b.id.toString()),this.save(),this.find(b)},// Retrieve a model from `this.data` by id.
find:function(a){return this.jsonData(this.localStorage().getItem(this.name+"-"+a.id))},// Return the array of all models currently in storage.
findAll:function(){// Lodash removed _#chain in v1.0.0-rc.1
return(a.chain||a)(this.records).map(function(a){return this.jsonData(this.localStorage().getItem(this.name+"-"+a))},this).compact().value()},// Delete a model from `this.data`, returning it.
destroy:function(b){return b.isNew()?!1:(this.localStorage().removeItem(this.name+"-"+b.id),this.records=a.reject(this.records,function(a){return a===b.id.toString()}),this.save(),b)},localStorage:function(){return localStorage},// fix for "illegal access" error on Android when JSON.parse is passed null
jsonData:function(a){return a&&JSON.parse(a)},// Clear localStorage for specific collection.
_clear:function(){var b=this.localStorage(),c=new RegExp("^"+this.name+"-");// Remove id-tracking item (e.g., "foo").
b.removeItem(this.name),// Lodash removed _#chain in v1.0.0-rc.1
// Match all data items (e.g., "foo-ID") and remove.
(a.chain||a)(b).keys().filter(function(a){return c.test(a)}).each(function(a){b.removeItem(a)}),this.records.length=0},// Size of localStorage.
_storageSize:function(){return this.localStorage().length}}),// localSync delegate to the model or collection's
// *localStorage* property, which should be an instance of `Store`.
// window.Store.sync and Backbone.localSync is deprecated, use Backbone.LocalStorage.sync instead
b.LocalStorage.sync=window.Store.sync=b.localSync=function(a,c,d){var e,f,g=c.localStorage||c.collection.localStorage,h=b.$.Deferred&&b.$.Deferred();//If $ is having Deferred - use it.
try{switch(a){case"read":e=void 0!=c.id?g.find(c):g.findAll();break;case"create":e=g.create(c);break;case"update":e=g.update(c);break;case"delete":e=g.destroy(c)}}catch(i){f=22===i.code&&0===g._storageSize()?"Private browsing is unsupported":i.message}return e?(d&&d.success&&("0.9.10"===b.VERSION?d.success(c,e,d):d.success(e)),h&&h.resolve(e)):(f=f?f:"Record Not Found",d&&d.error&&("0.9.10"===b.VERSION?d.error(c,f,d):d.error(f)),h&&h.reject(f)),// add compatibility with $.ajax
// always execute callback for success and error
d&&d.complete&&d.complete(e),h&&h.promise()},b.ajaxSync=b.sync,b.getSyncMethod=function(a){return a.localStorage||a.collection&&a.collection.localStorage?b.localSync:b.ajaxSync},// Override 'Backbone.sync' to default to localSync,
// the original 'Backbone.sync' is still available in 'Backbone.ajaxSync'
b.sync=function(a,c,d){return b.getSyncMethod(c).apply(this,[a,c,d])},b.LocalStorage});