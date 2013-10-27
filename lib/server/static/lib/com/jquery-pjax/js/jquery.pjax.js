// jquery.pjax.js
// copyright chris wanstrath
// https://github.com/defunkt/jquery-pjax
!function(a){// When called on a container with a selector, fetches the href with
// ajax into the container or with the data-pjax attribute on the link
// itself.
//
// Tries to make sure the back button and ctrl+click work the way
// you'd expect.
//
// Exported as $.fn.pjax
//
// Accepts a jQuery ajax options object that may include these
// pjax specific options:
//
//
// container - Where to stick the response body. Usually a String selector.
//             $(container).html(xhr.responseBody)
//             (default: current jquery context)
//      push - Whether to pushState the URL. Defaults to true (of course).
//   replace - Want to use replaceState instead? That's cool.
//
// For convenience the second parameter can be either the container or
// the options object.
//
// Returns the jQuery object
function b(b,d,e){var f=this;return this.on("click.pjax",b,function(b){var g=a.extend({},m(d,e));g.container||(g.container=a(this).attr("data-pjax")||f),c(b,g)})}// Public: pjax on click handler
//
// Exported as $.pjax.click.
//
// event   - "click" jQuery.Event
// options - pjax options
//
// Examples
//
//   $(document).on('click', 'a', $.pjax.click)
//   // is the same as
//   $(document).pjax('a')
//
//  $(document).on('click', 'a', function(event) {
//    var container = $(this).closest('[data-pjax-container]')
//    $.pjax.click(event, container)
//  })
//
// Returns nothing.
function c(b,c,d){d=m(c,d);var f=b.currentTarget;if("A"!==f.tagName.toUpperCase())throw"$.fn.pjax or $.pjax.click requires an anchor element";// Middle click, cmd click, and ctrl click should open
// links in a new tab as normal.
if(!(b.which>1||b.metaKey||b.ctrlKey||b.shiftKey||b.altKey||location.protocol!==f.protocol||location.hostname!==f.hostname||f.hash&&f.href.replace(f.hash,"")===location.href.replace(location.hash,"")||f.href===location.href+"#"))// Ignore empty anchor "foo.html#"
{var g={url:f.href,container:a(f).attr("data-pjax"),target:f},h=a.extend({},g,d),i=a.Event("pjax:click");a(f).trigger(i,[h]),i.isDefaultPrevented()||(e(h),b.preventDefault())}}// Public: pjax on form submit handler
//
// Exported as $.pjax.submit
//
// event   - "click" jQuery.Event
// options - pjax options
//
// Examples
//
//  $(document).on('submit', 'form', function(event) {
//    var container = $(this).closest('[data-pjax-container]')
//    $.pjax.submit(event, container)
//  })
//
// Returns nothing.
function d(b,c,d){d=m(c,d);var f=b.currentTarget;if("FORM"!==f.tagName.toUpperCase())throw"$.pjax.submit requires a form element";var g={type:f.method.toUpperCase(),url:f.action,data:a(f).serializeArray(),container:a(f).attr("data-pjax"),target:f};e(a.extend({},g,d)),b.preventDefault()}// Loads a URL with ajax, puts the response body inside a container,
// then pushState()'s the loaded URL.
//
// Works just like $.ajax in that it accepts a jQuery ajax
// settings object (with keys like url, type, data, etc).
//
// Accepts these extra keys:
//
// container - Where to stick the response body.
//             $(container).html(xhr.responseBody)
//      push - Whether to pushState the URL. Defaults to true (of course).
//   replace - Want to use replaceState instead? That's cool.
//
// Use it just like $.ajax:
//
//   var xhr = $.pjax({ url: this.href, container: '#main' })
//   console.log( xhr.readyState )
//
// Returns whatever $.ajax returns.
function e(b){function c(b,c){var e=a.Event(b,{relatedTarget:d});return h.trigger(e,c),!e.isDefaultPrevented()}b=a.extend(!0,{},a.ajaxSettings,e.defaults,b),a.isFunction(b.url)&&(b.url=b.url());var d=b.target,f=l(b.url).hash,h=b.context=n(b.container);// We want the browser to maintain two separate internal caches: one
// for pjax'd partial page loads and one for normal page loads.
// Without adding this secret parameter, some browsers will often
// confuse the two.
b.data||(b.data={}),b.data._pjax=h.selector;var i;b.beforeSend=function(a,d){// No timeout for non-GET requests
// Its not safe to request the resource again with a fallback method.
return"GET"!==d.type&&(d.timeout=0),a.setRequestHeader("X-PJAX","true"),a.setRequestHeader("X-PJAX-Container",h.selector),c("pjax:beforeSend",[a,d])?(d.timeout>0&&(i=setTimeout(function(){c("pjax:timeout",[a,b])&&a.abort("timeout")},d.timeout),// Clear timeout setting so jquerys internal timeout isn't invoked
d.timeout=0),b.requestUrl=l(d.url).href,void 0):!1},b.complete=function(a,d){i&&clearTimeout(i),c("pjax:complete",[a,d,b]),c("pjax:end",[a,b])},b.error=function(a,d,e){var f=q("",a,b),h=c("pjax:error",[a,d,e,b]);"GET"==b.type&&"abort"!==d&&h&&g(f.url)},b.success=function(d,i,k){// If $.pjax.defaults.version is a function, invoke it first.
// Otherwise it can be a static string.
var m="function"==typeof a.pjax.defaults.version?a.pjax.defaults.version():a.pjax.defaults.version,n=k.getResponseHeader("X-PJAX-Version"),o=q(d,k,b);// If there is a layout version mismatch, hard load the new url
if(m&&n&&m!==n)return g(o.url),void 0;// If the new response is missing a body, hard load the page
if(!o.contents)return g(o.url),void 0;e.state={id:b.id||j(),url:o.url,title:o.title,container:h.selector,fragment:b.fragment,timeout:b.timeout},(b.push||b.replace)&&window.history.replaceState(e.state,o.title,o.url),// Clear out any focused controls before inserting new page contents.
document.activeElement.blur(),o.title&&(document.title=o.title),h.html(o.contents);// FF bug: Won't autofocus fields that are inserted via JS.
// This behavior is incorrect. So if theres no current focus, autofocus
// the last field.
//
// http://www.w3.org/html/wg/drafts/html/master/forms.html
var p=h.find("input[autofocus], textarea[autofocus]").last()[0];// If the URL has a hash in it, make sure the browser
// knows to navigate to the hash.
if(p&&document.activeElement!==p&&p.focus(),r(o.scripts),// Scroll to top by default
"number"==typeof b.scrollTo&&a(window).scrollTop(b.scrollTo),""!==f){// Avoid using simple hash set here. Will add another history
// entry. Replace the url with replaceState and scroll to target
// by hand.
//
//   window.location.hash = hash
var s=l(o.url);s.hash=f,e.state.url=s.href,window.history.replaceState(e.state,o.title,s.href);var t=a(s.hash);t.length&&a(window).scrollTop(t.offset().top)}c("pjax:success",[d,i,k,b])},// Initialize pjax.state for the initial page load. Assume we're
// using the container and options of the link we're loading for the
// back button to the initial page. This ensures good back button
// behavior.
e.state||(e.state={id:j(),url:window.location.href,title:document.title,container:h.selector,fragment:b.fragment,timeout:b.timeout},window.history.replaceState(e.state,document.title));// Cancel the current request if we're already pjaxing
var m=e.xhr;m&&m.readyState<4&&(m.onreadystatechange=a.noop,m.abort()),e.options=b;var m=e.xhr=a.ajax(b);return m.readyState>0&&(b.push&&!b.replace&&(// Cache current container element before replacing it
s(e.state.id,h.clone().contents()),window.history.pushState(null,"",k(b.requestUrl))),c("pjax:start",[m,b]),c("pjax:send",[m,b])),e.xhr}// Public: Reload current page with pjax.
//
// Returns whatever $.pjax returns.
function f(b,c){var d={url:window.location.href,push:!1,replace:!0,scrollTo:!1};return e(a.extend(d,m(b,c)))}// Internal: Hard replace current state with url.
//
// Work for around WebKit
//   https://bugs.webkit.org/show_bug.cgi?id=93506
//
// Returns nothing.
function g(a){window.history.replaceState(null,"","#"),window.location.replace(a)}// popstate handler takes care of the back and forward buttons
//
// You probably shouldn't use pjax on pages with other pushState
// stuff yet.
function h(b){var c=b.state;if(c&&c.container){// When coming forward from a separate history session, will get an
// initial pop with a state we are already at. Skip reloading the current
// page.
if(x&&y==c.url)return;// If popping back to the same state, just skip.
// Could be clicking back from hashchange rather than a pushState.
if(e.state.id===c.id)return;var d=a(c.container);if(d.length){var f,h=A[c.id];e.state&&(// Since state ids always increase, we can deduce the history
// direction from the previous state.
f=e.state.id<c.id?"forward":"back",// Cache current container before replacement and inform the
// cache which direction the history shifted.
t(f,e.state.id,d.clone().contents()));var i=a.Event("pjax:popstate",{state:c,direction:f});d.trigger(i);var j={id:c.id,url:c.url,container:d,push:!1,fragment:c.fragment,timeout:c.timeout,scrollTo:!1};h?(d.trigger("pjax:start",[null,j]),c.title&&(document.title=c.title),d.html(h),e.state=c,d.trigger("pjax:end",[null,j])):e(j),// Force reflow/relayout before the browser tries to restore the
// scroll position.
d[0].offsetHeight}else g(location.href)}x=!1}// Fallback version of main pjax function for browsers that don't
// support pushState.
//
// Returns nothing since it retriggers a hard form submission.
function i(b){var c=a.isFunction(b.url)?b.url():b.url,d=b.type?b.type.toUpperCase():"GET",e=a("<form>",{method:"GET"===d?"GET":"POST",action:c,style:"display:none"});"GET"!==d&&"POST"!==d&&e.append(a("<input>",{type:"hidden",name:"_method",value:d.toLowerCase()}));var f=b.data;if("string"==typeof f)a.each(f.split("&"),function(b,c){var d=c.split("=");e.append(a("<input>",{type:"hidden",name:d[0],value:d[1]}))});else if("object"==typeof f)for(key in f)e.append(a("<input>",{type:"hidden",name:key,value:f[key]}));a(document.body).append(e),e.submit()}// Internal: Generate unique id for state object.
//
// Use a timestamp instead of a counter since ids should still be
// unique across page loads.
//
// Returns Number.
function j(){return(new Date).getTime()}// Internal: Strips _pjax param from url
//
// url - String
//
// Returns String.
function k(a){return a.replace(/\?_pjax=[^&]+&?/,"?").replace(/_pjax=[^&]+&?/,"").replace(/[\?&]$/,"")}// Internal: Parse URL components and returns a Locationish object.
//
// url - String URL
//
// Returns HTMLAnchorElement that acts like Location.
function l(a){var b=document.createElement("a");return b.href=a,b}// Internal: Build options Object for arguments.
//
// For convenience the first parameter can be either the container or
// the options object.
//
// Examples
//
//   optionsFor('#container')
//   // => {container: '#container'}
//
//   optionsFor('#container', {push: true})
//   // => {container: '#container', push: true}
//
//   optionsFor({container: '#container', push: true})
//   // => {container: '#container', push: true}
//
// Returns options Object.
function m(b,c){// Both container and options
return b&&c?c.container=b:c=a.isPlainObject(b)?b:{container:b},// Find and validate container
c.container&&(c.container=n(c.container)),c}// Internal: Find container element for a variety of inputs.
//
// Because we can't persist elements using the history API, we must be
// able to find a String selector that will consistently find the Element.
//
// container - A selector String, jQuery object, or DOM Element.
//
// Returns a jQuery object whose context is `document` and has a selector.
function n(b){if(b=a(b),b.length){if(""!==b.selector&&b.context===document)return b;if(b.attr("id"))return a("#"+b.attr("id"));throw"cant get selector for pjax container!"}throw"no pjax container for "+b.selector}// Internal: Filter and find all elements matching the selector.
//
// Where $.fn.find only matches descendants, findAll will test all the
// top level elements in the jQuery object as well.
//
// elems    - jQuery object of Elements
// selector - String selector to match
//
// Returns a jQuery object.
function o(a,b){return a.filter(b).add(a.find(b))}function p(b){return a.parseHTML(b,document,!0)}// Internal: Extracts container and metadata from response.
//
// 1. Extracts X-PJAX-URL header if set
// 2. Extracts inline <title> tags
// 3. Builds response Element and extracts fragment if set
//
// data    - String response data
// xhr     - XHR response
// options - pjax options Object
//
// Returns an Object with url, title, and contents keys.
function q(b,c,d){var e={};// Attempt to parse response html into elements
if(// Prefer X-PJAX-URL header if it was set, otherwise fallback to
// using the original requested url.
e.url=k(c.getResponseHeader("X-PJAX-URL")||d.requestUrl),/<html/i.test(b))var f=a(p(b.match(/<head[^>]*>([\s\S.]*)<\/head>/i)[0])),g=a(p(b.match(/<body[^>]*>([\s\S.]*)<\/body>/i)[0]));else var f=g=a(p(b));// If response data is empty, return fast
if(0===g.length)return e;if(// If there's a <title> tag in the header, use it as
// the page's title.
e.title=o(f,"title").last().text(),d.fragment){// If they specified a fragment, look for it in the response
// and pull it out.
if("body"===d.fragment)var h=g;else var h=o(g,d.fragment).first();h.length&&(e.contents=h.contents(),// If there's no title, look for data-title and title attributes
// on the fragment
e.title||(e.title=h.attr("title")||h.data("title")))}else/<html/i.test(b)||(e.contents=g);// Clean up any <title> tags
return e.contents&&(// Remove any parent title elements
e.contents=e.contents.not(function(){return a(this).is("title")}),// Then scrub any titles from their descendants
e.contents.find("title").remove(),// Gather all script[src] elements
e.scripts=o(e.contents,"script[src]").remove(),e.contents=e.contents.not(e.scripts)),// Trim any whitespace off the title
e.title&&(e.title=a.trim(e.title)),e}// Load an execute scripts using standard script request.
//
// Avoids jQuery's traditional $.getScript which does a XHR request and
// globalEval.
//
// scripts - jQuery object of script Elements
//
// Returns nothing.
function r(b){if(b){var c=a("script[src]");b.each(function(){var b=this.src,d=c.filter(function(){return this.src===b});if(!d.length){var e=document.createElement("script");e.type=a(this).attr("type"),e.src=a(this).attr("src"),document.head.appendChild(e)}})}}// Push previous state id and container contents into the history
// cache. Should be called in conjunction with `pushState` to save the
// previous container contents.
//
// id    - State ID Number
// value - DOM Element to cache
//
// Returns nothing.
function s(a,b){// Remove all entires in forward history stack after pushing
// a new page.
for(A[a]=b,C.push(a);B.length;)delete A[B.shift()];// Trim back history stack to max cache length.
for(;C.length>e.defaults.maxCacheLength;)delete A[C.shift()]}// Shifts cache from directional history cache. Should be
// called on `popstate` with the previous state id and container
// contents.
//
// direction - "forward" or "back" String
// id        - State ID Number
// value     - DOM Element to cache
//
// Returns nothing.
function t(a,b,c){var d,e;A[b]=c,"forward"===a?(d=C,e=B):(d=B,e=C),d.push(b),(b=e.pop())&&delete A[b]}// Public: Find version identifier for the initial page load.
//
// Returns String version or undefined.
function u(){return a("meta").filter(function(){var b=a(this).attr("http-equiv");return b&&"X-PJAX-VERSION"===b.toUpperCase()}).attr("content")}// Install pjax functions on $.pjax to enable pushState behavior.
//
// Does nothing if already enabled.
//
// Examples
//
//     $.pjax.enable()
//
// Returns nothing.
function v(){a.fn.pjax=b,a.pjax=e,a.pjax.enable=a.noop,a.pjax.disable=w,a.pjax.click=c,a.pjax.submit=d,a.pjax.reload=f,a.pjax.defaults={timeout:650,push:!0,replace:!1,type:"GET",dataType:"html",scrollTo:0,maxCacheLength:20,version:u},a(window).on("popstate.pjax",h)}// Disable pushState behavior.
//
// This is the case when a browser doesn't support pushState. It is
// sometimes useful to disable pushState for debugging on a modern
// browser.
//
// Examples
//
//     $.pjax.disable()
//
// Returns nothing.
function w(){a.fn.pjax=function(){return this},a.pjax=i,a.pjax.enable=v,a.pjax.disable=a.noop,a.pjax.click=a.noop,a.pjax.submit=a.noop,a.pjax.reload=function(){window.location.reload()},a(window).off("popstate.pjax",h)}var x=!0,y=window.location.href,z=window.history.state;// Initialize $.pjax.state if possible
// Happens when reloading a page and coming forward from a different
// session history.
z&&z.container&&(e.state=z),// Non-webkit browsers don't fire an initial popstate event
"state"in window.history&&(x=!1);// Internal: History DOM caching class.
var A={},B=[],C=[];// Add the state property to jQuery's event object so we can use it in
// $(window).bind('popstate')
a.inArray("state",a.event.props)<0&&a.event.props.push("state"),// Is pjax supported by this browser?
a.support.pjax=window.history&&window.history.pushState&&window.history.replaceState&&// pushState isn't reliable on iOS until 5.
!navigator.userAgent.match(/((iPod|iPhone|iPad).+\bOS\s+[1-4]|WebApps\/.+CFNetwork)/),a.support.pjax?v():w()}(jQuery);