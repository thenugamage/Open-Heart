import 'package:flutter/material.dart';

class DataSaverScreen extends StatefulWidget {
  const DataSaverScreen({super.key});

  @override
  State<DataSaverScreen> createState() => _DataSaverScreenState();
}

class _DataSaverScreenState extends State<DataSaverScreen> {
  bool _isDataSaverEnabled = false;
  bool _reduceImageQuality = false;
  bool _disableBackgroundData = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color.fromARGB(255, 17, 125, 183)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          children: [
            // Back Button
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context); // Navigate back to the previous screen
                  },
                ),
                const Spacer(),
                const Text(
                  "Data Saver Settings",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const Spacer(flex: 2),
              ],
            ),
            const SizedBox(height: 20),

            // Enable Data Saver
            SwitchListTile(
              title: const Text("Enable Data Saver"),
              subtitle: const Text("Reduce data usage across the app"),
              value: _isDataSaverEnabled,
              onChanged: (bool value) {
                setState(() {
                  _isDataSaverEnabled = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // Reduce Image Quality
            if (_isDataSaverEnabled)
              SwitchListTile(
                title: const Text("Reduce Image Quality"),
                subtitle: const Text("Load lower quality images to save data"),
                value: _reduceImageQuality,
                onChanged: (bool value) {
                  setState(() {
                    _reduceImageQuality = value;
                  });
                },
              ),

            // Disable Background Data
            if (_isDataSaverEnabled)
              SwitchListTile(
                title: const Text("Disable Background Data"),
                subtitle: const Text("Prevent the app from using data in the background"),
                value: _disableBackgroundData,
                onChanged: (bool value) {
                  setState(() {
                    _disableBackgroundData = value;
                  });
                },
              ),

            const SizedBox(height: 30),

            // Save Settings Button
            ElevatedButton(
              onPressed: () {
                // Action to save data saver settings
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Data saver settings updated")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade900,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text("Save Settings"),
            ),
          ],
        ),
      ),
    );
  }
}
