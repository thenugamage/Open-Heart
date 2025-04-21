// created by Thenuri
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'verification_screen.dart';

class VerificationFailedScreen extends StatelessWidget {
  final String verificationId;
  const VerificationFailedScreen({super.key, required this.verificationId});

  void resendOTP(BuildContext context) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+1234567890", // Replace with actual phone number
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Verification Failed: ${e.message}')),
          );
        },
        codeSent: (String verId, int? resendToken) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => OTPVerificationScreen(verificationId: verId)),
          );
        },
        codeAutoRetrievalTimeout: (String verId) {},
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("Assets/logo.png", height: 104),
              const SizedBox(height: 50),
              Image.asset("Assets/sad-face.png", height: 132), // Added sad-face image
              const SizedBox(height: 20),
              const Text(
          "Verification Failed",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
              ),
                const SizedBox(height: 30),
                const Text(
                "Sorry, We couldn't verify your phone number. Please try again.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                width: 250,
                child: ElevatedButton(
                  onPressed: () {
                  Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                  builder: (context) => OTPVerificationScreen(verificationId: verificationId),
                  ),
                  );
                  },
                  style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF013F68),
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: const BorderSide(color: Colors.white, width: 2),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                  "Resend OTP",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}