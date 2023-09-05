const express = require('express');
const AuthService = require('../services/auth_service');
const jwt= require('jsonwebtoken');
const User= require('../models/user');
const bcryptjs= require('bcryptjs');

exports.signup = async (req, res, next) => {
    try{
        const {name, email, password, membership} = req.body;

        const existingUser = await AuthService.findUserByEmail(email);
        if(existingUser){
            return res.status(400).json({message: "User already exists"});
        }
        const hashedPassword= await bcryptjs.hash(password, 10);

        const response= await AuthService.signup(name, email, hashedPassword, membership);
        res.json(response);
    }catch(err){
        return res.status(500).json({message:err});
    }
}

exports.signin = async (req, res, next) => {
    try{
        const {email, password} = req.body;

        const user= await AuthService.findUserByEmail(email);
        if(!user){
            return res.status(400).json({message: "User not found"});
        }
        const isMatch= await bcryptjs.compare(password, user.password);

        if(!isMatch){
            return res.status(400).json({message: "Incorrect password"});
        }
        const token= await AuthService.generateAccessToken(user,"passwordKey");
        console.log(typeof({token, ...user._doc}['token']));
        
        res.json({token, ...user._doc});
    } catch(err){
        res.status(500).json({message: err.message});
    }
}

exports.tokenIsValid = async (req, res, next) => {
    try{
        const token= req.header("x-auth-token");
        if(!token)
            return res.json(false);
        const verified = jwt.verify(token, "passwordKey");
        if(!verified)
            return res.json(false);
        console.log("token is valid");
        const user= await User.findById(verified.id);
        console.log("checking user",user);
        if(!user)
            return res.json(false);
        console.log("user is valid");
        return res.json(true);
    } catch(err){
        res.status(500).json({message: "error in token validation"});
    }
}

exports.getData= async (req, res, next) => {
    try{
        const token = req.header("x-auth-token");
        if(!token){
            return res.status(401).json({message: "No authentication token, access denied"});
        }
        const verified = jwt.verify(token, "passwordKey");
        console.log("token verifying");
        if(!verified){
            return res.status(401).json({message: "Token verification failed, authorization denied"});
        }
        console.log("token verified");
        req.user= verified.id;
        req.token= token;
        next();
    } catch(err) {
        console.log('------------------',err);
        next(err);
    }
}