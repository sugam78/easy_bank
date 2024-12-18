const express = require("express");
const fdRouter = express.Router();
const User = require("../models/user");
const auth = require("../middleware/auth");

fdRouter.post("/api/user/applyForFD", auth, async (req, res) => {
    try {
        const { amount, time, rate } = req.body;

        if (!amount || !time) {
            return res.status(400).json({ error: "Amount and time are required" });
        }

        if (isNaN(amount) || amount <= 0) {
            return res.status(400).json({ error: "Invalid amount" });
        }

        if (isNaN(time) || time <= 0) {
            return res.status(400).json({ error: "Invalid time period" });
        }

        const user = await User.findById(req.user.id);
        if (!user) {
            return res.status(401).json({ error: "Unauthorized. Token expired or invalid user" });
        }

        if (user.currentBalance < amount) {
            return res.status(400).json({ error: "Insufficient balance for Fixed Deposit" });
        }

        user.currentBalance -= amount;

        if (!user.fixedDeposits) {
            user.fixedDeposits = [];
        }
        const fdDetails = {
            amount,
            time,
            rate,
            startDate: new Date(),
            maturityDate: new Date(new Date().setMonth(new Date().getMonth() + time)),
        };
        user.fixedDeposits.push(fdDetails);

        await user.save();

        res.status(200).json({
            message: "Fixed Deposit successfully created",
            fixedDeposit: fdDetails,
        });
    } catch (error) {
        res.status(500).json({ error: "An unexpected error occurred" });
    }
});

module.exports = fdRouter;