require('dotenv').config({ path: './secrets.env' });

const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth.js");
const profileRouter = require("./routes/profile.js");
const historyRouter = require("./routes/history.js");
const transactionRouter = require("./routes/transaction.js");
const securityRouter = require("./routes/security.js");
const cronJobs = require('./cronJobs');


const admin = require("firebase-admin");
const serviceAccount = JSON.parse(process.env.FIREBASE_SERVICE_ACCOUNT);

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
})

const app = express();
const DB = process.env.DB_URI;
const PORT = 3000;

app.use(express.json());
app.use(authRouter);
app.use(profileRouter);
app.use(transactionRouter);
app.use(historyRouter);
app.use(securityRouter);
app.use((req, res, next) => {
    res.status(404).send("Endpoint not found");
});


mongoose.connect(DB).then(()=>{
    console.log("Connection Success");
    cronJobs();
}).catch((e)=>{
    console.log(e);
});

app.listen(PORT,"0.0.0.0",()=>{
    console.log(`connected to port ${PORT}`);
});