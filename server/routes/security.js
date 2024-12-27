const express = require("express");
const securityRouter = express.Router();
const bcryptjs = require("bcryptjs");
const User = require("../models/user");
const auth = require("../middleware/auth");

securityRouter.post("/api/user/change-password",auth,async(req,res)=>{
try{
    const {oldPassword,newPassword} = req.body;
    const user = await User.findById(req.user);
    if(!user){
            res.status(401).json({error: 'Token expired'});
        }
    const isMatch = await bcryptjs.compare(oldPassword,user.password);
    if(!isMatch){
        res.status(400).json({error: 'Wrong password'});
    }
    const hashedPassword = await bcryptjs.hash(newPassword,8);
    user.password  = hashedPassword;
    await user.save();
    res.json('Password Changed Successfully');

}
catch(e){
res.status(500).json({error: e.message});
}
});

securityRouter.post("/api/user/change-pin",auth,async(req,res)=>{
try{
    const {password, newPin} = req.body;
    console.log('HdfsEy');
    const user = await User.findById(req.user);
    console.log('hshsh');
        if(!user){
                res.status(401).json({error: 'Token expired'});
            }
            console.log('HEy');
        const isMatch = await bcryptjs.compare(oldPassword,user.password);
        console.log(isMatch);
        if(!isMatch){
            res.status(401).json({error: 'Wrong password'});
        }
        console.log('hi');
        const hashedPin = await bcryptjs.hash(newPin,4);
        console.log(hashedPin);
             user.pin  = hashedPin;
             console.log('hehehe');
             await user.save();
             res.json('Pin Changed Successfully');

}
catch(e){
res.status(500).json({error: e.message});
}
});

module.exports = securityRouter;