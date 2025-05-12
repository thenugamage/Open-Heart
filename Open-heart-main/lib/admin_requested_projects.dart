import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'addnew_project.dart';

class AdminCharityCampaignsPage extends StatefulWidget {
  const AdminCharityCampaignsPage({Key? key}) : super(key: key);

  @override
  State<AdminCharityCampaignsPage> createState() => _AdminCharityCampaignsPageState();
}

class _AdminCharityCampaignsPageState extends State<AdminCharityCampaignsPage> {
  int totalRequests = 0;
  bool showMore = false;

  @override
  void initState() {
    super.initState();
    fetchTotalRequests();
  }

  Future<void> fetchTotalRequests() async {
    final snapshot = await FirebaseFirestore.instance.collection('charity_campaigns').get();
    setState(() {
      totalRequests = snapshot.docs.length;
    });
  }

  Future<void> deleteProject(String docId) async {
    try {
      await FirebaseFirestore.instance.collection('charity_campaigns').doc(docId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Project deleted successfully.")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting project: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset('Assets/icons/back.png', height: 28),
                  ),
                  const Spacer(),
                  Image.asset('Assets/logo.png', height: 70),
                  const Spacer(flex: 1),
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Total Charity Requests',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      '$totalRequests',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          showMore = true;
                        });
                      },
                      icon: Icon(Icons.trending_up, size: 16),
                      label: Text('20% More'),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        foregroundColor: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (showMore)
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('charity_campaigns')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final docs = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final doc = docs[index];
                        final data = doc.data() as Map<String, dynamic>;
                        final docId = doc.id;

                        final topic = data['charity_topic'] ?? 'Untitled Initiative';

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                )
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Title: $topic', style: const TextStyle(fontWeight: FontWeight.bold)),
                                Text('Goal: LKR ${data['goal_amount'] ?? 'N/A'}'),
                                Text('Closing Date: ${data['goal_closing_date'] ?? 'N/A'}'),
                                Text('Charity Description: ${data['charity_description'] ?? 'N/A'}'),
                                const SizedBox(height: 4),
                                Text('Requested by: ${data['name'] ?? 'N/A'}'),
                                Text('Email: ${data['email'] ?? 'N/A'}'),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AddProjectPage(charityData: data),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blueAccent,
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: const Text("Add Project"),
                                    ),
                                    const SizedBox(width: 12),
                                    ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            title: const Text("Confirm Delete"),
                                            content: Text("Are you sure you want to delete '$topic'?"),
                                            actions: [
                                              TextButton(
                                                child: const Text("Cancel"),
                                                onPressed: () => Navigator.pop(ctx),
                                              ),
                                              TextButton(
                                                child: const Text("Delete", style: TextStyle(color: Colors.red)),
                                                onPressed: () {
                                                  Navigator.pop(ctx);
                                                  deleteProject(docId);
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.redAccent,
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: const Text("Delete"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
