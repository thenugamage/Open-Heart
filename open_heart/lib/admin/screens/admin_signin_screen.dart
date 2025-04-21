import 'package:flutter/material.dart';
import 'admin_home_screen.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  int _currentStep = 1;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleAdminLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    print('Admin login -> Email: $email | Password: $password');
    // Add authentication logic here
  }

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
                    "Admin Sign In",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF08385F),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// Email & Password Fields
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Error Message
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  const SizedBox(height: 30),

                  /// Sign In Button
                    SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                      Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => AdminHomePage()),
                  );
                      },
                      style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 8, 85, 124),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text(
                      "Sign in",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
