import express from "express";
import GymController from "../../controllers/gym_controllers.js";

const gymRouter: express.Router = express();

gymRouter.post("/login", GymController.gymLogin);
gymRouter.get("/usercount/:gym_id", GymController.getGymUserCount);
gymRouter.get("/user/:gym_id", GymController.getGymUsers);
gymRouter.get("/provider/:user_id", GymController.getGymProvider);
gymRouter.get("/:id", GymController.getGymById);
gymRouter.get("/", GymController.getAllGym);
gymRouter.post("/register", GymController.createNewGym);

export default gymRouter;
