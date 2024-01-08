import express from "express";
import path from "path";
import router from "./routes/index.js";
import logger from "./middleware/logger.js";
import { sendMonthlyPaymentReminders } from "./controllers/user_gym_controllers.js";

import cors from "cors";
import { adminRouter } from "./adminjs/index.js";

const app: express.Application = express();
const port = process.env.PORT || 4500;
const address = `127.0.0.1:${port}`;

app.use(express.json());
app.use(cors());
app.use("/api", logger, router);
app.use("/admin", logger, adminRouter);
// Public
app.use("/uploads", express.static(path.resolve("uploads")));

app.listen(port, function () {
  console.log(`starting app on: ${address}`);
  sendMonthlyPaymentReminders();
});
