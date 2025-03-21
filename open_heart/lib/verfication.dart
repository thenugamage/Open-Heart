// //Created by  Thenuri
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class OTPVerificationScreen extends StatelessWidget {
  const OTPVerificationScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
	return Scaffold(
	  body: Container(
		width: double.infinity,
		decoration: const BoxDecoration(
		  gradient: LinearGradient(
			begin: Alignment.topCenter,
			end: Alignment.bottomCenter,
			colors: [Color(0xFFE3F2FD), Color(0xFF64B5F6)],
		  ),
		),
		child: Padding(
		  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
		  child: Column(
			crossAxisAlignment: CrossAxisAlignment.center,
			children: [
			  // **Back Button**
			  Align(
				alignment: Alignment.topLeft,
				child: IconButton(
				  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
				  onPressed: () => Navigator.pop(context),
				),
			  ),
			  const SizedBox(height: 20),
			  // **Logo**
			  Image.asset(
				'assets/open_heart_logo.png',
				height: 80,
			  ),
			  const SizedBox(height: 10),
			  // **Title**
			  Text(
				"Open Heart",
				style: GoogleFonts.poppins(
				  fontSize: 22,
				  fontWeight: FontWeight.bold,
				  color: Colors.black,
				),
			  ),
			  const SizedBox(height: 10),
			  // **Verification Heading**
			  Text(
				"Verification",
				style: GoogleFonts.poppins(
				  fontSize: 26,
				  fontWeight: FontWeight.bold,
				  color: Colors.black87,
				),
			  ),
			  const SizedBox(height: 10),
			  // **Verification Message**
			  Text(
				"‘We’ve sent a 4-digit verification code to your email. Please enter the OTP code below to continue.’",
				textAlign: TextAlign.center,
				style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
			  ),
			  const SizedBox(height: 20),
			  // **OTP Input Field**
			  Pinput(
				length: 4,
				keyboardType: TextInputType.number,
				defaultPinTheme: PinTheme(
				  width: 60,
				  height: 60,
				  textStyle: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
				  decoration: BoxDecoration(
					borderRadius: BorderRadius.circular(10),
					border: Border.all(color: Colors.blueAccent),
				  ),
				),
			  ),
			  const SizedBox(height: 20),
			  // **Continue Button**
			  _buildButton("Continue", onPressed: () {
				// Handle OTP verification
			  }),
			  const SizedBox(height: 10),
			  // **Resend Button**
			  TextButton(
				onPressed: () {
				  // Handle OTP resend
				},
				child: Text(
				  "Resend",
				  style: GoogleFonts.poppins(fontSize: 14, color: Colors.blueAccent),
				),
			  ),
			  const SizedBox(height: 20),
			  // **Terms & Policy Notice**
			  Text(
				"By clicking the Continue button, you agree to the terms of service and privacy policy.",
				textAlign: TextAlign.center,
				style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54),
			  ),
			],
		  ),
		),
	  ),
	);
  }
  // **Reusable Continue Button**
  Widget _buildButton(String text, {required VoidCallback onPressed}) {
	return SizedBox(
	  width: double.infinity,
	  height: 50,
	  child: ElevatedButton(
		style: ElevatedButton.styleFrom(
		  backgroundColor: const Color(0xFF064B6D),
		  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
		),
		onPressed: onPressed,
		child: Text(
		  text,
		  style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
		),
	  ),
	);
  }
}
