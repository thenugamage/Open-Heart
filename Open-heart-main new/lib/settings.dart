import 'package:flutter/material.dart';
import 'editprofile.dart';
import 'home.dart';
import 'feedbacks.dart';
import 'report.dart';
import 'security.dart';
import 'notification.dart';
import 'terms_policies.dart';
import 'data_server.dart';
import 'wallet.dart';
import 'help and support.dart';
import 'add account.dart';

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
                _emojiTile("🛡️", "Security", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SecurityScreen()),
                  );
                }),
                _emojiTile("🔔", "Notifications", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const NotificationPage()),
                  );
                }),
                _emojiTile("🔒", "Privacy", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ReportProblemPage()),
                  );
                }),
              ]),

              const SizedBox(height: 20),

              // 💬 Support
              _sectionTitle("Support & About"),
              _sectionCard([
                _emojiTile("💳", "Wallet", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const WalletScreen()),
                  );
                }),
                _emojiTile("❓", "Help & Support", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HelpSupportScreen()),
                  );
                }),
                _emojiTile("📜", "Terms and Policies", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TermsAndPoliciesScreen()),
                  );
                }),
              ]),

              const SizedBox(height: 20),

              // 📉 Cache
              _sectionTitle("Cache & Cellular"),
              _sectionCard([
                _emojiTile("💬", "Feedback", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const FeedbacksPage()),
                  );
                }),
                _emojiTile("📉", "Data Saver", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const DataSaverPage()),
                  );
                }),
              ]),

              const SizedBox(height: 20),

              // ⚙️ Actions
              _sectionTitle("Actions"),
              _sectionCard([
                _emojiTile("🚩", "Report a problem", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ReportProblemPage()),
                  );
                }),
                _emojiTile("➕", "Add account", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddAccountScreen()),
                  );
                }),
                _emojiTile("🚪", "Log out", () {
                  Navigator.pop(context);
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
