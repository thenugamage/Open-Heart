import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'navbar.dart';
import 'sidebar.dart';
import 'donate_details.dart';

class DonatePage extends StatelessWidget {
  const DonatePage({super.key});

  Widget buildCardFromData({
    required BuildContext context,
    required Map<String, dynamic> data,
    required String docId,
  }) {
    final imagePath = (data['imageUrl'] ?? 'Assets/help.png').toString().trim();
    final rawTitle = data['title'] ??
        data.entries.firstWhere(
              (e) => e.key.trim() == 'title',
          orElse: () => const MapEntry('title', ''),
        ).value;
    final title = rawTitle.toString().trim().isEmpty ? 'No Title' : rawTitle.toString().trim();
    final subtitle = (data['descriptions'] ?? '').toString().trim();
    final raisedAmount = int.tryParse(data['raised']?.toString().trim() ?? '0') ?? 0;
    final goalAmount = int.tryParse(data['goal']?.toString().trim() ?? '1000000') ?? 1000000;
    final progress = (raisedAmount / goalAmount).clamp(0.0, 1.0);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                imagePath.startsWith('http')
                    ? Image.network(imagePath, fit: BoxFit.cover)
                    : Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 120,
                    color: Colors.grey[200],
                    child: const Center(child: Icon(Icons.broken_image, size: 40)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green.shade700,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Double Your Donation",
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.black87)),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              color: Colors.blueAccent,
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Raised : LKR $raisedAmount", style: const TextStyle(fontSize: 13)),
              Text("Goal : LKR $goalAmount", style: const TextStyle(fontSize: 13)),
            ],
          ),
          const SizedBox(height: 14),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailsPage(
                      title: title,
                      description: subtitle,
                      imagePath: imagePath,
                      docId: docId,
                      organization: data['organization'] ?? 'Unknown Organization',
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 4,
              ),
              child: const Text("Donate Now", style: TextStyle(fontSize: 14)),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userPhoto = user?.photoURL ?? "https://i.pravatar.cc/150?img=9";
    final userName = user?.displayName ?? user?.email ?? "User";

    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      drawer: const NewNavBar(selectedIndex: 2),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFE3F2FD),
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        title: Builder(
          builder: (context) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: const AssetImage('Assets/icons/navbar.png'),
                  radius: 20,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(userPhoto),
                      radius: 24,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Hello $userName!",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const Text(
                      "Where you want go",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blueAccent),
                  ),
                  child: Image.asset("Assets/icons/search.png", height: 24, width: 24),
                ),
              ),
            ],
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('donations').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final docs = snapshot.data!.docs;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                "Featured Initiatives",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0B3D91),
                ),
              ),
              const SizedBox(height: 10),
              ...docs.map((doc) => buildCardFromData(
                context: context,
                data: doc.data() as Map<String, dynamic>,
                docId: doc.id,
              )),
            ],
          );
        },
      ),
      bottomNavigationBar: const CustomNavigationBar(selectedIndex: 2),
    );
  }
}