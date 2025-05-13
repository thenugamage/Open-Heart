import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  File? _selectedImage; // To hold the selected image file

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

  // Function to allow the admin to pick an image from the gallery
  Future<void> _pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path); // Assign the selected image
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  // Function to upload image to Firebase Storage and get the download URL
  Future<String?> _uploadImage(File imageFile) async {
    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.png'; // Unique file name
      final ref = FirebaseStorage.instance.ref().child('donation_images/$fileName'); // Storage reference

      print("Uploading image to Firebase Storage...");
      await ref.putFile(imageFile); // Upload image to Firebase Storage
      print("Image uploaded successfully.");

      // Get the download URL
      final downloadUrl = await ref.getDownloadURL();
      print("Image URL: $downloadUrl"); // Log the URL for debugging
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null; // Return null if there's an error
    }
  }

  // Function to submit the form and save the data in Firestore
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final email = widget.charityData['email'] ?? "unknown";
      final name = widget.charityData['name'] ?? 'Supporter';
      final topic = _charityTopicController.text;
      final amount = int.tryParse(_goalAmountController.text) ?? 0;
      final description = _charityDescriptionController.text;
      String? imageUrl = ''; // Default image if no image is selected

      // If an image is selected, upload it to Firebase Storage
      if (_selectedImage != null) {
        print("Uploading image...");
        imageUrl = await _uploadImage(_selectedImage!); // Upload image and get URL

        if (imageUrl == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to upload image. Please try again.")),
          );
          return; // Return early if image upload fails
        }
      } else {
        // If no image is selected, assign a default value
        imageUrl = 'Assets/children.png';  // Default static image if no dynamic image is selected
        print("Using default image: $imageUrl");
      }

      // Adding the charity project data to Firestore
      try {
        await FirebaseFirestore.instance.collection('charity_campaigns').add({
          'charity_topic': topic,
          'goal_amount': amount,
          'charity_description': description,
          'goal_closing_date': _goalClosingDateController.text,
          'main_description': _mainDescriptionController.text,
          'email': email,
          'timestamp': FieldValue.serverTimestamp(),
          'imageUrl': imageUrl, // Store the image URL dynamically
        });

        // Adding the donation project data to Firestore
        await FirebaseFirestore.instance.collection('donations').add({
          'title': topic,
          'goal': amount.toString(),
          'raised': 0,
          'descriptions': description,
          'imageUrl': imageUrl, // Store the image URL dynamically
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Send an email confirmation after adding the project
        await EmailSender.sendEmailConfirmation(
          context,
          email,
          amount,
          charityDescription: description,
          userName: name,
        );

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Project added and email sent!")),
        );

        // Close the page and go back to the previous screen
        Navigator.pop(context);
      } catch (e) {
        print('Error adding project to Firestore: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error adding project. Please try again.")),
        );
      }
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
                    if (_selectedImage != null) // Display selected image preview
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Image.file(_selectedImage!, height: 100),
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
