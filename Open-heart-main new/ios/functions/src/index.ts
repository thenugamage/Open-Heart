import * as functions from "firebase-functions";
import * as nodemailer from "nodemailer";

interface DonationData {
  email: string;
  amount: number;
}

const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: "your-email@gmail.com", // ✅ replace with your Gmail
    pass: "your-app-password", // ✅ replace with app password
  },
});

export const sendDonationConfirmation = functions.https.onCall(
  async (request: functions.https.CallableRequest<DonationData>) => {
    const {email, amount} = request.data;

    const mailOptions = {
      from: "your-email@gmail.com",
      to: email,
      subject: "Thank You for Your Donation",
      html:
        "<p>Hello,</p>" +
        `<p>We’ve received your generous donation of <strong>LKR ${amount}</strong>.</p>` +
        "<p>Thank you for supporting our cause!</p>" +
        "<p>- Open Heart Team</p>",

    };

    try {
      await transporter.sendMail(mailOptions);
      return {success: true};
    } catch (error) {
      console.error("Email send error:", error);
      throw new functions.https.HttpsError("internal", "Failed to send email.");
    }
  },
);
