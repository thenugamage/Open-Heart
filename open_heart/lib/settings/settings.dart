import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: SettingsPage()));
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // 🌈 Full page gradient background
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
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                color: Colors.transparent, // no solid color, lets gradient show
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

              // Profile Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Colors.transparent,
                child: Row(
                  children: const [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Color(0xFF08557C),
                      child: Icon(Icons.person, color: Colors.white, size: 28),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Yennefer Doe',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              // Scrollable Settings
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildSectionTitle("Account"),
                      buildTile(Icons.edit, "Edit profile"),
                      buildTile(Icons.lock, "Security"),
                      buildTile(Icons.notifications, "Notifications"),
                      buildTile(Icons.privacy_tip, "Privacy"),

                      buildSectionTitle("Support & About"),
                      buildTile(Icons.subscriptions, "My Subscription"),
                      buildTile(Icons.help_outline, "Help & Support"),
                      buildTile(Icons.description, "Terms and Policies"),

                      buildSectionTitle("Cache & Cellular"),
                      buildTile(Icons.cleaning_services, "Free up space"),
                      buildTile(Icons.data_saver_on, "Data Saver"),

                      buildSectionTitle("Actions"),
                      buildTile(Icons.bug_report, "Report a problem"),
                      buildTile(Icons.person_add, "Add account"),
                      buildTile(Icons.logout, "Log out"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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

  static Widget buildTile(IconData icon, String label) {
    return Card(
      color: Colors.white.withOpacity(0.95),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Color(0xFF08557C)),
        title: Text(label, style: const TextStyle(color: Color(0xFF08557C))),
        onTap: () {
          // TODO: Add navigation or functionality
        },
      ),
    );
  }
}
