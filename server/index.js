// import the express module and the authRouter from the ./routes/auth file
const express = require("express");
const mongoose = require("mongoose");
const authRouter= require("./routes/auth");
const adminRouter = require("./routes/admin");

// set the port number to 3000
const PORT = 3000;

// create an instance of the express application
 
const app = express();

const db = 'mongodb+srv://sanjayrana070:evWRW7djoeOqlTBM@cluster0.cswkwrl.mongodb.net/?retryWrites=true&w=majority'

// use the authRouter middleware for all routes
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);

//Connection
mongoose.connect(db).then(function() {
	console.log("Connection established");


})
.catch(function(err) {
	console.log("Connection error")
})

// define a GET route for "/hello-world" that sends a JSON object with the name "sanjay"
app.get("/hello-world", function(req,res){
    res.send({name:"sanjay"});
})

// start listening on the specified port and log a message to the console
app.listen(PORT,'0.0.0.0',()=> {
    console.log (`connected to the port ${PORT}`);
});
