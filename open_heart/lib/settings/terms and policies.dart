import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TermsAndPolicyPage(),
    ),
  );
}

class TermsAndPolicyPage extends StatelessWidget {
  const TermsAndPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Color.fromARGB(255, 17, 125, 183),
            ], // Full background gradient
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Terms and Policy',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),

                const SizedBox(height: 20),

                // Terms of Service Section
                const Text(
                  'Terms of Service',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'By using this app, you agree to the following terms and conditions. You are not allowed to modify, distribute, or exploit the content of this app in any way. You agree to use the app for personal, non-commercial use only.',
                  style: TextStyle(fontSize: 14),
                ),

                const SizedBox(height: 20),

                // Privacy Policy Section
                const Text(
                  'Privacy Policy',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'We respect your privacy. We only collect personal information necessary for the operation of our services. We do not sell or share your data with third parties. Your personal information is stored securely.',
                  style: TextStyle(fontSize: 14),
                ),

                const SizedBox(height: 20),

                // Disclaimer Section
                const Text(
                  'Disclaimer',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'We do not guarantee the accuracy, reliability, or completeness of the content available on this app. Use the app at your own risk. The developer is not responsible for any damages that may arise from using this app.',
                  style: TextStyle(fontSize: 14),
                ),

                const SizedBox(height: 20),

                // Contact Us Section
                const Text(
                  'Contact Us',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'For any inquiries or issues regarding the terms or privacy policy, please contact us at: support@example.com',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
