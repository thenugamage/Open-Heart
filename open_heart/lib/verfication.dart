import 'package:flutter/material.dart';
import 'VerificationSuccess.dart';
import 'VerificationFailed.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerificationScreen extends StatefulWidget {
  final String email;
  final String correctOtp;

  const VerificationScreen({super.key, required this.email, required this.correctOtp});

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    4,
    (index) => FocusNode(),
  );

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _verifyOtp() async {
    // Combine all digits
    String enteredOtp = _otpControllers.map((controller) => controller.text).join();
    
    if (enteredOtp.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all 4 digits')),
      );
      return;
    }

    if (enteredOtp == widget.correctOtp) {
      // OTP is correct
      try {
        // Mark the user's email as verified in Firebase
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await user.reload();
        }
        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const VerificationSuccess()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } else {
      // OTP is incorrect
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const VerificationFailed()),
      );
    }
  }

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
            colors: [Colors.white, Color(0xFF117DB7)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("Assets/logo.png", height: 105),
              const SizedBox(height: 20),
              const Text(
                "Verify Email",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF08385F),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "We have sent a 4-digit code to",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF08385F),
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                widget.email,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF08385F),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              
              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                  (index) => SizedBox(
                    width: 60,
                    height: 60,
                    child: TextField(
                      controller: _otpControllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: "",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(fontSize: 24),
                      onChanged: (value) {
                        // Auto focus to next field
                        if (value.isNotEmpty && index < 3) {
                          _focusNodes[index + 1].requestFocus();
                        }
                      },
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Continue Button
              SizedBox(
                width: 250,
                child: ElevatedButton(
                  onPressed: _verifyOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF013F68),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    "Verify",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Resend OTP Link
              GestureDetector(
                onTap: () async {
                  try {
                    // Re-send the OTP
                    User? user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      await user.sendEmailVerification();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('OTP resent successfully')),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${e.toString()}')),
                    );
                  }
                },
                child: const Text(
                  "Didn't receive the code? Resend",
                  style: TextStyle(
                    color: Color(0xFF08385F),
                    fontWeight: FontWeight.bold,
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