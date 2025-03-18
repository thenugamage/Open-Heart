import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'verfication.dart';
import 'dart:math';

class VerificationFailed extends StatelessWidget {
  const VerificationFailed({super.key});

  // Generate a random 4-digit OTP
  String _generateOTP() {
    Random random = Random();
    int otp = random.nextInt(9000) + 1000; // Generates a number between 1000 and 9999
    return otp.toString();
  }

  Future<void> _resendVerificationEmail(BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Generate new OTP
        String newOtp = _generateOTP();
        
        // In a real app, this would send the OTP via email
        // For this example, we'll just navigate to the verification screen with the new OTP
        
        // Show loading indicator
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sending new verification code...')),
        );
        
        // Simulate network delay
        await Future.delayed(const Duration(seconds: 1));
        
        // Navigate to verification screen with new OTP
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => VerificationScreen(
              email: user.email ?? '',
              correctOtp: newOtp,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user found. Please sign up again.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to resend verification: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFF117DB7)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("Assets/failed.png", height: 100),
              const SizedBox(height: 20),
              const Text(
                "Verification Failed!",
                style: TextStyle(
                  fontSize: 24, 
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF08385F),
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "The verification code you entered is incorrect. Please try again.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF08385F),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 250,
                child: ElevatedButton(
                  onPressed: () => _resendVerificationEmail(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF013F68),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    "Resend Code",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}