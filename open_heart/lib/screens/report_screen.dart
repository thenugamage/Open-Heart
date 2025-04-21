import 'package:flutter/material.dart';

class ReportProblemPage extends StatelessWidget {
  const ReportProblemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent.shade100,
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Report & Problem',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Center(
                child: Column(
                  children: [
                    Image.asset('Assets/logo.png', height: 80),

                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Report & Problem',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blueGrey),
                ),
                child: Text(
                  'SETI Complaint Box provides an accessible, user-friendly, and secure platform for students to submit complaints and voice their concerns.\n\nBy using the SETI Complaint Box, students can contribute to the ongoing improvement of SETI\'s academic and non-academic environment, ensuring a positive and productive learning experience for all.',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Rules To Follow',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text('1. Be specific and detailed'),
              Text('2. Use respectful language'),
              Text('3. Provide evidence or examples'),
              Text('4. Avoid submitting duplicate complaints'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.location_city), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.volunteer_activism), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.emoji_people), label: ''),
      ],
    );
  }
}
