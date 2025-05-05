import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
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
                    'Contact Us',
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
                'Contact Us',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Crowdfunding has no limit, and we\'re here for you. Our dedicated teams are on stand-by to answer any inquiry you may have.',
              ),
              SizedBox(height: 15),
              Text('Visit Us', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                'Dialog Axiata PLC, 475, Union Place, Colombo 02, Sri Lanka.',
              ),
              SizedBox(height: 15),
              Text('Hotline', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Mon - Fri 9am to 6pm\nHotline Num: 076-8585457'),
              SizedBox(height: 15),
              Text('Email us', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('openheart@gmail.com'),
              SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildImageBox('Assets/child1.png'),
                  _buildImageBox('Assets/child2.png'),
                  _buildImageBox('Assets/child3.png'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageBox(String path) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(
        path,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
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
