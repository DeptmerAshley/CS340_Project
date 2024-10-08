/*
    SETUP
*/
var express = require('express');   // We are using the express library for the web server
var app = express();            // We need to instantiate an express object to interact with the server in our code
PORT        = 3656;                 // Set a port number at the top so it's easy to change in the future

const { engine } = require('express-handlebars');
var exphbs = require('express-handlebars');     // Import express-handlebars
app.engine('.hbs', engine({extname: ".hbs"}));  // Create an instance of the handlebars engine to process templates
app.set('view engine', '.hbs');                 // Tell express to use the handlebars engine whenever it encounters a *.hbs file.

var db = require('./database/db-connector'); //database

app.use(express.json());
app.use(express.urlencoded({extended: true}));
app.use(express.static(__dirname + '/public')); 



/*
    ROUTES
*/

app.get('/', function(req, res)
{
    
    let query1 = "SELECT * FROM Coaches";

    db.pool.query(query1, function(error, rows, fields){

        let coaches = rows;
        res.render('index', {data:rows});
    })

});

app.get('/Coaches', function(req, res)
{
    
    let query1 = "SELECT * FROM Coaches";

    db.pool.query(query1, function(error, rows, fields){

        let coaches = rows;
        res.render('Coaches', {data:rows});
    })

});

app.get('/players', function(req, res)
{
    
    let query1 = "SELECT * FROM Players";

    db.pool.query(query1, function(error, rows, fields){

        let players = rows;
        res.render('players', {data:rows});
    })

});

app.post('/add-coach-form', function(req, res){

    let data = req.body;

    let query1 = `INSERT INTO Coaches(name, email, trainingComplete) VALUES ('${data['input-name']}', '${data['input-email']}' , '${data['input-training']}')`;
    db.pool.query(query1, function(error, rows, fields){

        if (error) {

            console.log(error);
            res.sendStatus(400);
        }
        else
        {
            let query2 = `SELECT * FROM Coaches;`;
            db.pool.query(query2, function(error, rows, fields){

                if (error) {
        
                    console.log(error)
                    res.sendStatus(400);
                }
                else
                {
                    res.redirect('/');
                }
            })
        }
    })
});

app.post('/add-coach-ajax', function(req, res) 
{
    // Capture the incoming data and parse it back to a JS object
    let data = req.body;


    // Create the query and run it on the database
    query1 = `INSERT INTO Coaches (name, email, trainingComplete) VALUES ('${data.name}', '${data.email}', ${data.trainingComplete})`;
    db.pool.query(query1, function(error, rows, fields){

        // Check to see if there was an error
        if (error) {

            // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error)
            res.sendStatus(400);
        }
        else
        {
            // If there was no error, perform a SELECT * on Coaches
            query2 = `SELECT * FROM Coaches;`;
            db.pool.query(query2, function(error, rows, fields){

                // If there was an error on the second query, send a 400
                if (error) {
                    
                    // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
                    console.log(error);
                    res.sendStatus(400);
                }
                // If all went well, send the results of the query back.
                else
                {
                    res.send(rows);
                }
            })
        }
    })
});


app.delete('/delete-coach-ajax/', function(req,res,next){
    let data = req.body;
    let coachID = parseInt(data.coachID);
    let deleteTeamCoachID = `DELETE FROM Teams WHERE coachID = ?`;
    let deleteCoaches = `DELETE FROM Coaches WHERE coachID = ?`;

        db.pool.query(deleteTeamCoachID, [coachID], function(error, rows, fields){

            if (error) {
                console.log(error);
                res.sendStatus(400);
            }
            else
            {
                db.pool.query(deleteCoaches, [coachID], function(error, rows, fields){

                    if (error) {
                        console.log(error);
                        res.sendStatus(400);
                    }
                    else 
                    {
                        res.sendStatus(204);
                    }
                })
            }
        })
});


app.post('/add-player-form', function(req, res){

    let data = req.body;

    let query1 = `INSERT INTO Players(name, email, birthday) VALUES ('${data['input-name']}', '${data['input-email']}' , '${data['input-birthday']}')`;
    db.pool.query(query1, function(error, rows, fields){

        if (error) {

            console.log(error);
            res.sendStatus(400);
        }
        else
        {
            let query2 = `SELECT * FROM Players;`;
            db.pool.query(query2, function(error, rows, fields){

                if (error) {
        
                    console.log(error)
                    res.sendStatus(400);
                }
                else
                {
                    res.redirect('/players');
                }
            })
        }
    })
});

app.post('/add-player-ajax', function(req, res) 
{
    // Capture the incoming data and parse it back to a JS object
    let data = req.body;


    // Create the query and run it on the database
    query1 = `INSERT INTO Players (name, email, birthday) VALUES ('${data.name}', '${data.email}', ${data.birthday})`;
    db.pool.query(query1, function(error, rows, fields){

        // Check to see if there was an error
        if (error) {

            // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error)
            res.sendStatus(400);
        }
        else
        {
            // If there was no error, perform a SELECT * on Coaches
            query2 = `SELECT * FROM Players;`;
            db.pool.query(query2, function(error, rows, fields){

                // If there was an error on the second query, send a 400
                if (error) {
                    
                    // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
                    console.log(error);
                    res.sendStatus(400);
                }
                // If all went well, send the results of the query back.
                else
                {
                    res.send(rows);
                }
            })
        }
    })
});

/*
    LISTENER
*/
app.listen(PORT, function(){            // This is the basic syntax for what is called the 'listener' which receives incoming requests on the specified PORT.
    console.log('Express started on http://localhost:' + PORT + '; press Ctrl-C to terminate.')
});