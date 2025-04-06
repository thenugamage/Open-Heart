import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MySubscriptionPage(),
    ),
  );
}

class MySubscriptionPage extends StatelessWidget {
  const MySubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color.fromARGB(255, 17, 125, 183)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                      ),
                      const Spacer(),
                      const Text(
                        "My Subscription",
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

                // Logo from Assets (Square)
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      // color: Colors.black,
                      // Optional border radius
                      ),
                  child: Image.asset(
                    'Assets/logo.png', // Ensure this is the correct path to your image
                    fit: BoxFit
                        .cover, // Make sure the image fits within the square
                  ),
                ),

                const SizedBox(height: 33),

                // Campaign 1
                _campaignCard(
                  title: '1990',
                  raised: 'LKR 1,499,218',
                  goal: 'LKR 10,000,000',
                ),

                const SizedBox(height: 20),

                // Campaign 2
                _campaignCard(
                  title: 'Lets Help Speak And Smile',
                  raised: 'LKR 599,218',
                  goal: 'LKR 1,000,000',
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Campaign Card Widget (no percentage + white Donate More button)
  static Widget _campaignCard({
    required String title,
    required String raised,
    required String goal,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Placeholder Image Banner
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Container(
                height: 160,
                width: double.infinity,
                color: Colors.black,
                child: const Center(
                  child: Text(
                    'Image',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'islandstudio\nA baby boy with bilateral cleft lip...',
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 10),

                  // Raised & Goal
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Raised : $raised'),
                          Text('Goal   : $goal'),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Donate More Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        // TODO: Handle donate click
                      },
                      child: const Text(
                        "Donate More",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
