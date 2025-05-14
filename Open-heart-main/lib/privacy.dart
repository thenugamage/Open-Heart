import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffe6f3fc), // Light Blue
              Color(0xff9cd0f4), // Medium Blue
              Color(0xff2a8dd2), // Dark Blue
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo or image (optional)
                Center(
                  child: Image.asset(
                    'Assets/logo.png', // Replace with your logo image
                    height: 80,
                  ),
                ),
                const SizedBox(height: 20),

                // Title with enhanced typography
                const Text(
                  "Privacy Policy",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 10),

                // Subtitle (Privacy Overview)
                const Text(
                  "Your privacy is important to us. This policy explains how we collect, use, and protect your data.",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 30),

                // Detailed description of privacy policy
                const Text(
                  "We take your privacy seriously. This privacy policy outlines the data we collect, how we use it, and how we protect it. "
                      "By using this application, you agree to the terms outlined in this privacy policy. "
                      "We are committed to ensuring your personal data remains secure and private.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    height: 1.5, // Improve readability
                  ),
                ),
                const SizedBox(height: 40),

                // Spacer for proper layout
                const Spacer(),

                // Accept Terms button with better styling
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle the button press
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff2a8dd2), // Button color
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      elevation: 5, // Shadow for button
                    ),
                    child: const Text(
                      'Accept Privacy Policy',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
