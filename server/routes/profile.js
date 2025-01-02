const express = require("express");
const profileRouter = express.Router();
const User = require("../models/user");
const auth = require("../middleware/auth");

profileRouter.get("/api/user/profile", auth, async (req, res) => {
    try {
        const user = await User.findById(req.user).select("-password -pin -history");

        if (!user) {
            return res.status(404).json({ error: "User not found" });
        }

        res.json(user);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

module.exports = profileRouter;