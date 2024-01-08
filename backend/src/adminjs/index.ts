import AdminJS from "adminjs";
import AdminJSExpress from "@adminjs/express";
import Connect from "connect-pg-simple";
import session from "express-session";
import * as AdminJSMikroORM from "@adminjs/mikroorm";
import dotenv from "dotenv";
import adminOptions from "./config/adminjs_config.js";

dotenv.config();

const DEFAULT_ADMIN = {
  email: "admin",
  password: "admin",
};

const { POSTGRES_HOST, POSTGRES_DB, POSTGRES_USER, POSTGRES_PASSWORD } =
  process.env;
const POSTGRES_PORT = 5432;

const authenticate = async (email: string, password: string) => {
  if (email === DEFAULT_ADMIN.email && password === DEFAULT_ADMIN.password) {
    return Promise.resolve(DEFAULT_ADMIN);
  }
  return null;
};

// Register the MikroORM adapters with AdminJS
AdminJS.registerAdapter({
  Resource: AdminJSMikroORM.Resource,
  Database: AdminJSMikroORM.Database,
});

const admin = new AdminJS(adminOptions);
const ConnectSession = Connect(session);
const sessionStore = new ConnectSession({
  conObject: {
    // Use your PostgreSQL connection details here
    connectionString: `postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DB}`,
    ssl: process.env.NODE_ENV === "production",
  },
  tableName: "session",
  createTableIfMissing: true,
});

const adminRouter = AdminJSExpress.buildAuthenticatedRouter(
  admin,
  {
    authenticate,
    cookieName: "adminjs",
    cookiePassword: "sessionsecret",
  },
  null,
  {
    store: sessionStore,
    resave: true,
    saveUninitialized: true,
    secret: "sessionsecret",
    cookie: {
      httpOnly: process.env.NODE_ENV === "production",
      secure: process.env.NODE_ENV === "production",
    },
    name: "adminjs",
  }
);
export { adminRouter };
