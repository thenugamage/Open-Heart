import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  double totalDonations = 0.0;
  List<Map<String, dynamic>> recentTransactions = [];

  @override
  void initState() {
    super.initState();
    _fetchDonationData();
  }

  Future<void> _fetchDonationData() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('transactions')
          .where('userId', isEqualTo: userId)
          .where('status', isEqualTo: 'success')
          .orderBy('timestamp', descending: true)
          .limit(10)
          .get();

      double total = 0.0;
      List<Map<String, dynamic>> transactions = [];

      for (var doc in snapshot.docs) {
        final data = doc.data();

        final amount = (data['amount'] as num?)?.toDouble() ?? 0.0;
        final campaign = data['campaign']?.toString() ?? 'Unknown Campaign';
        final status = data['status']?.toString() ?? 'unknown';

        total += amount;

        transactions.add({
          'campaign': campaign,
          'amount': amount,
          'status': status,
        });
      }

      setState(() {
        totalDonations = total;
        recentTransactions = transactions;
      });
    } catch (e) {
      print("⚠️ Error fetching transactions: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color.fromARGB(255, 17, 125, 183)],
          ),
        ),
        child: ListView(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Image.asset('Assets/icons/back.png', height: 24),
                  onPressed: () => Navigator.pop(context),
                ),
                const Spacer(),
                const Text(
                  "Wallet",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
            const SizedBox(height: 20),

            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Total Donations Made",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 10),
                  Text("Rs. ${totalDonations.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _actionButton(context, "Add Funds", Icons.add),
                      const SizedBox(width: 10),
                      _actionButton(context, "Withdraw", Icons.arrow_upward),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Recent Transactions",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 10),
                  if (recentTransactions.isEmpty)
                    const Text("No recent transactions."),
                  ...recentTransactions.map((tx) => _transactionTile(
                    "Donation to '${tx['campaign']}'",
                    "Rs. ${tx['amount']}",
                    tx['status'] == 'success',
                  )),
                ],
              ),
            ),

            const SizedBox(height: 20),

            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Linked Payment Methods",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: const Icon(Icons.credit_card),
                    title: const Text("Visa •••• 1234"),
                    trailing: const Icon(Icons.delete_outline),
                    onTap: () {
                      // Remove card logic
                    },
                  ),
                  const SizedBox(height: 5),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text("Add New Card"),
                    onPressed: () => _showAddCardDialog(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      side: const BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F4FD),
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }

  Widget _actionButton(BuildContext context, String label, IconData icon) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: () {
          if (label == "Add Funds") {
            _showAddFundsDialog(context);
          } else {
            _showWithdrawDialog(context);
          }
        },
        icon: Icon(icon, size: 18),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade900,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _transactionTile(String title, String amount, bool success) {
    return ListTile(
      leading: Icon(
        success ? Icons.check_circle : Icons.error,
        color: success ? Colors.green : Colors.red,
      ),
      title: Text(title),
      trailing: Text(
        amount,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      dense: true,
      visualDensity: const VisualDensity(vertical: -2),
    );
  }

  void _showAddFundsDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Funds"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: "Enter amount"),
        ),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text("Confirm"),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Added Rs. ${controller.text}")),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showWithdrawDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Withdraw Funds"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: "Enter amount"),
        ),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text("Withdraw"),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Withdraw requested: Rs. ${controller.text}")),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showAddCardDialog(BuildContext context) {
    final nameController = TextEditingController();
    final numberController = TextEditingController();
    final expiryController = TextEditingController();
    final cvvController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add New Card"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Cardholder Name"),
            ),
            TextField(
              controller: numberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Card Number"),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: expiryController,
                    decoration: const InputDecoration(labelText: "Expiry Date"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: cvvController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "CVV"),
                    obscureText: true,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text("Save"),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Card added successfully")),
              );
            },
          ),
        ],
      ),
    );
  }
}
