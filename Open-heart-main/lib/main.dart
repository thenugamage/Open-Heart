import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Screens
import 'IntroPage.dart';
import 'signin.dart';
import 'signup.dart';
import 'home.dart';
import 'leaderboard.dart';
import 'donate.dart';
import 'settings.dart';
import 'profile.dart';
import 'editprofile.dart';
import 'feedbacks.dart';
import 'SelectionPage.dart';
import 'Dashboard.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AppInitializer());
}

// This wrapper handles Firebase init before MyApp loads
class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  bool _initialized = false;
  bool _error = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.red[50],
          body: Center(
            child: Text(
              "❌ Firebase init failed:\n\n$_errorMessage",
              style: const TextStyle(color: Colors.red, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    if (!_initialized) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return const MyApp();
  }
}

// Firestore shortcut (if needed later)
final firestore = FirebaseFirestore.instance;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Donation App',
      debugShowCheckedModeBanner: false,
      home: const IntroPage(),

      routes: {
        '/intro': (context) => const IntroPage(),
        '/signin': (context) => const SignInScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomePage(),
        '/leaderboard': (context) => const LeaderboardPage(),
        '/donate': (context) => const DonatePage(),
        '/settings': (context) => const SettingsPage(),
        '/profile': (context) => const ProfilePage(),
        '/editprofile': (context) => const EditProfilePage(),
        '/feedbacks': (context) => const FeedbacksPage(),
        '/selection': (context) => const SelectionScreen(),
        '/dashboard': (context) => const DashboardPage(),
        // Uncomment these when you implement the screens
        // '/contactus': (context) => const ContactUsPage(),
        // '/report': (context) => const ReportPage(),
        // '/aboutus': (context) => const AboutUsPage(),
        // '/verification': (context) => const VerificationPage(),
      },
    );
  }
}
