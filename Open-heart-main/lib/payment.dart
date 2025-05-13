import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'payment conform.dart';
import 'services/email_service.dart';

class PaymentPage extends StatefulWidget {
  final String docId;
  final String title;
  final String organization;
  final String imageUrl;

  const PaymentPage({
    super.key,
    required this.docId,
    required this.title,
    required this.organization,
    required this.imageUrl,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvcController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();

  int raised = 0;
  int goal = 1000000;
  String? selectedMethod;

  @override
  void initState() {
    super.initState();
    _fetchDonationData();
    _prefillUserEmail();
  }

  void _prefillUserEmail() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _emailController.text = user.email ?? '';
    }
  }

  Future<void> _fetchDonationData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('donations')
        .doc(widget.docId)
        .get();
    if (snapshot.exists) {
      setState(() {
        raised = int.tryParse(snapshot['raised'].toString()) ?? 0;
        goal = int.tryParse(snapshot['goal'].toString()) ?? 1000000;
      });
    }
  }

  void _submitDonation() async {
    final inputAmount = _amountController.text.trim();
    final email = _emailController.text.trim();
    final zipCode = _zipCodeController.text.trim();
    final expiry = _expiryController.text.trim();

    final amount = int.tryParse(inputAmount);
    if (amount == null || amount <= 0) {
      _showMessage("Enter a valid donation amount (LKR). Amount must be numeric.");
      return;
    }

    if (email.isEmpty || !email.contains("@")) {
      _showMessage("Enter a valid email address.");
      return;
    }

    if (selectedMethod == null) {
      _showMessage("Please select a payment method.");
      return;
    }

    final zipRegex = RegExp(r'^\d{5}$');
    if (!zipRegex.hasMatch(zipCode)) {
      _showMessage("ZIP Code must be exactly 5 digits.");
      return;
    }

    final expiryRegex = RegExp(r'^(0[1-9]|1[0-2])/\d{2}$');
    if (!expiryRegex.hasMatch(expiry)) {
      _showMessage("Expiry date must be in MM/YY format.");
      return;
    }

    // ✅ Update donation campaign 'raised' amount
    final docRef = FirebaseFirestore.instance.collection('donations').doc(widget.docId);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      final currentRaisedRaw = snapshot.data()?['raised'];
      int currentRaised;

      if (currentRaisedRaw is int) {
        currentRaised = currentRaisedRaw;
      } else if (currentRaisedRaw is String) {
        currentRaised = int.tryParse(currentRaisedRaw) ?? 0;
      } else {
        currentRaised = 0;
      }

      transaction.update(docRef, {'raised': currentRaised + amount});
    });

    // ✅ Save to 'transactions' collection
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('transactions').add({
        'userId': user.uid,
        'campaign': widget.title,
        'amount': amount,
        'status': 'success',
        'timestamp': FieldValue.serverTimestamp(),
      });
    }

    // ✅ Send email confirmation
    await EmailSender.sendEmailConfirmation(context, email, amount);

    // ✅ Navigate to confirmation screen
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PaymentConfirmationPage(
            title: widget.title,
            amount: amount,
          ),
        ),
      );
    });
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.redAccent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE3F2FD),
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('Assets/icons/back.png', height: 24),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Donate to ${widget.title}',
            style: const TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: widget.imageUrl.startsWith('http')
                  ? NetworkImage(widget.imageUrl)
                  : AssetImage(widget.imageUrl) as ImageProvider,
              radius: 40,
            ),
            const SizedBox(height: 10),
            Text(
              widget.organization,
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(widget.title, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Text(
              "Raised: LKR $raised / Goal: LKR $goal",
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87),
            ),
            const SizedBox(height: 5),
            LinearProgressIndicator(
              value: (raised / goal).clamp(0.0, 1.0),
              color: Colors.blueAccent,
              backgroundColor: Colors.grey[300],
              minHeight: 6,
            ),
            const SizedBox(height: 30),
            _buildTextField(_emailController, 'Your Email', TextInputType.emailAddress),
            const SizedBox(height: 16),
            _buildTextField(_amountController, 'Enter Amount (LKR)', TextInputType.number),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _paymentOption('visa', 'Assets/icons/visa.png', 'Visa'),
                _paymentOption('master', 'Assets/icons/master.png', 'Master'),
                _paymentOption('paypal', 'Assets/icons/paypal.png', 'PayPal'),
              ],
            ),
            const SizedBox(height: 40),
            _buildTextField(_cardNumberController, 'Card Number', TextInputType.number),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(_expiryController, 'MM/YY', TextInputType.number),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTextField(_cvcController, 'CVC', TextInputType.number),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildTextField(_zipCodeController, 'ZIP Code', TextInputType.number),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _submitDonation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text("Proceed to Pay",
                    style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, TextInputType inputType) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _paymentOption(String method, String imagePath, String label) {
    final isSelected = selectedMethod == method;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMethod = method;
        });
      },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 40,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected ? Colors.green : Colors.transparent,
                width: 2,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Image.asset(imagePath),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}