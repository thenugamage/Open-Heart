import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';

import 'admin_currentprojects.dart';

class AddNewProjectPage extends StatefulWidget {
  const AddNewProjectPage({super.key});

  @override
  State<AddNewProjectPage> createState() => _AddNewProjectPageState();
}

class _AddNewProjectPageState extends State<AddNewProjectPage> {
  final titleController = TextEditingController();
  final goalController = TextEditingController();
  final descriptionController = TextEditingController();
  final mainDescriptionController = TextEditingController();
  final closingDateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  bool _uploading = false;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _selectedImage = File(picked.path));
    }
  }

  Future<String?> _uploadImage(File file) async {
    try {
      final filename = 'donations/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final ref = FirebaseStorage.instance.ref().child(filename);
      final uploadTask = await ref.putFile(file);
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      debugPrint("❌ Image upload failed: $e");
      return null;
    }
  }

  void _addProject() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _uploading = true);
    String? imageUrl;

    // 🔼 Upload image if selected
    if (_selectedImage != null) {
      imageUrl = await _uploadImage(_selectedImage!);
      if (imageUrl == null) {
        setState(() => _uploading = false);
        _showError("Image upload failed. Please check your Firebase Storage rules.");
        return;
      }
    }

    final data = {
      'title': titleController.text.trim(),
      'goal': goalController.text.trim(),
      'raised': '0',
      'description': descriptionController.text.trim(),
      'closingDate': closingDateController.text.trim(),
      'mainDescription': mainDescriptionController.text.trim(),
      'imageUrl': imageUrl ?? '',
      'createdAt': DateTime.now().toIso8601String(),
    };

    try {
      await FirebaseFirestore.instance.collection('donations').add(data);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ New project added')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AdminCurrentProjects()),
      );
    } catch (e) {
      _showError("Error saving project: $e");
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.redAccent),
    );
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
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF0D47A1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    // 🔷 Title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        controller: titleController,
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputDecoration("Charity Topic...?"),
                        validator: (value) => value!.isEmpty ? 'Enter charity topic' : null,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 🔷 Image Picker
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          image: _selectedImage != null
                              ? DecorationImage(
                            image: FileImage(_selectedImage!),
                            fit: BoxFit.cover,
                          )
                              : null,
                        ),
                        child: _selectedImage == null
                            ? const Center(child: Text("Tap to upload a photo"))
                            : null,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 🔷 Inputs
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: goalController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(labelText: "Goal Amount (LKR)"),
                            validator: (value) => value!.isEmpty ? 'Enter goal amount' : null,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: descriptionController,
                            maxLines: 2,
                            decoration: const InputDecoration(labelText: "Short Description"),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: closingDateController,
                            decoration: const InputDecoration(labelText: "Goal Closing Date"),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: mainDescriptionController,
                            maxLines: 4,
                            decoration: const InputDecoration(labelText: "Full Project Description"),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 🔷 Submit Button
                    ElevatedButton(
                      onPressed: _uploading ? null : _addProject,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                      ),
                      child: _uploading
                          ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                      )
                          : const Text(
                        "Add New Project",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white70,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
    );
  }
}
