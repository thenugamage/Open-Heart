import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'navigationbar.dart';
import 'payment.dart';

class FeaturedInitiativesPage extends StatefulWidget {
  const FeaturedInitiativesPage({super.key});

  @override
  State<FeaturedInitiativesPage> createState() =>
      _FeaturedInitiativesPageState();
}

class _FeaturedInitiativesPageState extends State<FeaturedInitiativesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomNavigationBar(),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color.fromARGB(255, 17, 125, 183)],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.menu, size: 30, color: Colors.black),
                  Row(
                    children: const [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('Assets/profile.png'),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Hello Saduni Silva!",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Icon(Icons.search, size: 30, color: Colors.black),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Featured Initiatives",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('donations')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final donations = snapshot.data?.docs ?? [];

                  return ListView.builder(
                    itemCount: donations.length,
                    itemBuilder: (context, index) {
                      final doc = donations[index];
                      return _buildDonationCard(
                        context: context,
                        image: doc['imageUrl'],
                        title: doc['title'],
                        description: doc['description'],
                        progress: doc['progress'],
                        raised: doc['raised'],
                        goal: doc['goal'],
                        bgColor: Colors.blue.shade100,
                        label1: doc['label1'],
                        label2: doc['label2'],
                        organization: doc['organization'],
                        donationDoc: doc,
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDonationCard({
    required BuildContext context,
    required String image,
    required String title,
    required String description,
    required double progress,
    required String raised,
    required String goal,
    required Color bgColor,
    String? label1,
    String? label2,
    String organization = "Islandwide",
    required DocumentSnapshot donationDoc,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.asset(
                    image,
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                  if (label1 != null || label2 != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (label1 != null)
                            _buildLabel(label1, Colors.black87),
                          if (label2 != null) _buildLabel(label2, Colors.green),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            _buildCardDetails(
                title, description, progress, raised, goal, organization),
            Padding(
              padding: const EdgeInsets.all(15),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentPage(donation: donationDoc),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Center(
                  child: Text(
                    'Donate Now',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text, Color color) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  Widget _buildCardDetails(String title, String description, double progress,
      String raised, String goal, String organization) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.verified_user, size: 16, color: Colors.black54),
              const SizedBox(width: 5),
              Text(organization, style: const TextStyle(fontSize: 12)),
            ],
          ),
          const SizedBox(height: 5),
          Text(description, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade300,
            color: Colors.blue.shade900,
            minHeight: 8,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Raised: $raised",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text("Goal: $goal", style: const TextStyle(color: Colors.teal)),
            ],
          ),
        ],
      ),
    );
  }
}
