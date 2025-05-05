import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditDonationPage extends StatefulWidget {
    final String docId;
    final Map<String, dynamic> data;

  const EditDonationPage({super.key, required this.docId, required this.data});

    @override
    State<EditDonationPage> createState() => _EditDonationPageState();
}

class _EditDonationPageState extends State<EditDonationPage> {
    late TextEditingController titleController;
    late TextEditingController goalController;
    late TextEditingController raisedController;
    late TextEditingController imageController;
    late TextEditingController descriptionController;

    @override
    void initState() {
        super.initState();
        titleController = TextEditingController(text: widget.data['title']);
        goalController = TextEditingController(text: widget.data['goal']);
        raisedController = TextEditingController(text: widget.data['raised']);
        imageController = TextEditingController(text: widget.data['imageUrl']);
        descriptionController = TextEditingController(
                text: widget.data['description'] ?? widget.data['descriptions']);
    }

    void _saveChanges() {
        FirebaseFirestore.instance.collection('donations').doc(widget.docId).update({
                'title': titleController.text.trim(),
                'goal': goalController.text.trim(),
                'raised': raisedController.text.trim(),
                'imageUrl': imageController.text.trim(),
                'description': descriptionController.text.trim(),
    }).then((_) {
                Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Donation project updated successfully')),
      );
    });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
                backgroundColor: const Color(0xFFE3F2FD),
                appBar: AppBar(
                backgroundColor: const Color(0xFFE3F2FD),
                elevation: 0,
                centerTitle: true,
                title: Column(
                children: [
        Image.asset('Assets/logo.png', height: 60), // Replace title with logo
          ],
        ),
        leading: IconButton(
                icon: Image.asset('Assets/icons/back.png', height: 24),
        onPressed: () => Navigator.pop(context),
        ),
      ),
        body: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                padding: const EdgeInsets.all(20),
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
        child: ListView(
                children: [
              const Text(
                "Edit Project Details",
                style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFF0D47A1),
                ),
        textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

        // 🔹 Title
        TextField(
                controller: titleController,
                decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

        // 🔹 Goal
        TextField(
                controller: goalController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                labelText: 'Goal Amount',
                border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

        // 🔹 Raised
        TextField(
                controller: raisedController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                labelText: 'Raised Amount',
                border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

        // 🔹 Image
        TextField(
                controller: imageController,
                decoration: const InputDecoration(
                labelText: 'Image URL or Asset Path',
                border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

        // 🔹 Description
        TextField(
                controller: descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

        // 🔹 Save Button
        ElevatedButton.icon(
                onPressed: _saveChanges,
                icon: const Icon(Icons.save),
                label: const Text('Save Changes'),
                style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D47A1),
                padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
    }
}
