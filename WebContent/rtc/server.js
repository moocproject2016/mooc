var isUseHTTPs = !(!!process.env.PORT || !!process.env.IP);

var server = require(isUseHTTPs ? 'https' : 'http'),
    url = require('url'),
    path = require('path'),
    fs = require('fs');

function serverHandler(request, response) {
    var uri = url.parse(request.url).pathname,
        filename = path.join(process.cwd(), uri);

    var stats;

    try {
        stats = fs.lstatSync(filename);
    } catch (e) {
        response.writeHead(404, {
            'Content-Type': 'text/plain'
        });
        response.write('404 Not Found: ' + path.join('/', uri) + '\n');
        response.end();
        return;
    }
    
    if (fs.statSync(filename).isDirectory()) {
        filename += '/index.html';
        
    }

    var contentType;
    if(filename.indexOf('.html') !== -1) {
        contentType = {
            'Content-Type': 'text/html'
        };
    }


    fs.readFile(filename, 'binary', function(err, file) {
        if (err) {
            response.writeHead(500, {
                'Content-Type': 'text/plain'
            });
            response.write(err + '\n');
            response.end();
            return;
        }

        response.writeHead(200, contentType);
        response.write(file, 'binary');
        response.end();
    });
}

//페이크 개인키와 페이크 증명서를 통한 인증
var app;

if (isUseHTTPs) {
    var options = {
        key: fs.readFileSync(path.join(__dirname, 'fake-keys/privatekey.pem')),
        cert: fs.readFileSync(path.join(__dirname, 'fake-keys/certificate.pem'))
    };
    app = server.createServer(options, serverHandler);
} else app = server.createServer(serverHandler);

app = app.listen(process.env.PORT || 9001, process.env.IP || "192.168.30.100", function() {
    var addr = app.address();
    console.log("Server listening at", addr.address + ":" + addr.port);
});

//시그널 서버 세팅
require('./Signaling-Server.js')(app, function(socket) {
    try {
        var params = socket.handshake.query;
        
        if (!params.socketCustomEvent) {
            params.socketCustomEvent = 'custom-message';
        }

        socket.on(params.socketCustomEvent, function(message) {
            try {
                socket.broadcast.emit(params.socketCustomEvent, message);
            } catch (e) {}
        });
    } catch (e) {}
});
