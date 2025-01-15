const mongoose = require("mongoose");

const historySchema = mongoose.Schema({
    type: {
        type: String,
        enum: ['Debit', 'Credit'],
        required: true
    },
    amount: {
        type: Number,
        required: true
    },
    sender: {
        name: {
            type: String,
            required: true,
            trim: true
        },
        accNumber: {
            type: String,
            required: true,
            validate: {
                validator: (value) => {
                    return value.length == 14;
                },
                message: 'Invalid sender account number',
            }
        }
    },
    receiver: {
        name: {
            type: String,
            required: true,
            trim: true
        },
        accNumber: {
            type: String,
            required: true,
            validate: {
                validator: (value) => {
                    return value.length == 14;
                },
                message: 'Invalid receiver account number',
            }
        }
    },
    transactionDate :{
    type: Date, required: true, default: Date.now
    }
});


const userSchema = mongoose.Schema({
    name: {
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
            validator: (value) => {
                return value.length > 6;
            },
            message: 'Please enter a valid password',
        }
    },
    pin: {
        required: true,
        type: String,
        validate: {
            validator: (value) => {
                return value.length >= 4;
            },
            message: 'Please enter a valid Pin ',
        }
    },
    accNumber: {
        required: true,
        type: String,
        unique: true,
        validate: {
            validator: (value) => {
                return value.length == 14;
            },
            message: 'Invalid account number',
        }
    },
    currentBalance: {
        type: Number,
        required: true,
        default: 0
    },
    acurredInterest: {
        type: Number,
        required: true,
        default: 0
    },
    history: [historySchema],
    accountCreatedDate: {
        type: Date,
        required: true,
        default: Date.now
    },
    accountExpiryDate: {
        type: Date,
        required: true
    },
    transactionEnabled: {
            type: Boolean,
            default: true
        },
    qrCode: {
        type: String,
        required: false
    },
    fcmToken: {
            type: String,
            required: true,
        },
});

const user = mongoose.model('user', userSchema);
module.exports = user;
