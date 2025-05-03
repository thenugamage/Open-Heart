import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'keys.dart';

class PaymentPage extends StatefulWidget {
  final dynamic donation; // Firestore DocumentSnapshot

  const PaymentPage({super.key, required this.donation});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  double amount = 0;
  Map<String, dynamic>? intentPaymentData;

  @override
  void initState() {
    super.initState();
    final raisedAmount = widget.donation['raised'];
    try {
      amount =
          double.tryParse(raisedAmount.replaceAll(RegExp(r'[^\d.]'), '')) ??
              156;
    } catch (_) {
      amount = 156;
    }
  }

  Future<void> showPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((_) {
        intentPaymentData = null;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Payment Successful")),
        );
      }).onError((error, stackTrace) {
        if (kDebugMode) {
          print("Error: $error\nStackTrace: $stackTrace");
        }
      });
    } on StripeException catch (e) {
      if (kDebugMode) print("Stripe Exception: $e");
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(content: Text("Payment Cancelled")),
      );
    } catch (e) {
      if (kDebugMode) print("Exception: $e");
    }
  }

  Future<Map<String, dynamic>?> makeIntentPayment(
      String amount, String currency) async {
    try {
      final body = {
        "amount": (int.parse(amount) * 100).toString(),
        "currency": currency,
        "payment_method_types[]": "card",
      };

      final response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        body: body,
        headers: {
          "Authorization": "Bearer $Secretkey",
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );

      return jsonDecode(response.body);
    } catch (e) {
      if (kDebugMode) print("makeIntentPayment error: $e");
      return null;
    }
  }

  Future<void> paymentSheetInitialization(
      String amount, String currency) async {
    try {
      intentPaymentData = await makeIntentPayment(amount, currency);
      if (intentPaymentData != null) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            allowsDelayedPaymentMethods: true,
            paymentIntentClientSecret: intentPaymentData!["client_secret"],
            style: ThemeMode.dark,
            merchantDisplayName: "Your Company",
          ),
        );
        await showPaymentSheet();
      }
    } catch (e, s) {
      if (kDebugMode) {
        print("Initialization error: $e");
        print("StackTrace: $s");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.donation;

    return Scaffold(
      backgroundColor: const Color(0xFFB6E3F2),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0F7FA), Color(0xFFB6E3F2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage('Assets/profile.png'),
                  ),
                  title: RichText(
                    text: const TextSpan(
                      text: 'Hello ',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Saduni Silva!\n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: 'Where you want go',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.pinkAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    data['title'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      shadows: [
                        Shadow(
                            color: Colors.black26,
                            offset: Offset(2, 2),
                            blurRadius: 3),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, size: 18),
                      const SizedBox(width: 5),
                      Text(data['organization']),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purpleAccent,
                          minimumSize: const Size(80, 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          data['label1'] ?? '',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(thickness: 1.0, height: 20),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage('Assets/hoster.png'),
                  ),
                  title: Text(
                    data['organization'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text('Hosted By'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(data['description']),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      data['imageUrl'],
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      paymentSheetInitialization(
                          amount.round().toString(), "USD");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF005691),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Donate Now",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          const BottomNavigationBarItem(
              icon: Icon(Icons.location_city), label: ''),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueAccent,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(2, 2))
                ],
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.volunteer_activism,
                  size: 30, color: Colors.white),
            ),
            label: '',
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
          const BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
