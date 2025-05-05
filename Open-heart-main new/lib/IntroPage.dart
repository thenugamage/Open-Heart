import 'package:flutter/material.dart';
import 'SelectionPage.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Color.fromARGB(255, 17, 125, 183),
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 50),

            // App Logo
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Image.asset(
                  'Assets/JustLogo.png',
                  height: 40,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.broken_image,
                    size: 40,
                    color: Colors.red,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Main Title
            const Text(
              "Small change, big difference",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 40),

            // Collage of Child Images
            SizedBox(
              height: 500,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: _buildImage('Assets/child1.png', width: 110, height: 222),
                  ),
                  Positioned(
                    top: 50,
                    left: 115,
                    child: _buildImage('Assets/child2.png', width: 95, height: 210),
                  ),
                  Positioned(
                    top: 0,
                    right: 95,
                    child: _buildImage('Assets/child3.png', width: 100, height: 198),
                  ),
                  Positioned(
                    top: 30,
                    right: 0,
                    child: _buildImage('Assets/child4.png', width: 90, height: 233),
                  ),
                  Positioned(
                    top: 245,
                    left: 0,
                    child: _buildImage('Assets/child5.png', width: 102, height: 213),
                  ),
                  Positioned(
                    top: 260,
                    left: 95,
                    child: _buildImage('Assets/child6.png', width: 115, height: 262),
                  ),
                  Positioned(
                    top: 200,
                    right: 95,
                    child: _buildImage('Assets/child7.png', width: 100, height: 227),
                  ),
                  Positioned(
                    top: 280,
                    right: 0,
                    child: _buildImage('Assets/child8.png', width: 90, height: 201),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Get Started Button
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 8, 85, 124),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.white),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelectionPage(),
                    ),
                  );
                },
                child: const Text(
                  "Get started",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build image with fallback
  static Widget _buildImage(String imagePath, {required double width, required double height}) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey[300],
            child: const Icon(Icons.broken_image, size: 40),
          ),
        ),
      ),
    );
  }
}
