const jwt = require("jsonwebtoken");

const auth = async(req,res,next)=>{
    try{
        const token = req.header("x-auth-token");
        if(!token){
            res.status(401).json({msg: "No auth token, Access denied"});
        }
        const verify = jwt.verify(token,"passwordKey");
        if(!verify){
            return res.status(401).json({msg:'Token verification failed, authorization denied'});
        }
        req.user = verify.id;
        req.token = token;
        next();
    }
    catch(e){
        res.status(500).json({error: e.message});
    }
}

module.exports = auth;