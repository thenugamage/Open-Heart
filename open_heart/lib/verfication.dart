import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'main.dart';

class OTPVerificationPage extends StatelessWidget {
  const OTPVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset('assets/logo.png', height: 80),


            const SizedBox(height: 20),

            // Verification Text
            const Text(
              "Verification",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // Instructions
            const Text(
              "We’ve sent a 4-digit verification code to your email. "
              "Please enter the OTP code below to continue.",
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            // OTP Input
            Pinput(
              length: 4,
              defaultPinTheme: defaultPinTheme,
              onCompleted: (pin) {
                print("Entered OTP: $pin");
              },
            ),

            const SizedBox(height: 20),

            // Continue Button
            ElevatedButton(
              onPressed: () {
                // Handle OTP verification here
                print("OTP Verified");
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                backgroundColor: Colors.blue,
              ),
              child: const Text("Continue", style: TextStyle(color: Colors.white)),
            ),

            const SizedBox(height: 10),

            // Resend OTP
            TextButton(
              onPressed: () {
                print("Resend OTP clicked");
              },
              child: const Text("Resend"),
            ),

            // Terms & Privacy
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "By clicking the Continue button, you agree to the terms of service and privacy policy.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
