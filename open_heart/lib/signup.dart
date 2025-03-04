import 'package:flutter/material.dart';
import 'main.dart'; 


class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFF6AB1D7)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                "Assets/logo.png",
                height: 100,
              ),
              const SizedBox(height: 10),
              const Text(
                "Open Heart",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              // Email Field
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Your Email",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF003B5C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                "or continue with",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 10),

              // Apple Sign In Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.black),
                    ),
                  ),
                  icon: const Icon(Icons.apple, color: Colors.black),
                  label: const Text(
                    "Sign In with Apple",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Google Sign In Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.black),
                    ),
                  ),
                  icon: Image.asset(
                    "Assets/google.png",
                    height: 24,
                    width: 24,
                  ),
                  label: const Text(
                    "Sign In with Google",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Log In Link
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                  );
                },
                child: const Text.rich(
                  TextSpan(
                    text: "Have an Account? ",
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                    children: [
                      TextSpan(
                        text: "sign in",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
