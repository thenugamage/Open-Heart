import 'package:flutter/material.dart';
import 'main.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.blue.shade300],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 50),

            // Logo
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Image.asset(
                  'Assets/logo.png', // Updated path
                  height: 40,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Title
            const Text(
              "Small change, big difference",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 40),

            // **Collage Layout (Stack) with Correct Positions**
            SizedBox(
              height: 420,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(top: 0, left: 20, child: _buildImage('Assets/child1.png')),
                  Positioned(top: 30, left: 115, child: _buildImage('Assets/child2.png')),
                  Positioned(top: 0, right: 110, child: _buildImage('Assets/child3.png')),
                  Positioned(top: 30, right: 20, child: _buildImage('Assets/child4.png')),

                  Positioned(top: 180, left: 20, child: _buildImage('Assets/child5.png')),
                  Positioned(top: 210, left: 110, child: _buildImage('Assets/child6.png')),
                  Positioned(top: 180, right: 110, child: _buildImage('Assets/child7.png')),
                  Positioned(top: 210, right: 20, child: _buildImage('Assets/child8.png')),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // **Get Started Button**
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.white),
                  ),
                ),
                onPressed: () {
                  print("Get Started Pressed");
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

  // **Helper Function to Build Image with Equal Size**
  Widget _buildImage(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        imagePath,
        width: 95, // Same width for all images
        height: 170, // Same height for all images
        fit: BoxFit.cover,
      ),
    );
  }
}
