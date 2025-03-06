import 'package:flutter/material.dart';
import 'main.dart'; 

class OtpFailurePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color.fromARGB(255, 17, 125, 183)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'Assets/logo.png',
              height: 120,
            ),

            SizedBox(height: 40),

            // Sad Face Emoji or Image
            Image.asset(
              'Assets/sad-face.png',
              height: 120,
            ),

            SizedBox(height: 30),

            // "Login Failed" Text
            Text(
              "Login Failed",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            SizedBox(height: 20),

            // Description Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                "Sorry, this OTP is incorrect",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ),

            SizedBox(height: 40),

            // Resend OTP Button
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.white),
                  ),
                ),
                onPressed: () {
                  // Logic for resending OTP
                  print("Resending OTP...");
                },
                child: Text(
                  "Resend OTP",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
