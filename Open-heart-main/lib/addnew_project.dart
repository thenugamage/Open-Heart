import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'services/email.dart';

class AddProjectPage extends StatefulWidget {
  final Map<String, dynamic> charityData;

  const AddProjectPage({Key? key, required this.charityData}) : super(key: key);

  @override
  State<AddProjectPage> createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _charityTopicController = TextEditingController();
  final TextEditingController _goalAmountController = TextEditingController();
  final TextEditingController _charityDescriptionController = TextEditingController();
  final TextEditingController _goalClosingDateController = TextEditingController();
  final TextEditingController _mainDescriptionController = TextEditingController();

  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    final data = widget.charityData;
    _charityTopicController.text = data['charity_topic'] ?? '';
    _goalAmountController.text = data['goal_amount']?.toString() ?? '';
    _charityDescriptionController.text = data['charity_description'] ?? '';
    _goalClosingDateController.text = data['goal_closing_date'] ?? '';
    _mainDescriptionController.text = data['main_description'] ?? '';
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<String> _uploadImage(File imageFile) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
    final ref = FirebaseStorage.instance.ref().child('donation_images/$fileName');
    await ref.putFile(imageFile);
    return await ref.getDownloadURL();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final email = widget.charityData['email'] ?? "unknown";
      final name = widget.charityData['name'] ?? 'Supporter';
      final topic = _charityTopicController.text;
      final amount = int.tryParse(_goalAmountController.text) ?? 0;
      final description = _charityDescriptionController.text;
      String imageUrl = 'Assets/help.png';

      if (_selectedImage != null) {
        imageUrl = await _uploadImage(_selectedImage!);
      }

      await FirebaseFirestore.instance.collection('charity_campaigns').add({
        'charity_topic': topic,
        'goal_amount': amount,
        'charity_description': description,
        'goal_closing_date': _goalClosingDateController.text,
        'main_description': _mainDescriptionController.text,
        'email': email,
        'timestamp': FieldValue.serverTimestamp(),
      });

      await FirebaseFirestore.instance.collection('donations').add({
        'title': topic,
        'goal': amount.toString(),
        'raised': 0,
        'descriptions': description,
        'imageUrl': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });

      await EmailSender.sendEmailConfirmation(
        context,
        email,
        amount,
        charityDescription: description,
        userName: name,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Project added and email sent!")),
      );

      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _charityTopicController.dispose();
    _goalAmountController.dispose();
    _charityDescriptionController.dispose();
    _goalClosingDateController.dispose();
    _mainDescriptionController.dispose();
    super.dispose();
  }

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
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  Image.asset('Assets/logo.png', height: 60),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _charityTopicController,
                      decoration: const InputDecoration(labelText: 'Charity Topic'),
                      validator: (value) => value!.isEmpty ? 'Enter a topic' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _goalAmountController,
                      decoration: const InputDecoration(labelText: 'Goal Amount (LKR)'),
                      keyboardType: TextInputType.number,
                      validator: (value) => value!.isEmpty ? 'Enter a goal amount' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _charityDescriptionController,
                      decoration: const InputDecoration(labelText: 'Charity Description'),
                      validator: (value) => value!.isEmpty ? 'Enter a description' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _goalClosingDateController,
                      decoration: const InputDecoration(labelText: 'Goal Closing Date'),
                      validator: (value) => value!.isEmpty ? 'Enter a closing date' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _mainDescriptionController,
                      decoration: const InputDecoration(labelText: 'Main Description'),
                      validator: (value) => value!.isEmpty ? 'Enter main description' : null,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _pickImage,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.teal.shade200),
                      child: const Text("Upload A Photo", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Add New Project", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}