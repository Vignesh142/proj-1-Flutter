const User= require('../models/user');
const jwt= require('jsonwebtoken');

//contains all the database related logic
class AuthService{
    static async signup(name, email, password, membership){
        try{
            const newUser= new User({
                name, email, password, membership
            });
            return await newUser.save();
        }catch(err){
            console.log('------------------',err);
            throw err;
        }
    }
    static  async findUserByEmail(email){
        try{
            return await User.findOne({ email });
        } catch(err){
            console.log('------------------',err);
            throw err;
        }
    }
    
    static async generateAccessToken(user, passwordKey){ 
        const token= jwt.sign({id: user.id},passwordKey);
        return token;
    }
}

module.exports= AuthService;