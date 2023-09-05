const express= require("express");
const User= require("../models/user");
const bcryptjs= require("bcryptjs");
const jwt= require("jsonwebtoken");

const AuthController= require("../controller/auth_controller");

const authRouter= express.Router();
const AuthService= require("../services/auth_service");

//SignUp
authRouter.post("/api/signup", AuthController.signup);

// SignIn route
authRouter.post('/api/signin', AuthController.signin);

// Validate token
authRouter.post('/tokenIsValid', AuthController.tokenIsValid);

//get user data
authRouter.get('/', AuthController.getData, async (req, res) => {
    try{
        console.log("in get user data");
        const user= await User.findById(req.user);
        console.log({...user._doc});
        res.status(200).json({...user._doc,token: req.token});
    } catch(err){
        res.status(500).json({error: "error in getting user data"});
    }
});

module.exports= authRouter;
