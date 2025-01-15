const express = require("express");
const transactionRouter = express.Router();
const User = require("../models/user");
const auth = require("../middleware/auth");
const bcryptjs = require("bcryptjs");
const admin = require("firebase-admin");

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
        if (req.user && user && user._id.toString() === req.user.toString()) {
                    return res.status(400).json({ error: "Cannot validate your own mobile number" });
                }

        res.status(200).json({ message: "User Found" });

    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

transactionRouter.post("/api/user/checkAccountNumber", auth, async (req, res) => {
    try {
        const { accountNo } = req.body;

        if (!accountNo) {
            return res.status(400).json({ error: "Account number is required" });
        }

        const user = await User.findOne({ accNumber: accountNo });

        if (!user) {
            return res.status(404).json({ error: "No user found" });
        }
        if (user._id.toString() === req.user.toString()) {
                    return res.status(400).json({ error: "Cannot validate your own Account number" });
                }

        res.status(200).json({ message: "User Found" });

    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});


transactionRouter.post("/api/user/balanceTransfer", auth, async (req, res) => {
    try {
        const { accountNumber, mobileNumber, pin } = req.body;
        let amount = Number(req.body.amount);

        if (!amount || (!accountNumber && !mobileNumber)) {
            return res.status(400).json({ error: "Amount and either account number or mobile number are required" });
        }

        if (isNaN(amount) || amount <= 0) {
            return res.status(400).json({ error: "Invalid amount" });
        }

        const sender = await User.findById(req.user);

        if (!sender) {
            return res.status(401).json({ error: "Unauthorized. Token expired or invalid user" });
        }
        const isMatch = await bcryptjs.compare(pin,sender.pin);
                if(!isMatch){
                    return res.status(400).json({error: "Wrong Pin"});
                }
        if(!sender.transactionEnabled){
            return res.status(400).json({error: "Transaction is Disabled"});
        }

        let receiver;
        if (accountNumber) {
            receiver = await User.findOne({ accNumber: accountNumber });
        } else if (mobileNumber) {
            receiver = await User.findOne({ phone: mobileNumber });
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

        sender.currentBalance -= amount;
        receiver.currentBalance += amount;
         const transactionDate = new Date();

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
            },
            transactionDate: transactionDate,
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


        const senderToken = sender.fcmToken; // Ensure FCM token is saved in the User model
            const receiverToken = receiver.fcmToken; // Same for the receiver

            const message = {
              notification: {
                title: "Transaction Successful",
                body: `You have transferred ${amount} to ${receiver.name}`,
              },
              token: senderToken,
            };

            const receiverMessage = {
              notification: {
                title: "Transaction Received",
                body: `You have received ${amount} from ${sender.name}`,
              },
              token: receiverToken,
            };

            if (senderToken) {
              await admin.messaging().send(message);
            }

            if (receiverToken) {
              await admin.messaging().send(receiverMessage);
            }

        res.status(200).json({ message: "Balance successfully transferred" });

    } catch (error) {
        console.error("Error during balance transfer:", error);
        res.status(500).json({ error: error.message });
    }
});

transactionRouter.post("/api/user/toggleTransaction", auth, async (req, res) => {
    try {
        let user = await User.findById(req.user);
        user.transactionEnabled = ! user.transactionEnabled;
        user = await user.save();
        res.status(200).json(user.transactionEnabled);
    } catch (error) {
        console.error("Error during balance transfer:", error);
        res.status(500).json({ error: error.message });
    }
});


module.exports = transactionRouter;
