import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/profile_screen.dart'; 
import '../screens/donate_screen.dart';
import '../screens/leaderboard_screen.dart';


class CustomNavigationBar extends StatelessWidget {
  final int selectedIndex;

  const CustomNavigationBar({super.key, required this.selectedIndex});

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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const DonatePage()),
        );
        break;

        break;
      case 3:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SettingsPage()));
        break;
      case 4:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProfilePage())); // ✅ Updated
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Color.fromARGB(255, 17, 125, 183)],
        ),
      ),
      child: SafeArea(
        child: SizedBox(
          height: 90,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: BottomNavigationBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    currentIndex: selectedIndex,
                    onTap: (index) => _navigate(context, index),
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.orange,
                    unselectedItemColor: Colors.grey,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    items: [
                      BottomNavigationBarItem(
                        icon: Image.asset('Assets/icons/home.png', height: 28),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: Image.asset('Assets/icons/chess.png', height: 28),
                        label: '',
                      ),
                      const BottomNavigationBarItem(
                        icon: SizedBox.shrink(),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: Image.asset('Assets/icons/settings.png', height: 28),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: Image.asset('Assets/icons/user.png', height: 28),
                        label: '',
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -20,
                child: GestureDetector(
                  onTap: () => _navigate(context, 2),
                  child: Container(
                    height: 100,
                    width: 70,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFF0D6EFD), Color(0xFF0A58CA)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Image.asset(
                        'Assets/icons/donate.png',
                        height: 40,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
