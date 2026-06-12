(function(scope){
'use strict';

function F(arity, fun, wrapper) {
  wrapper.a = arity;
  wrapper.f = fun;
  return wrapper;
}

function F2(fun) {
  return F(2, fun, function(a) { return function(b) { return fun(a,b); }; })
}
function F3(fun) {
  return F(3, fun, function(a) {
    return function(b) { return function(c) { return fun(a, b, c); }; };
  });
}
function F4(fun) {
  return F(4, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return fun(a, b, c, d); }; }; };
  });
}
function F5(fun) {
  return F(5, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return fun(a, b, c, d, e); }; }; }; };
  });
}
function F6(fun) {
  return F(6, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return fun(a, b, c, d, e, f); }; }; }; }; };
  });
}
function F7(fun) {
  return F(7, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return fun(a, b, c, d, e, f, g); }; }; }; }; }; };
  });
}
function F8(fun) {
  return F(8, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return function(h) {
    return fun(a, b, c, d, e, f, g, h); }; }; }; }; }; }; };
  });
}
function F9(fun) {
  return F(9, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return function(h) { return function(i) {
    return fun(a, b, c, d, e, f, g, h, i); }; }; }; }; }; }; }; };
  });
}

function A2(fun, a, b) {
  return fun.a === 2 ? fun.f(a, b) : fun(a)(b);
}
function A3(fun, a, b, c) {
  return fun.a === 3 ? fun.f(a, b, c) : fun(a)(b)(c);
}
function A4(fun, a, b, c, d) {
  return fun.a === 4 ? fun.f(a, b, c, d) : fun(a)(b)(c)(d);
}
function A5(fun, a, b, c, d, e) {
  return fun.a === 5 ? fun.f(a, b, c, d, e) : fun(a)(b)(c)(d)(e);
}
function A6(fun, a, b, c, d, e, f) {
  return fun.a === 6 ? fun.f(a, b, c, d, e, f) : fun(a)(b)(c)(d)(e)(f);
}
function A7(fun, a, b, c, d, e, f, g) {
  return fun.a === 7 ? fun.f(a, b, c, d, e, f, g) : fun(a)(b)(c)(d)(e)(f)(g);
}
function A8(fun, a, b, c, d, e, f, g, h) {
  return fun.a === 8 ? fun.f(a, b, c, d, e, f, g, h) : fun(a)(b)(c)(d)(e)(f)(g)(h);
}
function A9(fun, a, b, c, d, e, f, g, h, i) {
  return fun.a === 9 ? fun.f(a, b, c, d, e, f, g, h, i) : fun(a)(b)(c)(d)(e)(f)(g)(h)(i);
}

console.warn('Compiled in DEV mode. Follow the advice at https://elm-lang.org/0.19.1/optimize for better performance and smaller assets.');


var _List_Nil_UNUSED = { $: 0 };
var _List_Nil = { $: '[]' };

function _List_Cons_UNUSED(hd, tl) { return { $: 1, a: hd, b: tl }; }
function _List_Cons(hd, tl) { return { $: '::', a: hd, b: tl }; }


var _List_cons = F2(_List_Cons);

function _List_fromArray(arr)
{
	var out = _List_Nil;
	for (var i = arr.length; i--; )
	{
		out = _List_Cons(arr[i], out);
	}
	return out;
}

function _List_toArray(xs)
{
	for (var out = []; xs.b; xs = xs.b) // WHILE_CONS
	{
		out.push(xs.a);
	}
	return out;
}

var _List_map2 = F3(function(f, xs, ys)
{
	for (var arr = []; xs.b && ys.b; xs = xs.b, ys = ys.b) // WHILE_CONSES
	{
		arr.push(A2(f, xs.a, ys.a));
	}
	return _List_fromArray(arr);
});

var _List_map3 = F4(function(f, xs, ys, zs)
{
	for (var arr = []; xs.b && ys.b && zs.b; xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A3(f, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_map4 = F5(function(f, ws, xs, ys, zs)
{
	for (var arr = []; ws.b && xs.b && ys.b && zs.b; ws = ws.b, xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A4(f, ws.a, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_map5 = F6(function(f, vs, ws, xs, ys, zs)
{
	for (var arr = []; vs.b && ws.b && xs.b && ys.b && zs.b; vs = vs.b, ws = ws.b, xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A5(f, vs.a, ws.a, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_sortBy = F2(function(f, xs)
{
	return _List_fromArray(_List_toArray(xs).sort(function(a, b) {
		return _Utils_cmp(f(a), f(b));
	}));
});

var _List_sortWith = F2(function(f, xs)
{
	return _List_fromArray(_List_toArray(xs).sort(function(a, b) {
		var ord = A2(f, a, b);
		return ord === $elm$core$Basics$EQ ? 0 : ord === $elm$core$Basics$LT ? -1 : 1;
	}));
});



var _JsArray_empty = [];

function _JsArray_singleton(value)
{
    return [value];
}

function _JsArray_length(array)
{
    return array.length;
}

var _JsArray_initialize = F3(function(size, offset, func)
{
    var result = new Array(size);

    for (var i = 0; i < size; i++)
    {
        result[i] = func(offset + i);
    }

    return result;
});

var _JsArray_initializeFromList = F2(function (max, ls)
{
    var result = new Array(max);

    for (var i = 0; i < max && ls.b; i++)
    {
        result[i] = ls.a;
        ls = ls.b;
    }

    result.length = i;
    return _Utils_Tuple2(result, ls);
});

var _JsArray_unsafeGet = F2(function(index, array)
{
    return array[index];
});

var _JsArray_unsafeSet = F3(function(index, value, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = array[i];
    }

    result[index] = value;
    return result;
});

var _JsArray_push = F2(function(value, array)
{
    var length = array.length;
    var result = new Array(length + 1);

    for (var i = 0; i < length; i++)
    {
        result[i] = array[i];
    }

    result[length] = value;
    return result;
});

var _JsArray_foldl = F3(function(func, acc, array)
{
    var length = array.length;

    for (var i = 0; i < length; i++)
    {
        acc = A2(func, array[i], acc);
    }

    return acc;
});

var _JsArray_foldr = F3(function(func, acc, array)
{
    for (var i = array.length - 1; i >= 0; i--)
    {
        acc = A2(func, array[i], acc);
    }

    return acc;
});

var _JsArray_map = F2(function(func, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = func(array[i]);
    }

    return result;
});

var _JsArray_indexedMap = F3(function(func, offset, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = A2(func, offset + i, array[i]);
    }

    return result;
});

var _JsArray_slice = F3(function(from, to, array)
{
    return array.slice(from, to);
});

var _JsArray_appendN = F3(function(n, dest, source)
{
    var destLen = dest.length;
    var itemsToCopy = n - destLen;

    if (itemsToCopy > source.length)
    {
        itemsToCopy = source.length;
    }

    var size = destLen + itemsToCopy;
    var result = new Array(size);

    for (var i = 0; i < destLen; i++)
    {
        result[i] = dest[i];
    }

    for (var i = 0; i < itemsToCopy; i++)
    {
        result[i + destLen] = source[i];
    }

    return result;
});



// LOG

var _Debug_log_UNUSED = F2(function(tag, value)
{
	return value;
});

var _Debug_log = F2(function(tag, value)
{
	console.log(tag + ': ' + _Debug_toString(value));
	return value;
});


// TODOS

function _Debug_todo(moduleName, region)
{
	return function(message) {
		_Debug_crash(8, moduleName, region, message);
	};
}

function _Debug_todoCase(moduleName, region, value)
{
	return function(message) {
		_Debug_crash(9, moduleName, region, value, message);
	};
}


// TO STRING

function _Debug_toString_UNUSED(value)
{
	return '<internals>';
}

function _Debug_toString(value)
{
	return _Debug_toAnsiString(false, value);
}

function _Debug_toAnsiString(ansi, value)
{
	if (typeof value === 'function')
	{
		return _Debug_internalColor(ansi, '<function>');
	}

	if (typeof value === 'boolean')
	{
		return _Debug_ctorColor(ansi, value ? 'True' : 'False');
	}

	if (typeof value === 'number')
	{
		return _Debug_numberColor(ansi, value + '');
	}

	if (value instanceof String)
	{
		return _Debug_charColor(ansi, "'" + _Debug_addSlashes(value, true) + "'");
	}

	if (typeof value === 'string')
	{
		return _Debug_stringColor(ansi, '"' + _Debug_addSlashes(value, false) + '"');
	}

	if (typeof value === 'object' && '$' in value)
	{
		var tag = value.$;

		if (typeof tag === 'number')
		{
			return _Debug_internalColor(ansi, '<internals>');
		}

		if (tag[0] === '#')
		{
			var output = [];
			for (var k in value)
			{
				if (k === '$') continue;
				output.push(_Debug_toAnsiString(ansi, value[k]));
			}
			return '(' + output.join(',') + ')';
		}

		if (tag === 'Set_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Set')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, $elm$core$Set$toList(value));
		}

		if (tag === 'RBNode_elm_builtin' || tag === 'RBEmpty_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Dict')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, $elm$core$Dict$toList(value));
		}

		if (tag === 'Array_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Array')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, $elm$core$Array$toList(value));
		}

		if (tag === '::' || tag === '[]')
		{
			var output = '[';

			value.b && (output += _Debug_toAnsiString(ansi, value.a), value = value.b)

			for (; value.b; value = value.b) // WHILE_CONS
			{
				output += ',' + _Debug_toAnsiString(ansi, value.a);
			}
			return output + ']';
		}

		var output = '';
		for (var i in value)
		{
			if (i === '$') continue;
			var str = _Debug_toAnsiString(ansi, value[i]);
			var c0 = str[0];
			var parenless = c0 === '{' || c0 === '(' || c0 === '[' || c0 === '<' || c0 === '"' || str.indexOf(' ') < 0;
			output += ' ' + (parenless ? str : '(' + str + ')');
		}
		return _Debug_ctorColor(ansi, tag) + output;
	}

	if (typeof DataView === 'function' && value instanceof DataView)
	{
		return _Debug_stringColor(ansi, '<' + value.byteLength + ' bytes>');
	}

	if (typeof File !== 'undefined' && value instanceof File)
	{
		return _Debug_internalColor(ansi, '<' + value.name + '>');
	}

	if (typeof value === 'object')
	{
		var output = [];
		for (var key in value)
		{
			var field = key[0] === '_' ? key.slice(1) : key;
			output.push(_Debug_fadeColor(ansi, field) + ' = ' + _Debug_toAnsiString(ansi, value[key]));
		}
		if (output.length === 0)
		{
			return '{}';
		}
		return '{ ' + output.join(', ') + ' }';
	}

	return _Debug_internalColor(ansi, '<internals>');
}

function _Debug_addSlashes(str, isChar)
{
	var s = str
		.replace(/\\/g, '\\\\')
		.replace(/\n/g, '\\n')
		.replace(/\t/g, '\\t')
		.replace(/\r/g, '\\r')
		.replace(/\v/g, '\\v')
		.replace(/\0/g, '\\0');

	if (isChar)
	{
		return s.replace(/\'/g, '\\\'');
	}
	else
	{
		return s.replace(/\"/g, '\\"');
	}
}

function _Debug_ctorColor(ansi, string)
{
	return ansi ? '\x1b[96m' + string + '\x1b[0m' : string;
}

function _Debug_numberColor(ansi, string)
{
	return ansi ? '\x1b[95m' + string + '\x1b[0m' : string;
}

function _Debug_stringColor(ansi, string)
{
	return ansi ? '\x1b[93m' + string + '\x1b[0m' : string;
}

function _Debug_charColor(ansi, string)
{
	return ansi ? '\x1b[92m' + string + '\x1b[0m' : string;
}

function _Debug_fadeColor(ansi, string)
{
	return ansi ? '\x1b[37m' + string + '\x1b[0m' : string;
}

function _Debug_internalColor(ansi, string)
{
	return ansi ? '\x1b[36m' + string + '\x1b[0m' : string;
}

function _Debug_toHexDigit(n)
{
	return String.fromCharCode(n < 10 ? 48 + n : 55 + n);
}


// CRASH


function _Debug_crash_UNUSED(identifier)
{
	throw new Error('https://github.com/elm/core/blob/1.0.0/hints/' + identifier + '.md');
}


function _Debug_crash(identifier, fact1, fact2, fact3, fact4)
{
	switch(identifier)
	{
		case 0:
			throw new Error('What node should I take over? In JavaScript I need something like:\n\n    Elm.Main.init({\n        node: document.getElementById("elm-node")\n    })\n\nYou need to do this with any Browser.sandbox or Browser.element program.');

		case 1:
			throw new Error('Browser.application programs cannot handle URLs like this:\n\n    ' + document.location.href + '\n\nWhat is the root? The root of your file system? Try looking at this program with `elm reactor` or some other server.');

		case 2:
			var jsonErrorString = fact1;
			throw new Error('Problem with the flags given to your Elm program on initialization.\n\n' + jsonErrorString);

		case 3:
			var portName = fact1;
			throw new Error('There can only be one port named `' + portName + '`, but your program has multiple.');

		case 4:
			var portName = fact1;
			var problem = fact2;
			throw new Error('Trying to send an unexpected type of value through port `' + portName + '`:\n' + problem);

		case 5:
			throw new Error('Trying to use `(==)` on functions.\nThere is no way to know if functions are "the same" in the Elm sense.\nRead more about this at https://package.elm-lang.org/packages/elm/core/latest/Basics#== which describes why it is this way and what the better version will look like.');

		case 6:
			var moduleName = fact1;
			throw new Error('Your page is loading multiple Elm scripts with a module named ' + moduleName + '. Maybe a duplicate script is getting loaded accidentally? If not, rename one of them so I know which is which!');

		case 8:
			var moduleName = fact1;
			var region = fact2;
			var message = fact3;
			throw new Error('TODO in module `' + moduleName + '` ' + _Debug_regionToString(region) + '\n\n' + message);

		case 9:
			var moduleName = fact1;
			var region = fact2;
			var value = fact3;
			var message = fact4;
			throw new Error(
				'TODO in module `' + moduleName + '` from the `case` expression '
				+ _Debug_regionToString(region) + '\n\nIt received the following value:\n\n    '
				+ _Debug_toString(value).replace('\n', '\n    ')
				+ '\n\nBut the branch that handles it says:\n\n    ' + message.replace('\n', '\n    ')
			);

		case 10:
			throw new Error('Bug in https://github.com/elm/virtual-dom/issues');

		case 11:
			throw new Error('Cannot perform mod 0. Division by zero error.');
	}
}

function _Debug_regionToString(region)
{
	if (region.start.line === region.end.line)
	{
		return 'on line ' + region.start.line;
	}
	return 'on lines ' + region.start.line + ' through ' + region.end.line;
}



// EQUALITY

function _Utils_eq(x, y)
{
	for (
		var pair, stack = [], isEqual = _Utils_eqHelp(x, y, 0, stack);
		isEqual && (pair = stack.pop());
		isEqual = _Utils_eqHelp(pair.a, pair.b, 0, stack)
		)
	{}

	return isEqual;
}

function _Utils_eqHelp(x, y, depth, stack)
{
	if (x === y)
	{
		return true;
	}

	if (typeof x !== 'object' || x === null || y === null)
	{
		typeof x === 'function' && _Debug_crash(5);
		return false;
	}

	if (depth > 100)
	{
		stack.push(_Utils_Tuple2(x,y));
		return true;
	}

	/**/
	if (x.$ === 'Set_elm_builtin')
	{
		x = $elm$core$Set$toList(x);
		y = $elm$core$Set$toList(y);
	}
	if (x.$ === 'RBNode_elm_builtin' || x.$ === 'RBEmpty_elm_builtin')
	{
		x = $elm$core$Dict$toList(x);
		y = $elm$core$Dict$toList(y);
	}
	//*/

	/**_UNUSED/
	if (x.$ < 0)
	{
		x = $elm$core$Dict$toList(x);
		y = $elm$core$Dict$toList(y);
	}
	//*/

	for (var key in x)
	{
		if (!_Utils_eqHelp(x[key], y[key], depth + 1, stack))
		{
			return false;
		}
	}
	return true;
}

var _Utils_equal = F2(_Utils_eq);
var _Utils_notEqual = F2(function(a, b) { return !_Utils_eq(a,b); });



// COMPARISONS

// Code in Generate/JavaScript.hs, Basics.js, and List.js depends on
// the particular integer values assigned to LT, EQ, and GT.

function _Utils_cmp(x, y, ord)
{
	if (typeof x !== 'object')
	{
		return x === y ? /*EQ*/ 0 : x < y ? /*LT*/ -1 : /*GT*/ 1;
	}

	/**/
	if (x instanceof String)
	{
		var a = x.valueOf();
		var b = y.valueOf();
		return a === b ? 0 : a < b ? -1 : 1;
	}
	//*/

	/**_UNUSED/
	if (typeof x.$ === 'undefined')
	//*/
	/**/
	if (x.$[0] === '#')
	//*/
	{
		return (ord = _Utils_cmp(x.a, y.a))
			? ord
			: (ord = _Utils_cmp(x.b, y.b))
				? ord
				: _Utils_cmp(x.c, y.c);
	}

	// traverse conses until end of a list or a mismatch
	for (; x.b && y.b && !(ord = _Utils_cmp(x.a, y.a)); x = x.b, y = y.b) {} // WHILE_CONSES
	return ord || (x.b ? /*GT*/ 1 : y.b ? /*LT*/ -1 : /*EQ*/ 0);
}

var _Utils_lt = F2(function(a, b) { return _Utils_cmp(a, b) < 0; });
var _Utils_le = F2(function(a, b) { return _Utils_cmp(a, b) < 1; });
var _Utils_gt = F2(function(a, b) { return _Utils_cmp(a, b) > 0; });
var _Utils_ge = F2(function(a, b) { return _Utils_cmp(a, b) >= 0; });

var _Utils_compare = F2(function(x, y)
{
	var n = _Utils_cmp(x, y);
	return n < 0 ? $elm$core$Basics$LT : n ? $elm$core$Basics$GT : $elm$core$Basics$EQ;
});


// COMMON VALUES

var _Utils_Tuple0_UNUSED = 0;
var _Utils_Tuple0 = { $: '#0' };

function _Utils_Tuple2_UNUSED(a, b) { return { a: a, b: b }; }
function _Utils_Tuple2(a, b) { return { $: '#2', a: a, b: b }; }

function _Utils_Tuple3_UNUSED(a, b, c) { return { a: a, b: b, c: c }; }
function _Utils_Tuple3(a, b, c) { return { $: '#3', a: a, b: b, c: c }; }

function _Utils_chr_UNUSED(c) { return c; }
function _Utils_chr(c) { return new String(c); }


// RECORDS

function _Utils_update(oldRecord, updatedFields)
{
	var newRecord = {};

	for (var key in oldRecord)
	{
		newRecord[key] = oldRecord[key];
	}

	for (var key in updatedFields)
	{
		newRecord[key] = updatedFields[key];
	}

	return newRecord;
}


// APPEND

var _Utils_append = F2(_Utils_ap);

function _Utils_ap(xs, ys)
{
	// append Strings
	if (typeof xs === 'string')
	{
		return xs + ys;
	}

	// append Lists
	if (!xs.b)
	{
		return ys;
	}
	var root = _List_Cons(xs.a, ys);
	xs = xs.b
	for (var curr = root; xs.b; xs = xs.b) // WHILE_CONS
	{
		curr = curr.b = _List_Cons(xs.a, ys);
	}
	return root;
}



// MATH

var _Basics_add = F2(function(a, b) { return a + b; });
var _Basics_sub = F2(function(a, b) { return a - b; });
var _Basics_mul = F2(function(a, b) { return a * b; });
var _Basics_fdiv = F2(function(a, b) { return a / b; });
var _Basics_idiv = F2(function(a, b) { return (a / b) | 0; });
var _Basics_pow = F2(Math.pow);

var _Basics_remainderBy = F2(function(b, a) { return a % b; });

// https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/divmodnote-letter.pdf
var _Basics_modBy = F2(function(modulus, x)
{
	var answer = x % modulus;
	return modulus === 0
		? _Debug_crash(11)
		:
	((answer > 0 && modulus < 0) || (answer < 0 && modulus > 0))
		? answer + modulus
		: answer;
});


// TRIGONOMETRY

var _Basics_pi = Math.PI;
var _Basics_e = Math.E;
var _Basics_cos = Math.cos;
var _Basics_sin = Math.sin;
var _Basics_tan = Math.tan;
var _Basics_acos = Math.acos;
var _Basics_asin = Math.asin;
var _Basics_atan = Math.atan;
var _Basics_atan2 = F2(Math.atan2);


// MORE MATH

function _Basics_toFloat(x) { return x; }
function _Basics_truncate(n) { return n | 0; }
function _Basics_isInfinite(n) { return n === Infinity || n === -Infinity; }

var _Basics_ceiling = Math.ceil;
var _Basics_floor = Math.floor;
var _Basics_round = Math.round;
var _Basics_sqrt = Math.sqrt;
var _Basics_log = Math.log;
var _Basics_isNaN = isNaN;


// BOOLEANS

function _Basics_not(bool) { return !bool; }
var _Basics_and = F2(function(a, b) { return a && b; });
var _Basics_or  = F2(function(a, b) { return a || b; });
var _Basics_xor = F2(function(a, b) { return a !== b; });



var _String_cons = F2(function(chr, str)
{
	return chr + str;
});

function _String_uncons(string)
{
	var word = string.charCodeAt(0);
	return !isNaN(word)
		? $elm$core$Maybe$Just(
			0xD800 <= word && word <= 0xDBFF
				? _Utils_Tuple2(_Utils_chr(string[0] + string[1]), string.slice(2))
				: _Utils_Tuple2(_Utils_chr(string[0]), string.slice(1))
		)
		: $elm$core$Maybe$Nothing;
}

var _String_append = F2(function(a, b)
{
	return a + b;
});

function _String_length(str)
{
	return str.length;
}

var _String_map = F2(function(func, string)
{
	var len = string.length;
	var array = new Array(len);
	var i = 0;
	while (i < len)
	{
		var word = string.charCodeAt(i);
		if (0xD800 <= word && word <= 0xDBFF)
		{
			array[i] = func(_Utils_chr(string[i] + string[i+1]));
			i += 2;
			continue;
		}
		array[i] = func(_Utils_chr(string[i]));
		i++;
	}
	return array.join('');
});

var _String_filter = F2(function(isGood, str)
{
	var arr = [];
	var len = str.length;
	var i = 0;
	while (i < len)
	{
		var char = str[i];
		var word = str.charCodeAt(i);
		i++;
		if (0xD800 <= word && word <= 0xDBFF)
		{
			char += str[i];
			i++;
		}

		if (isGood(_Utils_chr(char)))
		{
			arr.push(char);
		}
	}
	return arr.join('');
});

function _String_reverse(str)
{
	var len = str.length;
	var arr = new Array(len);
	var i = 0;
	while (i < len)
	{
		var word = str.charCodeAt(i);
		if (0xD800 <= word && word <= 0xDBFF)
		{
			arr[len - i] = str[i + 1];
			i++;
			arr[len - i] = str[i - 1];
			i++;
		}
		else
		{
			arr[len - i] = str[i];
			i++;
		}
	}
	return arr.join('');
}

var _String_foldl = F3(function(func, state, string)
{
	var len = string.length;
	var i = 0;
	while (i < len)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		i++;
		if (0xD800 <= word && word <= 0xDBFF)
		{
			char += string[i];
			i++;
		}
		state = A2(func, _Utils_chr(char), state);
	}
	return state;
});

var _String_foldr = F3(function(func, state, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		state = A2(func, _Utils_chr(char), state);
	}
	return state;
});

var _String_split = F2(function(sep, str)
{
	return str.split(sep);
});

var _String_join = F2(function(sep, strs)
{
	return strs.join(sep);
});

var _String_slice = F3(function(start, end, str) {
	return str.slice(start, end);
});

function _String_trim(str)
{
	return str.trim();
}

function _String_trimLeft(str)
{
	return str.replace(/^\s+/, '');
}

function _String_trimRight(str)
{
	return str.replace(/\s+$/, '');
}

function _String_words(str)
{
	return _List_fromArray(str.trim().split(/\s+/g));
}

function _String_lines(str)
{
	return _List_fromArray(str.split(/\r\n|\r|\n/g));
}

function _String_toUpper(str)
{
	return str.toUpperCase();
}

function _String_toLower(str)
{
	return str.toLowerCase();
}

var _String_any = F2(function(isGood, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		if (isGood(_Utils_chr(char)))
		{
			return true;
		}
	}
	return false;
});

var _String_all = F2(function(isGood, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		if (!isGood(_Utils_chr(char)))
		{
			return false;
		}
	}
	return true;
});

var _String_contains = F2(function(sub, str)
{
	return str.indexOf(sub) > -1;
});

var _String_startsWith = F2(function(sub, str)
{
	return str.indexOf(sub) === 0;
});

var _String_endsWith = F2(function(sub, str)
{
	return str.length >= sub.length &&
		str.lastIndexOf(sub) === str.length - sub.length;
});

var _String_indexes = F2(function(sub, str)
{
	var subLen = sub.length;

	if (subLen < 1)
	{
		return _List_Nil;
	}

	var i = 0;
	var is = [];

	while ((i = str.indexOf(sub, i)) > -1)
	{
		is.push(i);
		i = i + subLen;
	}

	return _List_fromArray(is);
});


// TO STRING

function _String_fromNumber(number)
{
	return number + '';
}


// INT CONVERSIONS

function _String_toInt(str)
{
	var total = 0;
	var code0 = str.charCodeAt(0);
	var start = code0 == 0x2B /* + */ || code0 == 0x2D /* - */ ? 1 : 0;

	for (var i = start; i < str.length; ++i)
	{
		var code = str.charCodeAt(i);
		if (code < 0x30 || 0x39 < code)
		{
			return $elm$core$Maybe$Nothing;
		}
		total = 10 * total + code - 0x30;
	}

	return i == start
		? $elm$core$Maybe$Nothing
		: $elm$core$Maybe$Just(code0 == 0x2D ? -total : total);
}


// FLOAT CONVERSIONS

function _String_toFloat(s)
{
	// check if it is a hex, octal, or binary number
	if (s.length === 0 || /[\sxbo]/.test(s))
	{
		return $elm$core$Maybe$Nothing;
	}
	var n = +s;
	// faster isNaN check
	return n === n ? $elm$core$Maybe$Just(n) : $elm$core$Maybe$Nothing;
}

function _String_fromList(chars)
{
	return _List_toArray(chars).join('');
}




function _Char_toCode(char)
{
	var code = char.charCodeAt(0);
	if (0xD800 <= code && code <= 0xDBFF)
	{
		return (code - 0xD800) * 0x400 + char.charCodeAt(1) - 0xDC00 + 0x10000
	}
	return code;
}

function _Char_fromCode(code)
{
	return _Utils_chr(
		(code < 0 || 0x10FFFF < code)
			? '\uFFFD'
			:
		(code <= 0xFFFF)
			? String.fromCharCode(code)
			:
		(code -= 0x10000,
			String.fromCharCode(Math.floor(code / 0x400) + 0xD800, code % 0x400 + 0xDC00)
		)
	);
}

function _Char_toUpper(char)
{
	return _Utils_chr(char.toUpperCase());
}

function _Char_toLower(char)
{
	return _Utils_chr(char.toLowerCase());
}

function _Char_toLocaleUpper(char)
{
	return _Utils_chr(char.toLocaleUpperCase());
}

function _Char_toLocaleLower(char)
{
	return _Utils_chr(char.toLocaleLowerCase());
}



/**/
function _Json_errorToString(error)
{
	return $elm$json$Json$Decode$errorToString(error);
}
//*/


// CORE DECODERS

function _Json_succeed(msg)
{
	return {
		$: 0,
		a: msg
	};
}

function _Json_fail(msg)
{
	return {
		$: 1,
		a: msg
	};
}

function _Json_decodePrim(decoder)
{
	return { $: 2, b: decoder };
}

var _Json_decodeInt = _Json_decodePrim(function(value) {
	return (typeof value !== 'number')
		? _Json_expecting('an INT', value)
		:
	(-2147483647 < value && value < 2147483647 && (value | 0) === value)
		? $elm$core$Result$Ok(value)
		:
	(isFinite(value) && !(value % 1))
		? $elm$core$Result$Ok(value)
		: _Json_expecting('an INT', value);
});

var _Json_decodeBool = _Json_decodePrim(function(value) {
	return (typeof value === 'boolean')
		? $elm$core$Result$Ok(value)
		: _Json_expecting('a BOOL', value);
});

var _Json_decodeFloat = _Json_decodePrim(function(value) {
	return (typeof value === 'number')
		? $elm$core$Result$Ok(value)
		: _Json_expecting('a FLOAT', value);
});

var _Json_decodeValue = _Json_decodePrim(function(value) {
	return $elm$core$Result$Ok(_Json_wrap(value));
});

var _Json_decodeString = _Json_decodePrim(function(value) {
	return (typeof value === 'string')
		? $elm$core$Result$Ok(value)
		: (value instanceof String)
			? $elm$core$Result$Ok(value + '')
			: _Json_expecting('a STRING', value);
});

function _Json_decodeList(decoder) { return { $: 3, b: decoder }; }
function _Json_decodeArray(decoder) { return { $: 4, b: decoder }; }

function _Json_decodeNull(value) { return { $: 5, c: value }; }

var _Json_decodeField = F2(function(field, decoder)
{
	return {
		$: 6,
		d: field,
		b: decoder
	};
});

var _Json_decodeIndex = F2(function(index, decoder)
{
	return {
		$: 7,
		e: index,
		b: decoder
	};
});

function _Json_decodeKeyValuePairs(decoder)
{
	return {
		$: 8,
		b: decoder
	};
}

function _Json_mapMany(f, decoders)
{
	return {
		$: 9,
		f: f,
		g: decoders
	};
}

var _Json_andThen = F2(function(callback, decoder)
{
	return {
		$: 10,
		b: decoder,
		h: callback
	};
});

function _Json_oneOf(decoders)
{
	return {
		$: 11,
		g: decoders
	};
}


// DECODING OBJECTS

var _Json_map1 = F2(function(f, d1)
{
	return _Json_mapMany(f, [d1]);
});

var _Json_map2 = F3(function(f, d1, d2)
{
	return _Json_mapMany(f, [d1, d2]);
});

var _Json_map3 = F4(function(f, d1, d2, d3)
{
	return _Json_mapMany(f, [d1, d2, d3]);
});

var _Json_map4 = F5(function(f, d1, d2, d3, d4)
{
	return _Json_mapMany(f, [d1, d2, d3, d4]);
});

var _Json_map5 = F6(function(f, d1, d2, d3, d4, d5)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5]);
});

var _Json_map6 = F7(function(f, d1, d2, d3, d4, d5, d6)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6]);
});

var _Json_map7 = F8(function(f, d1, d2, d3, d4, d5, d6, d7)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6, d7]);
});

var _Json_map8 = F9(function(f, d1, d2, d3, d4, d5, d6, d7, d8)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6, d7, d8]);
});


// DECODE

var _Json_runOnString = F2(function(decoder, string)
{
	try
	{
		var value = JSON.parse(string);
		return _Json_runHelp(decoder, value);
	}
	catch (e)
	{
		return $elm$core$Result$Err(A2($elm$json$Json$Decode$Failure, 'This is not valid JSON! ' + e.message, _Json_wrap(string)));
	}
});

var _Json_run = F2(function(decoder, value)
{
	return _Json_runHelp(decoder, _Json_unwrap(value));
});

function _Json_runHelp(decoder, value)
{
	switch (decoder.$)
	{
		case 2:
			return decoder.b(value);

		case 5:
			return (value === null)
				? $elm$core$Result$Ok(decoder.c)
				: _Json_expecting('null', value);

		case 3:
			if (!_Json_isArray(value))
			{
				return _Json_expecting('a LIST', value);
			}
			return _Json_runArrayDecoder(decoder.b, value, _List_fromArray);

		case 4:
			if (!_Json_isArray(value))
			{
				return _Json_expecting('an ARRAY', value);
			}
			return _Json_runArrayDecoder(decoder.b, value, _Json_toElmArray);

		case 6:
			var field = decoder.d;
			if (typeof value !== 'object' || value === null || !(field in value))
			{
				return _Json_expecting('an OBJECT with a field named `' + field + '`', value);
			}
			var result = _Json_runHelp(decoder.b, value[field]);
			return ($elm$core$Result$isOk(result)) ? result : $elm$core$Result$Err(A2($elm$json$Json$Decode$Field, field, result.a));

		case 7:
			var index = decoder.e;
			if (!_Json_isArray(value))
			{
				return _Json_expecting('an ARRAY', value);
			}
			if (index >= value.length)
			{
				return _Json_expecting('a LONGER array. Need index ' + index + ' but only see ' + value.length + ' entries', value);
			}
			var result = _Json_runHelp(decoder.b, value[index]);
			return ($elm$core$Result$isOk(result)) ? result : $elm$core$Result$Err(A2($elm$json$Json$Decode$Index, index, result.a));

		case 8:
			if (typeof value !== 'object' || value === null || _Json_isArray(value))
			{
				return _Json_expecting('an OBJECT', value);
			}

			var keyValuePairs = _List_Nil;
			// TODO test perf of Object.keys and switch when support is good enough
			for (var key in value)
			{
				if (Object.prototype.hasOwnProperty.call(value, key))
				{
					var result = _Json_runHelp(decoder.b, value[key]);
					if (!$elm$core$Result$isOk(result))
					{
						return $elm$core$Result$Err(A2($elm$json$Json$Decode$Field, key, result.a));
					}
					keyValuePairs = _List_Cons(_Utils_Tuple2(key, result.a), keyValuePairs);
				}
			}
			return $elm$core$Result$Ok($elm$core$List$reverse(keyValuePairs));

		case 9:
			var answer = decoder.f;
			var decoders = decoder.g;
			for (var i = 0; i < decoders.length; i++)
			{
				var result = _Json_runHelp(decoders[i], value);
				if (!$elm$core$Result$isOk(result))
				{
					return result;
				}
				answer = answer(result.a);
			}
			return $elm$core$Result$Ok(answer);

		case 10:
			var result = _Json_runHelp(decoder.b, value);
			return (!$elm$core$Result$isOk(result))
				? result
				: _Json_runHelp(decoder.h(result.a), value);

		case 11:
			var errors = _List_Nil;
			for (var temp = decoder.g; temp.b; temp = temp.b) // WHILE_CONS
			{
				var result = _Json_runHelp(temp.a, value);
				if ($elm$core$Result$isOk(result))
				{
					return result;
				}
				errors = _List_Cons(result.a, errors);
			}
			return $elm$core$Result$Err($elm$json$Json$Decode$OneOf($elm$core$List$reverse(errors)));

		case 1:
			return $elm$core$Result$Err(A2($elm$json$Json$Decode$Failure, decoder.a, _Json_wrap(value)));

		case 0:
			return $elm$core$Result$Ok(decoder.a);
	}
}

function _Json_runArrayDecoder(decoder, value, toElmValue)
{
	var len = value.length;
	var array = new Array(len);
	for (var i = 0; i < len; i++)
	{
		var result = _Json_runHelp(decoder, value[i]);
		if (!$elm$core$Result$isOk(result))
		{
			return $elm$core$Result$Err(A2($elm$json$Json$Decode$Index, i, result.a));
		}
		array[i] = result.a;
	}
	return $elm$core$Result$Ok(toElmValue(array));
}

function _Json_isArray(value)
{
	return Array.isArray(value) || (typeof FileList !== 'undefined' && value instanceof FileList);
}

function _Json_toElmArray(array)
{
	return A2($elm$core$Array$initialize, array.length, function(i) { return array[i]; });
}

function _Json_expecting(type, value)
{
	return $elm$core$Result$Err(A2($elm$json$Json$Decode$Failure, 'Expecting ' + type, _Json_wrap(value)));
}


// EQUALITY

function _Json_equality(x, y)
{
	if (x === y)
	{
		return true;
	}

	if (x.$ !== y.$)
	{
		return false;
	}

	switch (x.$)
	{
		case 0:
		case 1:
			return x.a === y.a;

		case 2:
			return x.b === y.b;

		case 5:
			return x.c === y.c;

		case 3:
		case 4:
		case 8:
			return _Json_equality(x.b, y.b);

		case 6:
			return x.d === y.d && _Json_equality(x.b, y.b);

		case 7:
			return x.e === y.e && _Json_equality(x.b, y.b);

		case 9:
			return x.f === y.f && _Json_listEquality(x.g, y.g);

		case 10:
			return x.h === y.h && _Json_equality(x.b, y.b);

		case 11:
			return _Json_listEquality(x.g, y.g);
	}
}

function _Json_listEquality(aDecoders, bDecoders)
{
	var len = aDecoders.length;
	if (len !== bDecoders.length)
	{
		return false;
	}
	for (var i = 0; i < len; i++)
	{
		if (!_Json_equality(aDecoders[i], bDecoders[i]))
		{
			return false;
		}
	}
	return true;
}


// ENCODE

var _Json_encode = F2(function(indentLevel, value)
{
	return JSON.stringify(_Json_unwrap(value), null, indentLevel) + '';
});

function _Json_wrap(value) { return { $: 0, a: value }; }
function _Json_unwrap(value) { return value.a; }

function _Json_wrap_UNUSED(value) { return value; }
function _Json_unwrap_UNUSED(value) { return value; }

function _Json_emptyArray() { return []; }
function _Json_emptyObject() { return {}; }

var _Json_addField = F3(function(key, value, object)
{
	var unwrapped = _Json_unwrap(value);
	if (!(key === 'toJSON' && typeof unwrapped === 'function'))
	{
		object[key] = unwrapped;
	}
	return object;
});

function _Json_addEntry(func)
{
	return F2(function(entry, array)
	{
		array.push(_Json_unwrap(func(entry)));
		return array;
	});
}

var _Json_encodeNull = _Json_wrap(null);



// TASKS

function _Scheduler_succeed(value)
{
	return {
		$: 0,
		a: value
	};
}

function _Scheduler_fail(error)
{
	return {
		$: 1,
		a: error
	};
}

function _Scheduler_binding(callback)
{
	return {
		$: 2,
		b: callback,
		c: null
	};
}

var _Scheduler_andThen = F2(function(callback, task)
{
	return {
		$: 3,
		b: callback,
		d: task
	};
});

var _Scheduler_onError = F2(function(callback, task)
{
	return {
		$: 4,
		b: callback,
		d: task
	};
});

function _Scheduler_receive(callback)
{
	return {
		$: 5,
		b: callback
	};
}


// PROCESSES

var _Scheduler_guid = 0;

function _Scheduler_rawSpawn(task)
{
	var proc = {
		$: 0,
		e: _Scheduler_guid++,
		f: task,
		g: null,
		h: []
	};

	_Scheduler_enqueue(proc);

	return proc;
}

function _Scheduler_spawn(task)
{
	return _Scheduler_binding(function(callback) {
		callback(_Scheduler_succeed(_Scheduler_rawSpawn(task)));
	});
}

function _Scheduler_rawSend(proc, msg)
{
	proc.h.push(msg);
	_Scheduler_enqueue(proc);
}

var _Scheduler_send = F2(function(proc, msg)
{
	return _Scheduler_binding(function(callback) {
		_Scheduler_rawSend(proc, msg);
		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
});

function _Scheduler_kill(proc)
{
	return _Scheduler_binding(function(callback) {
		var task = proc.f;
		if (task.$ === 2 && task.c)
		{
			task.c();
		}

		proc.f = null;

		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
}


/* STEP PROCESSES

type alias Process =
  { $ : tag
  , id : unique_id
  , root : Task
  , stack : null | { $: SUCCEED | FAIL, a: callback, b: stack }
  , mailbox : [msg]
  }

*/


var _Scheduler_working = false;
var _Scheduler_queue = [];


function _Scheduler_enqueue(proc)
{
	_Scheduler_queue.push(proc);
	if (_Scheduler_working)
	{
		return;
	}
	_Scheduler_working = true;
	while (proc = _Scheduler_queue.shift())
	{
		_Scheduler_step(proc);
	}
	_Scheduler_working = false;
}


function _Scheduler_step(proc)
{
	while (proc.f)
	{
		var rootTag = proc.f.$;
		if (rootTag === 0 || rootTag === 1)
		{
			while (proc.g && proc.g.$ !== rootTag)
			{
				proc.g = proc.g.i;
			}
			if (!proc.g)
			{
				return;
			}
			proc.f = proc.g.b(proc.f.a);
			proc.g = proc.g.i;
		}
		else if (rootTag === 2)
		{
			proc.f.c = proc.f.b(function(newRoot) {
				proc.f = newRoot;
				_Scheduler_enqueue(proc);
			});
			return;
		}
		else if (rootTag === 5)
		{
			if (proc.h.length === 0)
			{
				return;
			}
			proc.f = proc.f.b(proc.h.shift());
		}
		else // if (rootTag === 3 || rootTag === 4)
		{
			proc.g = {
				$: rootTag === 3 ? 0 : 1,
				b: proc.f.b,
				i: proc.g
			};
			proc.f = proc.f.d;
		}
	}
}



function _Process_sleep(time)
{
	return _Scheduler_binding(function(callback) {
		var id = setTimeout(function() {
			callback(_Scheduler_succeed(_Utils_Tuple0));
		}, time);

		return function() { clearTimeout(id); };
	});
}




// PROGRAMS


var _Platform_worker = F4(function(impl, flagDecoder, debugMetadata, args)
{
	return _Platform_initialize(
		flagDecoder,
		args,
		impl.init,
		impl.update,
		impl.subscriptions,
		function() { return function() {} }
	);
});



// INITIALIZE A PROGRAM


function _Platform_initialize(flagDecoder, args, init, update, subscriptions, stepperBuilder)
{
	var result = A2(_Json_run, flagDecoder, _Json_wrap(args ? args['flags'] : undefined));
	$elm$core$Result$isOk(result) || _Debug_crash(2 /**/, _Json_errorToString(result.a) /**/);
	var managers = {};
	var initPair = init(result.a);
	var model = initPair.a;
	var stepper = stepperBuilder(sendToApp, model);
	var ports = _Platform_setupEffects(managers, sendToApp);

	function sendToApp(msg, viewMetadata)
	{
		var pair = A2(update, msg, model);
		stepper(model = pair.a, viewMetadata);
		_Platform_enqueueEffects(managers, pair.b, subscriptions(model));
	}

	_Platform_enqueueEffects(managers, initPair.b, subscriptions(model));

	return ports ? { ports: ports } : {};
}



// TRACK PRELOADS
//
// This is used by code in elm/browser and elm/http
// to register any HTTP requests that are triggered by init.
//


var _Platform_preload;


function _Platform_registerPreload(url)
{
	_Platform_preload.add(url);
}



// EFFECT MANAGERS


var _Platform_effectManagers = {};


function _Platform_setupEffects(managers, sendToApp)
{
	var ports;

	// setup all necessary effect managers
	for (var key in _Platform_effectManagers)
	{
		var manager = _Platform_effectManagers[key];

		if (manager.a)
		{
			ports = ports || {};
			ports[key] = manager.a(key, sendToApp);
		}

		managers[key] = _Platform_instantiateManager(manager, sendToApp);
	}

	return ports;
}


function _Platform_createManager(init, onEffects, onSelfMsg, cmdMap, subMap)
{
	return {
		b: init,
		c: onEffects,
		d: onSelfMsg,
		e: cmdMap,
		f: subMap
	};
}


function _Platform_instantiateManager(info, sendToApp)
{
	var router = {
		g: sendToApp,
		h: undefined
	};

	var onEffects = info.c;
	var onSelfMsg = info.d;
	var cmdMap = info.e;
	var subMap = info.f;

	function loop(state)
	{
		return A2(_Scheduler_andThen, loop, _Scheduler_receive(function(msg)
		{
			var value = msg.a;

			if (msg.$ === 0)
			{
				return A3(onSelfMsg, router, value, state);
			}

			return cmdMap && subMap
				? A4(onEffects, router, value.i, value.j, state)
				: A3(onEffects, router, cmdMap ? value.i : value.j, state);
		}));
	}

	return router.h = _Scheduler_rawSpawn(A2(_Scheduler_andThen, loop, info.b));
}



// ROUTING


var _Platform_sendToApp = F2(function(router, msg)
{
	return _Scheduler_binding(function(callback)
	{
		router.g(msg);
		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
});


var _Platform_sendToSelf = F2(function(router, msg)
{
	return A2(_Scheduler_send, router.h, {
		$: 0,
		a: msg
	});
});



// BAGS


function _Platform_leaf(home)
{
	return function(value)
	{
		return {
			$: 1,
			k: home,
			l: value
		};
	};
}


function _Platform_batch(list)
{
	return {
		$: 2,
		m: list
	};
}


var _Platform_map = F2(function(tagger, bag)
{
	return {
		$: 3,
		n: tagger,
		o: bag
	}
});



// PIPE BAGS INTO EFFECT MANAGERS
//
// Effects must be queued!
//
// Say your init contains a synchronous command, like Time.now or Time.here
//
//   - This will produce a batch of effects (FX_1)
//   - The synchronous task triggers the subsequent `update` call
//   - This will produce a batch of effects (FX_2)
//
// If we just start dispatching FX_2, subscriptions from FX_2 can be processed
// before subscriptions from FX_1. No good! Earlier versions of this code had
// this problem, leading to these reports:
//
//   https://github.com/elm/core/issues/980
//   https://github.com/elm/core/pull/981
//   https://github.com/elm/compiler/issues/1776
//
// The queue is necessary to avoid ordering issues for synchronous commands.


// Why use true/false here? Why not just check the length of the queue?
// The goal is to detect "are we currently dispatching effects?" If we
// are, we need to bail and let the ongoing while loop handle things.
//
// Now say the queue has 1 element. When we dequeue the final element,
// the queue will be empty, but we are still actively dispatching effects.
// So you could get queue jumping in a really tricky category of cases.
//
var _Platform_effectsQueue = [];
var _Platform_effectsActive = false;


function _Platform_enqueueEffects(managers, cmdBag, subBag)
{
	_Platform_effectsQueue.push({ p: managers, q: cmdBag, r: subBag });

	if (_Platform_effectsActive) return;

	_Platform_effectsActive = true;
	for (var fx; fx = _Platform_effectsQueue.shift(); )
	{
		_Platform_dispatchEffects(fx.p, fx.q, fx.r);
	}
	_Platform_effectsActive = false;
}


function _Platform_dispatchEffects(managers, cmdBag, subBag)
{
	var effectsDict = {};
	_Platform_gatherEffects(true, cmdBag, effectsDict, null);
	_Platform_gatherEffects(false, subBag, effectsDict, null);

	for (var home in managers)
	{
		_Scheduler_rawSend(managers[home], {
			$: 'fx',
			a: effectsDict[home] || { i: _List_Nil, j: _List_Nil }
		});
	}
}


function _Platform_gatherEffects(isCmd, bag, effectsDict, taggers)
{
	switch (bag.$)
	{
		case 1:
			var home = bag.k;
			var effect = _Platform_toEffect(isCmd, home, taggers, bag.l);
			effectsDict[home] = _Platform_insert(isCmd, effect, effectsDict[home]);
			return;

		case 2:
			for (var list = bag.m; list.b; list = list.b) // WHILE_CONS
			{
				_Platform_gatherEffects(isCmd, list.a, effectsDict, taggers);
			}
			return;

		case 3:
			_Platform_gatherEffects(isCmd, bag.o, effectsDict, {
				s: bag.n,
				t: taggers
			});
			return;
	}
}


function _Platform_toEffect(isCmd, home, taggers, value)
{
	function applyTaggers(x)
	{
		for (var temp = taggers; temp; temp = temp.t)
		{
			x = temp.s(x);
		}
		return x;
	}

	var map = isCmd
		? _Platform_effectManagers[home].e
		: _Platform_effectManagers[home].f;

	return A2(map, applyTaggers, value)
}


function _Platform_insert(isCmd, newEffect, effects)
{
	effects = effects || { i: _List_Nil, j: _List_Nil };

	isCmd
		? (effects.i = _List_Cons(newEffect, effects.i))
		: (effects.j = _List_Cons(newEffect, effects.j));

	return effects;
}



// PORTS


function _Platform_checkPortName(name)
{
	if (_Platform_effectManagers[name])
	{
		_Debug_crash(3, name)
	}
}



// OUTGOING PORTS


function _Platform_outgoingPort(name, converter)
{
	_Platform_checkPortName(name);
	_Platform_effectManagers[name] = {
		e: _Platform_outgoingPortMap,
		u: converter,
		a: _Platform_setupOutgoingPort
	};
	return _Platform_leaf(name);
}


var _Platform_outgoingPortMap = F2(function(tagger, value) { return value; });


function _Platform_setupOutgoingPort(name)
{
	var subs = [];
	var converter = _Platform_effectManagers[name].u;

	// CREATE MANAGER

	var init = _Process_sleep(0);

	_Platform_effectManagers[name].b = init;
	_Platform_effectManagers[name].c = F3(function(router, cmdList, state)
	{
		for ( ; cmdList.b; cmdList = cmdList.b) // WHILE_CONS
		{
			// grab a separate reference to subs in case unsubscribe is called
			var currentSubs = subs;
			var value = _Json_unwrap(converter(cmdList.a));
			for (var i = 0; i < currentSubs.length; i++)
			{
				currentSubs[i](value);
			}
		}
		return init;
	});

	// PUBLIC API

	function subscribe(callback)
	{
		subs.push(callback);
	}

	function unsubscribe(callback)
	{
		// copy subs into a new array in case unsubscribe is called within a
		// subscribed callback
		subs = subs.slice();
		var index = subs.indexOf(callback);
		if (index >= 0)
		{
			subs.splice(index, 1);
		}
	}

	return {
		subscribe: subscribe,
		unsubscribe: unsubscribe
	};
}



// INCOMING PORTS


function _Platform_incomingPort(name, converter)
{
	_Platform_checkPortName(name);
	_Platform_effectManagers[name] = {
		f: _Platform_incomingPortMap,
		u: converter,
		a: _Platform_setupIncomingPort
	};
	return _Platform_leaf(name);
}


var _Platform_incomingPortMap = F2(function(tagger, finalTagger)
{
	return function(value)
	{
		return tagger(finalTagger(value));
	};
});


function _Platform_setupIncomingPort(name, sendToApp)
{
	var subs = _List_Nil;
	var converter = _Platform_effectManagers[name].u;

	// CREATE MANAGER

	var init = _Scheduler_succeed(null);

	_Platform_effectManagers[name].b = init;
	_Platform_effectManagers[name].c = F3(function(router, subList, state)
	{
		subs = subList;
		return init;
	});

	// PUBLIC API

	function send(incomingValue)
	{
		var result = A2(_Json_run, converter, _Json_wrap(incomingValue));

		$elm$core$Result$isOk(result) || _Debug_crash(4, name, result.a);

		var value = result.a;
		for (var temp = subs; temp.b; temp = temp.b) // WHILE_CONS
		{
			sendToApp(temp.a(value));
		}
	}

	return { send: send };
}



// EXPORT ELM MODULES
//
// Have DEBUG and PROD versions so that we can (1) give nicer errors in
// debug mode and (2) not pay for the bits needed for that in prod mode.
//


function _Platform_export_UNUSED(exports)
{
	scope['Elm']
		? _Platform_mergeExportsProd(scope['Elm'], exports)
		: scope['Elm'] = exports;
}


function _Platform_mergeExportsProd(obj, exports)
{
	for (var name in exports)
	{
		(name in obj)
			? (name == 'init')
				? _Debug_crash(6)
				: _Platform_mergeExportsProd(obj[name], exports[name])
			: (obj[name] = exports[name]);
	}
}


function _Platform_export(exports)
{
	scope['Elm']
		? _Platform_mergeExportsDebug('Elm', scope['Elm'], exports)
		: scope['Elm'] = exports;
}


function _Platform_mergeExportsDebug(moduleName, obj, exports)
{
	for (var name in exports)
	{
		(name in obj)
			? (name == 'init')
				? _Debug_crash(6, moduleName)
				: _Platform_mergeExportsDebug(moduleName + '.' + name, obj[name], exports[name])
			: (obj[name] = exports[name]);
	}
}




// HELPERS


var _VirtualDom_divertHrefToApp;

var _VirtualDom_doc = typeof document !== 'undefined' ? document : {};


function _VirtualDom_appendChild(parent, child)
{
	parent.appendChild(child);
}

var _VirtualDom_init = F4(function(virtualNode, flagDecoder, debugMetadata, args)
{
	// NOTE: this function needs _Platform_export available to work

	/**_UNUSED/
	var node = args['node'];
	//*/
	/**/
	var node = args && args['node'] ? args['node'] : _Debug_crash(0);
	//*/

	node.parentNode.replaceChild(
		_VirtualDom_render(virtualNode, function() {}),
		node
	);

	return {};
});



// TEXT


function _VirtualDom_text(string)
{
	return {
		$: 0,
		a: string
	};
}



// NODE


var _VirtualDom_nodeNS = F2(function(namespace, tag)
{
	return F2(function(factList, kidList)
	{
		for (var kids = [], descendantsCount = 0; kidList.b; kidList = kidList.b) // WHILE_CONS
		{
			var kid = kidList.a;
			descendantsCount += (kid.b || 0);
			kids.push(kid);
		}
		descendantsCount += kids.length;

		return {
			$: 1,
			c: tag,
			d: _VirtualDom_organizeFacts(factList),
			e: kids,
			f: namespace,
			b: descendantsCount
		};
	});
});


var _VirtualDom_node = _VirtualDom_nodeNS(undefined);



// KEYED NODE


var _VirtualDom_keyedNodeNS = F2(function(namespace, tag)
{
	return F2(function(factList, kidList)
	{
		for (var kids = [], descendantsCount = 0; kidList.b; kidList = kidList.b) // WHILE_CONS
		{
			var kid = kidList.a;
			descendantsCount += (kid.b.b || 0);
			kids.push(kid);
		}
		descendantsCount += kids.length;

		return {
			$: 2,
			c: tag,
			d: _VirtualDom_organizeFacts(factList),
			e: kids,
			f: namespace,
			b: descendantsCount
		};
	});
});


var _VirtualDom_keyedNode = _VirtualDom_keyedNodeNS(undefined);



// CUSTOM


function _VirtualDom_custom(factList, model, render, diff)
{
	return {
		$: 3,
		d: _VirtualDom_organizeFacts(factList),
		g: model,
		h: render,
		i: diff
	};
}



// MAP


var _VirtualDom_map = F2(function(tagger, node)
{
	return {
		$: 4,
		j: tagger,
		k: node,
		b: 1 + (node.b || 0)
	};
});



// LAZY


function _VirtualDom_thunk(refs, thunk)
{
	return {
		$: 5,
		l: refs,
		m: thunk,
		k: undefined
	};
}

var _VirtualDom_lazy = F2(function(func, a)
{
	return _VirtualDom_thunk([func, a], function() {
		return func(a);
	});
});

var _VirtualDom_lazy2 = F3(function(func, a, b)
{
	return _VirtualDom_thunk([func, a, b], function() {
		return A2(func, a, b);
	});
});

var _VirtualDom_lazy3 = F4(function(func, a, b, c)
{
	return _VirtualDom_thunk([func, a, b, c], function() {
		return A3(func, a, b, c);
	});
});

var _VirtualDom_lazy4 = F5(function(func, a, b, c, d)
{
	return _VirtualDom_thunk([func, a, b, c, d], function() {
		return A4(func, a, b, c, d);
	});
});

var _VirtualDom_lazy5 = F6(function(func, a, b, c, d, e)
{
	return _VirtualDom_thunk([func, a, b, c, d, e], function() {
		return A5(func, a, b, c, d, e);
	});
});

var _VirtualDom_lazy6 = F7(function(func, a, b, c, d, e, f)
{
	return _VirtualDom_thunk([func, a, b, c, d, e, f], function() {
		return A6(func, a, b, c, d, e, f);
	});
});

var _VirtualDom_lazy7 = F8(function(func, a, b, c, d, e, f, g)
{
	return _VirtualDom_thunk([func, a, b, c, d, e, f, g], function() {
		return A7(func, a, b, c, d, e, f, g);
	});
});

var _VirtualDom_lazy8 = F9(function(func, a, b, c, d, e, f, g, h)
{
	return _VirtualDom_thunk([func, a, b, c, d, e, f, g, h], function() {
		return A8(func, a, b, c, d, e, f, g, h);
	});
});



// FACTS


var _VirtualDom_on = F2(function(key, handler)
{
	return {
		$: 'a0',
		n: key,
		o: handler
	};
});
var _VirtualDom_style = F2(function(key, value)
{
	return {
		$: 'a1',
		n: key,
		o: value
	};
});
var _VirtualDom_property = F2(function(key, value)
{
	return {
		$: 'a2',
		n: key,
		o: value
	};
});
var _VirtualDom_attribute = F2(function(key, value)
{
	return {
		$: 'a3',
		n: key,
		o: value
	};
});
var _VirtualDom_attributeNS = F3(function(namespace, key, value)
{
	return {
		$: 'a4',
		n: key,
		o: { f: namespace, o: value }
	};
});



// XSS ATTACK VECTOR CHECKS
//
// For some reason, tabs can appear in href protocols and it still works.
// So '\tjava\tSCRIPT:alert("!!!")' and 'javascript:alert("!!!")' are the same
// in practice. That is why _VirtualDom_RE_js and _VirtualDom_RE_js_html look
// so freaky.
//
// Pulling the regular expressions out to the top level gives a slight speed
// boost in small benchmarks (4-10%) but hoisting values to reduce allocation
// can be unpredictable in large programs where JIT may have a harder time with
// functions are not fully self-contained. The benefit is more that the js and
// js_html ones are so weird that I prefer to see them near each other.


var _VirtualDom_RE_script = /^script$/i;
var _VirtualDom_RE_on_formAction = /^(on|formAction$)/i;
var _VirtualDom_RE_js = /^\s*j\s*a\s*v\s*a\s*s\s*c\s*r\s*i\s*p\s*t\s*:/i;
var _VirtualDom_RE_js_html = /^\s*(j\s*a\s*v\s*a\s*s\s*c\s*r\s*i\s*p\s*t\s*:|d\s*a\s*t\s*a\s*:\s*t\s*e\s*x\s*t\s*\/\s*h\s*t\s*m\s*l\s*(,|;))/i;


function _VirtualDom_noScript(tag)
{
	return _VirtualDom_RE_script.test(tag) ? 'p' : tag;
}

function _VirtualDom_noOnOrFormAction(key)
{
	return _VirtualDom_RE_on_formAction.test(key) ? 'data-' + key : key;
}

function _VirtualDom_noInnerHtmlOrFormAction(key)
{
	return key == 'innerHTML' || key == 'outerHTML' || key == 'formAction' ? 'data-' + key : key;
}

function _VirtualDom_noJavaScriptUri(value)
{
	return _VirtualDom_RE_js.test(value)
		? /**_UNUSED/''//*//**/'javascript:alert("This is an XSS vector. Please use ports or web components instead.")'//*/
		: value;
}

function _VirtualDom_noJavaScriptOrHtmlUri(value)
{
	return _VirtualDom_RE_js_html.test(value)
		? /**_UNUSED/''//*//**/'javascript:alert("This is an XSS vector. Please use ports or web components instead.")'//*/
		: value;
}

function _VirtualDom_noJavaScriptOrHtmlJson(value)
{
	return (
		(typeof _Json_unwrap(value) === 'string' && _VirtualDom_RE_js_html.test(_Json_unwrap(value)))
		||
		(Array.isArray(_Json_unwrap(value)) && _VirtualDom_RE_js_html.test(String(_Json_unwrap(value))))
	)
		? _Json_wrap(
			/**_UNUSED/''//*//**/'javascript:alert("This is an XSS vector. Please use ports or web components instead.")'//*/
		) : value;
}



// MAP FACTS


var _VirtualDom_mapAttribute = F2(function(func, attr)
{
	return (attr.$ === 'a0')
		? A2(_VirtualDom_on, attr.n, _VirtualDom_mapHandler(func, attr.o))
		: attr;
});

function _VirtualDom_mapHandler(func, handler)
{
	var tag = $elm$virtual_dom$VirtualDom$toHandlerInt(handler);

	// 0 = Normal
	// 1 = MayStopPropagation
	// 2 = MayPreventDefault
	// 3 = Custom

	return {
		$: handler.$,
		a:
			!tag
				? A2($elm$json$Json$Decode$map, func, handler.a)
				:
			A3($elm$json$Json$Decode$map2,
				tag < 3
					? _VirtualDom_mapEventTuple
					: _VirtualDom_mapEventRecord,
				$elm$json$Json$Decode$succeed(func),
				handler.a
			)
	};
}

var _VirtualDom_mapEventTuple = F2(function(func, tuple)
{
	return _Utils_Tuple2(func(tuple.a), tuple.b);
});

var _VirtualDom_mapEventRecord = F2(function(func, record)
{
	return {
		message: func(record.message),
		stopPropagation: record.stopPropagation,
		preventDefault: record.preventDefault
	}
});



// ORGANIZE FACTS


function _VirtualDom_organizeFacts(factList)
{
	for (var facts = {}; factList.b; factList = factList.b) // WHILE_CONS
	{
		var entry = factList.a;

		var tag = entry.$;
		var key = entry.n;
		var value = entry.o;

		if (tag === 'a2')
		{
			(key === 'className')
				? _VirtualDom_addClass(facts, key, _Json_unwrap(value))
				: facts[key] = _Json_unwrap(value);

			continue;
		}

		var subFacts = facts[tag] || (facts[tag] = {});
		(tag === 'a3' && key === 'class')
			? _VirtualDom_addClass(subFacts, key, value)
			: subFacts[key] = value;
	}

	return facts;
}

function _VirtualDom_addClass(object, key, newClass)
{
	var classes = object[key];
	object[key] = classes ? classes + ' ' + newClass : newClass;
}



// RENDER


function _VirtualDom_render(vNode, eventNode)
{
	var tag = vNode.$;

	if (tag === 5)
	{
		return _VirtualDom_render(vNode.k || (vNode.k = vNode.m()), eventNode);
	}

	if (tag === 0)
	{
		return _VirtualDom_doc.createTextNode(vNode.a);
	}

	if (tag === 4)
	{
		var subNode = vNode.k;
		var tagger = vNode.j;

		while (subNode.$ === 4)
		{
			typeof tagger !== 'object'
				? tagger = [tagger, subNode.j]
				: tagger.push(subNode.j);

			subNode = subNode.k;
		}

		var subEventRoot = { j: tagger, p: eventNode };
		var domNode = _VirtualDom_render(subNode, subEventRoot);
		domNode.elm_event_node_ref = subEventRoot;
		return domNode;
	}

	if (tag === 3)
	{
		var domNode = vNode.h(vNode.g);
		_VirtualDom_applyFacts(domNode, eventNode, vNode.d);
		return domNode;
	}

	// at this point `tag` must be 1 or 2

	var domNode = vNode.f
		? _VirtualDom_doc.createElementNS(vNode.f, vNode.c)
		: _VirtualDom_doc.createElement(vNode.c);

	if (_VirtualDom_divertHrefToApp && vNode.c == 'a')
	{
		domNode.addEventListener('click', _VirtualDom_divertHrefToApp(domNode));
	}

	_VirtualDom_applyFacts(domNode, eventNode, vNode.d);

	for (var kids = vNode.e, i = 0; i < kids.length; i++)
	{
		_VirtualDom_appendChild(domNode, _VirtualDom_render(tag === 1 ? kids[i] : kids[i].b, eventNode));
	}

	return domNode;
}



// APPLY FACTS


function _VirtualDom_applyFacts(domNode, eventNode, facts)
{
	for (var key in facts)
	{
		var value = facts[key];

		key === 'a1'
			? _VirtualDom_applyStyles(domNode, value)
			:
		key === 'a0'
			? _VirtualDom_applyEvents(domNode, eventNode, value)
			:
		key === 'a3'
			? _VirtualDom_applyAttrs(domNode, value)
			:
		key === 'a4'
			? _VirtualDom_applyAttrsNS(domNode, value)
			:
		((key !== 'value' && key !== 'checked') || domNode[key] !== value) && (domNode[key] = value);
	}
}



// APPLY STYLES


function _VirtualDom_applyStyles(domNode, styles)
{
	var domNodeStyle = domNode.style;

	for (var key in styles)
	{
		domNodeStyle[key] = styles[key];
	}
}



// APPLY ATTRS


function _VirtualDom_applyAttrs(domNode, attrs)
{
	for (var key in attrs)
	{
		var value = attrs[key];
		typeof value !== 'undefined'
			? domNode.setAttribute(key, value)
			: domNode.removeAttribute(key);
	}
}



// APPLY NAMESPACED ATTRS


function _VirtualDom_applyAttrsNS(domNode, nsAttrs)
{
	for (var key in nsAttrs)
	{
		var pair = nsAttrs[key];
		var namespace = pair.f;
		var value = pair.o;

		typeof value !== 'undefined'
			? domNode.setAttributeNS(namespace, key, value)
			: domNode.removeAttributeNS(namespace, key);
	}
}



// APPLY EVENTS


function _VirtualDom_applyEvents(domNode, eventNode, events)
{
	var allCallbacks = domNode.elmFs || (domNode.elmFs = {});

	for (var key in events)
	{
		var newHandler = events[key];
		var oldCallback = allCallbacks[key];

		if (!newHandler)
		{
			domNode.removeEventListener(key, oldCallback);
			allCallbacks[key] = undefined;
			continue;
		}

		if (oldCallback)
		{
			var oldHandler = oldCallback.q;
			if (oldHandler.$ === newHandler.$)
			{
				oldCallback.q = newHandler;
				continue;
			}
			domNode.removeEventListener(key, oldCallback);
		}

		oldCallback = _VirtualDom_makeCallback(eventNode, newHandler);
		domNode.addEventListener(key, oldCallback,
			_VirtualDom_passiveSupported
			&& { passive: $elm$virtual_dom$VirtualDom$toHandlerInt(newHandler) < 2 }
		);
		allCallbacks[key] = oldCallback;
	}
}



// PASSIVE EVENTS


var _VirtualDom_passiveSupported;

try
{
	window.addEventListener('t', null, Object.defineProperty({}, 'passive', {
		get: function() { _VirtualDom_passiveSupported = true; }
	}));
}
catch(e) {}



// EVENT HANDLERS


function _VirtualDom_makeCallback(eventNode, initialHandler)
{
	function callback(event)
	{
		var handler = callback.q;
		var result = _Json_runHelp(handler.a, event);

		if (!$elm$core$Result$isOk(result))
		{
			return;
		}

		var tag = $elm$virtual_dom$VirtualDom$toHandlerInt(handler);

		// 0 = Normal
		// 1 = MayStopPropagation
		// 2 = MayPreventDefault
		// 3 = Custom

		var value = result.a;
		var message = !tag ? value : tag < 3 ? value.a : value.message;
		var stopPropagation = tag == 1 ? value.b : tag == 3 && value.stopPropagation;
		var currentEventNode = (
			stopPropagation && event.stopPropagation(),
			(tag == 2 ? value.b : tag == 3 && value.preventDefault) && event.preventDefault(),
			eventNode
		);
		var tagger;
		var i;
		while (tagger = currentEventNode.j)
		{
			if (typeof tagger == 'function')
			{
				message = tagger(message);
			}
			else
			{
				for (var i = tagger.length; i--; )
				{
					message = tagger[i](message);
				}
			}
			currentEventNode = currentEventNode.p;
		}
		currentEventNode(message, stopPropagation); // stopPropagation implies isSync
	}

	callback.q = initialHandler;

	return callback;
}

function _VirtualDom_equalEvents(x, y)
{
	return x.$ == y.$ && _Json_equality(x.a, y.a);
}



// DIFF


// TODO: Should we do patches like in iOS?
//
// type Patch
//   = At Int Patch
//   | Batch (List Patch)
//   | Change ...
//
// How could it not be better?
//
function _VirtualDom_diff(x, y)
{
	var patches = [];
	_VirtualDom_diffHelp(x, y, patches, 0);
	return patches;
}


function _VirtualDom_pushPatch(patches, type, index, data)
{
	var patch = {
		$: type,
		r: index,
		s: data,
		t: undefined,
		u: undefined
	};
	patches.push(patch);
	return patch;
}


function _VirtualDom_diffHelp(x, y, patches, index)
{
	if (x === y)
	{
		return;
	}

	var xType = x.$;
	var yType = y.$;

	// Bail if you run into different types of nodes. Implies that the
	// structure has changed significantly and it's not worth a diff.
	if (xType !== yType)
	{
		if (xType === 1 && yType === 2)
		{
			y = _VirtualDom_dekey(y);
			yType = 1;
		}
		else
		{
			_VirtualDom_pushPatch(patches, 0, index, y);
			return;
		}
	}

	// Now we know that both nodes are the same $.
	switch (yType)
	{
		case 5:
			var xRefs = x.l;
			var yRefs = y.l;
			var i = xRefs.length;
			var same = i === yRefs.length;
			while (same && i--)
			{
				same = xRefs[i] === yRefs[i];
			}
			if (same)
			{
				y.k = x.k;
				return;
			}
			y.k = y.m();
			var subPatches = [];
			_VirtualDom_diffHelp(x.k, y.k, subPatches, 0);
			subPatches.length > 0 && _VirtualDom_pushPatch(patches, 1, index, subPatches);
			return;

		case 4:
			// gather nested taggers
			var xTaggers = x.j;
			var yTaggers = y.j;
			var nesting = false;

			var xSubNode = x.k;
			while (xSubNode.$ === 4)
			{
				nesting = true;

				typeof xTaggers !== 'object'
					? xTaggers = [xTaggers, xSubNode.j]
					: xTaggers.push(xSubNode.j);

				xSubNode = xSubNode.k;
			}

			var ySubNode = y.k;
			while (ySubNode.$ === 4)
			{
				nesting = true;

				typeof yTaggers !== 'object'
					? yTaggers = [yTaggers, ySubNode.j]
					: yTaggers.push(ySubNode.j);

				ySubNode = ySubNode.k;
			}

			// Just bail if different numbers of taggers. This implies the
			// structure of the virtual DOM has changed.
			if (nesting && xTaggers.length !== yTaggers.length)
			{
				_VirtualDom_pushPatch(patches, 0, index, y);
				return;
			}

			// check if taggers are "the same"
			if (nesting ? !_VirtualDom_pairwiseRefEqual(xTaggers, yTaggers) : xTaggers !== yTaggers)
			{
				_VirtualDom_pushPatch(patches, 2, index, yTaggers);
			}

			// diff everything below the taggers
			_VirtualDom_diffHelp(xSubNode, ySubNode, patches, index + 1);
			return;

		case 0:
			if (x.a !== y.a)
			{
				_VirtualDom_pushPatch(patches, 3, index, y.a);
			}
			return;

		case 1:
			_VirtualDom_diffNodes(x, y, patches, index, _VirtualDom_diffKids);
			return;

		case 2:
			_VirtualDom_diffNodes(x, y, patches, index, _VirtualDom_diffKeyedKids);
			return;

		case 3:
			if (x.h !== y.h)
			{
				_VirtualDom_pushPatch(patches, 0, index, y);
				return;
			}

			var factsDiff = _VirtualDom_diffFacts(x.d, y.d);
			factsDiff && _VirtualDom_pushPatch(patches, 4, index, factsDiff);

			var patch = y.i(x.g, y.g);
			patch && _VirtualDom_pushPatch(patches, 5, index, patch);

			return;
	}
}

// assumes the incoming arrays are the same length
function _VirtualDom_pairwiseRefEqual(as, bs)
{
	for (var i = 0; i < as.length; i++)
	{
		if (as[i] !== bs[i])
		{
			return false;
		}
	}

	return true;
}

function _VirtualDom_diffNodes(x, y, patches, index, diffKids)
{
	// Bail if obvious indicators have changed. Implies more serious
	// structural changes such that it's not worth it to diff.
	if (x.c !== y.c || x.f !== y.f)
	{
		_VirtualDom_pushPatch(patches, 0, index, y);
		return;
	}

	var factsDiff = _VirtualDom_diffFacts(x.d, y.d);
	factsDiff && _VirtualDom_pushPatch(patches, 4, index, factsDiff);

	diffKids(x, y, patches, index);
}



// DIFF FACTS


// TODO Instead of creating a new diff object, it's possible to just test if
// there *is* a diff. During the actual patch, do the diff again and make the
// modifications directly. This way, there's no new allocations. Worth it?
function _VirtualDom_diffFacts(x, y, category)
{
	var diff;

	// look for changes and removals
	for (var xKey in x)
	{
		if (xKey === 'a1' || xKey === 'a0' || xKey === 'a3' || xKey === 'a4')
		{
			var subDiff = _VirtualDom_diffFacts(x[xKey], y[xKey] || {}, xKey);
			if (subDiff)
			{
				diff = diff || {};
				diff[xKey] = subDiff;
			}
			continue;
		}

		// remove if not in the new facts
		if (!(xKey in y))
		{
			diff = diff || {};
			diff[xKey] =
				!category
					? (typeof x[xKey] === 'string' ? '' : null)
					:
				(category === 'a1')
					? ''
					:
				(category === 'a0' || category === 'a3')
					? undefined
					:
				{ f: x[xKey].f, o: undefined };

			continue;
		}

		var xValue = x[xKey];
		var yValue = y[xKey];

		// reference equal, so don't worry about it
		if (xValue === yValue && xKey !== 'value' && xKey !== 'checked'
			|| category === 'a0' && _VirtualDom_equalEvents(xValue, yValue))
		{
			continue;
		}

		diff = diff || {};
		diff[xKey] = yValue;
	}

	// add new stuff
	for (var yKey in y)
	{
		if (!(yKey in x))
		{
			diff = diff || {};
			diff[yKey] = y[yKey];
		}
	}

	return diff;
}



// DIFF KIDS


function _VirtualDom_diffKids(xParent, yParent, patches, index)
{
	var xKids = xParent.e;
	var yKids = yParent.e;

	var xLen = xKids.length;
	var yLen = yKids.length;

	// FIGURE OUT IF THERE ARE INSERTS OR REMOVALS

	if (xLen > yLen)
	{
		_VirtualDom_pushPatch(patches, 6, index, {
			v: yLen,
			i: xLen - yLen
		});
	}
	else if (xLen < yLen)
	{
		_VirtualDom_pushPatch(patches, 7, index, {
			v: xLen,
			e: yKids
		});
	}

	// PAIRWISE DIFF EVERYTHING ELSE

	for (var minLen = xLen < yLen ? xLen : yLen, i = 0; i < minLen; i++)
	{
		var xKid = xKids[i];
		_VirtualDom_diffHelp(xKid, yKids[i], patches, ++index);
		index += xKid.b || 0;
	}
}



// KEYED DIFF


function _VirtualDom_diffKeyedKids(xParent, yParent, patches, rootIndex)
{
	var localPatches = [];

	var changes = {}; // Dict String Entry
	var inserts = []; // Array { index : Int, entry : Entry }
	// type Entry = { tag : String, vnode : VNode, index : Int, data : _ }

	var xKids = xParent.e;
	var yKids = yParent.e;
	var xLen = xKids.length;
	var yLen = yKids.length;
	var xIndex = 0;
	var yIndex = 0;

	var index = rootIndex;

	while (xIndex < xLen && yIndex < yLen)
	{
		var x = xKids[xIndex];
		var y = yKids[yIndex];

		var xKey = x.a;
		var yKey = y.a;
		var xNode = x.b;
		var yNode = y.b;

		var newMatch = undefined;
		var oldMatch = undefined;

		// check if keys match

		if (xKey === yKey)
		{
			index++;
			_VirtualDom_diffHelp(xNode, yNode, localPatches, index);
			index += xNode.b || 0;

			xIndex++;
			yIndex++;
			continue;
		}

		// look ahead 1 to detect insertions and removals.

		var xNext = xKids[xIndex + 1];
		var yNext = yKids[yIndex + 1];

		if (xNext)
		{
			var xNextKey = xNext.a;
			var xNextNode = xNext.b;
			oldMatch = yKey === xNextKey;
		}

		if (yNext)
		{
			var yNextKey = yNext.a;
			var yNextNode = yNext.b;
			newMatch = xKey === yNextKey;
		}


		// swap x and y
		if (newMatch && oldMatch)
		{
			index++;
			_VirtualDom_diffHelp(xNode, yNextNode, localPatches, index);
			_VirtualDom_insertNode(changes, localPatches, xKey, yNode, yIndex, inserts);
			index += xNode.b || 0;

			index++;
			_VirtualDom_removeNode(changes, localPatches, xKey, xNextNode, index);
			index += xNextNode.b || 0;

			xIndex += 2;
			yIndex += 2;
			continue;
		}

		// insert y
		if (newMatch)
		{
			index++;
			_VirtualDom_insertNode(changes, localPatches, yKey, yNode, yIndex, inserts);
			_VirtualDom_diffHelp(xNode, yNextNode, localPatches, index);
			index += xNode.b || 0;

			xIndex += 1;
			yIndex += 2;
			continue;
		}

		// remove x
		if (oldMatch)
		{
			index++;
			_VirtualDom_removeNode(changes, localPatches, xKey, xNode, index);
			index += xNode.b || 0;

			index++;
			_VirtualDom_diffHelp(xNextNode, yNode, localPatches, index);
			index += xNextNode.b || 0;

			xIndex += 2;
			yIndex += 1;
			continue;
		}

		// remove x, insert y
		if (xNext && xNextKey === yNextKey)
		{
			index++;
			_VirtualDom_removeNode(changes, localPatches, xKey, xNode, index);
			_VirtualDom_insertNode(changes, localPatches, yKey, yNode, yIndex, inserts);
			index += xNode.b || 0;

			index++;
			_VirtualDom_diffHelp(xNextNode, yNextNode, localPatches, index);
			index += xNextNode.b || 0;

			xIndex += 2;
			yIndex += 2;
			continue;
		}

		break;
	}

	// eat up any remaining nodes with removeNode and insertNode

	while (xIndex < xLen)
	{
		index++;
		var x = xKids[xIndex];
		var xNode = x.b;
		_VirtualDom_removeNode(changes, localPatches, x.a, xNode, index);
		index += xNode.b || 0;
		xIndex++;
	}

	while (yIndex < yLen)
	{
		var endInserts = endInserts || [];
		var y = yKids[yIndex];
		_VirtualDom_insertNode(changes, localPatches, y.a, y.b, undefined, endInserts);
		yIndex++;
	}

	if (localPatches.length > 0 || inserts.length > 0 || endInserts)
	{
		_VirtualDom_pushPatch(patches, 8, rootIndex, {
			w: localPatches,
			x: inserts,
			y: endInserts
		});
	}
}



// CHANGES FROM KEYED DIFF


var _VirtualDom_POSTFIX = '_elmW6BL';


function _VirtualDom_insertNode(changes, localPatches, key, vnode, yIndex, inserts)
{
	var entry = changes[key];

	// never seen this key before
	if (!entry)
	{
		entry = {
			c: 0,
			z: vnode,
			r: yIndex,
			s: undefined
		};

		inserts.push({ r: yIndex, A: entry });
		changes[key] = entry;

		return;
	}

	// this key was removed earlier, a match!
	if (entry.c === 1)
	{
		inserts.push({ r: yIndex, A: entry });

		entry.c = 2;
		var subPatches = [];
		_VirtualDom_diffHelp(entry.z, vnode, subPatches, entry.r);
		entry.r = yIndex;
		entry.s.s = {
			w: subPatches,
			A: entry
		};

		return;
	}

	// this key has already been inserted or moved, a duplicate!
	_VirtualDom_insertNode(changes, localPatches, key + _VirtualDom_POSTFIX, vnode, yIndex, inserts);
}


function _VirtualDom_removeNode(changes, localPatches, key, vnode, index)
{
	var entry = changes[key];

	// never seen this key before
	if (!entry)
	{
		var patch = _VirtualDom_pushPatch(localPatches, 9, index, undefined);

		changes[key] = {
			c: 1,
			z: vnode,
			r: index,
			s: patch
		};

		return;
	}

	// this key was inserted earlier, a match!
	if (entry.c === 0)
	{
		entry.c = 2;
		var subPatches = [];
		_VirtualDom_diffHelp(vnode, entry.z, subPatches, index);

		_VirtualDom_pushPatch(localPatches, 9, index, {
			w: subPatches,
			A: entry
		});

		return;
	}

	// this key has already been removed or moved, a duplicate!
	_VirtualDom_removeNode(changes, localPatches, key + _VirtualDom_POSTFIX, vnode, index);
}



// ADD DOM NODES
//
// Each DOM node has an "index" assigned in order of traversal. It is important
// to minimize our crawl over the actual DOM, so these indexes (along with the
// descendantsCount of virtual nodes) let us skip touching entire subtrees of
// the DOM if we know there are no patches there.


function _VirtualDom_addDomNodes(domNode, vNode, patches, eventNode)
{
	_VirtualDom_addDomNodesHelp(domNode, vNode, patches, 0, 0, vNode.b, eventNode);
}


// assumes `patches` is non-empty and indexes increase monotonically.
function _VirtualDom_addDomNodesHelp(domNode, vNode, patches, i, low, high, eventNode)
{
	var patch = patches[i];
	var index = patch.r;

	while (index === low)
	{
		var patchType = patch.$;

		if (patchType === 1)
		{
			_VirtualDom_addDomNodes(domNode, vNode.k, patch.s, eventNode);
		}
		else if (patchType === 8)
		{
			patch.t = domNode;
			patch.u = eventNode;

			var subPatches = patch.s.w;
			if (subPatches.length > 0)
			{
				_VirtualDom_addDomNodesHelp(domNode, vNode, subPatches, 0, low, high, eventNode);
			}
		}
		else if (patchType === 9)
		{
			patch.t = domNode;
			patch.u = eventNode;

			var data = patch.s;
			if (data)
			{
				data.A.s = domNode;
				var subPatches = data.w;
				if (subPatches.length > 0)
				{
					_VirtualDom_addDomNodesHelp(domNode, vNode, subPatches, 0, low, high, eventNode);
				}
			}
		}
		else
		{
			patch.t = domNode;
			patch.u = eventNode;
		}

		i++;

		if (!(patch = patches[i]) || (index = patch.r) > high)
		{
			return i;
		}
	}

	var tag = vNode.$;

	if (tag === 4)
	{
		var subNode = vNode.k;

		while (subNode.$ === 4)
		{
			subNode = subNode.k;
		}

		return _VirtualDom_addDomNodesHelp(domNode, subNode, patches, i, low + 1, high, domNode.elm_event_node_ref);
	}

	// tag must be 1 or 2 at this point

	var vKids = vNode.e;
	var childNodes = domNode.childNodes;
	for (var j = 0; j < vKids.length; j++)
	{
		low++;
		var vKid = tag === 1 ? vKids[j] : vKids[j].b;
		var nextLow = low + (vKid.b || 0);
		if (low <= index && index <= nextLow)
		{
			i = _VirtualDom_addDomNodesHelp(childNodes[j], vKid, patches, i, low, nextLow, eventNode);
			if (!(patch = patches[i]) || (index = patch.r) > high)
			{
				return i;
			}
		}
		low = nextLow;
	}
	return i;
}



// APPLY PATCHES


function _VirtualDom_applyPatches(rootDomNode, oldVirtualNode, patches, eventNode)
{
	if (patches.length === 0)
	{
		return rootDomNode;
	}

	_VirtualDom_addDomNodes(rootDomNode, oldVirtualNode, patches, eventNode);
	return _VirtualDom_applyPatchesHelp(rootDomNode, patches);
}

function _VirtualDom_applyPatchesHelp(rootDomNode, patches)
{
	for (var i = 0; i < patches.length; i++)
	{
		var patch = patches[i];
		var localDomNode = patch.t
		var newNode = _VirtualDom_applyPatch(localDomNode, patch);
		if (localDomNode === rootDomNode)
		{
			rootDomNode = newNode;
		}
	}
	return rootDomNode;
}

function _VirtualDom_applyPatch(domNode, patch)
{
	switch (patch.$)
	{
		case 0:
			return _VirtualDom_applyPatchRedraw(domNode, patch.s, patch.u);

		case 4:
			_VirtualDom_applyFacts(domNode, patch.u, patch.s);
			return domNode;

		case 3:
			domNode.replaceData(0, domNode.length, patch.s);
			return domNode;

		case 1:
			return _VirtualDom_applyPatchesHelp(domNode, patch.s);

		case 2:
			if (domNode.elm_event_node_ref)
			{
				domNode.elm_event_node_ref.j = patch.s;
			}
			else
			{
				domNode.elm_event_node_ref = { j: patch.s, p: patch.u };
			}
			return domNode;

		case 6:
			var data = patch.s;
			for (var i = 0; i < data.i; i++)
			{
				domNode.removeChild(domNode.childNodes[data.v]);
			}
			return domNode;

		case 7:
			var data = patch.s;
			var kids = data.e;
			var i = data.v;
			var theEnd = domNode.childNodes[i];
			for (; i < kids.length; i++)
			{
				domNode.insertBefore(_VirtualDom_render(kids[i], patch.u), theEnd);
			}
			return domNode;

		case 9:
			var data = patch.s;
			if (!data)
			{
				domNode.parentNode.removeChild(domNode);
				return domNode;
			}
			var entry = data.A;
			if (typeof entry.r !== 'undefined')
			{
				domNode.parentNode.removeChild(domNode);
			}
			entry.s = _VirtualDom_applyPatchesHelp(domNode, data.w);
			return domNode;

		case 8:
			return _VirtualDom_applyPatchReorder(domNode, patch);

		case 5:
			return patch.s(domNode);

		default:
			_Debug_crash(10); // 'Ran into an unknown patch!'
	}
}


function _VirtualDom_applyPatchRedraw(domNode, vNode, eventNode)
{
	var parentNode = domNode.parentNode;
	var newNode = _VirtualDom_render(vNode, eventNode);

	if (!newNode.elm_event_node_ref)
	{
		newNode.elm_event_node_ref = domNode.elm_event_node_ref;
	}

	if (parentNode && newNode !== domNode)
	{
		parentNode.replaceChild(newNode, domNode);
	}
	return newNode;
}


function _VirtualDom_applyPatchReorder(domNode, patch)
{
	var data = patch.s;

	// remove end inserts
	var frag = _VirtualDom_applyPatchReorderEndInsertsHelp(data.y, patch);

	// removals
	domNode = _VirtualDom_applyPatchesHelp(domNode, data.w);

	// inserts
	var inserts = data.x;
	for (var i = 0; i < inserts.length; i++)
	{
		var insert = inserts[i];
		var entry = insert.A;
		var node = entry.c === 2
			? entry.s
			: _VirtualDom_render(entry.z, patch.u);
		domNode.insertBefore(node, domNode.childNodes[insert.r]);
	}

	// add end inserts
	if (frag)
	{
		_VirtualDom_appendChild(domNode, frag);
	}

	return domNode;
}


function _VirtualDom_applyPatchReorderEndInsertsHelp(endInserts, patch)
{
	if (!endInserts)
	{
		return;
	}

	var frag = _VirtualDom_doc.createDocumentFragment();
	for (var i = 0; i < endInserts.length; i++)
	{
		var insert = endInserts[i];
		var entry = insert.A;
		_VirtualDom_appendChild(frag, entry.c === 2
			? entry.s
			: _VirtualDom_render(entry.z, patch.u)
		);
	}
	return frag;
}


function _VirtualDom_virtualize(node)
{
	// TEXT NODES

	if (node.nodeType === 3)
	{
		return _VirtualDom_text(node.textContent);
	}


	// WEIRD NODES

	if (node.nodeType !== 1)
	{
		return _VirtualDom_text('');
	}


	// ELEMENT NODES

	var attrList = _List_Nil;
	var attrs = node.attributes;
	for (var i = attrs.length; i--; )
	{
		var attr = attrs[i];
		var name = attr.name;
		var value = attr.value;
		attrList = _List_Cons( A2(_VirtualDom_attribute, name, value), attrList );
	}

	var tag = node.tagName.toLowerCase();
	var kidList = _List_Nil;
	var kids = node.childNodes;

	for (var i = kids.length; i--; )
	{
		kidList = _List_Cons(_VirtualDom_virtualize(kids[i]), kidList);
	}
	return A3(_VirtualDom_node, tag, attrList, kidList);
}

function _VirtualDom_dekey(keyedNode)
{
	var keyedKids = keyedNode.e;
	var len = keyedKids.length;
	var kids = new Array(len);
	for (var i = 0; i < len; i++)
	{
		kids[i] = keyedKids[i].b;
	}

	return {
		$: 1,
		c: keyedNode.c,
		d: keyedNode.d,
		e: kids,
		f: keyedNode.f,
		b: keyedNode.b
	};
}




// ELEMENT


var _Debugger_element;

var _Browser_element = _Debugger_element || F4(function(impl, flagDecoder, debugMetadata, args)
{
	return _Platform_initialize(
		flagDecoder,
		args,
		impl.init,
		impl.update,
		impl.subscriptions,
		function(sendToApp, initialModel) {
			var view = impl.view;
			/**_UNUSED/
			var domNode = args['node'];
			//*/
			/**/
			var domNode = args && args['node'] ? args['node'] : _Debug_crash(0);
			//*/
			var currNode = _VirtualDom_virtualize(domNode);

			return _Browser_makeAnimator(initialModel, function(model)
			{
				var nextNode = view(model);
				var patches = _VirtualDom_diff(currNode, nextNode);
				domNode = _VirtualDom_applyPatches(domNode, currNode, patches, sendToApp);
				currNode = nextNode;
			});
		}
	);
});



// DOCUMENT


var _Debugger_document;

var _Browser_document = _Debugger_document || F4(function(impl, flagDecoder, debugMetadata, args)
{
	return _Platform_initialize(
		flagDecoder,
		args,
		impl.init,
		impl.update,
		impl.subscriptions,
		function(sendToApp, initialModel) {
			var divertHrefToApp = impl.setup && impl.setup(sendToApp)
			var view = impl.view;
			var title = _VirtualDom_doc.title;
			var bodyNode = _VirtualDom_doc.body;
			var currNode = _VirtualDom_virtualize(bodyNode);
			return _Browser_makeAnimator(initialModel, function(model)
			{
				_VirtualDom_divertHrefToApp = divertHrefToApp;
				var doc = view(model);
				var nextNode = _VirtualDom_node('body')(_List_Nil)(doc.body);
				var patches = _VirtualDom_diff(currNode, nextNode);
				bodyNode = _VirtualDom_applyPatches(bodyNode, currNode, patches, sendToApp);
				currNode = nextNode;
				_VirtualDom_divertHrefToApp = 0;
				(title !== doc.title) && (_VirtualDom_doc.title = title = doc.title);
			});
		}
	);
});



// ANIMATION


var _Browser_cancelAnimationFrame =
	typeof cancelAnimationFrame !== 'undefined'
		? cancelAnimationFrame
		: function(id) { clearTimeout(id); };

var _Browser_requestAnimationFrame =
	typeof requestAnimationFrame !== 'undefined'
		? requestAnimationFrame
		: function(callback) { return setTimeout(callback, 1000 / 60); };


function _Browser_makeAnimator(model, draw)
{
	draw(model);

	var state = 0;

	function updateIfNeeded()
	{
		state = state === 1
			? 0
			: ( _Browser_requestAnimationFrame(updateIfNeeded), draw(model), 1 );
	}

	return function(nextModel, isSync)
	{
		model = nextModel;

		isSync
			? ( draw(model),
				state === 2 && (state = 1)
				)
			: ( state === 0 && _Browser_requestAnimationFrame(updateIfNeeded),
				state = 2
				);
	};
}



// APPLICATION


function _Browser_application(impl)
{
	var onUrlChange = impl.onUrlChange;
	var onUrlRequest = impl.onUrlRequest;
	var key = function() { key.a(onUrlChange(_Browser_getUrl())); };

	return _Browser_document({
		setup: function(sendToApp)
		{
			key.a = sendToApp;
			_Browser_window.addEventListener('popstate', key);
			_Browser_window.navigator.userAgent.indexOf('Trident') < 0 || _Browser_window.addEventListener('hashchange', key);

			return F2(function(domNode, event)
			{
				if (!event.ctrlKey && !event.metaKey && !event.shiftKey && event.button < 1 && !domNode.target && !domNode.hasAttribute('download'))
				{
					event.preventDefault();
					var href = domNode.href;
					var curr = _Browser_getUrl();
					var next = $elm$url$Url$fromString(href).a;
					sendToApp(onUrlRequest(
						(next
							&& curr.protocol === next.protocol
							&& curr.host === next.host
							&& curr.port_.a === next.port_.a
						)
							? $elm$browser$Browser$Internal(next)
							: $elm$browser$Browser$External(href)
					));
				}
			});
		},
		init: function(flags)
		{
			return A3(impl.init, flags, _Browser_getUrl(), key);
		},
		view: impl.view,
		update: impl.update,
		subscriptions: impl.subscriptions
	});
}

function _Browser_getUrl()
{
	return $elm$url$Url$fromString(_VirtualDom_doc.location.href).a || _Debug_crash(1);
}

var _Browser_go = F2(function(key, n)
{
	return A2($elm$core$Task$perform, $elm$core$Basics$never, _Scheduler_binding(function() {
		n && history.go(n);
		key();
	}));
});

var _Browser_pushUrl = F2(function(key, url)
{
	return A2($elm$core$Task$perform, $elm$core$Basics$never, _Scheduler_binding(function() {
		history.pushState({}, '', url);
		key();
	}));
});

var _Browser_replaceUrl = F2(function(key, url)
{
	return A2($elm$core$Task$perform, $elm$core$Basics$never, _Scheduler_binding(function() {
		history.replaceState({}, '', url);
		key();
	}));
});



// GLOBAL EVENTS


var _Browser_fakeNode = { addEventListener: function() {}, removeEventListener: function() {} };
var _Browser_doc = typeof document !== 'undefined' ? document : _Browser_fakeNode;
var _Browser_window = typeof window !== 'undefined' ? window : _Browser_fakeNode;

var _Browser_on = F3(function(node, eventName, sendToSelf)
{
	return _Scheduler_spawn(_Scheduler_binding(function(callback)
	{
		function handler(event)	{ _Scheduler_rawSpawn(sendToSelf(event)); }
		node.addEventListener(eventName, handler, _VirtualDom_passiveSupported && { passive: true });
		return function() { node.removeEventListener(eventName, handler); };
	}));
});

var _Browser_decodeEvent = F2(function(decoder, event)
{
	var result = _Json_runHelp(decoder, event);
	return $elm$core$Result$isOk(result) ? $elm$core$Maybe$Just(result.a) : $elm$core$Maybe$Nothing;
});



// PAGE VISIBILITY


function _Browser_visibilityInfo()
{
	return (typeof _VirtualDom_doc.hidden !== 'undefined')
		? { hidden: 'hidden', change: 'visibilitychange' }
		:
	(typeof _VirtualDom_doc.mozHidden !== 'undefined')
		? { hidden: 'mozHidden', change: 'mozvisibilitychange' }
		:
	(typeof _VirtualDom_doc.msHidden !== 'undefined')
		? { hidden: 'msHidden', change: 'msvisibilitychange' }
		:
	(typeof _VirtualDom_doc.webkitHidden !== 'undefined')
		? { hidden: 'webkitHidden', change: 'webkitvisibilitychange' }
		: { hidden: 'hidden', change: 'visibilitychange' };
}



// ANIMATION FRAMES


function _Browser_rAF()
{
	return _Scheduler_binding(function(callback)
	{
		var id = _Browser_requestAnimationFrame(function() {
			callback(_Scheduler_succeed(Date.now()));
		});

		return function() {
			_Browser_cancelAnimationFrame(id);
		};
	});
}


function _Browser_now()
{
	return _Scheduler_binding(function(callback)
	{
		callback(_Scheduler_succeed(Date.now()));
	});
}



// DOM STUFF


function _Browser_withNode(id, doStuff)
{
	return _Scheduler_binding(function(callback)
	{
		_Browser_requestAnimationFrame(function() {
			var node = document.getElementById(id);
			callback(node
				? _Scheduler_succeed(doStuff(node))
				: _Scheduler_fail($elm$browser$Browser$Dom$NotFound(id))
			);
		});
	});
}


function _Browser_withWindow(doStuff)
{
	return _Scheduler_binding(function(callback)
	{
		_Browser_requestAnimationFrame(function() {
			callback(_Scheduler_succeed(doStuff()));
		});
	});
}


// FOCUS and BLUR


var _Browser_call = F2(function(functionName, id)
{
	return _Browser_withNode(id, function(node) {
		node[functionName]();
		return _Utils_Tuple0;
	});
});



// WINDOW VIEWPORT


function _Browser_getViewport()
{
	return {
		scene: _Browser_getScene(),
		viewport: {
			x: _Browser_window.pageXOffset,
			y: _Browser_window.pageYOffset,
			width: _Browser_doc.documentElement.clientWidth,
			height: _Browser_doc.documentElement.clientHeight
		}
	};
}

function _Browser_getScene()
{
	var body = _Browser_doc.body;
	var elem = _Browser_doc.documentElement;
	return {
		width: Math.max(body.scrollWidth, body.offsetWidth, elem.scrollWidth, elem.offsetWidth, elem.clientWidth),
		height: Math.max(body.scrollHeight, body.offsetHeight, elem.scrollHeight, elem.offsetHeight, elem.clientHeight)
	};
}

var _Browser_setViewport = F2(function(x, y)
{
	return _Browser_withWindow(function()
	{
		_Browser_window.scroll(x, y);
		return _Utils_Tuple0;
	});
});



// ELEMENT VIEWPORT


function _Browser_getViewportOf(id)
{
	return _Browser_withNode(id, function(node)
	{
		return {
			scene: {
				width: node.scrollWidth,
				height: node.scrollHeight
			},
			viewport: {
				x: node.scrollLeft,
				y: node.scrollTop,
				width: node.clientWidth,
				height: node.clientHeight
			}
		};
	});
}


var _Browser_setViewportOf = F3(function(id, x, y)
{
	return _Browser_withNode(id, function(node)
	{
		node.scrollLeft = x;
		node.scrollTop = y;
		return _Utils_Tuple0;
	});
});



// ELEMENT


function _Browser_getElement(id)
{
	return _Browser_withNode(id, function(node)
	{
		var rect = node.getBoundingClientRect();
		var x = _Browser_window.pageXOffset;
		var y = _Browser_window.pageYOffset;
		return {
			scene: _Browser_getScene(),
			viewport: {
				x: x,
				y: y,
				width: _Browser_doc.documentElement.clientWidth,
				height: _Browser_doc.documentElement.clientHeight
			},
			element: {
				x: x + rect.left,
				y: y + rect.top,
				width: rect.width,
				height: rect.height
			}
		};
	});
}



// LOAD and RELOAD


function _Browser_reload(skipCache)
{
	return A2($elm$core$Task$perform, $elm$core$Basics$never, _Scheduler_binding(function(callback)
	{
		_VirtualDom_doc.location.reload(skipCache);
	}));
}

function _Browser_load(url)
{
	return A2($elm$core$Task$perform, $elm$core$Basics$never, _Scheduler_binding(function(callback)
	{
		try
		{
			_Browser_window.location = url;
		}
		catch(err)
		{
			// Only Firefox can throw a NS_ERROR_MALFORMED_URI exception here.
			// Other browsers reload the page, so let's be consistent about that.
			_VirtualDom_doc.location.reload(false);
		}
	}));
}



function _Time_now(millisToPosix)
{
	return _Scheduler_binding(function(callback)
	{
		callback(_Scheduler_succeed(millisToPosix(Date.now())));
	});
}

var _Time_setInterval = F2(function(interval, task)
{
	return _Scheduler_binding(function(callback)
	{
		var id = setInterval(function() { _Scheduler_rawSpawn(task); }, interval);
		return function() { clearInterval(id); };
	});
});

function _Time_here()
{
	return _Scheduler_binding(function(callback)
	{
		callback(_Scheduler_succeed(
			A2($elm$time$Time$customZone, -(new Date().getTimezoneOffset()), _List_Nil)
		));
	});
}


function _Time_getZoneName()
{
	return _Scheduler_binding(function(callback)
	{
		try
		{
			var name = $elm$time$Time$Name(Intl.DateTimeFormat().resolvedOptions().timeZone);
		}
		catch (e)
		{
			var name = $elm$time$Time$Offset(new Date().getTimezoneOffset());
		}
		callback(_Scheduler_succeed(name));
	});
}
var $author$project$Main$Tick = F2(
	function (a, b) {
		return {$: 'Tick', a: a, b: b};
	});
var $elm$core$Basics$EQ = {$: 'EQ'};
var $elm$core$Basics$LT = {$: 'LT'};
var $elm$core$List$cons = _List_cons;
var $elm$core$Elm$JsArray$foldr = _JsArray_foldr;
var $elm$core$Array$foldr = F3(
	function (func, baseCase, _v0) {
		var tree = _v0.c;
		var tail = _v0.d;
		var helper = F2(
			function (node, acc) {
				if (node.$ === 'SubTree') {
					var subTree = node.a;
					return A3($elm$core$Elm$JsArray$foldr, helper, acc, subTree);
				} else {
					var values = node.a;
					return A3($elm$core$Elm$JsArray$foldr, func, acc, values);
				}
			});
		return A3(
			$elm$core$Elm$JsArray$foldr,
			helper,
			A3($elm$core$Elm$JsArray$foldr, func, baseCase, tail),
			tree);
	});
var $elm$core$Array$toList = function (array) {
	return A3($elm$core$Array$foldr, $elm$core$List$cons, _List_Nil, array);
};
var $elm$core$Dict$foldr = F3(
	function (func, acc, t) {
		foldr:
		while (true) {
			if (t.$ === 'RBEmpty_elm_builtin') {
				return acc;
			} else {
				var key = t.b;
				var value = t.c;
				var left = t.d;
				var right = t.e;
				var $temp$func = func,
					$temp$acc = A3(
					func,
					key,
					value,
					A3($elm$core$Dict$foldr, func, acc, right)),
					$temp$t = left;
				func = $temp$func;
				acc = $temp$acc;
				t = $temp$t;
				continue foldr;
			}
		}
	});
var $elm$core$Dict$toList = function (dict) {
	return A3(
		$elm$core$Dict$foldr,
		F3(
			function (key, value, list) {
				return A2(
					$elm$core$List$cons,
					_Utils_Tuple2(key, value),
					list);
			}),
		_List_Nil,
		dict);
};
var $elm$core$Dict$keys = function (dict) {
	return A3(
		$elm$core$Dict$foldr,
		F3(
			function (key, value, keyList) {
				return A2($elm$core$List$cons, key, keyList);
			}),
		_List_Nil,
		dict);
};
var $elm$core$Set$toList = function (_v0) {
	var dict = _v0.a;
	return $elm$core$Dict$keys(dict);
};
var $elm$core$Basics$GT = {$: 'GT'};
var $MacCASOutreach$graphicsvg$GraphicSVG$App$InitTime = function (a) {
	return {$: 'InitTime', a: a};
};
var $MacCASOutreach$graphicsvg$GraphicSVG$App$URLChanged = function (a) {
	return {$: 'URLChanged', a: a};
};
var $MacCASOutreach$graphicsvg$GraphicSVG$App$URLRequest = function (a) {
	return {$: 'URLRequest', a: a};
};
var $MacCASOutreach$graphicsvg$GraphicSVG$App$UserMsg = function (a) {
	return {$: 'UserMsg', a: a};
};
var $elm$core$Basics$apL = F2(
	function (f, x) {
		return f(x);
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Graphics = function (a) {
	return {$: 'Graphics', a: a};
};
var $elm$core$Result$Err = function (a) {
	return {$: 'Err', a: a};
};
var $elm$json$Json$Decode$Failure = F2(
	function (a, b) {
		return {$: 'Failure', a: a, b: b};
	});
var $elm$json$Json$Decode$Field = F2(
	function (a, b) {
		return {$: 'Field', a: a, b: b};
	});
var $elm$json$Json$Decode$Index = F2(
	function (a, b) {
		return {$: 'Index', a: a, b: b};
	});
var $elm$core$Result$Ok = function (a) {
	return {$: 'Ok', a: a};
};
var $elm$json$Json$Decode$OneOf = function (a) {
	return {$: 'OneOf', a: a};
};
var $elm$core$Basics$False = {$: 'False'};
var $elm$core$Basics$add = _Basics_add;
var $elm$core$Maybe$Just = function (a) {
	return {$: 'Just', a: a};
};
var $elm$core$Maybe$Nothing = {$: 'Nothing'};
var $elm$core$String$all = _String_all;
var $elm$core$Basics$and = _Basics_and;
var $elm$core$Basics$append = _Utils_append;
var $elm$json$Json$Encode$encode = _Json_encode;
var $elm$core$String$fromInt = _String_fromNumber;
var $elm$core$String$join = F2(
	function (sep, chunks) {
		return A2(
			_String_join,
			sep,
			_List_toArray(chunks));
	});
var $elm$core$String$split = F2(
	function (sep, string) {
		return _List_fromArray(
			A2(_String_split, sep, string));
	});
var $elm$json$Json$Decode$indent = function (str) {
	return A2(
		$elm$core$String$join,
		'\n    ',
		A2($elm$core$String$split, '\n', str));
};
var $elm$core$List$foldl = F3(
	function (func, acc, list) {
		foldl:
		while (true) {
			if (!list.b) {
				return acc;
			} else {
				var x = list.a;
				var xs = list.b;
				var $temp$func = func,
					$temp$acc = A2(func, x, acc),
					$temp$list = xs;
				func = $temp$func;
				acc = $temp$acc;
				list = $temp$list;
				continue foldl;
			}
		}
	});
var $elm$core$List$length = function (xs) {
	return A3(
		$elm$core$List$foldl,
		F2(
			function (_v0, i) {
				return i + 1;
			}),
		0,
		xs);
};
var $elm$core$List$map2 = _List_map2;
var $elm$core$Basics$le = _Utils_le;
var $elm$core$Basics$sub = _Basics_sub;
var $elm$core$List$rangeHelp = F3(
	function (lo, hi, list) {
		rangeHelp:
		while (true) {
			if (_Utils_cmp(lo, hi) < 1) {
				var $temp$lo = lo,
					$temp$hi = hi - 1,
					$temp$list = A2($elm$core$List$cons, hi, list);
				lo = $temp$lo;
				hi = $temp$hi;
				list = $temp$list;
				continue rangeHelp;
			} else {
				return list;
			}
		}
	});
var $elm$core$List$range = F2(
	function (lo, hi) {
		return A3($elm$core$List$rangeHelp, lo, hi, _List_Nil);
	});
var $elm$core$List$indexedMap = F2(
	function (f, xs) {
		return A3(
			$elm$core$List$map2,
			f,
			A2(
				$elm$core$List$range,
				0,
				$elm$core$List$length(xs) - 1),
			xs);
	});
var $elm$core$Char$toCode = _Char_toCode;
var $elm$core$Char$isLower = function (_char) {
	var code = $elm$core$Char$toCode(_char);
	return (97 <= code) && (code <= 122);
};
var $elm$core$Char$isUpper = function (_char) {
	var code = $elm$core$Char$toCode(_char);
	return (code <= 90) && (65 <= code);
};
var $elm$core$Basics$or = _Basics_or;
var $elm$core$Char$isAlpha = function (_char) {
	return $elm$core$Char$isLower(_char) || $elm$core$Char$isUpper(_char);
};
var $elm$core$Char$isDigit = function (_char) {
	var code = $elm$core$Char$toCode(_char);
	return (code <= 57) && (48 <= code);
};
var $elm$core$Char$isAlphaNum = function (_char) {
	return $elm$core$Char$isLower(_char) || ($elm$core$Char$isUpper(_char) || $elm$core$Char$isDigit(_char));
};
var $elm$core$List$reverse = function (list) {
	return A3($elm$core$List$foldl, $elm$core$List$cons, _List_Nil, list);
};
var $elm$core$String$uncons = _String_uncons;
var $elm$json$Json$Decode$errorOneOf = F2(
	function (i, error) {
		return '\n\n(' + ($elm$core$String$fromInt(i + 1) + (') ' + $elm$json$Json$Decode$indent(
			$elm$json$Json$Decode$errorToString(error))));
	});
var $elm$json$Json$Decode$errorToString = function (error) {
	return A2($elm$json$Json$Decode$errorToStringHelp, error, _List_Nil);
};
var $elm$json$Json$Decode$errorToStringHelp = F2(
	function (error, context) {
		errorToStringHelp:
		while (true) {
			switch (error.$) {
				case 'Field':
					var f = error.a;
					var err = error.b;
					var isSimple = function () {
						var _v1 = $elm$core$String$uncons(f);
						if (_v1.$ === 'Nothing') {
							return false;
						} else {
							var _v2 = _v1.a;
							var _char = _v2.a;
							var rest = _v2.b;
							return $elm$core$Char$isAlpha(_char) && A2($elm$core$String$all, $elm$core$Char$isAlphaNum, rest);
						}
					}();
					var fieldName = isSimple ? ('.' + f) : ('[\'' + (f + '\']'));
					var $temp$error = err,
						$temp$context = A2($elm$core$List$cons, fieldName, context);
					error = $temp$error;
					context = $temp$context;
					continue errorToStringHelp;
				case 'Index':
					var i = error.a;
					var err = error.b;
					var indexName = '[' + ($elm$core$String$fromInt(i) + ']');
					var $temp$error = err,
						$temp$context = A2($elm$core$List$cons, indexName, context);
					error = $temp$error;
					context = $temp$context;
					continue errorToStringHelp;
				case 'OneOf':
					var errors = error.a;
					if (!errors.b) {
						return 'Ran into a Json.Decode.oneOf with no possibilities' + function () {
							if (!context.b) {
								return '!';
							} else {
								return ' at json' + A2(
									$elm$core$String$join,
									'',
									$elm$core$List$reverse(context));
							}
						}();
					} else {
						if (!errors.b.b) {
							var err = errors.a;
							var $temp$error = err,
								$temp$context = context;
							error = $temp$error;
							context = $temp$context;
							continue errorToStringHelp;
						} else {
							var starter = function () {
								if (!context.b) {
									return 'Json.Decode.oneOf';
								} else {
									return 'The Json.Decode.oneOf at json' + A2(
										$elm$core$String$join,
										'',
										$elm$core$List$reverse(context));
								}
							}();
							var introduction = starter + (' failed in the following ' + ($elm$core$String$fromInt(
								$elm$core$List$length(errors)) + ' ways:'));
							return A2(
								$elm$core$String$join,
								'\n\n',
								A2(
									$elm$core$List$cons,
									introduction,
									A2($elm$core$List$indexedMap, $elm$json$Json$Decode$errorOneOf, errors)));
						}
					}
				default:
					var msg = error.a;
					var json = error.b;
					var introduction = function () {
						if (!context.b) {
							return 'Problem with the given value:\n\n';
						} else {
							return 'Problem with the value at json' + (A2(
								$elm$core$String$join,
								'',
								$elm$core$List$reverse(context)) + ':\n\n    ');
						}
					}();
					return introduction + ($elm$json$Json$Decode$indent(
						A2($elm$json$Json$Encode$encode, 4, json)) + ('\n\n' + msg));
			}
		}
	});
var $elm$core$Array$branchFactor = 32;
var $elm$core$Array$Array_elm_builtin = F4(
	function (a, b, c, d) {
		return {$: 'Array_elm_builtin', a: a, b: b, c: c, d: d};
	});
var $elm$core$Elm$JsArray$empty = _JsArray_empty;
var $elm$core$Basics$ceiling = _Basics_ceiling;
var $elm$core$Basics$fdiv = _Basics_fdiv;
var $elm$core$Basics$logBase = F2(
	function (base, number) {
		return _Basics_log(number) / _Basics_log(base);
	});
var $elm$core$Basics$toFloat = _Basics_toFloat;
var $elm$core$Array$shiftStep = $elm$core$Basics$ceiling(
	A2($elm$core$Basics$logBase, 2, $elm$core$Array$branchFactor));
var $elm$core$Array$empty = A4($elm$core$Array$Array_elm_builtin, 0, $elm$core$Array$shiftStep, $elm$core$Elm$JsArray$empty, $elm$core$Elm$JsArray$empty);
var $elm$core$Elm$JsArray$initialize = _JsArray_initialize;
var $elm$core$Array$Leaf = function (a) {
	return {$: 'Leaf', a: a};
};
var $elm$core$Basics$apR = F2(
	function (x, f) {
		return f(x);
	});
var $elm$core$Basics$eq = _Utils_equal;
var $elm$core$Basics$floor = _Basics_floor;
var $elm$core$Elm$JsArray$length = _JsArray_length;
var $elm$core$Basics$gt = _Utils_gt;
var $elm$core$Basics$max = F2(
	function (x, y) {
		return (_Utils_cmp(x, y) > 0) ? x : y;
	});
var $elm$core$Basics$mul = _Basics_mul;
var $elm$core$Array$SubTree = function (a) {
	return {$: 'SubTree', a: a};
};
var $elm$core$Elm$JsArray$initializeFromList = _JsArray_initializeFromList;
var $elm$core$Array$compressNodes = F2(
	function (nodes, acc) {
		compressNodes:
		while (true) {
			var _v0 = A2($elm$core$Elm$JsArray$initializeFromList, $elm$core$Array$branchFactor, nodes);
			var node = _v0.a;
			var remainingNodes = _v0.b;
			var newAcc = A2(
				$elm$core$List$cons,
				$elm$core$Array$SubTree(node),
				acc);
			if (!remainingNodes.b) {
				return $elm$core$List$reverse(newAcc);
			} else {
				var $temp$nodes = remainingNodes,
					$temp$acc = newAcc;
				nodes = $temp$nodes;
				acc = $temp$acc;
				continue compressNodes;
			}
		}
	});
var $elm$core$Tuple$first = function (_v0) {
	var x = _v0.a;
	return x;
};
var $elm$core$Array$treeFromBuilder = F2(
	function (nodeList, nodeListSize) {
		treeFromBuilder:
		while (true) {
			var newNodeSize = $elm$core$Basics$ceiling(nodeListSize / $elm$core$Array$branchFactor);
			if (newNodeSize === 1) {
				return A2($elm$core$Elm$JsArray$initializeFromList, $elm$core$Array$branchFactor, nodeList).a;
			} else {
				var $temp$nodeList = A2($elm$core$Array$compressNodes, nodeList, _List_Nil),
					$temp$nodeListSize = newNodeSize;
				nodeList = $temp$nodeList;
				nodeListSize = $temp$nodeListSize;
				continue treeFromBuilder;
			}
		}
	});
var $elm$core$Array$builderToArray = F2(
	function (reverseNodeList, builder) {
		if (!builder.nodeListSize) {
			return A4(
				$elm$core$Array$Array_elm_builtin,
				$elm$core$Elm$JsArray$length(builder.tail),
				$elm$core$Array$shiftStep,
				$elm$core$Elm$JsArray$empty,
				builder.tail);
		} else {
			var treeLen = builder.nodeListSize * $elm$core$Array$branchFactor;
			var depth = $elm$core$Basics$floor(
				A2($elm$core$Basics$logBase, $elm$core$Array$branchFactor, treeLen - 1));
			var correctNodeList = reverseNodeList ? $elm$core$List$reverse(builder.nodeList) : builder.nodeList;
			var tree = A2($elm$core$Array$treeFromBuilder, correctNodeList, builder.nodeListSize);
			return A4(
				$elm$core$Array$Array_elm_builtin,
				$elm$core$Elm$JsArray$length(builder.tail) + treeLen,
				A2($elm$core$Basics$max, 5, depth * $elm$core$Array$shiftStep),
				tree,
				builder.tail);
		}
	});
var $elm$core$Basics$idiv = _Basics_idiv;
var $elm$core$Basics$lt = _Utils_lt;
var $elm$core$Array$initializeHelp = F5(
	function (fn, fromIndex, len, nodeList, tail) {
		initializeHelp:
		while (true) {
			if (fromIndex < 0) {
				return A2(
					$elm$core$Array$builderToArray,
					false,
					{nodeList: nodeList, nodeListSize: (len / $elm$core$Array$branchFactor) | 0, tail: tail});
			} else {
				var leaf = $elm$core$Array$Leaf(
					A3($elm$core$Elm$JsArray$initialize, $elm$core$Array$branchFactor, fromIndex, fn));
				var $temp$fn = fn,
					$temp$fromIndex = fromIndex - $elm$core$Array$branchFactor,
					$temp$len = len,
					$temp$nodeList = A2($elm$core$List$cons, leaf, nodeList),
					$temp$tail = tail;
				fn = $temp$fn;
				fromIndex = $temp$fromIndex;
				len = $temp$len;
				nodeList = $temp$nodeList;
				tail = $temp$tail;
				continue initializeHelp;
			}
		}
	});
var $elm$core$Basics$remainderBy = _Basics_remainderBy;
var $elm$core$Array$initialize = F2(
	function (len, fn) {
		if (len <= 0) {
			return $elm$core$Array$empty;
		} else {
			var tailLen = len % $elm$core$Array$branchFactor;
			var tail = A3($elm$core$Elm$JsArray$initialize, tailLen, len - tailLen, fn);
			var initialFromIndex = (len - tailLen) - $elm$core$Array$branchFactor;
			return A5($elm$core$Array$initializeHelp, fn, initialFromIndex, len, _List_Nil, tail);
		}
	});
var $elm$core$Basics$True = {$: 'True'};
var $elm$core$Result$isOk = function (result) {
	if (result.$ === 'Ok') {
		return true;
	} else {
		return false;
	}
};
var $elm$json$Json$Decode$map = _Json_map1;
var $elm$json$Json$Decode$map2 = _Json_map2;
var $elm$json$Json$Decode$succeed = _Json_succeed;
var $elm$virtual_dom$VirtualDom$toHandlerInt = function (handler) {
	switch (handler.$) {
		case 'Normal':
			return 0;
		case 'MayStopPropagation':
			return 1;
		case 'MayPreventDefault':
			return 2;
		default:
			return 3;
	}
};
var $elm$browser$Browser$External = function (a) {
	return {$: 'External', a: a};
};
var $elm$browser$Browser$Internal = function (a) {
	return {$: 'Internal', a: a};
};
var $elm$core$Basics$identity = function (x) {
	return x;
};
var $elm$browser$Browser$Dom$NotFound = function (a) {
	return {$: 'NotFound', a: a};
};
var $elm$url$Url$Http = {$: 'Http'};
var $elm$url$Url$Https = {$: 'Https'};
var $elm$url$Url$Url = F6(
	function (protocol, host, port_, path, query, fragment) {
		return {fragment: fragment, host: host, path: path, port_: port_, protocol: protocol, query: query};
	});
var $elm$core$String$contains = _String_contains;
var $elm$core$String$length = _String_length;
var $elm$core$String$slice = _String_slice;
var $elm$core$String$dropLeft = F2(
	function (n, string) {
		return (n < 1) ? string : A3(
			$elm$core$String$slice,
			n,
			$elm$core$String$length(string),
			string);
	});
var $elm$core$String$indexes = _String_indexes;
var $elm$core$String$isEmpty = function (string) {
	return string === '';
};
var $elm$core$String$left = F2(
	function (n, string) {
		return (n < 1) ? '' : A3($elm$core$String$slice, 0, n, string);
	});
var $elm$core$String$toInt = _String_toInt;
var $elm$url$Url$chompBeforePath = F5(
	function (protocol, path, params, frag, str) {
		if ($elm$core$String$isEmpty(str) || A2($elm$core$String$contains, '@', str)) {
			return $elm$core$Maybe$Nothing;
		} else {
			var _v0 = A2($elm$core$String$indexes, ':', str);
			if (!_v0.b) {
				return $elm$core$Maybe$Just(
					A6($elm$url$Url$Url, protocol, str, $elm$core$Maybe$Nothing, path, params, frag));
			} else {
				if (!_v0.b.b) {
					var i = _v0.a;
					var _v1 = $elm$core$String$toInt(
						A2($elm$core$String$dropLeft, i + 1, str));
					if (_v1.$ === 'Nothing') {
						return $elm$core$Maybe$Nothing;
					} else {
						var port_ = _v1;
						return $elm$core$Maybe$Just(
							A6(
								$elm$url$Url$Url,
								protocol,
								A2($elm$core$String$left, i, str),
								port_,
								path,
								params,
								frag));
					}
				} else {
					return $elm$core$Maybe$Nothing;
				}
			}
		}
	});
var $elm$url$Url$chompBeforeQuery = F4(
	function (protocol, params, frag, str) {
		if ($elm$core$String$isEmpty(str)) {
			return $elm$core$Maybe$Nothing;
		} else {
			var _v0 = A2($elm$core$String$indexes, '/', str);
			if (!_v0.b) {
				return A5($elm$url$Url$chompBeforePath, protocol, '/', params, frag, str);
			} else {
				var i = _v0.a;
				return A5(
					$elm$url$Url$chompBeforePath,
					protocol,
					A2($elm$core$String$dropLeft, i, str),
					params,
					frag,
					A2($elm$core$String$left, i, str));
			}
		}
	});
var $elm$url$Url$chompBeforeFragment = F3(
	function (protocol, frag, str) {
		if ($elm$core$String$isEmpty(str)) {
			return $elm$core$Maybe$Nothing;
		} else {
			var _v0 = A2($elm$core$String$indexes, '?', str);
			if (!_v0.b) {
				return A4($elm$url$Url$chompBeforeQuery, protocol, $elm$core$Maybe$Nothing, frag, str);
			} else {
				var i = _v0.a;
				return A4(
					$elm$url$Url$chompBeforeQuery,
					protocol,
					$elm$core$Maybe$Just(
						A2($elm$core$String$dropLeft, i + 1, str)),
					frag,
					A2($elm$core$String$left, i, str));
			}
		}
	});
var $elm$url$Url$chompAfterProtocol = F2(
	function (protocol, str) {
		if ($elm$core$String$isEmpty(str)) {
			return $elm$core$Maybe$Nothing;
		} else {
			var _v0 = A2($elm$core$String$indexes, '#', str);
			if (!_v0.b) {
				return A3($elm$url$Url$chompBeforeFragment, protocol, $elm$core$Maybe$Nothing, str);
			} else {
				var i = _v0.a;
				return A3(
					$elm$url$Url$chompBeforeFragment,
					protocol,
					$elm$core$Maybe$Just(
						A2($elm$core$String$dropLeft, i + 1, str)),
					A2($elm$core$String$left, i, str));
			}
		}
	});
var $elm$core$String$startsWith = _String_startsWith;
var $elm$url$Url$fromString = function (str) {
	return A2($elm$core$String$startsWith, 'http://', str) ? A2(
		$elm$url$Url$chompAfterProtocol,
		$elm$url$Url$Http,
		A2($elm$core$String$dropLeft, 7, str)) : (A2($elm$core$String$startsWith, 'https://', str) ? A2(
		$elm$url$Url$chompAfterProtocol,
		$elm$url$Url$Https,
		A2($elm$core$String$dropLeft, 8, str)) : $elm$core$Maybe$Nothing);
};
var $elm$core$Basics$never = function (_v0) {
	never:
	while (true) {
		var nvr = _v0.a;
		var $temp$_v0 = nvr;
		_v0 = $temp$_v0;
		continue never;
	}
};
var $elm$core$Task$Perform = function (a) {
	return {$: 'Perform', a: a};
};
var $elm$core$Task$succeed = _Scheduler_succeed;
var $elm$core$Task$init = $elm$core$Task$succeed(_Utils_Tuple0);
var $elm$core$List$foldrHelper = F4(
	function (fn, acc, ctr, ls) {
		if (!ls.b) {
			return acc;
		} else {
			var a = ls.a;
			var r1 = ls.b;
			if (!r1.b) {
				return A2(fn, a, acc);
			} else {
				var b = r1.a;
				var r2 = r1.b;
				if (!r2.b) {
					return A2(
						fn,
						a,
						A2(fn, b, acc));
				} else {
					var c = r2.a;
					var r3 = r2.b;
					if (!r3.b) {
						return A2(
							fn,
							a,
							A2(
								fn,
								b,
								A2(fn, c, acc)));
					} else {
						var d = r3.a;
						var r4 = r3.b;
						var res = (ctr > 500) ? A3(
							$elm$core$List$foldl,
							fn,
							acc,
							$elm$core$List$reverse(r4)) : A4($elm$core$List$foldrHelper, fn, acc, ctr + 1, r4);
						return A2(
							fn,
							a,
							A2(
								fn,
								b,
								A2(
									fn,
									c,
									A2(fn, d, res))));
					}
				}
			}
		}
	});
var $elm$core$List$foldr = F3(
	function (fn, acc, ls) {
		return A4($elm$core$List$foldrHelper, fn, acc, 0, ls);
	});
var $elm$core$List$map = F2(
	function (f, xs) {
		return A3(
			$elm$core$List$foldr,
			F2(
				function (x, acc) {
					return A2(
						$elm$core$List$cons,
						f(x),
						acc);
				}),
			_List_Nil,
			xs);
	});
var $elm$core$Task$andThen = _Scheduler_andThen;
var $elm$core$Task$map = F2(
	function (func, taskA) {
		return A2(
			$elm$core$Task$andThen,
			function (a) {
				return $elm$core$Task$succeed(
					func(a));
			},
			taskA);
	});
var $elm$core$Task$map2 = F3(
	function (func, taskA, taskB) {
		return A2(
			$elm$core$Task$andThen,
			function (a) {
				return A2(
					$elm$core$Task$andThen,
					function (b) {
						return $elm$core$Task$succeed(
							A2(func, a, b));
					},
					taskB);
			},
			taskA);
	});
var $elm$core$Task$sequence = function (tasks) {
	return A3(
		$elm$core$List$foldr,
		$elm$core$Task$map2($elm$core$List$cons),
		$elm$core$Task$succeed(_List_Nil),
		tasks);
};
var $elm$core$Platform$sendToApp = _Platform_sendToApp;
var $elm$core$Task$spawnCmd = F2(
	function (router, _v0) {
		var task = _v0.a;
		return _Scheduler_spawn(
			A2(
				$elm$core$Task$andThen,
				$elm$core$Platform$sendToApp(router),
				task));
	});
var $elm$core$Task$onEffects = F3(
	function (router, commands, state) {
		return A2(
			$elm$core$Task$map,
			function (_v0) {
				return _Utils_Tuple0;
			},
			$elm$core$Task$sequence(
				A2(
					$elm$core$List$map,
					$elm$core$Task$spawnCmd(router),
					commands)));
	});
var $elm$core$Task$onSelfMsg = F3(
	function (_v0, _v1, _v2) {
		return $elm$core$Task$succeed(_Utils_Tuple0);
	});
var $elm$core$Task$cmdMap = F2(
	function (tagger, _v0) {
		var task = _v0.a;
		return $elm$core$Task$Perform(
			A2($elm$core$Task$map, tagger, task));
	});
_Platform_effectManagers['Task'] = _Platform_createManager($elm$core$Task$init, $elm$core$Task$onEffects, $elm$core$Task$onSelfMsg, $elm$core$Task$cmdMap);
var $elm$core$Task$command = _Platform_leaf('Task');
var $elm$core$Task$perform = F2(
	function (toMessage, task) {
		return $elm$core$Task$command(
			$elm$core$Task$Perform(
				A2($elm$core$Task$map, toMessage, task)));
	});
var $elm$browser$Browser$application = _Browser_application;
var $elm$core$Basics$composeL = F3(
	function (g, f, x) {
		return g(
			f(x));
	});
var $elm$core$Basics$not = _Basics_not;
var $MacCASOutreach$graphicsvg$GraphicSVG$convertCoords = F2(
	function (_v0, gModel) {
		var x = _v0.a;
		var y = _v0.b;
		var sw = gModel.sw;
		var sh = gModel.sh;
		var cw = gModel.cw;
		var ch = gModel.ch;
		var aspectout = (!(!sh)) ? (sw / sh) : (4 / 3);
		var aspectin = (!(!ch)) ? (cw / ch) : (4 / 3);
		var scaledInX = _Utils_cmp(aspectout, aspectin) < 0;
		var scaledInY = _Utils_cmp(aspectout, aspectin) > 0;
		var cscale = scaledInX ? (sw / cw) : (scaledInY ? (sh / ch) : 1);
		return _Utils_Tuple2((x - (sw / 2)) / cscale, (y + (sh / 2)) / cscale);
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$NoOp = {$: 'NoOp'};
var $MacCASOutreach$graphicsvg$GraphicSVG$WindowResize = function (a) {
	return {$: 'WindowResize', a: a};
};
var $elm$core$Task$onError = _Scheduler_onError;
var $elm$core$Task$attempt = F2(
	function (resultToMessage, task) {
		return $elm$core$Task$command(
			$elm$core$Task$Perform(
				A2(
					$elm$core$Task$onError,
					A2(
						$elm$core$Basics$composeL,
						A2($elm$core$Basics$composeL, $elm$core$Task$succeed, resultToMessage),
						$elm$core$Result$Err),
					A2(
						$elm$core$Task$andThen,
						A2(
							$elm$core$Basics$composeL,
							A2($elm$core$Basics$composeL, $elm$core$Task$succeed, resultToMessage),
							$elm$core$Result$Ok),
						task))));
	});
var $elm$browser$Browser$Dom$getViewportOf = _Browser_getViewportOf;
var $elm$core$Basics$round = _Basics_round;
var $MacCASOutreach$graphicsvg$GraphicSVG$getViewportSize = A2(
	$elm$core$Task$attempt,
	function (rvp) {
		if (rvp.$ === 'Ok') {
			var vp = rvp.a;
			return $MacCASOutreach$graphicsvg$GraphicSVG$WindowResize(
				$elm$core$Maybe$Just(
					_Utils_Tuple2(
						$elm$core$Basics$round(vp.viewport.width),
						$elm$core$Basics$round(vp.viewport.height))));
		} else {
			return $MacCASOutreach$graphicsvg$GraphicSVG$NoOp;
		}
	},
	$elm$browser$Browser$Dom$getViewportOf('render'));
var $elm$core$Platform$Cmd$map = _Platform_map;
var $elm$core$Platform$Cmd$batch = _Platform_batch;
var $elm$core$Platform$Cmd$none = $elm$core$Platform$Cmd$batch(_List_Nil);
var $MacCASOutreach$graphicsvg$GraphicSVG$hiddenAppUpdate = F4(
	function (userView, userUpdate, msg, _v0) {
		var userModel = _v0.a;
		var gModel = _v0.b;
		var mapUserCmd = function (cmd) {
			return A2($elm$core$Platform$Cmd$map, $MacCASOutreach$graphicsvg$GraphicSVG$Graphics, cmd);
		};
		var _v1 = userView(userModel).body;
		var cw = _v1.a;
		var ch = _v1.b;
		switch (msg.$) {
			case 'Graphics':
				var message = msg.a;
				var _v3 = A2(userUpdate, message, userModel);
				var newModel = _v3.a;
				var userCmds = _v3.b;
				return _Utils_Tuple2(
					_Utils_Tuple2(
						newModel,
						_Utils_update(
							gModel,
							{ch: ch, cw: cw})),
					mapUserCmd(userCmds));
			case 'WindowResize':
				var mWH = msg.a;
				if (mWH.$ === 'Just') {
					var _v5 = mWH.a;
					var w = _v5.a;
					var h = _v5.b;
					return _Utils_Tuple2(
						_Utils_Tuple2(
							userModel,
							_Utils_update(
								gModel,
								{sh: h, sw: w})),
						$elm$core$Platform$Cmd$none);
				} else {
					return _Utils_Tuple2(
						_Utils_Tuple2(userModel, gModel),
						$MacCASOutreach$graphicsvg$GraphicSVG$getViewportSize);
				}
			case 'ReturnPosition':
				var message = msg.a;
				var _v6 = msg.b;
				var x = _v6.a;
				var y = _v6.b;
				var _v7 = A2(
					userUpdate,
					message(
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$convertCoords,
							_Utils_Tuple2(x, y),
							gModel)),
					userModel);
				var newModel = _v7.a;
				var userCmds = _v7.b;
				return _Utils_Tuple2(
					_Utils_Tuple2(newModel, gModel),
					mapUserCmd(userCmds));
			default:
				return _Utils_Tuple2(
					_Utils_Tuple2(userModel, gModel),
					$elm$core$Platform$Cmd$none);
		}
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$ReturnPosition = F2(
	function (a, b) {
		return {$: 'ReturnPosition', a: a, b: b};
	});
var $elm$svg$Svg$trustedNode = _VirtualDom_nodeNS('http://www.w3.org/2000/svg');
var $elm$svg$Svg$clipPath = $elm$svg$Svg$trustedNode('clipPath');
var $elm$svg$Svg$defs = $elm$svg$Svg$trustedNode('defs');
var $elm$core$String$fromFloat = _String_fromNumber;
var $elm$svg$Svg$Attributes$height = _VirtualDom_attribute('height');
var $elm$svg$Svg$Attributes$id = _VirtualDom_attribute('id');
var $elm$core$Basics$negate = function (n) {
	return -n;
};
var $elm$svg$Svg$rect = $elm$svg$Svg$trustedNode('rect');
var $elm$svg$Svg$Attributes$width = _VirtualDom_attribute('width');
var $elm$svg$Svg$Attributes$x = _VirtualDom_attribute('x');
var $elm$svg$Svg$Attributes$y = _VirtualDom_attribute('y');
var $MacCASOutreach$graphicsvg$GraphicSVG$cPath = F2(
	function (w, h) {
		return A2(
			$elm$svg$Svg$defs,
			_List_Nil,
			_List_fromArray(
				[
					A2(
					$elm$svg$Svg$clipPath,
					_List_fromArray(
						[
							$elm$svg$Svg$Attributes$id('cPath')
						]),
					_List_fromArray(
						[
							A2(
							$elm$svg$Svg$rect,
							_List_fromArray(
								[
									$elm$svg$Svg$Attributes$width(
									$elm$core$String$fromFloat(w)),
									$elm$svg$Svg$Attributes$height(
									$elm$core$String$fromFloat(h)),
									$elm$svg$Svg$Attributes$x(
									$elm$core$String$fromFloat((-w) / 2)),
									$elm$svg$Svg$Attributes$y(
									$elm$core$String$fromFloat((-h) / 2))
								]),
							_List_Nil)
						]))
				]));
	});
var $elm$svg$Svg$Attributes$clipPath = _VirtualDom_attribute('clip-path');
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Everything = {$: 'Everything'};
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Group = function (a) {
	return {$: 'Group', a: a};
};
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Notathing = {$: 'Notathing'};
var $elm$svg$Svg$a = $elm$svg$Svg$trustedNode('a');
var $elm$core$List$any = F2(
	function (isOkay, list) {
		any:
		while (true) {
			if (!list.b) {
				return false;
			} else {
				var x = list.a;
				var xs = list.b;
				if (isOkay(x)) {
					return true;
				} else {
					var $temp$isOkay = isOkay,
						$temp$list = xs;
					isOkay = $temp$isOkay;
					list = $temp$list;
					continue any;
				}
			}
		}
	});
var $elm$core$List$all = F2(
	function (isOkay, list) {
		return !A2(
			$elm$core$List$any,
			A2($elm$core$Basics$composeL, $elm$core$Basics$not, isOkay),
			list);
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Solid = function (a) {
	return {$: 'Solid', a: a};
};
var $avh4$elm_color$Color$RgbaSpace = F4(
	function (a, b, c, d) {
		return {$: 'RgbaSpace', a: a, b: b, c: c, d: d};
	});
var $avh4$elm_color$Color$fromRgba = function (components) {
	return A4($avh4$elm_color$Color$RgbaSpace, components.red, components.green, components.blue, components.alpha);
};
var $elm$core$Basics$clamp = F3(
	function (low, high, number) {
		return (_Utils_cmp(number, low) < 0) ? low : ((_Utils_cmp(number, high) > 0) ? high : number);
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$ssa = function (n) {
	return A3($elm$core$Basics$clamp, 0, 1, n);
};
var $MacCASOutreach$graphicsvg$GraphicSVG$ssc = function (n) {
	return A3($elm$core$Basics$clamp, 0, 255, n);
};
var $MacCASOutreach$graphicsvg$GraphicSVG$rgba = F4(
	function (r, g, b, a) {
		return $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Solid(
			$avh4$elm_color$Color$fromRgba(
				{
					alpha: $MacCASOutreach$graphicsvg$GraphicSVG$ssa(a),
					blue: $MacCASOutreach$graphicsvg$GraphicSVG$ssc(b),
					green: $MacCASOutreach$graphicsvg$GraphicSVG$ssc(g),
					red: $MacCASOutreach$graphicsvg$GraphicSVG$ssc(r)
				}));
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$black = A4($MacCASOutreach$graphicsvg$GraphicSVG$rgba, 0, 0, 0, 1);
var $elm$svg$Svg$circle = $elm$svg$Svg$trustedNode('circle');
var $elm$core$Basics$composeR = F3(
	function (f, g, x) {
		return g(
			f(x));
	});
var $elm$core$String$concat = function (strings) {
	return A2($elm$core$String$join, '', strings);
};
var $elm$json$Json$Encode$bool = _Json_wrap;
var $elm$html$Html$Attributes$boolProperty = F2(
	function (key, bool) {
		return A2(
			_VirtualDom_property,
			key,
			$elm$json$Json$Encode$bool(bool));
	});
var $elm$html$Html$Attributes$contenteditable = $elm$html$Html$Attributes$boolProperty('contentEditable');
var $MacCASOutreach$graphicsvg$GraphicSVG$pairToString = function (_v0) {
	var x = _v0.a;
	var y = _v0.b;
	return $elm$core$String$fromFloat(x) + (',' + $elm$core$String$fromFloat(y));
};
var $MacCASOutreach$graphicsvg$GraphicSVG$bezierStringHelper = function (_v0) {
	var _v1 = _v0.a;
	var a = _v1.a;
	var b = _v1.b;
	var _v2 = _v0.b;
	var c = _v2.a;
	var d = _v2.b;
	return ' Q ' + ($MacCASOutreach$graphicsvg$GraphicSVG$pairToString(
		_Utils_Tuple2(a, b)) + (' ' + $MacCASOutreach$graphicsvg$GraphicSVG$pairToString(
		_Utils_Tuple2(c, d))));
};
var $MacCASOutreach$graphicsvg$GraphicSVG$createBezierString = F2(
	function (first, list) {
		return 'M ' + ($MacCASOutreach$graphicsvg$GraphicSVG$pairToString(first) + $elm$core$String$concat(
			A2($elm$core$List$map, $MacCASOutreach$graphicsvg$GraphicSVG$bezierStringHelper, list)));
	});
var $elm$svg$Svg$Attributes$cx = _VirtualDom_attribute('cx');
var $elm$svg$Svg$Attributes$cy = _VirtualDom_attribute('cy');
var $elm$svg$Svg$Attributes$fill = _VirtualDom_attribute('fill');
var $elm$svg$Svg$g = $elm$svg$Svg$trustedNode('g');
var $elm$svg$Svg$Attributes$gradientTransform = _VirtualDom_attribute('gradientTransform');
var $elm$svg$Svg$Attributes$gradientUnits = _VirtualDom_attribute('gradientUnits');
var $elm$core$List$head = function (list) {
	if (list.b) {
		var x = list.a;
		var xs = list.b;
		return $elm$core$Maybe$Just(x);
	} else {
		return $elm$core$Maybe$Nothing;
	}
};
var $elm$svg$Svg$linearGradient = $elm$svg$Svg$trustedNode('linearGradient');
var $elm$svg$Svg$Attributes$mask = _VirtualDom_attribute('mask');
var $avh4$elm_color$Color$toRgba = function (_v0) {
	var r = _v0.a;
	var g = _v0.b;
	var b = _v0.c;
	var a = _v0.d;
	return {alpha: a, blue: b, green: g, red: r};
};
var $MacCASOutreach$graphicsvg$GraphicSVG$mkRGB = function (colour) {
	var col = $avh4$elm_color$Color$toRgba(colour);
	return 'rgba(' + ($elm$core$String$fromFloat(col.red) + (',' + ($elm$core$String$fromFloat(col.green) + (',' + ($elm$core$String$fromFloat(col.blue) + (',' + ($elm$core$String$fromFloat(col.alpha) + ')')))))));
};
var $elm$svg$Svg$Attributes$offset = _VirtualDom_attribute('offset');
var $elm$core$Basics$pi = _Basics_pi;
var $elm$svg$Svg$Attributes$r = _VirtualDom_attribute('r');
var $elm$svg$Svg$radialGradient = $elm$svg$Svg$trustedNode('radialGradient');
var $elm$svg$Svg$stop = $elm$svg$Svg$trustedNode('stop');
var $elm$svg$Svg$Attributes$style = _VirtualDom_attribute('style');
var $elm$svg$Svg$Attributes$transform = _VirtualDom_attribute('transform');
var $MacCASOutreach$graphicsvg$GraphicSVG$createGradientSVG = F3(
	function (id, _v0, grad) {
		var wid = _v0.a;
		var hei = _v0.b;
		var w = function () {
			if (grad.$ === 'RadialGradient') {
				var stops = grad.a;
				var _v6 = $elm$core$List$head(
					$elm$core$List$reverse(stops));
				if (_v6.$ === 'Just') {
					var _v7 = _v6.a;
					var pos = _v7.a;
					return pos;
				} else {
					return 0;
				}
			} else {
				var stops = grad.b;
				var _v8 = $elm$core$List$head(
					$elm$core$List$reverse(stops));
				if (_v8.$ === 'Just') {
					var _v9 = _v8.a;
					var pos = _v9.a;
					return pos;
				} else {
					return 0;
				}
			}
		}();
		var squareSize = (_Utils_cmp(wid, hei) > 0) ? (2 * wid) : (2 * hei);
		var rotation = function () {
			if (grad.$ === 'LinearGradient') {
				var rot = grad.a;
				var stops = grad.b;
				return (rot * 180) / $elm$core$Basics$pi;
			} else {
				return 0;
			}
		}();
		var isRadial = function () {
			if (grad.$ === 'RadialGradient') {
				return true;
			} else {
				return false;
			}
		}();
		var createStop = function (_v2) {
			var pos = _v2.a;
			var trans = _v2.b;
			var colour = _v2.c;
			var start = isRadial ? 0 : (((1 - (w / squareSize)) / 2) * 100);
			var percent = isRadial ? ((pos / w) * 100) : (start + ((pos / squareSize) * 100));
			var percentTxt = $elm$core$String$fromFloat(percent) + '%';
			var opacityTxt = 'stop-opacity:' + ($elm$core$String$fromFloat(trans) + ';');
			var colourTxt = 'stop-color:' + ($MacCASOutreach$graphicsvg$GraphicSVG$mkRGB(colour) + ';');
			return A2(
				$elm$svg$Svg$stop,
				_List_fromArray(
					[
						$elm$svg$Svg$Attributes$offset(percentTxt),
						$elm$svg$Svg$Attributes$style(
						_Utils_ap(colourTxt, opacityTxt))
					]),
				_List_Nil);
		};
		var defs = A2(
			$elm$svg$Svg$defs,
			_List_Nil,
			_List_fromArray(
				[
					function () {
					if (grad.$ === 'LinearGradient') {
						var stops = grad.b;
						return A2(
							$elm$svg$Svg$linearGradient,
							_List_fromArray(
								[
									$elm$svg$Svg$Attributes$id(id + 'gradient'),
									$elm$svg$Svg$Attributes$gradientTransform(
									'rotate(' + ($elm$core$String$fromFloat(rotation) + 'rad)')),
									$elm$svg$Svg$Attributes$gradientTransform(
									'rotate(' + ($elm$core$String$fromFloat(rotation) + 'rad)'))
								]),
							A2($elm$core$List$map, createStop, stops));
					} else {
						var stops = grad.a;
						return A2(
							$elm$svg$Svg$radialGradient,
							_List_fromArray(
								[
									$elm$svg$Svg$Attributes$id(id + 'gradient'),
									$elm$svg$Svg$Attributes$cx('0'),
									$elm$svg$Svg$Attributes$cy('0'),
									$elm$svg$Svg$Attributes$r(
									$elm$core$String$fromFloat(w)),
									$elm$svg$Svg$Attributes$gradientUnits('userSpaceOnUse')
								]),
							A2($elm$core$List$map, createStop, stops));
					}
				}()
				]));
		return A2(
			$elm$svg$Svg$g,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$mask('url(#' + (id + 'mask)'))
				]),
			_List_fromArray(
				[
					defs,
					A2(
					$elm$svg$Svg$rect,
					_List_fromArray(
						[
							$elm$svg$Svg$Attributes$x(
							$elm$core$String$fromFloat((-squareSize) / 2)),
							$elm$svg$Svg$Attributes$y(
							$elm$core$String$fromFloat((-squareSize) / 2)),
							$elm$svg$Svg$Attributes$width(
							$elm$core$String$fromFloat(squareSize)),
							$elm$svg$Svg$Attributes$height(
							$elm$core$String$fromFloat(squareSize)),
							$elm$svg$Svg$Attributes$fill('url(#' + (id + 'gradient)')),
							$elm$svg$Svg$Attributes$id(id + 'grad'),
							$elm$svg$Svg$Attributes$transform(
							'rotate(' + ($elm$core$String$fromFloat(rotation) + ')'))
						]),
					_List_Nil)
				]));
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Inked = F3(
	function (a, b, c) {
		return {$: 'Inked', a: a, b: b, c: c};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$filled = F2(
	function (color, stencil) {
		return A3(
			$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Inked,
			$elm$core$Maybe$Just(color),
			$elm$core$Maybe$Nothing,
			stencil);
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Move = F2(
	function (a, b) {
		return {$: 'Move', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$move = F2(
	function (disp, shape) {
		return A2($MacCASOutreach$graphicsvg$GraphicSVG$Secret$Move, disp, shape);
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Rect = F2(
	function (a, b) {
		return {$: 'Rect', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$rect = F2(
	function (w, h) {
		return A2($MacCASOutreach$graphicsvg$GraphicSVG$Secret$Rect, w, h);
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$createGraphX = F5(
	function (h, s, th, c, x) {
		return A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(x * s, 0),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				c,
				A2($MacCASOutreach$graphicsvg$GraphicSVG$rect, th, h)));
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$createGraphY = F5(
	function (w, s, th, c, y) {
		return A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(0, y * s),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				c,
				A2($MacCASOutreach$graphicsvg$GraphicSVG$rect, w, th)));
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$group = function (shapes) {
	return $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Group(shapes);
};
var $MacCASOutreach$graphicsvg$GraphicSVG$createGraph = F4(
	function (_v0, s, th, c) {
		var w = _v0.a;
		var h = _v0.b;
		var syi = $elm$core$Basics$ceiling(h / (s * 2));
		var ylisti = A2($elm$core$List$range, -syi, syi);
		var sxi = $elm$core$Basics$ceiling(w / (s * 2));
		var xlisti = A2($elm$core$List$range, -sxi, sxi);
		return $MacCASOutreach$graphicsvg$GraphicSVG$group(
			_Utils_ap(
				A2(
					$elm$core$List$map,
					A2(
						$elm$core$Basics$composeL,
						A4($MacCASOutreach$graphicsvg$GraphicSVG$createGraphX, h, s, th, c),
						$elm$core$Basics$toFloat),
					xlisti),
				A2(
					$elm$core$List$map,
					A2(
						$elm$core$Basics$composeL,
						A4($MacCASOutreach$graphicsvg$GraphicSVG$createGraphY, w, s, th, c),
						$elm$core$Basics$toFloat),
					ylisti)));
	});
var $elm$svg$Svg$Attributes$d = _VirtualDom_attribute('d');
var $elm$svg$Svg$ellipse = $elm$svg$Svg$trustedNode('ellipse');
var $elm$svg$Svg$Attributes$fillOpacity = _VirtualDom_attribute('fill-opacity');
var $elm$svg$Svg$Attributes$fontSize = _VirtualDom_attribute('font-size');
var $elm$svg$Svg$foreignObject = $elm$svg$Svg$trustedNode('foreignObject');
var $MacCASOutreach$graphicsvg$GraphicSVG$getAlpha = function (colour) {
	return $avh4$elm_color$Color$toRgba(colour).alpha;
};
var $MacCASOutreach$graphicsvg$GraphicSVG$ident = _Utils_Tuple2(
	_Utils_Tuple3(1, 0, 0),
	_Utils_Tuple3(0, 1, 0));
var $elm$core$List$intersperse = F2(
	function (sep, xs) {
		if (!xs.b) {
			return _List_Nil;
		} else {
			var hd = xs.a;
			var tl = xs.b;
			var step = F2(
				function (x, rest) {
					return A2(
						$elm$core$List$cons,
						sep,
						A2($elm$core$List$cons, x, rest));
				});
			var spersed = A3($elm$core$List$foldr, step, _List_Nil, tl);
			return A2($elm$core$List$cons, hd, spersed);
		}
	});
var $elm$core$List$isEmpty = function (xs) {
	if (!xs.b) {
		return true;
	} else {
		return false;
	}
};
var $elm$virtual_dom$VirtualDom$map = _VirtualDom_map;
var $elm$html$Html$map = $elm$virtual_dom$VirtualDom$map;
var $elm$svg$Svg$mask = $elm$svg$Svg$trustedNode('mask');
var $MacCASOutreach$graphicsvg$GraphicSVG$matrixMult = F2(
	function (_v0, _v3) {
		var _v1 = _v0.a;
		var a = _v1.a;
		var c = _v1.b;
		var e = _v1.c;
		var _v2 = _v0.b;
		var b = _v2.a;
		var d = _v2.b;
		var f = _v2.c;
		var _v4 = _v3.a;
		var a1 = _v4.a;
		var c1 = _v4.b;
		var e1 = _v4.c;
		var _v5 = _v3.b;
		var b1 = _v5.a;
		var d1 = _v5.b;
		var f1 = _v5.c;
		return _Utils_Tuple2(
			_Utils_Tuple3((a * a1) + (c * b1), (a * c1) + (c * d1), (e + (a * e1)) + (c * f1)),
			_Utils_Tuple3((b * a1) + (d * b1), (b * c1) + (d * d1), (f + (b * e1)) + (d * f1)));
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$mkAlpha = A2($elm$core$Basics$composeL, $elm$core$String$fromFloat, $MacCASOutreach$graphicsvg$GraphicSVG$getAlpha);
var $MacCASOutreach$graphicsvg$GraphicSVG$moveT = F2(
	function (_v0, _v1) {
		var u = _v0.a;
		var v = _v0.b;
		var _v2 = _v1.a;
		var a = _v2.a;
		var c = _v2.b;
		var tx = _v2.c;
		var _v3 = _v1.b;
		var b = _v3.a;
		var d = _v3.b;
		var ty = _v3.c;
		return _Utils_Tuple2(
			_Utils_Tuple3(a, c, (tx + (a * u)) + (c * v)),
			_Utils_Tuple3(b, d, (ty + (b * u)) + (d * v)));
	});
var $elm$virtual_dom$VirtualDom$Normal = function (a) {
	return {$: 'Normal', a: a};
};
var $elm$virtual_dom$VirtualDom$on = _VirtualDom_on;
var $elm$html$Html$Events$on = F2(
	function (event, decoder) {
		return A2(
			$elm$virtual_dom$VirtualDom$on,
			event,
			$elm$virtual_dom$VirtualDom$Normal(decoder));
	});
var $elm$html$Html$Events$onClick = function (msg) {
	return A2(
		$elm$html$Html$Events$on,
		'click',
		$elm$json$Json$Decode$succeed(msg));
};
var $elm$json$Json$Decode$field = _Json_decodeField;
var $MacCASOutreach$graphicsvg$GraphicSVG$flipY = function (_v0) {
	var x = _v0.a;
	var y = _v0.b;
	return _Utils_Tuple2(x, -y);
};
var $elm$json$Json$Decode$float = _Json_decodeFloat;
var $MacCASOutreach$graphicsvg$GraphicSVG$mousePosDecoder = A3(
	$elm$json$Json$Decode$map2,
	F2(
		function (x, y) {
			return $MacCASOutreach$graphicsvg$GraphicSVG$flipY(
				_Utils_Tuple2(x, y));
		}),
	A2($elm$json$Json$Decode$field, 'offsetX', $elm$json$Json$Decode$float),
	A2($elm$json$Json$Decode$field, 'offsetY', $elm$json$Json$Decode$float));
var $MacCASOutreach$graphicsvg$GraphicSVG$onEnterAt = function (msg) {
	return A2(
		$elm$html$Html$Events$on,
		'mouseover',
		A2($elm$json$Json$Decode$map, msg, $MacCASOutreach$graphicsvg$GraphicSVG$mousePosDecoder));
};
var $MacCASOutreach$graphicsvg$GraphicSVG$onLeaveAt = function (msg) {
	return A2(
		$elm$html$Html$Events$on,
		'mouseleave',
		A2($elm$json$Json$Decode$map, msg, $MacCASOutreach$graphicsvg$GraphicSVG$mousePosDecoder));
};
var $elm$html$Html$Events$onMouseDown = function (msg) {
	return A2(
		$elm$html$Html$Events$on,
		'mousedown',
		$elm$json$Json$Decode$succeed(msg));
};
var $MacCASOutreach$graphicsvg$GraphicSVG$onMouseDownAt = function (msg) {
	return A2(
		$elm$html$Html$Events$on,
		'mousedown',
		A2($elm$json$Json$Decode$map, msg, $MacCASOutreach$graphicsvg$GraphicSVG$mousePosDecoder));
};
var $elm$html$Html$Events$onMouseEnter = function (msg) {
	return A2(
		$elm$html$Html$Events$on,
		'mouseenter',
		$elm$json$Json$Decode$succeed(msg));
};
var $elm$html$Html$Events$onMouseLeave = function (msg) {
	return A2(
		$elm$html$Html$Events$on,
		'mouseleave',
		$elm$json$Json$Decode$succeed(msg));
};
var $elm$html$Html$Events$onMouseUp = function (msg) {
	return A2(
		$elm$html$Html$Events$on,
		'mouseup',
		$elm$json$Json$Decode$succeed(msg));
};
var $MacCASOutreach$graphicsvg$GraphicSVG$onMouseUpAt = function (msg) {
	return A2(
		$elm$html$Html$Events$on,
		'mouseup',
		A2($elm$json$Json$Decode$map, msg, $MacCASOutreach$graphicsvg$GraphicSVG$mousePosDecoder));
};
var $MacCASOutreach$graphicsvg$GraphicSVG$onMoveAt = function (msg) {
	return A2(
		$elm$html$Html$Events$on,
		'mousemove',
		A2($elm$json$Json$Decode$map, msg, $MacCASOutreach$graphicsvg$GraphicSVG$mousePosDecoder));
};
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$MousePtr = {$: 'MousePtr'};
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$PenPtr = {$: 'PenPtr'};
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$TouchPtr = {$: 'TouchPtr'};
var $MacCASOutreach$graphicsvg$GraphicSVG$myPtrType = function (deviceType) {
	switch (deviceType.$) {
		case 'MouseType':
			return $MacCASOutreach$graphicsvg$GraphicSVG$Secret$MousePtr;
		case 'TouchType':
			return $MacCASOutreach$graphicsvg$GraphicSVG$Secret$TouchPtr;
		default:
			return $MacCASOutreach$graphicsvg$GraphicSVG$Secret$PenPtr;
	}
};
var $elm$virtual_dom$VirtualDom$Custom = function (a) {
	return {$: 'Custom', a: a};
};
var $elm$html$Html$Events$custom = F2(
	function (event, decoder) {
		return A2(
			$elm$virtual_dom$VirtualDom$on,
			event,
			$elm$virtual_dom$VirtualDom$Custom(decoder));
	});
var $mpizenberg$elm_pointer_events$Html$Events$Extra$Pointer$Event = F5(
	function (pointerType, pointer, pointerId, isPrimary, contactDetails) {
		return {contactDetails: contactDetails, isPrimary: isPrimary, pointer: pointer, pointerId: pointerId, pointerType: pointerType};
	});
var $elm$json$Json$Decode$bool = _Json_decodeBool;
var $mpizenberg$elm_pointer_events$Html$Events$Extra$Pointer$ContactDetails = F5(
	function (width, height, pressure, tiltX, tiltY) {
		return {height: height, pressure: pressure, tiltX: tiltX, tiltY: tiltY, width: width};
	});
var $elm$json$Json$Decode$map5 = _Json_map5;
var $mpizenberg$elm_pointer_events$Html$Events$Extra$Pointer$contactDetailsDecoder = A6(
	$elm$json$Json$Decode$map5,
	$mpizenberg$elm_pointer_events$Html$Events$Extra$Pointer$ContactDetails,
	A2($elm$json$Json$Decode$field, 'width', $elm$json$Json$Decode$float),
	A2($elm$json$Json$Decode$field, 'height', $elm$json$Json$Decode$float),
	A2($elm$json$Json$Decode$field, 'pressure', $elm$json$Json$Decode$float),
	A2($elm$json$Json$Decode$field, 'tiltX', $elm$json$Json$Decode$float),
	A2($elm$json$Json$Decode$field, 'tiltY', $elm$json$Json$Decode$float));
var $mpizenberg$elm_pointer_events$Html$Events$Extra$Mouse$Event = F6(
	function (keys, button, clientPos, offsetPos, pagePos, screenPos) {
		return {button: button, clientPos: clientPos, keys: keys, offsetPos: offsetPos, pagePos: pagePos, screenPos: screenPos};
	});
var $mpizenberg$elm_pointer_events$Html$Events$Extra$Mouse$BackButton = {$: 'BackButton'};
var $mpizenberg$elm_pointer_events$Html$Events$Extra$Mouse$ErrorButton = {$: 'ErrorButton'};
var $mpizenberg$elm_pointer_events$Html$Events$Extra$Mouse$ForwardButton = {$: 'ForwardButton'};
var $mpizenberg$elm_pointer_events$Html$Events$Extra$Mouse$MainButton = {$: 'MainButton'};
var $mpizenberg$elm_pointer_events$Html$Events$Extra$Mouse$MiddleButton = {$: 'MiddleButton'};
var $mpizenberg$elm_pointer_events$Html$Events$Extra$Mouse$SecondButton = {$: 'SecondButton'};
var $mpizenberg$elm_pointer_events$Html$Events$Extra$Mouse$buttonFromId = function (id) {
	switch (id) {
		case 0:
			return $mpizenberg$elm_pointer_events$Html$Events$Extra$Mouse$MainButton;
		case 1:
			return $mpizenberg$elm_pointer_events$Html$Events$Extra$Mouse$MiddleButton;
		case 2:
			return $mpizenberg$elm_pointer_events$Html$Events$Extra$Mouse$SecondButton;
		case 3:
			return $mpizenberg$elm_pointer_events$Html$Events$Extra$Mouse$BackButton;
		case 4:
			return $mpizenberg$elm_pointer_events$Html$Events$Extra$Mouse$ForwardButton;
		default:
			return $mpizenberg$elm_pointer_events$Html$Events$Extra$Mouse$ErrorButton;
	}
};
var $elm$json$Json$Decode$int = _Json_decodeInt;
var $mpizenberg$elm_pointer_events$Html$Events$Extra$Mouse$buttonDecoder = A2(
	$elm$json$Json$Decode$map,
	$mpizenberg$elm_pointer_events$Html$Events$Extra$Mouse$buttonFromId,
	A2($elm$json$Json$Decode$field, 'button', $elm$json$Json$Decode$int));
var $mpizenberg$elm_pointer_events$Internal$Decode$clientPos = A3(
	$elm$json$Json$Decode$map2,
	F2(
		function (a, b) {
			return _Utils_Tuple2(a, b);
		}),
	A2($elm$json$Json$Decode$field, 'clientX', $elm$json$Json$Decode$float),
	A2($elm$json$Json$Decode$field, 'clientY', $elm$json$Json$Decode$float));
var $mpizenberg$elm_pointer_events$Internal$Decode$Keys = F4(
	function (alt, ctrl, meta, shift) {
		return {alt: alt, ctrl: ctrl, meta: meta, shift: shift};
	});
var $elm$json$Json$Decode$map4 = _Json_map4;
var $mpizenberg$elm_pointer_events$Internal$Decode$keys = A5(
	$elm$json$Json$Decode$map4,
	$mpizenberg$elm_pointer_events$Internal$Decode$Keys,
	A2($elm$json$Json$Decode$field, 'altKey', $elm$json$Json$Decode$bool),
	A2($elm$json$Json$Decode$field, 'ctrlKey', $elm$json$Json$Decode$bool),
	A2($elm$json$Json$Decode$field, 'metaKey', $elm$json$Json$Decode$bool),
	A2($elm$json$Json$Decode$field, 'shiftKey', $elm$json$Json$Decode$bool));
var $elm$json$Json$Decode$map6 = _Json_map6;
var $mpizenberg$elm_pointer_events$Internal$Decode$offsetPos = A3(
	$elm$json$Json$Decode$map2,
	F2(
		function (a, b) {
			return _Utils_Tuple2(a, b);
		}),
	A2($elm$json$Json$Decode$field, 'offsetX', $elm$json$Json$Decode$float),
	A2($elm$json$Json$Decode$field, 'offsetY', $elm$json$Json$Decode$float));
var $mpizenberg$elm_pointer_events$Internal$Decode$pagePos = A3(
	$elm$json$Json$Decode$map2,
	F2(
		function (a, b) {
			return _Utils_Tuple2(a, b);
		}),
	A2($elm$json$Json$Decode$field, 'pageX', $elm$json$Json$Decode$float),
	A2($elm$json$Json$Decode$field, 'pageY', $elm$json$Json$Decode$float));
var $mpizenberg$elm_pointer_events$Internal$Decode$screenPos = A3(
	$elm$json$Json$Decode$map2,
	F2(
		function (a, b) {
			return _Utils_Tuple2(a, b);
		}),
	A2($elm$json$Json$Decode$field, 'screenX', $elm$json$Json$Decode$float),
	A2($elm$json$Json$Decode$field, 'screenY', $elm$json$Json$Decode$float));
var $mpizenberg$elm_pointer_events$Html$Events$Extra$Mouse$eventDecoder = A7($elm$json$Json$Decode$map6, $mpizenberg$elm_pointer_events$Html$Events$Extra$Mouse$Event, $mpizenberg$elm_pointer_events$Internal$Decode$keys, $mpizenberg$elm_pointer_events$Html$Events$Extra$Mouse$buttonDecoder, $mpizenberg$elm_pointer_events$Internal$Decode$clientPos, $mpizenberg$elm_pointer_events$Internal$Decode$offsetPos, $mpizenberg$elm_pointer_events$Internal$Decode$pagePos, $mpizenberg$elm_pointer_events$Internal$Decode$screenPos);
var $elm$json$Json$Decode$string = _Json_decodeString;
var $mpizenberg$elm_pointer_events$Html$Events$Extra$Pointer$MouseType = {$: 'MouseType'};
var $mpizenberg$elm_pointer_events$Html$Events$Extra$Pointer$PenType = {$: 'PenType'};
var $mpizenberg$elm_pointer_events$Html$Events$Extra$Pointer$TouchType = {$: 'TouchType'};
var $mpizenberg$elm_pointer_events$Html$Events$Extra$Pointer$stringToPointerType = function (str) {
	switch (str) {
		case 'pen':
			return $mpizenberg$elm_pointer_events$Html$Events$Extra$Pointer$PenType;
		case 'touch':
			return $mpizenberg$elm_pointer_events$Html$Events$Extra$Pointer$TouchType;
		default:
			return $mpizenberg$elm_pointer_events$Html$Events$Extra$Pointer$MouseType;
	}
};
var $mpizenberg$elm_pointer_events$Html$Events$Extra$Pointer$pointerTypeDecoder = A2($elm$json$Json$Decode$map, $mpizenberg$elm_pointer_events$Html$Events$Extra$Pointer$stringToPointerType, $elm$json$Json$Decode$string);
var $mpizenberg$elm_pointer_events$Html$Events$Extra$Pointer$eventDecoder = A6(
	$elm$json$Json$Decode$map5,
	$mpizenberg$elm_pointer_events$Html$Events$Extra$Pointer$Event,
	A2($elm$json$Json$Decode$field, 'pointerType', $mpizenberg$elm_pointer_events$Html$Events$Extra$Pointer$pointerTypeDecoder),
	$mpizenberg$elm_pointer_events$Html$Events$Extra$Mouse$eventDecoder,
	A2($elm$json$Json$Decode$field, 'pointerId', $elm$json$Json$Decode$int),
	A2($elm$json$Json$Decode$field, 'isPrimary', $elm$json$Json$Decode$bool),
	$mpizenberg$elm_pointer_events$Html$Events$Extra$Pointer$contactDetailsDecoder);
var $mpizenberg$elm_pointer_events$Html$Events$Extra$Pointer$onWithOptions = F3(
	function (event, options, tag) {
		return A2(
			$elm$html$Html$Events$custom,
			event,
			A2(
				$elm$json$Json$Decode$map,
				function (ev) {
					return {
						message: tag(ev),
						preventDefault: options.preventDefault,
						stopPropagation: options.stopPropagation
					};
				},
				$mpizenberg$elm_pointer_events$Html$Events$Extra$Pointer$eventDecoder));
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$onPtrCancel = function (msg) {
	return A3(
		$mpizenberg$elm_pointer_events$Html$Events$Extra$Pointer$onWithOptions,
		'pointercancel',
		{preventDefault: true, stopPropagation: true},
		function (event) {
			return msg(
				$MacCASOutreach$graphicsvg$GraphicSVG$myPtrType(event.pointerType));
		});
};
var $MacCASOutreach$graphicsvg$GraphicSVG$onPtrEnd = function (msg) {
	return A3(
		$mpizenberg$elm_pointer_events$Html$Events$Extra$Pointer$onWithOptions,
		'pointerup',
		{preventDefault: true, stopPropagation: true},
		function (event) {
			return msg(
				$MacCASOutreach$graphicsvg$GraphicSVG$myPtrType(event.pointerType));
		});
};
var $MacCASOutreach$graphicsvg$GraphicSVG$onPtrMove = function (msg) {
	return A3(
		$mpizenberg$elm_pointer_events$Html$Events$Extra$Pointer$onWithOptions,
		'pointermove',
		{preventDefault: true, stopPropagation: true},
		function (event) {
			return A2(
				msg,
				$MacCASOutreach$graphicsvg$GraphicSVG$myPtrType(event.pointerType),
				$MacCASOutreach$graphicsvg$GraphicSVG$flipY(event.pointer.pagePos));
		});
};
var $MacCASOutreach$graphicsvg$GraphicSVG$onPtrStart = function (msg) {
	return A3(
		$mpizenberg$elm_pointer_events$Html$Events$Extra$Pointer$onWithOptions,
		'pointerdown',
		{preventDefault: true, stopPropagation: true},
		function (event) {
			return msg(
				$MacCASOutreach$graphicsvg$GraphicSVG$myPtrType(event.pointerType));
		});
};
var $MacCASOutreach$graphicsvg$GraphicSVG$onPtrStartAt = function (msg) {
	return A3(
		$mpizenberg$elm_pointer_events$Html$Events$Extra$Pointer$onWithOptions,
		'pointerdown',
		{preventDefault: true, stopPropagation: true},
		function (event) {
			return A2(
				msg,
				$MacCASOutreach$graphicsvg$GraphicSVG$myPtrType(event.pointerType),
				$MacCASOutreach$graphicsvg$GraphicSVG$flipY(event.pointer.pagePos));
		});
};
var $MacCASOutreach$graphicsvg$GraphicSVG$onTapAt = function (msg) {
	return A2(
		$elm$html$Html$Events$on,
		'click',
		A2($elm$json$Json$Decode$map, msg, $MacCASOutreach$graphicsvg$GraphicSVG$mousePosDecoder));
};
var $MacCASOutreach$graphicsvg$GraphicSVG$onTouchEnd = function (msg) {
	return A2(
		$elm$html$Html$Events$on,
		'touchend',
		$elm$json$Json$Decode$succeed(msg));
};
var $elm$virtual_dom$VirtualDom$MayPreventDefault = function (a) {
	return {$: 'MayPreventDefault', a: a};
};
var $elm$html$Html$Events$preventDefaultOn = F2(
	function (event, decoder) {
		return A2(
			$elm$virtual_dom$VirtualDom$on,
			event,
			$elm$virtual_dom$VirtualDom$MayPreventDefault(decoder));
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$TouchPos = F2(
	function (a, b) {
		return {$: 'TouchPos', a: a, b: b};
	});
var $elm$json$Json$Decode$at = F2(
	function (fields, decoder) {
		return A3($elm$core$List$foldr, $elm$json$Json$Decode$field, decoder, fields);
	});
var $elm$json$Json$Decode$oneOf = _Json_oneOf;
var $MacCASOutreach$graphicsvg$GraphicSVG$touchDecoder = $elm$json$Json$Decode$oneOf(
	_List_fromArray(
		[
			A2(
			$elm$json$Json$Decode$at,
			_List_fromArray(
				['touches', '0']),
			A3(
				$elm$json$Json$Decode$map2,
				$MacCASOutreach$graphicsvg$GraphicSVG$TouchPos,
				A2($elm$json$Json$Decode$field, 'pageX', $elm$json$Json$Decode$float),
				A2($elm$json$Json$Decode$field, 'pageY', $elm$json$Json$Decode$float))),
			A3(
			$elm$json$Json$Decode$map2,
			$MacCASOutreach$graphicsvg$GraphicSVG$TouchPos,
			A2($elm$json$Json$Decode$field, 'pageX', $elm$json$Json$Decode$float),
			A2($elm$json$Json$Decode$field, 'pageY', $elm$json$Json$Decode$float))
		]));
var $MacCASOutreach$graphicsvg$GraphicSVG$touchToPair = function (tp) {
	var x = tp.a;
	var y = tp.b;
	return $MacCASOutreach$graphicsvg$GraphicSVG$flipY(
		_Utils_Tuple2(x, y));
};
var $MacCASOutreach$graphicsvg$GraphicSVG$onTouchMove = function (msg) {
	return A2(
		$elm$html$Html$Events$preventDefaultOn,
		'touchmove',
		A2(
			$elm$json$Json$Decode$map,
			function (a) {
				return _Utils_Tuple2(
					A2($elm$core$Basics$composeL, msg, $MacCASOutreach$graphicsvg$GraphicSVG$touchToPair)(a),
					true);
			},
			$MacCASOutreach$graphicsvg$GraphicSVG$touchDecoder));
};
var $MacCASOutreach$graphicsvg$GraphicSVG$onTouchStart = function (msg) {
	return A2(
		$elm$html$Html$Events$on,
		'touchstart',
		$elm$json$Json$Decode$succeed(msg));
};
var $MacCASOutreach$graphicsvg$GraphicSVG$onTouchStartAt = function (msg) {
	return A2(
		$elm$html$Html$Events$on,
		'touchstart',
		A2(
			$elm$json$Json$Decode$map,
			A2($elm$core$Basics$composeL, msg, $MacCASOutreach$graphicsvg$GraphicSVG$touchToPair),
			$MacCASOutreach$graphicsvg$GraphicSVG$touchDecoder));
};
var $elm$svg$Svg$path = $elm$svg$Svg$trustedNode('path');
var $elm$svg$Svg$Attributes$points = _VirtualDom_attribute('points');
var $elm$svg$Svg$polygon = $elm$svg$Svg$trustedNode('polygon');
var $elm$svg$Svg$polyline = $elm$svg$Svg$trustedNode('polyline');
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$AlphaMask = F2(
	function (a, b) {
		return {$: 'AlphaMask', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Clip = F2(
	function (a, b) {
		return {$: 'Clip', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$EnterAt = F2(
	function (a, b) {
		return {$: 'EnterAt', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$EnterShape = F2(
	function (a, b) {
		return {$: 'EnterShape', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Exit = F2(
	function (a, b) {
		return {$: 'Exit', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$ExitAt = F2(
	function (a, b) {
		return {$: 'ExitAt', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$ForeignObject = F3(
	function (a, b, c) {
		return {$: 'ForeignObject', a: a, b: b, c: c};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$GraphPaper = F3(
	function (a, b, c) {
		return {$: 'GraphPaper', a: a, b: b, c: c};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$GroupOutline = function (a) {
	return {$: 'GroupOutline', a: a};
};
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Link = F2(
	function (a, b) {
		return {$: 'Link', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$MouseDown = F2(
	function (a, b) {
		return {$: 'MouseDown', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$MouseDownAt = F2(
	function (a, b) {
		return {$: 'MouseDownAt', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$MouseUp = F2(
	function (a, b) {
		return {$: 'MouseUp', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$MouseUpAt = F2(
	function (a, b) {
		return {$: 'MouseUpAt', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$MoveOverAt = F2(
	function (a, b) {
		return {$: 'MoveOverAt', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$PtrCancel = F2(
	function (a, b) {
		return {$: 'PtrCancel', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$PtrEnd = F2(
	function (a, b) {
		return {$: 'PtrEnd', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$PtrEndAt = F2(
	function (a, b) {
		return {$: 'PtrEndAt', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$PtrMoveAt = F2(
	function (a, b) {
		return {$: 'PtrMoveAt', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$PtrStart = F2(
	function (a, b) {
		return {$: 'PtrStart', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$PtrStartAt = F2(
	function (a, b) {
		return {$: 'PtrStartAt', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Rotate = F2(
	function (a, b) {
		return {$: 'Rotate', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Scale = F3(
	function (a, b, c) {
		return {$: 'Scale', a: a, b: b, c: c};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Skew = F3(
	function (a, b, c) {
		return {$: 'Skew', a: a, b: b, c: c};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Tap = F2(
	function (a, b) {
		return {$: 'Tap', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$TapAt = F2(
	function (a, b) {
		return {$: 'TapAt', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$TouchEnd = F2(
	function (a, b) {
		return {$: 'TouchEnd', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$TouchEndAt = F2(
	function (a, b) {
		return {$: 'TouchEndAt', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$TouchMoveAt = F2(
	function (a, b) {
		return {$: 'TouchMoveAt', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$TouchStart = F2(
	function (a, b) {
		return {$: 'TouchStart', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$TouchStartAt = F2(
	function (a, b) {
		return {$: 'TouchStartAt', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Transformed = F2(
	function (a, b) {
		return {$: 'Transformed', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$repaint = F2(
	function (color, shape) {
		switch (shape.$) {
			case 'Inked':
				if (shape.b.$ === 'Nothing') {
					var _v1 = shape.b;
					var st = shape.c;
					return A3(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Inked,
						$elm$core$Maybe$Just(color),
						$elm$core$Maybe$Nothing,
						st);
				} else {
					var _v2 = shape.b.a;
					var lt = _v2.a;
					var st = shape.c;
					return A3(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Inked,
						$elm$core$Maybe$Just(color),
						$elm$core$Maybe$Just(
							_Utils_Tuple2(lt, color)),
						st);
				}
			case 'Move':
				var s = shape.a;
				var sh = shape.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Move,
					s,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, color, sh));
			case 'Rotate':
				var r = shape.a;
				var sh = shape.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Rotate,
					r,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, color, sh));
			case 'Scale':
				var sx = shape.a;
				var sy = shape.b;
				var sh = shape.c;
				return A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Scale,
					sx,
					sy,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, color, sh));
			case 'Skew':
				var skx = shape.a;
				var sky = shape.b;
				var sh = shape.c;
				return A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Skew,
					skx,
					sky,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, color, sh));
			case 'Transformed':
				var tm = shape.a;
				var sh = shape.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Transformed,
					tm,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, color, sh));
			case 'Group':
				var shapes = shape.a;
				return $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Group(
					A2(
						$elm$core$List$map,
						$MacCASOutreach$graphicsvg$GraphicSVG$repaint(color),
						shapes));
			case 'GroupOutline':
				var cmbndshp = shape.a;
				return $MacCASOutreach$graphicsvg$GraphicSVG$Secret$GroupOutline(
					A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, color, cmbndshp));
			case 'Link':
				var s = shape.a;
				var sh = shape.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Link,
					s,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, color, sh));
			case 'AlphaMask':
				var reg = shape.a;
				var sh = shape.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$AlphaMask,
					reg,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, color, sh));
			case 'Clip':
				var reg = shape.a;
				var sh = shape.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Clip,
					reg,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, color, sh));
			case 'Tap':
				var userMsg = shape.a;
				var sh = shape.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Tap,
					userMsg,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, color, sh));
			case 'TapAt':
				var userMsg = shape.a;
				var sh = shape.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$TapAt,
					userMsg,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, color, sh));
			case 'EnterShape':
				var userMsg = shape.a;
				var sh = shape.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$EnterShape,
					userMsg,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, color, sh));
			case 'EnterAt':
				var userMsg = shape.a;
				var sh = shape.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$EnterAt,
					userMsg,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, color, sh));
			case 'Exit':
				var userMsg = shape.a;
				var sh = shape.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Exit,
					userMsg,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, color, sh));
			case 'ExitAt':
				var userMsg = shape.a;
				var sh = shape.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$ExitAt,
					userMsg,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, color, sh));
			case 'MouseDown':
				var userMsg = shape.a;
				var sh = shape.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$MouseDown,
					userMsg,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, color, sh));
			case 'MouseDownAt':
				var userMsg = shape.a;
				var sh = shape.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$MouseDownAt,
					userMsg,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, color, sh));
			case 'MouseUp':
				var userMsg = shape.a;
				var sh = shape.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$MouseUp,
					userMsg,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, color, sh));
			case 'MouseUpAt':
				var userMsg = shape.a;
				var sh = shape.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$MouseUpAt,
					userMsg,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, color, sh));
			case 'MoveOverAt':
				var userMsg = shape.a;
				var sh = shape.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$MoveOverAt,
					userMsg,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, color, sh));
			case 'TouchStart':
				var userMsg = shape.a;
				var sh = shape.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$TouchStart,
					userMsg,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, color, sh));
			case 'TouchEnd':
				var userMsg = shape.a;
				var sh = shape.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$TouchEnd,
					userMsg,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, color, sh));
			case 'TouchStartAt':
				var userMsg = shape.a;
				var sh = shape.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$TouchStartAt,
					userMsg,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, color, sh));
			case 'TouchEndAt':
				var userMsg = shape.a;
				var sh = shape.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$TouchEndAt,
					userMsg,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, color, sh));
			case 'TouchMoveAt':
				var userMsg = shape.a;
				var sh = shape.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$TouchMoveAt,
					userMsg,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, color, sh));
			case 'PtrStart':
				var userMsg = shape.a;
				var sh = shape.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$PtrStart,
					userMsg,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, color, sh));
			case 'PtrEnd':
				var userMsg = shape.a;
				var sh = shape.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$PtrEnd,
					userMsg,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, color, sh));
			case 'PtrCancel':
				var userMsg = shape.a;
				var sh = shape.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$PtrCancel,
					userMsg,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, color, sh));
			case 'PtrStartAt':
				var userMsg = shape.a;
				var sh = shape.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$PtrStartAt,
					userMsg,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, color, sh));
			case 'PtrEndAt':
				var userMsg = shape.a;
				var sh = shape.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$PtrEndAt,
					userMsg,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, color, sh));
			case 'PtrMoveAt':
				var userMsg = shape.a;
				var sh = shape.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$PtrMoveAt,
					userMsg,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, color, sh));
			case 'ForeignObject':
				var w = shape.a;
				var h = shape.b;
				var htm = shape.c;
				return A3($MacCASOutreach$graphicsvg$GraphicSVG$Secret$ForeignObject, w, h, htm);
			case 'Everything':
				return $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Everything;
			case 'Notathing':
				return $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Notathing;
			default:
				var s = shape.a;
				var th = shape.b;
				return A3($MacCASOutreach$graphicsvg$GraphicSVG$Secret$GraphPaper, s, th, color);
		}
	});
var $avh4$elm_color$Color$rgb = F3(
	function (r, g, b) {
		return A4($avh4$elm_color$Color$RgbaSpace, r, g, b, 1.0);
	});
var $elm$core$Basics$cos = _Basics_cos;
var $elm$core$Basics$sin = _Basics_sin;
var $MacCASOutreach$graphicsvg$GraphicSVG$rotateT = F2(
	function (rad, _v0) {
		var _v1 = _v0.a;
		var a = _v1.a;
		var c = _v1.b;
		var tx = _v1.c;
		var _v2 = _v0.b;
		var b = _v2.a;
		var d = _v2.b;
		var ty = _v2.c;
		var sinX = $elm$core$Basics$sin(rad);
		var cosX = $elm$core$Basics$cos(rad);
		return _Utils_Tuple2(
			_Utils_Tuple3((a * cosX) + (c * sinX), (c * cosX) - (a * sinX), tx),
			_Utils_Tuple3((b * cosX) + (d * sinX), (d * cosX) - (b * sinX), ty));
	});
var $elm$svg$Svg$Attributes$rx = _VirtualDom_attribute('rx');
var $elm$svg$Svg$Attributes$ry = _VirtualDom_attribute('ry');
var $MacCASOutreach$graphicsvg$GraphicSVG$scaleT = F3(
	function (sx, sy, _v0) {
		var _v1 = _v0.a;
		var a = _v1.a;
		var c = _v1.b;
		var tx = _v1.c;
		var _v2 = _v0.b;
		var b = _v2.a;
		var d = _v2.b;
		var ty = _v2.c;
		return _Utils_Tuple2(
			_Utils_Tuple3(a * sx, c * sy, tx),
			_Utils_Tuple3(b * sx, d * sy, ty));
	});
var $elm$core$Basics$tan = _Basics_tan;
var $MacCASOutreach$graphicsvg$GraphicSVG$skewT = F3(
	function (skx, sky, _v0) {
		var _v1 = _v0.a;
		var a = _v1.a;
		var c = _v1.b;
		var tx = _v1.c;
		var _v2 = _v0.b;
		var b = _v2.a;
		var d = _v2.b;
		var ty = _v2.c;
		var tanY = $elm$core$Basics$tan(-sky);
		var tanX = $elm$core$Basics$tan(-skx);
		return _Utils_Tuple2(
			_Utils_Tuple3(a + (c * tanY), c + (a * tanX), tx),
			_Utils_Tuple3(b + (d * tanY), d + (b * tanX), ty));
	});
var $elm$svg$Svg$Attributes$stroke = _VirtualDom_attribute('stroke');
var $elm$svg$Svg$Attributes$strokeDasharray = _VirtualDom_attribute('stroke-dasharray');
var $elm$svg$Svg$Attributes$strokeOpacity = _VirtualDom_attribute('stroke-opacity');
var $elm$svg$Svg$Attributes$strokeWidth = _VirtualDom_attribute('stroke-width');
var $elm$svg$Svg$Attributes$target = _VirtualDom_attribute('target');
var $elm$virtual_dom$VirtualDom$text = _VirtualDom_text;
var $elm$svg$Svg$text = $elm$virtual_dom$VirtualDom$text;
var $elm$svg$Svg$Attributes$textAnchor = _VirtualDom_attribute('text-anchor');
var $elm$svg$Svg$text_ = $elm$svg$Svg$trustedNode('text');
var $MacCASOutreach$graphicsvg$GraphicSVG$white = A4($MacCASOutreach$graphicsvg$GraphicSVG$rgba, 255, 255, 255, 1);
var $elm$svg$Svg$Attributes$xlinkHref = function (value) {
	return A3(
		_VirtualDom_attributeNS,
		'http://www.w3.org/1999/xlink',
		'xlink:href',
		_VirtualDom_noJavaScriptUri(value));
};
var $elm$svg$Svg$Attributes$xmlSpace = A2(_VirtualDom_attributeNS, 'http://www.w3.org/XML/1998/namespace', 'xml:space');
var $MacCASOutreach$graphicsvg$GraphicSVG$createSVG = F7(
	function (id, w, h, trans, msgWrapper, positionWrapper, shape) {
		createSVG:
		while (true) {
			var ptrWrapper = function (msg) {
				return A2($elm$core$Basics$composeR, msg, msgWrapper);
			};
			var ptrPosWrapper = function (msg) {
				return F2(
					function (ptr, pos) {
						return A2(
							positionWrapper,
							msg(ptr),
							pos);
					});
			};
			switch (shape.$) {
				case 'Inked':
					var fillClr = shape.a;
					var lt = shape.b;
					var stencil = shape.c;
					var strokeAttrs = function () {
						_v13$3:
						while (true) {
							if (lt.$ === 'Nothing') {
								return _List_Nil;
							} else {
								if (lt.a.b.$ === 'Solid') {
									switch (lt.a.a.$) {
										case 'Unbroken':
											var _v14 = lt.a;
											var th = _v14.a.a;
											var strokeClr = _v14.b.a;
											var nonStroke = function () {
												var opcty = $MacCASOutreach$graphicsvg$GraphicSVG$getAlpha(strokeClr);
												return (th <= 0) || (opcty <= 0);
											}();
											return nonStroke ? _List_Nil : _List_fromArray(
												[
													$elm$svg$Svg$Attributes$strokeWidth(
													$elm$core$String$fromFloat(th)),
													$elm$svg$Svg$Attributes$stroke(
													$MacCASOutreach$graphicsvg$GraphicSVG$mkRGB(strokeClr)),
													$elm$svg$Svg$Attributes$strokeOpacity(
													$MacCASOutreach$graphicsvg$GraphicSVG$mkAlpha(strokeClr))
												]);
										case 'Broken':
											var _v15 = lt.a;
											var _v16 = _v15.a;
											var dashes = _v16.a;
											var th = _v16.b;
											var strokeClr = _v15.b.a;
											var nonStroke = function () {
												var opcty = $MacCASOutreach$graphicsvg$GraphicSVG$getAlpha(strokeClr);
												return (th <= 0) || ((opcty <= 0) || A2(
													$elm$core$List$all,
													function (_v17) {
														var on = _v17.a;
														return !on;
													},
													dashes));
											}();
											return nonStroke ? _List_Nil : _Utils_ap(
												_List_fromArray(
													[
														$elm$svg$Svg$Attributes$strokeWidth(
														$elm$core$String$fromFloat(th)),
														$elm$svg$Svg$Attributes$stroke(
														$MacCASOutreach$graphicsvg$GraphicSVG$mkRGB(strokeClr)),
														$elm$svg$Svg$Attributes$strokeOpacity(
														$MacCASOutreach$graphicsvg$GraphicSVG$mkAlpha(strokeClr))
													]),
												_List_fromArray(
													[
														$elm$svg$Svg$Attributes$strokeDasharray(
														$elm$core$String$concat(
															A2(
																$elm$core$List$intersperse,
																',',
																A2($elm$core$List$map, $MacCASOutreach$graphicsvg$GraphicSVG$pairToString, dashes))))
													]));
										default:
											break _v13$3;
									}
								} else {
									break _v13$3;
								}
							}
						}
						var _v18 = lt.a;
						return _List_Nil;
					}();
					var nonexistBody = function () {
						if (fillClr.$ === 'Nothing') {
							return true;
						} else {
							return false;
						}
					}();
					var gradientDefs = function () {
						if ((fillClr.$ === 'Just') && (fillClr.a.$ === 'Gradient')) {
							var gr = fillClr.a.a;
							return $elm$core$Maybe$Just(
								A3(
									$MacCASOutreach$graphicsvg$GraphicSVG$createGradientSVG,
									id,
									_Utils_Tuple2(w, h),
									gr));
						} else {
							return $elm$core$Maybe$Nothing;
						}
					}();
					var clrAttrs = function () {
						if (fillClr.$ === 'Nothing') {
							return _List_fromArray(
								[
									$elm$svg$Svg$Attributes$fill('none')
								]);
						} else {
							if (fillClr.a.$ === 'Solid') {
								var bodyClr = fillClr.a.a;
								return _List_fromArray(
									[
										$elm$svg$Svg$Attributes$fill(
										$MacCASOutreach$graphicsvg$GraphicSVG$mkRGB(bodyClr)),
										$elm$svg$Svg$Attributes$fillOpacity(
										$MacCASOutreach$graphicsvg$GraphicSVG$mkAlpha(bodyClr))
									]);
							} else {
								return _List_fromArray(
									[
										$elm$svg$Svg$Attributes$id(id),
										$elm$svg$Svg$Attributes$fill(
										$MacCASOutreach$graphicsvg$GraphicSVG$mkRGB(
											A3($avh4$elm_color$Color$rgb, 255, 255, 255)))
									]);
							}
						}
					}();
					var _v1 = trans;
					var _v2 = _v1.a;
					var a = _v2.a;
					var c = _v2.b;
					var tx = _v2.c;
					var _v3 = _v1.b;
					var b = _v3.a;
					var d = _v3.b;
					var ty = _v3.c;
					var transAttrs = _List_fromArray(
						[
							$elm$svg$Svg$Attributes$transform(
							'matrix(' + ($elm$core$String$concat(
								A2(
									$elm$core$List$intersperse,
									',',
									A2(
										$elm$core$List$map,
										$elm$core$String$fromFloat,
										_List_fromArray(
											[a, -b, c, -d, tx, -ty])))) + ')'))
						]);
					var attrs = function () {
						if ((fillClr.$ === 'Just') && (fillClr.a.$ === 'Gradient')) {
							return _Utils_ap(clrAttrs, strokeAttrs);
						} else {
							return _Utils_ap(
								transAttrs,
								_Utils_ap(clrAttrs, strokeAttrs));
						}
					}();
					var basicShape = function () {
						switch (stencil.$) {
							case 'Circle':
								var r = stencil.a;
								return A2(
									$elm$svg$Svg$circle,
									_Utils_ap(
										_List_fromArray(
											[
												$elm$svg$Svg$Attributes$cx('0'),
												$elm$svg$Svg$Attributes$cy('0'),
												$elm$svg$Svg$Attributes$r(
												$elm$core$String$fromFloat(r))
											]),
										attrs),
									_List_Nil);
							case 'Rect':
								var rw = stencil.a;
								var rh = stencil.b;
								return A2(
									$elm$svg$Svg$rect,
									_Utils_ap(
										_List_fromArray(
											[
												$elm$svg$Svg$Attributes$x(
												$elm$core$String$fromFloat((-rw) / 2)),
												$elm$svg$Svg$Attributes$y(
												$elm$core$String$fromFloat((-rh) / 2)),
												$elm$svg$Svg$Attributes$width(
												$elm$core$String$fromFloat(rw)),
												$elm$svg$Svg$Attributes$height(
												$elm$core$String$fromFloat(rh))
											]),
										attrs),
									_List_Nil);
							case 'RoundRect':
								var rw = stencil.a;
								var rh = stencil.b;
								var r = stencil.c;
								return A2(
									$elm$svg$Svg$rect,
									_Utils_ap(
										_List_fromArray(
											[
												$elm$svg$Svg$Attributes$x(
												$elm$core$String$fromFloat((-rw) / 2)),
												$elm$svg$Svg$Attributes$y(
												$elm$core$String$fromFloat((-rh) / 2)),
												$elm$svg$Svg$Attributes$rx(
												$elm$core$String$fromFloat(r)),
												$elm$svg$Svg$Attributes$ry(
												$elm$core$String$fromFloat(r)),
												$elm$svg$Svg$Attributes$width(
												$elm$core$String$fromFloat(rw)),
												$elm$svg$Svg$Attributes$height(
												$elm$core$String$fromFloat(rh))
											]),
										attrs),
									_List_Nil);
							case 'Oval':
								var ow = stencil.a;
								var oh = stencil.b;
								return A2(
									$elm$svg$Svg$ellipse,
									_Utils_ap(
										_List_fromArray(
											[
												$elm$svg$Svg$Attributes$cx('0'),
												$elm$svg$Svg$Attributes$cy('0'),
												$elm$svg$Svg$Attributes$rx(
												$elm$core$String$fromFloat(0.5 * ow)),
												$elm$svg$Svg$Attributes$ry(
												$elm$core$String$fromFloat(0.5 * oh))
											]),
										attrs),
									_List_Nil);
							case 'Polygon':
								var vertices = stencil.a;
								return A2(
									$elm$svg$Svg$polygon,
									_Utils_ap(
										_List_fromArray(
											[
												$elm$svg$Svg$Attributes$points(
												$elm$core$String$concat(
													A2(
														$elm$core$List$intersperse,
														' ',
														A2($elm$core$List$map, $MacCASOutreach$graphicsvg$GraphicSVG$pairToString, vertices))))
											]),
										attrs),
									_List_Nil);
							case 'Path':
								var vertices = stencil.a;
								return A2(
									$elm$svg$Svg$polyline,
									_Utils_ap(
										_List_fromArray(
											[
												$elm$svg$Svg$Attributes$points(
												$elm$core$String$concat(
													A2(
														$elm$core$List$intersperse,
														' ',
														A2($elm$core$List$map, $MacCASOutreach$graphicsvg$GraphicSVG$pairToString, vertices))))
											]),
										attrs),
									_List_Nil);
							case 'BezierPath':
								var start = stencil.a;
								var pts = stencil.b;
								return A2(
									$elm$svg$Svg$path,
									_Utils_ap(
										_List_fromArray(
											[
												$elm$svg$Svg$Attributes$d(
												A2($MacCASOutreach$graphicsvg$GraphicSVG$createBezierString, start, pts))
											]),
										attrs),
									_List_Nil);
							default:
								var _v6 = stencil.a;
								var si = _v6.a;
								var bo = _v6.b;
								var i = _v6.c;
								var u = _v6.d;
								var s = _v6.e;
								var sel = _v6.f;
								var f = _v6.g;
								var align = _v6.h;
								var str = stencil.b;
								var txtDec = (u && s) ? 'text-decoration: underline line-through;' : (u ? 'text-decoration: underline;' : (s ? 'text-decoration: line-through;' : ''));
								var select = (!sel) ? '-webkit-touch-callout: none;\n-webkit-user-select: none;\n-khtml-user-select: none;\n-moz-user-select: none;\n-ms-user-select: none;\nuser-select: none;cursor: default;' : '';
								var it = i ? 'font-style: italic;' : '';
								var font = function () {
									switch (f.$) {
										case 'Sansserif':
											return 'sans-serif;';
										case 'Serif':
											return 'serif;';
										case 'FixedWidth':
											return 'monospace;';
										default:
											var fStr = f.a;
											return fStr + ';';
									}
								}();
								var bol = bo ? 'font-weight: bold;' : '';
								var sty = bol + (it + (txtDec + ('font-family: ' + (font + select))));
								var anchor = function () {
									switch (align.$) {
										case 'AlignCentred':
											return 'middle';
										case 'AlignLeft':
											return 'start';
										default:
											return 'end';
									}
								}();
								return A2(
									$elm$svg$Svg$text_,
									_Utils_ap(
										_List_fromArray(
											[
												$elm$svg$Svg$Attributes$x('0'),
												$elm$svg$Svg$Attributes$y('0'),
												$elm$svg$Svg$Attributes$style(sty),
												$elm$svg$Svg$Attributes$fontSize(
												$elm$core$String$fromFloat(si)),
												$elm$svg$Svg$Attributes$textAnchor(anchor),
												$elm$html$Html$Attributes$contenteditable(true)
											]),
										_Utils_ap(
											_List_fromArray(
												[
													$elm$svg$Svg$Attributes$transform(
													'matrix(' + ($elm$core$String$concat(
														A2(
															$elm$core$List$intersperse,
															',',
															A2(
																$elm$core$List$map,
																$elm$core$String$fromFloat,
																_List_fromArray(
																	[a, -b, -c, d, tx, -ty])))) + ')'))
												]),
											_Utils_ap(
												_List_fromArray(
													[
														$elm$svg$Svg$Attributes$xmlSpace('preserve')
													]),
												_Utils_ap(clrAttrs, strokeAttrs)))),
									_List_fromArray(
										[
											$elm$svg$Svg$text(str)
										]));
						}
					}();
					if (nonexistBody && $elm$core$List$isEmpty(strokeAttrs)) {
						return A2($elm$svg$Svg$g, _List_Nil, _List_Nil);
					} else {
						if (gradientDefs.$ === 'Just') {
							var gDefs = gradientDefs.a;
							return A2(
								$elm$svg$Svg$g,
								transAttrs,
								_List_fromArray(
									[
										A2(
										$elm$svg$Svg$mask,
										_List_fromArray(
											[
												$elm$svg$Svg$Attributes$id(id + 'mask')
											]),
										_List_fromArray(
											[basicShape])),
										gDefs
									]));
						} else {
							return basicShape;
						}
					}
				case 'ForeignObject':
					var fw = shape.a;
					var fh = shape.b;
					var htm = shape.c;
					var _v19 = trans;
					var _v20 = _v19.a;
					var a = _v20.a;
					var c = _v20.b;
					var tx = _v20.c;
					var _v21 = _v19.b;
					var b = _v21.a;
					var d = _v21.b;
					var ty = _v21.c;
					return A2(
						$elm$svg$Svg$foreignObject,
						_List_fromArray(
							[
								$elm$svg$Svg$Attributes$width(
								$elm$core$String$fromFloat(fw)),
								$elm$svg$Svg$Attributes$height(
								$elm$core$String$fromFloat(fh)),
								$elm$svg$Svg$Attributes$transform(
								'matrix(' + ($elm$core$String$concat(
									A2(
										$elm$core$List$intersperse,
										',',
										A2(
											$elm$core$List$map,
											$elm$core$String$fromFloat,
											_List_fromArray(
												[a, -b, -c, d, tx, -ty])))) + ')'))
							]),
						_List_fromArray(
							[
								A2($elm$html$Html$map, msgWrapper, htm)
							]));
				case 'Move':
					var v = shape.a;
					var sh = shape.b;
					var $temp$id = id,
						$temp$w = w,
						$temp$h = h,
						$temp$trans = A2($MacCASOutreach$graphicsvg$GraphicSVG$moveT, v, trans),
						$temp$msgWrapper = msgWrapper,
						$temp$positionWrapper = positionWrapper,
						$temp$shape = sh;
					id = $temp$id;
					w = $temp$w;
					h = $temp$h;
					trans = $temp$trans;
					msgWrapper = $temp$msgWrapper;
					positionWrapper = $temp$positionWrapper;
					shape = $temp$shape;
					continue createSVG;
				case 'Everything':
					var $temp$id = id,
						$temp$w = w,
						$temp$h = h,
						$temp$trans = $MacCASOutreach$graphicsvg$GraphicSVG$ident,
						$temp$msgWrapper = msgWrapper,
						$temp$positionWrapper = positionWrapper,
						$temp$shape = A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$filled,
						$MacCASOutreach$graphicsvg$GraphicSVG$white,
						A2($MacCASOutreach$graphicsvg$GraphicSVG$rect, w, h));
					id = $temp$id;
					w = $temp$w;
					h = $temp$h;
					trans = $temp$trans;
					msgWrapper = $temp$msgWrapper;
					positionWrapper = $temp$positionWrapper;
					shape = $temp$shape;
					continue createSVG;
				case 'Notathing':
					var $temp$id = id,
						$temp$w = w,
						$temp$h = h,
						$temp$trans = $MacCASOutreach$graphicsvg$GraphicSVG$ident,
						$temp$msgWrapper = msgWrapper,
						$temp$positionWrapper = positionWrapper,
						$temp$shape = A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$filled,
						$MacCASOutreach$graphicsvg$GraphicSVG$black,
						A2($MacCASOutreach$graphicsvg$GraphicSVG$rect, w, h));
					id = $temp$id;
					w = $temp$w;
					h = $temp$h;
					trans = $temp$trans;
					msgWrapper = $temp$msgWrapper;
					positionWrapper = $temp$positionWrapper;
					shape = $temp$shape;
					continue createSVG;
				case 'Rotate':
					var deg = shape.a;
					var sh = shape.b;
					var $temp$id = id,
						$temp$w = w,
						$temp$h = h,
						$temp$trans = A2($MacCASOutreach$graphicsvg$GraphicSVG$rotateT, deg, trans),
						$temp$msgWrapper = msgWrapper,
						$temp$positionWrapper = positionWrapper,
						$temp$shape = sh;
					id = $temp$id;
					w = $temp$w;
					h = $temp$h;
					trans = $temp$trans;
					msgWrapper = $temp$msgWrapper;
					positionWrapper = $temp$positionWrapper;
					shape = $temp$shape;
					continue createSVG;
				case 'Scale':
					var sx = shape.a;
					var sy = shape.b;
					var sh = shape.c;
					var $temp$id = id,
						$temp$w = w,
						$temp$h = h,
						$temp$trans = A3($MacCASOutreach$graphicsvg$GraphicSVG$scaleT, sx, sy, trans),
						$temp$msgWrapper = msgWrapper,
						$temp$positionWrapper = positionWrapper,
						$temp$shape = sh;
					id = $temp$id;
					w = $temp$w;
					h = $temp$h;
					trans = $temp$trans;
					msgWrapper = $temp$msgWrapper;
					positionWrapper = $temp$positionWrapper;
					shape = $temp$shape;
					continue createSVG;
				case 'Skew':
					var sx = shape.a;
					var sy = shape.b;
					var sh = shape.c;
					var $temp$id = id,
						$temp$w = w,
						$temp$h = h,
						$temp$trans = A3($MacCASOutreach$graphicsvg$GraphicSVG$skewT, sx, sy, trans),
						$temp$msgWrapper = msgWrapper,
						$temp$positionWrapper = positionWrapper,
						$temp$shape = sh;
					id = $temp$id;
					w = $temp$w;
					h = $temp$h;
					trans = $temp$trans;
					msgWrapper = $temp$msgWrapper;
					positionWrapper = $temp$positionWrapper;
					shape = $temp$shape;
					continue createSVG;
				case 'Transformed':
					var tm = shape.a;
					var sh = shape.b;
					var $temp$id = id,
						$temp$w = w,
						$temp$h = h,
						$temp$trans = A2($MacCASOutreach$graphicsvg$GraphicSVG$matrixMult, trans, tm),
						$temp$msgWrapper = msgWrapper,
						$temp$positionWrapper = positionWrapper,
						$temp$shape = sh;
					id = $temp$id;
					w = $temp$w;
					h = $temp$h;
					trans = $temp$trans;
					msgWrapper = $temp$msgWrapper;
					positionWrapper = $temp$positionWrapper;
					shape = $temp$shape;
					continue createSVG;
				case 'Link':
					var href = shape.a;
					var sh = shape.b;
					return A2(
						$elm$svg$Svg$a,
						_List_fromArray(
							[
								$elm$svg$Svg$Attributes$xlinkHref(href),
								$elm$svg$Svg$Attributes$target('_blank')
							]),
						_List_fromArray(
							[
								A7($MacCASOutreach$graphicsvg$GraphicSVG$createSVG, id, w, h, trans, msgWrapper, positionWrapper, sh)
							]));
				case 'AlphaMask':
					var region = shape.a;
					var sh = shape.b;
					return A2(
						$elm$svg$Svg$g,
						_List_Nil,
						_List_fromArray(
							[
								A2(
								$elm$svg$Svg$defs,
								_List_Nil,
								_List_fromArray(
									[
										A2(
										$elm$svg$Svg$mask,
										_List_fromArray(
											[
												$elm$svg$Svg$Attributes$id('m' + id)
											]),
										_List_fromArray(
											[
												A7(
												$MacCASOutreach$graphicsvg$GraphicSVG$createSVG,
												id + 'm',
												w,
												h,
												trans,
												msgWrapper,
												positionWrapper,
												$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Group(
													_List_fromArray(
														[
															$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Everything,
															A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, $MacCASOutreach$graphicsvg$GraphicSVG$black, region)
														])))
											]))
									])),
								A2(
								$elm$svg$Svg$g,
								_List_fromArray(
									[
										$elm$svg$Svg$Attributes$mask('url(#m' + (id + ')'))
									]),
								_List_fromArray(
									[
										A7($MacCASOutreach$graphicsvg$GraphicSVG$createSVG, id + 'mm', w, h, trans, msgWrapper, positionWrapper, sh)
									]))
							]));
				case 'Clip':
					var region = shape.a;
					var sh = shape.b;
					return A2(
						$elm$svg$Svg$g,
						_List_Nil,
						_List_fromArray(
							[
								A2(
								$elm$svg$Svg$defs,
								_List_Nil,
								_List_fromArray(
									[
										A2(
										$elm$svg$Svg$mask,
										_List_fromArray(
											[
												$elm$svg$Svg$Attributes$id('c' + id)
											]),
										_List_fromArray(
											[
												A7(
												$MacCASOutreach$graphicsvg$GraphicSVG$createSVG,
												id + 'c',
												w,
												h,
												trans,
												msgWrapper,
												positionWrapper,
												$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Group(
													_List_fromArray(
														[
															$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Notathing,
															A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, $MacCASOutreach$graphicsvg$GraphicSVG$white, region)
														])))
											]))
									])),
								A2(
								$elm$svg$Svg$g,
								_List_fromArray(
									[
										$elm$svg$Svg$Attributes$mask('url(#c' + (id + ')'))
									]),
								_List_fromArray(
									[
										A7($MacCASOutreach$graphicsvg$GraphicSVG$createSVG, id + 'cc', w, h, trans, msgWrapper, positionWrapper, sh)
									]))
							]));
				case 'Tap':
					var msg = shape.a;
					var sh = shape.b;
					return A2(
						$elm$svg$Svg$g,
						_List_fromArray(
							[
								$elm$html$Html$Events$onClick(
								msgWrapper(msg))
							]),
						_List_fromArray(
							[
								A7($MacCASOutreach$graphicsvg$GraphicSVG$createSVG, id, w, h, trans, msgWrapper, positionWrapper, sh)
							]));
				case 'TapAt':
					var msg = shape.a;
					var sh = shape.b;
					return A2(
						$elm$svg$Svg$g,
						_List_fromArray(
							[
								$MacCASOutreach$graphicsvg$GraphicSVG$onTapAt(
								positionWrapper(msg))
							]),
						_List_fromArray(
							[
								A7($MacCASOutreach$graphicsvg$GraphicSVG$createSVG, id, w, h, trans, msgWrapper, positionWrapper, sh)
							]));
				case 'EnterShape':
					var msg = shape.a;
					var sh = shape.b;
					return A2(
						$elm$svg$Svg$g,
						_List_fromArray(
							[
								$elm$html$Html$Events$onMouseEnter(
								msgWrapper(msg))
							]),
						_List_fromArray(
							[
								A7($MacCASOutreach$graphicsvg$GraphicSVG$createSVG, id, w, h, trans, msgWrapper, positionWrapper, sh)
							]));
				case 'EnterAt':
					var msg = shape.a;
					var sh = shape.b;
					return A2(
						$elm$svg$Svg$g,
						_List_fromArray(
							[
								$MacCASOutreach$graphicsvg$GraphicSVG$onEnterAt(
								positionWrapper(msg))
							]),
						_List_fromArray(
							[
								A7($MacCASOutreach$graphicsvg$GraphicSVG$createSVG, id, w, h, trans, msgWrapper, positionWrapper, sh)
							]));
				case 'Exit':
					var msg = shape.a;
					var sh = shape.b;
					return A2(
						$elm$svg$Svg$g,
						_List_fromArray(
							[
								$elm$html$Html$Events$onMouseLeave(
								msgWrapper(msg))
							]),
						_List_fromArray(
							[
								A7($MacCASOutreach$graphicsvg$GraphicSVG$createSVG, id, w, h, trans, msgWrapper, positionWrapper, sh)
							]));
				case 'ExitAt':
					var msg = shape.a;
					var sh = shape.b;
					return A2(
						$elm$svg$Svg$g,
						_List_fromArray(
							[
								$MacCASOutreach$graphicsvg$GraphicSVG$onLeaveAt(
								positionWrapper(msg))
							]),
						_List_fromArray(
							[
								A7($MacCASOutreach$graphicsvg$GraphicSVG$createSVG, id, w, h, trans, msgWrapper, positionWrapper, sh)
							]));
				case 'MouseDown':
					var msg = shape.a;
					var sh = shape.b;
					return A2(
						$elm$svg$Svg$g,
						_List_fromArray(
							[
								$elm$html$Html$Events$onMouseDown(
								msgWrapper(msg))
							]),
						_List_fromArray(
							[
								A7($MacCASOutreach$graphicsvg$GraphicSVG$createSVG, id, w, h, trans, msgWrapper, positionWrapper, sh)
							]));
				case 'MouseDownAt':
					var msg = shape.a;
					var sh = shape.b;
					return A2(
						$elm$svg$Svg$g,
						_List_fromArray(
							[
								$MacCASOutreach$graphicsvg$GraphicSVG$onMouseDownAt(
								positionWrapper(msg))
							]),
						_List_fromArray(
							[
								A7($MacCASOutreach$graphicsvg$GraphicSVG$createSVG, id, w, h, trans, msgWrapper, positionWrapper, sh)
							]));
				case 'MouseUp':
					var msg = shape.a;
					var sh = shape.b;
					return A2(
						$elm$svg$Svg$g,
						_List_fromArray(
							[
								$elm$html$Html$Events$onMouseUp(
								msgWrapper(msg))
							]),
						_List_fromArray(
							[
								A7($MacCASOutreach$graphicsvg$GraphicSVG$createSVG, id, w, h, trans, msgWrapper, positionWrapper, sh)
							]));
				case 'MouseUpAt':
					var msg = shape.a;
					var sh = shape.b;
					return A2(
						$elm$svg$Svg$g,
						_List_fromArray(
							[
								$MacCASOutreach$graphicsvg$GraphicSVG$onMouseUpAt(
								positionWrapper(msg))
							]),
						_List_fromArray(
							[
								A7($MacCASOutreach$graphicsvg$GraphicSVG$createSVG, id, w, h, trans, msgWrapper, positionWrapper, sh)
							]));
				case 'MoveOverAt':
					var msg = shape.a;
					var sh = shape.b;
					return A2(
						$elm$svg$Svg$g,
						_List_fromArray(
							[
								$MacCASOutreach$graphicsvg$GraphicSVG$onMoveAt(
								positionWrapper(msg))
							]),
						_List_fromArray(
							[
								A7($MacCASOutreach$graphicsvg$GraphicSVG$createSVG, id, w, h, trans, msgWrapper, positionWrapper, sh)
							]));
				case 'TouchStart':
					var msg = shape.a;
					var sh = shape.b;
					return A2(
						$elm$svg$Svg$g,
						_List_fromArray(
							[
								$MacCASOutreach$graphicsvg$GraphicSVG$onTouchStart(
								msgWrapper(msg))
							]),
						_List_fromArray(
							[
								A7($MacCASOutreach$graphicsvg$GraphicSVG$createSVG, id, w, h, trans, msgWrapper, positionWrapper, sh)
							]));
				case 'TouchEnd':
					var msg = shape.a;
					var sh = shape.b;
					return A2(
						$elm$svg$Svg$g,
						_List_fromArray(
							[
								$MacCASOutreach$graphicsvg$GraphicSVG$onTouchEnd(
								msgWrapper(msg))
							]),
						_List_fromArray(
							[
								A7($MacCASOutreach$graphicsvg$GraphicSVG$createSVG, id, w, h, trans, msgWrapper, positionWrapper, sh)
							]));
				case 'TouchStartAt':
					var msg = shape.a;
					var sh = shape.b;
					return A2(
						$elm$svg$Svg$g,
						_List_fromArray(
							[
								$MacCASOutreach$graphicsvg$GraphicSVG$onTouchStartAt(
								positionWrapper(msg))
							]),
						_List_fromArray(
							[
								A7($MacCASOutreach$graphicsvg$GraphicSVG$createSVG, id, w, h, trans, msgWrapper, positionWrapper, sh)
							]));
				case 'TouchEndAt':
					var msg = shape.a;
					var sh = shape.b;
					return A2(
						$elm$svg$Svg$g,
						_List_fromArray(
							[
								$MacCASOutreach$graphicsvg$GraphicSVG$onTouchStartAt(
								positionWrapper(msg))
							]),
						_List_fromArray(
							[
								A7($MacCASOutreach$graphicsvg$GraphicSVG$createSVG, id, w, h, trans, msgWrapper, positionWrapper, sh)
							]));
				case 'TouchMoveAt':
					var msg = shape.a;
					var sh = shape.b;
					return A2(
						$elm$svg$Svg$g,
						_List_fromArray(
							[
								$MacCASOutreach$graphicsvg$GraphicSVG$onTouchMove(
								positionWrapper(msg))
							]),
						_List_fromArray(
							[
								A7($MacCASOutreach$graphicsvg$GraphicSVG$createSVG, id, w, h, trans, msgWrapper, positionWrapper, sh)
							]));
				case 'PtrStart':
					var msg = shape.a;
					var sh = shape.b;
					return A2(
						$elm$svg$Svg$g,
						_List_fromArray(
							[
								$MacCASOutreach$graphicsvg$GraphicSVG$onPtrStart(
								ptrWrapper(msg))
							]),
						_List_fromArray(
							[
								A7($MacCASOutreach$graphicsvg$GraphicSVG$createSVG, id, w, h, trans, msgWrapper, positionWrapper, sh)
							]));
				case 'PtrEnd':
					var msg = shape.a;
					var sh = shape.b;
					return A2(
						$elm$svg$Svg$g,
						_List_fromArray(
							[
								$MacCASOutreach$graphicsvg$GraphicSVG$onPtrEnd(
								ptrWrapper(msg))
							]),
						_List_fromArray(
							[
								A7($MacCASOutreach$graphicsvg$GraphicSVG$createSVG, id, w, h, trans, msgWrapper, positionWrapper, sh)
							]));
				case 'PtrCancel':
					var msg = shape.a;
					var sh = shape.b;
					return A2(
						$elm$svg$Svg$g,
						_List_fromArray(
							[
								$MacCASOutreach$graphicsvg$GraphicSVG$onPtrCancel(
								ptrWrapper(msg))
							]),
						_List_fromArray(
							[
								A7($MacCASOutreach$graphicsvg$GraphicSVG$createSVG, id, w, h, trans, msgWrapper, positionWrapper, sh)
							]));
				case 'PtrStartAt':
					var msg = shape.a;
					var sh = shape.b;
					return A2(
						$elm$svg$Svg$g,
						_List_fromArray(
							[
								$MacCASOutreach$graphicsvg$GraphicSVG$onPtrStartAt(
								ptrPosWrapper(msg))
							]),
						_List_fromArray(
							[
								A7($MacCASOutreach$graphicsvg$GraphicSVG$createSVG, id, w, h, trans, msgWrapper, positionWrapper, sh)
							]));
				case 'PtrEndAt':
					var msg = shape.a;
					var sh = shape.b;
					return A2(
						$elm$svg$Svg$g,
						_List_fromArray(
							[
								$MacCASOutreach$graphicsvg$GraphicSVG$onPtrStartAt(
								ptrPosWrapper(msg))
							]),
						_List_fromArray(
							[
								A7($MacCASOutreach$graphicsvg$GraphicSVG$createSVG, id, w, h, trans, msgWrapper, positionWrapper, sh)
							]));
				case 'PtrMoveAt':
					var msg = shape.a;
					var sh = shape.b;
					return A2(
						$elm$svg$Svg$g,
						_List_fromArray(
							[
								$MacCASOutreach$graphicsvg$GraphicSVG$onPtrMove(
								ptrPosWrapper(msg))
							]),
						_List_fromArray(
							[
								A7($MacCASOutreach$graphicsvg$GraphicSVG$createSVG, id, w, h, trans, msgWrapper, positionWrapper, sh)
							]));
				case 'Group':
					var shapes = shape.a;
					return A2(
						$elm$svg$Svg$g,
						_List_Nil,
						A2(
							$elm$core$List$indexedMap,
							function (n) {
								return A6(
									$MacCASOutreach$graphicsvg$GraphicSVG$createSVG,
									id + ('g' + $elm$core$String$fromInt(n)),
									w,
									h,
									trans,
									msgWrapper,
									positionWrapper);
							},
							shapes));
				case 'GroupOutline':
					var cmbndshp = shape.a;
					var $temp$id = id,
						$temp$w = w,
						$temp$h = h,
						$temp$trans = trans,
						$temp$msgWrapper = msgWrapper,
						$temp$positionWrapper = positionWrapper,
						$temp$shape = cmbndshp;
					id = $temp$id;
					w = $temp$w;
					h = $temp$h;
					trans = $temp$trans;
					msgWrapper = $temp$msgWrapper;
					positionWrapper = $temp$positionWrapper;
					shape = $temp$shape;
					continue createSVG;
				default:
					var s = shape.a;
					var th = shape.b;
					var c = shape.c;
					return ((th <= 0) || (_Utils_cmp(s, 2 * th) < 0)) ? A2($elm$svg$Svg$g, _List_Nil, _List_Nil) : A7(
						$MacCASOutreach$graphicsvg$GraphicSVG$createSVG,
						id,
						w,
						h,
						trans,
						msgWrapper,
						positionWrapper,
						A4(
							$MacCASOutreach$graphicsvg$GraphicSVG$createGraph,
							_Utils_Tuple2(w, h),
							s,
							th,
							c));
			}
		}
	});
var $elm$svg$Svg$svg = $elm$svg$Svg$trustedNode('svg');
var $elm$svg$Svg$Attributes$viewBox = _VirtualDom_attribute('viewBox');
var $MacCASOutreach$graphicsvg$GraphicSVG$createCollage = F3(
	function (w, h, shapes) {
		return A2(
			$elm$svg$Svg$svg,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$width('100%'),
					$elm$svg$Svg$Attributes$height('100%'),
					$elm$svg$Svg$Attributes$style('position:absolute;top:0px;left:0px;'),
					$elm$svg$Svg$Attributes$viewBox(
					$elm$core$String$fromFloat((-w) / 2) + (' ' + ($elm$core$String$fromFloat((-h) / 2) + (' ' + ($elm$core$String$fromFloat(w) + (' ' + $elm$core$String$fromFloat(h))))))),
					$elm$svg$Svg$Attributes$id('render')
				]),
			A2(
				$elm$core$List$cons,
				A2($MacCASOutreach$graphicsvg$GraphicSVG$cPath, w, h),
				_List_fromArray(
					[
						A2(
						$elm$svg$Svg$g,
						_List_fromArray(
							[
								$elm$svg$Svg$Attributes$clipPath('url(#cPath)')
							]),
						A2(
							$elm$core$List$indexedMap,
							function (n) {
								return A6(
									$MacCASOutreach$graphicsvg$GraphicSVG$createSVG,
									$elm$core$String$fromInt(n),
									w,
									h,
									$MacCASOutreach$graphicsvg$GraphicSVG$ident,
									$MacCASOutreach$graphicsvg$GraphicSVG$Graphics,
									$MacCASOutreach$graphicsvg$GraphicSVG$ReturnPosition);
							},
							shapes))
					])));
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$hiddenAppView = F2(
	function (userView, _v0) {
		var userModel = _v0.a;
		var userViewEval = userView(userModel);
		var title = userViewEval.title;
		var _v1 = userViewEval.body;
		var w = _v1.a;
		var h = _v1.b;
		var shapes = _v1.c;
		return {
			body: _List_fromArray(
				[
					A3($MacCASOutreach$graphicsvg$GraphicSVG$createCollage, w, h, shapes)
				]),
			title: title
		};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$initHiddenModel = {ch: 0, cw: 0, sh: 0, sw: 0};
var $MacCASOutreach$graphicsvg$GraphicSVG$initialCmd = function (userCmd) {
	return $elm$core$Platform$Cmd$batch(
		_List_fromArray(
			[$MacCASOutreach$graphicsvg$GraphicSVG$getViewportSize, userCmd]));
};
var $elm$core$Tuple$second = function (_v0) {
	var y = _v0.b;
	return y;
};
var $elm$core$Platform$Sub$batch = _Platform_batch;
var $elm$core$Platform$Sub$map = _Platform_map;
var $elm$browser$Browser$Events$Window = {$: 'Window'};
var $elm$browser$Browser$Events$MySub = F3(
	function (a, b, c) {
		return {$: 'MySub', a: a, b: b, c: c};
	});
var $elm$browser$Browser$Events$State = F2(
	function (subs, pids) {
		return {pids: pids, subs: subs};
	});
var $elm$core$Dict$RBEmpty_elm_builtin = {$: 'RBEmpty_elm_builtin'};
var $elm$core$Dict$empty = $elm$core$Dict$RBEmpty_elm_builtin;
var $elm$browser$Browser$Events$init = $elm$core$Task$succeed(
	A2($elm$browser$Browser$Events$State, _List_Nil, $elm$core$Dict$empty));
var $elm$browser$Browser$Events$nodeToKey = function (node) {
	if (node.$ === 'Document') {
		return 'd_';
	} else {
		return 'w_';
	}
};
var $elm$browser$Browser$Events$addKey = function (sub) {
	var node = sub.a;
	var name = sub.b;
	return _Utils_Tuple2(
		_Utils_ap(
			$elm$browser$Browser$Events$nodeToKey(node),
			name),
		sub);
};
var $elm$core$Dict$Black = {$: 'Black'};
var $elm$core$Dict$RBNode_elm_builtin = F5(
	function (a, b, c, d, e) {
		return {$: 'RBNode_elm_builtin', a: a, b: b, c: c, d: d, e: e};
	});
var $elm$core$Dict$Red = {$: 'Red'};
var $elm$core$Dict$balance = F5(
	function (color, key, value, left, right) {
		if ((right.$ === 'RBNode_elm_builtin') && (right.a.$ === 'Red')) {
			var _v1 = right.a;
			var rK = right.b;
			var rV = right.c;
			var rLeft = right.d;
			var rRight = right.e;
			if ((left.$ === 'RBNode_elm_builtin') && (left.a.$ === 'Red')) {
				var _v3 = left.a;
				var lK = left.b;
				var lV = left.c;
				var lLeft = left.d;
				var lRight = left.e;
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Red,
					key,
					value,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, lK, lV, lLeft, lRight),
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, rK, rV, rLeft, rRight));
			} else {
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					color,
					rK,
					rV,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, key, value, left, rLeft),
					rRight);
			}
		} else {
			if ((((left.$ === 'RBNode_elm_builtin') && (left.a.$ === 'Red')) && (left.d.$ === 'RBNode_elm_builtin')) && (left.d.a.$ === 'Red')) {
				var _v5 = left.a;
				var lK = left.b;
				var lV = left.c;
				var _v6 = left.d;
				var _v7 = _v6.a;
				var llK = _v6.b;
				var llV = _v6.c;
				var llLeft = _v6.d;
				var llRight = _v6.e;
				var lRight = left.e;
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Red,
					lK,
					lV,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, llK, llV, llLeft, llRight),
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, key, value, lRight, right));
			} else {
				return A5($elm$core$Dict$RBNode_elm_builtin, color, key, value, left, right);
			}
		}
	});
var $elm$core$Basics$compare = _Utils_compare;
var $elm$core$Dict$insertHelp = F3(
	function (key, value, dict) {
		if (dict.$ === 'RBEmpty_elm_builtin') {
			return A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, key, value, $elm$core$Dict$RBEmpty_elm_builtin, $elm$core$Dict$RBEmpty_elm_builtin);
		} else {
			var nColor = dict.a;
			var nKey = dict.b;
			var nValue = dict.c;
			var nLeft = dict.d;
			var nRight = dict.e;
			var _v1 = A2($elm$core$Basics$compare, key, nKey);
			switch (_v1.$) {
				case 'LT':
					return A5(
						$elm$core$Dict$balance,
						nColor,
						nKey,
						nValue,
						A3($elm$core$Dict$insertHelp, key, value, nLeft),
						nRight);
				case 'EQ':
					return A5($elm$core$Dict$RBNode_elm_builtin, nColor, nKey, value, nLeft, nRight);
				default:
					return A5(
						$elm$core$Dict$balance,
						nColor,
						nKey,
						nValue,
						nLeft,
						A3($elm$core$Dict$insertHelp, key, value, nRight));
			}
		}
	});
var $elm$core$Dict$insert = F3(
	function (key, value, dict) {
		var _v0 = A3($elm$core$Dict$insertHelp, key, value, dict);
		if ((_v0.$ === 'RBNode_elm_builtin') && (_v0.a.$ === 'Red')) {
			var _v1 = _v0.a;
			var k = _v0.b;
			var v = _v0.c;
			var l = _v0.d;
			var r = _v0.e;
			return A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, k, v, l, r);
		} else {
			var x = _v0;
			return x;
		}
	});
var $elm$core$Dict$fromList = function (assocs) {
	return A3(
		$elm$core$List$foldl,
		F2(
			function (_v0, dict) {
				var key = _v0.a;
				var value = _v0.b;
				return A3($elm$core$Dict$insert, key, value, dict);
			}),
		$elm$core$Dict$empty,
		assocs);
};
var $elm$core$Process$kill = _Scheduler_kill;
var $elm$core$Dict$foldl = F3(
	function (func, acc, dict) {
		foldl:
		while (true) {
			if (dict.$ === 'RBEmpty_elm_builtin') {
				return acc;
			} else {
				var key = dict.b;
				var value = dict.c;
				var left = dict.d;
				var right = dict.e;
				var $temp$func = func,
					$temp$acc = A3(
					func,
					key,
					value,
					A3($elm$core$Dict$foldl, func, acc, left)),
					$temp$dict = right;
				func = $temp$func;
				acc = $temp$acc;
				dict = $temp$dict;
				continue foldl;
			}
		}
	});
var $elm$core$Dict$merge = F6(
	function (leftStep, bothStep, rightStep, leftDict, rightDict, initialResult) {
		var stepState = F3(
			function (rKey, rValue, _v0) {
				stepState:
				while (true) {
					var list = _v0.a;
					var result = _v0.b;
					if (!list.b) {
						return _Utils_Tuple2(
							list,
							A3(rightStep, rKey, rValue, result));
					} else {
						var _v2 = list.a;
						var lKey = _v2.a;
						var lValue = _v2.b;
						var rest = list.b;
						if (_Utils_cmp(lKey, rKey) < 0) {
							var $temp$rKey = rKey,
								$temp$rValue = rValue,
								$temp$_v0 = _Utils_Tuple2(
								rest,
								A3(leftStep, lKey, lValue, result));
							rKey = $temp$rKey;
							rValue = $temp$rValue;
							_v0 = $temp$_v0;
							continue stepState;
						} else {
							if (_Utils_cmp(lKey, rKey) > 0) {
								return _Utils_Tuple2(
									list,
									A3(rightStep, rKey, rValue, result));
							} else {
								return _Utils_Tuple2(
									rest,
									A4(bothStep, lKey, lValue, rValue, result));
							}
						}
					}
				}
			});
		var _v3 = A3(
			$elm$core$Dict$foldl,
			stepState,
			_Utils_Tuple2(
				$elm$core$Dict$toList(leftDict),
				initialResult),
			rightDict);
		var leftovers = _v3.a;
		var intermediateResult = _v3.b;
		return A3(
			$elm$core$List$foldl,
			F2(
				function (_v4, result) {
					var k = _v4.a;
					var v = _v4.b;
					return A3(leftStep, k, v, result);
				}),
			intermediateResult,
			leftovers);
	});
var $elm$browser$Browser$Events$Event = F2(
	function (key, event) {
		return {event: event, key: key};
	});
var $elm$core$Platform$sendToSelf = _Platform_sendToSelf;
var $elm$browser$Browser$Events$spawn = F3(
	function (router, key, _v0) {
		var node = _v0.a;
		var name = _v0.b;
		var actualNode = function () {
			if (node.$ === 'Document') {
				return _Browser_doc;
			} else {
				return _Browser_window;
			}
		}();
		return A2(
			$elm$core$Task$map,
			function (value) {
				return _Utils_Tuple2(key, value);
			},
			A3(
				_Browser_on,
				actualNode,
				name,
				function (event) {
					return A2(
						$elm$core$Platform$sendToSelf,
						router,
						A2($elm$browser$Browser$Events$Event, key, event));
				}));
	});
var $elm$core$Dict$union = F2(
	function (t1, t2) {
		return A3($elm$core$Dict$foldl, $elm$core$Dict$insert, t2, t1);
	});
var $elm$browser$Browser$Events$onEffects = F3(
	function (router, subs, state) {
		var stepRight = F3(
			function (key, sub, _v6) {
				var deads = _v6.a;
				var lives = _v6.b;
				var news = _v6.c;
				return _Utils_Tuple3(
					deads,
					lives,
					A2(
						$elm$core$List$cons,
						A3($elm$browser$Browser$Events$spawn, router, key, sub),
						news));
			});
		var stepLeft = F3(
			function (_v4, pid, _v5) {
				var deads = _v5.a;
				var lives = _v5.b;
				var news = _v5.c;
				return _Utils_Tuple3(
					A2($elm$core$List$cons, pid, deads),
					lives,
					news);
			});
		var stepBoth = F4(
			function (key, pid, _v2, _v3) {
				var deads = _v3.a;
				var lives = _v3.b;
				var news = _v3.c;
				return _Utils_Tuple3(
					deads,
					A3($elm$core$Dict$insert, key, pid, lives),
					news);
			});
		var newSubs = A2($elm$core$List$map, $elm$browser$Browser$Events$addKey, subs);
		var _v0 = A6(
			$elm$core$Dict$merge,
			stepLeft,
			stepBoth,
			stepRight,
			state.pids,
			$elm$core$Dict$fromList(newSubs),
			_Utils_Tuple3(_List_Nil, $elm$core$Dict$empty, _List_Nil));
		var deadPids = _v0.a;
		var livePids = _v0.b;
		var makeNewPids = _v0.c;
		return A2(
			$elm$core$Task$andThen,
			function (pids) {
				return $elm$core$Task$succeed(
					A2(
						$elm$browser$Browser$Events$State,
						newSubs,
						A2(
							$elm$core$Dict$union,
							livePids,
							$elm$core$Dict$fromList(pids))));
			},
			A2(
				$elm$core$Task$andThen,
				function (_v1) {
					return $elm$core$Task$sequence(makeNewPids);
				},
				$elm$core$Task$sequence(
					A2($elm$core$List$map, $elm$core$Process$kill, deadPids))));
	});
var $elm$core$List$maybeCons = F3(
	function (f, mx, xs) {
		var _v0 = f(mx);
		if (_v0.$ === 'Just') {
			var x = _v0.a;
			return A2($elm$core$List$cons, x, xs);
		} else {
			return xs;
		}
	});
var $elm$core$List$filterMap = F2(
	function (f, xs) {
		return A3(
			$elm$core$List$foldr,
			$elm$core$List$maybeCons(f),
			_List_Nil,
			xs);
	});
var $elm$browser$Browser$Events$onSelfMsg = F3(
	function (router, _v0, state) {
		var key = _v0.key;
		var event = _v0.event;
		var toMessage = function (_v2) {
			var subKey = _v2.a;
			var _v3 = _v2.b;
			var node = _v3.a;
			var name = _v3.b;
			var decoder = _v3.c;
			return _Utils_eq(subKey, key) ? A2(_Browser_decodeEvent, decoder, event) : $elm$core$Maybe$Nothing;
		};
		var messages = A2($elm$core$List$filterMap, toMessage, state.subs);
		return A2(
			$elm$core$Task$andThen,
			function (_v1) {
				return $elm$core$Task$succeed(state);
			},
			$elm$core$Task$sequence(
				A2(
					$elm$core$List$map,
					$elm$core$Platform$sendToApp(router),
					messages)));
	});
var $elm$browser$Browser$Events$subMap = F2(
	function (func, _v0) {
		var node = _v0.a;
		var name = _v0.b;
		var decoder = _v0.c;
		return A3(
			$elm$browser$Browser$Events$MySub,
			node,
			name,
			A2($elm$json$Json$Decode$map, func, decoder));
	});
_Platform_effectManagers['Browser.Events'] = _Platform_createManager($elm$browser$Browser$Events$init, $elm$browser$Browser$Events$onEffects, $elm$browser$Browser$Events$onSelfMsg, 0, $elm$browser$Browser$Events$subMap);
var $elm$browser$Browser$Events$subscription = _Platform_leaf('Browser.Events');
var $elm$browser$Browser$Events$on = F3(
	function (node, name, decoder) {
		return $elm$browser$Browser$Events$subscription(
			A3($elm$browser$Browser$Events$MySub, node, name, decoder));
	});
var $elm$browser$Browser$Events$onResize = function (func) {
	return A3(
		$elm$browser$Browser$Events$on,
		$elm$browser$Browser$Events$Window,
		'resize',
		A2(
			$elm$json$Json$Decode$field,
			'target',
			A3(
				$elm$json$Json$Decode$map2,
				func,
				A2($elm$json$Json$Decode$field, 'innerWidth', $elm$json$Json$Decode$int),
				A2($elm$json$Json$Decode$field, 'innerHeight', $elm$json$Json$Decode$int))));
};
var $MacCASOutreach$graphicsvg$GraphicSVG$subs = F2(
	function (userSubs, _v0) {
		var userModel = _v0.a;
		return $elm$core$Platform$Sub$batch(
			_Utils_ap(
				_List_fromArray(
					[
						$elm$browser$Browser$Events$onResize(
						F2(
							function (_v1, _v2) {
								return $MacCASOutreach$graphicsvg$GraphicSVG$WindowResize($elm$core$Maybe$Nothing);
							}))
					]),
				_List_fromArray(
					[
						A2(
						$elm$core$Platform$Sub$map,
						$MacCASOutreach$graphicsvg$GraphicSVG$Graphics,
						userSubs(userModel))
					])));
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$app = function (input) {
	return $elm$browser$Browser$application(
		{
			init: F3(
				function (flags, url, key) {
					var userInitCmd = A3(input.init, flags, url, key).b;
					var userInit = A3(input.init, flags, url, key).a;
					var userView = input.view(userInit).body;
					var _v0 = userView;
					var initW = _v0.a;
					var initH = _v0.b;
					return _Utils_Tuple2(
						_Utils_Tuple2(
							userInit,
							_Utils_update(
								$MacCASOutreach$graphicsvg$GraphicSVG$initHiddenModel,
								{ch: initH, cw: initW})),
						$MacCASOutreach$graphicsvg$GraphicSVG$initialCmd(
							A2($elm$core$Platform$Cmd$map, $MacCASOutreach$graphicsvg$GraphicSVG$Graphics, userInitCmd)));
				}),
			onUrlChange: A2($elm$core$Basics$composeL, $MacCASOutreach$graphicsvg$GraphicSVG$Graphics, input.onUrlChange),
			onUrlRequest: A2($elm$core$Basics$composeL, $MacCASOutreach$graphicsvg$GraphicSVG$Graphics, input.onUrlRequest),
			subscriptions: $MacCASOutreach$graphicsvg$GraphicSVG$subs(input.subscriptions),
			update: A2($MacCASOutreach$graphicsvg$GraphicSVG$hiddenAppUpdate, input.view, input.update),
			view: $MacCASOutreach$graphicsvg$GraphicSVG$hiddenAppView(input.view)
		});
};
var $MacCASOutreach$graphicsvg$GraphicSVG$App$DownArrow = {$: 'DownArrow'};
var $MacCASOutreach$graphicsvg$GraphicSVG$App$Key = function (a) {
	return {$: 'Key', a: a};
};
var $MacCASOutreach$graphicsvg$GraphicSVG$App$LeftArrow = {$: 'LeftArrow'};
var $MacCASOutreach$graphicsvg$GraphicSVG$App$RightArrow = {$: 'RightArrow'};
var $MacCASOutreach$graphicsvg$GraphicSVG$App$UpArrow = {$: 'UpArrow'};
var $MacCASOutreach$graphicsvg$GraphicSVG$App$WentDown = {$: 'WentDown'};
var $MacCASOutreach$graphicsvg$GraphicSVG$App$WentUp = {$: 'WentUp'};
var $MacCASOutreach$graphicsvg$GraphicSVG$App$arrowChecker = F5(
	function (checker, up, down, left, right) {
		return _Utils_Tuple2(
			function () {
				var _v0 = _Utils_Tuple2(
					checker(left),
					checker(right));
				_v0$8:
				while (true) {
					switch (_v0.a.$) {
						case 'Down':
							switch (_v0.b.$) {
								case 'Up':
									var _v1 = _v0.a;
									var _v2 = _v0.b;
									return -1;
								case 'JustUp':
									var _v3 = _v0.a;
									var _v4 = _v0.b;
									return -1;
								default:
									break _v0$8;
							}
						case 'JustDown':
							switch (_v0.b.$) {
								case 'Up':
									var _v5 = _v0.a;
									var _v6 = _v0.b;
									return -1;
								case 'JustUp':
									var _v7 = _v0.a;
									var _v8 = _v0.b;
									return -1;
								default:
									break _v0$8;
							}
						case 'Up':
							switch (_v0.b.$) {
								case 'Down':
									var _v9 = _v0.a;
									var _v10 = _v0.b;
									return 1;
								case 'JustDown':
									var _v13 = _v0.a;
									var _v14 = _v0.b;
									return 1;
								default:
									break _v0$8;
							}
						default:
							switch (_v0.b.$) {
								case 'Down':
									var _v11 = _v0.a;
									var _v12 = _v0.b;
									return 1;
								case 'JustDown':
									var _v15 = _v0.a;
									var _v16 = _v0.b;
									return 1;
								default:
									break _v0$8;
							}
					}
				}
				return 0;
			}(),
			function () {
				var _v17 = _Utils_Tuple2(
					checker(down),
					checker(up));
				_v17$8:
				while (true) {
					switch (_v17.a.$) {
						case 'Down':
							switch (_v17.b.$) {
								case 'Up':
									var _v18 = _v17.a;
									var _v19 = _v17.b;
									return -1;
								case 'JustUp':
									var _v20 = _v17.a;
									var _v21 = _v17.b;
									return -1;
								default:
									break _v17$8;
							}
						case 'JustDown':
							switch (_v17.b.$) {
								case 'Up':
									var _v22 = _v17.a;
									var _v23 = _v17.b;
									return -1;
								case 'JustUp':
									var _v24 = _v17.a;
									var _v25 = _v17.b;
									return -1;
								default:
									break _v17$8;
							}
						case 'Up':
							switch (_v17.b.$) {
								case 'Down':
									var _v26 = _v17.a;
									var _v27 = _v17.b;
									return 1;
								case 'JustDown':
									var _v30 = _v17.a;
									var _v31 = _v17.b;
									return 1;
								default:
									break _v17$8;
							}
						default:
							switch (_v17.b.$) {
								case 'Down':
									var _v28 = _v17.a;
									var _v29 = _v17.b;
									return 1;
								case 'JustDown':
									var _v32 = _v17.a;
									var _v33 = _v17.b;
									return 1;
								default:
									break _v17$8;
							}
					}
				}
				return 0;
			}());
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$App$Down = {$: 'Down'};
var $MacCASOutreach$graphicsvg$GraphicSVG$App$JustDown = {$: 'JustDown'};
var $MacCASOutreach$graphicsvg$GraphicSVG$App$JustUp = {$: 'JustUp'};
var $elm$core$Dict$get = F2(
	function (targetKey, dict) {
		get:
		while (true) {
			if (dict.$ === 'RBEmpty_elm_builtin') {
				return $elm$core$Maybe$Nothing;
			} else {
				var key = dict.b;
				var value = dict.c;
				var left = dict.d;
				var right = dict.e;
				var _v1 = A2($elm$core$Basics$compare, targetKey, key);
				switch (_v1.$) {
					case 'LT':
						var $temp$targetKey = targetKey,
							$temp$dict = left;
						targetKey = $temp$targetKey;
						dict = $temp$dict;
						continue get;
					case 'EQ':
						return $elm$core$Maybe$Just(value);
					default:
						var $temp$targetKey = targetKey,
							$temp$dict = right;
						targetKey = $temp$targetKey;
						dict = $temp$dict;
						continue get;
				}
			}
		}
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$App$insertKeyDict = F3(
	function (dict, key, action) {
		var currState = A2($elm$core$Dict$get, key, dict);
		if (currState.$ === 'Just') {
			if (!currState.a.b) {
				switch (currState.a.a.$) {
					case 'JustDown':
						var _v1 = currState.a;
						var _v2 = _v1.a;
						return A3(
							$elm$core$Dict$insert,
							key,
							function () {
								if (action.$ === 'WentDown') {
									return _Utils_Tuple2($MacCASOutreach$graphicsvg$GraphicSVG$App$JustDown, false);
								} else {
									return _Utils_Tuple2($MacCASOutreach$graphicsvg$GraphicSVG$App$JustDown, true);
								}
							}(),
							dict);
					case 'Down':
						var _v4 = currState.a;
						var _v5 = _v4.a;
						return A3(
							$elm$core$Dict$insert,
							key,
							function () {
								if (action.$ === 'WentDown') {
									return _Utils_Tuple2($MacCASOutreach$graphicsvg$GraphicSVG$App$Down, false);
								} else {
									return _Utils_Tuple2($MacCASOutreach$graphicsvg$GraphicSVG$App$JustUp, false);
								}
							}(),
							dict);
					case 'Up':
						var _v7 = currState.a;
						var _v8 = _v7.a;
						return A3(
							$elm$core$Dict$insert,
							key,
							function () {
								if (action.$ === 'WentDown') {
									return _Utils_Tuple2($MacCASOutreach$graphicsvg$GraphicSVG$App$JustDown, false);
								} else {
									return _Utils_Tuple2($MacCASOutreach$graphicsvg$GraphicSVG$App$JustUp, false);
								}
							}(),
							dict);
					default:
						var _v10 = currState.a;
						var _v11 = _v10.a;
						return A3(
							$elm$core$Dict$insert,
							key,
							function () {
								if (action.$ === 'WentDown') {
									return _Utils_Tuple2($MacCASOutreach$graphicsvg$GraphicSVG$App$JustUp, true);
								} else {
									return _Utils_Tuple2($MacCASOutreach$graphicsvg$GraphicSVG$App$JustUp, false);
								}
							}(),
							dict);
				}
			} else {
				var _v13 = currState.a;
				var state = _v13.a;
				return A3(
					$elm$core$Dict$insert,
					key,
					function () {
						if (action.$ === 'WentDown') {
							return _Utils_Tuple2(state, true);
						} else {
							return _Utils_Tuple2(state, true);
						}
					}(),
					dict);
			}
		} else {
			return A3(
				$elm$core$Dict$insert,
				key,
				function () {
					if (action.$ === 'WentDown') {
						return _Utils_Tuple2($MacCASOutreach$graphicsvg$GraphicSVG$App$JustDown, false);
					} else {
						return _Utils_Tuple2($MacCASOutreach$graphicsvg$GraphicSVG$App$JustUp, false);
					}
				}(),
				dict);
		}
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$App$Up = {$: 'Up'};
var $elm$core$Char$toUpper = _Char_toUpper;
var $MacCASOutreach$graphicsvg$GraphicSVG$App$keyCheckerFunction = F2(
	function (dict, key) {
		var kc = function () {
			switch (key.$) {
				case 'Key':
					var str = key.a;
					return $elm$core$Char$toCode(
						$elm$core$Char$toUpper(
							function () {
								var _v10 = $elm$core$String$uncons(str);
								if (_v10.$ === 'Just') {
									var _v11 = _v10.a;
									var a = _v11.a;
									return a;
								} else {
									return _Utils_chr('z');
								}
							}()));
				case 'Backspace':
					return 8;
				case 'Tab':
					return 9;
				case 'Enter':
					return 13;
				case 'Shift':
					return 16;
				case 'Ctrl':
					return 17;
				case 'Alt':
					return 18;
				case 'Caps':
					return 20;
				case 'Space':
					return 32;
				case 'LeftArrow':
					return 37;
				case 'UpArrow':
					return 38;
				case 'RightArrow':
					return 39;
				case 'DownArrow':
					return 40;
				default:
					return 46;
			}
		}();
		var state = A2($elm$core$Dict$get, kc, dict);
		if (state.$ === 'Just') {
			switch (state.a.a.$) {
				case 'JustDown':
					var _v1 = state.a;
					var _v2 = _v1.a;
					return $MacCASOutreach$graphicsvg$GraphicSVG$App$JustDown;
				case 'Down':
					var _v3 = state.a;
					var _v4 = _v3.a;
					return $MacCASOutreach$graphicsvg$GraphicSVG$App$Down;
				case 'JustUp':
					var _v5 = state.a;
					var _v6 = _v5.a;
					return $MacCASOutreach$graphicsvg$GraphicSVG$App$JustUp;
				default:
					var _v7 = state.a;
					var _v8 = _v7.a;
					return $MacCASOutreach$graphicsvg$GraphicSVG$App$Up;
			}
		} else {
			return $MacCASOutreach$graphicsvg$GraphicSVG$App$Up;
		}
	});
var $elm$browser$Browser$Navigation$load = _Browser_load;
var $elm$core$Dict$filter = F2(
	function (isGood, dict) {
		return A3(
			$elm$core$Dict$foldl,
			F3(
				function (k, v, d) {
					return A2(isGood, k, v) ? A3($elm$core$Dict$insert, k, v, d) : d;
				}),
			$elm$core$Dict$empty,
			dict);
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$App$filterHelper = F2(
	function (key, action) {
		if (action.a.$ === 'Up') {
			var _v1 = action.a;
			return false;
		} else {
			return true;
		}
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$App$maintainHelper = F2(
	function (key, action) {
		if (!action.b) {
			switch (action.a.$) {
				case 'JustUp':
					var _v1 = action.a;
					return _Utils_Tuple2($MacCASOutreach$graphicsvg$GraphicSVG$App$Up, false);
				case 'Up':
					var _v3 = action.a;
					return _Utils_Tuple2($MacCASOutreach$graphicsvg$GraphicSVG$App$Up, false);
				case 'JustDown':
					var _v5 = action.a;
					return _Utils_Tuple2($MacCASOutreach$graphicsvg$GraphicSVG$App$Down, false);
				default:
					var _v7 = action.a;
					return _Utils_Tuple2($MacCASOutreach$graphicsvg$GraphicSVG$App$Down, false);
			}
		} else {
			switch (action.a.$) {
				case 'JustUp':
					var _v2 = action.a;
					return _Utils_Tuple2($MacCASOutreach$graphicsvg$GraphicSVG$App$JustDown, false);
				case 'Up':
					var _v4 = action.a;
					return _Utils_Tuple2($MacCASOutreach$graphicsvg$GraphicSVG$App$Up, false);
				case 'JustDown':
					var _v6 = action.a;
					return _Utils_Tuple2($MacCASOutreach$graphicsvg$GraphicSVG$App$JustUp, false);
				default:
					var _v8 = action.a;
					return _Utils_Tuple2($MacCASOutreach$graphicsvg$GraphicSVG$App$Down, false);
			}
		}
	});
var $elm$core$Dict$map = F2(
	function (func, dict) {
		if (dict.$ === 'RBEmpty_elm_builtin') {
			return $elm$core$Dict$RBEmpty_elm_builtin;
		} else {
			var color = dict.a;
			var key = dict.b;
			var value = dict.c;
			var left = dict.d;
			var right = dict.e;
			return A5(
				$elm$core$Dict$RBNode_elm_builtin,
				color,
				key,
				A2(func, key, value),
				A2($elm$core$Dict$map, func, left),
				A2($elm$core$Dict$map, func, right));
		}
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$App$maintainKeyDict = function (dict) {
	return A2(
		$elm$core$Dict$filter,
		$MacCASOutreach$graphicsvg$GraphicSVG$App$filterHelper,
		A2($elm$core$Dict$map, $MacCASOutreach$graphicsvg$GraphicSVG$App$maintainHelper, dict));
};
var $elm$time$Time$posixToMillis = function (_v0) {
	var millis = _v0.a;
	return millis;
};
var $MacCASOutreach$graphicsvg$GraphicSVG$App$subtractTimeSeconds = F2(
	function (t1, t0) {
		return ($elm$time$Time$posixToMillis(t1) - $elm$time$Time$posixToMillis(t0)) / 1000;
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$App$hiddenGameUpdate = F3(
	function (userUpdate, msg, _v0) {
		var userModel = _v0.a;
		var hiddenModel = _v0.b;
		var updateTick = hiddenModel.tick;
		switch (msg.$) {
			case 'UserMsg':
				var userMsg = msg.a;
				return _Utils_Tuple2(
					_Utils_Tuple2(
						A2(userUpdate, userMsg, userModel),
						hiddenModel),
					$elm$core$Platform$Cmd$none);
			case 'InitTime':
				var t = msg.a;
				return _Utils_Tuple2(
					_Utils_Tuple2(
						userModel,
						_Utils_update(
							hiddenModel,
							{initT: t})),
					$elm$core$Platform$Cmd$none);
			case 'TickTime':
				var t = msg.a;
				var timeInSeconds = A2($MacCASOutreach$graphicsvg$GraphicSVG$App$subtractTimeSeconds, t, hiddenModel.initT);
				var keyChecker = $MacCASOutreach$graphicsvg$GraphicSVG$App$keyCheckerFunction(hiddenModel.keys);
				var wasd = A5(
					$MacCASOutreach$graphicsvg$GraphicSVG$App$arrowChecker,
					keyChecker,
					$MacCASOutreach$graphicsvg$GraphicSVG$App$Key('w'),
					$MacCASOutreach$graphicsvg$GraphicSVG$App$Key('s'),
					$MacCASOutreach$graphicsvg$GraphicSVG$App$Key('a'),
					$MacCASOutreach$graphicsvg$GraphicSVG$App$Key('d'));
				var arrowKeys = A5($MacCASOutreach$graphicsvg$GraphicSVG$App$arrowChecker, keyChecker, $MacCASOutreach$graphicsvg$GraphicSVG$App$UpArrow, $MacCASOutreach$graphicsvg$GraphicSVG$App$DownArrow, $MacCASOutreach$graphicsvg$GraphicSVG$App$LeftArrow, $MacCASOutreach$graphicsvg$GraphicSVG$App$RightArrow);
				var newModel = A2(
					userUpdate,
					A2(
						hiddenModel.tick,
						timeInSeconds,
						_Utils_Tuple3(keyChecker, arrowKeys, wasd)),
					userModel);
				return _Utils_Tuple2(
					_Utils_Tuple2(
						newModel,
						_Utils_update(
							hiddenModel,
							{
								keys: $MacCASOutreach$graphicsvg$GraphicSVG$App$maintainKeyDict(hiddenModel.keys)
							})),
					$elm$core$Platform$Cmd$none);
			case 'KeyDown':
				var keyCode = msg.a;
				return _Utils_Tuple2(
					_Utils_Tuple2(
						userModel,
						_Utils_update(
							hiddenModel,
							{
								keys: A3($MacCASOutreach$graphicsvg$GraphicSVG$App$insertKeyDict, hiddenModel.keys, keyCode, $MacCASOutreach$graphicsvg$GraphicSVG$App$WentDown)
							})),
					$elm$core$Platform$Cmd$none);
			case 'KeyUp':
				var keyCode = msg.a;
				return _Utils_Tuple2(
					_Utils_Tuple2(
						userModel,
						_Utils_update(
							hiddenModel,
							{
								keys: A3($MacCASOutreach$graphicsvg$GraphicSVG$App$insertKeyDict, hiddenModel.keys, keyCode, $MacCASOutreach$graphicsvg$GraphicSVG$App$WentUp)
							})),
					$elm$core$Platform$Cmd$none);
			case 'URLRequest':
				var urlreq = msg.a;
				if (urlreq.$ === 'External') {
					var url = urlreq.a;
					return _Utils_Tuple2(
						_Utils_Tuple2(userModel, hiddenModel),
						$elm$browser$Browser$Navigation$load(url));
				} else {
					return _Utils_Tuple2(
						_Utils_Tuple2(userModel, hiddenModel),
						$elm$core$Platform$Cmd$none);
				}
			default:
				var url = msg.a;
				return _Utils_Tuple2(
					_Utils_Tuple2(userModel, hiddenModel),
					$elm$core$Platform$Cmd$none);
		}
	});
var $elm$time$Time$Posix = function (a) {
	return {$: 'Posix', a: a};
};
var $elm$time$Time$millisToPosix = $elm$time$Time$Posix;
var $MacCASOutreach$graphicsvg$GraphicSVG$App$initHiddenModel = F2(
	function (tick, navKey) {
		return {
			initT: $elm$time$Time$millisToPosix(0),
			keys: $elm$core$Dict$empty,
			navKey: navKey,
			tick: tick
		};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Collage = F3(
	function (a, b, c) {
		return {$: 'Collage', a: a, b: b, c: c};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$map = F2(
	function (f, sh) {
		switch (sh.$) {
			case 'Inked':
				var fillClr = sh.a;
				var lt = sh.b;
				var stencil = sh.c;
				return A3($MacCASOutreach$graphicsvg$GraphicSVG$Secret$Inked, fillClr, lt, stencil);
			case 'ForeignObject':
				var w = sh.a;
				var h = sh.b;
				var htm = sh.c;
				return A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$ForeignObject,
					w,
					h,
					A2($elm$html$Html$map, f, htm));
			case 'Move':
				var v = sh.a;
				var shape = sh.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Move,
					v,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, shape));
			case 'Rotate':
				var deg = sh.a;
				var shape = sh.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Rotate,
					deg,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, shape));
			case 'Scale':
				var sx = sh.a;
				var sy = sh.b;
				var shape = sh.c;
				return A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Scale,
					sx,
					sy,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, shape));
			case 'Skew':
				var skx = sh.a;
				var sky = sh.b;
				var shape = sh.c;
				return A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Skew,
					skx,
					sky,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, shape));
			case 'Transformed':
				var tm = sh.a;
				var shape = sh.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Transformed,
					tm,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, shape));
			case 'Link':
				var href = sh.a;
				var shape = sh.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Link,
					href,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, shape));
			case 'AlphaMask':
				var sh1 = sh.a;
				var sh2 = sh.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$AlphaMask,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, sh1),
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, sh2));
			case 'Clip':
				var sh1 = sh.a;
				var sh2 = sh.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Clip,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, sh1),
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, sh2));
			case 'Everything':
				return $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Everything;
			case 'Notathing':
				return $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Notathing;
			case 'Tap':
				var msg = sh.a;
				var shape = sh.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Tap,
					f(msg),
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, shape));
			case 'TapAt':
				var msg = sh.a;
				var shape = sh.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$TapAt,
					A2($elm$core$Basics$composeL, f, msg),
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, shape));
			case 'EnterShape':
				var msg = sh.a;
				var shape = sh.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$EnterShape,
					f(msg),
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, shape));
			case 'EnterAt':
				var msg = sh.a;
				var shape = sh.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$EnterAt,
					A2($elm$core$Basics$composeL, f, msg),
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, shape));
			case 'Exit':
				var msg = sh.a;
				var shape = sh.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Exit,
					f(msg),
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, shape));
			case 'ExitAt':
				var msg = sh.a;
				var shape = sh.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$ExitAt,
					A2($elm$core$Basics$composeL, f, msg),
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, shape));
			case 'MouseDown':
				var msg = sh.a;
				var shape = sh.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$MouseDown,
					f(msg),
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, shape));
			case 'MouseDownAt':
				var msg = sh.a;
				var shape = sh.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$MouseDownAt,
					A2($elm$core$Basics$composeL, f, msg),
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, shape));
			case 'MouseUp':
				var msg = sh.a;
				var shape = sh.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$MouseUp,
					f(msg),
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, shape));
			case 'MouseUpAt':
				var msg = sh.a;
				var shape = sh.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$MouseUpAt,
					A2($elm$core$Basics$composeL, f, msg),
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, shape));
			case 'MoveOverAt':
				var msg = sh.a;
				var shape = sh.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$MoveOverAt,
					A2($elm$core$Basics$composeL, f, msg),
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, shape));
			case 'TouchStart':
				var msg = sh.a;
				var shape = sh.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$TouchStart,
					f(msg),
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, shape));
			case 'TouchEnd':
				var msg = sh.a;
				var shape = sh.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$TouchEnd,
					f(msg),
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, shape));
			case 'TouchStartAt':
				var msg = sh.a;
				var shape = sh.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$TouchStartAt,
					A2($elm$core$Basics$composeL, f, msg),
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, shape));
			case 'TouchEndAt':
				var msg = sh.a;
				var shape = sh.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$TouchEndAt,
					A2($elm$core$Basics$composeL, f, msg),
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, shape));
			case 'TouchMoveAt':
				var msg = sh.a;
				var shape = sh.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$TouchMoveAt,
					A2($elm$core$Basics$composeL, f, msg),
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, shape));
			case 'PtrStart':
				var msg = sh.a;
				var shape = sh.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$PtrStart,
					A2($elm$core$Basics$composeR, msg, f),
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, shape));
			case 'PtrEnd':
				var msg = sh.a;
				var shape = sh.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$PtrEnd,
					A2($elm$core$Basics$composeR, msg, f),
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, shape));
			case 'PtrCancel':
				var msg = sh.a;
				var shape = sh.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$PtrCancel,
					A2($elm$core$Basics$composeR, msg, f),
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, shape));
			case 'PtrStartAt':
				var msg = sh.a;
				var shape = sh.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$PtrStartAt,
					F2(
						function (ptrTy, pos) {
							return f(
								A2(msg, ptrTy, pos));
						}),
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, shape));
			case 'PtrEndAt':
				var msg = sh.a;
				var shape = sh.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$PtrEndAt,
					F2(
						function (ptrTy, pos) {
							return f(
								A2(msg, ptrTy, pos));
						}),
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, shape));
			case 'PtrMoveAt':
				var msg = sh.a;
				var shape = sh.b;
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$PtrMoveAt,
					F2(
						function (ptrTy, pos) {
							return f(
								A2(msg, ptrTy, pos));
						}),
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, shape));
			case 'Group':
				var shapes = sh.a;
				return $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Group(
					A2(
						$elm$core$List$map,
						$MacCASOutreach$graphicsvg$GraphicSVG$map(f),
						shapes));
			case 'GroupOutline':
				var cmbndshp = sh.a;
				return $MacCASOutreach$graphicsvg$GraphicSVG$Secret$GroupOutline(
					A2($MacCASOutreach$graphicsvg$GraphicSVG$map, f, cmbndshp));
			default:
				var s = sh.a;
				var th = sh.b;
				var c = sh.c;
				return A3($MacCASOutreach$graphicsvg$GraphicSVG$Secret$GraphPaper, s, th, c);
		}
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$mapCollage = F2(
	function (f, _v0) {
		var w = _v0.a;
		var h = _v0.b;
		var shapes = _v0.c;
		return A3(
			$MacCASOutreach$graphicsvg$GraphicSVG$Collage,
			w,
			h,
			A2(
				$elm$core$List$map,
				$MacCASOutreach$graphicsvg$GraphicSVG$map(f),
				shapes));
	});
var $elm$time$Time$Name = function (a) {
	return {$: 'Name', a: a};
};
var $elm$time$Time$Offset = function (a) {
	return {$: 'Offset', a: a};
};
var $elm$time$Time$Zone = F2(
	function (a, b) {
		return {$: 'Zone', a: a, b: b};
	});
var $elm$time$Time$customZone = $elm$time$Time$Zone;
var $elm$time$Time$now = _Time_now($elm$time$Time$millisToPosix);
var $MacCASOutreach$graphicsvg$GraphicSVG$App$KeyDown = function (a) {
	return {$: 'KeyDown', a: a};
};
var $MacCASOutreach$graphicsvg$GraphicSVG$App$KeyUp = function (a) {
	return {$: 'KeyUp', a: a};
};
var $MacCASOutreach$graphicsvg$GraphicSVG$App$TickTime = function (a) {
	return {$: 'TickTime', a: a};
};
var $elm$browser$Browser$AnimationManager$Time = function (a) {
	return {$: 'Time', a: a};
};
var $elm$browser$Browser$AnimationManager$State = F3(
	function (subs, request, oldTime) {
		return {oldTime: oldTime, request: request, subs: subs};
	});
var $elm$browser$Browser$AnimationManager$init = $elm$core$Task$succeed(
	A3($elm$browser$Browser$AnimationManager$State, _List_Nil, $elm$core$Maybe$Nothing, 0));
var $elm$browser$Browser$AnimationManager$now = _Browser_now(_Utils_Tuple0);
var $elm$browser$Browser$AnimationManager$rAF = _Browser_rAF(_Utils_Tuple0);
var $elm$core$Process$spawn = _Scheduler_spawn;
var $elm$browser$Browser$AnimationManager$onEffects = F3(
	function (router, subs, _v0) {
		var request = _v0.request;
		var oldTime = _v0.oldTime;
		var _v1 = _Utils_Tuple2(request, subs);
		if (_v1.a.$ === 'Nothing') {
			if (!_v1.b.b) {
				var _v2 = _v1.a;
				return $elm$browser$Browser$AnimationManager$init;
			} else {
				var _v4 = _v1.a;
				return A2(
					$elm$core$Task$andThen,
					function (pid) {
						return A2(
							$elm$core$Task$andThen,
							function (time) {
								return $elm$core$Task$succeed(
									A3(
										$elm$browser$Browser$AnimationManager$State,
										subs,
										$elm$core$Maybe$Just(pid),
										time));
							},
							$elm$browser$Browser$AnimationManager$now);
					},
					$elm$core$Process$spawn(
						A2(
							$elm$core$Task$andThen,
							$elm$core$Platform$sendToSelf(router),
							$elm$browser$Browser$AnimationManager$rAF)));
			}
		} else {
			if (!_v1.b.b) {
				var pid = _v1.a.a;
				return A2(
					$elm$core$Task$andThen,
					function (_v3) {
						return $elm$browser$Browser$AnimationManager$init;
					},
					$elm$core$Process$kill(pid));
			} else {
				return $elm$core$Task$succeed(
					A3($elm$browser$Browser$AnimationManager$State, subs, request, oldTime));
			}
		}
	});
var $elm$browser$Browser$AnimationManager$onSelfMsg = F3(
	function (router, newTime, _v0) {
		var subs = _v0.subs;
		var oldTime = _v0.oldTime;
		var send = function (sub) {
			if (sub.$ === 'Time') {
				var tagger = sub.a;
				return A2(
					$elm$core$Platform$sendToApp,
					router,
					tagger(
						$elm$time$Time$millisToPosix(newTime)));
			} else {
				var tagger = sub.a;
				return A2(
					$elm$core$Platform$sendToApp,
					router,
					tagger(newTime - oldTime));
			}
		};
		return A2(
			$elm$core$Task$andThen,
			function (pid) {
				return A2(
					$elm$core$Task$andThen,
					function (_v1) {
						return $elm$core$Task$succeed(
							A3(
								$elm$browser$Browser$AnimationManager$State,
								subs,
								$elm$core$Maybe$Just(pid),
								newTime));
					},
					$elm$core$Task$sequence(
						A2($elm$core$List$map, send, subs)));
			},
			$elm$core$Process$spawn(
				A2(
					$elm$core$Task$andThen,
					$elm$core$Platform$sendToSelf(router),
					$elm$browser$Browser$AnimationManager$rAF)));
	});
var $elm$browser$Browser$AnimationManager$Delta = function (a) {
	return {$: 'Delta', a: a};
};
var $elm$browser$Browser$AnimationManager$subMap = F2(
	function (func, sub) {
		if (sub.$ === 'Time') {
			var tagger = sub.a;
			return $elm$browser$Browser$AnimationManager$Time(
				A2($elm$core$Basics$composeL, func, tagger));
		} else {
			var tagger = sub.a;
			return $elm$browser$Browser$AnimationManager$Delta(
				A2($elm$core$Basics$composeL, func, tagger));
		}
	});
_Platform_effectManagers['Browser.AnimationManager'] = _Platform_createManager($elm$browser$Browser$AnimationManager$init, $elm$browser$Browser$AnimationManager$onEffects, $elm$browser$Browser$AnimationManager$onSelfMsg, 0, $elm$browser$Browser$AnimationManager$subMap);
var $elm$browser$Browser$AnimationManager$subscription = _Platform_leaf('Browser.AnimationManager');
var $elm$browser$Browser$AnimationManager$onAnimationFrame = function (tagger) {
	return $elm$browser$Browser$AnimationManager$subscription(
		$elm$browser$Browser$AnimationManager$Time(tagger));
};
var $elm$browser$Browser$Events$onAnimationFrame = $elm$browser$Browser$AnimationManager$onAnimationFrame;
var $elm$browser$Browser$Events$Document = {$: 'Document'};
var $elm$browser$Browser$Events$onKeyDown = A2($elm$browser$Browser$Events$on, $elm$browser$Browser$Events$Document, 'keydown');
var $elm$browser$Browser$Events$onKeyUp = A2($elm$browser$Browser$Events$on, $elm$browser$Browser$Events$Document, 'keyup');
var $MacCASOutreach$graphicsvg$GraphicSVG$App$subs = _List_fromArray(
	[
		$elm$browser$Browser$Events$onKeyUp(
		A2(
			$elm$json$Json$Decode$map,
			$MacCASOutreach$graphicsvg$GraphicSVG$App$KeyUp,
			A2($elm$json$Json$Decode$field, 'keyCode', $elm$json$Json$Decode$int))),
		$elm$browser$Browser$Events$onKeyDown(
		A2(
			$elm$json$Json$Decode$map,
			$MacCASOutreach$graphicsvg$GraphicSVG$App$KeyDown,
			A2($elm$json$Json$Decode$field, 'keyCode', $elm$json$Json$Decode$int))),
		$elm$browser$Browser$Events$onAnimationFrame($MacCASOutreach$graphicsvg$GraphicSVG$App$TickTime)
	]);
var $MacCASOutreach$graphicsvg$GraphicSVG$App$gameApp = F2(
	function (tickMsg, userApp) {
		var userView = userApp.view;
		var userUpdate = userApp.update;
		var userTitle = userApp.title;
		var userInit = userApp.model;
		return $MacCASOutreach$graphicsvg$GraphicSVG$app(
			{
				init: F3(
					function (_v0, _v1, navKey) {
						return _Utils_Tuple2(
							_Utils_Tuple2(
								userInit,
								A2($MacCASOutreach$graphicsvg$GraphicSVG$App$initHiddenModel, tickMsg, navKey)),
							A2($elm$core$Task$perform, $MacCASOutreach$graphicsvg$GraphicSVG$App$InitTime, $elm$time$Time$now));
					}),
				onUrlChange: $MacCASOutreach$graphicsvg$GraphicSVG$App$URLChanged,
				onUrlRequest: $MacCASOutreach$graphicsvg$GraphicSVG$App$URLRequest,
				subscriptions: function (_v2) {
					return $elm$core$Platform$Sub$batch($MacCASOutreach$graphicsvg$GraphicSVG$App$subs);
				},
				update: $MacCASOutreach$graphicsvg$GraphicSVG$App$hiddenGameUpdate(userUpdate),
				view: function (_v3) {
					var userModel = _v3.a;
					return {
						body: A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$mapCollage,
							$MacCASOutreach$graphicsvg$GraphicSVG$App$UserMsg,
							userView(userModel)),
						title: userApp.title
					};
				}
			});
	});
var $author$project$Main$Welcome = function (a) {
	return {$: 'Welcome', a: a};
};
var $author$project$Main$init = {
	startTime: 0,
	state: $author$project$Main$Welcome(true),
	time: 0
};
var $author$project$Main$Scene1 = {$: 'Scene1'};
var $author$project$Main$Scene2 = {$: 'Scene2'};
var $author$project$Main$Scene2End = {$: 'Scene2End'};
var $author$project$Main$Scene3 = {$: 'Scene3'};
var $author$project$Main$Scene4 = {$: 'Scene4'};
var $author$project$Main$Scene4End = {$: 'Scene4End'};
var $author$project$Main$Scene4half = {$: 'Scene4half'};
var $author$project$Main$Scene5 = {$: 'Scene5'};
var $author$project$Main$SceneEnd = {$: 'SceneEnd'};
var $author$project$Main$update = F2(
	function (msg, model) {
		switch (msg.$) {
			case 'Tick':
				var t = msg.a;
				return _Utils_update(
					model,
					{time: t});
			case 'HideInstructions':
				var _v1 = model.state;
				if (_v1.$ === 'Welcome') {
					return _Utils_update(
						model,
						{
							startTime: model.time,
							state: $author$project$Main$Welcome(false)
						});
				} else {
					var otherwise = _v1;
					return model;
				}
			case 'WelcomeTo1':
				var _v2 = model.state;
				if (_v2.$ === 'Welcome') {
					return _Utils_update(
						model,
						{startTime: model.time, state: $author$project$Main$Scene1});
				} else {
					var otherwise = _v2;
					return model;
				}
			case 'Restart1':
				var _v3 = model.state;
				if (_v3.$ === 'Scene1') {
					return _Utils_update(
						model,
						{startTime: model.time});
				} else {
					var otherwise = _v3;
					return model;
				}
			case 'Restart2':
				var _v4 = model.state;
				if (_v4.$ === 'Scene2') {
					return _Utils_update(
						model,
						{startTime: model.time});
				} else {
					var otherwise = _v4;
					return model;
				}
			case 'Restart2end':
				var _v5 = model.state;
				if (_v5.$ === 'Scene2End') {
					return _Utils_update(
						model,
						{startTime: model.time});
				} else {
					var otherwise = _v5;
					return model;
				}
			case 'Restart3':
				var _v6 = model.state;
				if (_v6.$ === 'Scene3') {
					return _Utils_update(
						model,
						{startTime: model.time});
				} else {
					var otherwise = _v6;
					return model;
				}
			case 'Restart4':
				var _v7 = model.state;
				if (_v7.$ === 'Scene4') {
					return _Utils_update(
						model,
						{startTime: model.time});
				} else {
					var otherwise = _v7;
					return model;
				}
			case 'Restart4half':
				var _v8 = model.state;
				if (_v8.$ === 'Scene4half') {
					return _Utils_update(
						model,
						{startTime: model.time});
				} else {
					var otherwise = _v8;
					return model;
				}
			case 'Restart4end':
				var _v9 = model.state;
				if (_v9.$ === 'Scene4End') {
					return _Utils_update(
						model,
						{startTime: model.time});
				} else {
					var otherwise = _v9;
					return model;
				}
			case 'Restart5':
				var _v10 = model.state;
				if (_v10.$ === 'Scene5') {
					return _Utils_update(
						model,
						{startTime: model.time});
				} else {
					var otherwise = _v10;
					return model;
				}
			case 'Restartend':
				var _v11 = model.state;
				if (_v11.$ === 'SceneEnd') {
					return _Utils_update(
						model,
						{startTime: model.time});
				} else {
					var otherwise = _v11;
					return model;
				}
			case 'T1to2':
				var _v12 = model.state;
				if (_v12.$ === 'Scene1') {
					return _Utils_update(
						model,
						{startTime: model.time, state: $author$project$Main$Scene2});
				} else {
					var otherwise = _v12;
					return model;
				}
			case 'T1to3':
				var _v13 = model.state;
				if (_v13.$ === 'Scene1') {
					return _Utils_update(
						model,
						{startTime: model.time, state: $author$project$Main$Scene3});
				} else {
					var otherwise = _v13;
					return model;
				}
			case 'T2toend':
				var _v14 = model.state;
				if (_v14.$ === 'Scene2') {
					return _Utils_update(
						model,
						{startTime: model.time, state: $author$project$Main$Scene2End});
				} else {
					var otherwise = _v14;
					return model;
				}
			case 'T2to3':
				var _v15 = model.state;
				if (_v15.$ === 'Scene2') {
					return _Utils_update(
						model,
						{startTime: model.time, state: $author$project$Main$Scene3});
				} else {
					var otherwise = _v15;
					return model;
				}
			case 'T3to4':
				var _v16 = model.state;
				if (_v16.$ === 'Scene3') {
					return _Utils_update(
						model,
						{startTime: model.time, state: $author$project$Main$Scene4});
				} else {
					var otherwise = _v16;
					return model;
				}
			case 'T3to5':
				var _v17 = model.state;
				if (_v17.$ === 'Scene3') {
					return _Utils_update(
						model,
						{startTime: model.time, state: $author$project$Main$Scene5});
				} else {
					var otherwise = _v17;
					return model;
				}
			case 'T4toend':
				var _v18 = model.state;
				if (_v18.$ === 'Scene4') {
					return _Utils_update(
						model,
						{startTime: model.time, state: $author$project$Main$Scene4End});
				} else {
					var otherwise = _v18;
					return model;
				}
			case 'T4to4half':
				var _v19 = model.state;
				if (_v19.$ === 'Scene4') {
					return _Utils_update(
						model,
						{startTime: model.time, state: $author$project$Main$Scene4half});
				} else {
					var otherwise = _v19;
					return model;
				}
			case 'T4halfto5':
				var _v20 = model.state;
				if (_v20.$ === 'Scene4half') {
					return _Utils_update(
						model,
						{state: $author$project$Main$Scene5});
				} else {
					var otherwise = _v20;
					return model;
				}
			case 'T5toFINALend':
				var _v21 = model.state;
				if (_v21.$ === 'Scene5') {
					return _Utils_update(
						model,
						{state: $author$project$Main$SceneEnd});
				} else {
					var otherwise = _v21;
					return model;
				}
			case 'End4ToWelcome':
				var _v22 = model.state;
				if (_v22.$ === 'Scene4End') {
					return _Utils_update(
						model,
						{
							state: $author$project$Main$Welcome(false)
						});
				} else {
					var otherwise = _v22;
					return model;
				}
			default:
				var _v23 = model.state;
				if (_v23.$ === 'Scene2End') {
					return _Utils_update(
						model,
						{
							state: $author$project$Main$Welcome(false)
						});
				} else {
					var otherwise = _v23;
					return model;
				}
		}
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$collage = F3(
	function (w, h, shapes) {
		return A3($MacCASOutreach$graphicsvg$GraphicSVG$Collage, w, h, shapes);
	});
var $author$project$Main$Cody = {$: 'Cody'};
var $author$project$Main$Either = {$: 'Either'};
var $author$project$Main$End2ToWelcome = {$: 'End2ToWelcome'};
var $author$project$Main$End4ToWelcome = {$: 'End4ToWelcome'};
var $author$project$Main$HideInstructions = {$: 'HideInstructions'};
var $author$project$Main$Mermaid = {$: 'Mermaid'};
var $author$project$Main$Nar = {$: 'Nar'};
var $author$project$Main$Or = {$: 'Or'};
var $author$project$Main$Pixar = {$: 'Pixar'};
var $author$project$Main$Restart1 = {$: 'Restart1'};
var $author$project$Main$Restart2 = {$: 'Restart2'};
var $author$project$Main$Restart2end = {$: 'Restart2end'};
var $author$project$Main$Restart3 = {$: 'Restart3'};
var $author$project$Main$Restart4 = {$: 'Restart4'};
var $author$project$Main$Restart4end = {$: 'Restart4end'};
var $author$project$Main$Restart4half = {$: 'Restart4half'};
var $author$project$Main$Restart5 = {$: 'Restart5'};
var $author$project$Main$Restartend = {$: 'Restartend'};
var $author$project$Main$T1to2 = {$: 'T1to2'};
var $author$project$Main$T1to3 = {$: 'T1to3'};
var $author$project$Main$T2to3 = {$: 'T2to3'};
var $author$project$Main$T2toend = {$: 'T2toend'};
var $author$project$Main$T3to4 = {$: 'T3to4'};
var $author$project$Main$T3to5 = {$: 'T3to5'};
var $author$project$Main$T4halfto5 = {$: 'T4halfto5'};
var $author$project$Main$T4to4half = {$: 'T4to4half'};
var $author$project$Main$T4toend = {$: 'T4toend'};
var $author$project$Main$T5toFINALend = {$: 'T5toFINALend'};
var $author$project$Main$WelcomeTo1 = {$: 'WelcomeTo1'};
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull = F2(
	function (a, b) {
		return {$: 'Pull', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$NoLine = {$: 'NoLine'};
var $MacCASOutreach$graphicsvg$GraphicSVG$blank = A4($MacCASOutreach$graphicsvg$GraphicSVG$rgba, 0, 0, 0, 0);
var $MacCASOutreach$graphicsvg$GraphicSVG$subtract = F2(
	function (shape1, shape2) {
		return A2($MacCASOutreach$graphicsvg$GraphicSVG$Secret$AlphaMask, shape1, shape2);
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$addOutline = F3(
	function (style, outlineClr, shape) {
		addOutline:
		while (true) {
			var lineStyle = function () {
				if (style.$ === 'NoLine') {
					return $elm$core$Maybe$Nothing;
				} else {
					return $elm$core$Maybe$Just(
						_Utils_Tuple2(style, outlineClr));
				}
			}();
			switch (shape.$) {
				case 'Inked':
					var clr = shape.a;
					var st = shape.c;
					return A3($MacCASOutreach$graphicsvg$GraphicSVG$Secret$Inked, clr, lineStyle, st);
				case 'Move':
					var s = shape.a;
					var sh = shape.b;
					return A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Move,
						s,
						A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, style, outlineClr, sh));
				case 'Rotate':
					var r = shape.a;
					var sh = shape.b;
					return A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Rotate,
						r,
						A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, style, outlineClr, sh));
				case 'Scale':
					var sx = shape.a;
					var sy = shape.b;
					var sh = shape.c;
					return A3(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Scale,
						sx,
						sy,
						A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, style, outlineClr, sh));
				case 'Skew':
					var skx = shape.a;
					var sky = shape.b;
					var sh = shape.c;
					return A3(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Skew,
						skx,
						sky,
						A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, style, outlineClr, sh));
				case 'Transformed':
					var tm = shape.a;
					var sh = shape.b;
					return A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Transformed,
						tm,
						A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, style, outlineClr, sh));
				case 'Group':
					var list = shape.a;
					var innerlist = A2(
						$elm$core$List$filterMap,
						function (shp) {
							if (shp.$ === 'GroupOutline') {
								return $elm$core$Maybe$Nothing;
							} else {
								return $elm$core$Maybe$Just(
									A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, $MacCASOutreach$graphicsvg$GraphicSVG$Secret$NoLine, $MacCASOutreach$graphicsvg$GraphicSVG$black, shp));
							}
						},
						list);
					if (!innerlist.b) {
						return $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Group(_List_Nil);
					} else {
						if (!innerlist.b.b) {
							var hd = innerlist.a;
							var $temp$style = style,
								$temp$outlineClr = outlineClr,
								$temp$shape = hd;
							style = $temp$style;
							outlineClr = $temp$outlineClr;
							shape = $temp$shape;
							continue addOutline;
						} else {
							if (_Utils_eq(lineStyle, $elm$core$Maybe$Nothing)) {
								return $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Group(innerlist);
							} else {
								var outlnshp = $MacCASOutreach$graphicsvg$GraphicSVG$Secret$GroupOutline(
									A2(
										$MacCASOutreach$graphicsvg$GraphicSVG$subtract,
										$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Group(innerlist),
										$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Group(
											A2(
												$elm$core$List$map,
												A2($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, style, outlineClr),
												innerlist))));
								return $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Group(
									_Utils_ap(
										innerlist,
										_List_fromArray(
											[outlnshp])));
							}
						}
					}
				case 'GroupOutline':
					var cmbndshp = shape.a;
					return $MacCASOutreach$graphicsvg$GraphicSVG$Secret$GroupOutline(cmbndshp);
				case 'AlphaMask':
					var reg = shape.a;
					var sh = shape.b;
					var ptrn = A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, $MacCASOutreach$graphicsvg$GraphicSVG$Secret$NoLine, $MacCASOutreach$graphicsvg$GraphicSVG$black, reg);
					var inside = A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, $MacCASOutreach$graphicsvg$GraphicSVG$Secret$NoLine, $MacCASOutreach$graphicsvg$GraphicSVG$black, sh);
					if (_Utils_eq(lineStyle, $elm$core$Maybe$Nothing)) {
						return A2($MacCASOutreach$graphicsvg$GraphicSVG$Secret$AlphaMask, ptrn, inside);
					} else {
						var ptrnlnd = A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, style, outlineClr, reg);
						var ptrnoutln = A2($MacCASOutreach$graphicsvg$GraphicSVG$Secret$Clip, inside, ptrnlnd);
						var newshp = A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, style, outlineClr, sh);
						var shpoutln = A2($MacCASOutreach$graphicsvg$GraphicSVG$Secret$Clip, inside, newshp);
						return A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$AlphaMask,
							ptrn,
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Group(
								_List_fromArray(
									[
										inside,
										$MacCASOutreach$graphicsvg$GraphicSVG$Secret$GroupOutline(
										$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Group(
											_List_fromArray(
												[shpoutln, ptrnoutln])))
									])));
					}
				case 'Clip':
					var reg = shape.a;
					var sh = shape.b;
					var ptrn = A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, $MacCASOutreach$graphicsvg$GraphicSVG$Secret$NoLine, $MacCASOutreach$graphicsvg$GraphicSVG$black, reg);
					var inside = A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, $MacCASOutreach$graphicsvg$GraphicSVG$Secret$NoLine, $MacCASOutreach$graphicsvg$GraphicSVG$black, sh);
					if (_Utils_eq(lineStyle, $elm$core$Maybe$Nothing)) {
						return A2($MacCASOutreach$graphicsvg$GraphicSVG$Secret$Clip, ptrn, inside);
					} else {
						var ptrnlnd = A3(
							$MacCASOutreach$graphicsvg$GraphicSVG$addOutline,
							style,
							outlineClr,
							A2($MacCASOutreach$graphicsvg$GraphicSVG$repaint, $MacCASOutreach$graphicsvg$GraphicSVG$blank, reg));
						var ptrnoutln = A2($MacCASOutreach$graphicsvg$GraphicSVG$Secret$Clip, inside, ptrnlnd);
						var newshp = A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, style, outlineClr, sh);
						var shpoutln = A2($MacCASOutreach$graphicsvg$GraphicSVG$Secret$Clip, inside, newshp);
						return A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Clip,
							ptrn,
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Group(
								_List_fromArray(
									[
										inside,
										$MacCASOutreach$graphicsvg$GraphicSVG$Secret$GroupOutline(
										$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Group(
											_List_fromArray(
												[shpoutln, ptrnoutln])))
									])));
					}
				case 'Link':
					var s = shape.a;
					var sh = shape.b;
					return A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Link,
						s,
						A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, style, outlineClr, sh));
				case 'Tap':
					var userMsg = shape.a;
					var sh = shape.b;
					return A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Tap,
						userMsg,
						A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, style, outlineClr, sh));
				case 'TapAt':
					var userMsg = shape.a;
					var sh = shape.b;
					return A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$TapAt,
						userMsg,
						A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, style, outlineClr, sh));
				case 'EnterShape':
					var userMsg = shape.a;
					var sh = shape.b;
					return A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$EnterShape,
						userMsg,
						A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, style, outlineClr, sh));
				case 'EnterAt':
					var userMsg = shape.a;
					var sh = shape.b;
					return A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$EnterAt,
						userMsg,
						A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, style, outlineClr, sh));
				case 'Exit':
					var userMsg = shape.a;
					var sh = shape.b;
					return A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Exit,
						userMsg,
						A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, style, outlineClr, sh));
				case 'ExitAt':
					var userMsg = shape.a;
					var sh = shape.b;
					return A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$ExitAt,
						userMsg,
						A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, style, outlineClr, sh));
				case 'MouseDown':
					var userMsg = shape.a;
					var sh = shape.b;
					return A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$MouseDown,
						userMsg,
						A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, style, outlineClr, sh));
				case 'MouseDownAt':
					var userMsg = shape.a;
					var sh = shape.b;
					return A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$MouseDownAt,
						userMsg,
						A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, style, outlineClr, sh));
				case 'MouseUp':
					var userMsg = shape.a;
					var sh = shape.b;
					return A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$MouseUp,
						userMsg,
						A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, style, outlineClr, sh));
				case 'MouseUpAt':
					var userMsg = shape.a;
					var sh = shape.b;
					return A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$MouseUpAt,
						userMsg,
						A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, style, outlineClr, sh));
				case 'MoveOverAt':
					var userMsg = shape.a;
					var sh = shape.b;
					return A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$MoveOverAt,
						userMsg,
						A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, style, outlineClr, sh));
				case 'TouchStart':
					var userMsg = shape.a;
					var sh = shape.b;
					return A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$TouchStart,
						userMsg,
						A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, style, outlineClr, sh));
				case 'TouchEnd':
					var userMsg = shape.a;
					var sh = shape.b;
					return A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$TouchEnd,
						userMsg,
						A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, style, outlineClr, sh));
				case 'TouchStartAt':
					var userMsg = shape.a;
					var sh = shape.b;
					return A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$TouchStartAt,
						userMsg,
						A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, style, outlineClr, sh));
				case 'TouchEndAt':
					var userMsg = shape.a;
					var sh = shape.b;
					return A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$TouchEndAt,
						userMsg,
						A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, style, outlineClr, sh));
				case 'TouchMoveAt':
					var userMsg = shape.a;
					var sh = shape.b;
					return A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$TouchMoveAt,
						userMsg,
						A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, style, outlineClr, sh));
				case 'PtrStart':
					var userMsg = shape.a;
					var sh = shape.b;
					return A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$PtrStart,
						userMsg,
						A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, style, outlineClr, sh));
				case 'PtrEnd':
					var userMsg = shape.a;
					var sh = shape.b;
					return A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$PtrEnd,
						userMsg,
						A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, style, outlineClr, sh));
				case 'PtrCancel':
					var userMsg = shape.a;
					var sh = shape.b;
					return A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$PtrCancel,
						userMsg,
						A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, style, outlineClr, sh));
				case 'PtrStartAt':
					var userMsg = shape.a;
					var sh = shape.b;
					return A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$PtrStartAt,
						userMsg,
						A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, style, outlineClr, sh));
				case 'PtrEndAt':
					var userMsg = shape.a;
					var sh = shape.b;
					return A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$PtrEndAt,
						userMsg,
						A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, style, outlineClr, sh));
				case 'PtrMoveAt':
					var userMsg = shape.a;
					var sh = shape.b;
					return A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$PtrMoveAt,
						userMsg,
						A3($MacCASOutreach$graphicsvg$GraphicSVG$addOutline, style, outlineClr, sh));
				case 'ForeignObject':
					var w = shape.a;
					var h = shape.b;
					var htm = shape.c;
					return A3($MacCASOutreach$graphicsvg$GraphicSVG$Secret$ForeignObject, w, h, htm);
				case 'Everything':
					return $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Everything;
				case 'Notathing':
					return $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Notathing;
				default:
					var s = shape.a;
					var th = shape.b;
					var clr = shape.c;
					return A3($MacCASOutreach$graphicsvg$GraphicSVG$Secret$GraphPaper, s, th, clr);
			}
		}
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$clip = F2(
	function (shape1, shape2) {
		return A2($MacCASOutreach$graphicsvg$GraphicSVG$Secret$Clip, shape1, shape2);
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$BezierPath = F2(
	function (a, b) {
		return {$: 'BezierPath', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$curveListHelper = function (_v0) {
	var _v1 = _v0.a;
	var a = _v1.a;
	var b = _v1.b;
	var _v2 = _v0.b;
	var c = _v2.a;
	var d = _v2.b;
	return _Utils_Tuple2(
		_Utils_Tuple2(a, b),
		_Utils_Tuple2(c, d));
};
var $MacCASOutreach$graphicsvg$GraphicSVG$curve = F2(
	function (_v0, list) {
		var a = _v0.a;
		var b = _v0.b;
		return A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$Secret$BezierPath,
			_Utils_Tuple2(a, b),
			A2($elm$core$List$map, $MacCASOutreach$graphicsvg$GraphicSVG$curveListHelper, list));
	});
var $elm$core$Basics$degrees = function (angleInDegrees) {
	return (angleInDegrees * $elm$core$Basics$pi) / 180;
};
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Gradient = function (a) {
	return {$: 'Gradient', a: a};
};
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$LinearGradient = F2(
	function (a, b) {
		return {$: 'LinearGradient', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$gradient = function (stops) {
	return $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Gradient(
		A2($MacCASOutreach$graphicsvg$GraphicSVG$Secret$LinearGradient, 0, stops));
};
var $MacCASOutreach$graphicsvg$GraphicSVG$gray = A4($MacCASOutreach$graphicsvg$GraphicSVG$rgba, 211, 215, 207, 1);
var $elm$core$Basics$abs = function (n) {
	return (n < 0) ? (-n) : n;
};
var $MacCASOutreach$graphicsvg$GraphicSVG$findChroma = F2(
	function (lit, sat) {
		return (1 - $elm$core$Basics$abs((2 * lit) - 1)) * sat;
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$findM = F2(
	function (lit, chroma) {
		return lit - (0.5 * chroma);
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$mapTriple = F2(
	function (f, _v0) {
		var a1 = _v0.a;
		var a2 = _v0.b;
		var a3 = _v0.c;
		return _Utils_Tuple3(
			f(a1),
			f(a2),
			f(a3));
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$modFloat = F2(
	function (x, m) {
		return x - (m * $elm$core$Basics$floor(x / m));
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$findHue_ = function (hue) {
	return hue / $elm$core$Basics$degrees(60);
};
var $MacCASOutreach$graphicsvg$GraphicSVG$findX = F2(
	function (chroma, hue) {
		return chroma * (1 - $elm$core$Basics$abs(
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$modFloat,
				$MacCASOutreach$graphicsvg$GraphicSVG$findHue_(hue),
				2) - 1));
	});
var $elm$core$Basics$ge = _Utils_ge;
var $MacCASOutreach$graphicsvg$GraphicSVG$toRGB_ = F3(
	function (hue, sat, lit) {
		var hue_ = $MacCASOutreach$graphicsvg$GraphicSVG$findHue_(hue);
		var chroma = A2($MacCASOutreach$graphicsvg$GraphicSVG$findChroma, lit, sat);
		var x = A2($MacCASOutreach$graphicsvg$GraphicSVG$findX, chroma, hue);
		return ((hue_ >= 0) && (hue_ < 1)) ? _Utils_Tuple3(chroma, x, 0) : (((hue_ >= 1) && (hue_ < 2)) ? _Utils_Tuple3(x, chroma, 0) : (((hue_ >= 2) && (hue_ < 3)) ? _Utils_Tuple3(0, chroma, x) : (((hue_ >= 3) && (hue_ < 4)) ? _Utils_Tuple3(0, x, chroma) : (((hue_ >= 4) && (hue_ < 5)) ? _Utils_Tuple3(x, 0, chroma) : (((hue_ >= 5) && (hue_ < 6)) ? _Utils_Tuple3(chroma, 0, x) : _Utils_Tuple3(0, 0, 0))))));
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$convert = F3(
	function (hue, sat, lit) {
		var hue_ = A2($MacCASOutreach$graphicsvg$GraphicSVG$modFloat, hue, 2 * $elm$core$Basics$pi);
		var rgb_ = A3($MacCASOutreach$graphicsvg$GraphicSVG$toRGB_, hue_, sat, lit);
		var chroma = A2($MacCASOutreach$graphicsvg$GraphicSVG$findChroma, lit, sat);
		var m = A2($MacCASOutreach$graphicsvg$GraphicSVG$findM, lit, chroma);
		return A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$mapTriple,
			function (x) {
				return x * 255;
			},
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$mapTriple,
				function (x) {
					return x + m;
				},
				rgb_));
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$hsl = F3(
	function (h, s, l) {
		var _v0 = A3($MacCASOutreach$graphicsvg$GraphicSVG$convert, h, s, l);
		var r = _v0.a;
		var g = _v0.b;
		var b = _v0.c;
		return A4($MacCASOutreach$graphicsvg$GraphicSVG$rgba, r, g, b, 1);
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Polygon = function (a) {
	return {$: 'Polygon', a: a};
};
var $elm$core$Basics$turns = function (angleInTurns) {
	return (2 * $elm$core$Basics$pi) * angleInTurns;
};
var $MacCASOutreach$graphicsvg$GraphicSVG$ptOnCircle = F3(
	function (r, n, cn) {
		var angle = $elm$core$Basics$turns(cn / n);
		return _Utils_Tuple2(
			r * $elm$core$Basics$cos(angle),
			r * $elm$core$Basics$sin(angle));
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$ngon = F2(
	function (n, r) {
		return $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Polygon(
			A2(
				$elm$core$List$map,
				A2(
					$elm$core$Basics$composeL,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$ptOnCircle, r, n),
					$elm$core$Basics$toFloat),
				A2($elm$core$List$range, 0, n)));
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Oval = F2(
	function (a, b) {
		return {$: 'Oval', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$oval = F2(
	function (w, h) {
		return A2($MacCASOutreach$graphicsvg$GraphicSVG$Secret$Oval, w, h);
	});
var $author$project$Main$fractionalModBy = F2(
	function (m, x) {
		return x - (m * $elm$core$Basics$floor(x / m));
	});
var $author$project$Main$repeatDuration = F4(
	function (duration, start, end, t) {
		return start + (((end - start) * A2($author$project$Main$fractionalModBy, duration, t)) / duration);
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$rotate = F2(
	function (theta, shape) {
		return A2($MacCASOutreach$graphicsvg$GraphicSVG$Secret$Rotate, theta, shape);
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$scale = F2(
	function (s, shape) {
		return A3($MacCASOutreach$graphicsvg$GraphicSVG$Secret$Scale, s, s, shape);
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$scaleX = F2(
	function (s, shape) {
		return A3($MacCASOutreach$graphicsvg$GraphicSVG$Secret$Scale, s, 1, shape);
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$lightGreen = A4($MacCASOutreach$graphicsvg$GraphicSVG$rgba, 138, 226, 52, 1);
var $author$project$Main$seaweedRock = $MacCASOutreach$graphicsvg$GraphicSVG$group(
	_List_fromArray(
		[
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(0, 12),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$lightGreen,
				A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 2, 25))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
			$elm$core$Basics$degrees(20),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(0, 10),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					$MacCASOutreach$graphicsvg$GraphicSVG$lightGreen,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 2, 20)))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
			$elm$core$Basics$degrees(-20),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(0, 10),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					$MacCASOutreach$graphicsvg$GraphicSVG$lightGreen,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 2, 20))))
		]));
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Unbroken = function (a) {
	return {$: 'Unbroken', a: a};
};
var $MacCASOutreach$graphicsvg$GraphicSVG$solid = function (th) {
	return $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Unbroken(th);
};
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Stop = F3(
	function (a, b, c) {
		return {$: 'Stop', a: a, b: b, c: c};
	});
var $avh4$elm_color$Color$rgba = F4(
	function (r, g, b, a) {
		return A4($avh4$elm_color$Color$RgbaSpace, r, g, b, a);
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$stop = F2(
	function (col, pos) {
		if (col.$ === 'Solid') {
			var colour = col.a;
			return A3($MacCASOutreach$graphicsvg$GraphicSVG$Secret$Stop, pos, 1, colour);
		} else {
			return A3(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Stop,
				pos,
				1,
				A4($avh4$elm_color$Color$rgba, 0, 0, 0, 0));
		}
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$wedgeHelper = F2(
	function (r, cn) {
		var angle = $elm$core$Basics$turns(0.5 * cn);
		return _Utils_Tuple2(
			r * $elm$core$Basics$cos(angle),
			r * $elm$core$Basics$sin(angle));
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$wedge = F2(
	function (r, frac) {
		var n = ((frac * 360) / 10) + 5;
		var ni = $elm$core$Basics$round(n);
		var dlta = frac / ni;
		return $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Polygon(
			(frac > 0) ? _Utils_ap(
				_List_fromArray(
					[
						_Utils_Tuple2(0, 0),
						A2($MacCASOutreach$graphicsvg$GraphicSVG$wedgeHelper, r, -frac)
					]),
				_Utils_ap(
					A2(
						$elm$core$List$map,
						A2(
							$elm$core$Basics$composeL,
							A2(
								$elm$core$Basics$composeL,
								$MacCASOutreach$graphicsvg$GraphicSVG$wedgeHelper(r),
								$elm$core$Basics$mul(dlta)),
							$elm$core$Basics$toFloat),
						A2($elm$core$List$range, -ni, ni)),
					_List_fromArray(
						[
							A2($MacCASOutreach$graphicsvg$GraphicSVG$wedgeHelper, r, frac),
							_Utils_Tuple2(0, 0)
						]))) : _List_Nil);
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$yellow = A4($MacCASOutreach$graphicsvg$GraphicSVG$rgba, 237, 212, 0, 1);
var $author$project$Main$treasureChess = $MacCASOutreach$graphicsvg$GraphicSVG$group(
	_List_fromArray(
		[
			A3(
			$MacCASOutreach$graphicsvg$GraphicSVG$addOutline,
			$MacCASOutreach$graphicsvg$GraphicSVG$solid(1),
			$MacCASOutreach$graphicsvg$GraphicSVG$black,
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$hsl,
					$elm$core$Basics$degrees(32),
					0.568,
					0.4),
				A2($MacCASOutreach$graphicsvg$GraphicSVG$rect, 24, 15))),
			A3(
			$MacCASOutreach$graphicsvg$GraphicSVG$addOutline,
			$MacCASOutreach$graphicsvg$GraphicSVG$solid(0.8),
			$MacCASOutreach$graphicsvg$GraphicSVG$black,
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$hsl,
					$elm$core$Basics$degrees(32),
					0.568,
					0.4),
				A2($MacCASOutreach$graphicsvg$GraphicSVG$rect, 24, 5))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(0, 7.5),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
				$elm$core$Basics$degrees(90),
				A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$addOutline,
					$MacCASOutreach$graphicsvg$GraphicSVG$solid(1),
					$MacCASOutreach$graphicsvg$GraphicSVG$black,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$filled,
						A3(
							$MacCASOutreach$graphicsvg$GraphicSVG$hsl,
							$elm$core$Basics$degrees(32),
							0.568,
							0.4),
						A2($MacCASOutreach$graphicsvg$GraphicSVG$wedge, 12, 0.5))))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-11, 7),
			A3(
				$MacCASOutreach$graphicsvg$GraphicSVG$addOutline,
				$MacCASOutreach$graphicsvg$GraphicSVG$solid(0.5),
				$MacCASOutreach$graphicsvg$GraphicSVG$black,
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					$MacCASOutreach$graphicsvg$GraphicSVG$yellow,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$rect, 3.5, 3))))
		]));
var $author$project$Main$MyCurve = F2(
	function (a, b) {
		return {$: 'MyCurve', a: a, b: b};
	});
var $author$project$Main$addTurtle = F2(
	function (_v0, _v1) {
		var x = _v0.a;
		var y = _v0.b;
		var u = _v1.a;
		var v = _v1.b;
		return _Utils_Tuple2(x + u, y + v);
	});
var $author$project$Main$addPull = F2(
	function (_v0, _v1) {
		var p0 = _v0.a;
		var p1 = _v0.b;
		var p2 = _v1.a;
		var p3 = _v1.b;
		return A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
			A2($author$project$Main$addTurtle, p0, p2),
			A2($author$project$Main$addTurtle, p1, p3));
	});
var $author$project$Main$addCurve = F2(
	function (_v0, _v1) {
		var p0 = _v0.a;
		var pulls0 = _v0.b;
		var p1 = _v1.a;
		var pulls1 = _v1.b;
		return A2(
			$author$project$Main$MyCurve,
			A2($author$project$Main$addTurtle, p0, p1),
			A3($elm$core$List$map2, $author$project$Main$addPull, pulls0, pulls1));
	});
var $author$project$Main$animationPieces = F3(
	function (pieces, _default, t) {
		animationPieces:
		while (true) {
			if (pieces.b) {
				var _v1 = pieces.a;
				var duration = _v1.a;
				var shape = _v1.b;
				var rest = pieces.b;
				if (_Utils_cmp(t, duration) < 1) {
					return shape(t);
				} else {
					var $temp$pieces = rest,
						$temp$default = _default,
						$temp$t = t - duration;
					pieces = $temp$pieces;
					_default = $temp$default;
					t = $temp$t;
					continue animationPieces;
				}
			} else {
				return _default(t);
			}
		}
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$brown = A4($MacCASOutreach$graphicsvg$GraphicSVG$rgba, 193, 125, 17, 1);
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Circle = function (a) {
	return {$: 'Circle', a: a};
};
var $MacCASOutreach$graphicsvg$GraphicSVG$circle = function (r) {
	return $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Circle(r);
};
var $MacCASOutreach$graphicsvg$GraphicSVG$darkBrown = A4($MacCASOutreach$graphicsvg$GraphicSVG$rgba, 143, 89, 2, 1);
var $MacCASOutreach$graphicsvg$GraphicSVG$darkGreen = A4($MacCASOutreach$graphicsvg$GraphicSVG$rgba, 78, 154, 6, 1);
var $author$project$Main$drawCurve = function (_v0) {
	var p0 = _v0.a;
	var pulls = _v0.b;
	return A2($MacCASOutreach$graphicsvg$GraphicSVG$curve, p0, pulls);
};
var $author$project$Main$flippersTurtle = _List_fromArray(
	[
		A2(
		$author$project$Main$MyCurve,
		_Utils_Tuple2(-21.45, 2.7042),
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-25.41, -4.687),
				_Utils_Tuple2(-29.38, -12.07)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-29.56, -13.34),
				_Utils_Tuple2(-29.74, -14.60)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-29.92, -15.32),
				_Utils_Tuple2(-30.10, -16.04)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-29.74, -17.12),
				_Utils_Tuple2(-29.38, -18.20)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-28.30, -20.55),
				_Utils_Tuple2(-27.22, -22.89)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-24.87, -25.6),
				_Utils_Tuple2(-22.53, -28.30)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-19.29, -30.82),
				_Utils_Tuple2(-16.04, -33.35)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-9.915, -36.59),
				_Utils_Tuple2(-3.785, -39.84)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(0.9014, -40.92),
				_Utils_Tuple2(5.5887, -42.00)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(7.0309, -41.64),
				_Utils_Tuple2(8.4732, -41.28)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(8.8338, -40.38),
				_Utils_Tuple2(9.1943, -39.48)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(8.6535, -38.21),
				_Utils_Tuple2(8.1126, -36.95)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(2.7042, -31.36),
				_Utils_Tuple2(-2.704, -25.78)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-4.146, -23.61),
				_Utils_Tuple2(-5.588, -21.45)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-7.030, -17.66),
				_Utils_Tuple2(-8.473, -13.88)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-8.653, -11.53),
				_Utils_Tuple2(-8.833, -9.194)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-7.211, -3.605),
				_Utils_Tuple2(-5.588, 1.9830)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-13.52, 2.3436),
				_Utils_Tuple2(-21.45, 2.7042))
			])),
		A2(
		$author$project$Main$MyCurve,
		_Utils_Tuple2(-21.45, 2.7042),
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-25.23, -4.507),
				_Utils_Tuple2(-29.02, -11.71)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-29.38, -13.16),
				_Utils_Tuple2(-29.74, -14.60)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-29.74, -16.22),
				_Utils_Tuple2(-29.74, -17.84)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-28.30, -20.91),
				_Utils_Tuple2(-26.86, -23.97)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-23.25, -28.12),
				_Utils_Tuple2(-19.65, -32.27)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-13.88, -36.77),
				_Utils_Tuple2(-8.112, -41.28)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-4.146, -43.44),
				_Utils_Tuple2(-0.180, -45.61)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(0.9014, -45.79),
				_Utils_Tuple2(1.9830, -45.97)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(2.7042, -45.79),
				_Utils_Tuple2(3.4253, -45.61)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(3.9661, -44.52),
				_Utils_Tuple2(4.5070, -43.44)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(4.1464, -41.82),
				_Utils_Tuple2(3.7859, -40.20)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-0.901, -33.53),
				_Utils_Tuple2(-5.588, -26.86)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-6.850, -24.33),
				_Utils_Tuple2(-8.112, -21.81)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-8.653, -19.65),
				_Utils_Tuple2(-9.194, -17.48)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-9.374, -14.24),
				_Utils_Tuple2(-9.554, -10.99)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-8.653, -7.391),
				_Utils_Tuple2(-7.752, -3.785)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-6.670, -0.901),
				_Utils_Tuple2(-5.588, 1.9830)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-13.52, 2.3436),
				_Utils_Tuple2(-21.45, 2.7042))
			])),
		A2(
		$author$project$Main$MyCurve,
		_Utils_Tuple2(-21.45, 2.7042),
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-25.05, -3.785),
				_Utils_Tuple2(-28.66, -10.27)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-29.20, -12.98),
				_Utils_Tuple2(-29.74, -15.68)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-29.74, -18.20),
				_Utils_Tuple2(-29.74, -20.73)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-28.84, -24.51),
				_Utils_Tuple2(-27.94, -28.30)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-26.32, -31.90),
				_Utils_Tuple2(-24.69, -35.51)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-22.89, -37.85),
				_Utils_Tuple2(-21.09, -40.20)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-18.02, -42.90),
				_Utils_Tuple2(-14.96, -45.61)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-13.88, -46.33),
				_Utils_Tuple2(-12.8, -47.05)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-11.89, -47.05),
				_Utils_Tuple2(-10.99, -47.05)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-10.27, -45.97),
				_Utils_Tuple2(-9.554, -44.89)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-9.554, -42.00),
				_Utils_Tuple2(-9.554, -39.12)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-10.27, -35.15),
				_Utils_Tuple2(-10.99, -31.18)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-11.89, -27.94),
				_Utils_Tuple2(-12.8, -24.69)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-12.8, -20.73),
				_Utils_Tuple2(-12.8, -16.76)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-12.43, -13.34),
				_Utils_Tuple2(-12.07, -9.915)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-10.81, -6.670),
				_Utils_Tuple2(-9.554, -3.425)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-7.932, -0.721),
				_Utils_Tuple2(-6.309, 1.9830)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-13.88, 2.3436),
				_Utils_Tuple2(-21.45, 2.7042))
			])),
		A2(
		$author$project$Main$MyCurve,
		_Utils_Tuple2(-21.45, 2.7042),
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-25.23, -4.326),
				_Utils_Tuple2(-29.02, -11.35)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-29.56, -12.61),
				_Utils_Tuple2(-30.10, -13.88)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-30.46, -15.32),
				_Utils_Tuple2(-30.82, -16.76)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-31.18, -18.92),
				_Utils_Tuple2(-31.54, -21.09)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-31.18, -25.96),
				_Utils_Tuple2(-30.82, -30.82)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-29.92, -35.33),
				_Utils_Tuple2(-29.02, -39.84)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-27.94, -43.26),
				_Utils_Tuple2(-26.86, -46.69)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-26.14, -47.41),
				_Utils_Tuple2(-25.41, -48.13)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-24.51, -48.31),
				_Utils_Tuple2(-23.61, -48.49)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-22.53, -47.77),
				_Utils_Tuple2(-21.45, -47.05)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-20.91, -45.25),
				_Utils_Tuple2(-20.37, -43.44)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-19.83, -40.56),
				_Utils_Tuple2(-19.29, -37.67)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-18.92, -35.87),
				_Utils_Tuple2(-18.56, -34.07)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-17.84, -31.36),
				_Utils_Tuple2(-17.12, -28.66)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-16.58, -26.14),
				_Utils_Tuple2(-16.04, -23.61)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-15.32, -21.09),
				_Utils_Tuple2(-14.60, -18.56)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-10.63, -8.292),
				_Utils_Tuple2(-6.670, 1.9830)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-14.06, 2.3436),
				_Utils_Tuple2(-21.45, 2.7042))
			])),
		A2(
		$author$project$Main$MyCurve,
		_Utils_Tuple2(-21.81, 2.7042),
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-25.78, -4.507),
				_Utils_Tuple2(-29.74, -11.71)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-30.46, -13.52),
				_Utils_Tuple2(-31.18, -15.32)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-32.09, -17.66),
				_Utils_Tuple2(-32.99, -20.01)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-33.53, -22.35),
				_Utils_Tuple2(-34.07, -24.69)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-34.61, -27.76),
				_Utils_Tuple2(-35.15, -30.82)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-35.51, -34.43),
				_Utils_Tuple2(-35.87, -38.03)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-35.51, -41.82),
				_Utils_Tuple2(-35.15, -45.61)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-34.43, -46.33),
				_Utils_Tuple2(-33.71, -47.05)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-32.63, -47.05),
				_Utils_Tuple2(-31.54, -47.05)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-30.46, -45.97),
				_Utils_Tuple2(-29.38, -44.89)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-27.94, -42.54),
				_Utils_Tuple2(-26.50, -40.20)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-25.23, -37.13),
				_Utils_Tuple2(-23.97, -34.07)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-22.53, -30.82),
				_Utils_Tuple2(-21.09, -27.58)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-19.83, -24.69),
				_Utils_Tuple2(-18.56, -21.81)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-17.12, -18.92),
				_Utils_Tuple2(-15.68, -16.04)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-14.60, -13.88),
				_Utils_Tuple2(-13.52, -11.71)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-10.45, -5.588),
				_Utils_Tuple2(-7.391, 0.5408)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-14.78, 1.6225),
				_Utils_Tuple2(-21.81, 2.7042))
			])),
		A2(
		$author$project$Main$MyCurve,
		_Utils_Tuple2(-22.17, 2.7042),
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-24.69, -1.983),
				_Utils_Tuple2(-27.22, -6.670)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-28.66, -9.554),
				_Utils_Tuple2(-30.10, -12.43)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-32.09, -16.40),
				_Utils_Tuple2(-34.07, -20.37)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-35.87, -24.51),
				_Utils_Tuple2(-37.67, -28.66)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-38.76, -31.00),
				_Utils_Tuple2(-39.84, -33.35)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-40.56, -35.15),
				_Utils_Tuple2(-41.28, -36.95)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-41.64, -39.12),
				_Utils_Tuple2(-42.00, -41.28)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-42.00, -42.54),
				_Utils_Tuple2(-42.00, -43.80)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-41.28, -44.34),
				_Utils_Tuple2(-40.56, -44.89)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-39.30, -44.52),
				_Utils_Tuple2(-38.03, -44.16)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-36.59, -43.08),
				_Utils_Tuple2(-35.15, -42.00)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-32.99, -39.84),
				_Utils_Tuple2(-30.82, -37.67)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-28.48, -34.79),
				_Utils_Tuple2(-26.14, -31.90)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-24.51, -29.74),
				_Utils_Tuple2(-22.89, -27.58)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-20.73, -23.97),
				_Utils_Tuple2(-18.56, -20.37)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-16.04, -15.68),
				_Utils_Tuple2(-13.52, -10.99)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-10.45, -5.228),
				_Utils_Tuple2(-7.391, 0.5408)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-14.78, 1.6225),
				_Utils_Tuple2(-22.17, 2.7042))
			])),
		A2(
		$author$project$Main$MyCurve,
		_Utils_Tuple2(-22.53, 2.7042),
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-27.22, -5.408),
				_Utils_Tuple2(-31.90, -13.52)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-33.53, -15.86),
				_Utils_Tuple2(-35.15, -18.20)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-37.67, -21.45),
				_Utils_Tuple2(-40.20, -24.69)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-42.00, -26.86),
				_Utils_Tuple2(-43.80, -29.02)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-45.61, -30.64),
				_Utils_Tuple2(-47.41, -32.27)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-48.67, -33.17),
				_Utils_Tuple2(-49.93, -34.07)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-50.47, -35.15),
				_Utils_Tuple2(-51.01, -36.23)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-51.38, -36.95),
				_Utils_Tuple2(-51.74, -37.67)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-51.74, -38.76),
				_Utils_Tuple2(-51.74, -39.84)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-51.38, -40.20),
				_Utils_Tuple2(-51.01, -40.56)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-49.93, -40.92),
				_Utils_Tuple2(-48.85, -41.28)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-47.05, -41.10),
				_Utils_Tuple2(-45.25, -40.92)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-42.36, -40.02),
				_Utils_Tuple2(-39.48, -39.12)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-35.51, -36.59),
				_Utils_Tuple2(-31.54, -34.07)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-27.22, -29.56),
				_Utils_Tuple2(-22.89, -25.05)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-17.66, -17.30),
				_Utils_Tuple2(-12.43, -9.554)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-9.735, -4.507),
				_Utils_Tuple2(-7.030, 0.5408)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-14.78, 1.6225),
				_Utils_Tuple2(-22.53, 2.7042))
			]))
	]);
var $author$project$Main$hindLimb = function (model) {
	return $MacCASOutreach$graphicsvg$GraphicSVG$group(
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
				$elm$core$Basics$degrees(
					2 * $elm$core$Basics$sin(model.time)),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					$MacCASOutreach$graphicsvg$GraphicSVG$darkGreen,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$curve,
						_Utils_Tuple2(29.025, 4.5070),
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(31.729, 0.3605),
								_Utils_Tuple2(34.433, -3.785)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(35.695, -4.867),
								_Utils_Tuple2(36.957, -5.949)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(38.4, -6.670),
								_Utils_Tuple2(39.842, -7.391)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(42.005, -8.473),
								_Utils_Tuple2(44.169, -9.554)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(47.053, -10.81),
								_Utils_Tuple2(49.938, -12.07)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(52.822, -13.16),
								_Utils_Tuple2(55.707, -14.24)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(58.591, -15.32),
								_Utils_Tuple2(61.476, -16.40)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(64, -17.66),
								_Utils_Tuple2(66.523, -18.92)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(67.966, -19.83),
								_Utils_Tuple2(69.408, -20.73)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(70.129, -20.55),
								_Utils_Tuple2(70.850, -20.37)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(71.571, -19.83),
								_Utils_Tuple2(72.292, -19.29)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(72.653, -17.30),
								_Utils_Tuple2(73.014, -15.32)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(73.014, -13.52),
								_Utils_Tuple2(73.014, -11.71)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(72.292, -9.915),
								_Utils_Tuple2(71.571, -8.112)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(71.211, -6.670),
								_Utils_Tuple2(70.850, -5.228)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(70.129, -3.785),
								_Utils_Tuple2(69.408, -2.343)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(68.687, -1.802),
								_Utils_Tuple2(67.966, -1.261)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(66.523, 0),
								_Utils_Tuple2(65.081, 1.2619)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(64, 2.7042),
								_Utils_Tuple2(62.918, 4.1464)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(61.836, 4.6873),
								_Utils_Tuple2(60.754, 5.2281)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(59.673, 5.0478),
								_Utils_Tuple2(58.591, 4.8676)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(57.149, 4.6873),
								_Utils_Tuple2(55.707, 4.5070)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(53.904, 4.6873),
								_Utils_Tuple2(52.101, 4.8676)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(49.938, 5.5887),
								_Utils_Tuple2(47.774, 6.3098)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(44.890, 8.1126),
								_Utils_Tuple2(42.005, 9.9154)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(35.515, 7.2112),
								_Utils_Tuple2(29.025, 4.5070))
							]))))
			]));
};
var $author$project$Main$mkAnimationPieceVS = F4(
	function (addVS, subVS, scaleVS, listOfVectors) {
		if (listOfVectors.b && listOfVectors.b.b) {
			var p0 = listOfVectors.a;
			var _v1 = listOfVectors.b;
			var p1 = _v1.a;
			var rest = _v1.b;
			return A2(
				$elm$core$List$cons,
				_Utils_Tuple2(
					1,
					function (t) {
						return A2(
							addVS,
							p0,
							A2(
								scaleVS,
								t,
								A2(subVS, p1, p0)));
					}),
				A4(
					$author$project$Main$mkAnimationPieceVS,
					addVS,
					subVS,
					scaleVS,
					A2($elm$core$List$cons, p1, rest)));
		} else {
			return _List_Nil;
		}
	});
var $author$project$Main$scaleTurtle = F2(
	function (s, _v0) {
		var x = _v0.a;
		var y = _v0.b;
		return _Utils_Tuple2(s * x, s * y);
	});
var $author$project$Main$scalePull = F2(
	function (s, _v0) {
		var p2 = _v0.a;
		var p3 = _v0.b;
		return A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
			A2($author$project$Main$scaleTurtle, s, p2),
			A2($author$project$Main$scaleTurtle, s, p3));
	});
var $author$project$Main$scaleCurve = F2(
	function (s, _v0) {
		var p1 = _v0.a;
		var pulls1 = _v0.b;
		return A2(
			$author$project$Main$MyCurve,
			A2($author$project$Main$scaleTurtle, s, p1),
			A2(
				$elm$core$List$map,
				$author$project$Main$scalePull(s),
				pulls1));
	});
var $author$project$Main$subTurtle = F2(
	function (_v0, _v1) {
		var x = _v0.a;
		var y = _v0.b;
		var u = _v1.a;
		var v = _v1.b;
		return _Utils_Tuple2(x - u, y - v);
	});
var $author$project$Main$subPull = F2(
	function (_v0, _v1) {
		var p0 = _v0.a;
		var p1 = _v0.b;
		var p2 = _v1.a;
		var p3 = _v1.b;
		return A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
			A2($author$project$Main$subTurtle, p0, p2),
			A2($author$project$Main$subTurtle, p1, p3));
	});
var $author$project$Main$subCurve = F2(
	function (_v0, _v1) {
		var p0 = _v0.a;
		var pulls0 = _v0.b;
		var p1 = _v1.a;
		var pulls1 = _v1.b;
		return A2(
			$author$project$Main$MyCurve,
			A2($author$project$Main$subTurtle, p0, p1),
			A3($elm$core$List$map2, $author$project$Main$subPull, pulls0, pulls1));
	});
var $author$project$Main$turtle = function (model) {
	return $MacCASOutreach$graphicsvg$GraphicSVG$group(
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$darkGreen,
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$curve,
					_Utils_Tuple2(-46.69, 24.698),
					_List_fromArray(
						[
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-47.59, 23.797),
							_Utils_Tuple2(-48.49, 22.895)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-49.03, 22.535),
							_Utils_Tuple2(-49.57, 22.174)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-50.29, 22.174),
							_Utils_Tuple2(-51.01, 22.174)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-51.74, 22.174),
							_Utils_Tuple2(-52.46, 22.174)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-53.54, 22.354),
							_Utils_Tuple2(-54.62, 22.535)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-55.88, 23.076),
							_Utils_Tuple2(-57.14, 23.616)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-59.49, 24.157),
							_Utils_Tuple2(-61.83, 24.698)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-64, 24.878),
							_Utils_Tuple2(-66.16, 25.059)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-69.76, 24.518),
							_Utils_Tuple2(-73.37, 23.977)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-74.45, 23.616),
							_Utils_Tuple2(-75.53, 23.256)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-76.8, 22.535),
							_Utils_Tuple2(-78.06, 21.814)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-79.14, 20.552),
							_Utils_Tuple2(-80.22, 19.290)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-80.58, 18.388),
							_Utils_Tuple2(-80.94, 17.487)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-81.30, 15.143),
							_Utils_Tuple2(-81.66, 12.8)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-82.20, 12.078),
							_Utils_Tuple2(-82.74, 11.357)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-83.10, 10.636),
							_Utils_Tuple2(-83.47, 9.9154)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-83.47, 8.1126),
							_Utils_Tuple2(-83.47, 6.3098)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-83.10, 6.1295),
							_Utils_Tuple2(-82.74, 5.9492)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-81.66, 5.9492),
							_Utils_Tuple2(-80.58, 5.9492)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-79.68, 5.9492),
							_Utils_Tuple2(-78.78, 5.9492)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-80.76, 5.7690),
							_Utils_Tuple2(-82.74, 5.5887)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-82.20, 4.6873),
							_Utils_Tuple2(-81.66, 3.7859)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-81.12, 3.2450),
							_Utils_Tuple2(-80.58, 2.7042)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-79.68, 2.3436),
							_Utils_Tuple2(-78.78, 1.9830)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-77.34, 1.9830),
							_Utils_Tuple2(-75.89, 1.9830)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-73.37, 2.1633),
							_Utils_Tuple2(-70.85, 2.3436)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-69.76, 2.5239),
							_Utils_Tuple2(-68.68, 2.7042)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-67.78, 2.1633),
							_Utils_Tuple2(-66.88, 1.6225)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-65.62, 1.6225),
							_Utils_Tuple2(-64.36, 1.6225)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-62.91, 1.8028),
							_Utils_Tuple2(-61.47, 1.9830)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-59.31, 2.5239),
							_Utils_Tuple2(-57.14, 3.0647)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-55.16, 3.2450),
							_Utils_Tuple2(-53.18, 3.4253)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-51.74, 3.4253),
							_Utils_Tuple2(-50.29, 3.4253)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-48.13, 2.5239),
							_Utils_Tuple2(-45.97, 1.6225)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-42.72, -0.360),
							_Utils_Tuple2(-39.48, -2.343)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-32.99, 4.6873),
							_Utils_Tuple2(-26.50, 11.718)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-33.35, 21.633),
							_Utils_Tuple2(-40.20, 31.549)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-43.44, 28.123),
							_Utils_Tuple2(-46.69, 24.698))
						]))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(-75, 15),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					$MacCASOutreach$graphicsvg$GraphicSVG$black,
					$MacCASOutreach$graphicsvg$GraphicSVG$circle(1))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$brown,
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$curve,
					_Utils_Tuple2(-35.87, 3.7859),
					_List_fromArray(
						[
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-36.95, 2.1633),
							_Utils_Tuple2(-38.03, 0.5408)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-39.30, -0.540),
							_Utils_Tuple2(-40.56, -1.622)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-40.92, -1.983),
							_Utils_Tuple2(-41.28, -2.343)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-38.03, -4.507),
							_Utils_Tuple2(-34.79, -6.670)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-32.81, -7.752),
							_Utils_Tuple2(-30.82, -8.833)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-29.38, -9.374),
							_Utils_Tuple2(-27.94, -9.915)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-26.50, -10.45),
							_Utils_Tuple2(-25.05, -10.99)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-23.25, -11.35),
							_Utils_Tuple2(-21.45, -11.71)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-19.83, -12.07),
							_Utils_Tuple2(-18.20, -12.43)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-15.50, -12.8),
							_Utils_Tuple2(-12.8, -13.16)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-10.27, -13.16),
							_Utils_Tuple2(-7.752, -13.16)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-5.047, -12.98),
							_Utils_Tuple2(-2.343, -12.8)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(0.3605, -12.61),
							_Utils_Tuple2(3.0647, -12.43)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(5.4084, -12.07),
							_Utils_Tuple2(7.7521, -11.71)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(10.816, -11.17),
							_Utils_Tuple2(13.881, -10.63)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(16.405, -10.09),
							_Utils_Tuple2(18.929, -9.554)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(21.273, -9.014),
							_Utils_Tuple2(23.616, -8.473)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(26.321, -7.571),
							_Utils_Tuple2(29.025, -6.670)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(32.090, -5.408),
							_Utils_Tuple2(35.154, -4.146)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(41.645, 0.7211),
							_Utils_Tuple2(48.135, 5.5887)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(49.397, 6.8507),
							_Utils_Tuple2(50.659, 8.1126)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(51.560, 9.5549),
							_Utils_Tuple2(52.461, 10.997)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(8.2929, 7.5718),
							_Utils_Tuple2(-35.87, 3.7859))
						]))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$darkGreen,
				$author$project$Main$drawCurve(
					A3(
						$author$project$Main$animationPieces,
						A4($author$project$Main$mkAnimationPieceVS, $author$project$Main$addCurve, $author$project$Main$subCurve, $author$project$Main$scaleCurve, $author$project$Main$flippersTurtle),
						function (t) {
							return A2(
								$author$project$Main$MyCurve,
								_Utils_Tuple2(0, 0),
								_List_Nil);
						},
						3 + (3 * $elm$core$Basics$cos(model.time))))),
				$author$project$Main$hindLimb(model),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$darkBrown,
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$curve,
					_Utils_Tuple2(-46.69, 25.419),
					_List_fromArray(
						[
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-46.33, 24.157),
							_Utils_Tuple2(-45.97, 22.895)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-45.61, 21.633),
							_Utils_Tuple2(-45.25, 20.371)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-44.52, 19.109),
							_Utils_Tuple2(-43.80, 17.847)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-43.44, 16.405),
							_Utils_Tuple2(-43.08, 14.963)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-42.36, 13.340),
							_Utils_Tuple2(-41.64, 11.718)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-41.10, 10.095),
							_Utils_Tuple2(-40.56, 8.4732)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-40.02, 7.7521),
							_Utils_Tuple2(-39.48, 7.0309)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-38.58, 5.7690),
							_Utils_Tuple2(-37.67, 4.5070)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-36.41, 3.4253),
							_Utils_Tuple2(-35.15, 2.3436)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-33.71, 1.0816),
							_Utils_Tuple2(-32.27, -0.180)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-31.18, -0.540),
							_Utils_Tuple2(-30.10, -0.901)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-27.94, -1.442),
							_Utils_Tuple2(-25.78, -1.983)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-23.25, -2.523),
							_Utils_Tuple2(-20.73, -3.064)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-18.38, -3.785),
							_Utils_Tuple2(-16.04, -4.507)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-13.16, -4.507),
							_Utils_Tuple2(-10.27, -4.507)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-7.211, -4.867),
							_Utils_Tuple2(-4.146, -5.228)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-1.442, -5.047),
							_Utils_Tuple2(1.2619, -4.867)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(4.3267, -3.966),
							_Utils_Tuple2(7.3915, -3.064)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(9.5549, -3.064),
							_Utils_Tuple2(11.718, -3.064)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(14.602, -2.704),
							_Utils_Tuple2(17.487, -2.343)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(39.301, 5.0478),
							_Utils_Tuple2(61.115, 12.439)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(50.839, 20.552),
							_Utils_Tuple2(40.563, 28.664)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(36.416, 31.188),
							_Utils_Tuple2(32.270, 33.712)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(29.205, 34.974),
							_Utils_Tuple2(26.140, 36.236)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(24.518, 36.777),
							_Utils_Tuple2(22.895, 37.318)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(20.912, 37.859),
							_Utils_Tuple2(18.929, 38.4)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(16.405, 39.301),
							_Utils_Tuple2(13.881, 40.202)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(9.5549, 40.923),
							_Utils_Tuple2(5.2281, 41.645)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(2.8845, 41.645),
							_Utils_Tuple2(0.5408, 41.645)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-1.802, 42.185),
							_Utils_Tuple2(-4.146, 42.726)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-6.309, 43.087),
							_Utils_Tuple2(-8.473, 43.447)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-12.79, 43.267),
							_Utils_Tuple2(-17.12, 43.087)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-21.45, 42.185),
							_Utils_Tuple2(-25.78, 41.284)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-27.94, 40.563),
							_Utils_Tuple2(-30.10, 39.842)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-32.63, 38.039),
							_Utils_Tuple2(-35.15, 36.236)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-38.40, 33.171),
							_Utils_Tuple2(-41.64, 30.107)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-44.16, 27.943),
							_Utils_Tuple2(-46.69, 25.419))
						])))
			]));
};
var $MacCASOutreach$graphicsvg$GraphicSVG$rgb = F3(
	function (r, g, b) {
		return A4($MacCASOutreach$graphicsvg$GraphicSVG$rgba, r, g, b, 1);
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$rotateGradient = F2(
	function (r, grad) {
		if ((grad.$ === 'Gradient') && (grad.a.$ === 'LinearGradient')) {
			var _v1 = grad.a;
			var rot = _v1.a;
			var stops = _v1.b;
			return $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Gradient(
				A2($MacCASOutreach$graphicsvg$GraphicSVG$Secret$LinearGradient, rot + r, stops));
		} else {
			var radialGrad = grad;
			return radialGrad;
		}
	});
var $elm$core$Basics$sqrt = _Basics_sqrt;
var $author$project$Main$water = function (brightness) {
	return $MacCASOutreach$graphicsvg$GraphicSVG$group(
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$rotateGradient,
					$elm$core$Basics$degrees(-90),
					$MacCASOutreach$graphicsvg$GraphicSVG$gradient(
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$stop,
								A3($MacCASOutreach$graphicsvg$GraphicSVG$rgb, brightness * 144, brightness * 239, brightness * 255),
								-33),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$stop,
								A3(
									$MacCASOutreach$graphicsvg$GraphicSVG$rgb,
									$elm$core$Basics$sqrt(brightness) * 20,
									$elm$core$Basics$sqrt(brightness) * 187,
									$elm$core$Basics$sqrt(brightness) * 220),
								30)
							]))),
				A2($MacCASOutreach$graphicsvg$GraphicSVG$rect, 500, 500))
			]));
};
var $author$project$Main$backgroundElements = F3(
	function (brightness, schoolOfFish, model) {
		return $MacCASOutreach$graphicsvg$GraphicSVG$group(
			_List_fromArray(
				[
					$author$project$Main$water(brightness),
					schoolOfFish(model),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(
						A4($author$project$Main$repeatDuration, -3, 500, 100, model.time),
						35),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$scale,
						0.3,
						$author$project$Main$turtle(model))),
					function () {
					var seaweed = F2(
						function (idx, rawThickness) {
							var waveTime = model.time + (0.1 * idx);
							var thickness = 2 + rawThickness;
							var wholeSeaweed = A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$filled,
								A3(
									$MacCASOutreach$graphicsvg$GraphicSVG$hsl,
									$elm$core$Basics$degrees(92),
									0.722,
									0.408),
								A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$curve,
									_Utils_Tuple2(-thickness, -50),
									_List_fromArray(
										[
											A2(
											$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
											_Utils_Tuple2(
												(-thickness) + (10 * $elm$core$Basics$cos(waveTime)),
												-25),
											_Utils_Tuple2(-thickness, 0)),
											A2(
											$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
											_Utils_Tuple2(
												(-thickness) - (10 * $elm$core$Basics$cos(waveTime)),
												25),
											_Utils_Tuple2(0, 50)),
											A2(
											$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
											_Utils_Tuple2(0, 50),
											_Utils_Tuple2(0, 50)),
											A2(
											$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
											_Utils_Tuple2(
												thickness - (10 * $elm$core$Basics$cos(waveTime)),
												25),
											_Utils_Tuple2(thickness, 0)),
											A2(
											$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
											_Utils_Tuple2(
												thickness + (10 * $elm$core$Basics$cos(waveTime)),
												-25),
											_Utils_Tuple2(thickness, -50)),
											A2(
											$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
											_Utils_Tuple2(0, -50),
											_Utils_Tuple2(-thickness, -50))
										])));
							var spotRot = (-1) * $elm$core$Basics$cos(17 * idx);
							var spotHeight = $elm$core$Basics$sin(17 * idx);
							return $MacCASOutreach$graphicsvg$GraphicSVG$group(
								_List_fromArray(
									[
										wholeSeaweed,
										A2(
										$MacCASOutreach$graphicsvg$GraphicSVG$clip,
										wholeSeaweed,
										A2(
											$MacCASOutreach$graphicsvg$GraphicSVG$move,
											_Utils_Tuple2(
												spotHeight * ((0.5 * thickness) + (5 * $elm$core$Basics$cos(waveTime))),
												(-25) * spotHeight),
											A2(
												$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
												(0.35 * $elm$core$Basics$cos(waveTime)) * spotRot,
												A2(
													$MacCASOutreach$graphicsvg$GraphicSVG$filled,
													A3(
														$MacCASOutreach$graphicsvg$GraphicSVG$hsl,
														$elm$core$Basics$degrees(59),
														0.437,
														0.463),
													A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 3, 7)))))
									]));
						});
					return A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$scale,
						1.2,
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$move,
							_Utils_Tuple2(0, -30),
							$MacCASOutreach$graphicsvg$GraphicSVG$group(
								A3(
									$elm$core$List$map2,
									F2(
										function (idx, thickness) {
											return A2(
												$MacCASOutreach$graphicsvg$GraphicSVG$move,
												_Utils_Tuple2(10 * idx, 0),
												A2(seaweed, idx, thickness));
										}),
									A2($elm$core$List$range, -10, 10),
									_List_fromArray(
										[0.850, 0.095, 0.295, 0.231, 0.615, 0.428, 0.260, 0.310, 0.173, 0.397, 0.725, 0.440, 0.104, 0.156, 0.073, 0.470, 0.627, 0.220, 0.726, 0.847])))));
				}(),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-35, -90),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$filled,
						$MacCASOutreach$graphicsvg$GraphicSVG$gradient(
							_List_fromArray(
								[
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$stop,
									A3(
										$MacCASOutreach$graphicsvg$GraphicSVG$hsl,
										$elm$core$Basics$degrees(43),
										0.53,
										0.61),
									0),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$stop,
									A3(
										$MacCASOutreach$graphicsvg$GraphicSVG$hsl,
										$elm$core$Basics$degrees(43),
										0.714,
										0.778),
									25)
								])),
						A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 500, 100))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-45, -38),
					$author$project$Main$seaweedRock),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-75, -35),
					A3(
						$MacCASOutreach$graphicsvg$GraphicSVG$addOutline,
						$MacCASOutreach$graphicsvg$GraphicSVG$solid(0.4),
						$MacCASOutreach$graphicsvg$GraphicSVG$black,
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$scaleX,
							2,
							A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$filled,
								$MacCASOutreach$graphicsvg$GraphicSVG$gray,
								A2($MacCASOutreach$graphicsvg$GraphicSVG$ngon, 12, 14))))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-60, -42),
					A3(
						$MacCASOutreach$graphicsvg$GraphicSVG$addOutline,
						$MacCASOutreach$graphicsvg$GraphicSVG$solid(0.4),
						$MacCASOutreach$graphicsvg$GraphicSVG$black,
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$scaleX,
							2,
							A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$filled,
								$MacCASOutreach$graphicsvg$GraphicSVG$gray,
								A2($MacCASOutreach$graphicsvg$GraphicSVG$ngon, 14, 11))))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(75, -40),
					$author$project$Main$treasureChess),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(45, -45),
					$author$project$Main$seaweedRock),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(60, -62),
					$author$project$Main$seaweedRock),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-70, -57),
					$author$project$Main$seaweedRock)
				]));
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$blue = A4($MacCASOutreach$graphicsvg$GraphicSVG$rgba, 52, 101, 164, 1);
var $author$project$Main$fish = function (colour) {
	return $MacCASOutreach$graphicsvg$GraphicSVG$group(
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(-20, -34),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					colour,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 28, 24))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(-20, -33),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					$MacCASOutreach$graphicsvg$GraphicSVG$white,
					$MacCASOutreach$graphicsvg$GraphicSVG$circle(5))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(-31, -33),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					$MacCASOutreach$graphicsvg$GraphicSVG$white,
					$MacCASOutreach$graphicsvg$GraphicSVG$circle(5))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(-22, -33),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					$MacCASOutreach$graphicsvg$GraphicSVG$black,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 5, 7.5))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(-33, -33),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					$MacCASOutreach$graphicsvg$GraphicSVG$black,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 5, 7.5))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$black,
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$curve,
					_Utils_Tuple2(-27.72, -38.22),
					_List_fromArray(
						[
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-26.97, -39.41),
							_Utils_Tuple2(-26.22, -40.61)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-25.62, -40.61),
							_Utils_Tuple2(-25.03, -40.61)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-24.13, -39.26),
							_Utils_Tuple2(-23.23, -37.92)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-23.68, -37.77),
							_Utils_Tuple2(-24.13, -37.62)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-24.58, -38.22),
							_Utils_Tuple2(-25.03, -38.81)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-25.18, -39.26),
							_Utils_Tuple2(-25.33, -39.71)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-25.62, -39.71),
							_Utils_Tuple2(-25.92, -39.71)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-26.37, -38.81),
							_Utils_Tuple2(-26.82, -37.92)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-27.27, -38.07),
							_Utils_Tuple2(-27.72, -38.22))
						])))
			]));
};
var $author$project$Main$fishTail = function (colour) {
	return $MacCASOutreach$graphicsvg$GraphicSVG$group(
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				colour,
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$curve,
					_Utils_Tuple2(-7.044, -32.52),
					_List_fromArray(
						[
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-4.646, -30.10),
							_Utils_Tuple2(-2.248, -29.52)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-3.896, -33.61),
							_Utils_Tuple2(-5.545, -34.62)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-3.666, -35.85),
							_Utils_Tuple2(-3.147, -39.11)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-5.096, -39.52),
							_Utils_Tuple2(-7.044, -38.22)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-7.194, -36.42),
							_Utils_Tuple2(-7.344, -34.62)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-7.644, -33.57),
							_Utils_Tuple2(-7.044, -32.52))
						])))
			]));
};
var $author$project$Main$leftFin = function (colour) {
	return $MacCASOutreach$graphicsvg$GraphicSVG$group(
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				colour,
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$curve,
					_Utils_Tuple2(-32.82, -38.22),
					_List_fromArray(
						[
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-34.17, -38.81),
							_Utils_Tuple2(-35.52, -39.41)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-35.07, -40.16),
							_Utils_Tuple2(-34.62, -40.91)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-34.02, -40.61),
							_Utils_Tuple2(-33.42, -40.31)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-33.27, -40.61),
							_Utils_Tuple2(-33.12, -40.91)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-33.42, -41.36),
							_Utils_Tuple2(-33.72, -41.81)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-32.93, -42.26),
							_Utils_Tuple2(-31.62, -42.71)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-30.57, -43.16),
							_Utils_Tuple2(-32.82, -38.22))
						])))
			]));
};
var $MacCASOutreach$graphicsvg$GraphicSVG$orange = A4($MacCASOutreach$graphicsvg$GraphicSVG$rgba, 245, 121, 0, 1);
var $author$project$Main$rightFin = function (colour) {
	return $MacCASOutreach$graphicsvg$GraphicSVG$group(
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				colour,
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$curve,
					_Utils_Tuple2(-11.54, -36.72),
					_List_fromArray(
						[
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-13.18, -39.41),
							_Utils_Tuple2(-14.83, -42.11)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-13.93, -42.26),
							_Utils_Tuple2(-13.03, -42.41)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-12.74, -41.96),
							_Utils_Tuple2(-12.44, -41.51)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-12.14, -41.96),
							_Utils_Tuple2(-11.84, -42.41)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-10.94, -42.55),
							_Utils_Tuple2(-10.04, -42.41)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-8.992, -41.96),
							_Utils_Tuple2(-7.943, -41.51)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-8.683, -40.16),
							_Utils_Tuple2(-11.54, -36.72))
						])))
			]));
};
var $author$project$Main$upperFin = function (colour) {
	return $MacCASOutreach$graphicsvg$GraphicSVG$group(
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				colour,
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$curve,
					_Utils_Tuple2(-26.82, -26.52),
					_List_fromArray(
						[
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-26.67, -24.28),
							_Utils_Tuple2(-26.52, -22.03)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-24.88, -21.04),
							_Utils_Tuple2(-23.23, -21.13)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-23.08, -22.03),
							_Utils_Tuple2(-22.93, -22.93)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-22.48, -22.18),
							_Utils_Tuple2(-22.03, -21.43)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-19.78, -20.47),
							_Utils_Tuple2(-17.53, -20.83)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-17.53, -21.88),
							_Utils_Tuple2(-17.53, -22.93)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-16.78, -22.18),
							_Utils_Tuple2(-16.03, -21.43)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-13.48, -21.57),
							_Utils_Tuple2(-10.94, -24.43)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-9.182, -27.30),
							_Utils_Tuple2(-9.142, -29.82)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-11.54, -26.97),
							_Utils_Tuple2(-13.93, -25.92)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-17.38, -24.37),
							_Utils_Tuple2(-20.83, -24.73)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-23.83, -25.01),
							_Utils_Tuple2(-26.82, -26.52))
						])))
			]));
};
var $author$project$Main$cody = F2(
	function (model, colour) {
		return $MacCASOutreach$graphicsvg$GraphicSVG$group(
			_List_fromArray(
				[
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(30, 40),
					$author$project$Main$fish($MacCASOutreach$graphicsvg$GraphicSVG$yellow)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(30, 40),
					$author$project$Main$upperFin($MacCASOutreach$graphicsvg$GraphicSVG$orange)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
					$elm$core$Basics$degrees(1.3) * $elm$core$Basics$sin(model.time * 10),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(30, 40),
						$author$project$Main$rightFin($MacCASOutreach$graphicsvg$GraphicSVG$orange))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
					$elm$core$Basics$degrees(-1.3) * $elm$core$Basics$sin(model.time * 10),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(30, 40),
						$author$project$Main$leftFin($MacCASOutreach$graphicsvg$GraphicSVG$orange))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(
						0,
						2 * $elm$core$Basics$sin(model.time * 5)),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(30, 40),
						$author$project$Main$fishTail($MacCASOutreach$graphicsvg$GraphicSVG$orange)))
				]));
	});
var $author$project$Main$eyeShellS = A2(
	$MacCASOutreach$graphicsvg$GraphicSVG$scale,
	0.3,
	A3(
		$MacCASOutreach$graphicsvg$GraphicSVG$addOutline,
		$MacCASOutreach$graphicsvg$GraphicSVG$solid(2),
		A3(
			$MacCASOutreach$graphicsvg$GraphicSVG$hsl,
			$elm$core$Basics$degrees(227),
			0.973,
			0.455),
		A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$filled,
			A3(
				$MacCASOutreach$graphicsvg$GraphicSVG$hsl,
				$elm$core$Basics$degrees(186),
				0.802,
				0.373),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$curve,
				_Utils_Tuple2(24.284, -35.28),
				_List_fromArray(
					[
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(25.325, -36.84),
						_Utils_Tuple2(23.566, -37.20)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(22.387, -37.00),
						_Utils_Tuple2(22.609, -34.81)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(23.225, -33.33),
						_Utils_Tuple2(25.241, -33.85)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(27.858, -35.74),
						_Utils_Tuple2(26.676, -38.63)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(25.044, -41.27),
						_Utils_Tuple2(21.413, -40.31)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(15.375, -37.47),
						_Utils_Tuple2(19.738, -30.02)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(24.119, -24.62),
						_Utils_Tuple2(31.700, -30.02)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(36.857, -34.98),
						_Utils_Tuple2(33.614, -41.74)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(28.401, -50.80),
						_Utils_Tuple2(16.388, -44.85)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(8.2514, -34.27),
						_Utils_Tuple2(14.714, -25.48)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(23.201, -16.40),
						_Utils_Tuple2(35.289, -20.93)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(45.692, -25.58),
						_Utils_Tuple2(46.295, -38.63)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(48.156, -41.03),
						_Utils_Tuple2(45.816, -43.42)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(38.041, -49.44),
						_Utils_Tuple2(30.265, -46.05)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(30.145, -45.93),
						_Utils_Tuple2(30.026, -45.81))
					])))));
var $MacCASOutreach$graphicsvg$GraphicSVG$outlined = F3(
	function (style, outlineClr, stencil) {
		var lineStyle = function () {
			if (style.$ === 'NoLine') {
				return $elm$core$Maybe$Nothing;
			} else {
				return $elm$core$Maybe$Just(
					_Utils_Tuple2(style, outlineClr));
			}
		}();
		return A3($MacCASOutreach$graphicsvg$GraphicSVG$Secret$Inked, $elm$core$Maybe$Nothing, lineStyle, stencil);
	});
var $author$project$Main$mouthShellS = $MacCASOutreach$graphicsvg$GraphicSVG$group(
	_List_fromArray(
		[
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
			$elm$core$Basics$degrees(-15),
			A3(
				$MacCASOutreach$graphicsvg$GraphicSVG$addOutline,
				$MacCASOutreach$graphicsvg$GraphicSVG$solid(0.5),
				A3($MacCASOutreach$graphicsvg$GraphicSVG$rgb, 53, 50, 98),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					A3($MacCASOutreach$graphicsvg$GraphicSVG$rgb, 117, 131, 174),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$curve,
						_Utils_Tuple2(10.791, 1.6487),
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(9.4861, 11.990),
								_Utils_Tuple2(24.580, 22.332)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(30.775, 26.430),
								_Utils_Tuple2(38.370, 28.327)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(41.968, 29.028),
								_Utils_Tuple2(42.566, 25.929)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(42.571, 17.935),
								_Utils_Tuple2(29.976, 10.941)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(24.230, 7.4941),
								_Utils_Tuple2(20.084, 4.0468)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(15.437, 1.7978),
								_Utils_Tuple2(10.791, 1.6487))
							]))))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
			$elm$core$Basics$degrees(-10),
			A3(
				$MacCASOutreach$graphicsvg$GraphicSVG$addOutline,
				$MacCASOutreach$graphicsvg$GraphicSVG$solid(0.5),
				A3($MacCASOutreach$graphicsvg$GraphicSVG$rgb, 53, 50, 98),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					A3($MacCASOutreach$graphicsvg$GraphicSVG$rgb, 117, 131, 174),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$curve,
						_Utils_Tuple2(19.784, 3.4473),
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(30.725, 5.2967),
								_Utils_Tuple2(43.466, 4.9461)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(47.512, 4.9964),
								_Utils_Tuple2(51.559, 4.0468)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(53.161, 2.4482),
								_Utils_Tuple2(46.763, 0.4496)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(36.222, -2.499),
								_Utils_Tuple2(23.681, -2.248)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(16.086, -1.748),
								_Utils_Tuple2(11.690, -0.449)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(10.191, 0.4496),
								_Utils_Tuple2(11.091, 1.3489)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(15.288, 2.3981),
								_Utils_Tuple2(19.784, 3.4473))
							]))))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
			$elm$core$Basics$degrees(-15),
			A3(
				$MacCASOutreach$graphicsvg$GraphicSVG$outlined,
				$MacCASOutreach$graphicsvg$GraphicSVG$solid(0.25),
				A3($MacCASOutreach$graphicsvg$GraphicSVG$rgb, 53, 50, 98),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$curve,
					_Utils_Tuple2(25.779, 22.632),
					_List_fromArray(
						[
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(24.731, 19.334),
							_Utils_Tuple2(20.683, 16.037)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(17.386, 13.738),
							_Utils_Tuple2(14.088, 13.039))
						])))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
			$elm$core$Basics$degrees(-15),
			A3(
				$MacCASOutreach$graphicsvg$GraphicSVG$outlined,
				$MacCASOutreach$graphicsvg$GraphicSVG$solid(0.25),
				A3($MacCASOutreach$graphicsvg$GraphicSVG$rgb, 53, 50, 98),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$curve,
					_Utils_Tuple2(13.189, 10.042),
					_List_fromArray(
						[
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(27.633, 14.936),
							_Utils_Tuple2(30.276, 25.030))
						])))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
			$elm$core$Basics$degrees(-15),
			A3(
				$MacCASOutreach$graphicsvg$GraphicSVG$outlined,
				$MacCASOutreach$graphicsvg$GraphicSVG$solid(0.25),
				A3($MacCASOutreach$graphicsvg$GraphicSVG$rgb, 53, 50, 98),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$curve,
					_Utils_Tuple2(34.173, 26.529),
					_List_fromArray(
						[
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(33.825, 20.533),
							_Utils_Tuple2(27.878, 14.538)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(22.782, 9.5908),
							_Utils_Tuple2(16.487, 8.8430)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(13.438, 8.2435),
							_Utils_Tuple2(11.990, 7.6440))
						])))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
			$elm$core$Basics$degrees(-15),
			A3(
				$MacCASOutreach$graphicsvg$GraphicSVG$outlined,
				$MacCASOutreach$graphicsvg$GraphicSVG$solid(0.5),
				A3($MacCASOutreach$graphicsvg$GraphicSVG$rgb, 53, 50, 98),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$curve,
					_Utils_Tuple2(10.791, 4.3466),
					_List_fromArray(
						[
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(23.182, 6.2918),
							_Utils_Tuple2(33.573, 16.637)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(38.872, 22.182),
							_Utils_Tuple2(37.170, 27.728))
						])))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
			$elm$core$Basics$degrees(-10),
			A3(
				$MacCASOutreach$graphicsvg$GraphicSVG$outlined,
				$MacCASOutreach$graphicsvg$GraphicSVG$solid(0.5),
				A3($MacCASOutreach$graphicsvg$GraphicSVG$rgb, 53, 50, 98),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$curve,
					_Utils_Tuple2(13.789, 1.9484),
					_List_fromArray(
						[
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(30.875, -3.252),
							_Utils_Tuple2(47.962, 4.9461))
						])))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
			$elm$core$Basics$degrees(-10),
			A3(
				$MacCASOutreach$graphicsvg$GraphicSVG$outlined,
				$MacCASOutreach$graphicsvg$GraphicSVG$solid(0.5),
				A3($MacCASOutreach$graphicsvg$GraphicSVG$rgb, 53, 50, 98),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$curve,
					_Utils_Tuple2(18.285, 2.8477),
					_List_fromArray(
						[
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(22.731, 1.1482),
							_Utils_Tuple2(28.777, 1.6487)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(33.624, 2.1482),
							_Utils_Tuple2(36.871, 2.8477)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(39.919, 3.6969),
							_Utils_Tuple2(40.768, 4.9461))
						])))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
			$elm$core$Basics$degrees(-10),
			A3(
				$MacCASOutreach$graphicsvg$GraphicSVG$outlined,
				$MacCASOutreach$graphicsvg$GraphicSVG$solid(0.5),
				A3($MacCASOutreach$graphicsvg$GraphicSVG$rgb, 53, 50, 98),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$curve,
					_Utils_Tuple2(23.381, 4.0468),
					_List_fromArray(
						[
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(25.929, 2.8470),
							_Utils_Tuple2(30.276, 3.4473)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(33.124, 3.9468),
							_Utils_Tuple2(34.772, 4.6463))
						]))))
		]));
var $author$project$Main$fishS = function (colour) {
	return $MacCASOutreach$graphicsvg$GraphicSVG$group(
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(-20, -34),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					colour,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 28, 24))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(-30, -23),
				$author$project$Main$eyeShellS),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(-41, -23),
				$author$project$Main$eyeShellS),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(-22, -40),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$scaleX,
					-1,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$scale, 0.15, $author$project$Main$mouthShellS)))
			]));
};
var $author$project$Main$fishTailS = function (colour) {
	return $MacCASOutreach$graphicsvg$GraphicSVG$group(
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				colour,
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$curve,
					_Utils_Tuple2(-7.044, -32.52),
					_List_fromArray(
						[
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-4.646, -30.10),
							_Utils_Tuple2(-2.248, -29.52)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-3.896, -33.61),
							_Utils_Tuple2(-5.545, -34.62)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-3.666, -35.85),
							_Utils_Tuple2(-3.147, -39.11)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-5.096, -39.52),
							_Utils_Tuple2(-7.044, -38.22)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-7.194, -36.42),
							_Utils_Tuple2(-7.344, -34.62)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-7.644, -33.57),
							_Utils_Tuple2(-7.044, -32.52))
						])))
			]));
};
var $author$project$Main$leftFinS = function (colour) {
	return $MacCASOutreach$graphicsvg$GraphicSVG$group(
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				colour,
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$curve,
					_Utils_Tuple2(-32.82, -38.22),
					_List_fromArray(
						[
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-34.17, -38.81),
							_Utils_Tuple2(-35.52, -39.41)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-35.07, -40.16),
							_Utils_Tuple2(-34.62, -40.91)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-34.02, -40.61),
							_Utils_Tuple2(-33.42, -40.31)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-33.27, -40.61),
							_Utils_Tuple2(-33.12, -40.91)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-33.42, -41.36),
							_Utils_Tuple2(-33.72, -41.81)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-32.93, -42.26),
							_Utils_Tuple2(-31.62, -42.71)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-30.57, -43.16),
							_Utils_Tuple2(-32.82, -38.22))
						])))
			]));
};
var $author$project$Main$repeatDistance = F4(
	function (speed, start, end, t) {
		return start + A2($author$project$Main$fractionalModBy, end - start, speed * t);
	});
var $author$project$Main$rightFinS = function (colour) {
	return $MacCASOutreach$graphicsvg$GraphicSVG$group(
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				colour,
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$curve,
					_Utils_Tuple2(-11.54, -36.72),
					_List_fromArray(
						[
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-13.18, -39.41),
							_Utils_Tuple2(-14.83, -42.11)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-13.93, -42.26),
							_Utils_Tuple2(-13.03, -42.41)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-12.74, -41.96),
							_Utils_Tuple2(-12.44, -41.51)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-12.14, -41.96),
							_Utils_Tuple2(-11.84, -42.41)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-10.94, -42.55),
							_Utils_Tuple2(-10.04, -42.41)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-8.992, -41.96),
							_Utils_Tuple2(-7.943, -41.51)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-8.683, -40.16),
							_Utils_Tuple2(-11.54, -36.72))
						])))
			]));
};
var $author$project$Main$sandGradient = F2(
	function (x0, x1) {
		return A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$rotateGradient,
			$elm$core$Basics$degrees(33),
			$MacCASOutreach$graphicsvg$GraphicSVG$gradient(
				_List_fromArray(
					[
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$stop,
						A3(
							$MacCASOutreach$graphicsvg$GraphicSVG$hsl,
							$elm$core$Basics$degrees(26),
							0.93,
							0.25),
						x0),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$stop,
						A3(
							$MacCASOutreach$graphicsvg$GraphicSVG$hsl,
							$elm$core$Basics$degrees(42),
							0.5,
							0.75),
						x1)
					])));
	});
var $author$project$Main$upperFinS = function (colour) {
	return $MacCASOutreach$graphicsvg$GraphicSVG$group(
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				colour,
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$curve,
					_Utils_Tuple2(-26.82, -26.52),
					_List_fromArray(
						[
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-26.67, -24.28),
							_Utils_Tuple2(-26.52, -22.03)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-24.88, -21.04),
							_Utils_Tuple2(-23.23, -21.13)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-23.08, -22.03),
							_Utils_Tuple2(-22.93, -22.93)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-22.48, -22.18),
							_Utils_Tuple2(-22.03, -21.43)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-19.78, -20.47),
							_Utils_Tuple2(-17.53, -20.83)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-17.53, -21.88),
							_Utils_Tuple2(-17.53, -22.93)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-16.78, -22.18),
							_Utils_Tuple2(-16.03, -21.43)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-13.48, -21.57),
							_Utils_Tuple2(-10.94, -24.43)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-9.182, -27.30),
							_Utils_Tuple2(-9.142, -29.82)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-11.54, -26.97),
							_Utils_Tuple2(-13.93, -25.92)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-17.38, -24.37),
							_Utils_Tuple2(-20.83, -24.73)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-23.83, -25.01),
							_Utils_Tuple2(-26.82, -26.52))
						])))
			]));
};
var $author$project$Main$codyS = F2(
	function (model, colour) {
		return $MacCASOutreach$graphicsvg$GraphicSVG$group(
			_List_fromArray(
				[
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(
						A4($author$project$Main$repeatDistance, 60, 500, 100, -model.time),
						0),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(-20, 50),
						$author$project$Main$fishS(
							A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$rotateGradient,
								$elm$core$Basics$degrees(180),
								A2($author$project$Main$sandGradient, 0, 40))))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
					$elm$core$Basics$degrees(1.3) * $elm$core$Basics$sin(model.time * 10),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(
							A4($author$project$Main$repeatDistance, 60, 500, 100, -model.time),
							0),
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$move,
							_Utils_Tuple2(-20, 50),
							$author$project$Main$rightFinS(
								A2($author$project$Main$sandGradient, -10, 100))))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
					$elm$core$Basics$degrees(-1.3) * $elm$core$Basics$sin(model.time * 10),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(
							A4($author$project$Main$repeatDistance, 60, 500, 100, -model.time),
							0),
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$move,
							_Utils_Tuple2(-20, 50),
							$author$project$Main$leftFinS(
								A2($author$project$Main$sandGradient, -10, 100))))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(
						0,
						2 * $elm$core$Basics$sin(model.time * 5)),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(
							A4($author$project$Main$repeatDistance, 60, 500, 100, -model.time),
							0),
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$move,
							_Utils_Tuple2(-20, 50),
							$author$project$Main$fishTailS(
								A2($author$project$Main$sandGradient, 10, 100))))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(
						A4($author$project$Main$repeatDistance, 60, 500, 100, -model.time),
						0),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(-20, 50),
						$author$project$Main$upperFinS(
							A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$rotateGradient,
								$elm$core$Basics$degrees(180),
								A2($author$project$Main$sandGradient, 30, 100)))))
				]));
	});
var $author$project$Main$debugSpeedup = 1;
var $author$project$Main$failedEndScript = _List_fromArray(
	[
		_Utils_Tuple2($author$project$Main$Mermaid, ' '),
		_Utils_Tuple2($author$project$Main$Mermaid, ' '),
		_Utils_Tuple2($author$project$Main$Mermaid, 'Aww... The three best friends'),
		_Utils_Tuple2($author$project$Main$Mermaid, 'never spoke to each other ever'),
		_Utils_Tuple2($author$project$Main$Mermaid, 'again... :('),
		_Utils_Tuple2($author$project$Main$Mermaid, ' '),
		_Utils_Tuple2($author$project$Main$Mermaid, 'Do you want to try again to'),
		_Utils_Tuple2($author$project$Main$Mermaid, 'save the friendship?'),
		_Utils_Tuple2($author$project$Main$Mermaid, ' ')
	]);
var $MacCASOutreach$graphicsvg$GraphicSVG$pink = A4($MacCASOutreach$graphicsvg$GraphicSVG$rgba, 255, 105, 180, 1);
var $MacCASOutreach$graphicsvg$GraphicSVG$red = A4($MacCASOutreach$graphicsvg$GraphicSVG$rgba, 204, 0, 0, 1);
var $author$project$Main$mermaid = $MacCASOutreach$graphicsvg$GraphicSVG$group(
	_List_fromArray(
		[
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$filled,
			A3($MacCASOutreach$graphicsvg$GraphicSVG$rgb, 69, 38, 14),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$curve,
				_Utils_Tuple2(-47.81, 14.838),
				_List_fromArray(
					[
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-46.96, 12.488),
						_Utils_Tuple2(-45.71, 14.538)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-51.21, 27.682),
						_Utils_Tuple2(-45.11, 31.025)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-44.96, 33.223),
						_Utils_Tuple2(-42.41, 35.822)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-35.72, 47.018),
						_Utils_Tuple2(-19.63, 46.014)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(0.5573, 44.523),
						_Utils_Tuple2(0.7494, 21.433)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(1.9491, 19.983),
						_Utils_Tuple2(1.3489, 19.934)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(3.3487, 18.437),
						_Utils_Tuple2(1.9484, 13.339)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(2.6978, 11.639),
						_Utils_Tuple2(3.4473, 13.339)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(5.1985, 7.8915),
						_Utils_Tuple2(0.1498, 8.2435)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-0.800, 5.3950),
						_Utils_Tuple2(1.6487, 4.3466)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(5.0978, 3.7456),
						_Utils_Tuple2(3.7470, 6.7447)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(8.6459, 5.5480),
						_Utils_Tuple2(6.7447, -1.648)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(4.1976, -6.996),
						_Utils_Tuple2(-0.749, -6.744)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-0.147, -13.79),
						_Utils_Tuple2(-5.545, -16.03)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-8.843, -18.03),
						_Utils_Tuple2(-12.14, -17.23)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-20.68, -8.992),
						_Utils_Tuple2(-29.22, -0.749)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-34.62, -2.450),
						_Utils_Tuple2(-40.01, 1.0491)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-43.36, 4.6463),
						_Utils_Tuple2(-43.91, 8.2435)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-47.81, 7.5920),
						_Utils_Tuple2(-49.91, 12.140)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-49.91, 14.439),
						_Utils_Tuple2(-47.81, 14.838))
					]))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$filled,
			A3($MacCASOutreach$graphicsvg$GraphicSVG$rgb, 205, 156, 109),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$curve,
				_Utils_Tuple2(-37.62, 21.133),
				_List_fromArray(
					[
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-37.36, 17.335),
						_Utils_Tuple2(-39.71, 15.138)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-37.27, 6.5915),
						_Utils_Tuple2(-27.42, 6.4449)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-23.23, 5.6449),
						_Utils_Tuple2(-19.03, 6.4449)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-9.789, 7.0920),
						_Utils_Tuple2(-7.344, 13.939)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-6.894, 14.388),
						_Utils_Tuple2(-6.444, 14.838)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-3.895, 14.287),
						_Utils_Tuple2(-4.346, 17.536)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-5.545, 19.236),
						_Utils_Tuple2(-6.744, 17.536)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-8.392, 21.583),
						_Utils_Tuple2(-12.44, 23.831)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-15.88, 25.679),
						_Utils_Tuple2(-17.53, 29.526)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-22.13, 25.578),
						_Utils_Tuple2(-30.12, 25.030)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-31.17, 21.081),
						_Utils_Tuple2(-37.62, 21.133))
					]))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$filled,
			A3($MacCASOutreach$graphicsvg$GraphicSVG$rgb, 205, 156, 109),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$curve,
				_Utils_Tuple2(-19.33, 6.4449),
				_List_fromArray(
					[
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-19.63, 5.9953),
						_Utils_Tuple2(-18.73, 5.5456)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-16.28, 5.1459),
						_Utils_Tuple2(-15.43, 4.9461)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-14.23, 4.5484),
						_Utils_Tuple2(-12.44, -1.049)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-12.24, -2.548),
						_Utils_Tuple2(-11.84, -4.046)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-9.592, -8.243),
						_Utils_Tuple2(-7.344, -12.44)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-6.744, -12.44),
						_Utils_Tuple2(-6.145, -12.44)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-5.545, -11.99),
						_Utils_Tuple2(-4.946, -11.54)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-4.046, -11.79),
						_Utils_Tuple2(-4.346, -11.84)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-2.747, -11.99),
						_Utils_Tuple2(-3.147, -12.74)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-2.097, -13.33),
						_Utils_Tuple2(-2.847, -13.93)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-2.398, -14.08),
						_Utils_Tuple2(-1.948, -14.23)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-2.047, -16.08),
						_Utils_Tuple2(-4.346, -15.73)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-6.296, -15.63),
						_Utils_Tuple2(-5.845, -18.13)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-7.344, -19.53),
						_Utils_Tuple2(-7.644, -18.13)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-7.943, -17.68),
						_Utils_Tuple2(-8.243, -17.23)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-9.092, -17.38),
						_Utils_Tuple2(-9.742, -15.13)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-12.04, -13.98),
						_Utils_Tuple2(-13.33, -10.64)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-14.23, -8.393),
						_Utils_Tuple2(-15.13, -6.145)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-14.83, -9.142),
						_Utils_Tuple2(-14.53, -12.14)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-22.93, -11.99),
						_Utils_Tuple2(-31.32, -11.84)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-31.47, -9.892),
						_Utils_Tuple2(-31.62, -7.943)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-31.32, -6.594),
						_Utils_Tuple2(-31.02, -5.245)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-31.77, -6.295),
						_Utils_Tuple2(-32.52, -7.344)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-33.62, -13.04),
						_Utils_Tuple2(-36.72, -15.13)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-37.12, -16.38),
						_Utils_Tuple2(-39.11, -17.83)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-40.01, -18.78),
						_Utils_Tuple2(-40.91, -18.13)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-40.21, -17.23),
						_Utils_Tuple2(-40.91, -16.33)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-41.91, -15.13),
						_Utils_Tuple2(-44.51, -15.13)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-45.46, -14.63),
						_Utils_Tuple2(-44.21, -13.93)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-44.56, -12.63),
						_Utils_Tuple2(-43.31, -12.74)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-43.71, -12.29),
						_Utils_Tuple2(-42.71, -11.84)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-42.46, -10.84),
						_Utils_Tuple2(-41.21, -11.84)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-40.91, -11.99),
						_Utils_Tuple2(-40.61, -12.14)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-40.16, -12.29),
						_Utils_Tuple2(-39.71, -12.44)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-39.56, -12.29),
						_Utils_Tuple2(-39.41, -12.14)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-36.57, -8.693),
						_Utils_Tuple2(-34.92, -3.447)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-34.17, 0.5995),
						_Utils_Tuple2(-32.22, 4.6463)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-31.22, 5.3960),
						_Utils_Tuple2(-28.62, 5.5456)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-27.12, 5.8454),
						_Utils_Tuple2(-27.42, 6.1451)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-27.57, 6.4449),
						_Utils_Tuple2(-27.72, 6.7447)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-23.83, 7.1943),
						_Utils_Tuple2(-19.33, 6.4449))
					]))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$filled,
			A3($MacCASOutreach$graphicsvg$GraphicSVG$rgb, 250, 203, 9),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$curve,
				_Utils_Tuple2(-14.83, -7.344),
				_List_fromArray(
					[
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-15.68, -8.993),
						_Utils_Tuple2(-18.13, -9.442)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-21.63, -9.842),
						_Utils_Tuple2(-22.93, -10.64)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-24.93, -9.992),
						_Utils_Tuple2(-27.72, -9.742)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-31.12, -9.443),
						_Utils_Tuple2(-31.92, -7.344)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-34.37, -7.293),
						_Utils_Tuple2(-34.02, -9.442)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-33.47, -10.64),
						_Utils_Tuple2(-33.12, -10.64)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-33.32, -12.69),
						_Utils_Tuple2(-30.72, -12.14)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-29.97, -13.99),
						_Utils_Tuple2(-28.02, -13.03)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-26.02, -14.93),
						_Utils_Tuple2(-23.23, -13.03)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-20.83, -14.83),
						_Utils_Tuple2(-18.43, -13.03)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-17.48, -14.59),
						_Utils_Tuple2(-15.73, -12.14)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-13.53, -13.19),
						_Utils_Tuple2(-13.33, -10.04)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-11.98, -8.193),
						_Utils_Tuple2(-14.83, -7.344))
					]))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$filled,
			A3($MacCASOutreach$graphicsvg$GraphicSVG$rgb, 250, 203, 9),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$curve,
				_Utils_Tuple2(-31.62, 1.0491),
				_List_fromArray(
					[
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-32.22, -2.098),
						_Utils_Tuple2(-31.02, -5.245)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-23.93, -7.445),
						_Utils_Tuple2(-15.43, -5.245)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-15.28, -2.398),
						_Utils_Tuple2(-15.13, 0.4496)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-16.33, 2.7491),
						_Utils_Tuple2(-17.53, 1.6487)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-19.03, 3.6484),
						_Utils_Tuple2(-20.53, 2.2482)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-22.03, 3.5981),
						_Utils_Tuple2(-23.53, 2.5480)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-25.33, 3.6482),
						_Utils_Tuple2(-27.12, 1.9484)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-28.32, 3.1985),
						_Utils_Tuple2(-29.52, 1.6487)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-30.57, 2.0489),
						_Utils_Tuple2(-31.62, 1.0491))
					]))),
			A3(
			$MacCASOutreach$graphicsvg$GraphicSVG$outlined,
			$MacCASOutreach$graphicsvg$GraphicSVG$solid(1),
			$MacCASOutreach$graphicsvg$GraphicSVG$red,
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$curve,
				_Utils_Tuple2(-25.92, 9.7423),
				_List_fromArray(
					[
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-23.93, 8.1423),
						_Utils_Tuple2(-21.13, 9.7423))
					]))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$filled,
			$MacCASOutreach$graphicsvg$GraphicSVG$pink,
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$curve,
				_Utils_Tuple2(-14.23, 35.222),
				_List_fromArray(
					[
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-14.08, 33.873),
						_Utils_Tuple2(-13.93, 32.524)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-14.53, 31.325),
						_Utils_Tuple2(-15.13, 30.126)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-13.63, 29.826),
						_Utils_Tuple2(-12.14, 29.526)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-11.09, 28.327),
						_Utils_Tuple2(-10.04, 27.128)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-9.442, 28.477),
						_Utils_Tuple2(-8.843, 29.826)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-7.494, 30.426),
						_Utils_Tuple2(-6.145, 31.025)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-7.194, 32.074),
						_Utils_Tuple2(-8.243, 33.124)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-8.543, 34.622),
						_Utils_Tuple2(-8.843, 36.121)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-10.04, 35.522),
						_Utils_Tuple2(-11.24, 34.922)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-12.74, 35.072),
						_Utils_Tuple2(-14.23, 35.222))
					]))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-7.5, 28),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$white,
				$MacCASOutreach$graphicsvg$GraphicSVG$circle(1.5))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-5.5, 26),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$white,
				$MacCASOutreach$graphicsvg$GraphicSVG$circle(1))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-5, 24),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$white,
				$MacCASOutreach$graphicsvg$GraphicSVG$circle(0.75))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-5, 22.5),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$white,
				$MacCASOutreach$graphicsvg$GraphicSVG$circle(0.5))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-7.25, 14.5),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$pink,
				$MacCASOutreach$graphicsvg$GraphicSVG$circle(0.75))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-14, 16.7),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$white,
				A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 4.5, 3.8))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-33, 16.7),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$white,
				A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 4.5, 3.8))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$clip,
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(-14, 16.7),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					$MacCASOutreach$graphicsvg$GraphicSVG$white,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 4.5, 3.8))),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(-14, 17.2),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					$MacCASOutreach$graphicsvg$GraphicSVG$black,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 2.4, 3.3)))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$clip,
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(-33, 16.7),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					$MacCASOutreach$graphicsvg$GraphicSVG$white,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 4.5, 3.8))),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(-33, 17.2),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					$MacCASOutreach$graphicsvg$GraphicSVG$black,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 2.4, 3.3))))
		]));
var $author$project$Main$flippers = _List_fromArray(
	[
		A2(
		$author$project$Main$MyCurve,
		_Utils_Tuple2(-9.442, 40.018),
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-21.99, 9.1911),
				_Utils_Tuple2(1.6487, -17.23)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-8.408, -45.32),
				_Utils_Tuple2(21.133, -55.60)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(23.533, -42.26),
				_Utils_Tuple2(19.934, -27.12)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(34.173, -30.88),
				_Utils_Tuple2(48.412, -19.03)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(35.425, 2.1604),
				_Utils_Tuple2(13.039, -7.644)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(3.6903, 3.6880),
				_Utils_Tuple2(11.540, 38.220)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-0.000, 43.619),
				_Utils_Tuple2(-9.442, 40.018))
			])),
		A2(
		$author$project$Main$MyCurve,
		_Utils_Tuple2(-9.442, 40.018),
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-23.39, 27.841),
				_Utils_Tuple2(-5.545, -18.73)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-13.04, -43.01),
				_Utils_Tuple2(1.6487, -58.90)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(17.394, -47.61),
				_Utils_Tuple2(13.339, -29.52)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(23.927, -38.87),
				_Utils_Tuple2(44.515, -28.62)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(35.328, -8.883),
				_Utils_Tuple2(10.941, -13.33)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-1.358, -7.259),
				_Utils_Tuple2(10.941, 38.220)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(0.4496, 42.569),
				_Utils_Tuple2(-9.442, 40.018))
			])),
		A2(
		$author$project$Main$MyCurve,
		_Utils_Tuple2(-9.742, 39.718),
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-22.89, 22.091),
				_Utils_Tuple2(-8.243, -17.53)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-25.68, -39.72),
				_Utils_Tuple2(-17.53, -53.50)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-3.444, -57.11),
				_Utils_Tuple2(3.4473, -37.32)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(8.4892, -50.56),
				_Utils_Tuple2(24.131, -50.81)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(26.437, -31.02),
				_Utils_Tuple2(9.1428, -17.23)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(14.942, 11.091),
				_Utils_Tuple2(9.7423, 39.419)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-1.949, 41.919),
				_Utils_Tuple2(-9.742, 39.718))
			])),
		A2(
		$author$project$Main$MyCurve,
		_Utils_Tuple2(-9.742, 39.419),
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-23.79, 21.641),
				_Utils_Tuple2(-9.442, -16.93)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-26.63, -21.32),
				_Utils_Tuple2(-30.42, -40.31)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-19.33, -45.92),
				_Utils_Tuple2(-8.243, -33.72)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-3.300, -46.31),
				_Utils_Tuple2(10.042, -48.71)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(15.144, -35.02),
				_Utils_Tuple2(5.2459, -19.33)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(16.493, 21.742),
				_Utils_Tuple2(10.341, 38.220)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-1.900, 43.669),
				_Utils_Tuple2(-9.742, 39.419))
			])),
		A2(
		$author$project$Main$MyCurve,
		_Utils_Tuple2(-12.44, 38.519),
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-14.74, 16.740),
				_Utils_Tuple2(-11.24, -15.43)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-31.38, -23.57),
				_Utils_Tuple2(-33.12, -37.92)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-21.13, -43.87),
				_Utils_Tuple2(-10.94, -34.02)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-7.098, -47.66),
				_Utils_Tuple2(6.1451, -49.31)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(11.296, -35.17),
				_Utils_Tuple2(4.0468, -19.63)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(18.194, 15.992),
				_Utils_Tuple2(10.941, 38.819)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-0.599, 42.569),
				_Utils_Tuple2(-12.44, 38.519))
			])),
		A2(
		$author$project$Main$MyCurve,
		_Utils_Tuple2(-10.34, 39.119),
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-10.69, 13.089),
				_Utils_Tuple2(-13.03, -13.33)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-33.08, -22.88),
				_Utils_Tuple2(-35.52, -35.82)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-22.18, -41.82),
				_Utils_Tuple2(-13.63, -32.82)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-10.49, -45.61),
				_Utils_Tuple2(1.0491, -50.21)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(10.599, -41.62),
				_Utils_Tuple2(0.7494, -18.43)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(17.545, 4.1423),
				_Utils_Tuple2(10.941, 37.920)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-0.299, 43.119),
				_Utils_Tuple2(-10.34, 39.119))
			])),
		A2(
		$author$project$Main$MyCurve,
		_Utils_Tuple2(-11.84, 38.819),
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-6.639, 22.239),
				_Utils_Tuple2(-14.23, -12.14)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-31.12, -18.93),
				_Utils_Tuple2(-38.22, -34.32)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-25.37, -40.12),
				_Utils_Tuple2(-15.73, -32.52)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-14.14, -43.71),
				_Utils_Tuple2(-1.948, -50.51)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(6.7512, -37.12),
				_Utils_Tuple2(-1.348, -18.73)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(16.696, 0.6922),
				_Utils_Tuple2(10.341, 38.519)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-0.599, 42.119),
				_Utils_Tuple2(-11.84, 38.819))
			])),
		A2(
		$author$project$Main$MyCurve,
		_Utils_Tuple2(10.941, 38.519),
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(19.744, 14.292),
				_Utils_Tuple2(2.5480, -19.33)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(8.9480, -37.67),
				_Utils_Tuple2(2.5480, -52.60)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-12.89, -49.56),
				_Utils_Tuple2(-14.53, -31.92)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-22.63, -40.67),
				_Utils_Tuple2(-35.52, -34.62)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-38.33, -21.98),
				_Utils_Tuple2(-13.33, -13.33)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-5.390, 1.5903),
				_Utils_Tuple2(-11.84, 37.920)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-6.199, 42.970),
				_Utils_Tuple2(10.941, 38.519))
			])),
		A2(
		$author$project$Main$MyCurve,
		_Utils_Tuple2(10.941, 38.819),
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(12.996, -3.907),
				_Utils_Tuple2(-2.548, -20.23)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(3.5039, -46.87),
				_Utils_Tuple2(-7.644, -54.70)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-22.98, -49.01),
				_Utils_Tuple2(-18.13, -26.52)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-32.17, -30.53),
				_Utils_Tuple2(-43.61, -20.53)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-34.57, -6.788),
				_Utils_Tuple2(-20.53, -10.04)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-6.487, -5.111),
				_Utils_Tuple2(-12.44, 38.220)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
				_Utils_Tuple2(-2.649, 42.420),
				_Utils_Tuple2(10.941, 38.819))
			]))
	]);
var $author$project$Main$tail = function (model) {
	return $MacCASOutreach$graphicsvg$GraphicSVG$group(
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				A3($MacCASOutreach$graphicsvg$GraphicSVG$rgb, 244, 96, 180),
				$author$project$Main$drawCurve(
					A3(
						$author$project$Main$animationPieces,
						A4($author$project$Main$mkAnimationPieceVS, $author$project$Main$addCurve, $author$project$Main$subCurve, $author$project$Main$scaleCurve, $author$project$Main$flippers),
						function (t) {
							return A2(
								$author$project$Main$MyCurve,
								_Utils_Tuple2(0, 0),
								_List_Nil);
						},
						3 + (3 * $elm$core$Basics$cos(model.time)))))
			]));
};
var $author$project$Main$completeMermaid = function (model) {
	return $MacCASOutreach$graphicsvg$GraphicSVG$group(
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(-68, -13),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$scale,
					0.5,
					$author$project$Main$tail(model))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(-50, 15),
				A2($MacCASOutreach$graphicsvg$GraphicSVG$scale, 0.75, $author$project$Main$mermaid))
			]));
};
var $author$project$Main$finalMermaid = function (model) {
	return $MacCASOutreach$graphicsvg$GraphicSVG$group(
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(
					0,
					(10 * $elm$core$Basics$sin(model.time)) * 0.5),
				$author$project$Main$completeMermaid(model))
			]));
};
var $MacCASOutreach$graphicsvg$GraphicSVG$mirrorY = function (shape) {
	return A3($MacCASOutreach$graphicsvg$GraphicSVG$Secret$Scale, 1, -1, shape);
};
var $author$project$Main$sadMermaid = $MacCASOutreach$graphicsvg$GraphicSVG$group(
	_List_fromArray(
		[
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$filled,
			A3($MacCASOutreach$graphicsvg$GraphicSVG$rgb, 69, 38, 14),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$curve,
				_Utils_Tuple2(-47.81, 14.838),
				_List_fromArray(
					[
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-46.96, 12.488),
						_Utils_Tuple2(-45.71, 14.538)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-51.21, 27.682),
						_Utils_Tuple2(-45.11, 31.025)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-44.96, 33.223),
						_Utils_Tuple2(-42.41, 35.822)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-35.72, 47.018),
						_Utils_Tuple2(-19.63, 46.014)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(0.5573, 44.523),
						_Utils_Tuple2(0.7494, 21.433)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(1.9491, 19.983),
						_Utils_Tuple2(1.3489, 19.934)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(3.3487, 18.437),
						_Utils_Tuple2(1.9484, 13.339)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(2.6978, 11.639),
						_Utils_Tuple2(3.4473, 13.339)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(5.1985, 7.8915),
						_Utils_Tuple2(0.1498, 8.2435)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-0.800, 5.3950),
						_Utils_Tuple2(1.6487, 4.3466)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(5.0978, 3.7456),
						_Utils_Tuple2(3.7470, 6.7447)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(8.6459, 5.5480),
						_Utils_Tuple2(6.7447, -1.648)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(4.1976, -6.996),
						_Utils_Tuple2(-0.749, -6.744)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-0.147, -13.79),
						_Utils_Tuple2(-5.545, -16.03)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-8.843, -18.03),
						_Utils_Tuple2(-12.14, -17.23)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-20.68, -8.992),
						_Utils_Tuple2(-29.22, -0.749)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-34.62, -2.450),
						_Utils_Tuple2(-40.01, 1.0491)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-43.36, 4.6463),
						_Utils_Tuple2(-43.91, 8.2435)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-47.81, 7.5920),
						_Utils_Tuple2(-49.91, 12.140)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-49.91, 14.439),
						_Utils_Tuple2(-47.81, 14.838))
					]))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$filled,
			A3($MacCASOutreach$graphicsvg$GraphicSVG$rgb, 205, 156, 109),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$curve,
				_Utils_Tuple2(-37.62, 21.133),
				_List_fromArray(
					[
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-37.36, 17.335),
						_Utils_Tuple2(-39.71, 15.138)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-37.27, 6.5915),
						_Utils_Tuple2(-27.42, 6.4449)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-23.23, 5.6449),
						_Utils_Tuple2(-19.03, 6.4449)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-9.789, 7.0920),
						_Utils_Tuple2(-7.344, 13.939)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-6.894, 14.388),
						_Utils_Tuple2(-6.444, 14.838)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-3.895, 14.287),
						_Utils_Tuple2(-4.346, 17.536)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-5.545, 19.236),
						_Utils_Tuple2(-6.744, 17.536)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-8.392, 21.583),
						_Utils_Tuple2(-12.44, 23.831)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-15.88, 25.679),
						_Utils_Tuple2(-17.53, 29.526)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-22.13, 25.578),
						_Utils_Tuple2(-30.12, 25.030)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-31.17, 21.081),
						_Utils_Tuple2(-37.62, 21.133))
					]))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$filled,
			A3($MacCASOutreach$graphicsvg$GraphicSVG$rgb, 205, 156, 109),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$curve,
				_Utils_Tuple2(-19.33, 6.4449),
				_List_fromArray(
					[
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-19.63, 5.9953),
						_Utils_Tuple2(-18.73, 5.5456)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-16.28, 5.1459),
						_Utils_Tuple2(-15.43, 4.9461)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-14.23, 4.5484),
						_Utils_Tuple2(-12.44, -1.049)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-12.24, -2.548),
						_Utils_Tuple2(-11.84, -4.046)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-9.592, -8.243),
						_Utils_Tuple2(-7.344, -12.44)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-6.744, -12.44),
						_Utils_Tuple2(-6.145, -12.44)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-5.545, -11.99),
						_Utils_Tuple2(-4.946, -11.54)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-4.046, -11.79),
						_Utils_Tuple2(-4.346, -11.84)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-2.747, -11.99),
						_Utils_Tuple2(-3.147, -12.74)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-2.097, -13.33),
						_Utils_Tuple2(-2.847, -13.93)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-2.398, -14.08),
						_Utils_Tuple2(-1.948, -14.23)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-2.047, -16.08),
						_Utils_Tuple2(-4.346, -15.73)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-6.296, -15.63),
						_Utils_Tuple2(-5.845, -18.13)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-7.344, -19.53),
						_Utils_Tuple2(-7.644, -18.13)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-7.943, -17.68),
						_Utils_Tuple2(-8.243, -17.23)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-9.092, -17.38),
						_Utils_Tuple2(-9.742, -15.13)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-12.04, -13.98),
						_Utils_Tuple2(-13.33, -10.64)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-14.23, -8.393),
						_Utils_Tuple2(-15.13, -6.145)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-14.83, -9.142),
						_Utils_Tuple2(-14.53, -12.14)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-22.93, -11.99),
						_Utils_Tuple2(-31.32, -11.84)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-31.47, -9.892),
						_Utils_Tuple2(-31.62, -7.943)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-31.32, -6.594),
						_Utils_Tuple2(-31.02, -5.245)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-31.77, -6.295),
						_Utils_Tuple2(-32.52, -7.344)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-33.62, -13.04),
						_Utils_Tuple2(-36.72, -15.13)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-37.12, -16.38),
						_Utils_Tuple2(-39.11, -17.83)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-40.01, -18.78),
						_Utils_Tuple2(-40.91, -18.13)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-40.21, -17.23),
						_Utils_Tuple2(-40.91, -16.33)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-41.91, -15.13),
						_Utils_Tuple2(-44.51, -15.13)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-45.46, -14.63),
						_Utils_Tuple2(-44.21, -13.93)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-44.56, -12.63),
						_Utils_Tuple2(-43.31, -12.74)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-43.71, -12.29),
						_Utils_Tuple2(-42.71, -11.84)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-42.46, -10.84),
						_Utils_Tuple2(-41.21, -11.84)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-40.91, -11.99),
						_Utils_Tuple2(-40.61, -12.14)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-40.16, -12.29),
						_Utils_Tuple2(-39.71, -12.44)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-39.56, -12.29),
						_Utils_Tuple2(-39.41, -12.14)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-36.57, -8.693),
						_Utils_Tuple2(-34.92, -3.447)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-34.17, 0.5995),
						_Utils_Tuple2(-32.22, 4.6463)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-31.22, 5.3960),
						_Utils_Tuple2(-28.62, 5.5456)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-27.12, 5.8454),
						_Utils_Tuple2(-27.42, 6.1451)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-27.57, 6.4449),
						_Utils_Tuple2(-27.72, 6.7447)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-23.83, 7.1943),
						_Utils_Tuple2(-19.33, 6.4449))
					]))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$filled,
			A3($MacCASOutreach$graphicsvg$GraphicSVG$rgb, 250, 203, 9),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$curve,
				_Utils_Tuple2(-14.83, -7.344),
				_List_fromArray(
					[
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-15.68, -8.993),
						_Utils_Tuple2(-18.13, -9.442)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-21.63, -9.842),
						_Utils_Tuple2(-22.93, -10.64)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-24.93, -9.992),
						_Utils_Tuple2(-27.72, -9.742)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-31.12, -9.443),
						_Utils_Tuple2(-31.92, -7.344)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-34.37, -7.293),
						_Utils_Tuple2(-34.02, -9.442)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-33.47, -10.64),
						_Utils_Tuple2(-33.12, -10.64)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-33.32, -12.69),
						_Utils_Tuple2(-30.72, -12.14)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-29.97, -13.99),
						_Utils_Tuple2(-28.02, -13.03)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-26.02, -14.93),
						_Utils_Tuple2(-23.23, -13.03)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-20.83, -14.83),
						_Utils_Tuple2(-18.43, -13.03)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-17.48, -14.59),
						_Utils_Tuple2(-15.73, -12.14)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-13.53, -13.19),
						_Utils_Tuple2(-13.33, -10.04)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-11.98, -8.193),
						_Utils_Tuple2(-14.83, -7.344))
					]))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$filled,
			A3($MacCASOutreach$graphicsvg$GraphicSVG$rgb, 250, 203, 9),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$curve,
				_Utils_Tuple2(-31.62, 1.0491),
				_List_fromArray(
					[
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-32.22, -2.098),
						_Utils_Tuple2(-31.02, -5.245)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-23.93, -7.445),
						_Utils_Tuple2(-15.43, -5.245)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-15.28, -2.398),
						_Utils_Tuple2(-15.13, 0.4496)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-16.33, 2.7491),
						_Utils_Tuple2(-17.53, 1.6487)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-19.03, 3.6484),
						_Utils_Tuple2(-20.53, 2.2482)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-22.03, 3.5981),
						_Utils_Tuple2(-23.53, 2.5480)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-25.33, 3.6482),
						_Utils_Tuple2(-27.12, 1.9484)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-28.32, 3.1985),
						_Utils_Tuple2(-29.52, 1.6487)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-30.57, 2.0489),
						_Utils_Tuple2(-31.62, 1.0491))
					]))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(0, 20),
			$MacCASOutreach$graphicsvg$GraphicSVG$mirrorY(
				A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$outlined,
					$MacCASOutreach$graphicsvg$GraphicSVG$solid(1),
					$MacCASOutreach$graphicsvg$GraphicSVG$red,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$curve,
						_Utils_Tuple2(-25.92, 9.7423),
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-23.93, 8.1423),
								_Utils_Tuple2(-21.13, 9.7423))
							]))))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$filled,
			$MacCASOutreach$graphicsvg$GraphicSVG$pink,
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$curve,
				_Utils_Tuple2(-14.23, 35.222),
				_List_fromArray(
					[
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-14.08, 33.873),
						_Utils_Tuple2(-13.93, 32.524)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-14.53, 31.325),
						_Utils_Tuple2(-15.13, 30.126)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-13.63, 29.826),
						_Utils_Tuple2(-12.14, 29.526)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-11.09, 28.327),
						_Utils_Tuple2(-10.04, 27.128)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-9.442, 28.477),
						_Utils_Tuple2(-8.843, 29.826)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-7.494, 30.426),
						_Utils_Tuple2(-6.145, 31.025)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-7.194, 32.074),
						_Utils_Tuple2(-8.243, 33.124)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-8.543, 34.622),
						_Utils_Tuple2(-8.843, 36.121)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-10.04, 35.522),
						_Utils_Tuple2(-11.24, 34.922)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
						_Utils_Tuple2(-12.74, 35.072),
						_Utils_Tuple2(-14.23, 35.222))
					]))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-7.5, 28),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$white,
				$MacCASOutreach$graphicsvg$GraphicSVG$circle(1.5))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-5.5, 26),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$white,
				$MacCASOutreach$graphicsvg$GraphicSVG$circle(1))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-5, 24),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$white,
				$MacCASOutreach$graphicsvg$GraphicSVG$circle(0.75))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-5, 22.5),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$white,
				$MacCASOutreach$graphicsvg$GraphicSVG$circle(0.5))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-7.25, 14.5),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$pink,
				$MacCASOutreach$graphicsvg$GraphicSVG$circle(0.75))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-14, 16.7),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$white,
				A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 4.5, 3.8))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-33, 16.7),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$white,
				A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 4.5, 3.8))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$clip,
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(-14, 16.7),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					$MacCASOutreach$graphicsvg$GraphicSVG$white,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 4.5, 3.8))),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(-14, 17.2),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					$MacCASOutreach$graphicsvg$GraphicSVG$black,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 2.4, 3.3)))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$clip,
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(-33, 16.7),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					$MacCASOutreach$graphicsvg$GraphicSVG$white,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 4.5, 3.8))),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(-33, 17.2),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					$MacCASOutreach$graphicsvg$GraphicSVG$black,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 2.4, 3.3))))
		]));
var $author$project$Main$tailSad = function (model) {
	return $MacCASOutreach$graphicsvg$GraphicSVG$group(
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				A3($MacCASOutreach$graphicsvg$GraphicSVG$rgb, 244, 96, 180),
				$author$project$Main$drawCurve(
					A3(
						$author$project$Main$animationPieces,
						A4($author$project$Main$mkAnimationPieceVS, $author$project$Main$addCurve, $author$project$Main$subCurve, $author$project$Main$scaleCurve, $author$project$Main$flippers),
						function (t) {
							return A2(
								$author$project$Main$MyCurve,
								_Utils_Tuple2(0, 0),
								_List_Nil);
						},
						3 + (3 * $elm$core$Basics$cos(model.time)))))
			]));
};
var $author$project$Main$completeSadMermaid = function (model) {
	return $MacCASOutreach$graphicsvg$GraphicSVG$group(
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(-68, -13),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$scale,
					0.5,
					$author$project$Main$tailSad(model))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(-50, 15),
				A2($MacCASOutreach$graphicsvg$GraphicSVG$scale, 0.75, $author$project$Main$sadMermaid))
			]));
};
var $author$project$Main$finalSadMermaid = function (model) {
	return $MacCASOutreach$graphicsvg$GraphicSVG$group(
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(
					0,
					(10 * $elm$core$Basics$sin(model.time)) * 0.5),
				$author$project$Main$completeSadMermaid(model))
			]));
};
var $MacCASOutreach$graphicsvg$GraphicSVG$triangle = function (r) {
	return A2($MacCASOutreach$graphicsvg$GraphicSVG$ngon, 3, r);
};
var $author$project$Main$fishBackground = $MacCASOutreach$graphicsvg$GraphicSVG$group(
	_List_fromArray(
		[
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$filled,
			A3(
				$MacCASOutreach$graphicsvg$GraphicSVG$hsl,
				$elm$core$Basics$degrees(226),
				0.20,
				0.55),
			A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 15, 10)),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-8, 0),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$hsl,
					$elm$core$Basics$degrees(226),
					0.20,
					0.55),
				$MacCASOutreach$graphicsvg$GraphicSVG$triangle(5)))
		]));
var $MacCASOutreach$graphicsvg$GraphicSVG$mirrorX = function (shape) {
	return A3($MacCASOutreach$graphicsvg$GraphicSVG$Secret$Scale, -1, 1, shape);
};
var $author$project$Main$fishAni = function (model) {
	return $MacCASOutreach$graphicsvg$GraphicSVG$group(
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(
					A4($author$project$Main$repeatDuration, 9, 25, -105, model.time),
					-10),
				$author$project$Main$fishBackground),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(
					A4($author$project$Main$repeatDuration, -10, 23, 105, model.time),
					0),
				$MacCASOutreach$graphicsvg$GraphicSVG$mirrorX(
					A2($MacCASOutreach$graphicsvg$GraphicSVG$scale, 0.8, $author$project$Main$fishBackground))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(
					A4($author$project$Main$repeatDuration, 7, 35, -120, model.time),
					10),
				A2($MacCASOutreach$graphicsvg$GraphicSVG$scale, 0.6, $author$project$Main$fishBackground)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(
					A4($author$project$Main$repeatDuration, -7, 35, 130, model.time),
					25),
				$MacCASOutreach$graphicsvg$GraphicSVG$mirrorX(
					A2($MacCASOutreach$graphicsvg$GraphicSVG$scale, 0.6, $author$project$Main$fishBackground))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(
					A4($author$project$Main$repeatDuration, -10, 25, -105, model.time),
					40),
				$MacCASOutreach$graphicsvg$GraphicSVG$mirrorX(
					A2($MacCASOutreach$graphicsvg$GraphicSVG$scale, 0.6, $author$project$Main$fishBackground)))
			]));
};
var $MacCASOutreach$graphicsvg$GraphicSVG$green = A4($MacCASOutreach$graphicsvg$GraphicSVG$rgba, 115, 210, 22, 1);
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$AlignCentred = {$: 'AlignCentred'};
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Face = F8(
	function (a, b, c, d, e, f, g, h) {
		return {$: 'Face', a: a, b: b, c: c, d: d, e: e, f: f, g: g, h: h};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Text = F2(
	function (a, b) {
		return {$: 'Text', a: a, b: b};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$centered = function (stencil) {
	if (stencil.$ === 'Text') {
		var _v1 = stencil.a;
		var si = _v1.a;
		var bo = _v1.b;
		var i = _v1.c;
		var u = _v1.d;
		var s = _v1.e;
		var sel = _v1.f;
		var f = _v1.g;
		var c = _v1.h;
		var str = stencil.b;
		return A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Text,
			A8($MacCASOutreach$graphicsvg$GraphicSVG$Secret$Face, si, bo, i, u, s, sel, f, $MacCASOutreach$graphicsvg$GraphicSVG$Secret$AlignCentred),
			str);
	} else {
		var a = stencil;
		return a;
	}
};
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Sansserif = {$: 'Sansserif'};
var $MacCASOutreach$graphicsvg$GraphicSVG$sansserif = function (stencil) {
	if (stencil.$ === 'Text') {
		var _v1 = stencil.a;
		var si = _v1.a;
		var bo = _v1.b;
		var i = _v1.c;
		var u = _v1.d;
		var s = _v1.e;
		var sel = _v1.f;
		var f = _v1.g;
		var c = _v1.h;
		var str = stencil.b;
		return A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Text,
			A8($MacCASOutreach$graphicsvg$GraphicSVG$Secret$Face, si, bo, i, u, s, sel, $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Sansserif, c),
			str);
	} else {
		var a = stencil;
		return a;
	}
};
var $MacCASOutreach$graphicsvg$GraphicSVG$size = F2(
	function (sze, stencil) {
		if (stencil.$ === 'Text') {
			var _v1 = stencil.a;
			var si = _v1.a;
			var bo = _v1.b;
			var i = _v1.c;
			var u = _v1.d;
			var s = _v1.e;
			var sel = _v1.f;
			var f = _v1.g;
			var c = _v1.h;
			var str = stencil.b;
			return A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Text,
				A8($MacCASOutreach$graphicsvg$GraphicSVG$Secret$Face, sze, bo, i, u, s, sel, f, c),
				str);
		} else {
			var a = stencil;
			return a;
		}
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$AlignLeft = {$: 'AlignLeft'};
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Serif = {$: 'Serif'};
var $MacCASOutreach$graphicsvg$GraphicSVG$text = function (str) {
	return A2(
		$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Text,
		A8($MacCASOutreach$graphicsvg$GraphicSVG$Secret$Face, 12, false, false, false, false, false, $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Serif, $MacCASOutreach$graphicsvg$GraphicSVG$Secret$AlignLeft),
		str);
};
var $author$project$Main$headline = function (txt) {
	return A3(
		$MacCASOutreach$graphicsvg$GraphicSVG$addOutline,
		$MacCASOutreach$graphicsvg$GraphicSVG$solid(0.5),
		A3($MacCASOutreach$graphicsvg$GraphicSVG$rgb, 50, 155, 255),
		A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$filled,
			A3($MacCASOutreach$graphicsvg$GraphicSVG$rgb, 0, 100, 150),
			$MacCASOutreach$graphicsvg$GraphicSVG$sansserif(
				$MacCASOutreach$graphicsvg$GraphicSVG$centered(
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$size,
						10,
						$MacCASOutreach$graphicsvg$GraphicSVG$text(txt))))));
};
var $MacCASOutreach$graphicsvg$GraphicSVG$darkRed = A4($MacCASOutreach$graphicsvg$GraphicSVG$rgba, 164, 0, 0, 1);
var $author$project$Main$tentacles = function (color) {
	return $MacCASOutreach$graphicsvg$GraphicSVG$group(
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(-12, 1.5),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
					$elm$core$Basics$degrees(-60),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$filled,
						color,
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$curve,
							_Utils_Tuple2(0, 0),
							_List_fromArray(
								[
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(10, 0),
									_Utils_Tuple2(20, -10))
								]))))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(-9, -40),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
					$elm$core$Basics$degrees(120),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$filled,
						color,
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$curve,
							_Utils_Tuple2(0, 0),
							_List_fromArray(
								[
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(10, 0),
									_Utils_Tuple2(20, -10))
								]))))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(-6, 1.5),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$scale,
					0.75,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
						$elm$core$Basics$degrees(-60),
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$filled,
							color,
							A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$curve,
								_Utils_Tuple2(0, 0),
								_List_fromArray(
									[
										A2(
										$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
										_Utils_Tuple2(10, 0),
										_Utils_Tuple2(20, -10))
									])))))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(-4, -30),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$scale,
					0.75,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
						$elm$core$Basics$degrees(120),
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$filled,
							color,
							A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$curve,
								_Utils_Tuple2(0, 0),
								_List_fromArray(
									[
										A2(
										$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
										_Utils_Tuple2(10, 0),
										_Utils_Tuple2(20, -10))
									])))))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(0, 1.5),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
					$elm$core$Basics$degrees(-60),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$filled,
						color,
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$curve,
							_Utils_Tuple2(0, 0),
							_List_fromArray(
								[
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(10, 0),
									_Utils_Tuple2(20, -10))
								]))))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(3, -40),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
					$elm$core$Basics$degrees(120),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$filled,
						color,
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$curve,
							_Utils_Tuple2(0, 0),
							_List_fromArray(
								[
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(10, 0),
									_Utils_Tuple2(20, -10))
								]))))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(6, 1.5),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$scale,
					0.75,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
						$elm$core$Basics$degrees(-60),
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$filled,
							color,
							A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$curve,
								_Utils_Tuple2(0, 0),
								_List_fromArray(
									[
										A2(
										$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
										_Utils_Tuple2(10, 0),
										_Utils_Tuple2(20, -10))
									])))))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(8, -30),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$scale,
					0.75,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
						$elm$core$Basics$degrees(120),
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$filled,
							color,
							A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$curve,
								_Utils_Tuple2(0, 0),
								_List_fromArray(
									[
										A2(
										$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
										_Utils_Tuple2(10, 0),
										_Utils_Tuple2(20, -10))
									])))))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(12, 1.5),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
					$elm$core$Basics$degrees(-60),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$filled,
						color,
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$curve,
							_Utils_Tuple2(0, 0),
							_List_fromArray(
								[
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(10, 0),
									_Utils_Tuple2(20, -10))
								]))))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(15, -40),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
					$elm$core$Basics$degrees(120),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$filled,
						color,
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$curve,
							_Utils_Tuple2(0, 0),
							_List_fromArray(
								[
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(10, 0),
									_Utils_Tuple2(20, -10))
								])))))
			]));
};
var $author$project$Main$jellyfish = function (color) {
	return $MacCASOutreach$graphicsvg$GraphicSVG$group(
		_List_fromArray(
			[
				$author$project$Main$tentacles(color),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
				$elm$core$Basics$degrees(90),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					color,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$wedge, 20, 0.5))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(-10, 8),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					$MacCASOutreach$graphicsvg$GraphicSVG$black,
					$MacCASOutreach$graphicsvg$GraphicSVG$circle(2))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(10, 8),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					$MacCASOutreach$graphicsvg$GraphicSVG$black,
					$MacCASOutreach$graphicsvg$GraphicSVG$circle(2))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(-9, 8),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					$MacCASOutreach$graphicsvg$GraphicSVG$white,
					$MacCASOutreach$graphicsvg$GraphicSVG$circle(0.5))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(11, 8),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					$MacCASOutreach$graphicsvg$GraphicSVG$white,
					$MacCASOutreach$graphicsvg$GraphicSVG$circle(0.5))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(0, 5),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
					$elm$core$Basics$degrees(-90),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$filled,
						$MacCASOutreach$graphicsvg$GraphicSVG$darkRed,
						A2($MacCASOutreach$graphicsvg$GraphicSVG$wedge, 3, 0.5))))
			]));
};
var $MacCASOutreach$graphicsvg$GraphicSVG$lightBlue = A4($MacCASOutreach$graphicsvg$GraphicSVG$rgba, 114, 159, 207, 1);
var $MacCASOutreach$graphicsvg$GraphicSVG$lightRed = A4($MacCASOutreach$graphicsvg$GraphicSVG$rgba, 239, 41, 41, 1);
var $author$project$Main$pearls = $MacCASOutreach$graphicsvg$GraphicSVG$group(
	_List_fromArray(
		[
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$filled,
			$MacCASOutreach$graphicsvg$GraphicSVG$white,
			$MacCASOutreach$graphicsvg$GraphicSVG$circle(1)),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(4, -7),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$white,
				$MacCASOutreach$graphicsvg$GraphicSVG$circle(1))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(8, -13),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$white,
				$MacCASOutreach$graphicsvg$GraphicSVG$circle(0.5))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-9, 0),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$white,
				$MacCASOutreach$graphicsvg$GraphicSVG$circle(0.5))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-11.5, -7),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$white,
				$MacCASOutreach$graphicsvg$GraphicSVG$circle(1))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-15, -13),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$white,
				$MacCASOutreach$graphicsvg$GraphicSVG$circle(1))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(5, 6),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$white,
				$MacCASOutreach$graphicsvg$GraphicSVG$circle(1))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(12, 8),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$white,
				$MacCASOutreach$graphicsvg$GraphicSVG$circle(1))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(18, 10),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$white,
				$MacCASOutreach$graphicsvg$GraphicSVG$circle(1))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-5, 12),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$white,
				$MacCASOutreach$graphicsvg$GraphicSVG$circle(0.5))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-5, 18),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$white,
				$MacCASOutreach$graphicsvg$GraphicSVG$circle(1))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-5, 23),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$white,
				$MacCASOutreach$graphicsvg$GraphicSVG$circle(1))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-14, 5),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$white,
				$MacCASOutreach$graphicsvg$GraphicSVG$circle(0.5))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-20.5, 6.5),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$white,
				$MacCASOutreach$graphicsvg$GraphicSVG$circle(1))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-26, 8),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$white,
				$MacCASOutreach$graphicsvg$GraphicSVG$circle(1)))
		]));
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$RadialGradient = function (a) {
	return {$: 'RadialGradient', a: a};
};
var $MacCASOutreach$graphicsvg$GraphicSVG$radialGradient = function (stops) {
	return $MacCASOutreach$graphicsvg$GraphicSVG$Secret$Gradient(
		$MacCASOutreach$graphicsvg$GraphicSVG$Secret$RadialGradient(stops));
};
var $author$project$Main$stopsStarfish = function (t) {
	return A2(
		$elm$core$List$map,
		function (idx) {
			return A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$stop,
				A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$hsl,
					t + ($elm$core$Basics$degrees(36) * idx),
					1,
					0.5),
				5 * idx);
		},
		A2($elm$core$List$range, 0, 10));
};
var $author$project$Main$rainbow = function (model) {
	return $MacCASOutreach$graphicsvg$GraphicSVG$group(
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(-5, -0.5),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$rotateGradient,
						$elm$core$Basics$degrees(90),
						$MacCASOutreach$graphicsvg$GraphicSVG$radialGradient(
							$author$project$Main$stopsStarfish(model.time * 0.4))),
					$MacCASOutreach$graphicsvg$GraphicSVG$circle(50)))
			]));
};
var $MacCASOutreach$graphicsvg$GraphicSVG$hsla = F4(
	function (h, s, l, a) {
		var _v0 = A3($MacCASOutreach$graphicsvg$GraphicSVG$convert, h, s, l);
		var r = _v0.a;
		var g = _v0.b;
		var b = _v0.c;
		return A4($MacCASOutreach$graphicsvg$GraphicSVG$rgba, r, g, b, a);
	});
var $author$project$Main$starfish = $MacCASOutreach$graphicsvg$GraphicSVG$group(
	_List_fromArray(
		[
			A3(
			$MacCASOutreach$graphicsvg$GraphicSVG$addOutline,
			$MacCASOutreach$graphicsvg$GraphicSVG$solid(6),
			A4(
				$MacCASOutreach$graphicsvg$GraphicSVG$hsla,
				$elm$core$Basics$degrees(14),
				0.95,
				0.30,
				1),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				A4(
					$MacCASOutreach$graphicsvg$GraphicSVG$hsla,
					$elm$core$Basics$degrees(13),
					0.84,
					0.50,
					1),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$curve,
					_Utils_Tuple2(5.0659, 13.340),
					_List_fromArray(
						[
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(15.197, 14.522),
							_Utils_Tuple2(25.329, 15.704)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(29.223, 14.591),
							_Utils_Tuple2(27.356, 10.638)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(18.575, 4.7282),
							_Utils_Tuple2(9.7941, -1.182)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(8.9053, -2.679),
							_Utils_Tuple2(9.4564, -4.897)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(13.678, -13.50),
							_Utils_Tuple2(17.899, -22.12)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(18.846, -26.61),
							_Utils_Tuple2(12.833, -25.49)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(6.0791, -18.91),
							_Utils_Tuple2(-0.675, -12.32)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-4.390, -9.104),
							_Utils_Tuple2(-8.105, -13.00)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-13.50, -19.25),
							_Utils_Tuple2(-18.91, -25.49)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-24.31, -26.55),
							_Utils_Tuple2(-23.64, -21.44)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-20.77, -13.17),
							_Utils_Tuple2(-17.89, -4.897)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-17.07, -3.039),
							_Utils_Tuple2(-19.92, -1.182)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-28.36, 3.2084),
							_Utils_Tuple2(-36.81, 7.5989)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-39.71, 11.780),
							_Utils_Tuple2(-34.78, 13.002)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-24.99, 12.664),
							_Utils_Tuple2(-15.19, 12.327)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-12.48, 11.549),
							_Utils_Tuple2(-12.49, 14.691)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-9.794, 24.654),
							_Utils_Tuple2(-7.092, 34.617)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(-4.390, 37.786),
							_Utils_Tuple2(-1.688, 34.955)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(0.1688, 24.992),
							_Utils_Tuple2(2.0263, 15.029)),
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
							_Utils_Tuple2(3.1661, 13.184),
							_Utils_Tuple2(5.0659, 13.340))
						])))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$scale,
			0.8,
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(-5, 5),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					A4(
						$MacCASOutreach$graphicsvg$GraphicSVG$hsla,
						$elm$core$Basics$degrees(12.5),
						0.50,
						0.47,
						1),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$curve,
						_Utils_Tuple2(0, 19.757),
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-1.519, 11.482),
								_Utils_Tuple2(-3.039, 3.2084)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-14.86, 3.7150),
								_Utils_Tuple2(-26.68, 4.2216)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-15.53, 0.8443),
								_Utils_Tuple2(-4.390, -2.532)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-9.456, -14.01),
								_Utils_Tuple2(-14.52, -25.49)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-6.585, -15.19),
								_Utils_Tuple2(1.3509, -4.897)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(9.2875, -14.69),
								_Utils_Tuple2(17.224, -24.48)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(12.158, -14.01),
								_Utils_Tuple2(7.0923, -3.546)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(17.562, 1.6886),
								_Utils_Tuple2(28.031, 6.9234)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(16.886, 4.8970),
								_Utils_Tuple2(5.7414, 2.8707)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(2.7018, 11.313),
								_Utils_Tuple2(0, 19.757))
							])))))
		]));
var $author$project$Main$movingStarfish = function (model) {
	return $MacCASOutreach$graphicsvg$GraphicSVG$group(
		_List_fromArray(
			[
				$author$project$Main$starfish,
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$clip,
				$author$project$Main$pearls,
				$author$project$Main$rainbow(model))
			]));
};
var $author$project$Main$bubbleClr = A4($MacCASOutreach$graphicsvg$GraphicSVG$rgba, 255, 255, 255, 0.85);
var $MacCASOutreach$graphicsvg$GraphicSVG$ghost = function (stencil) {
	return A3(
		$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Inked,
		$elm$core$Maybe$Just($MacCASOutreach$graphicsvg$GraphicSVG$blank),
		$elm$core$Maybe$Nothing,
		stencil);
};
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$FixedWidth = {$: 'FixedWidth'};
var $MacCASOutreach$graphicsvg$GraphicSVG$fixedwidth = function (stencil) {
	if (stencil.$ === 'Text') {
		var _v1 = stencil.a;
		var si = _v1.a;
		var bo = _v1.b;
		var i = _v1.c;
		var u = _v1.d;
		var s = _v1.e;
		var sel = _v1.f;
		var f = _v1.g;
		var c = _v1.h;
		var str = stencil.b;
		return A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Text,
			A8($MacCASOutreach$graphicsvg$GraphicSVG$Secret$Face, si, bo, i, u, s, sel, $MacCASOutreach$graphicsvg$GraphicSVG$Secret$FixedWidth, c),
			str);
	} else {
		var a = stencil;
		return a;
	}
};
var $author$project$Main$textHeight = 4;
var $author$project$Main$mkScriptFor = F4(
	function (textClr, actor, theScript, offset) {
		var mkTxt = F2(
			function (idx, txt) {
				return A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(offset, (-$author$project$Main$textHeight) * idx),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$filled,
						textClr,
						$MacCASOutreach$graphicsvg$GraphicSVG$fixedwidth(
							A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$size,
								2,
								$MacCASOutreach$graphicsvg$GraphicSVG$text(txt)))));
			});
		var getNext = F3(
			function (thisActor, _v0, moreScript) {
				getNext:
				while (true) {
					var lastActor = _v0.a;
					var idx = _v0.b;
					if (moreScript.b) {
						var _v2 = moreScript.a;
						var newActor = _v2.a;
						var newTxt = _v2.b;
						var rest = moreScript.b;
						var newIdx = _Utils_eq(newActor, lastActor) ? (idx + 1) : (idx + 1.75);
						if (_Utils_eq(newActor, thisActor)) {
							return A2(
								$elm$core$List$cons,
								_Utils_Tuple2(
									A2(mkTxt, newIdx, newTxt),
									newIdx),
								A3(
									getNext,
									thisActor,
									_Utils_Tuple2(newActor, newIdx),
									rest));
						} else {
							var $temp$thisActor = thisActor,
								$temp$_v0 = _Utils_Tuple2(newActor, newIdx),
								$temp$moreScript = rest;
							thisActor = $temp$thisActor;
							_v0 = $temp$_v0;
							moreScript = $temp$moreScript;
							continue getNext;
						}
					} else {
						return _List_Nil;
					}
				}
			});
		var shapesAndVisibility = function () {
			if (theScript.b) {
				var _v4 = theScript.a;
				var newActor = _v4.a;
				var newTxt = _v4.b;
				var rest = theScript.b;
				return A3(
					getNext,
					actor,
					_Utils_Tuple2(newActor, 0.5),
					theScript);
			} else {
				return _List_Nil;
			}
		}();
		return _Utils_Tuple2(
			$MacCASOutreach$graphicsvg$GraphicSVG$group(
				A2($elm$core$List$map, $elm$core$Tuple$first, shapesAndVisibility)),
			A2($elm$core$List$map, $elm$core$Tuple$second, shapesAndVisibility));
	});
var $author$project$Main$scriptSpeed = $author$project$Main$textHeight;
var $author$project$Main$textSpeed = 1.85;
var $author$project$Main$multiBubbleLeft = F5(
	function (textClr, script, width, actor, t) {
		var bubble = A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$curve,
			_Utils_Tuple2((-width) * 0.5, -8),
			_List_fromArray(
				[
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
					_Utils_Tuple2(((-width) * 0.5) + 5, -8),
					_Utils_Tuple2(((-width) * 0.5) + 7, -4)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
					_Utils_Tuple2((width * 0.5) + 2, -8),
					_Utils_Tuple2(width * 0.5, 1)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
					_Utils_Tuple2(width * 0.5, 8),
					_Utils_Tuple2(0, 7)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
					_Utils_Tuple2((-width) * 0.5, 8),
					_Utils_Tuple2((-width) * 0.5, 2)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
					_Utils_Tuple2((-width) * 0.5, -2),
					_Utils_Tuple2(((-width) * 0.5) + 3, -3)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
					_Utils_Tuple2(((-width) * 0.5) + 5, -6),
					_Utils_Tuple2(((-width) * 0.5) + 0, -8))
				]));
		var _v0 = A4($author$project$Main$mkScriptFor, textClr, actor, script, width / 15);
		var contents = _v0.a;
		var visibility = _v0.b;
		var isVisible = A2(
			$elm$core$List$any,
			function (start) {
				return (_Utils_cmp(($author$project$Main$textSpeed * 0.75) * t, (($author$project$Main$scriptSpeed * 0.75) * start) - 2) > 0) && (_Utils_cmp($author$project$Main$textSpeed * t, ($author$project$Main$scriptSpeed * start) + 4) < 0);
			},
			visibility);
		return A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$scale,
			2,
			$MacCASOutreach$graphicsvg$GraphicSVG$group(
				isVisible ? _List_fromArray(
					[
						A2($MacCASOutreach$graphicsvg$GraphicSVG$filled, $author$project$Main$bubbleClr, bubble),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$clip,
						$MacCASOutreach$graphicsvg$GraphicSVG$ghost(bubble),
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$move,
							_Utils_Tuple2(1.5 - (0.5 * width), $author$project$Main$textSpeed * t),
							contents)),
						A3(
						$MacCASOutreach$graphicsvg$GraphicSVG$outlined,
						$MacCASOutreach$graphicsvg$GraphicSVG$solid(0.5),
						textClr,
						bubble)
					]) : _List_Nil));
	});
var $author$project$Main$multiBubbleRight = F5(
	function (textClr, script, width, actor, t) {
		var bubble = A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$curve,
			_Utils_Tuple2((-width) * 0.5, -8),
			_List_fromArray(
				[
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
					_Utils_Tuple2(((-width) * 0.5) + 5, -8),
					_Utils_Tuple2(((-width) * 0.5) + 7, -4)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
					_Utils_Tuple2((width * 0.5) + 2, -8),
					_Utils_Tuple2(width * 0.5, 1)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
					_Utils_Tuple2(width * 0.5, 8),
					_Utils_Tuple2(0, 7)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
					_Utils_Tuple2((-width) * 0.5, 8),
					_Utils_Tuple2((-width) * 0.5, 2)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
					_Utils_Tuple2((-width) * 0.5, -2),
					_Utils_Tuple2(((-width) * 0.5) + 3, -3)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
					_Utils_Tuple2(((-width) * 0.5) + 5, -6),
					_Utils_Tuple2(((-width) * 0.5) + 0, -8))
				]));
		var _v0 = A4($author$project$Main$mkScriptFor, textClr, actor, script, width / 15);
		var contents = _v0.a;
		var visibility = _v0.b;
		var isVisible = A2(
			$elm$core$List$any,
			function (start) {
				return (_Utils_cmp(($author$project$Main$textSpeed * 0.75) * t, (($author$project$Main$scriptSpeed * 0.75) * start) - 2) > 0) && (_Utils_cmp($author$project$Main$textSpeed * t, ($author$project$Main$scriptSpeed * start) + 4) < 0);
			},
			visibility);
		return A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$scale,
			2,
			$MacCASOutreach$graphicsvg$GraphicSVG$group(
				isVisible ? _List_fromArray(
					[
						$MacCASOutreach$graphicsvg$GraphicSVG$mirrorX(
						A2($MacCASOutreach$graphicsvg$GraphicSVG$filled, $author$project$Main$bubbleClr, bubble)),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$clip,
						$MacCASOutreach$graphicsvg$GraphicSVG$mirrorX(
							$MacCASOutreach$graphicsvg$GraphicSVG$ghost(bubble)),
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$move,
							_Utils_Tuple2(1 - (0.5 * width), $author$project$Main$textSpeed * t),
							contents)),
						$MacCASOutreach$graphicsvg$GraphicSVG$mirrorX(
						A3(
							$MacCASOutreach$graphicsvg$GraphicSVG$outlined,
							$MacCASOutreach$graphicsvg$GraphicSVG$solid(0.25),
							textClr,
							bubble))
					]) : _List_Nil));
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$notifyTap = F2(
	function (msg, shape) {
		return A2($MacCASOutreach$graphicsvg$GraphicSVG$Secret$Tap, msg, shape);
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$scaleY = F2(
	function (s, shape) {
		return A3($MacCASOutreach$graphicsvg$GraphicSVG$Secret$Scale, 1, s, shape);
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$square = function (r) {
	return A2($MacCASOutreach$graphicsvg$GraphicSVG$Secret$Rect, r, r);
};
var $author$project$Main$parrotFish = function (model) {
	return $MacCASOutreach$graphicsvg$GraphicSVG$group(
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(0, 13),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
					$elm$core$Basics$degrees(-5),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$filled,
						$MacCASOutreach$graphicsvg$GraphicSVG$gradient(
							_List_fromArray(
								[
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$stop,
									A3(
										$MacCASOutreach$graphicsvg$GraphicSVG$hsl,
										$elm$core$Basics$degrees(256),
										0.298,
										0.57),
									0),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$stop,
									A3(
										$MacCASOutreach$graphicsvg$GraphicSVG$hsl,
										$elm$core$Basics$degrees(31),
										0.975,
										0.57),
									50)
								])),
						A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 40, 17)))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(-5, -13),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
					$elm$core$Basics$degrees(8),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$filled,
						$MacCASOutreach$graphicsvg$GraphicSVG$gradient(
							_List_fromArray(
								[
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$stop,
									A3(
										$MacCASOutreach$graphicsvg$GraphicSVG$hsl,
										$elm$core$Basics$degrees(256),
										0.298,
										0.57),
									0),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$stop,
									A3(
										$MacCASOutreach$graphicsvg$GraphicSVG$hsl,
										$elm$core$Basics$degrees(31),
										0.975,
										0.57),
									50)
								])),
						A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 30, 12)))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$subtract,
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(27.5, -3),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
						$elm$core$Basics$degrees(-90),
						$MacCASOutreach$graphicsvg$GraphicSVG$ghost(
							A2($MacCASOutreach$graphicsvg$GraphicSVG$wedge, 3.5, 0.5)))),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$subtract,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(28, -3.5),
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
							$elm$core$Basics$degrees(90),
							$MacCASOutreach$graphicsvg$GraphicSVG$ghost(
								A2($MacCASOutreach$graphicsvg$GraphicSVG$wedge, 4, 0.5)))),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$clip,
						$MacCASOutreach$graphicsvg$GraphicSVG$group(
							_List_fromArray(
								[
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
									$elm$core$Basics$degrees(-90),
									$MacCASOutreach$graphicsvg$GraphicSVG$ghost(
										A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 34, 60))),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
									$elm$core$Basics$degrees(2) * $elm$core$Basics$sin(2 * model.time),
									A2(
										$MacCASOutreach$graphicsvg$GraphicSVG$move,
										_Utils_Tuple2(-32, 3),
										A2(
											$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
											$elm$core$Basics$degrees(-20),
											A2(
												$MacCASOutreach$graphicsvg$GraphicSVG$filled,
												$MacCASOutreach$graphicsvg$GraphicSVG$black,
												A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 20, 12))))),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
									$elm$core$Basics$degrees(2) * $elm$core$Basics$sin(2 * model.time),
									A2(
										$MacCASOutreach$graphicsvg$GraphicSVG$move,
										_Utils_Tuple2(-32, -3),
										A2(
											$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
											$elm$core$Basics$degrees(20),
											A2(
												$MacCASOutreach$graphicsvg$GraphicSVG$filled,
												$MacCASOutreach$graphicsvg$GraphicSVG$black,
												A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 20, 12)))))
								])),
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
							$elm$core$Basics$degrees(-90),
							A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$filled,
								$MacCASOutreach$graphicsvg$GraphicSVG$gradient(
									_List_fromArray(
										[
											A2(
											$MacCASOutreach$graphicsvg$GraphicSVG$stop,
											A3(
												$MacCASOutreach$graphicsvg$GraphicSVG$hsl,
												$elm$core$Basics$degrees(160),
												0.619,
												0.53),
											0),
											A2(
											$MacCASOutreach$graphicsvg$GraphicSVG$stop,
											A3(
												$MacCASOutreach$graphicsvg$GraphicSVG$hsl,
												$elm$core$Basics$degrees(31),
												0.975,
												0.57),
											25),
											A2(
											$MacCASOutreach$graphicsvg$GraphicSVG$stop,
											A3(
												$MacCASOutreach$graphicsvg$GraphicSVG$hsl,
												$elm$core$Basics$degrees(52),
												0.975,
												0.57),
											30)
										])),
								$MacCASOutreach$graphicsvg$GraphicSVG$square(100)))))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(23, -3.5),
				$MacCASOutreach$graphicsvg$GraphicSVG$group(
					_List_fromArray(
						[
							A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
							$elm$core$Basics$degrees(
								$elm$core$Basics$abs(
									10 * $elm$core$Basics$sin(model.time))),
							A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$move,
								_Utils_Tuple2(5, 0),
								A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$scaleY,
									1.3,
									A2(
										$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
										$elm$core$Basics$degrees(90),
										A2(
											$MacCASOutreach$graphicsvg$GraphicSVG$filled,
											A3(
												$MacCASOutreach$graphicsvg$GraphicSVG$hsl,
												$elm$core$Basics$degrees(256),
												0.5,
												0.6),
											A2($MacCASOutreach$graphicsvg$GraphicSVG$wedge, 4, 0.5)))))),
							$MacCASOutreach$graphicsvg$GraphicSVG$mirrorY(
							A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
								$elm$core$Basics$degrees(
									$elm$core$Basics$abs(
										10 * $elm$core$Basics$sin(model.time))),
								A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$move,
									_Utils_Tuple2(4.5, -0.5),
									A2(
										$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
										$elm$core$Basics$degrees(90),
										A2(
											$MacCASOutreach$graphicsvg$GraphicSVG$filled,
											A3(
												$MacCASOutreach$graphicsvg$GraphicSVG$hsl,
												$elm$core$Basics$degrees(256),
												0.5,
												0.6),
											A2($MacCASOutreach$graphicsvg$GraphicSVG$wedge, 3.5, 0.5))))))
						]))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(18, 5),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					$MacCASOutreach$graphicsvg$GraphicSVG$white,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 8, 10))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(19, 5),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					$MacCASOutreach$graphicsvg$GraphicSVG$black,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 5, 6))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(18, 6),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					$MacCASOutreach$graphicsvg$GraphicSVG$white,
					$MacCASOutreach$graphicsvg$GraphicSVG$circle(1)))
			]));
};
var $author$project$Main$parrotFishS = function (model) {
	return $MacCASOutreach$graphicsvg$GraphicSVG$group(
		_List_fromArray(
			[
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(0, 13),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
					$elm$core$Basics$degrees(-5),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$filled,
						A2($author$project$Main$sandGradient, 10, 70),
						A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 40, 17)))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(-5, -13),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
					$elm$core$Basics$degrees(8),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$filled,
						A2($author$project$Main$sandGradient, -15, 5),
						A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 30, 12)))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
				$elm$core$Basics$degrees(2) * $elm$core$Basics$sin(2 * model.time),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-32, 3),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
						$elm$core$Basics$degrees(-20),
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$filled,
							A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$rotateGradient,
								$elm$core$Basics$degrees(-30),
								A2($author$project$Main$sandGradient, 0, 20)),
							A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 20, 12))))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
				$elm$core$Basics$degrees(2) * $elm$core$Basics$sin(2 * model.time),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-32, -3),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
						$elm$core$Basics$degrees(20),
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$filled,
							A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$rotateGradient,
								$elm$core$Basics$degrees(-90),
								A2($author$project$Main$sandGradient, 0, 20)),
							A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 20, 12))))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
				$elm$core$Basics$degrees(-90),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					A2($author$project$Main$sandGradient, 0, 45),
					A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 34, 60))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(15, -2),
				A2($MacCASOutreach$graphicsvg$GraphicSVG$scale, 0.4, $author$project$Main$mouthShellS)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(5, 17.5),
				$author$project$Main$eyeShellS)
			]));
};
var $author$project$Main$partyHat = F6(
	function (colour1, colour2, colour3, colour4, colour5, colour6) {
		return $MacCASOutreach$graphicsvg$GraphicSVG$group(
			_List_fromArray(
				[
					A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$addOutline,
					$MacCASOutreach$graphicsvg$GraphicSVG$solid(1),
					$MacCASOutreach$graphicsvg$GraphicSVG$black,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$filled,
						colour1,
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$curve,
							_Utils_Tuple2(-51.25, 33.124),
							_List_fromArray(
								[
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-38.66, 4.3466),
									_Utils_Tuple2(-26.07, -24.43)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-27.42, -26.07),
									_Utils_Tuple2(-28.77, -27.72)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-53.05, -25.92),
									_Utils_Tuple2(-77.33, -24.13)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-77.63, -22.63),
									_Utils_Tuple2(-77.93, -21.13)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-67.29, 3.5971),
									_Utils_Tuple2(-56.65, 28.327)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-55.30, 31.475),
									_Utils_Tuple2(-53.95, 34.622)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-52.75, 33.873),
									_Utils_Tuple2(-51.25, 33.124))
								])))),
					A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$addOutline,
					$MacCASOutreach$graphicsvg$GraphicSVG$solid(1),
					$MacCASOutreach$graphicsvg$GraphicSVG$black,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$filled,
						colour2,
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$curve,
							_Utils_Tuple2(-52.45, 34.922),
							_List_fromArray(
								[
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-50.15, 29.875),
									_Utils_Tuple2(-54.85, 28.627)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-58.75, 29.875),
									_Utils_Tuple2(-56.65, 34.922)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-61.50, 32.272),
									_Utils_Tuple2(-62.95, 36.421)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-63.60, 40.919),
									_Utils_Tuple2(-55.45, 40.618)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-57.80, 42.416),
									_Utils_Tuple2(-56.95, 45.414)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-52.05, 50.065),
									_Utils_Tuple2(-50.36, 42.117)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-48.66, 45.116),
									_Utils_Tuple2(-44.96, 42.716)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-43.86, 40.518),
									_Utils_Tuple2(-46.16, 39.119)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-47.81, 38.070),
									_Utils_Tuple2(-49.46, 37.620)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-46.56, 38.171),
									_Utils_Tuple2(-46.46, 34.922)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-47.56, 32.473),
									_Utils_Tuple2(-50.06, 33.423)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-51.40, 33.623),
									_Utils_Tuple2(-52.45, 34.922))
								])))),
					A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$outlined,
					$MacCASOutreach$graphicsvg$GraphicSVG$solid(1),
					$MacCASOutreach$graphicsvg$GraphicSVG$black,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$curve,
						_Utils_Tuple2(-56.35, 41.217),
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-61.25, 41.965),
								_Utils_Tuple2(-61.75, 47.512)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-61.85, 50.462),
								_Utils_Tuple2(-58.75, 49.611)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-57.25, 48.711),
								_Utils_Tuple2(-58.15, 47.812)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-58.90, 47.362),
								_Utils_Tuple2(-59.65, 47.512))
							]))),
					A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$addOutline,
					$MacCASOutreach$graphicsvg$GraphicSVG$solid(1),
					$MacCASOutreach$graphicsvg$GraphicSVG$black,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$filled,
						colour6,
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$curve,
							_Utils_Tuple2(-67.14, -22.63),
							_List_fromArray(
								[
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-64.99, -19.03),
									_Utils_Tuple2(-66.24, -15.43)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-66.94, -10.24),
									_Utils_Tuple2(-72.24, -9.442)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-74.34, -14.08),
									_Utils_Tuple2(-76.44, -18.73)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-74.94, -21.58),
									_Utils_Tuple2(-73.44, -24.43)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-70.29, -23.68),
									_Utils_Tuple2(-67.14, -22.63))
								])))),
					A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$addOutline,
					$MacCASOutreach$graphicsvg$GraphicSVG$solid(1),
					$MacCASOutreach$graphicsvg$GraphicSVG$black,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$filled,
						colour4,
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$curve,
							_Utils_Tuple2(-55.75, -21.13),
							_List_fromArray(
								[
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-56.70, -15.38),
									_Utils_Tuple2(-51.85, -13.63)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-47.86, -12.38),
									_Utils_Tuple2(-45.26, -15.73)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-43.86, -18.43),
									_Utils_Tuple2(-45.26, -21.13)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-46.46, -23.83),
									_Utils_Tuple2(-47.66, -26.52)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-51.55, -25.77),
									_Utils_Tuple2(-55.45, -25.03)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-55.75, -23.08),
									_Utils_Tuple2(-55.75, -21.13))
								])))),
					A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$addOutline,
					$MacCASOutreach$graphicsvg$GraphicSVG$solid(1),
					$MacCASOutreach$graphicsvg$GraphicSVG$black,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$filled,
						colour2,
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$curve,
							_Utils_Tuple2(-28.47, -26.82),
							_List_fromArray(
								[
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-23.48, -20.18),
									_Utils_Tuple2(-19.48, -24.13)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-16.13, -29.02),
									_Utils_Tuple2(-20.98, -30.72)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-16.63, -30.97),
									_Utils_Tuple2(-16.48, -35.22)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-15.38, -39.47),
									_Utils_Tuple2(-23.08, -37.32)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-25.18, -35.82),
									_Utils_Tuple2(-27.27, -34.32)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-24.52, -37.02),
									_Utils_Tuple2(-26.97, -39.71)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-32.52, -41.52),
									_Utils_Tuple2(-35.07, -36.72)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-34.42, -39.71),
									_Utils_Tuple2(-37.17, -41.51)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-42.91, -42.01),
									_Utils_Tuple2(-42.26, -36.12)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-43.31, -41.81),
									_Utils_Tuple2(-48.56, -41.51)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-52.81, -41.57),
									_Utils_Tuple2(-50.66, -34.02)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-52.30, -36.32),
									_Utils_Tuple2(-53.95, -37.02)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-55.95, -35.92),
									_Utils_Tuple2(-55.15, -33.42)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-55.15, -37.07),
									_Utils_Tuple2(-58.75, -38.51)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-63.40, -39.07),
									_Utils_Tuple2(-64.44, -34.02)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-65.94, -38.32),
									_Utils_Tuple2(-69.84, -39.41)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-75.19, -39.02),
									_Utils_Tuple2(-76.14, -34.02)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-78.13, -36.97),
									_Utils_Tuple2(-81.53, -36.12)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-85.13, -34.72),
									_Utils_Tuple2(-83.33, -29.52)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-82.63, -27.87),
									_Utils_Tuple2(-80.93, -26.22)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-83.18, -27.07),
									_Utils_Tuple2(-85.43, -25.33)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-87.28, -22.78),
									_Utils_Tuple2(-84.53, -20.23)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-80.98, -19.03),
									_Utils_Tuple2(-79.43, -19.63)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-77.08, -20.63),
									_Utils_Tuple2(-76.14, -22.63)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-77.64, -20.23),
									_Utils_Tuple2(-76.14, -17.83)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-74.64, -16.58),
									_Utils_Tuple2(-73.14, -18.13)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-70.24, -20.33),
									_Utils_Tuple2(-71.34, -23.53)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-70.59, -20.13),
									_Utils_Tuple2(-66.84, -19.93)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-63.79, -19.23),
									_Utils_Tuple2(-62.35, -22.33)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-61.50, -24.58),
									_Utils_Tuple2(-61.45, -26.82)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-61.30, -22.88),
									_Utils_Tuple2(-58.15, -21.73)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-55.45, -20.53),
									_Utils_Tuple2(-52.75, -21.73)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-50.20, -24.13),
									_Utils_Tuple2(-51.25, -26.52)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-49.41, -20.98),
									_Utils_Tuple2(-44.36, -20.83)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-40.06, -21.38),
									_Utils_Tuple2(-37.17, -27.12)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-37.17, -21.88),
									_Utils_Tuple2(-33.57, -21.43)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-28.82, -21.43),
									_Utils_Tuple2(-28.47, -26.82))
								])))),
					A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$addOutline,
					$MacCASOutreach$graphicsvg$GraphicSVG$solid(1),
					$MacCASOutreach$graphicsvg$GraphicSVG$black,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$filled,
						colour5,
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$curve,
							_Utils_Tuple2(-65.94, 6.4449),
							_List_fromArray(
								[
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-65.60, 3.3964),
									_Utils_Tuple2(-60.85, 2.5480)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-55.15, 2.6463),
									_Utils_Tuple2(-54.25, 6.7447)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-53.25, 10.042),
									_Utils_Tuple2(-55.45, 13.339)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-58.75, 15.439),
									_Utils_Tuple2(-61.45, 13.339)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-62.50, 12.589),
									_Utils_Tuple2(-63.55, 13.039)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-64.89, 9.8922),
									_Utils_Tuple2(-66.24, 6.7447))
								])))),
					A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$addOutline,
					$MacCASOutreach$graphicsvg$GraphicSVG$solid(1),
					$MacCASOutreach$graphicsvg$GraphicSVG$black,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$filled,
						colour3,
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$curve,
							_Utils_Tuple2(-48.26, 25.929),
							_List_fromArray(
								[
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-54.96, 21.933),
									_Utils_Tuple2(-51.85, 16.936)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-48.91, 12.638),
									_Utils_Tuple2(-43.16, 13.339)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-45.56, 19.634),
									_Utils_Tuple2(-48.26, 25.929))
								])))),
					A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$addOutline,
					$MacCASOutreach$graphicsvg$GraphicSVG$solid(1),
					$MacCASOutreach$graphicsvg$GraphicSVG$black,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$filled,
						colour5,
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$curve,
							_Utils_Tuple2(-32.97, -8.543),
							_List_fromArray(
								[
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-38.02, -6.892),
									_Utils_Tuple2(-39.86, -11.84)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-40.47, -15.13),
									_Utils_Tuple2(-36.87, -17.23)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-34.02, -18.73),
									_Utils_Tuple2(-31.17, -17.23)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-30.07, -16.88),
									_Utils_Tuple2(-29.97, -15.13)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-31.47, -11.84),
									_Utils_Tuple2(-32.97, -8.543))
								])))),
					A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$addOutline,
					$MacCASOutreach$graphicsvg$GraphicSVG$solid(1),
					$MacCASOutreach$graphicsvg$GraphicSVG$black,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$filled,
						colour4,
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$curve,
							_Utils_Tuple2(-48.56, 6.1451),
							_List_fromArray(
								[
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-52.76, 3.7976),
									_Utils_Tuple2(-51.55, -0.149)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-50.16, -3.648),
									_Utils_Tuple2(-46.76, -3.747)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-42.36, -3.548),
									_Utils_Tuple2(-41.36, 1.0491)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-41.31, 5.0473),
									_Utils_Tuple2(-44.66, 5.8454)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-46.91, 6.9451),
									_Utils_Tuple2(-48.56, 6.1451))
								])))),
					A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$addOutline,
					$MacCASOutreach$graphicsvg$GraphicSVG$solid(1),
					$MacCASOutreach$graphicsvg$GraphicSVG$black,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$filled,
						colour3,
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$curve,
							_Utils_Tuple2(-58.45, -2.847),
							_List_fromArray(
								[
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-56.25, -3.496),
									_Utils_Tuple2(-55.45, -6.744)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-55.45, -10.14),
									_Utils_Tuple2(-59.65, -11.54)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-63.15, -11.64),
									_Utils_Tuple2(-63.85, -9.142)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-64.95, -6.594),
									_Utils_Tuple2(-62.65, -4.046)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
									_Utils_Tuple2(-60.55, -2.447),
									_Utils_Tuple2(-58.45, -2.847))
								]))))
				]));
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$bold = function (stencil) {
	if (stencil.$ === 'Text') {
		var _v1 = stencil.a;
		var si = _v1.a;
		var bo = _v1.b;
		var i = _v1.c;
		var u = _v1.d;
		var s = _v1.e;
		var sel = _v1.f;
		var f = _v1.g;
		var c = _v1.h;
		var str = stencil.b;
		return A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Text,
			A8($MacCASOutreach$graphicsvg$GraphicSVG$Secret$Face, si, true, i, u, s, sel, f, c),
			str);
	} else {
		var a = stencil;
		return a;
	}
};
var $MacCASOutreach$graphicsvg$GraphicSVG$lightOrange = A4($MacCASOutreach$graphicsvg$GraphicSVG$rgba, 252, 175, 62, 1);
var $author$project$Main$spike = A2(
	$MacCASOutreach$graphicsvg$GraphicSVG$subtract,
	A2(
		$MacCASOutreach$graphicsvg$GraphicSVG$move,
		_Utils_Tuple2(0, -2),
		A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$filled,
			$MacCASOutreach$graphicsvg$GraphicSVG$white,
			A2($MacCASOutreach$graphicsvg$GraphicSVG$rect, 7, 2.5))),
	A2(
		$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
		$elm$core$Basics$degrees(-30),
		A3(
			$MacCASOutreach$graphicsvg$GraphicSVG$addOutline,
			$MacCASOutreach$graphicsvg$GraphicSVG$solid(0.5),
			$MacCASOutreach$graphicsvg$GraphicSVG$black,
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$lightOrange,
				$MacCASOutreach$graphicsvg$GraphicSVG$triangle(3)))));
var $author$project$Main$tailPuffer = $MacCASOutreach$graphicsvg$GraphicSVG$group(
	_List_fromArray(
		[
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-3, 0),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$lightOrange,
				$MacCASOutreach$graphicsvg$GraphicSVG$circle(3.5))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(3, 0),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$lightOrange,
				$MacCASOutreach$graphicsvg$GraphicSVG$circle(3.5))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(0, -5),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
				$elm$core$Basics$degrees(30),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					$MacCASOutreach$graphicsvg$GraphicSVG$lightOrange,
					$MacCASOutreach$graphicsvg$GraphicSVG$triangle(7))))
		]));
var $author$project$Main$pufferfish = $MacCASOutreach$graphicsvg$GraphicSVG$group(
	_List_fromArray(
		[
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(0, 13),
			$author$project$Main$spike),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-11, 9),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
				$elm$core$Basics$degrees(40),
				$author$project$Main$spike)),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(11, 9),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
				$elm$core$Basics$degrees(-40),
				$author$project$Main$spike)),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(0, -13),
			A2($MacCASOutreach$graphicsvg$GraphicSVG$scaleY, -1, $author$project$Main$spike)),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-11, -9),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$scaleY,
				-1,
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
					$elm$core$Basics$degrees(40),
					$author$project$Main$spike))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(11, -9),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$scaleY,
				-1,
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
					$elm$core$Basics$degrees(-40),
					$author$project$Main$spike))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-20, 0),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
				$elm$core$Basics$degrees(90),
				A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$addOutline,
					$MacCASOutreach$graphicsvg$GraphicSVG$solid(1),
					$MacCASOutreach$graphicsvg$GraphicSVG$black,
					$author$project$Main$tailPuffer))),
			A3(
			$MacCASOutreach$graphicsvg$GraphicSVG$addOutline,
			$MacCASOutreach$graphicsvg$GraphicSVG$solid(0.5),
			$MacCASOutreach$graphicsvg$GraphicSVG$black,
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$lightOrange,
				A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 30, 25))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-5, 7),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
				$elm$core$Basics$degrees(20),
				$author$project$Main$spike)),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(5, 7),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
				$elm$core$Basics$degrees(-20),
				$author$project$Main$spike)),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-5, -7),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$scaleY,
				-1,
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
					$elm$core$Basics$degrees(20),
					$author$project$Main$spike))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(5, -7),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$scaleY,
				-1,
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
					$elm$core$Basics$degrees(-20),
					$author$project$Main$spike))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(0, 2),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$black,
				A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 3, 4))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(9, 2),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$black,
				A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 3, 4))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(4.5, -2),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
				$elm$core$Basics$degrees(-90),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					$MacCASOutreach$graphicsvg$GraphicSVG$black,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$wedge, 2, 0.5)))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(0, -1),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$pink,
				A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 3, 1))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(9, -1),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				$MacCASOutreach$graphicsvg$GraphicSVG$pink,
				A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 3, 1))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-7, 0),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$subtract,
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(1, 0),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$filled,
						$MacCASOutreach$graphicsvg$GraphicSVG$white,
						A2($MacCASOutreach$graphicsvg$GraphicSVG$rect, 4, 10))),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
					$elm$core$Basics$degrees(-180),
					A3(
						$MacCASOutreach$graphicsvg$GraphicSVG$addOutline,
						$MacCASOutreach$graphicsvg$GraphicSVG$solid(0.5),
						$MacCASOutreach$graphicsvg$GraphicSVG$black,
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$filled,
							$MacCASOutreach$graphicsvg$GraphicSVG$lightOrange,
							A2($MacCASOutreach$graphicsvg$GraphicSVG$wedge, 5, 0.25)))))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(12.5, 0),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$subtract,
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					$MacCASOutreach$graphicsvg$GraphicSVG$white,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$rect, 4, 10)),
				A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$addOutline,
					$MacCASOutreach$graphicsvg$GraphicSVG$solid(0.5),
					$MacCASOutreach$graphicsvg$GraphicSVG$black,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$filled,
						$MacCASOutreach$graphicsvg$GraphicSVG$lightOrange,
						A2($MacCASOutreach$graphicsvg$GraphicSVG$wedge, 5, 0.25))))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(19.25, -20),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$scale,
				0.5,
				$MacCASOutreach$graphicsvg$GraphicSVG$mirrorX(
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$filled,
						$MacCASOutreach$graphicsvg$GraphicSVG$lightBlue,
						$MacCASOutreach$graphicsvg$GraphicSVG$bold(
							$MacCASOutreach$graphicsvg$GraphicSVG$text('YOU! (Cloonie)')))))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(19, -20),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$scale,
				0.5,
				$MacCASOutreach$graphicsvg$GraphicSVG$mirrorX(
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$filled,
						$MacCASOutreach$graphicsvg$GraphicSVG$black,
						$MacCASOutreach$graphicsvg$GraphicSVG$bold(
							$MacCASOutreach$graphicsvg$GraphicSVG$text('YOU! (Cloonie)'))))))
		]));
var $author$project$Main$spikeS = A2(
	$MacCASOutreach$graphicsvg$GraphicSVG$subtract,
	A2(
		$MacCASOutreach$graphicsvg$GraphicSVG$move,
		_Utils_Tuple2(0, -2),
		A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$filled,
			$MacCASOutreach$graphicsvg$GraphicSVG$white,
			A2($MacCASOutreach$graphicsvg$GraphicSVG$rect, 9, 2.5))),
	A2(
		$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
		$elm$core$Basics$degrees(-30),
		A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$filled,
			A2($author$project$Main$sandGradient, 0, 10),
			$MacCASOutreach$graphicsvg$GraphicSVG$triangle(5))));
var $author$project$Main$tailS = $MacCASOutreach$graphicsvg$GraphicSVG$group(
	_List_fromArray(
		[
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(0, -5),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
				$elm$core$Basics$degrees(30),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					A2($author$project$Main$sandGradient, 0, 50),
					$MacCASOutreach$graphicsvg$GraphicSVG$triangle(7)))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-3, 0),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$rotateGradient,
					$elm$core$Basics$degrees(180),
					A2($author$project$Main$sandGradient, 0, 50)),
				$MacCASOutreach$graphicsvg$GraphicSVG$circle(3.5))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(3, 0),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$rotateGradient,
					$elm$core$Basics$degrees(180),
					A2($author$project$Main$sandGradient, 0, 50)),
				$MacCASOutreach$graphicsvg$GraphicSVG$circle(3.5)))
		]));
var $author$project$Main$pufferfishS = $MacCASOutreach$graphicsvg$GraphicSVG$group(
	_List_fromArray(
		[
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(0, 13),
			$author$project$Main$spikeS),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-11, 9),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
				$elm$core$Basics$degrees(40),
				$author$project$Main$spikeS)),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(11, 9),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
				$elm$core$Basics$degrees(-40),
				$author$project$Main$spikeS)),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(0, -13),
			A2($MacCASOutreach$graphicsvg$GraphicSVG$scaleY, -1, $author$project$Main$spikeS)),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-11, -9),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$scaleY,
				-1,
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
					$elm$core$Basics$degrees(40),
					$author$project$Main$spikeS))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(11, -9),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$scaleY,
				-1,
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
					$elm$core$Basics$degrees(-40),
					$author$project$Main$spikeS))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-20, 0),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
				$elm$core$Basics$degrees(90),
				$author$project$Main$tailS)),
			A3(
			$MacCASOutreach$graphicsvg$GraphicSVG$addOutline,
			$MacCASOutreach$graphicsvg$GraphicSVG$solid(0.5),
			$MacCASOutreach$graphicsvg$GraphicSVG$black,
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$filled,
				A2($author$project$Main$sandGradient, 0, 50),
				A2($MacCASOutreach$graphicsvg$GraphicSVG$oval, 30, 25))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-5, 7),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
				$elm$core$Basics$degrees(20),
				$author$project$Main$spikeS)),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(5, 7),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
				$elm$core$Basics$degrees(-20),
				$author$project$Main$spikeS)),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-5, -7),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$scaleY,
				-1,
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
					$elm$core$Basics$degrees(20),
					$author$project$Main$spikeS))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(5, -7),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$scaleY,
				-1,
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
					$elm$core$Basics$degrees(-20),
					$author$project$Main$spikeS))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-6, 12),
			A2($MacCASOutreach$graphicsvg$GraphicSVG$scale, 0.8, $author$project$Main$eyeShellS)),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(16, 12),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$scaleX,
				-1,
				A2($MacCASOutreach$graphicsvg$GraphicSVG$scale, 0.8, $author$project$Main$eyeShellS))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(0, -2.5),
			A2($MacCASOutreach$graphicsvg$GraphicSVG$scale, 0.15, $author$project$Main$mouthShellS)),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(-7, 0),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$subtract,
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(1, 0),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$filled,
						$MacCASOutreach$graphicsvg$GraphicSVG$white,
						A2($MacCASOutreach$graphicsvg$GraphicSVG$rect, 4, 10))),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
					$elm$core$Basics$degrees(-180),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$filled,
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$rotateGradient,
							$elm$core$Basics$degrees(120),
							A2($author$project$Main$sandGradient, -5, 20)),
						A2($MacCASOutreach$graphicsvg$GraphicSVG$wedge, 7, 0.25))))),
			A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$move,
			_Utils_Tuple2(12.5, 0),
			A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$subtract,
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					$MacCASOutreach$graphicsvg$GraphicSVG$white,
					A2($MacCASOutreach$graphicsvg$GraphicSVG$rect, 4, 10)),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					A2($author$project$Main$sandGradient, 0, 10),
					A2($MacCASOutreach$graphicsvg$GraphicSVG$wedge, 7, 0.25))))
		]));
var $MacCASOutreach$graphicsvg$GraphicSVG$purple = A4($MacCASOutreach$graphicsvg$GraphicSVG$rgba, 117, 80, 123, 1);
var $author$project$Main$buttonGreen = A3($MacCASOutreach$graphicsvg$GraphicSVG$rgb, 20, 180, 170);
var $author$project$Main$buttonHighlight = function (t) {
	return A4(
		$MacCASOutreach$graphicsvg$GraphicSVG$rgba,
		255,
		255,
		170,
		0.5 + (0.5 * $elm$core$Basics$sin(2 * t)));
};
var $MacCASOutreach$graphicsvg$GraphicSVG$Secret$RoundRect = F3(
	function (a, b, c) {
		return {$: 'RoundRect', a: a, b: b, c: c};
	});
var $MacCASOutreach$graphicsvg$GraphicSVG$roundedRect = F3(
	function (w, h, r) {
		return A3($MacCASOutreach$graphicsvg$GraphicSVG$Secret$RoundRect, w, h, r);
	});
var $author$project$Main$restartButton = function (t) {
	return $MacCASOutreach$graphicsvg$GraphicSVG$group(
		_List_fromArray(
			[
				A3(
				$MacCASOutreach$graphicsvg$GraphicSVG$outlined,
				$MacCASOutreach$graphicsvg$GraphicSVG$solid(1.5),
				$author$project$Main$buttonHighlight(t),
				A3($MacCASOutreach$graphicsvg$GraphicSVG$roundedRect, 20, 7, 3)),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(0, -1.5),
				A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$outlined,
					$MacCASOutreach$graphicsvg$GraphicSVG$solid(1),
					$author$project$Main$buttonHighlight(t),
					$MacCASOutreach$graphicsvg$GraphicSVG$centered(
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$size,
							6,
							$MacCASOutreach$graphicsvg$GraphicSVG$text('Replay'))))),
				A3(
				$MacCASOutreach$graphicsvg$GraphicSVG$addOutline,
				$MacCASOutreach$graphicsvg$GraphicSVG$solid(0.5),
				$author$project$Main$buttonGreen,
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					A4($MacCASOutreach$graphicsvg$GraphicSVG$rgba, 255, 255, 255, 0.5),
					A3($MacCASOutreach$graphicsvg$GraphicSVG$roundedRect, 20, 7, 3))),
				A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$move,
				_Utils_Tuple2(0, -1.5),
				A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					$author$project$Main$buttonGreen,
					$MacCASOutreach$graphicsvg$GraphicSVG$centered(
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$size,
							6,
							$MacCASOutreach$graphicsvg$GraphicSVG$text('Replay')))))
			]));
};
var $author$project$Main$myBlack = A3($MacCASOutreach$graphicsvg$GraphicSVG$rgb, 39, 120, 230);
var $author$project$Main$stops = function (t) {
	return A2(
		$elm$core$List$map,
		function (idx) {
			return A2(
				$MacCASOutreach$graphicsvg$GraphicSVG$stop,
				A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$hsl,
					3 + ($elm$core$Basics$degrees(2) * idx),
					1,
					0.5),
				5 * idx);
		},
		A2($elm$core$List$range, 0, 10));
};
var $author$project$Main$shell = F2(
	function (textLabel, notifyMsg) {
		var shellStencil = A2(
			$MacCASOutreach$graphicsvg$GraphicSVG$curve,
			_Utils_Tuple2(-46.91, -5.845),
			_List_fromArray(
				[
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
					_Utils_Tuple2(-50.34, -11.84),
					_Utils_Tuple2(-46.01, -17.83)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
					_Utils_Tuple2(-23.53, -33.17),
					_Utils_Tuple2(-1.049, -35.52)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
					_Utils_Tuple2(20.084, -31.83),
					_Utils_Tuple2(41.217, -19.63)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
					_Utils_Tuple2(46.216, -11.98),
					_Utils_Tuple2(43.615, -6.145)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
					_Utils_Tuple2(47.835, 1.1091),
					_Utils_Tuple2(44.215, 8.2435)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
					_Utils_Tuple2(41.817, 11.572),
					_Utils_Tuple2(39.419, 10.941)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
					_Utils_Tuple2(40.350, 15.437),
					_Utils_Tuple2(37.320, 19.934)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
					_Utils_Tuple2(34.653, 23.612),
					_Utils_Tuple2(31.025, 25.330)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
					_Utils_Tuple2(28.098, 30.547),
					_Utils_Tuple2(23.531, 33.124)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
					_Utils_Tuple2(19.873, 33.964),
					_Utils_Tuple2(18.735, 31.925)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
					_Utils_Tuple2(12.449, 39.843),
					_Utils_Tuple2(7.0444, 34.922)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
					_Utils_Tuple2(-0.978, 42.132),
					_Utils_Tuple2(-10.04, 35.222)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
					_Utils_Tuple2(-18.00, 37.983),
					_Utils_Tuple2(-22.93, 31.625)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
					_Utils_Tuple2(-29.47, 35.438),
					_Utils_Tuple2(-34.62, 24.131)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
					_Utils_Tuple2(-42.71, 24.086),
					_Utils_Tuple2(-43.01, 10.042)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
					_Utils_Tuple2(-52.16, 7.5983),
					_Utils_Tuple2(-46.91, -5.845))
				]));
		return $MacCASOutreach$graphicsvg$GraphicSVG$group(
			_List_fromArray(
				[
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$rotateGradient,
						$elm$core$Basics$degrees(90),
						$MacCASOutreach$graphicsvg$GraphicSVG$gradient(
							$author$project$Main$stops(0.4))),
					shellStencil),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$filled,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$rotateGradient,
						$elm$core$Basics$degrees(90),
						$MacCASOutreach$graphicsvg$GraphicSVG$radialGradient(
							$author$project$Main$stops(0.4))),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$curve,
						_Utils_Tuple2(-24.43, -30.72),
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-24.88, -33.87),
								_Utils_Tuple2(-25.33, -37.02)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-15.47, -38.59),
								_Utils_Tuple2(-3.747, -36.72)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(8.8430, -39.10),
								_Utils_Tuple2(21.433, -38.51)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(21.863, -34.17),
								_Utils_Tuple2(20.533, -29.82)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(8.5433, -32.82),
								_Utils_Tuple2(-3.447, -35.82)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-13.33, -32.82),
								_Utils_Tuple2(-23.23, -29.82)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-23.83, -30.42),
								_Utils_Tuple2(-24.43, -30.72))
							]))),
					A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$outlined,
					$MacCASOutreach$graphicsvg$GraphicSVG$solid(1),
					$author$project$Main$myBlack,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$curve,
						_Utils_Tuple2(-24.43, -29.52),
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-24.77, -33.74),
								_Utils_Tuple2(-25.03, -37.32)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-18.27, -39.57),
								_Utils_Tuple2(-3.447, -37.02)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(12.513, -39.07),
								_Utils_Tuple2(20.833, -38.51)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(21.823, -34.32),
								_Utils_Tuple2(20.533, -30.12)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(7.9325, -34.42),
								_Utils_Tuple2(-1.348, -36.12)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-11.62, -35.40),
								_Utils_Tuple2(-24.43, -29.52))
							]))),
					A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$outlined,
					$MacCASOutreach$graphicsvg$GraphicSVG$solid(1),
					$author$project$Main$myBlack,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$curve,
						_Utils_Tuple2(-1.648, -35.52),
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-17.98, -35.15),
								_Utils_Tuple2(-40.91, -22.03)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-52.27, -13.93),
								_Utils_Tuple2(-46.91, -5.845)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-40.54, -15.44),
								_Utils_Tuple2(-31.62, -22.33))
							]))),
					A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$outlined,
					$MacCASOutreach$graphicsvg$GraphicSVG$solid(1),
					$author$project$Main$myBlack,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$curve,
						_Utils_Tuple2(-46.31, -5.845),
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-52.85, 6.9381),
								_Utils_Tuple2(-43.31, 10.641)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-40.32, -0.370),
								_Utils_Tuple2(-34.62, -9.742)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-50.60, 19.424),
								_Utils_Tuple2(-35.82, 24.430)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-34.92, 24.701),
								_Utils_Tuple2(-34.02, 24.131)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-30.76, 2.9068),
								_Utils_Tuple2(-21.43, -16.03))
							]))),
					A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$outlined,
					$MacCASOutreach$graphicsvg$GraphicSVG$solid(1),
					$author$project$Main$myBlack,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$curve,
						_Utils_Tuple2(-34.62, 25.030),
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-28.73, 35.697),
								_Utils_Tuple2(-22.93, 31.925)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-22.83, 20.463),
								_Utils_Tuple2(-21.13, 10.042)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-27.27, 42.932),
								_Utils_Tuple2(-10.34, 35.222)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-9.652, 30.126),
								_Utils_Tuple2(-10.04, 25.030)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-9.892, 29.976),
								_Utils_Tuple2(-9.742, 34.922)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-1.498, 43.152),
								_Utils_Tuple2(6.7447, 35.222)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(11.757, -5.209),
								_Utils_Tuple2(-1.348, -36.12)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(20.023, -16.69),
								_Utils_Tuple2(19.035, 27.728))
							]))),
					A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$outlined,
					$MacCASOutreach$graphicsvg$GraphicSVG$solid(1),
					$author$project$Main$myBlack,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$curve,
						_Utils_Tuple2(7.0444, 34.922),
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(13.479, 40.294),
								_Utils_Tuple2(19.035, 31.625)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(25.150, 36.147),
								_Utils_Tuple2(30.426, 25.030)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(30.169, 7.6934),
								_Utils_Tuple2(22.032, -8.243)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(29.989, 8.5433),
								_Utils_Tuple2(30.426, 25.330)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(39.752, 22.095),
								_Utils_Tuple2(39.119, 12.740)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(38.241, 5.6553),
								_Utils_Tuple2(34.922, -0.749)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(38.461, 5.2459),
								_Utils_Tuple2(38.519, 11.241)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(47.657, 9.9866),
								_Utils_Tuple2(44.515, -2.548)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(37.802, -13.99),
								_Utils_Tuple2(25.929, -23.53)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(35.833, -15.58),
								_Utils_Tuple2(42.416, -5.845)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(44.295, -5.433),
								_Utils_Tuple2(44.814, -9.742)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(44.466, -15.75),
								_Utils_Tuple2(39.718, -19.93)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(29.606, -26.29),
								_Utils_Tuple2(19.934, -30.12)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(9.8922, -33.47),
								_Utils_Tuple2(-0.149, -35.22)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(18.197, -28.97),
								_Utils_Tuple2(31.625, -7.644))
							]))),
					A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$outlined,
					$MacCASOutreach$graphicsvg$GraphicSVG$solid(1),
					$author$project$Main$myBlack,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$curve,
						_Utils_Tuple2(18.735, -14.83),
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(11.763, -30.46),
								_Utils_Tuple2(-1.049, -35.52)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-11.22, -11.83),
								_Utils_Tuple2(-10.64, 18.135))
							]))),
					A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$outlined,
					$MacCASOutreach$graphicsvg$GraphicSVG$solid(1),
					$author$project$Main$myBlack,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$curve,
						_Utils_Tuple2(-18.73, 2.5480),
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-15.60, -14.22),
								_Utils_Tuple2(-7.644, -28.92))
							]))),
					A3(
					$MacCASOutreach$graphicsvg$GraphicSVG$outlined,
					$MacCASOutreach$graphicsvg$GraphicSVG$solid(1),
					$author$project$Main$myBlack,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$curve,
						_Utils_Tuple2(-18.73, -19.33),
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-13.31, -30.41),
								_Utils_Tuple2(-2.847, -35.22)),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$Secret$Pull,
								_Utils_Tuple2(-19.83, -32.04),
								_Utils_Tuple2(-31.62, -14.53))
							]))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$scale,
					1.5,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(0, -5),
						A3(
							$MacCASOutreach$graphicsvg$GraphicSVG$outlined,
							$MacCASOutreach$graphicsvg$GraphicSVG$solid(2.3),
							$MacCASOutreach$graphicsvg$GraphicSVG$white,
							$MacCASOutreach$graphicsvg$GraphicSVG$centered(
								$MacCASOutreach$graphicsvg$GraphicSVG$text(textLabel))))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$scale,
					1.5,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(0, -5),
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$filled,
							A3($MacCASOutreach$graphicsvg$GraphicSVG$rgb, 45, 8, 255),
							$MacCASOutreach$graphicsvg$GraphicSVG$centered(
								$MacCASOutreach$graphicsvg$GraphicSVG$text(textLabel))))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$notifyTap,
					notifyMsg,
					$MacCASOutreach$graphicsvg$GraphicSVG$ghost(shellStencil))
				]));
	});
var $author$project$Main$textBlue = A3($MacCASOutreach$graphicsvg$GraphicSVG$rgb, 45, 8, 255);
var $author$project$Main$welcomeScript = _List_fromArray(
	[
		_Utils_Tuple2($author$project$Main$Mermaid, 'Let\'s Practice Social-Emotional'),
		_Utils_Tuple2($author$project$Main$Mermaid, 'Learning! Are You Ready?')
	]);
var $author$project$Main$myShapes = function (model) {
	var _v0 = model.state;
	switch (_v0.$) {
		case 'Welcome':
			var showInstructions = _v0.a;
			return _Utils_ap(
				_List_fromArray(
					[
						A3(
						$author$project$Main$backgroundElements,
						1,
						function (input) {
							return $MacCASOutreach$graphicsvg$GraphicSVG$group(_List_Nil);
						},
						model),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(-60, -50),
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
							5 * $elm$core$Basics$sin(1 * model.time),
							A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$scale,
								0.7 + (0.2 * $elm$core$Basics$sin(1.5 * model.time)),
								A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$scale,
									0.25,
									$author$project$Main$movingStarfish(model))))),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(
							A4($author$project$Main$repeatDistance, 5, -500, 100, -model.time),
							20),
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$move,
							_Utils_Tuple2(
								0,
								(30 * $elm$core$Basics$cos(model.time)) * 0.3),
							A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$move,
								_Utils_Tuple2(30, -10),
								A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$scale,
									0.5,
									$author$project$Main$jellyfish(
										A3(
											$MacCASOutreach$graphicsvg$GraphicSVG$hsl,
											$elm$core$Basics$degrees(30) * model.time,
											1,
											0.5)))))),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(
							0,
							(10 * $elm$core$Basics$sin(model.time)) * 0.5),
						$MacCASOutreach$graphicsvg$GraphicSVG$group(
							_List_fromArray(
								[
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$scale,
									1.7,
									A2(
										$MacCASOutreach$graphicsvg$GraphicSVG$move,
										_Utils_Tuple2(-10, 16),
										A5($author$project$Main$multiBubbleRight, $MacCASOutreach$graphicsvg$GraphicSVG$black, $author$project$Main$welcomeScript, 42, $author$project$Main$Mermaid, 4.5))),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$move,
									_Utils_Tuple2(120, -17),
									A2(
										$MacCASOutreach$graphicsvg$GraphicSVG$scale,
										0.8,
										$author$project$Main$finalMermaid(model)))
								]))),
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(0, -40),
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$scale,
							0.5,
							A2($author$project$Main$shell, 'Let\'s Go!', $author$project$Main$WelcomeTo1)))
					]),
				showInstructions ? _List_fromArray(
					[
						A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$notifyTap,
						$author$project$Main$HideInstructions,
						$MacCASOutreach$graphicsvg$GraphicSVG$group(
							_List_fromArray(
								[
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$filled,
									A4($MacCASOutreach$graphicsvg$GraphicSVG$rgba, 255, 255, 255, 0.85),
									A2($MacCASOutreach$graphicsvg$GraphicSVG$rect, 190, 125)),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$move,
									_Utils_Tuple2(0, 35),
									$author$project$Main$headline('Help the mermaid')),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$move,
									_Utils_Tuple2(0, 15),
									$author$project$Main$headline('say the right thing')),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$move,
									_Utils_Tuple2(0, -5),
									$author$project$Main$headline('by clicking')),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$move,
									_Utils_Tuple2(-40, -30),
									A2(
										$MacCASOutreach$graphicsvg$GraphicSVG$scale,
										0.35,
										A2($author$project$Main$shell, 'the', $author$project$Main$HideInstructions))),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$move,
									_Utils_Tuple2(0, -30),
									A2(
										$MacCASOutreach$graphicsvg$GraphicSVG$scale,
										0.35,
										A2($author$project$Main$shell, 'right', $author$project$Main$HideInstructions))),
									A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$move,
									_Utils_Tuple2(40, -30),
									A2(
										$MacCASOutreach$graphicsvg$GraphicSVG$scale,
										0.35,
										A2($author$project$Main$shell, 'choice', $author$project$Main$HideInstructions)))
								])))
					]) : _List_Nil);
		case 'Scene1':
			var scriptTime = $author$project$Main$debugSpeedup * (model.time - model.startTime);
			var pixarScript = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Pixar, 'Hey guys! It\'s been 5 years'),
					_Utils_Tuple2($author$project$Main$Pixar, 'since we met in Kindergarten!'),
					_Utils_Tuple2($author$project$Main$Pixar, ' '),
					_Utils_Tuple2($author$project$Main$Pixar, 'I think for today, we should'),
					_Utils_Tuple2($author$project$Main$Pixar, 'do something special...')
				]);
			var orScript = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Or, 'Oh my gosh,'),
					_Utils_Tuple2($author$project$Main$Or, '5 YEARS?!'),
					_Utils_Tuple2($author$project$Main$Or, 'Yay!'),
					_Utils_Tuple2($author$project$Main$Or, 'That sounds'),
					_Utils_Tuple2($author$project$Main$Or, 'so exciting!'),
					_Utils_Tuple2($author$project$Main$Or, 'We\'re going to'),
					_Utils_Tuple2($author$project$Main$Or, 'have the best '),
					_Utils_Tuple2($author$project$Main$Or, 'time ever!!'),
					_Utils_Tuple2($author$project$Main$Or, '')
				]);
			var mermaidScript = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Mermaid, 'Hmm, what do you think, Cloonie?')
				]);
			var eitherScript = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Either, 'Ummm...'),
					_Utils_Tuple2($author$project$Main$Either, 'but how in the'),
					_Utils_Tuple2($author$project$Main$Either, 'sea are we '),
					_Utils_Tuple2($author$project$Main$Either, 'supposed to '),
					_Utils_Tuple2($author$project$Main$Either, 'build something '),
					_Utils_Tuple2($author$project$Main$Either, 'like that??? '),
					_Utils_Tuple2($author$project$Main$Either, 'We\'re only '),
					_Utils_Tuple2($author$project$Main$Either, 'in Grade 4, '),
					_Utils_Tuple2($author$project$Main$Either, 'we can\'t really'),
					_Utils_Tuple2($author$project$Main$Either, 'do anything. '),
					_Utils_Tuple2($author$project$Main$Either, 'Let\'s just go '),
					_Utils_Tuple2($author$project$Main$Either, 'eat seaweed, '),
					_Utils_Tuple2($author$project$Main$Either, 'it\'s easier...'),
					_Utils_Tuple2($author$project$Main$Either, ''),
					_Utils_Tuple2($author$project$Main$Either, '')
				]);
			var codyScript = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Cody, 'OH! I know!'),
					_Utils_Tuple2($author$project$Main$Cody, ' '),
					_Utils_Tuple2($author$project$Main$Cody, 'Why don\'t we build'),
					_Utils_Tuple2($author$project$Main$Cody, 'a statue out of pearls'),
					_Utils_Tuple2($author$project$Main$Cody, 'to celebrate?')
				]);
			var scene1Script = _Utils_ap(
				pixarScript,
				_Utils_ap(
					codyScript,
					_Utils_ap(
						mermaidScript,
						_Utils_ap(eitherScript, orScript))));
			return _List_fromArray(
				[
					A3($author$project$Main$backgroundElements, 1, $author$project$Main$fishAni, model),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-68, -3),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$scale,
						0.5,
						$author$project$Main$parrotFish(model))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-8, 25),
					A5($author$project$Main$multiBubbleLeft, $MacCASOutreach$graphicsvg$GraphicSVG$black, scene1Script, 46, $author$project$Main$Pixar, scriptTime)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-10, -8),
					A2($author$project$Main$cody, model, $MacCASOutreach$graphicsvg$GraphicSVG$orange)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-50, 25),
					A5($author$project$Main$multiBubbleRight, $MacCASOutreach$graphicsvg$GraphicSVG$black, scene1Script, 42, $author$project$Main$Cody, scriptTime)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(
						0,
						(10 * $elm$core$Basics$sin(model.time)) * 0.5),
					$MacCASOutreach$graphicsvg$GraphicSVG$group(
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$scale,
								1,
								A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$move,
									_Utils_Tuple2(0, 35),
									A5($author$project$Main$multiBubbleRight, $MacCASOutreach$graphicsvg$GraphicSVG$black, scene1Script, 48, $author$project$Main$Mermaid, scriptTime))),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$move,
								_Utils_Tuple2(120, -17),
								A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$scale,
									0.8,
									$author$project$Main$finalMermaid(model)))
							]))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(78, 48),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$scale,
						0.75,
						$MacCASOutreach$graphicsvg$GraphicSVG$mirrorX($author$project$Main$pufferfish))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$scale,
					0.5,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(-130, -80),
						A2($author$project$Main$shell, 'Either say:', $author$project$Main$T1to2))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-68, -40),
					$MacCASOutreach$graphicsvg$GraphicSVG$group(
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$move,
								_Utils_Tuple2(47, 0),
								A5($author$project$Main$multiBubbleLeft, $author$project$Main$textBlue, scene1Script, 21, $author$project$Main$Either, scriptTime))
							]))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$scale,
					0.5,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(60, -80),
						A2($author$project$Main$shell, 'or say:', $author$project$Main$T1to3))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(30, -40),
					$MacCASOutreach$graphicsvg$GraphicSVG$group(
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$move,
								_Utils_Tuple2(47, 0),
								A5($author$project$Main$multiBubbleLeft, $author$project$Main$textBlue, scene1Script, 20, $author$project$Main$Or, scriptTime))
							]))),
					(scriptTime > 85) ? A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$notifyTap,
					$author$project$Main$Restart1,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(80, 55),
						$author$project$Main$restartButton(model.time))) : $MacCASOutreach$graphicsvg$GraphicSVG$group(_List_Nil)
				]);
		case 'Scene2':
			var scriptTime = $author$project$Main$debugSpeedup * (model.time - model.startTime);
			var pixar2moreScript = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Pixar, 'Come on! It\'ll be something'),
					_Utils_Tuple2($author$project$Main$Pixar, 'exciting for sure')
				]);
			var pixar2Script = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Pixar, 'Then why don\'t we go and'),
					_Utils_Tuple2($author$project$Main$Pixar, 'collect the shells next to'),
					_Utils_Tuple2($author$project$Main$Pixar, 'Seaweed Seashore and make'),
					_Utils_Tuple2($author$project$Main$Pixar, 'a statute out of seashells instead?'),
					_Utils_Tuple2($author$project$Main$Pixar, 'Then we can go and eat'),
					_Utils_Tuple2($author$project$Main$Pixar, 'AND celebrate?')
				]);
			var or2Script = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Or, 'Well...I guess.'),
					_Utils_Tuple2($author$project$Main$Or, 'But I\'d'),
					_Utils_Tuple2($author$project$Main$Or, 'definitely'),
					_Utils_Tuple2($author$project$Main$Or, 'like to eat'),
					_Utils_Tuple2($author$project$Main$Or, 'some'),
					_Utils_Tuple2($author$project$Main$Or, 'seaweed before'),
					_Utils_Tuple2($author$project$Main$Or, 'we start working.'),
					_Utils_Tuple2($author$project$Main$Or, 'I really need'),
					_Utils_Tuple2($author$project$Main$Or, 'some energy in'),
					_Utils_Tuple2($author$project$Main$Or, 'my body.'),
					_Utils_Tuple2($author$project$Main$Or, ''),
					_Utils_Tuple2($author$project$Main$Or, '')
				]);
			var mermaid2Script = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Mermaid, ' Cloonie, what response'),
					_Utils_Tuple2($author$project$Main$Mermaid, 'do you think will best'),
					_Utils_Tuple2($author$project$Main$Mermaid, 'support Pixar and Cody?')
				]);
			var either2Script = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Either, 'Nah,'),
					_Utils_Tuple2($author$project$Main$Either, 'that sounds'),
					_Utils_Tuple2($author$project$Main$Either, 'too difficult,'),
					_Utils_Tuple2($author$project$Main$Either, 'I think we'),
					_Utils_Tuple2($author$project$Main$Either, 'should just'),
					_Utils_Tuple2($author$project$Main$Either, 'give up on'),
					_Utils_Tuple2($author$project$Main$Either, 'the statue'),
					_Utils_Tuple2($author$project$Main$Either, 'idea.'),
					_Utils_Tuple2($author$project$Main$Either, ''),
					_Utils_Tuple2($author$project$Main$Either, '')
				]);
			var cody2Script = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Cody, 'Umm.... I\'m not sure...'),
					_Utils_Tuple2($author$project$Main$Cody, 'Cloonie makes a good point...')
				]);
			var scene2Script = _Utils_ap(
				pixar2Script,
				_Utils_ap(
					cody2Script,
					_Utils_ap(
						pixar2moreScript,
						_Utils_ap(
							mermaid2Script,
							_Utils_ap(either2Script, or2Script)))));
			return _List_fromArray(
				[
					A3($author$project$Main$backgroundElements, 1, $author$project$Main$fishAni, model),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(78, 48),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$scale,
						0.75,
						$MacCASOutreach$graphicsvg$GraphicSVG$mirrorX($author$project$Main$pufferfish))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-68, -3),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$scale,
						0.5,
						$author$project$Main$parrotFish(model))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-8, 25),
					A5($author$project$Main$multiBubbleLeft, $MacCASOutreach$graphicsvg$GraphicSVG$black, scene2Script, 46, $author$project$Main$Pixar, scriptTime)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-10, -8),
					A2($author$project$Main$cody, model, $MacCASOutreach$graphicsvg$GraphicSVG$orange)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-50, 25),
					A5($author$project$Main$multiBubbleRight, $MacCASOutreach$graphicsvg$GraphicSVG$black, scene2Script, 42, $author$project$Main$Cody, scriptTime)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(
						0,
						(10 * $elm$core$Basics$sin(model.time)) * 0.5),
					$MacCASOutreach$graphicsvg$GraphicSVG$group(
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$scale,
								1,
								A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$move,
									_Utils_Tuple2(0, 35),
									A5($author$project$Main$multiBubbleRight, $MacCASOutreach$graphicsvg$GraphicSVG$black, scene2Script, 48, $author$project$Main$Mermaid, scriptTime))),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$move,
								_Utils_Tuple2(120, -17),
								A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$scale,
									0.8,
									$author$project$Main$finalMermaid(model)))
							]))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$scale,
					0.5,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(-130, -80),
						A2($author$project$Main$shell, 'Either say:', $author$project$Main$T2toend))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-68, -40),
					$MacCASOutreach$graphicsvg$GraphicSVG$group(
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$move,
								_Utils_Tuple2(47, 0),
								A5($author$project$Main$multiBubbleLeft, $author$project$Main$textBlue, scene2Script, 21, $author$project$Main$Either, scriptTime))
							]))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$scale,
					0.5,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(60, -80),
						A2($author$project$Main$shell, 'or say:', $author$project$Main$T2to3))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(30, -40),
					$MacCASOutreach$graphicsvg$GraphicSVG$group(
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$move,
								_Utils_Tuple2(47, 0),
								A5($author$project$Main$multiBubbleLeft, $author$project$Main$textBlue, scene2Script, 20, $author$project$Main$Or, scriptTime))
							]))),
					(scriptTime > 20) ? A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$notifyTap,
					$author$project$Main$Restart2,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(80, 55),
						$author$project$Main$restartButton(model.time))) : $MacCASOutreach$graphicsvg$GraphicSVG$group(_List_Nil)
				]);
		case 'Scene3':
			var scriptTime = $author$project$Main$debugSpeedup * (model.time - model.startTime);
			var pixar3twoScript = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Pixar, 'Yeah! Why don\'t we each make'),
					_Utils_Tuple2($author$project$Main$Pixar, 'check in often and at the'),
					_Utils_Tuple2($author$project$Main$Pixar, 'end, we should work together'),
					_Utils_Tuple2($author$project$Main$Pixar, 'to combine the three of them.')
				]);
			var pixar3Script = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Pixar, 'Let\'s split up and collect'),
					_Utils_Tuple2($author$project$Main$Pixar, 'as many shells as we can!')
				]);
			var or3Script = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Or, 'Mhm,'),
					_Utils_Tuple2($author$project$Main$Or, 'that sounds'),
					_Utils_Tuple2($author$project$Main$Or, 'great!'),
					_Utils_Tuple2($author$project$Main$Or, 'Checking in'),
					_Utils_Tuple2($author$project$Main$Or, 'with each'),
					_Utils_Tuple2($author$project$Main$Or, 'other sounds'),
					_Utils_Tuple2($author$project$Main$Or, 'like an'),
					_Utils_Tuple2($author$project$Main$Or, 'excellent'),
					_Utils_Tuple2($author$project$Main$Or, 'idea, Pixar!'),
					_Utils_Tuple2($author$project$Main$Or, 'Or else,'),
					_Utils_Tuple2($author$project$Main$Or, 'we\'ll end'),
					_Utils_Tuple2($author$project$Main$Or, 'up making'),
					_Utils_Tuple2($author$project$Main$Or, 'things that'),
					_Utils_Tuple2($author$project$Main$Or, 'don\'t fit'),
					_Utils_Tuple2($author$project$Main$Or, 'in with'),
					_Utils_Tuple2($author$project$Main$Or, 'each other!'),
					_Utils_Tuple2($author$project$Main$Or, '')
				]);
			var mermaid3twoScript = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Mermaid, '*1 Hour Later*')
				]);
			var mermaid3threeScript = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Mermaid, 'What do you think'),
					_Utils_Tuple2($author$project$Main$Mermaid, 'about that, Cloonie?')
				]);
			var mermaid3Script = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Mermaid, '*15 Minutes Later*')
				]);
			var either3Script = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Either, 'Ugh,'),
					_Utils_Tuple2($author$project$Main$Either, 'you guys are'),
					_Utils_Tuple2($author$project$Main$Either, 'so lame.'),
					_Utils_Tuple2($author$project$Main$Either, 'Why do we'),
					_Utils_Tuple2($author$project$Main$Either, 'even need'),
					_Utils_Tuple2($author$project$Main$Either, 'to check in?'),
					_Utils_Tuple2($author$project$Main$Either, 'We can just make'),
					_Utils_Tuple2($author$project$Main$Either, 'each statue'),
					_Utils_Tuple2($author$project$Main$Either, 'ourself'),
					_Utils_Tuple2($author$project$Main$Either, 'and figure'),
					_Utils_Tuple2($author$project$Main$Either, 'things out'),
					_Utils_Tuple2($author$project$Main$Either, 'on our own.'),
					_Utils_Tuple2($author$project$Main$Either, 'We\'ll combine'),
					_Utils_Tuple2($author$project$Main$Either, 'them later.'),
					_Utils_Tuple2($author$project$Main$Either, ''),
					_Utils_Tuple2($author$project$Main$Either, '')
				]);
			var cody3twoScript = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Cody, 'Alright, let\'s check in everyone!'),
					_Utils_Tuple2($author$project$Main$Cody, 'these are all the seashells'),
					_Utils_Tuple2($author$project$Main$Cody, 'that we got! Why don\'t'),
					_Utils_Tuple2($author$project$Main$Cody, 'we try building three friends'),
					_Utils_Tuple2($author$project$Main$Cody, 'hugging each other?')
				]);
			var cody3Script = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Cody, 'Yeah!')
				]);
			var scene3Script = _Utils_ap(
				mermaid3Script,
				_Utils_ap(
					pixar3Script,
					_Utils_ap(
						cody3Script,
						_Utils_ap(
							mermaid3twoScript,
							_Utils_ap(
								cody3twoScript,
								_Utils_ap(
									pixar3twoScript,
									_Utils_ap(
										mermaid3threeScript,
										_Utils_ap(either3Script, or3Script))))))));
			return _List_fromArray(
				[
					A3(
					$author$project$Main$backgroundElements,
					0.95,
					function (input) {
						return A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$filled,
							$MacCASOutreach$graphicsvg$GraphicSVG$orange,
							$MacCASOutreach$graphicsvg$GraphicSVG$circle(5));
					},
					model),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-68, -3),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$scale,
						0.5,
						$author$project$Main$parrotFish(model))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(78, 48),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$scale,
						0.75,
						$MacCASOutreach$graphicsvg$GraphicSVG$mirrorX($author$project$Main$pufferfish))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-8, 25),
					A5($author$project$Main$multiBubbleLeft, $MacCASOutreach$graphicsvg$GraphicSVG$black, scene3Script, 46, $author$project$Main$Pixar, scriptTime)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-10, -8),
					A2($author$project$Main$cody, model, $MacCASOutreach$graphicsvg$GraphicSVG$orange)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-50, 25),
					A5($author$project$Main$multiBubbleRight, $MacCASOutreach$graphicsvg$GraphicSVG$black, scene3Script, 42, $author$project$Main$Cody, scriptTime)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(
						0,
						(10 * $elm$core$Basics$sin(model.time)) * 0.5),
					$MacCASOutreach$graphicsvg$GraphicSVG$group(
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$scale,
								1,
								A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$move,
									_Utils_Tuple2(0, 35),
									A5($author$project$Main$multiBubbleRight, $MacCASOutreach$graphicsvg$GraphicSVG$black, scene3Script, 48, $author$project$Main$Mermaid, scriptTime))),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$move,
								_Utils_Tuple2(120, -17),
								A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$scale,
									0.8,
									$author$project$Main$finalMermaid(model)))
							]))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$scale,
					0.5,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(-130, -80),
						A2($author$project$Main$shell, 'Either say:', $author$project$Main$T3to4))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-68, -40),
					$MacCASOutreach$graphicsvg$GraphicSVG$group(
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$move,
								_Utils_Tuple2(47, 0),
								A5($author$project$Main$multiBubbleLeft, $author$project$Main$textBlue, scene3Script, 20, $author$project$Main$Either, scriptTime))
							]))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$scale,
					0.5,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(60, -80),
						A2($author$project$Main$shell, 'or say:', $author$project$Main$T3to5))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(30, -40),
					$MacCASOutreach$graphicsvg$GraphicSVG$group(
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$move,
								_Utils_Tuple2(47, 0),
								A5($author$project$Main$multiBubbleLeft, $author$project$Main$textBlue, scene3Script, 20, $author$project$Main$Or, scriptTime))
							]))),
					(scriptTime > 85) ? A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$notifyTap,
					$author$project$Main$Restart3,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(80, 55),
						$author$project$Main$restartButton(model.time))) : $MacCASOutreach$graphicsvg$GraphicSVG$group(_List_Nil)
				]);
		case 'Scene2End':
			var scriptTime = $author$project$Main$debugSpeedup * (model.time - model.startTime);
			return _List_fromArray(
				[
					A3(
					$author$project$Main$backgroundElements,
					0.9,
					function (input) {
						return $MacCASOutreach$graphicsvg$GraphicSVG$group(_List_Nil);
					},
					model),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(78, 48),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$scale,
						0.75,
						$MacCASOutreach$graphicsvg$GraphicSVG$mirrorX($author$project$Main$pufferfish))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-60, -50),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
						5 * $elm$core$Basics$sin(1 * model.time),
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$scale,
							0.7 + (0.2 * $elm$core$Basics$sin(1.5 * model.time)),
							A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$scale,
								0.25,
								$author$project$Main$movingStarfish(model))))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(
						0,
						(7 * $elm$core$Basics$sin(model.time)) * 0.5),
					$MacCASOutreach$graphicsvg$GraphicSVG$group(
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$scale,
								1.7,
								A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$move,
									_Utils_Tuple2(-10, 16),
									A5(
										$author$project$Main$multiBubbleRight,
										$MacCASOutreach$graphicsvg$GraphicSVG$black,
										$author$project$Main$failedEndScript,
										42,
										$author$project$Main$Mermaid,
										A4($author$project$Main$repeatDistance, 1, 20, 1, model.time)))),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$move,
								_Utils_Tuple2(120, -17),
								A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$scale,
									0.8,
									$author$project$Main$finalSadMermaid(model)))
							]))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(0, -40),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$scale,
						0.5,
						A2($author$project$Main$shell, 'Yes Please!', $author$project$Main$End2ToWelcome))),
					(scriptTime > 85) ? A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$notifyTap,
					$author$project$Main$Restart2end,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(80, 55),
						$author$project$Main$restartButton(model.time))) : $MacCASOutreach$graphicsvg$GraphicSVG$group(_List_Nil)
				]);
		case 'Scene4':
			var scriptTime = $author$project$Main$debugSpeedup * (model.time - model.startTime);
			var pixar4twoScript = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Pixar, 'Good job guys! I think we'),
					_Utils_Tuple2($author$project$Main$Pixar, 'can put them together now.')
				]);
			var pixar4threeScript = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Pixar, 'Oh no! These figures'),
					_Utils_Tuple2($author$project$Main$Pixar, 'are all different sizes and they'),
					_Utils_Tuple2($author$project$Main$Pixar, 'don\'t look like they\'re hugging.')
				]);
			var pixar4fourScript = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Pixar, 'Yeah! Why don\'t we each make'),
					_Utils_Tuple2($author$project$Main$Pixar, 'check in often and at the'),
					_Utils_Tuple2($author$project$Main$Pixar, 'end, we should work together'),
					_Utils_Tuple2($author$project$Main$Pixar, 'to combine the three of them.')
				]);
			var pixar4Script = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Pixar, 'Hmm, I guess that works too.')
				]);
			var or4Script = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Or, 'Oh my gosh,'),
					_Utils_Tuple2($author$project$Main$Or, '5 YEARS?!'),
					_Utils_Tuple2($author$project$Main$Or, 'Yay!'),
					_Utils_Tuple2($author$project$Main$Or, 'That sounds'),
					_Utils_Tuple2($author$project$Main$Or, 'so exciting!'),
					_Utils_Tuple2($author$project$Main$Or, 'We\'re going to'),
					_Utils_Tuple2($author$project$Main$Or, 'have the best '),
					_Utils_Tuple2($author$project$Main$Or, 'time ever!!'),
					_Utils_Tuple2($author$project$Main$Or, '')
				]);
			var mermaid4twoScript = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Nar, '*After they\'re put together*')
				]);
			var mermaid4threeScript = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Mermaid, 'What do you think'),
					_Utils_Tuple2($author$project$Main$Mermaid, 'about that, Cloonie?')
				]);
			var mermaid4Script = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Nar, '30 minutes later')
				]);
			var either4Script = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Either, 'Just put'),
					_Utils_Tuple2($author$project$Main$Either, 'them besides'),
					_Utils_Tuple2($author$project$Main$Either, 'each other.'),
					_Utils_Tuple2($author$project$Main$Either, 'They don\'t'),
					_Utils_Tuple2($author$project$Main$Either, 'need to be'),
					_Utils_Tuple2($author$project$Main$Either, 'hugging each'),
					_Utils_Tuple2($author$project$Main$Either, 'other, anyways.'),
					_Utils_Tuple2($author$project$Main$Either, '*All three put'),
					_Utils_Tuple2($author$project$Main$Either, 'the statues'),
					_Utils_Tuple2($author$project$Main$Either, 'beside each'),
					_Utils_Tuple2($author$project$Main$Either, 'other*'),
					_Utils_Tuple2($author$project$Main$Either, 'Ugh,'),
					_Utils_Tuple2($author$project$Main$Either, 'this was'),
					_Utils_Tuple2($author$project$Main$Either, 'the most'),
					_Utils_Tuple2($author$project$Main$Either, 'boring day'),
					_Utils_Tuple2($author$project$Main$Either, 'of my life!'),
					_Utils_Tuple2($author$project$Main$Either, ''),
					_Utils_Tuple2($author$project$Main$Either, '')
				]);
			var cody4Script = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Cody, 'we try building three friends'),
					_Utils_Tuple2($author$project$Main$Cody, 'hugging each other?')
				]);
			var scene4Script = _Utils_ap(
				pixar4Script,
				_Utils_ap(
					mermaid4Script,
					_Utils_ap(
						pixar4twoScript,
						_Utils_ap(
							mermaid4twoScript,
							_Utils_ap(
								pixar4threeScript,
								_Utils_ap(
									cody4Script,
									_Utils_ap(
										pixar4fourScript,
										_Utils_ap(
											mermaid4threeScript,
											_Utils_ap(either4Script, or4Script)))))))));
			return _List_fromArray(
				[
					A3(
					$author$project$Main$backgroundElements,
					0.8,
					function (input) {
						return A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$filled,
							$MacCASOutreach$graphicsvg$GraphicSVG$purple,
							$MacCASOutreach$graphicsvg$GraphicSVG$circle(5));
					},
					model),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(78, 48),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$scale,
						0.75,
						$MacCASOutreach$graphicsvg$GraphicSVG$mirrorX($author$project$Main$pufferfish))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-68, -3),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$scale,
						0.5,
						$author$project$Main$parrotFish(model))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-8, 25),
					A5($author$project$Main$multiBubbleLeft, $MacCASOutreach$graphicsvg$GraphicSVG$black, scene4Script, 46, $author$project$Main$Pixar, scriptTime)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-10, -8),
					A2($author$project$Main$cody, model, $MacCASOutreach$graphicsvg$GraphicSVG$orange)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-50, 25),
					A5($author$project$Main$multiBubbleRight, $MacCASOutreach$graphicsvg$GraphicSVG$black, scene4Script, 42, $author$project$Main$Cody, scriptTime)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(
						0,
						(10 * $elm$core$Basics$sin(model.time)) * 0.5),
					$MacCASOutreach$graphicsvg$GraphicSVG$group(
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$scale,
								1,
								A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$move,
									_Utils_Tuple2(0, 35),
									A5($author$project$Main$multiBubbleRight, $MacCASOutreach$graphicsvg$GraphicSVG$black, scene4Script, 48, $author$project$Main$Mermaid, scriptTime))),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$move,
								_Utils_Tuple2(120, -17),
								A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$scale,
									0.8,
									$author$project$Main$finalMermaid(model)))
							]))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$scale,
					0.5,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(-130, -80),
						A2($author$project$Main$shell, 'Either say:', $author$project$Main$T4toend))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-68, -40),
					$MacCASOutreach$graphicsvg$GraphicSVG$group(
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$move,
								_Utils_Tuple2(47, 0),
								A5($author$project$Main$multiBubbleLeft, $author$project$Main$textBlue, scene4Script, 20, $author$project$Main$Either, scriptTime))
							]))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$scale,
					0.5,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(60, -80),
						A2($author$project$Main$shell, 'or say:', $author$project$Main$T4to4half))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(30, -40),
					$MacCASOutreach$graphicsvg$GraphicSVG$group(
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$move,
								_Utils_Tuple2(47, 0),
								A5($author$project$Main$multiBubbleLeft, $author$project$Main$textBlue, scene4Script, 20, $author$project$Main$Or, scriptTime))
							]))),
					(scriptTime > 85) ? A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$notifyTap,
					$author$project$Main$Restart4,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(80, 55),
						$author$project$Main$restartButton(model.time))) : $MacCASOutreach$graphicsvg$GraphicSVG$group(_List_Nil)
				]);
		case 'Scene5':
			var scriptTime = $author$project$Main$debugSpeedup * (model.time - model.startTime);
			var pixar5twoScript = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Pixar, 'Whoaaaaa! Look!')
				]);
			var pixar5Script = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Pixar, 'Good job guys!'),
					_Utils_Tuple2($author$project$Main$Pixar, 'I think we can put'),
					_Utils_Tuple2($author$project$Main$Pixar, 'them together now!')
				]);
			var mermaid5twoScript = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Mermaid, 'The three friends starts putting'),
					_Utils_Tuple2($author$project$Main$Mermaid, 'them together')
				]);
			var mermaid5Script = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Mermaid, 'And so, each of the three friends'),
					_Utils_Tuple2($author$project$Main$Mermaid, 'starts building a statue of'),
					_Utils_Tuple2($author$project$Main$Mermaid, 'themselves out of seashells,'),
					_Utils_Tuple2($author$project$Main$Mermaid, 'making sure to check-in'),
					_Utils_Tuple2($author$project$Main$Mermaid, 'with each other often.'),
					_Utils_Tuple2($author$project$Main$Mermaid, '1 hour later...')
				]);
			var either5Script = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Either, 'Woohoo!!'),
					_Utils_Tuple2($author$project$Main$Either, 'This looks'),
					_Utils_Tuple2($author$project$Main$Either, 'so good!'),
					_Utils_Tuple2($author$project$Main$Either, 'I\'m so happy'),
					_Utils_Tuple2($author$project$Main$Either, 'that we'),
					_Utils_Tuple2($author$project$Main$Either, 'were able'),
					_Utils_Tuple2($author$project$Main$Either, 'to work'),
					_Utils_Tuple2($author$project$Main$Either, 'together,'),
					_Utils_Tuple2($author$project$Main$Either, 'this was'),
					_Utils_Tuple2($author$project$Main$Either, 'the best'),
					_Utils_Tuple2($author$project$Main$Either, 'day of'),
					_Utils_Tuple2($author$project$Main$Either, 'my life!'),
					_Utils_Tuple2($author$project$Main$Either, ''),
					_Utils_Tuple2($author$project$Main$Either, '')
				]);
			var cody5Script = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Cody, 'That looks amazing!'),
					_Utils_Tuple2($author$project$Main$Cody, 'Let\'s place it at the'),
					_Utils_Tuple2($author$project$Main$Cody, 'center of our three houses!'),
					_Utils_Tuple2($author$project$Main$Cody, 'It was such a good idea'),
					_Utils_Tuple2($author$project$Main$Cody, 'to make it out of sand instead'),
					_Utils_Tuple2($author$project$Main$Cody, 'too!!!')
				]);
			var scene5Script = _Utils_ap(
				mermaid5Script,
				_Utils_ap(
					pixar5Script,
					_Utils_ap(
						mermaid5twoScript,
						_Utils_ap(
							pixar5twoScript,
							_Utils_ap(cody5Script, either5Script)))));
			return _List_fromArray(
				[
					A3(
					$author$project$Main$backgroundElements,
					1.05,
					function (input) {
						return A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$filled,
							$MacCASOutreach$graphicsvg$GraphicSVG$black,
							$MacCASOutreach$graphicsvg$GraphicSVG$circle(5));
					},
					model),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(30, -30),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$scale,
						0.5,
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$move,
							_Utils_Tuple2(0, 10),
							$author$project$Main$pufferfishS))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(30, -30),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$scale,
						0.5,
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$move,
							_Utils_Tuple2(-20, -20),
							A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$scale,
								0.6,
								$author$project$Main$parrotFishS(
									{time: 0}))))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(30, -30),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$scale,
						0.5,
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$move,
							_Utils_Tuple2(80, -35),
							$MacCASOutreach$graphicsvg$GraphicSVG$mirrorX(
								A2(
									$author$project$Main$codyS,
									{time: 0},
									$MacCASOutreach$graphicsvg$GraphicSVG$purple))))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(78, 48),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$scale,
						0.75,
						$MacCASOutreach$graphicsvg$GraphicSVG$mirrorX($author$project$Main$pufferfish))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-68, -3),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$scale,
						0.5,
						$author$project$Main$parrotFish(model))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-8, 25),
					A5($author$project$Main$multiBubbleLeft, $MacCASOutreach$graphicsvg$GraphicSVG$black, scene5Script, 46, $author$project$Main$Pixar, scriptTime)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-10, -8),
					A2($author$project$Main$cody, model, $MacCASOutreach$graphicsvg$GraphicSVG$orange)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-50, 25),
					A5($author$project$Main$multiBubbleRight, $MacCASOutreach$graphicsvg$GraphicSVG$black, scene5Script, 42, $author$project$Main$Cody, scriptTime)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(
						0,
						(10 * $elm$core$Basics$sin(model.time)) * 0.5),
					$MacCASOutreach$graphicsvg$GraphicSVG$group(
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$scale,
								1,
								A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$move,
									_Utils_Tuple2(0, 35),
									A5($author$project$Main$multiBubbleRight, $MacCASOutreach$graphicsvg$GraphicSVG$black, scene5Script, 48, $author$project$Main$Mermaid, scriptTime))),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$move,
								_Utils_Tuple2(120, -17),
								A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$scale,
									0.8,
									$author$project$Main$finalMermaid(model)))
							]))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$scale,
					0.5,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(-30, -80),
						A2($author$project$Main$shell, 'Let\'s Party!', $author$project$Main$T5toFINALend))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-20, -40),
					$MacCASOutreach$graphicsvg$GraphicSVG$group(
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$move,
								_Utils_Tuple2(47, 0),
								A5($author$project$Main$multiBubbleLeft, $author$project$Main$textBlue, scene5Script, 20, $author$project$Main$Either, scriptTime))
							]))),
					(scriptTime > 85) ? A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$notifyTap,
					$author$project$Main$Restart5,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(80, 55),
						$author$project$Main$restartButton(model.time))) : $MacCASOutreach$graphicsvg$GraphicSVG$group(_List_Nil)
				]);
		case 'Scene4End':
			var scriptTime = $author$project$Main$debugSpeedup * (model.time - model.startTime);
			var scene4EndScript = _List_fromArray(
				[$author$project$Main$failedEndScript]);
			return _List_fromArray(
				[
					A3(
					$author$project$Main$backgroundElements,
					1.05,
					function (input) {
						return A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$filled,
							$MacCASOutreach$graphicsvg$GraphicSVG$brown,
							$MacCASOutreach$graphicsvg$GraphicSVG$circle(5));
					},
					model),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(78, 48),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$scale,
						0.75,
						$MacCASOutreach$graphicsvg$GraphicSVG$mirrorX($author$project$Main$pufferfish))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-60, -50),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
						5 * $elm$core$Basics$sin(1 * model.time),
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$scale,
							0.7 + (0.2 * $elm$core$Basics$sin(1.5 * model.time)),
							A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$scale,
								0.25,
								$author$project$Main$movingStarfish(model))))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(
						0,
						(4 * $elm$core$Basics$sin(model.time)) * 0.5),
					$MacCASOutreach$graphicsvg$GraphicSVG$group(
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$scale,
								1.7,
								A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$move,
									_Utils_Tuple2(-10, 16),
									A5(
										$author$project$Main$multiBubbleRight,
										$MacCASOutreach$graphicsvg$GraphicSVG$black,
										$author$project$Main$failedEndScript,
										42,
										$author$project$Main$Mermaid,
										A4($author$project$Main$repeatDistance, 1, 20, 1, model.time)))),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$move,
								_Utils_Tuple2(120, -17),
								A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$scale,
									0.8,
									$author$project$Main$finalSadMermaid(
										{time: model.time * 0.25})))
							]))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(0, -40),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$scale,
						0.5,
						A2($author$project$Main$shell, 'Yes Please!', $author$project$Main$End4ToWelcome))),
					(scriptTime > 85) ? A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$notifyTap,
					$author$project$Main$Restart4end,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(80, 55),
						$author$project$Main$restartButton(model.time))) : $MacCASOutreach$graphicsvg$GraphicSVG$group(_List_Nil)
				]);
		case 'Scene4half':
			var scriptTime = $author$project$Main$debugSpeedup * (model.time - model.startTime);
			var pixar4halfScript = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Pixar, 'That\'s fine, Cloonie.'),
					_Utils_Tuple2($author$project$Main$Pixar, 'Thank you for your apology.'),
					_Utils_Tuple2($author$project$Main$Pixar, 'Alright there\'s still time'),
					_Utils_Tuple2($author$project$Main$Pixar, 'before night, let\'s do this!!')
				]);
			var scene4halfScript = pixar4halfScript;
			return _List_fromArray(
				[
					A3(
					$author$project$Main$backgroundElements,
					1,
					function (input) {
						return A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$filled,
							$MacCASOutreach$graphicsvg$GraphicSVG$green,
							$MacCASOutreach$graphicsvg$GraphicSVG$circle(5));
					},
					model),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(78, 48),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$scale,
						0.75,
						$MacCASOutreach$graphicsvg$GraphicSVG$mirrorX($author$project$Main$pufferfish))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-68, -3),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$scale,
						0.5,
						$author$project$Main$parrotFish(model))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-8, 25),
					A5($author$project$Main$multiBubbleLeft, $MacCASOutreach$graphicsvg$GraphicSVG$black, scene4halfScript, 46, $author$project$Main$Pixar, scriptTime)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-10, -8),
					A2($author$project$Main$cody, model, $MacCASOutreach$graphicsvg$GraphicSVG$orange)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(
						0,
						(10 * $elm$core$Basics$sin(model.time)) * 0.5),
					$MacCASOutreach$graphicsvg$GraphicSVG$group(
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$scale,
								1,
								A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$move,
									_Utils_Tuple2(0, 35),
									A5($author$project$Main$multiBubbleRight, $MacCASOutreach$graphicsvg$GraphicSVG$black, scene4halfScript, 48, $author$project$Main$Mermaid, scriptTime))),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$move,
								_Utils_Tuple2(120, -17),
								A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$scale,
									0.8,
									$author$project$Main$finalMermaid(model)))
							]))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(0, -40),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$scale,
						0.5,
						A2($author$project$Main$shell, 'Let\'s Go!', $author$project$Main$T4halfto5))),
					(scriptTime > 85) ? A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$notifyTap,
					$author$project$Main$Restart4half,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(80, 55),
						$author$project$Main$restartButton(model.time))) : $MacCASOutreach$graphicsvg$GraphicSVG$group(_List_Nil)
				]);
		default:
			var scriptTime = $author$project$Main$debugSpeedup * (model.time - model.startTime);
			var sceneEndScript = _List_fromArray(
				[
					_Utils_Tuple2($author$project$Main$Mermaid, 'Whew, thanks Cloonie!'),
					_Utils_Tuple2($author$project$Main$Mermaid, 'You saved the friendship!'),
					_Utils_Tuple2($author$project$Main$Mermaid, 'Congratulations! You won the game!'),
					_Utils_Tuple2($author$project$Main$Mermaid, '...AND learned social-emotional learning?!?!'),
					_Utils_Tuple2($author$project$Main$Mermaid, 'Wow... you\'re so impressive!!')
				]);
			return _List_fromArray(
				[
					A3(
					$author$project$Main$backgroundElements,
					1,
					function (input) {
						return A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$filled,
							$MacCASOutreach$graphicsvg$GraphicSVG$darkGreen,
							$MacCASOutreach$graphicsvg$GraphicSVG$circle(5));
					},
					model),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(78, 48),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$scale,
						0.75,
						$MacCASOutreach$graphicsvg$GraphicSVG$mirrorX($author$project$Main$pufferfish))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(73, 58),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
						$elm$core$Basics$degrees(30),
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$scale,
							0.1,
							A6($author$project$Main$partyHat, $MacCASOutreach$graphicsvg$GraphicSVG$pink, $MacCASOutreach$graphicsvg$GraphicSVG$lightRed, $MacCASOutreach$graphicsvg$GraphicSVG$yellow, $MacCASOutreach$graphicsvg$GraphicSVG$green, $MacCASOutreach$graphicsvg$GraphicSVG$lightBlue, $MacCASOutreach$graphicsvg$GraphicSVG$blue)))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-68, -3),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$scale,
						0.5,
						$author$project$Main$parrotFish(model))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-50, 10),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$scale,
						0.2,
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
							$elm$core$Basics$degrees(-10),
							A6($author$project$Main$partyHat, $MacCASOutreach$graphicsvg$GraphicSVG$pink, $MacCASOutreach$graphicsvg$GraphicSVG$lightRed, $MacCASOutreach$graphicsvg$GraphicSVG$yellow, $MacCASOutreach$graphicsvg$GraphicSVG$green, $MacCASOutreach$graphicsvg$GraphicSVG$lightBlue, $MacCASOutreach$graphicsvg$GraphicSVG$blue)))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-10, -8),
					A2($author$project$Main$cody, model, $MacCASOutreach$graphicsvg$GraphicSVG$orange)),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(0, 14),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$scale,
						0.2,
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
							$elm$core$Basics$degrees(10),
							A6($author$project$Main$partyHat, $MacCASOutreach$graphicsvg$GraphicSVG$pink, $MacCASOutreach$graphicsvg$GraphicSVG$lightRed, $MacCASOutreach$graphicsvg$GraphicSVG$yellow, $MacCASOutreach$graphicsvg$GraphicSVG$green, $MacCASOutreach$graphicsvg$GraphicSVG$lightBlue, $MacCASOutreach$graphicsvg$GraphicSVG$blue)))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(
						0,
						(10 * $elm$core$Basics$sin(model.time)) * 0.5),
					$MacCASOutreach$graphicsvg$GraphicSVG$group(
						_List_fromArray(
							[
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$scale,
								1,
								A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$move,
									_Utils_Tuple2(0, 35),
									A5($author$project$Main$multiBubbleRight, $MacCASOutreach$graphicsvg$GraphicSVG$black, sceneEndScript, 48, $author$project$Main$Mermaid, scriptTime))),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$move,
								_Utils_Tuple2(120, -17),
								A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$scale,
									0.8,
									$author$project$Main$finalMermaid(model))),
								A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$move,
								_Utils_Tuple2(75, 25),
								A2(
									$MacCASOutreach$graphicsvg$GraphicSVG$scale,
									0.2,
									A6($author$project$Main$partyHat, $MacCASOutreach$graphicsvg$GraphicSVG$pink, $MacCASOutreach$graphicsvg$GraphicSVG$lightRed, $MacCASOutreach$graphicsvg$GraphicSVG$yellow, $MacCASOutreach$graphicsvg$GraphicSVG$green, $MacCASOutreach$graphicsvg$GraphicSVG$lightBlue, $MacCASOutreach$graphicsvg$GraphicSVG$blue)))
							]))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(-60, -50),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$rotate,
						5 * $elm$core$Basics$sin(1 * model.time),
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$scale,
							0.7 + (0.2 * $elm$core$Basics$sin(1.5 * model.time)),
							A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$scale,
								0.25,
								$author$project$Main$movingStarfish(model))))),
					A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$move,
					_Utils_Tuple2(
						A4($author$project$Main$repeatDistance, 5, -500, 100, -model.time),
						20),
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(
							0,
							(30 * $elm$core$Basics$cos(model.time)) * 0.3),
						A2(
							$MacCASOutreach$graphicsvg$GraphicSVG$move,
							_Utils_Tuple2(30, -10),
							A2(
								$MacCASOutreach$graphicsvg$GraphicSVG$scale,
								0.5,
								$author$project$Main$jellyfish(
									A3(
										$MacCASOutreach$graphicsvg$GraphicSVG$hsl,
										$elm$core$Basics$degrees(30) * model.time,
										1,
										0.5)))))),
					(scriptTime > 85) ? A2(
					$MacCASOutreach$graphicsvg$GraphicSVG$notifyTap,
					$author$project$Main$Restartend,
					A2(
						$MacCASOutreach$graphicsvg$GraphicSVG$move,
						_Utils_Tuple2(80, 55),
						$author$project$Main$restartButton(model.time))) : $MacCASOutreach$graphicsvg$GraphicSVG$group(_List_Nil)
				]);
	}
};
var $author$project$Main$view = function (model) {
	return A3(
		$MacCASOutreach$graphicsvg$GraphicSVG$collage,
		192,
		128,
		$author$project$Main$myShapes(model));
};
var $author$project$Main$main = A2(
	$MacCASOutreach$graphicsvg$GraphicSVG$App$gameApp,
	$author$project$Main$Tick,
	{model: $author$project$Main$init, title: 'Game Slot', update: $author$project$Main$update, view: $author$project$Main$view});
_Platform_export({'Main':{'init':$author$project$Main$main(
	$elm$json$Json$Decode$succeed(_Utils_Tuple0))(0)}});}(this));