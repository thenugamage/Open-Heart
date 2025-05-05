import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: DataSaverPage()),
  );
}

class DataSaverPage extends StatefulWidget {
  const DataSaverPage({super.key});

  @override
  State<DataSaverPage> createState() => _DataSaverPageState();
}

class _DataSaverPageState extends State<DataSaverPage> {
  bool lowQualityImages = false;
  bool backgroundData = false;

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
                          'Data Saver',
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

              // Data Saver Options List
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      _dataSaverTile(
                        icon:
                        Icons
                            .image, // Icon changed to image for Low-Quality Images
                        title: "Low-Quality Images",
                        subtitle: "Reduce image quality to save data.",
                        value: lowQualityImages,
                        onChanged:
                            (val) => setState(() => lowQualityImages = val),
                      ),
                      _dataSaverTile(
                        icon:
                        Icons
                            .signal_cellular_off, // Icon changed to signal for Background Data Restriction
                        title: "Background Data Restriction",
                        subtitle: "Limit app usage in the background.",
                        value: backgroundData,
                        onChanged:
                            (val) => setState(() => backgroundData = val),
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

  // Reusable data saver toggle tile with dynamic icon
  Widget _dataSaverTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Card(
      color: Colors.white.withOpacity(0.8),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.blueAccent,
        ),
        onTap: () {
          // You can also handle the tap action if needed
        },
      ),
    );
  }
}
