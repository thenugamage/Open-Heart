import 'package:flutter/material.dart';
import 'leaderboard.dart';
import 'settings.dart';
import 'home.dart'; // ✅ Import HomePage

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigation logic based on tapped index
    switch (index) {
      case 0: // Home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
      case 1: // Leaderboard
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LeaderboardPage()),
        );
        break;
      case 3: // Settings
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SettingsPage()),
        );
        break;
      // Add other cases if needed (like index 2 and 4)
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: [
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        const BottomNavigationBarItem(
            icon: Icon(Icons.location_city), label: ''),
        BottomNavigationBarItem(
          icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blueAccent,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(8),
            child: const Icon(Icons.volunteer_activism,
                size: 30, color: Colors.white),
          ),
          label: '',
        ),
        const BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        const BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
      ],
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }
}
