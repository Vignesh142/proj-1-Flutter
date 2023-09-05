// imports from packages
const express= require("express");
const mongoose= require("mongoose");

//imports from other files
const authRouter= require("./routes/auth");

const PORT = 3000;
const app = express();
const DB= "mongodb+srv://new-user19:newuser19.@cluster0.haacszw.mongodb.net/?retryWrites=true&w=majority"

//middleware
//Client -> Middleware ->SERVER -> Client
app.use(express.json());
app.use(authRouter);
app.use((err, req, res, next) => {
    console.log('----------------------',err);
    res.status(500).json({message: err.message});
});

//Connections
mongoose.connect(DB).then(() => {
    console.log("Connected to the database ...");
}).catch((err) => {
    console.log(err);
});

app.listen(PORT,"0.0.0.0",() => {
    console.log(`Server is listening on port ${PORT} ...`);
});