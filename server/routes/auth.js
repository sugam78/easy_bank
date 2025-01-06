const express = require("express");
const authRouter = express.Router();
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const User = require("../models/user");
const auth = require("../middleware/auth");
const QRCode = require('qrcode');

const generateUniqueAccountNumber = async () => {
    let accountNumber;
    let existingAccount;

    do {
        accountNumber = Math.floor(10000000000000 + Math.random() * 90000000000000);

        existingAccount = await User.findOne({ accountNumber });
    } while (existingAccount);

    return accountNumber;
};

authRouter.post("/api/signup", async (req, res) => {
    try {
        const { name, phone, password, pin } = req.body;

        // Check if a user with the same phone number already exists
        const existingUser = await User.findOne({ phone });
        if (existingUser) {
            return res.status(400).json({ error: "User with the same phone number already exists" });
        }

        // Generate a hashed password
        const hashedPassword = await bcryptjs.hash(password, 8);
        const hashedPin = await bcryptjs.hash(pin, 4);

        // Generate a unique 14-digit account number
        const accNumber = await generateUniqueAccountNumber();

        const qrData = { name, accNumber };

        const qrCode = await QRCode.toDataURL(JSON.stringify(qrData));

        // Set account creation date and expiry date
        const accountCreatedDate = new Date();
        const accountExpiryDate = new Date(accountCreatedDate);
        accountExpiryDate.setFullYear(accountCreatedDate.getFullYear() + 5);

        // Create a new user
        let user = new User({
            name,
            phone,
            password: hashedPassword,
            pin: hashedPin,
            accNumber,
            accountCreatedDate,
            accountExpiryDate,
            qrCode
        });

        user = await user.save();

        res.json(user);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});


authRouter.post("/api/login",async(req,res)=>{
    try{
        const {phone,password} = req.body;
        const user = await User.findOne({phone});
        if(!user){
            return res.status(400).json({msg: "User with phone does not exists"});
        }
        const isMatch = await bcryptjs.compare(password,user.password);
        if(!isMatch){
            return res.status(400).json({error: "Wrong Password"});
        }
        const token = jwt.sign({id: user._id},"passwordKey");
        const responseUser = {
                    _id: user._id,
                    name: user.name,
                    phone: user.phone,
                    accNumber: user.accNumber,
                    token: token
                };

        res.json(responseUser);
    }
    catch(e){
        res.status(500).json({error: e.message});
    }
});

//check if token is valid or not
authRouter.post("/api/is-token-valid",async(req,res)=>{
    try{
    const token = req.header("x-auth-token");
    if(!token){
        return res.json(false);
    }
    const verify = jwt.verify(token,"passwordKey");
    if(!verify){
        return res.json(false);
    }
    const user = await User.findById(verify.id);
    if(!user){
        return res.json(false);
    }
    return res.json(true);
    }
    catch(e){
        res.status(500).json({error: e.message});
    }
});

//get user data
authRouter.get("/api/get-user-data",auth,async(req,res)=>{
    try{
        const user = await User.findById(req.user);
        res.json({...user._doc,token: req.token});
    }
    catch(e){
        res.status(500).json({error: e.message});
    }
});

module.exports = authRouter;