//     Underscore.js 1.5.2
//     http://underscorejs.org
//     (c) 2009-2013 Jeremy Ashkenas, DocumentCloud and Investigative Reporters & Editors
//     Underscore may be freely distributed under the MIT license.
(function(){// Baseline setup
// --------------
// Establish the root object, `window` in the browser, or `exports` on the server.
var a=this,b=a._,c={},d=Array.prototype,e=Object.prototype,f=Function.prototype,g=d.push,h=d.slice,i=d.concat,j=e.toString,k=e.hasOwnProperty,l=d.forEach,m=d.map,n=d.reduce,o=d.reduceRight,p=d.filter,q=d.every,r=d.some,s=d.indexOf,t=d.lastIndexOf,u=Array.isArray,v=Object.keys,w=f.bind,x=function(a){return a instanceof x?a:this instanceof x?(this._wrapped=a,void 0):new x(a)};// Export the Underscore object for **Node.js**, with
// backwards-compatibility for the old `require()` API. If we're in
// the browser, add `_` as a global object via a string identifier,
// for Closure Compiler "advanced" mode.
"undefined"!=typeof exports?("undefined"!=typeof module&&module.exports&&(exports=module.exports=x),exports._=x):a._=x,// Current version.
x.VERSION="1.5.2";// Collection Functions
// --------------------
// The cornerstone, an `each` implementation, aka `forEach`.
// Handles objects with the built-in `forEach`, arrays, and raw objects.
// Delegates to **ECMAScript 5**'s native `forEach` if available.
var y=x.each=x.forEach=function(a,b,d){if(null!=a)if(l&&a.forEach===l)a.forEach(b,d);else if(a.length===+a.length){for(var e=0,f=a.length;f>e;e++)if(b.call(d,a[e],e,a)===c)return}else for(var g=x.keys(a),e=0,f=g.length;f>e;e++)if(b.call(d,a[g[e]],g[e],a)===c)return};// Return the results of applying the iterator to each element.
// Delegates to **ECMAScript 5**'s native `map` if available.
x.map=x.collect=function(a,b,c){var d=[];return null==a?d:m&&a.map===m?a.map(b,c):(y(a,function(a,e,f){d.push(b.call(c,a,e,f))}),d)};var z="Reduce of empty array with no initial value";// **Reduce** builds up a single result from a list of values, aka `inject`,
// or `foldl`. Delegates to **ECMAScript 5**'s native `reduce` if available.
x.reduce=x.foldl=x.inject=function(a,b,c,d){var e=arguments.length>2;if(null==a&&(a=[]),n&&a.reduce===n)return d&&(b=x.bind(b,d)),e?a.reduce(b,c):a.reduce(b);if(y(a,function(a,f,g){e?c=b.call(d,c,a,f,g):(c=a,e=!0)}),!e)throw new TypeError(z);return c},// The right-associative version of reduce, also known as `foldr`.
// Delegates to **ECMAScript 5**'s native `reduceRight` if available.
x.reduceRight=x.foldr=function(a,b,c,d){var e=arguments.length>2;if(null==a&&(a=[]),o&&a.reduceRight===o)return d&&(b=x.bind(b,d)),e?a.reduceRight(b,c):a.reduceRight(b);var f=a.length;if(f!==+f){var g=x.keys(a);f=g.length}if(y(a,function(h,i,j){i=g?g[--f]:--f,e?c=b.call(d,c,a[i],i,j):(c=a[i],e=!0)}),!e)throw new TypeError(z);return c},// Return the first value which passes a truth test. Aliased as `detect`.
x.find=x.detect=function(a,b,c){var d;return A(a,function(a,e,f){return b.call(c,a,e,f)?(d=a,!0):void 0}),d},// Return all the elements that pass a truth test.
// Delegates to **ECMAScript 5**'s native `filter` if available.
// Aliased as `select`.
x.filter=x.select=function(a,b,c){var d=[];return null==a?d:p&&a.filter===p?a.filter(b,c):(y(a,function(a,e,f){b.call(c,a,e,f)&&d.push(a)}),d)},// Return all the elements for which a truth test fails.
x.reject=function(a,b,c){return x.filter(a,function(a,d,e){return!b.call(c,a,d,e)},c)},// Determine whether all of the elements match a truth test.
// Delegates to **ECMAScript 5**'s native `every` if available.
// Aliased as `all`.
x.every=x.all=function(a,b,d){b||(b=x.identity);var e=!0;return null==a?e:q&&a.every===q?a.every(b,d):(y(a,function(a,f,g){return(e=e&&b.call(d,a,f,g))?void 0:c}),!!e)};// Determine if at least one element in the object matches a truth test.
// Delegates to **ECMAScript 5**'s native `some` if available.
// Aliased as `any`.
var A=x.some=x.any=function(a,b,d){b||(b=x.identity);var e=!1;return null==a?e:r&&a.some===r?a.some(b,d):(y(a,function(a,f,g){return e||(e=b.call(d,a,f,g))?c:void 0}),!!e)};// Determine if the array or object contains a given value (using `===`).
// Aliased as `include`.
x.contains=x.include=function(a,b){return null==a?!1:s&&a.indexOf===s?-1!=a.indexOf(b):A(a,function(a){return a===b})},// Invoke a method (with arguments) on every item in a collection.
x.invoke=function(a,b){var c=h.call(arguments,2),d=x.isFunction(b);return x.map(a,function(a){return(d?b:a[b]).apply(a,c)})},// Convenience version of a common use case of `map`: fetching a property.
x.pluck=function(a,b){return x.map(a,function(a){return a[b]})},// Convenience version of a common use case of `filter`: selecting only objects
// containing specific `key:value` pairs.
x.where=function(a,b,c){return x.isEmpty(b)?c?void 0:[]:x[c?"find":"filter"](a,function(a){for(var c in b)if(b[c]!==a[c])return!1;return!0})},// Convenience version of a common use case of `find`: getting the first object
// containing specific `key:value` pairs.
x.findWhere=function(a,b){return x.where(a,b,!0)},// Return the maximum element or (element-based computation).
// Can't optimize arrays of integers longer than 65,535 elements.
// See [WebKit Bug 80797](https://bugs.webkit.org/show_bug.cgi?id=80797)
x.max=function(a,b,c){if(!b&&x.isArray(a)&&a[0]===+a[0]&&a.length<65535)return Math.max.apply(Math,a);if(!b&&x.isEmpty(a))return-1/0;var d={computed:-1/0,value:-1/0};return y(a,function(a,e,f){var g=b?b.call(c,a,e,f):a;g>d.computed&&(d={value:a,computed:g})}),d.value},// Return the minimum element (or element-based computation).
x.min=function(a,b,c){if(!b&&x.isArray(a)&&a[0]===+a[0]&&a.length<65535)return Math.min.apply(Math,a);if(!b&&x.isEmpty(a))return 1/0;var d={computed:1/0,value:1/0};return y(a,function(a,e,f){var g=b?b.call(c,a,e,f):a;g<d.computed&&(d={value:a,computed:g})}),d.value},// Shuffle an array, using the modern version of the 
// [Fisher-Yates shuffle](http://en.wikipedia.org/wiki/Fisher–Yates_shuffle).
x.shuffle=function(a){var b,c=0,d=[];return y(a,function(a){b=x.random(c++),d[c-1]=d[b],d[b]=a}),d},// Sample **n** random values from an array.
// If **n** is not specified, returns a single random element from the array.
// The internal `guard` argument allows it to work with `map`.
x.sample=function(a,b,c){return arguments.length<2||c?a[x.random(a.length-1)]:x.shuffle(a).slice(0,Math.max(0,b))};// An internal function to generate lookup iterators.
var B=function(a){return x.isFunction(a)?a:function(b){return b[a]}};// Sort the object's values by a criterion produced by an iterator.
x.sortBy=function(a,b,c){var d=B(b);return x.pluck(x.map(a,function(a,b,e){return{value:a,index:b,criteria:d.call(c,a,b,e)}}).sort(function(a,b){var c=a.criteria,d=b.criteria;if(c!==d){if(c>d||void 0===c)return 1;if(d>c||void 0===d)return-1}return a.index-b.index}),"value")};// An internal function used for aggregate "group by" operations.
var C=function(a){return function(b,c,d){var e={},f=null==c?x.identity:B(c);return y(b,function(c,g){var h=f.call(d,c,g,b);a(e,h,c)}),e}};// Groups the object's values by a criterion. Pass either a string attribute
// to group by, or a function that returns the criterion.
x.groupBy=C(function(a,b,c){(x.has(a,b)?a[b]:a[b]=[]).push(c)}),// Indexes the object's values by a criterion, similar to `groupBy`, but for
// when you know that your index values will be unique.
x.indexBy=C(function(a,b,c){a[b]=c}),// Counts instances of an object that group by a certain criterion. Pass
// either a string attribute to count by, or a function that returns the
// criterion.
x.countBy=C(function(a,b){x.has(a,b)?a[b]++:a[b]=1}),// Use a comparator function to figure out the smallest index at which
// an object should be inserted so as to maintain order. Uses binary search.
x.sortedIndex=function(a,b,c,d){c=null==c?x.identity:B(c);for(var e=c.call(d,b),f=0,g=a.length;g>f;){var h=f+g>>>1;c.call(d,a[h])<e?f=h+1:g=h}return f},// Safely create a real, live array from anything iterable.
x.toArray=function(a){return a?x.isArray(a)?h.call(a):a.length===+a.length?x.map(a,x.identity):x.values(a):[]},// Return the number of elements in an object.
x.size=function(a){return null==a?0:a.length===+a.length?a.length:x.keys(a).length},// Array Functions
// ---------------
// Get the first element of an array. Passing **n** will return the first N
// values in the array. Aliased as `head` and `take`. The **guard** check
// allows it to work with `_.map`.
x.first=x.head=x.take=function(a,b,c){return null==a?void 0:null==b||c?a[0]:h.call(a,0,b)},// Returns everything but the last entry of the array. Especially useful on
// the arguments object. Passing **n** will return all the values in
// the array, excluding the last N. The **guard** check allows it to work with
// `_.map`.
x.initial=function(a,b,c){return h.call(a,0,a.length-(null==b||c?1:b))},// Get the last element of an array. Passing **n** will return the last N
// values in the array. The **guard** check allows it to work with `_.map`.
x.last=function(a,b,c){return null==a?void 0:null==b||c?a[a.length-1]:h.call(a,Math.max(a.length-b,0))},// Returns everything but the first entry of the array. Aliased as `tail` and `drop`.
// Especially useful on the arguments object. Passing an **n** will return
// the rest N values in the array. The **guard**
// check allows it to work with `_.map`.
x.rest=x.tail=x.drop=function(a,b,c){return h.call(a,null==b||c?1:b)},// Trim out all falsy values from an array.
x.compact=function(a){return x.filter(a,x.identity)};// Internal implementation of a recursive `flatten` function.
var D=function(a,b,c){return b&&x.every(a,x.isArray)?i.apply(c,a):(y(a,function(a){x.isArray(a)||x.isArguments(a)?b?g.apply(c,a):D(a,b,c):c.push(a)}),c)};// Flatten out an array, either recursively (by default), or just one level.
x.flatten=function(a,b){return D(a,b,[])},// Return a version of the array that does not contain the specified value(s).
x.without=function(a){return x.difference(a,h.call(arguments,1))},// Produce a duplicate-free version of the array. If the array has already
// been sorted, you have the option of using a faster algorithm.
// Aliased as `unique`.
x.uniq=x.unique=function(a,b,c,d){x.isFunction(b)&&(d=c,c=b,b=!1);var e=c?x.map(a,c,d):a,f=[],g=[];return y(e,function(c,d){(b?d&&g[g.length-1]===c:x.contains(g,c))||(g.push(c),f.push(a[d]))}),f},// Produce an array that contains the union: each distinct element from all of
// the passed-in arrays.
x.union=function(){return x.uniq(x.flatten(arguments,!0))},// Produce an array that contains every item shared between all the
// passed-in arrays.
x.intersection=function(a){var b=h.call(arguments,1);return x.filter(x.uniq(a),function(a){return x.every(b,function(b){return x.indexOf(b,a)>=0})})},// Take the difference between one array and a number of other arrays.
// Only the elements present in just the first array will remain.
x.difference=function(a){var b=i.apply(d,h.call(arguments,1));return x.filter(a,function(a){return!x.contains(b,a)})},// Zip together multiple lists into a single array -- elements that share
// an index go together.
x.zip=function(){for(var a=x.max(x.pluck(arguments,"length").concat(0)),b=new Array(a),c=0;a>c;c++)b[c]=x.pluck(arguments,""+c);return b},// Converts lists into objects. Pass either a single array of `[key, value]`
// pairs, or two parallel arrays of the same length -- one of keys, and one of
// the corresponding values.
x.object=function(a,b){if(null==a)return{};for(var c={},d=0,e=a.length;e>d;d++)b?c[a[d]]=b[d]:c[a[d][0]]=a[d][1];return c},// If the browser doesn't supply us with indexOf (I'm looking at you, **MSIE**),
// we need this function. Return the position of the first occurrence of an
// item in an array, or -1 if the item is not included in the array.
// Delegates to **ECMAScript 5**'s native `indexOf` if available.
// If the array is large and already in sort order, pass `true`
// for **isSorted** to use binary search.
x.indexOf=function(a,b,c){if(null==a)return-1;var d=0,e=a.length;if(c){if("number"!=typeof c)return d=x.sortedIndex(a,b),a[d]===b?d:-1;d=0>c?Math.max(0,e+c):c}if(s&&a.indexOf===s)return a.indexOf(b,c);for(;e>d;d++)if(a[d]===b)return d;return-1},// Delegates to **ECMAScript 5**'s native `lastIndexOf` if available.
x.lastIndexOf=function(a,b,c){if(null==a)return-1;var d=null!=c;if(t&&a.lastIndexOf===t)return d?a.lastIndexOf(b,c):a.lastIndexOf(b);for(var e=d?c:a.length;e--;)if(a[e]===b)return e;return-1},// Generate an integer Array containing an arithmetic progression. A port of
// the native Python `range()` function. See
// [the Python documentation](http://docs.python.org/library/functions.html#range).
x.range=function(a,b,c){arguments.length<=1&&(b=a||0,a=0),c=arguments[2]||1;for(var d=Math.max(Math.ceil((b-a)/c),0),e=0,f=new Array(d);d>e;)f[e++]=a,a+=c;return f};// Function (ahem) Functions
// ------------------
// Reusable constructor function for prototype setting.
var E=function(){};// Create a function bound to a given object (assigning `this`, and arguments,
// optionally). Delegates to **ECMAScript 5**'s native `Function.bind` if
// available.
x.bind=function(a,b){var c,d;if(w&&a.bind===w)return w.apply(a,h.call(arguments,1));if(!x.isFunction(a))throw new TypeError;return c=h.call(arguments,2),d=function(){if(!(this instanceof d))return a.apply(b,c.concat(h.call(arguments)));E.prototype=a.prototype;var e=new E;E.prototype=null;var f=a.apply(e,c.concat(h.call(arguments)));return Object(f)===f?f:e}},// Partially apply a function by creating a version that has had some of its
// arguments pre-filled, without changing its dynamic `this` context.
x.partial=function(a){var b=h.call(arguments,1);return function(){return a.apply(this,b.concat(h.call(arguments)))}},// Bind all of an object's methods to that object. Useful for ensuring that
// all callbacks defined on an object belong to it.
x.bindAll=function(a){var b=h.call(arguments,1);if(0===b.length)throw new Error("bindAll must be passed function names");return y(b,function(b){a[b]=x.bind(a[b],a)}),a},// Memoize an expensive function by storing its results.
x.memoize=function(a,b){var c={};return b||(b=x.identity),function(){var d=b.apply(this,arguments);return x.has(c,d)?c[d]:c[d]=a.apply(this,arguments)}},// Delays a function for the given number of milliseconds, and then calls
// it with the arguments supplied.
x.delay=function(a,b){var c=h.call(arguments,2);return setTimeout(function(){return a.apply(null,c)},b)},// Defers a function, scheduling it to run after the current call stack has
// cleared.
x.defer=function(a){return x.delay.apply(x,[a,1].concat(h.call(arguments,1)))},// Returns a function, that, when invoked, will only be triggered at most once
// during a given window of time. Normally, the throttled function will run
// as much as it can, without ever going more than once per `wait` duration;
// but if you'd like to disable the execution on the leading edge, pass
// `{leading: false}`. To disable execution on the trailing edge, ditto.
x.throttle=function(a,b,c){var d,e,f,g=null,h=0;c||(c={});var i=function(){h=c.leading===!1?0:new Date,g=null,f=a.apply(d,e)};return function(){var j=new Date;h||c.leading!==!1||(h=j);var k=b-(j-h);return d=this,e=arguments,0>=k?(clearTimeout(g),g=null,h=j,f=a.apply(d,e)):g||c.trailing===!1||(g=setTimeout(i,k)),f}},// Returns a function, that, as long as it continues to be invoked, will not
// be triggered. The function will be called after it stops being called for
// N milliseconds. If `immediate` is passed, trigger the function on the
// leading edge, instead of the trailing.
x.debounce=function(a,b,c){var d,e,f,g,h;return function(){f=this,e=arguments,g=new Date;var i=function(){var j=new Date-g;b>j?d=setTimeout(i,b-j):(d=null,c||(h=a.apply(f,e)))},j=c&&!d;return d||(d=setTimeout(i,b)),j&&(h=a.apply(f,e)),h}},// Returns a function that will be executed at most one time, no matter how
// often you call it. Useful for lazy initialization.
x.once=function(a){var b,c=!1;return function(){return c?b:(c=!0,b=a.apply(this,arguments),a=null,b)}},// Returns the first function passed as an argument to the second,
// allowing you to adjust arguments, run code before and after, and
// conditionally execute the original function.
x.wrap=function(a,b){return function(){var c=[a];return g.apply(c,arguments),b.apply(this,c)}},// Returns a function that is the composition of a list of functions, each
// consuming the return value of the function that follows.
x.compose=function(){var a=arguments;return function(){for(var b=arguments,c=a.length-1;c>=0;c--)b=[a[c].apply(this,b)];return b[0]}},// Returns a function that will only be executed after being called N times.
x.after=function(a,b){return function(){return--a<1?b.apply(this,arguments):void 0}},// Object Functions
// ----------------
// Retrieve the names of an object's properties.
// Delegates to **ECMAScript 5**'s native `Object.keys`
x.keys=v||function(a){if(a!==Object(a))throw new TypeError("Invalid object");var b=[];for(var c in a)x.has(a,c)&&b.push(c);return b},// Retrieve the values of an object's properties.
x.values=function(a){for(var b=x.keys(a),c=b.length,d=new Array(c),e=0;c>e;e++)d[e]=a[b[e]];return d},// Convert an object into a list of `[key, value]` pairs.
x.pairs=function(a){for(var b=x.keys(a),c=b.length,d=new Array(c),e=0;c>e;e++)d[e]=[b[e],a[b[e]]];return d},// Invert the keys and values of an object. The values must be serializable.
x.invert=function(a){for(var b={},c=x.keys(a),d=0,e=c.length;e>d;d++)b[a[c[d]]]=c[d];return b},// Return a sorted list of the function names available on the object.
// Aliased as `methods`
x.functions=x.methods=function(a){var b=[];for(var c in a)x.isFunction(a[c])&&b.push(c);return b.sort()},// Extend a given object with all the properties in passed-in object(s).
x.extend=function(a){return y(h.call(arguments,1),function(b){if(b)for(var c in b)a[c]=b[c]}),a},// Return a copy of the object only containing the whitelisted properties.
x.pick=function(a){var b={},c=i.apply(d,h.call(arguments,1));return y(c,function(c){c in a&&(b[c]=a[c])}),b},// Return a copy of the object without the blacklisted properties.
x.omit=function(a){var b={},c=i.apply(d,h.call(arguments,1));for(var e in a)x.contains(c,e)||(b[e]=a[e]);return b},// Fill in a given object with default properties.
x.defaults=function(a){return y(h.call(arguments,1),function(b){if(b)for(var c in b)void 0===a[c]&&(a[c]=b[c])}),a},// Create a (shallow-cloned) duplicate of an object.
x.clone=function(a){return x.isObject(a)?x.isArray(a)?a.slice():x.extend({},a):a},// Invokes interceptor with the obj, and then returns obj.
// The primary purpose of this method is to "tap into" a method chain, in
// order to perform operations on intermediate results within the chain.
x.tap=function(a,b){return b(a),a};// Internal recursive comparison function for `isEqual`.
var F=function(a,b,c,d){// Identical objects are equal. `0 === -0`, but they aren't identical.
// See the [Harmony `egal` proposal](http://wiki.ecmascript.org/doku.php?id=harmony:egal).
if(a===b)return 0!==a||1/a==1/b;// A strict comparison is necessary because `null == undefined`.
if(null==a||null==b)return a===b;// Unwrap any wrapped objects.
a instanceof x&&(a=a._wrapped),b instanceof x&&(b=b._wrapped);// Compare `[[Class]]` names.
var e=j.call(a);if(e!=j.call(b))return!1;switch(e){// Strings, numbers, dates, and booleans are compared by value.
case"[object String]":// Primitives and their corresponding object wrappers are equivalent; thus, `"5"` is
// equivalent to `new String("5")`.
return a==String(b);case"[object Number]":// `NaN`s are equivalent, but non-reflexive. An `egal` comparison is performed for
// other numeric values.
return a!=+a?b!=+b:0==a?1/a==1/b:a==+b;case"[object Date]":case"[object Boolean]":// Coerce dates and booleans to numeric primitive values. Dates are compared by their
// millisecond representations. Note that invalid dates with millisecond representations
// of `NaN` are not equivalent.
return+a==+b;// RegExps are compared by their source patterns and flags.
case"[object RegExp]":return a.source==b.source&&a.global==b.global&&a.multiline==b.multiline&&a.ignoreCase==b.ignoreCase}if("object"!=typeof a||"object"!=typeof b)return!1;for(// Assume equality for cyclic structures. The algorithm for detecting cyclic
// structures is adapted from ES 5.1 section 15.12.3, abstract operation `JO`.
var f=c.length;f--;)// Linear search. Performance is inversely proportional to the number of
// unique nested structures.
if(c[f]==a)return d[f]==b;// Objects with different constructors are not equivalent, but `Object`s
// from different frames are.
var g=a.constructor,h=b.constructor;if(g!==h&&!(x.isFunction(g)&&g instanceof g&&x.isFunction(h)&&h instanceof h))return!1;// Add the first object to the stack of traversed objects.
c.push(a),d.push(b);var i=0,k=!0;// Recursively compare objects and arrays.
if("[object Array]"==e){if(// Compare array lengths to determine if a deep comparison is necessary.
i=a.length,k=i==b.length)// Deep compare the contents, ignoring non-numeric properties.
for(;i--&&(k=F(a[i],b[i],c,d)););}else{// Deep compare objects.
for(var l in a)if(x.has(a,l)&&(// Count the expected number of properties.
i++,!(k=x.has(b,l)&&F(a[l],b[l],c,d))))break;// Ensure that both objects contain the same number of properties.
if(k){for(l in b)if(x.has(b,l)&&!i--)break;k=!i}}// Remove the first object from the stack of traversed objects.
return c.pop(),d.pop(),k};// Perform a deep comparison to check if two objects are equal.
x.isEqual=function(a,b){return F(a,b,[],[])},// Is a given array, string, or object empty?
// An "empty" object has no enumerable own-properties.
x.isEmpty=function(a){if(null==a)return!0;if(x.isArray(a)||x.isString(a))return 0===a.length;for(var b in a)if(x.has(a,b))return!1;return!0},// Is a given value a DOM element?
x.isElement=function(a){return!(!a||1!==a.nodeType)},// Is a given value an array?
// Delegates to ECMA5's native Array.isArray
x.isArray=u||function(a){return"[object Array]"==j.call(a)},// Is a given variable an object?
x.isObject=function(a){return a===Object(a)},// Add some isType methods: isArguments, isFunction, isString, isNumber, isDate, isRegExp.
y(["Arguments","Function","String","Number","Date","RegExp"],function(a){x["is"+a]=function(b){return j.call(b)=="[object "+a+"]"}}),// Define a fallback version of the method in browsers (ahem, IE), where
// there isn't any inspectable "Arguments" type.
x.isArguments(arguments)||(x.isArguments=function(a){return!(!a||!x.has(a,"callee"))}),// Optimize `isFunction` if appropriate.
"function"!=typeof/./&&(x.isFunction=function(a){return"function"==typeof a}),// Is a given object a finite number?
x.isFinite=function(a){return isFinite(a)&&!isNaN(parseFloat(a))},// Is the given value `NaN`? (NaN is the only number which does not equal itself).
x.isNaN=function(a){return x.isNumber(a)&&a!=+a},// Is a given value a boolean?
x.isBoolean=function(a){return a===!0||a===!1||"[object Boolean]"==j.call(a)},// Is a given value equal to null?
x.isNull=function(a){return null===a},// Is a given variable undefined?
x.isUndefined=function(a){return void 0===a},// Shortcut function for checking if an object has a given property directly
// on itself (in other words, not on a prototype).
x.has=function(a,b){return k.call(a,b)},// Utility Functions
// -----------------
// Run Underscore.js in *noConflict* mode, returning the `_` variable to its
// previous owner. Returns a reference to the Underscore object.
x.noConflict=function(){return a._=b,this},// Keep the identity function around for default iterators.
x.identity=function(a){return a},// Run a function **n** times.
x.times=function(a,b,c){for(var d=Array(Math.max(0,a)),e=0;a>e;e++)d[e]=b.call(c,e);return d},// Return a random integer between min and max (inclusive).
x.random=function(a,b){return null==b&&(b=a,a=0),a+Math.floor(Math.random()*(b-a+1))};// List of HTML entities for escaping.
var G={escape:{"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;","'":"&#x27;"}};G.unescape=x.invert(G.escape);// Regexes containing the keys and values listed immediately above.
var H={escape:new RegExp("["+x.keys(G.escape).join("")+"]","g"),unescape:new RegExp("("+x.keys(G.unescape).join("|")+")","g")};// Functions for escaping and unescaping strings to/from HTML interpolation.
x.each(["escape","unescape"],function(a){x[a]=function(b){return null==b?"":(""+b).replace(H[a],function(b){return G[a][b]})}}),// If the value of the named `property` is a function then invoke it with the
// `object` as context; otherwise, return it.
x.result=function(a,b){if(null==a)return void 0;var c=a[b];return x.isFunction(c)?c.call(a):c},// Add your own custom functions to the Underscore object.
x.mixin=function(a){y(x.functions(a),function(b){var c=x[b]=a[b];x.prototype[b]=function(){var a=[this._wrapped];return g.apply(a,arguments),M.call(this,c.apply(x,a))}})};// Generate a unique integer id (unique within the entire client session).
// Useful for temporary DOM ids.
var I=0;x.uniqueId=function(a){var b=++I+"";return a?a+b:b},// By default, Underscore uses ERB-style template delimiters, change the
// following template settings to use alternative delimiters.
x.templateSettings={evaluate:/<%([\s\S]+?)%>/g,interpolate:/<%=([\s\S]+?)%>/g,escape:/<%-([\s\S]+?)%>/g};// When customizing `templateSettings`, if you don't want to define an
// interpolation, evaluation or escaping regex, we need one that is
// guaranteed not to match.
var J=/(.)^/,K={"'":"'","\\":"\\","\r":"r","\n":"n","	":"t","\u2028":"u2028","\u2029":"u2029"},L=/\\|'|\r|\n|\t|\u2028|\u2029/g;// JavaScript micro-templating, similar to John Resig's implementation.
// Underscore templating handles arbitrary delimiters, preserves whitespace,
// and correctly escapes quotes within interpolated code.
x.template=function(a,b,c){var d;c=x.defaults({},c,x.templateSettings);// Combine delimiters into one regular expression via alternation.
var e=new RegExp([(c.escape||J).source,(c.interpolate||J).source,(c.evaluate||J).source].join("|")+"|$","g"),f=0,g="__p+='";a.replace(e,function(b,c,d,e,h){return g+=a.slice(f,h).replace(L,function(a){return"\\"+K[a]}),c&&(g+="'+\n((__t=("+c+"))==null?'':_.escape(__t))+\n'"),d&&(g+="'+\n((__t=("+d+"))==null?'':__t)+\n'"),e&&(g+="';\n"+e+"\n__p+='"),f=h+b.length,b}),g+="';\n",// If a variable is not specified, place data values in local scope.
c.variable||(g="with(obj||{}){\n"+g+"}\n"),g="var __t,__p='',__j=Array.prototype.join,print=function(){__p+=__j.call(arguments,'');};\n"+g+"return __p;\n";try{d=new Function(c.variable||"obj","_",g)}catch(h){throw h.source=g,h}if(b)return d(b,x);var i=function(a){return d.call(this,a,x)};// Provide the compiled function source as a convenience for precompilation.
return i.source="function("+(c.variable||"obj")+"){\n"+g+"}",i},// Add a "chain" function, which will delegate to the wrapper.
x.chain=function(a){return x(a).chain()};// OOP
// ---------------
// If Underscore is called as a function, it returns a wrapped object that
// can be used OO-style. This wrapper holds altered versions of all the
// underscore functions. Wrapped objects may be chained.
// Helper function to continue chaining intermediate results.
var M=function(a){return this._chain?x(a).chain():a};// Add all of the Underscore functions to the wrapper object.
x.mixin(x),// Add all mutator Array functions to the wrapper.
y(["pop","push","reverse","shift","sort","splice","unshift"],function(a){var b=d[a];x.prototype[a]=function(){var c=this._wrapped;return b.apply(c,arguments),"shift"!=a&&"splice"!=a||0!==c.length||delete c[0],M.call(this,c)}}),// Add all accessor Array functions to the wrapper.
y(["concat","join","slice"],function(a){var b=d[a];x.prototype[a]=function(){return M.call(this,b.apply(this._wrapped,arguments))}}),x.extend(x.prototype,{// Start chaining a wrapped Underscore object.
chain:function(){return this._chain=!0,this},// Extracts the result from a wrapped and chained object.
value:function(){return this._wrapped}})}).call(this);