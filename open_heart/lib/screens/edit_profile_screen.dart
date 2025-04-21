import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dobController = TextEditingController();
  final _countryController = TextEditingController();

  File? _selectedImage;
  String? _currentImageUrl;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      final data = doc.data();
      setState(() {
        _nameController.text = data?['name'] ?? '';
        _emailController.text = user.email ?? '';
        _dobController.text = data?['dob'] ?? '';
        _countryController.text = data?['country'] ?? '';
        _currentImageUrl = (data?['photoUrl'] ?? '').replaceAll('"', '').trim();
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      final imageFile = File(picked.path);
      final downloadUrl = await _uploadImage(imageFile);

      if (downloadUrl != null) {
        setState(() {
          _selectedImage = imageFile;
          _currentImageUrl = downloadUrl;
        });
      }
    }
  }

  Future<String?> _uploadImage(File file) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return null;

    try {
      final ref = FirebaseStorage.instance.ref().child('profile_photos/$uid.jpg');
      await ref.putFile(file);
      final downloadUrl = await ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'photoUrl': downloadUrl,
      });

      return downloadUrl;
    } catch (e) {
      print("Upload failed: $e");
      return null;
    }
  }

  Future<void> _saveChanges() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        setState(() => _isSaving = true);

        String? imageUrl = _currentImageUrl;
        if (_selectedImage != null) {
          final uploaded = await _uploadImage(_selectedImage!);
          if (uploaded != null) imageUrl = uploaded;
        }

        await _firestore.collection('users').doc(user.uid).update({
          'name': _nameController.text.trim(),
          'dob': _dobController.text.trim(),
          'country': _countryController.text.trim(),
          'photoUrl': imageUrl ?? '',
        });

        if (_emailController.text.trim() != user.email) {
          await user.updateEmail(_emailController.text.trim());
        }

        if (_passwordController.text.trim().isNotEmpty) {
          await user.updatePassword(_passwordController.text.trim());
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Profile updated successfully")),
          );
        }

        setState(() {
          _isSaving = false;
          _selectedImage = null;
          _currentImageUrl = imageUrl;
        });
      } catch (e) {
        setState(() => _isSaving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.toString()}")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe8f1fb),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset('Assets/icons/back.png', height: 24),
                ),
                const Spacer(),
                const Text(
                  "Edit Profile",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                const SizedBox(width: 24),
              ],
            ),
            const SizedBox(height: 30),

            Stack(
              alignment: Alignment.bottomRight,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: _selectedImage != null
                          ? FileImage(_selectedImage!)
                          : (_currentImageUrl != null && _currentImageUrl!.startsWith("http")
                          ? NetworkImage(_currentImageUrl!)
                          : const AssetImage('Assets/icons/user.png') as ImageProvider),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
            _buildInputField("Name", _nameController),
            _buildInputField("Email", _emailController),
            _buildInputField("Password", _passwordController, isPassword: true),
            _buildInputField("Date of Birth", _dobController),
            _buildInputField("Country/Region", _countryController),

            const SizedBox(height: 20),
            _isSaving
                ? const CircularProgressIndicator()
                : ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xff093f6c),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Colors.white70),
                ),
              ),
              onPressed: _saveChanges,
              child: const Text(
                "Save changes",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller,
      {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.black54)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 14),
      ],
    );
  }
}
