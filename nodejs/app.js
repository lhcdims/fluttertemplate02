// vars
var gbolDebug = true;
var aryClients = [];
var fs = require('fs');

// Date Related
//var dateTime = require('node-datetime');
//var dt = dateTime.create();
//dt.format('YYYY-MM-DD HH:mm:ss');

Date.prototype.Format = function (fmt) { //author: meizz
    var o = {
        "M+": this.getMonth() + 1, //月份
        "d+": this.getDate(), //日
        "h+": this.getHours(), //小时
        "m+": this.getMinutes(), //分
        "s+": this.getSeconds(), //秒
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度
        "S": this.getMilliseconds() //毫秒
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length === 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
};


// Console Related
function funUpdateConsole(msg, bolDebugOnly) {
    var bolShouldShow = false;
    try {
        if (bolDebugOnly) {
            if (gbolDebug) {
                bolShouldShow = true;
            }
        } else {
            bolShouldShow = true;
        }
        if (bolShouldShow) {
            var strTempDate = new Date().Format("yyyy-MM-dd hh:mm:ss");
            console.log(strTempDate + " : " + msg);
        }
    } catch (err) {
        console.log(err.message);
    }
}



// The new method use connection pool, which connection(s) will be created automatically when needed
var mysql = require('mysql');
var pool = mysql.createPool({
    connectionLimit: 10,
    host: "localhost",
    user: "root",
    password: "zephan915",
    database: "ken068802"
});





// Socket.IO Server for Server Monitor to connect
var appServer = require('express')();
var httpServer = require('http').Server(appServer);
var ioServer = require('socket.io')(httpServer);

appServer.get('/', function (req, res) {
    res.sendFile(__dirname + '/server.html');
});

ioServer.on('connection', function (socket) {
    funUpdateConsole('ken068802 WebServer Monitor Initialized', false);
    socket.on('disconnect', function () {
        funUpdateConsole('ken068802 WebServer Monitor Disconnected', false);
    });
});

httpServer.listen(10502, function () {
    funUpdateConsole('ken068802 WebServer Monitor listening on *:10502', false);
});

function funUpdateServerMonitor(strMsg, bolDebugOnly) {
    var bolShouldShow = false;
    try {
        if (bolDebugOnly) {
            if (gbolDebug) {
                bolShouldShow = true;
            }
        } else {
            bolShouldShow = true;
        }
        if (bolShouldShow) {
            var strTempDate = new Date().Format("yyyy-MM-dd hh:mm:ss");
            ioServer.emit('chat message', strTempDate + " : " + strMsg);
        }
    } catch (err) {
        //
    }
}




// Socket.IO Server for Client to connect
var ioClient = require('socket.io');
var httpClient = require('http');

var serverClient = httpClient.createServer(function (req, res) {
    var headers = {};
    headers["Access-Control-Allow-Origin"] = "*";
    headers["Access-Control-Allow-Methods"] = "POST, GET, PUT, DELETE, OPTIONS";
    //    headers["Access-Control-Allow-Credentials"] = true;
    headers["Access-Control-Max-Age"] = '86400'; // 24 hours
    headers["Access-Control-Allow-Headers"] = "X-Requested-With, Access-Control-Allow-Origin, X-HTTP-Method-Override, Content-Type, Authorization, Accept";
    res.writeHead(200, headers);
    res.end();
});
serverClient.listen(10531, '');


funUpdateConsole('ThisApp Socket.IO Server running at port 10531', false);






// Core Programs



// Show Clients' List every 30 seconds
function funShowClients() {
    var i = 0;
    for (i = 0; i < aryClients.length; i++) {
        try {
            funUpdateServerMonitor("Connection Code: " + aryClients[i].connectionCode + "&nbsp;&nbsp;&nbsp;User ID: " + aryClients[i].userId, true);
        } catch (err) {
            //
        }
    }
    var dtTemp = Date.now();
    setTimeout(funShowClients, 30000);
}
funShowClients();



// Listen to socket
var socketAll = new ioClient();
socketAll.attach(serverClient);


function funTestFlutter(SocketID) {
    socketAll.to(`${SocketID}`).emit('loginget', SocketID);
}

// var socketAll = ioClient.listen(serverClient);
socketAll.on('connection', function (socket) {
    funUpdateConsole("Client Connected, Socket ID: " + socket.id, false);
    funUpdateServerMonitor("Client Connected, Socket ID: " + socket.id, false);
    socket.emit("UpdateYourSocketID", socket.id);

    setTimeout(funTestFlutter, 10000, socket.id);

    socket.on('updateClientUserId', function (userid) {
        var bolFound = false;
        for (var i = 0; i < aryClients.length; i++) {
            if (aryClients[i].connectionCode === socket.id) {
                aryClients[i].userId = userid;
                bolFound = true;
                funUpdateConsole("Update User ID: " + userid + " from Socket ID: " + socket.id, true);
            }
        }
        if (!bolFound) {
            if (userid !== "") {
                aryClients.push({ connectionCode: socket.id, userId: userid});
                funUpdateConsole("Add User ID: " + userid + " from Socket ID: " + socket.id, true);
            }
        }
        socketAll.emit("ServerUpdateUserList", aryClients);
        funUpdateConsole("ServerUpdateUserList SENT on UPDATE", true);
    });


    socket.on('removeClientUserId', function (userid) {
        for (var i = 0; i < aryClients.length; i++) {
            if (aryClients[i].connectionCode === socket.id) {
                aryClients[i].userId = "";
                funUpdateConsole("Remove User ID: " + userid + " from Socket ID: " + socket.id, true);
            }
        }
        socketAll.emit("ServerUpdateUserList", aryClients);
        funUpdateConsole("ServerUpdateUserList SENT on REMOVE", true);
    });


    socket.on('disconnect', function () {
        funUpdateConsole("Client Disconnected, Socket ID: " + socket.id, false);
        funUpdateServerMonitor("Client Disconnected, Socket ID: " + socket.id, false);
        for (var i = 0; i < aryClients.length; i++) {
            if (aryClients[i].connectionCode === socket.id) {
                aryClients.splice(i, 1);
            }
        }
        socketAll.emit("ServerUpdateUserList", aryClients);
        funUpdateConsole("ServerUpdateUserList SENT on DISCONNECT", true);
    });


    socket.on('HeartBeat', function () {
        funUpdateServerMonitor("Heart Beat from Socket ID: " + socket.id, true);
    });


    // Catch any unexpected error, to avoid system hangs
    socket.on('error', function () { });
});





// Support Functions


// Encode String to UTF-8
function utf8Encode(string) {
    string = string.replace(/\r\n/g, "\n");
    var utftext = "";
    for (var n = 0; n < string.length; n++) {
        var c = string.charCodeAt(n);
        if (c < 128) {
            utftext += String.fromCharCode(c);
        } else if ((c > 127) && (c < 2048)) {
            utftext += String.fromCharCode((c >> 6) | 192);
            utftext += String.fromCharCode((c & 63) | 128);
        } else {
            utftext += String.fromCharCode((c >> 12) | 224);
            utftext += String.fromCharCode(((c >> 6) & 63) | 128);
            utftext += String.fromCharCode((c & 63) | 128);
        }

    }
    return utftext;
}
// Decode String From UTF-8
function utf8Decode(utftext) {
    var string = "";
    var i = 0;
    var c = c1 = c2 = 0;
    while (i < utftext.length) {
        c = utftext.charCodeAt(i);
        if (c < 128) {
            string += String.fromCharCode(c);
            i++;
        } else if ((c > 191) && (c < 224)) {
            c2 = utftext.charCodeAt(i + 1);
            string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
            i += 2;
        } else {
            c2 = utftext.charCodeAt(i + 1);
            c3 = utftext.charCodeAt(i + 2);
            string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
            i += 3;
        }
    }
    return string;
}

function json_decode(str_json) {
    var json = JSON;
    if (typeof json === 'object' && typeof json.parse === 'function') {
        return json.parse(str_json);
    }

    var cx = /[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g;
    var j;
    var text = str_json;

    // Parsing happens in four stages. In the first stage, we replace certain
    // Unicode characters with escape sequences. JavaScript handles many characters
    // incorrectly, either silently deleting them, or treating them as line endings.
    cx.lastIndex = 0;
    if (cx.test(text)) {
        text = text.replace(cx, function (a) {
            return '\\u' +
                ('0000' + a.charCodeAt(0).toString(16)).slice(-4);
        });
    }

    // In the second stage, we run the text against regular expressions that look
    // for non-JSON patterns. We are especially concerned with '()' and 'new'
    // because they can cause invocation, and '=' because it can cause mutation.
    // But just to be safe, we want to reject all unexpected forms.

    // We split the second stage into 4 regexp operations in order to work around
    // crippling inefficiencies in IE's and Safari's regexp engines. First we
    // replace the JSON backslash pairs with '@' (a non-JSON character). Second, we
    // replace all simple value tokens with ']' characters. Third, we delete all
    // open brackets that follow a colon or comma or that begin the text. Finally,
    // we look to see that the remaining characters are only whitespace or ']' or
    // ',' or ':' or '{' or '}'. If that is so, then the text is safe for eval.
    if (/^[\],:{}\s]*$/.
        test(text.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g, '@').
            replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g, ']').
            replace(/(?:^|:|,)(?:\s*\[)+/g, ''))) {

        // In the third stage we use the eval function to compile the text into a
        // JavaScript structure. The '{' operator is subject to a syntactic ambiguity
        // in JavaScript: it can begin a block or an object literal. We wrap the text
        // in parens to eliminate the ambiguity.

        j = eval('(' + text + ')');

        return j;
    }

    // If the text is not JSON parseable, then a SyntaxError is thrown.
    throw new SyntaxError('json_decode');
}

