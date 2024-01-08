import nodemailer from "nodemailer";

const transporter = nodemailer.createTransport({
  service: "Gmail",
  auth: {
    user: "tewodrosm01@email.com",
    pass: "uqgicrybtnstqvha",
  },
});

export default transporter;
