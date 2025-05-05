import 'package:flutter/material.dart';

class TermsAndPoliciesScreen extends StatelessWidget {
  const TermsAndPoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color.fromARGB(255, 17, 125, 183)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          children: [
            // Back Button
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context); // Navigate back to the previous screen
                  },
                ),
                const Spacer(),
                const Text(
                  "Terms and Policies",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const Spacer(flex: 2),
              ],
            ),
            const SizedBox(height: 20),

            // Terms and Policies Content
            const Text(
              "Terms and Conditions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Please read our Terms and Policies carefully before using our app. By using this application, you agree to the following terms...",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),

            // Scrollable Content for Terms and Conditions
            const Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa. Vestibulum lacinia arcu eget nulla. ...",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 30),

            // Accept Terms Button
            ElevatedButton(
              onPressed: () {
                // Action to accept terms (e.g., navigate to another screen or save the acceptance)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Terms accepted")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade900,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text("Accept Terms"),
            ),
          ],
        ),
      ),
    );
  }
}
