const express = require("express");
const authRouter = express.Router();
const User = require("../models/user");
const auth = require("../middleware/auth");

authRouter.get("/api/user", auth, async (req, res) => {
    try {
        const user = await User.findById(req.user).select("-password -pin");

        if (!user) {
            return res.status(404).json({ msg: "User not found" });
        }

        res.json(user);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});
