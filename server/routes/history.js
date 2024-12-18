const express = require("express");
const historyRouter = express.Router();
const User = require("../models/user");
const auth = require("../middleware/auth");

historyRouter.get("/api/user/history", auth, async (req, res) => {
    const { page = 1, limit = 10 } = req.query;
        const skip = (page - 1) * limit;
        try {
            const user = await User.findById(req.user.id, 'history');
            if (!user) {
                return res.status(404).json({ error: 'User not found' });
            }

            const paginatedHistory = user.history.slice(skip, skip + limit);
            res.status(200).json(paginatedHistory);
        } catch (error) {
            res.status(500).json({ error: 'Error fetching history', error });
        }
});


module.exports = historyRouter;