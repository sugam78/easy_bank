const cron = require('node-cron');
const User = require('./models/user');

cron.schedule('0 0 * * *', async () => {
  console.log('Running daily interest calculation...');
  await updateDailyInterest();
});

async function updateDailyInterest() {
  try {
    const users = await User.find({});

    for (const user of users) {
      const { currentBalance, _id } = user;

      const dailyInterest = (currentBalance * (3 / 100)) / 365;
      const newBalance = currentBalance + dailyInterest;

      await User.updateOne({ _id }, { currentBalance: newBalance });

      console.log(`Updated user ${_id} balance to ${newBalance}`);
    }
  } catch (error) {
    console.error('Error updating daily interest:', error);
  }
}

module.exports = () => {
  console.log("Cron jobs initialized");
};
