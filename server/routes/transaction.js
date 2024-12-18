const express = require("express");
const transactionRouter = express.Router();
const User = require("../models/user");
const auth = require("../middleware/auth");
const bcryptjs = require("bcryptjs");


transactionRouter.post("/api/user/checkMobileNumber", auth, async (req, res) => {
    try {
        const { mobileNumber } = req.body;

        if (!mobileNumber) {
            return res.status(400).json({ error: "Mobile number is required" });
        }

        const user = await User.findOne({ phone: mobileNumber });

        if (!user) {
            return res.status(404).json({ error: "No user found" });
        }

        res.status(200).json({ message: "User Found" });

    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

transactionRouter.post("/api/user/checkAccountNumber", auth, async (req, res) => {
    try {
        const { accountNo } = req.body;

        if (!mobileNumber) {
            return res.status(400).json({ error: "Account number is required" });
        }

        const user = await User.findOne({ accNumber: accountNo });

        if (!user) {
            return res.status(404).json({ error: "No user found" });
        }

        res.status(200).json({ message: "User Found" });

    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});


transactionRouter.post("/api/user/balanceTransfer", auth, async (req, res) => {
    try {
        const { accountNumber, mobileNumber,pin } = req.body;
        let amount = Number(req.body.amount);

        if (!amount || (!accountNumber && !mobileNumber)) {
            return res.status(400).json({ error: "Amount and either account number or mobile number are required" });
        }

        if (isNaN(amount) || amount <= 0) {
            return res.status(400).json({ error: "Invalid amount" });
        }

        const sender = await User.findById(req.user.id);

        if (!sender) {
            return res.status(401).json({ error: "Unauthorized. Token expired or invalid user" });
        }
        const isMatch = await bcryptjs.compare(pin,user.pin);
                if(!isMatch){
                    return res.status(400).json({error: "Wrong Pin"});
                }


        let receiver;
        if (accountNumber) {
            receiver = await User.findOne({ accNumber: accountNumber });
        } else if (mobileNumber) {
            receiver = await User.findOne({ mobileNumber: mobileNumber });
        }

        if (!receiver) {
        if(accountNumber)
            {
            return res.status(404).json({ error: "No user found with the provided account number" });
            }
            else{
            return res.status(404).json({ error: "No user found with the provided mobile number" });
            }
        }

        if (sender.currentBalance < amount) {
            return res.status(400).json({ error: "Insufficient balance" });
        }

        // Update balances
        sender.currentBalance -= amount;
        receiver.currentBalance += amount;

        // Create transaction objects
        const transaction = {
            type: "Debit",
            amount,
            sender: {
                name: sender.name,
                accNumber: sender.accNumber,
            },
            receiver: {
                name: receiver.name,
                accNumber: receiver.accNumber,
                mobileNumber: receiver.mobileNumber,
            },
        };

        const receiverTransaction = {
            ...transaction,
            type: "Credit",
        };

        // Add transactions to history
        sender.history.push(transaction);
        receiver.history.push(receiverTransaction);

        // Save changes
        await sender.save();
        await receiver.save();

        res.status(200).json({ message: "Balance successfully transferred" });

    } catch (error) {
        console.error("Error during balance transfer:", error);
        res.status(500).json({ error: error.message });
    }
});


module.exports = transactionRouter;
