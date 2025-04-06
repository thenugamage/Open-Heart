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

                // Logo box
                Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        "LOGO",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                    // Stacked images
                    Column(
                      children: [
                        _contactImageBox('assets/img1.jpg'),
                        const SizedBox(height: 8),
                        _contactImageBox('assets/img2.jpg'),
                        const SizedBox(height: 8),
                        _contactImageBox('assets/img3.jpg'),
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

  // Reusable stacked image box
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
