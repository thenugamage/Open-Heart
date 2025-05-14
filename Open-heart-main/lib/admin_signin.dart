import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'selectionPage.dart';
import 'admin_dashboard.dart';

class AdminSignInPage extends StatefulWidget {
  const AdminSignInPage({super.key});

  @override
  State<AdminSignInPage> createState() => _AdminSignInPageState();
}

class _AdminSignInPageState extends State<AdminSignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  final _auth = FirebaseAuth.instance;

  Future<void> _signInAdmin() async {
    setState(() => _isLoading = true);

    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final isAdmin = userCredential.user?.email == 'admin@openheart.com';

      if (isAdmin) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AdminDashboardPage()),
        );
      } else {
        FirebaseAuth.instance.signOut();
        _showError("Access denied. Not an admin.");
      }
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? "Sign in failed");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _resetPassword() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      _showError("Please enter your email to reset password.");
      return;
    }
    try {
      await _auth.sendPasswordResetEmail(email: email);
      _showError("Password reset link sent to $email");
    } catch (e) {
      _showError("Failed to send reset link: ${e.toString()}");
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE3F2FD), Color(0xFF0074cc)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Centered heart background image
          Center(
            child: Opacity(
              opacity: 0.08,
              child: Image.asset(
                'Assets/backgroundimg.png', // Make sure this image exists
                width: 500,
                height: 500,
                fit: BoxFit.contain,
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 28, vertical: 32),
                child: Column(
                  children: [
                    // 🔙 Back button
                    Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () =>
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const SelectionScreen()),
                            ),
                        child: Image.asset('Assets/icons/back.png', height: 28), // Back button image
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 🧡 Logo
                    Image.asset('Assets/logo.png', height: 100), // Ensure logo image exists
                    const SizedBox(height: 10),

                    const Text(
                      "Admin Sign In",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff093f6c),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // 📧 Email input
                    _buildInput("Email", _emailController),

                    // 🔒 Password input
                    _buildInput(
                        "Password", _passwordController, isPassword: true),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _resetPassword,
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 🔘 Sign In Button
                    _isLoading
                        ? const CircularProgressIndicator()
                        : SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _signInAdmin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff093f6c),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 5,
                        ),
                        child: const Text(
                          "Sign in",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInput(String hint, TextEditingController controller,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? _obscurePassword : false,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIcon: isPassword
              ? IconButton(
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
            icon: Image.asset(
              'Assets/icons/eye.png', // Make sure this file exists
              height: 22,
              width: 22,
            ),
          )
              : null,
        ),
      ),
    );
  }
}
