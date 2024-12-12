const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
    name:{
        required: true,
        type: String,
        trim: true
    },
    phone: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                const re = /^\d{10}$/; // Matches exactly 10 digits
                return re.test(value);
            },
            message: 'Please enter a valid phone number',
        }
    },

    password: {
            required: true,
            type: String,
            validate: {
                validator: (value)=>{
                    return value.length > 6;
                },
                message: 'Please enter a valid password',
            }
        },
    pin: {
            required: true,
            type: String,
            validate: {
                validator: (value)=>{
                    return value.length == 4;
                },
                message: 'Please enter a valid Pin ',
            }
        },
    accNumber: {
            required: true,
            type: String,
            unique: true,
            validate: {
                validator: (value)=>{
                    return value.length == 14;
                },
                message: 'Invalid account number',
            }
        },

});

const user = mongoose.model('user', userSchema);
module.exports = user;