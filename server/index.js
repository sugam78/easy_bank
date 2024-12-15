const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth.js");

const app = express();
const PORT = 3000;
const DB = "mongodb+srv://paudelsugam9:sugam123@cluster0.d23pu.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";


app.use(express.json());
app.use(authRouter);


mongoose.connect(DB).then(()=>{
console.log("Connection Success");
}).catch((e)=>{
console.log(e);
});

app.listen(PORT,"0.0.0.0",()=>{
console.log(`connected to port ${PORT}`);
});