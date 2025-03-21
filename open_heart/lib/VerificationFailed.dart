// Created by Thenuri

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerificationFailedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE3F2FD), Color(0xFF64B5F6)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // **Back Button**
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(height: 20),
              // **Logo**
              Image.asset(
                'Assets/logo.png',
                height: 80,
              ),
              const SizedBox(height: 30),
              // **Failed Icon**
              Image.asset(
                'Assets/sad-face.png',
                height: 120,
              ),
              const SizedBox(height: 20),
              // **Login Failed Text**
              Text(
                "Login Failed",
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              // **Failure Message**
              Text(
                "Sorry, this OTP is incorrect",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 40),
              // **Resend OTP Button**
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF064B6D), width: 2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    // Resend OTP logic
                  },
                  child: Text(
                    "Resend OTP",
                    style: GoogleFonts.poppins(fontSize: 16, color: Color(0xFF064B6D)),
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
