import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeedbacksPage extends StatefulWidget {
  const FeedbacksPage({super.key});

  @override
  State<FeedbacksPage> createState() => _FeedbacksPageState();
}

class _FeedbacksPageState extends State<FeedbacksPage> {
  double sliderValue = 2;
  final TextEditingController _commentController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final List<String> moods = ["Worst", "Not Good", "Fine", "Look Good", "Very Good"];
  final List<IconData> moodIcons = [
    FontAwesomeIcons.faceDizzy,
    FontAwesomeIcons.faceFrown,
    FontAwesomeIcons.faceMeh,
    FontAwesomeIcons.faceSmile,
    FontAwesomeIcons.faceGrinStars,
  ];

  bool isSubmitting = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submitFeedback() async {
    if (_commentController.text.trim().isEmpty) {
      _showMessage("Please enter a comment.", isError: true);
      return;
    }

    final mood = moods[sliderValue.round()];
    final comment = _commentController.text.trim();
    final user = _auth.currentUser;

    if (user == null) {
      _showMessage("User not signed in.", isError: true);
      return;
    }

    setState(() => isSubmitting = true);

    try {
      await _firestore.collection('feedbacks').add({
        'uid': user.uid,
        'email': user.email ?? 'unknown',
        'mood': mood,
        'comment': comment,
        'timestamp': FieldValue.serverTimestamp(),
      });

      _commentController.clear();
      setState(() => sliderValue = 2);

      _showMessage("✅ Thank you! Your feedback was submitted.");
    } catch (e) {
      _showMessage("Error: ${e.toString()}", isError: true);
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int selectedFace = sliderValue.round();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(16, 50, 16, 24),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFF117DB7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Back + title
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset('Assets/icons/back.png', height: 26, width: 26),
                ),
                const Spacer(),
                const Text(
                  "Feedback",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                const SizedBox(width: 26),
              ],
            ),
            const SizedBox(height: 30),

            const Text(
              "How was your experience?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Icon(moodIcons[selectedFace], size: 80, color: Colors.blue.shade900),
            const SizedBox(height: 10),
            Text(
              moods[selectedFace],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            Slider(
              value: sliderValue,
              onChanged: (value) => setState(() => sliderValue = value),
              min: 0,
              max: 4,
              divisions: 4,
              activeColor: Colors.blue.shade900,
              label: moods[selectedFace],
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Leave a comment...",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: isSubmitting ? null : _submitFeedback,
              icon: isSubmitting
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
                  : const Icon(Icons.send),
              label: Text(isSubmitting ? "Submitting..." : "Submit Feedback"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade900,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
