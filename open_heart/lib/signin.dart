// Created by Thenuri
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';
import 'signup.dart';
import 'home.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Email sign in method
  Future<void> _signInWithEmailAndPassword() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      
      // Authentication successful, navigate to home screen
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = _getMessageFromErrorCode(e.code);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_errorMessage ?? "An error occurred during sign in"),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      setState(() {
        _errorMessage = "An error occurred. Please try again later.";
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_errorMessage!),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Google sign in method
  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {

      // Initialize Google Sign In
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {

        // User canceled the sign-in process
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Obtain the auth details from the Google user
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with the credential
      await FirebaseAuth.instance.signInWithCredential(credential);


      // Authentication successful, navigate to verification screen
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = _getMessageFromErrorCode(e.code);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text(_errorMessage ?? "An error occurred during Google sign in"),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      setState(() {
        _errorMessage = "An error occurred. Please try again later.";
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_errorMessage!),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Convert Firebase error codes to user-friendly messages
  String _getMessageFromErrorCode(String errorCode) {
    switch (errorCode) {
      case "invalid-email":
        return "Your email address is invalid.";
      case "user-disabled":
        return "This user has been disabled.";
      case "user-not-found":
        return "No user found with this email.";
      case "wrong-password":
        return "Wrong password provided.";
      case "too-many-requests":
        return "Too many attempts. Please try again later.";
      case "operation-not-allowed":
        return "Operation not allowed. Please contact support.";
      case "network-request-failed":
        return "Network error. Please check your connection.";
      default:
        return "An error occurred. Please try again.";
    }
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Gradient Background
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    /// Back Button
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios, size: 26),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),

                    const SizedBox(height: 10),
                    Image.asset("Assets/logo.png", height: 105),
                    const SizedBox(height: 30),
                    const Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF08385F),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Your Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
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
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                            ),
                          ),
                        ],
                      ),
                    ),

                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 10, right: 10),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(
                              color: Colors.red, fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 250,
                      child: ElevatedButton(
                        onPressed: _signInWithEmailAndPassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 8, 85, 124),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "or continue with",
                      style: TextStyle(
                        color: Color(0xFF08385F),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: _signInWithGoogle,
                        icon: Image.asset("Assets/google.png", height: 24),
                        label: const Text(
                          "Sign In with Google",
                          style: TextStyle(
                              color: Color.fromARGB(255, 103, 143, 209),
                              fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()),
                        );
                      },
                      child: const Text.rich(
                        TextSpan(
                          text: "New User? ",
                          style:
                              TextStyle(color: Color(0xFF135A95), fontSize: 14),
                          children: [
                            TextSpan(
                              text: "Create Account",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

