import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home_screen.dart';
import 'leaderboard_screen.dart';
import 'donate_screen.dart';
import 'settings_screen.dart';
import 'profile_screen.dart';

class NewNavBar extends StatelessWidget {
  final int selectedIndex;

  const NewNavBar({super.key, required this.selectedIndex});

  void _navigate(BuildContext context, int index) {
    if (index == selectedIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
        break;
      case 1:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LeaderboardPage()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const DonatePage()));
        break;
      case 3:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SettingsPage()));
        break;
      case 4:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProfilePage()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFe3f2fd), Color(0xFF90caf9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.transparent),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                  FirebaseAuth.instance.currentUser?.photoURL ??
                      "https://i.pravatar.cc/150?img=9",
                ),
              ),
              accountName: Text(
                FirebaseAuth.instance.currentUser?.displayName ?? "User",
                style: const TextStyle(color: Colors.black87),
              ),
              accountEmail: Text(
                FirebaseAuth.instance.currentUser?.email ?? "",
                style: const TextStyle(color: Colors.black54),
              ),
            ),

            // Navigation Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  buildNavItem(context, 'Assets/icons/home.png', "Home", 0),
                  buildNavItem(context, 'Assets/icons/chess.png', "Leaderboard", 1),
                  buildNavItem(context, 'Assets/icons/donate.png', "Donations", 2),
                  buildNavItem(context, 'Assets/icons/settings.png', "Settings", 3),
                  buildNavItem(context, 'Assets/icons/user.png', "Profile", 4),
                ],
              ),
            ),

            // Logout Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade400,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size.fromHeight(50),
                ),
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pop(context); // Close drawer
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/signin', // ✅ FIXED: use the correct route
                          (route) => false,
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Logout failed: $e"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNavItem(BuildContext context, String assetPath, String title, int index) {
    return ListTile(
      leading: Image.asset(assetPath, height: 28, width: 28),
      title: Text(
        title,
        style: TextStyle(
          color: selectedIndex == index ? Colors.blue.shade900 : Colors.black87,
          fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.black54),
      tileColor: selectedIndex == index
          ? Colors.white.withOpacity(0.6)
          : Colors.white.withOpacity(0.4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: () {
        Navigator.pop(context);
        _navigate(context, index);
      },
    );
  }
}
