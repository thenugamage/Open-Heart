import 'package:flutter/material.dart';
import 'signin.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color.fromARGB(255, 17, 125, 183)],
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
                  'Assets/JustLogo.png',
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
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            
            const SizedBox(height: 40),
            
            // **Collage Layout (Stack) with Correct Positions**
            SizedBox(
              height: 500,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(top: 0, left: 0, child: SizedBox(width: 110, height: 222, child: _buildImage('Assets/child1.png'))),
                  Positioned(top: 50, left: 115, child: SizedBox(width: 95, height: 210, child: _buildImage('Assets/child2.png'))),
                  Positioned(top: 0, right: 95, child: SizedBox(width: 100, height: 198, child: _buildImage('Assets/child3.png'))),
                  Positioned(top: 30, right: 0, child: SizedBox(width: 90, height: 233, child: _buildImage('Assets/child4.png'))),
                  
                  Positioned(top: 245, left: 0, child: SizedBox(width: 102, height: 213, child: _buildImage('Assets/child5.png'))),
                  Positioned(top: 260, left: 95, child: SizedBox(width: 115, height: 262, child: _buildImage('Assets/child6.png'))),
                  Positioned(top: 200, right: 95, child: SizedBox(width: 100, height: 227, child: _buildImage('Assets/child7.png'))),
                  Positioned(top: 280, right: 0, child: SizedBox(width: 90, height: 201, child: _buildImage('Assets/child8.png'))),
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
                  backgroundColor: const Color.fromARGB(255, 8, 85, 124),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.white),
                  ),
                ),
                onPressed: () {
                  // Navigate to SignInScreen when button is pressed
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => SignInScreen()),
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
  
  // **Helper Function to Build Image with Equal Size**
  Widget _buildImage(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        imagePath,
        height: 222,
        width: 80,
        fit: BoxFit.cover,
      ),
    );
  }
}