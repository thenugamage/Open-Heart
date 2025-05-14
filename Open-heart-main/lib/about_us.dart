import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent, // Make the AppBar transparent
        elevation: 0, // Remove shadow under the AppBar
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
                  "About Us",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 10),

                // Subtitle (Company Overview)
                const Text(
                  "Welcome to our company. We are dedicated to providing top-notch services.",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 30),

                // Detailed description
                const Text(
                  "Our app is built with the goal of delivering a seamless experience for our users. "
                      "We focus on using the latest technology to offer high-quality services that help improve your day-to-day life. "
                      "Join us in making the world a better place, one click at a time.",
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
                      'Accept Terms',
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
