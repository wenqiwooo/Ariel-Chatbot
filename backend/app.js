/**
 * Module dependencies.
 */

var express = require('express'),
    routes = require('./routes'),
    user = require('./routes/user'),
    http = require('http'),
    path = require('path'),
    fs = require('fs');

var app = express();

var cloudant, db;
var dbName = "awesome_sia_backend_db";
var dbCredentials = "https://ac0a2706-e13b-4d02-8272-7ba147a045c9-bluemix:" +
                    "cf84bcace4c44bc80646fb1f6a12960c259d835a1a2829ec265df7f7787e1ed0@" +
                    "ac0a2706-e13b-4d02-8272-7ba147a045c9-bluemix.cloudant.com";

var bodyParser = require('body-parser');
var methodOverride = require('method-override');
var logger = require('morgan');
var errorHandler = require('errorhandler');
var multipart = require('connect-multiparty')
var multipartMiddleware = multipart();

// all environments
app.set('port', process.env.PORT || 3000);
app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');
app.engine('html', require('ejs').renderFile);
app.use(logger('dev'));
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(methodOverride());
app.use(express.static(path.join(__dirname, 'public')));
app.use('/style', express.static(path.join(__dirname, '/views/style')));

// development only
if ('development' == app.get('env')) {
    app.use(errorHandler());
}

function initDBConnection() {
    var Cloudant = require('cloudant');
    cloudant = Cloudant(dbCredentials, function(er, cloudant, reply) {
        if (er) { throw er; }
        console.log('Connected with username: %s', reply.userCtx.name)
    })
    // check if DB exists if not create
    cloudant.db.get(dbName, function (err, body) {
        if (!err) {
            console.log("database " + dbName + " exists");
        } else {
            cloudant.db.create(dbName, function (err, res) {
                if (!err) {
                    console.log("database " + dbName + " created!");
                }
            });
        }
    });
    db = cloudant.use(dbName);
}

initDBConnection();

var saveMessage = function(flight, seat, name, message, category, response) {
    var timestamp = (new Date()).toJSON();
    db.insert({
        flight: flight,
        seat: seat,
        name: name,
        message: message,
        category: category,
        timestamp: timestamp,
        done: "false"
    }, function(err, doc) {
        if(err) {
            response.sendStatus(500);
        } else {
            response.send(doc.id);
        }
    });
}

var doneMessage = function(doc) {
    db.insert(doc, function(err, body) {
        if(err) {
            console.log(err);
        } else {
            console.log("Done " + doc._id);
        }
    });
}

app.get('/api/test', routes.test);

app.get('/api', function(request, response) {
    response.send("Awesome SIA backend running!\n");
});

app.get('/api/requests', function(request, response) {
    var lastDate = request.query.date;
    var flight = request.query.flight;
    var id = request.query.id;
    var customSelector = {};
    var customQuery;
    if (id != undefined) {
        customSelector._id = id;
        customQuery = {
                "selector": customSelector,
                "fields": [
                           "_id", "_rev",
                           "flight",
                           "seat",
                           "name",
                           "message",
                           "category",
                           "timestamp",
                           "done"
                         ]
        }
    } else {
        if (lastDate != undefined) {
            customSelector.timestamp = {"$gt": lastDate};
        } else {
            customSelector.timestamp = {"$gt": "1970-01-01T00:00:00.000Z"};
        }
        if (flight != undefined) {
            customSelector["flight"] = flight;
        }
        customQuery = {
                "selector": customSelector,
                  "fields": [
                    "_id", "_rev",
                    "flight",
                    "seat",
                    "name",
                    "message",
                    "category",
                    "timestamp",
                    "done"
                  ],
                  "sort": [
                    {
                      "timestamp": "asc"
                    }
                  ]
        }
    }
    console.log(customQuery);
    db.find(customQuery, function(er, result) {
        if (er) {
            throw er;
        }
        console.log('Sent %d message(s)\n', result.docs.length);
//        for (var i = 0; i < result.docs.length; i++) {
//            var doc = result.docs[i];
//            console.log('Seat: %s\nMessage: %s\nCategory: %s\nTimestamp: %s\n',
//                        doc.seat, doc.message, doc.category, doc.timestamp);
//            response.write(JSON.stringify(doc));
//            if (i == result.docs.length - 1) response.end();
//        }
        response.send(JSON.stringify(result.docs));
      });
});

app.post('/api/requests', function(request, response) {
    console.log("Incoming message...");

    console.log(request.body);

    var flight = request.body.flight;
    var seat = request.body.seat;
    var name = request.body.name;
    var message = request.body.message;
    var category = request.body.category;
    saveMessage(flight, seat, name, message, category, response);

});

app.put('/api/requests', function(request, response) {
    console.log("Doing " + JSON.stringify(request.body));
    doneMessage(request.body);
});

app.get('/api/requests/done', function(request, response) {
    var id = request.query.id;
    var customSelector = {};
    var customQuery;
    if (id != undefined) {
        customSelector._id = id;
        customQuery = {
                "selector": customSelector,
                "fields": [
                           "_id", "_rev",
                           "flight",
                           "seat",
                           "name",
                           "message",
                           "category",
                           "timestamp",
                           "done"
                         ]
        }
    }
    console.log(customQuery);
    db.find(customQuery, function(er, result) {
        if (er) {
            throw er;
        }
        console.log('Sent %d message(s)\n', result.docs.length);
        if (result.docs.length == 0) {
            response.send("not found");
        } else {
            response.send(result.docs[0].done);
        }
      });
});

http.createServer(app).listen(app.get('port'), function() {
    console.log('Express server listening on port ' + app.get('port'));
});
