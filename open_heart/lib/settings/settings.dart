import 'package:flutter/material.dart';
import 'security.dart'; // Import the SecurityPage
import 'notification.dart'; // Import the NotificationPage
import 'profile.dart'; // Import the ProfilePage
import 'data server.dart'; // Import the DataServerPage
import 'free up space.dart'; // Import the FreeUpSpacePage
import 'terms and policies.dart'; // Import the TermsAndPolicyPage
import 'add acount.dart'; // Import the AddAccountPage
import 'contact us.dart'; // Import the ContactUsPage
import 'edit profile.dart'; // Import the EditProfilePage
import 'help and support.dart'; // Import the HelpAndSupportPage
import 'log out.dart'; // Import the LogOutPage
import 'my subscription.dart'; // Import the MySubscriptionPage
import 'privacy.dart'; // Import the PrivacyPage
import 'report a problem.dart'; // Import the ReportProblemPage

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
                      buildTile(Icons.description, "Terms and Policies",
                          context), // Links to TermsAndPolicyPage
                      buildTile(Icons.contact_page, "Contact Us",
                          context), // New tile

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
              MaterialPageRoute(builder: (context) => const FreeUpSpacePage()),
            );
          } else if (label == "Data Saver") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DataSaverPage()),
            );
          } else if (label == "Terms and Policies") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const TermsAndPolicyPage()), // Navigate to TermsAndPolicyPage
            );
          } else if (label == "Add account") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddAccountPage()),
            ); // Navigate to AddAccountPage
          } else if (label == "Contact Us") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ContactUsPage()),
            ); // Navigate to ContactUsPage
          } else if (label == "Edit profile") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EditProfilePage()),
            ); // Navigate to EditProfilePage
          } else if (label == "Help & Support") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const HelpAndSupportPage()),
            ); // Navigate to HelpAndSupportPage
          } else if (label == "Log out") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LogoutPage()),
            ); // Navigate to LogOutPage
          } else if (label == "My Subscription") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MySubscriptionPage()),
            ); // Navigate to MySubscriptionPage
          } else if (label == "Privacy") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PrivacyPage()),
            ); // Navigate to PrivacyPage
          } else if (label == "Report a problem") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ReportProblemPage()),
            ); // Navigate to ReportProblemPage
          }
        },
      ),
    );
  }
}
