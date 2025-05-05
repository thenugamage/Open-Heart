import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotificationPage(),
    ),
  );
}

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool pushNotif = true;
  bool smsAlerts = false;
  bool emailNotif = true;
  bool appUpdates = true;
  bool campaignActivity = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                    ),
                    const Spacer(),
                    const Text(
                      "Notifications",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Notification toggles
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _notificationTile(
                      title: "Push Notifications",
                      value: pushNotif,
                      onChanged: (val) => setState(() => pushNotif = val),
                    ),
                    _notificationTile(
                      title: "SMS Alerts",
                      value: smsAlerts,
                      onChanged: (val) => setState(() => smsAlerts = val),
                    ),
                    _notificationTile(
                      title: "Email Notifications",
                      value: emailNotif,
                      onChanged: (val) => setState(() => emailNotif = val),
                    ),
                    _notificationTile(
                      title: "App Updates",
                      value: appUpdates,
                      onChanged: (val) => setState(() => appUpdates = val),
                    ),
                    _notificationTile(
                      title: "Campaign Activity",
                      value: campaignActivity,
                      onChanged:
                          (val) => setState(() => campaignActivity = val),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable toggle tile
  Widget _notificationTile({
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Card(
      color: Colors.white.withOpacity(0.8),
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SwitchListTile(
        title: Text(title),
        value: value,
        activeColor: Colors.blueAccent,
        onChanged: onChanged,
      ),
    );
  }
}
