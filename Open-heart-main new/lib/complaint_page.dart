import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintPage extends StatefulWidget {
  const ComplaintPage({super.key});

  @override
  State<ComplaintPage> createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  bool _showDetails = false; // Track whether to show the details or not

  // Function to fetch the weekly complaint count
  Future<int> getWeeklyComplaintCount() async {
    final now = DateTime.now();
    final oneWeekAgo = now.subtract(const Duration(days: 7));
    final snapshot = await FirebaseFirestore.instance
        .collection('reports')
        .where('timestamp', isGreaterThan: oneWeekAgo)
        .get();

    return snapshot.docs.length;
  }

  // Function to fetch complaints details
  Future<List<Map<String, dynamic>>> getComplaints() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('reports')
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  // Function to format timestamp
  String formatTimestamp(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE3F2FD),
        elevation: 0,
        centerTitle: true,
        title: Image.asset('Assets/logo.png', height: 60),
        leading: IconButton(
          icon: Image.asset('Assets/icons/back.png', height: 24),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Total Complaints (Weekly)
            FutureBuilder<int>(
              future: getWeeklyComplaintCount(),
              builder: (context, snapshot) {
                final count = snapshot.data ?? 0;
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Total Complaints (Weekly)",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        count.toString(),
                        style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            _showDetails = !_showDetails; // Toggle the details view
                          });
                        },
                        icon: const Icon(Icons.arrow_upward),
                        label: const Text("20% More"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          side: const BorderSide(color: Colors.black),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // Show details if _showDetails is true
            if (_showDetails)
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: getComplaints(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return const Center(child: Text('Error fetching data'));
                    }
                    final complaints = snapshot.data ?? [];

                    return ListView.builder(
                      itemCount: complaints.length,
                      itemBuilder: (context, index) {
                        final complaint = complaints[index];

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Display the description first
                                Text(
                                  complaint['description'] ?? 'No Description',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 8),

                                // Displaying the details: name, email, and timestamp
                                Text(
                                  'Name: ${complaint['name'] ?? 'Anonymous'}',
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                                Text(
                                  'Email: ${complaint['email']}',
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                                Text(
                                  'Submitted on: ${formatTimestamp(complaint['timestamp'])}',
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
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
