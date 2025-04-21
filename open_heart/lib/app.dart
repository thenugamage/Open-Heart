//  lib/app.dart
import 'package:flutter/material.dart';
import 'screens/landing_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App Name', //  Add your app name
      theme: ThemeData(
        primarySwatch: Colors.blue, //  Example theme
      ),
      home: LandingPage(), //  Set your initial screen
      //  routes: {  /* Define your routes here if using named routes */ },
    );
  }
}