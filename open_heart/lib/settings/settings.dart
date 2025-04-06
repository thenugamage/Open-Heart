import 'package:flutter/material.dart';
import 'security.dart'; // Import the SecurityPage
import 'notification.dart'; // Import the NotificationPage
import 'profile.dart'; // Import the ProfilePage
import 'data server.dart'; // Import the DataServerPage
import 'free up space.dart'; // Import the FreeUpSpacePage

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

              // Profile Section with Profile Photo
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Colors.transparent,
                child: Row(
                  children: [
                    // Profile Photo
                    ClipOval(
                      child: Image.asset(
                        'Assets/profile photo.PNG',
                        width: 48, // Adjust size as necessary
                        height: 48, // Adjust size as necessary
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        // Navigate to Profile Page
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

              // Scrollable Settings
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
                      buildTile(Icons.cleaning_services, "Free up space",
                          context), // Links to FreeUpSpacePage
                      buildTile(Icons.data_saver_on, "Data Saver",
                          context), // Links to DataServerPage

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
          // Navigate to the appropriate page based on the label
          if (label == "Security") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecurityPage()),
            );
          } else if (label == "Notifications") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationPage()),
            );
          } else if (label == "Free up space") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const FreeUpSpacePage()), // Navigate to FreeUpSpacePage
            );
          } else if (label == "Data Saver") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const DataSaverPage()), // Navigate to DataServerPage
            );
          }
        },
      ),
    );
  }
}
