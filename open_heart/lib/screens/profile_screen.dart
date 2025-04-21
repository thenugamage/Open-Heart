import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffe6f3fc),
              Color(0xff9cd0f4),
              Color(0xff2a8dd2),
            ],
          ),
        ),
        child: SafeArea(
          child: uid == null
              ? const Center(child: Text("User not logged in"))
              : StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || !snapshot.data!.exists) {
                return const Center(child: Text("User data not found"));
              }

              final userData =
              snapshot.data!.data() as Map<String, dynamic>;

              final userImageUrl = userData['photoUrl']?.toString();
              final userImage = (userImageUrl != null &&
                  userImageUrl.isNotEmpty &&
                  userImageUrl.startsWith("http"))
                  ? NetworkImage(userImageUrl)
                  : const AssetImage('Assets/icons/user.png')
              as ImageProvider;

              return Column(
                children: [
                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HomePage(),
                              ),
                            );
                          },
                          child: Image.asset(
                            'Assets/icons/back.png',
                            height: 26,
                            width: 26,
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          "Profile",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontFamily: 'ArialRoundedMTBold',
                          ),
                        ),
                        const Spacer(),
                        const SizedBox(width: 26),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 52,
                      backgroundImage: userImage,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Expanded(
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView(
                        children: [
                          _ProfileField(
                            label: "Name",
                            value: userData['name'] ?? '',
                          ),
                          _ProfileField(
                            label: "Email",
                            value: userData['email'] ??
                                FirebaseAuth.instance.currentUser?.email ??
                                '',
                          ),
                          _ProfileField(
                            label: "Password",
                            value: "************",
                          ),
                          _ProfileField(
                            label: "Date of Birth",
                            value: userData['dob'] ?? '',
                          ),
                          _ProfileField(
                            label: "Country/Region",
                            value: userData['country'] ?? '',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ProfileField extends StatelessWidget {
  final String label;
  final String value;

  const _ProfileField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            initialValue: value,
            readOnly: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withOpacity(0.3),
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
