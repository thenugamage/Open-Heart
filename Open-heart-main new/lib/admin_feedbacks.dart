import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AdminViewFeedbacks extends StatelessWidget {
  const AdminViewFeedbacks({super.key});

  String getMoodEmoji(String mood) {
    switch (mood.toLowerCase()) {
      case 'worst':
        return '💔'; // Emoji for "worst"
      case 'not good':
        return '😵'; // Emoji for "not good"
      case 'fine':
        return '😐'; // Emoji for "fine"
      case 'look good':
        return '🙂'; // Emoji for "look good"
      case 'very good':
        return '🤩'; // Emoji for "very good"
      default:
        return '❓'; // Default emoji if mood is unknown
    }
  }

  Color getMoodColor(String mood) {
    switch (mood.toLowerCase()) {
      case 'happy':
        return Colors.green;
      case 'fine':
        return Colors.blue;
      case 'sad':
        return Colors.orange;
      case 'angry':
        return Colors.redAccent;
      case 'excited':
        return Colors.purple;
      case 'look good':
        return Colors.teal;
      case 'worst':
        return Colors.brown;
      default:
        return Colors.grey;
    }
  }

  void _confirmDelete(BuildContext context, String docId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this feedback?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await FirebaseFirestore.instance.collection('feedbacks').doc(docId).delete();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Feedback deleted"), backgroundColor: Colors.redAccent),
              );
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE3F2FD),
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('Assets/icons/back.png', height: 24),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Image.asset('Assets/logo.png', height: 60),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          const Text(
            "Weekly Feedbacks",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D47A1),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('feedbacks')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return const Center(child: Text("Something went wrong"));
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final feedbackDocs = snapshot.data!.docs;

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: feedbackDocs.length,
                  itemBuilder: (context, index) {
                    final doc = feedbackDocs[index];
                    final data = doc.data() as Map<String, dynamic>;

                    final email = (data['email'] ?? 'Unknown').toString();
                    final comment = (data['comment'] ?? '').toString().trim();
                    final mood = (data['mood'] ?? 'unknown').toString().trim();
                    final timestamp = (data['timestamp'] as Timestamp?)?.toDate();
                    final formattedDate = timestamp != null
                        ? DateFormat('yyyy-MM-dd HH:mm:ss').format(timestamp)
                        : 'Unknown time';

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 🔹 Email with index
                          Row(
                            children: [
                              Text(
                                "${index + 1}. ",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black87,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  email,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // 🔹 Mood
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Text(getMoodEmoji(mood), style: const TextStyle(fontSize: 18)),
                              const SizedBox(width: 6),
                              Text(
                                mood.isNotEmpty ? mood : "Mood not provided",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: getMoodColor(mood),
                                ),
                              ),
                            ],
                          ),

                          // 🔹 Comment
                          const SizedBox(height: 10),
                          Text(
                            comment.isNotEmpty ? comment : 'No message provided',
                            style: const TextStyle(fontSize: 14),
                          ),

                          // 🔹 Date & Delete
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                formattedDate,
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              GestureDetector(
                                onTap: () => _confirmDelete(context, doc.id),
                                child: Image.asset('Assets/icons/delete.png', height: 24, width: 24),
                              ),
                            ],
                          ),
                        ],
                      ),
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
}
