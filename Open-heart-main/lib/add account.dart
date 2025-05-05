import 'package:flutter/material.dart';

class AddAccountScreen extends StatefulWidget {
  const AddAccountScreen({super.key});

  @override
  State<AddAccountScreen> createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
            // Back Button and Title
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
                  "Add Account",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const Spacer(flex: 2),
              ],
            ),
            const SizedBox(height: 20),

            // Account Details Form
            const Text(
              "Enter your account details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Email Input
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 20),

            // Password Input
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 20),

            // Button to add the account
            ElevatedButton(
              onPressed: () {
                // Handle the adding of the account (e.g., Firebase authentication)
                String email = _emailController.text;
                String password = _passwordController.text;

                // Example: Call Firebase to register or link the account here

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Account added successfully")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade900,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text("Add Account"),
            ),
            const SizedBox(height: 20),

            // Option to link Google or other accounts
            const Text(
              "OR Link a social account",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),

            // Google Login Button
            ElevatedButton.icon(
              onPressed: () {
                // Trigger Google Login or other third-party account linking here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade900,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              icon: const Icon(Icons.account_circle),
              label: const Text("Link with Google"),
            ),
            const SizedBox(height: 10),

            // Option to link Facebook
            ElevatedButton.icon(
              onPressed: () {
                // Trigger Facebook login or account linking here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade800,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              icon: const Icon(Icons.facebook),
              label: const Text("Link with Facebook"),
            ),
          ],
        ),
      ),
    );
  }
}
