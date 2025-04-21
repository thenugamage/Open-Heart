import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import 'home_screen.dart';
import 'feedbacks_screen.dart';
import 'report_screen.dart'; // <-- Make sure you have this file and class created

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            children: [
              // 🔙 Back button and title
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HomePage()),
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
                    "Settings",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: 24),

              // 🔐 Account Section
              _sectionTitle("Account"),
              _sectionCard([
                _emojiTile("🧑‍💼", "Edit profile", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const EditProfilePage()),
                  );
                }),
                _emojiTile("🛡️", "Security"),
                _emojiTile("🔔", "Notifications"),
                _emojiTile("🔒", "Privacy"),
              ]),

              const SizedBox(height: 20),

              // 💬 Support
              _sectionTitle("Support & About"),
              _sectionCard([
                _emojiTile("💳", "Wallet"),
                _emojiTile("❓", "Help & Support"),
                _emojiTile("📜", "Terms and Policies"),
              ]),

              const SizedBox(height: 20),

              // 📉 Cache
              _sectionTitle("Cache & cellular"),
              _sectionCard([
                _emojiTile("💬", "Feedback", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const FeedbacksPage()),
                  );
                }),
                _emojiTile("📉", "Data Saver"),
              ]),

              const SizedBox(height: 20),

              // ⚙️ Actions
              _sectionTitle("Actions"),
              _sectionCard([
                _emojiTile("🚩", "Report a problem", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ReportProblemPage()),

                  );
                }),
                _emojiTile("➕", "Add account"),
                _emojiTile("🚪", "Log out", () {
                  Navigator.pop(context); // Replace with FirebaseAuth.instance.signOut() if needed
                }),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  // 📌 Section Header
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0, left: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  // 📦 Card Wrapper
  Widget _sectionCard(List<Widget> tiles) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0x33ffffff),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(children: tiles),
    );
  }

  // 🔘 Emoji Tile with optional tap
  Widget _emojiTile(String emoji, String label, [VoidCallback? onTap]) {
    return ListTile(
      leading: Text(
        emoji,
        style: const TextStyle(fontSize: 24),
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
      onTap: onTap,
      dense: true,
      visualDensity: const VisualDensity(horizontal: 0, vertical: -1),
    );
  }
}
