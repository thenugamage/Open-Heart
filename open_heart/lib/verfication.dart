import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class VerificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color.fromARGB(255, 17, 125, 183)],
          ),
        ),
        child: Stack(
          children: [
            /// backgroud Image
            Positioned(
              top: 200,
              left: 0,
              right: 0,
              bottom: 0,
              child: Opacity(
                opacity: 0.9,
                child: Image.asset(
                  'Assets/backgroundimg.png',
                  width: 100,
                height: 100,
                ),
              ),
            ),
            Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               //// Back Button
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              // Logo
              Image.asset(
                "Assets/logo.png",
                height: 100,
              ),
              const SizedBox(height: 30),
              const Text(
                "Verification Code",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 8, 56, 95),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "We've sent a 4-digit verification code to your email. Please enter the OTP code below to continue.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 30),

               /// OTP Input Fields
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Pinput(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    length: 4,
                    defaultPinTheme: PinTheme(
                      height: 88,
                      width: 66,
                      textStyle: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color.fromARGB(255, 1, 98, 244)),
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(0, 255, 255, 255),
                      ),
                    ),
                    showCursor: true,
                  ),
                ),
              const SizedBox(height: 30),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Add your logic to verify the OTP here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 1, 66, 104),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Resend Code Link
              GestureDetector(
                onTap: () {
                  // Add your logic to resend the OTP here
                },
                child: const Text(
                  "Didn't receive the code? Resend",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 94, 171),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Terms and Conditions
              const Text(
                "By clicking the Continue button, you agree to the terms of service and privacy policy.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}