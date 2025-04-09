import 'package:flutter/material.dart';
import 'leaderboard.dart';
// <-- Import the LeaderboardPage

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 1) {
      // Building icon is at index 1
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LeaderboardPage()),
      );
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: [
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        const BottomNavigationBarItem(
            icon: Icon(Icons.location_city), label: ''), // Building icon
        BottomNavigationBarItem(
          icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blueAccent,
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 4, offset: Offset(2, 2))
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
