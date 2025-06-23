import dotenv from "dotenv";
import { convert } from "html-to-text";
import nodemailer from "nodemailer";
import pug from "pug";

import { UserDocument } from "../interface/user";

dotenv.config({ path: "./.env" });

export interface TransportOptions {
  host?: string;
  port?: number;
  auth?: {
    user: string;
    pass: string;
  };
}

type UserData = {
  name: string;
  email: string;
  phone: string;
  message: string;
};

class Email {
  to: string;

  name: string;

  url: string;

  from: string;

  constructor(user: UserDocument, url?: string) {
    this.to = user.email;
    this.name = `${user.firstName} ${user.lastName}`;
    this.url = url;
    this.from = `Skillzy <${process.env.EMAIL_FROM}>`;
  }

  newTransport() {
    if (process.env.NODE_ENV !== "developement") {
      return nodemailer.createTransport({
        host: "smtp.sendgrid.net",
        port: 587,
        secure: false, // Use `true` for port 465
        auth: {
          user: "apikey", // Must be "apikey" (literal string)
          pass: process.env.SENDGRID_PASSWORD // Use your API Key
        }
      });
    }

    const transportOptions: TransportOptions = {
      host: process.env.EMAIL_HOST,
      port: +process.env.EMAIL_PORT,
      auth: {
        user: process.env.EMAIL_USERNAME,
        pass: process.env.EMAIL_PASSWORD
      }
    };

    return nodemailer.createTransport(transportOptions);
  }

  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  async send(template: string, subject: string, data?: Record<string, any>): Promise<void> {
    const html = pug.renderFile(`${__dirname}/../views/emails/${template}.pug`, {
      name: this.name,
      email: this.to,
      url: this.url,
      subject,
      data
    });

    // Send the email
    const emailOptions = {
      from: this.from,
      to: this.to,
      subject,
      html,
      text: convert(html, { wordwrap: 130 })
    };

    await this.newTransport().sendMail(emailOptions);
  }

  async sendResetPasswordEmail(otp: string) {
    await this.send("resetPassword", "Reset your password (Valid for 10mins)", { otp });
  }

  async sendVerificationEmail(otp: string) {
    await this.send("verifyEmail", "Verify your email (Valid for 10mins)", { otp });
  }

  async sendDeletionEmail(otp: string) {
    await this.send("deletionEmail", "Delete your data (Valid for 10mins)", { otp });
  }

  async sendLoginTokenEmail(otp: string) {
    await this.send("loginVerification", "Verify your login (Valid for 10mins)", { otp });
  }

  async contactUsEmail(userData: UserData) {
    this.to = process.env.EMAIL_FROM;
    await this.send("contactUs", "GoFitWithUs Contact Suport Center", userData);
  }
}

export default Email;
