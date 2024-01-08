import { Request, Response, NextFunction } from "express";
import { User, UserStore } from "../models/user.js";
import { IRequest } from "../middleware/auth.js";
import transporter from "../configs/emailConfig.js";
import cron from "node-cron";
import UserGymService from "../services/user_gym_service.js";

// Define a function for sending monthly payment reminders
export const sendMonthlyPaymentReminders = () => {
  // Schedule the job to run every day (or at a suitable frequency)
  cron.schedule("0 0 * * *", async () => {
    try {
      const currentDate = new Date();

      // Get all users who have not paid and need a reminder
      const userGymService: UserGymService = new UserGymService();
      const unpaidUsers = await userGymService.getAllUsersNotPaid();

      // Define the email content
      const emailSubject = "Monthly Payment Reminder";
      const emailText =
        "Dear user, your monthly payment is due. Please make your payment as soon as possible.";

      for (const user of unpaidUsers) {
        const joinDate = new Date(user.join_date!); // Assuming you have a join_date field in your user object
        const nextPaymentDueDate = new Date(joinDate);
        nextPaymentDueDate.setMonth(nextPaymentDueDate.getMonth() + 1); // Add one month to the join date

        if (currentDate >= nextPaymentDueDate) {
          // Send an email to the user
          const mailOptions = {
            from: "tewodrosm01@email.com",
            to: user.email,
            subject: emailSubject,
            text: emailText,
          };
          await transporter.sendMail(mailOptions);

          // Calculate the new next payment due date
          nextPaymentDueDate.setMonth(nextPaymentDueDate.getMonth() + 1);

          // Update the user's join date to the new next payment due date
          const userStore: UserStore = new UserStore();
          await userStore.updateUserJoinDate(user.user_id!, nextPaymentDueDate);
        }
      }
    } catch (error) {
      console.error("Error sending monthly emails:", error);
    }
  });
};

class UserGymControllers {
  static joinUserToGym = async (req: IRequest, res: Response) => {
    try {
      console.log(req.user?.user_id);
      const userId = req.user!.user_id;
      const gymId = req.params.gymId;
      const join_date = new Date(); // Get the current date as the join date
      const userGymService: UserGymService = new UserGymService();
      const userJoin = await userGymService.joinGym(
        userId!,
        parseInt(gymId),
        join_date
      );
      res.json({ message: "Success", data: userJoin });
    } catch (err) {
      res.status(400).json(`${err}`);
    }
  };
  static leaveUserToGym = async (req: IRequest, res: Response) => {
    try {
      console.log(req.user?.user_id);
      const userId = req.user!.user_id;
      const gymId = req.params.gymId;
      const userGymService: UserGymService = new UserGymService();
      const userLeave = await userGymService.leaveGym(userId!, parseInt(gymId));
      res.json({ message: "Success", data: userLeave });
    } catch (err) {
      res.status(400).json(`${err}`);
    }
  };
  static updateUserPaymentStatus = async (
    req: Request,
    res: Response
  ): Promise<void> => {
    const userGymService: UserGymService = new UserGymService();
    const userId = parseInt(req.params.userId, 10); // Assuming userId is in the URL parameters
    const gymId = parseInt(req.params.gymId, 10); // Assuming gymId is in the URL parameters
    const isPaid = req.body.is_paid;

    if (isNaN(userId) || isNaN(gymId)) {
      res.status(400).json({ error: "Invalid user or gym ID." });
      return;
    }

    if (typeof isPaid !== "boolean") {
      res.status(400).json({ error: "is_paid must be a boolean value." });
      return;
    }

    try {
      const updatedUser = await userGymService.updateUserPaymentStatus(
        userId,
        gymId,
        isPaid
      );
      if (updatedUser !== null) {
        res.status(200).json(updatedUser);
      } else {
        res
          .status(404)
          .json({ error: "User or gym not found, or no update occurred." });
      }
    } catch (error) {
      console.error("Error updating user payment status:", error);
      res.status(500).json({ error: "Internal Server Error" });
    }
  };
}

export default UserGymControllers;
