import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

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
            // Back and Title
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                const Spacer(),
                const Text(
                  "Help & Support",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
            const SizedBox(height: 30),

            // Contact Options
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Need Assistance?",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  _supportTile(
                    context,
                    icon: Icons.email_outlined,
                    title: "Contact Support",
                    subtitle: "support@yourapp.com",
                    onTap: () {
                      // open mail client or support flow
                    },
                  ),
                  _supportTile(
                    context,
                    icon: Icons.chat_bubble_outline,
                    title: "Live Chat",
                    subtitle: "Chat with a support agent",
                    onTap: () {
                      // navigate to live chat
                    },
                  ),
                  _supportTile(
                    context,
                    icon: Icons.send,
                    title: "Submit a Request",
                    subtitle: "Get help from our team",
                    onTap: () {
                      _showSupportRequestDialog(context);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // FAQs
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Frequently Asked Questions",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  _faqItem("How to start a donation campaign?"),
                  _faqItem("How can I withdraw funds?"),
                  _faqItem("What if my payment fails?"),
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
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }

  Widget _supportTile(BuildContext context,
      {required IconData icon,
        required String title,
        required String subtitle,
        required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }

  Widget _faqItem(String question) {
    return ListTile(
      leading: const Icon(Icons.help_outline),
      title: Text(question),
      trailing: const Icon(Icons.keyboard_arrow_right),
      onTap: () {
        // Expand with answer or show dialog
      },
    );
  }

  // Submit Request Dialog
  void _showSupportRequestDialog(BuildContext context) {
    final subjectController = TextEditingController();
    final messageController = TextEditingController();
    String selectedCategory = 'Technical';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Submit a Request"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: subjectController,
                decoration: const InputDecoration(labelText: "Subject"),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                items: ['Technical', 'Payment', 'Account', 'Other']
                    .map((category) => DropdownMenuItem(
                  value: category,
                  child: Text(category),
                ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) selectedCategory = value;
                },
                decoration: const InputDecoration(labelText: "Category"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: messageController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: "Describe your issue",
                  alignLabelWithHint: true,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text("Submit"),
            onPressed: () async {
              if (subjectController.text.isEmpty ||
                  messageController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please fill all fields")),
                );
                return;
              }

              try {
                await FirebaseFirestore.instance
                    .collection('support_requests')
                    .add({
                  'subject': subjectController.text,
                  'category': selectedCategory,
                  'message': messageController.text,
                  'timestamp': FieldValue.serverTimestamp(),
                });

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Support request submitted")),
                );
              } catch (e) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error: ${e.toString()}")),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