function json_encode(mixed_val) {
    var json = JSON;
    if (typeof json === 'object' && typeof json.stringify === 'function') {
        return json.stringify(mixed_val);
    }

    var value = mixed_val;

    var quote = function (string) {
        var escapable = /[\\\"\u0000-\u001f\u007f-\u009f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g;
        var meta = {    // table of character substitutions
            '\b': '\\b',
            '\t': '\\t',
            '\n': '\\n',
            '\f': '\\f',
            '\r': '\\r',
            '"': '\\"',
            '\\': '\\\\'
        };

        escapable.lastIndex = 0;
        return escapable.test(string) ?
            '"' + string.replace(escapable, function (a) {
                var c = meta[a];
                return typeof c === 'string' ? c :
                    '\\u' + ('0000' + a.charCodeAt(0).toString(16)).slice(-4);
            }) + '"' :
            '"' + string + '"';
    };

    var str = function (key, holder) {
        var gap = '';
        var indent = '    ';
        var i = 0;          // The loop counter.
        var k = '';          // The member key.
        var v = '';          // The member value.
        var length = 0;
        var mind = gap;
        var partial = [];
        var value = holder[key];

        // If the value has a toJSON method, call it to obtain a replacement value.
        if (value && typeof value === 'object' &&
            typeof value.toJSON === 'function') {
            value = value.toJSON(key);
        }

        // What happens next depends on the value's type.
        switch (typeof value) {
            case 'string':
                return quote(value);

            case 'number':
                // JSON numbers must be finite. Encode non-finite numbers as null.
                return isFinite(value) ? String(value) : 'null';

            case 'boolean':
            case 'null':
                // If the value is a boolean or null, convert it to a string. Note:
                // typeof null does not produce 'null'. The case is included here in
                // the remote chance that this gets fixed someday.

                return String(value);

            case 'object':
                // If the type is 'object', we might be dealing with an object or an array or
                // null.
                // Due to a specification blunder in ECMAScript, typeof null is 'object',
                // so watch out for that case.
                if (!value) {
                    return 'null';
                }

                // Make an array to hold the partial results of stringifying this object value.
                gap += indent;
                partial = [];

                // Is the value an array?
                if (Object.prototype.toString.apply(value) === '[object Array]') {
                    // The value is an array. Stringify every element. Use null as a placeholder
                    // for non-JSON values.

                    length = value.length;
                    for (i = 0; i < length; i += 1) {
                        partial[i] = str(i, value) || 'null';
                    }

                    // Join all of the elements together, separated with commas, and wrap them in
                    // brackets.
                    v = partial.length === 0 ? '[]' :
                        gap ? '[\n' + gap +
                            partial.join(',\n' + gap) + '\n' +
                            mind + ']' :
                            '[' + partial.join(',') + ']';
                    gap = mind;
                    return v;
                }

                // Iterate through all of the keys in the object.
                for (k in value) {
                    if (Object.hasOwnProperty.call(value, k)) {
                        v = str(k, value);
                        if (v) {
                            partial.push(quote(k) + (gap ? ': ' : ':') + v);
                        }
                    }
                }

                // Join all of the member texts together, separated with commas,
                // and wrap them in braces.
                v = partial.length === 0 ? '{}' :
                    gap ? '{\n' + gap + partial.join(',\n' + gap) + '\n' +
                        mind + '}' : '{' + partial.join(',') + '}';
                gap = mind;
                return v;
        }
    };

    // Make a fake root object containing our value under the key of ''.
    // Return the result of stringifying the value.
    return str('', {
        '': value
    });
}