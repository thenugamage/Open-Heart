import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'donate.dart';

class PaymentConfirmationPage extends StatelessWidget {
  final String title;
  final int amount;

  const PaymentConfirmationPage({
    super.key,
    required this.title,
    required this.amount,
  });

  Future<void> _assignPointsToUser(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final int points = (amount / 100).floor(); // ✅ 12000 -> 120 points
// ✅ Correct points calculation

      final userRef = FirebaseFirestore.instance.collection('leaderboard').doc(user.uid);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final snapshot = await transaction.get(userRef);
        final currentPoints = (snapshot.data()?['points'] ?? 0) as int;

        transaction.set(userRef, {
          'displayName': user.displayName ?? user.email ?? 'User',
          'email': user.email ?? '',
          'photoURL': user.photoURL ?? '',
          'points': currentPoints + points,
        }, SetOptions(merge: true));
      });

      // 🎉 Show popup
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text("🎉 Congratulations!"),
            content: Text("You earned $points points for your donation."),
            actions: [
              TextButton(
                child: const Text("View Leaderboard"),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/leaderboard');
                },
              ),
              TextButton(
                child: const Text("Close"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Trigger point logic after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _assignPointsToUser(context);
    });

    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("Assets/icons/success.png", height: 100),
              const SizedBox(height: 20),
              const Text(
                "Donation Successful!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 12),
              Text(
                "Thank you for donating LKR $amount to '$title'!",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.email_outlined, color: Colors.green),
                  SizedBox(width: 8),
                  Text(
                    "Confirmation email sent to your gmail.",
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const DonatePage()),
                          (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B2C70),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Back to Home",
                    style: TextStyle(fontSize: 16, color: Colors.white, letterSpacing: 0.5),
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
