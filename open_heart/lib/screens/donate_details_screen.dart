import 'package:flutter/material.dart';
import 'payment_screen.dart';
class DetailsPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final String docId;
  final String organization;

  const DetailsPage({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.docId,
    required this.organization,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Image.asset('Assets/icons/back.png', height: 24),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  const Text(
                    "Donate Details",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    const Shadow(
                      color: Colors.black26,
                      offset: Offset(1, 2),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Image.asset("Assets/icons/1.png", height: 18),
                  const SizedBox(width: 6),
                  const Text("Islandwide", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.pink.shade200,
                    ),
                    child: const Text("Healthcare", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              const Divider(height: 30),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: imagePath.startsWith('http')
                        ? Image.network(imagePath, height: 44, width: 44, fit: BoxFit.cover)
                        : Image.asset(imagePath, height: 44, width: 44, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(organization, style: const TextStyle(fontWeight: FontWeight.bold)),
                      const Text("Hosted By", style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: const TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 20),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: imagePath.startsWith('http')
                      ? Image.network(imagePath, height: 200, fit: BoxFit.cover)
                      : Image.asset(imagePath, height: 200, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the PaymentPage with the relevant data
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PaymentPage(
                          docId: docId,
                          title: title,
                          organization: organization,
                          imageUrl: imagePath,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: Colors.white70),
                    ),
                  ),
                  child: const Text("Donate Now", style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}