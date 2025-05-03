import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FreeUpSpacePage(),
    ),
  );
}

class FreeUpSpacePage extends StatelessWidget {
  const FreeUpSpacePage({super.key});

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
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Free Up Space',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Storage Options List
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      _storageOptionTile(
                        Icons.delete,
                        "Clear Cache",
                        "Free up space by clearing app cache.",
                      ),
                      _storageOptionTile(
                        Icons.delete_forever,
                        "Clear App Data",
                        "Remove unnecessary app data.",
                      ),
                      _storageOptionTile(
                        Icons.history,
                        "Clear Temporary Files",
                        "Remove temporary files that are taking up space.",
                      ),
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

  // Reusable tile card for storage options
  static Widget _storageOptionTile(
    IconData icon,
    String title,
    String description,
  ) {
    return Card(
      color: Colors.white.withOpacity(0.8),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // TODO: Handle the tap action (e.g., clear cache, data, etc.)
        },
      ),
    );
  }
}
