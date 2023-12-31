const mongoose= require("mongoose");

const userSchema = mongoose.Schema({
    name: {
        required : true,
        type: String,
        trim: true,
    },
    email: {
        required : true,
        type: String,
        trim: true,
        // validate: {
        //     validator: (value) => {
        //         return validator.isEmail(value);
        //     },
        //     message: 'Please enter a valid email address'
        // }
    },
    password: {
        required : true,
        type:String,
        // validate: {
        //     // validator: (value) => {
        //     //     return value.length >= 6;
        //     // }
        // }
    },
    membership: {
        required: true,
        type: String,
    },
    // type: {
    //     type: String,
    //     default: "user",
    // }
});

const User = mongoose.model("User", userSchema);
module.exports= User;