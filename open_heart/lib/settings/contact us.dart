import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: ContactUsPage()),
  );
}

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

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
            colors: [Colors.white, Color.fromARGB(255, 17, 125, 183)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                      ),
                      const Spacer(),
                      const Text(
                        "Contact Us",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // Logo from Assets
                Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      'Assets/logo.png', // Ensure this is the correct path to your image
                      fit:
                          BoxFit.cover, // Ensure the image covers the container
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Contact description
                const Center(
                  child: Text(
                    "Contact Us",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Crowdfunding has no limit, and we’re here for you.\nOur dedicated teams are on stand-by to answer\nany inquiry you may have.",
                  style: TextStyle(fontSize: 14),
                ),

                const SizedBox(height: 20),

                // Visit Us
                const Center(
                  child: Text(
                    "Visit Us",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Dialog Axiata PLC, 475, Union Place, Colombo 02,\nSri Lanka.",
                  style: TextStyle(fontSize: 14),
                ),

                const SizedBox(height: 20),

                // Hotline + stacked image boxes
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hotline details
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Center(
                            child: Text(
                              "Hotline",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(height: 6),
                          Text("Mon - Fri 9am to 6pm"),
                          Text("Hotline Num: 076-8585457"),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Stacked images in a row
                    Column(
                      children: [
                        _contactImageBox('Assets/child_contactus.PNG'),
                        const SizedBox(height: 8),
                        _contactImageBox('Assets/child_contactus1.PNG'),
                        const SizedBox(height: 8),
                        _contactImageBox('Assets/child_contactus2.PNG'),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Email
                const Center(
                  child: Text(
                    "Email us",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 6),
                const Text("openheart@gmail.com"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Reusable stacked image box with slight margin
  static Widget _contactImageBox(String path) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 80,
        height: 60,
        color: Colors.black,
        child: Image.asset(path, fit: BoxFit.cover),
      ),
    );
  }
}
