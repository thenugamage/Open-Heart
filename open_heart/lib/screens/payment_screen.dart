import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'payment_confirm_screen.dart';


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
  }

  Future<void> _fetchDonationData() async {
    final snapshot = await FirebaseFirestore.instance.collection('donations').doc(widget.docId).get();
    if (snapshot.exists) {
      setState(() {
        raised = int.tryParse(snapshot['raised'].toString()) ?? 0;
        goal = int.tryParse(snapshot['goal'].toString()) ?? 1000000;
      });
    }
  }

  void _submitDonation() async {
    final inputAmount = _amountController.text.trim();
    final amount = int.tryParse(inputAmount);

    if (amount == null || amount <= 0) {
      _showMessage("Please enter a valid amount.");
      return;
    }

    if (selectedMethod == null) {
      _showMessage("Please select a payment method.");
      return;
    }

    final docRef = FirebaseFirestore.instance.collection('donations').doc(widget.docId);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      final currentRaised = int.tryParse(snapshot['raised'].toString()) ?? 0;
      transaction.update(docRef, {'raised': currentRaised + amount});
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentConfirmationPage(
          title: widget.title,
          amount: amount,
        ),
      ),
    );
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
          icon: Image.asset('Assets/icons/back.png', height: 24), // Back button with image
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Donate to ${widget.title}', style: const TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView( // Wrap the main content with SingleChildScrollView to avoid overflow
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
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
            ),
            const SizedBox(height: 5),
            LinearProgressIndicator(
              value: (raised / goal).clamp(0.0, 1.0),
              color: Colors.blueAccent,
              backgroundColor: Colors.grey[300],
              minHeight: 6,
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Amount (LKR)',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 💳 Payment method selection
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _paymentOption('visa', 'Assets/icons/visa.png', 'Visa'),
                _paymentOption('master', 'Assets/icons/master.png', 'Master'),
                _paymentOption('paypal', 'Assets/icons/paypal.png', 'PayPal'),
              ],
            ),

            const SizedBox(height: 40),

            // 💳 Card details input
            Column(
              children: [
                TextField(
                  controller: _cardNumberController,
                  decoration: InputDecoration(
                    labelText: 'Card Number',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _expiryController,
                        decoration: InputDecoration(
                          labelText: 'MM/YY',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: _cvcController,
                        decoration: InputDecoration(
                          labelText: 'CVC',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _zipCodeController,
                  decoration: InputDecoration(
                    labelText: 'ZIP Code',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Proceed to Pay button
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
                child: const Text("Proceed to Pay", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
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
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
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
