import 'package:flutter/material.dart';
import 'security.dart';
import 'notification.dart';
import 'profile.dart';
import 'data server.dart';
import 'free up space.dart';
import 'terms and policies.dart';
import 'navigationbar.dart'; // ✅ Import navigation bar
// ✅ Import home screen

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: SettingsPage()));
}

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
            colors: [Colors.white, Color.fromARGB(255, 17, 125, 183)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: const Center(
                  child: Text(
                    'Setting',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'Assets/profile.png',
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfilePage()),
                        );
                      },
                      child: const Text(
                        'Yennefer Doe',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildSectionTitle("Account"),
                      buildTile(Icons.edit, "Edit profile", context),
                      buildTile(Icons.lock, "Security", context),
                      buildTile(Icons.notifications, "Notifications", context),
                      buildTile(Icons.privacy_tip, "Privacy", context),
                      buildSectionTitle("Support & About"),
                      buildTile(
                          Icons.subscriptions, "My Subscription", context),
                      buildTile(Icons.help_outline, "Help & Support", context),
                      buildTile(
                          Icons.description, "Terms and Policies", context),
                      buildSectionTitle("Cache & Cellular"),
                      buildTile(
                          Icons.cleaning_services, "Free up space", context),
                      buildTile(Icons.data_saver_on, "Data Saver", context),
                      buildSectionTitle("Actions"),
                      buildTile(Icons.bug_report, "Report a problem", context),
                      buildTile(Icons.person_add, "Add account", context),
                      buildTile(Icons.logout, "Log out", context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(), // ✅ Use navigation bar
    );
  }

  static Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  static Widget buildTile(IconData icon, String label, BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.95),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Color(0xFF08557C)),
        title: Text(label, style: const TextStyle(color: Color(0xFF08557C))),
        onTap: () {
          if (label == "Security") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SecurityPage()));
          } else if (label == "Notifications") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationPage()));
          } else if (label == "Free up space") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FreeUpSpacePage()));
          } else if (label == "Data Saver") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const DataSaverPage()));
          } else if (label == "Terms and Policies") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TermsAndPolicyPage()));
          }
        },
      ),
    );
  }
}
