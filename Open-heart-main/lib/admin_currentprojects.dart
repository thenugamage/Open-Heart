import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class AdminCurrentProjects extends StatelessWidget {
  const AdminCurrentProjects({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final formatter = NumberFormat.decimalPattern();

    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE3F2FD),
        elevation: 0,
        centerTitle: true,
        title: Column(
          children: [
            Image.asset('Assets/logo.png', height: 60),
          ],
        ),
        leading: IconButton(
          icon: Image.asset('Assets/icons/back.png', height: 24),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(Icons.person_outline),
          ),
        ],
      ),
      body: Column(
        children: [
          if (user != null)
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.photoURL ?? ''),
                    radius: 16,
                    backgroundColor: Colors.grey[300],
                  ),
                  const SizedBox(width: 8),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: "Hello ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: user.displayName ?? 'Admin',
                        ),
                      ],
                    ),
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          const Text(
            "Where you want go",
            style: TextStyle(color: Colors.redAccent, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('donations').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text("Error loading projects"));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No donation campaigns found"));
                }

                final docs = snapshot.data!.docs;

                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>;
                    final docId = docs[index].id;

                    final title = (data['title'] ?? '').toString().trim();
                    final description = (data['description'] ?? data['descriptions'] ?? 'No description provided').toString().trim();
                    final goal = int.tryParse((data['goal'] ?? '').toString().replaceAll(",", "").trim()) ?? 0;
                    final raised = int.tryParse((data['raised'] ?? '').toString().replaceAll(",", "").trim()) ?? 0;
                    final rawImage = (data['imageUrl'] ?? '').toString().trim();
                    final image = rawImage.isEmpty ? 'Assets/help.png' : rawImage;

                    return _buildDonationCard(
                      context,
                      docId: docId,
                      image: image,
                      title: title,
                      description: description,
                      raised: raised,
                      goal: goal,
                      formatter: formatter,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDonationCard(
      BuildContext context, {
        required String docId,
        required String image,
        required String title,
        required String description,
        required int raised,
        required int goal,
        required NumberFormat formatter,
      }) {
    final isNetworkImage = image.startsWith('http');

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0D47A1),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: isNetworkImage
                ? Image.network(
              image,
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                debugPrint('❌ Network image failed: $image');
                return Container(
                  height: 140,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
                  ),
                );
              },
            )
                : Image.asset(
              image,
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                debugPrint('❌ Asset image failed: $image');
                return Container(
                  height: 140,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text("Raised :    LKR ${formatter.format(raised)}", style: const TextStyle(color: Colors.white)),
          Text("Goal     :    LKR ${formatter.format(goal)}", style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Confirm Delete'),
                      content: const Text('Are you sure you want to delete this project?'),
                      actions: [
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () => Navigator.pop(ctx),
                        ),
                        TextButton(
                          child: const Text('Delete', style: TextStyle(color: Colors.red)),
                          onPressed: () {
                            FirebaseFirestore.instance.collection('donations').doc(docId).delete();
                            Navigator.pop(ctx);
                          },
                        ),
                      ],
                    ),
                  );
                },
                child: Image.asset(
                  'Assets/icons/delete.png',
                  height: 28,
                  width: 28,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
