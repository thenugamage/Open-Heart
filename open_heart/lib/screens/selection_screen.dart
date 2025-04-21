// Created by Thenuri
import 'package:flutter/material.dart';
import 'signin_screen.dart';
import '../admin/screens/admin_signin_screen.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({super.key});

  @override
  SelectionScreenState createState() => SelectionScreenState();
}

class SelectionScreenState extends State<SelectionScreen> {
  int _currentStep = 0;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background Gradient
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Color(0xFF117DB7)],
              ),
            ),
          ),

          /// Background Image
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            bottom: 0,
            child: Opacity(
              opacity: 0.8,
              child: Image.asset(
                'Assets/backgroundimg.png',
                width: 300,
                height: 400,
              ),
            ),
          ),

          /// Page Content
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),

                  /// Back Button
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, size: 26),
                      onPressed: () {
                        if (_currentStep == 2) {
                          setState(() {
                            _currentStep = 1;
                            _errorMessage = null;
                          });
                        } else {
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// Logo
                  Image.asset("Assets/logo.png", height: 100),

                  const SizedBox(height: 10),

                  const SizedBox(height: 20),

                  /// Page Title
                  const Text(
                    "Selection",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF08385F),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// Error Message Display
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  // User Button
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignInScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 8, 85, 124),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text(
                        "User",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Admin Panel Button
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AdminPanelScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 8, 85, 124),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text(
                        "Admin Panel",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



