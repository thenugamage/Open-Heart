import 'package:flutter/material.dart';
import 'main.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.blue.shade300],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),

              // Top Menu & Search Icons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.menu, size: 30, color: Colors.black),
                    Icon(Icons.search, size: 30, color: Colors.black),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // **Main Banner**
              _buildBanner(),

              const SizedBox(height: 20),

              // **Category Icons**
              _buildCategoryIcons(),

              const SizedBox(height: 20),

              // **Support & Start Donation Buttons**
              _buildDonationButtons(),

              const SizedBox(height: 20),

              // **Search & Filter Section**
              _buildSearchAndFilters(),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // **Banner Section**
  Widget _buildBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'Assets/homeimg1.png', // Replace with your actual banner image
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                const Text(
                  "Start Your Own Funding",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 2,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                const Text(
                  "Create Your Own Hope Post",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("Start Now"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // **Category Icons Section**
  Widget _buildCategoryIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _categoryIcon(Icons.grid_view, "All"),
        _categoryIcon(Icons.coronavirus, "Pandemic"),
        _categoryIcon(Icons.local_hospital, "Medical"),
        _categoryIcon(Icons.school, "Education"),
      ],
    );
  }

  Widget _categoryIcon(IconData icon, String title) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 28,
          child: Icon(icon, size: 30, color: Colors.black),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // **Donation Buttons**
  Widget _buildDonationButtons() {
    return Column(
      children: [
        _donationButton("Support A Donation Campaign"),
        const SizedBox(height: 10),
        _donationButton("Start A Donation Campaign"),
      ],
    );
  }

  Widget _donationButton(String text) {
    return SizedBox(
      width: 300,
      height: 45,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.black),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {},
        child: Text(
          text,
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
      ),
    );
  }

  // **Search & Filters**
  Widget _buildSearchAndFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'Assets/homeimg2.png', // Background image for search section
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                _searchBox(),
                const SizedBox(height: 20),
                _filterButton(Icons.category, "Category"),
                const SizedBox(height: 10),
                _filterButton(Icons.location_on, "Location"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // **Search Bar**
  Widget _searchBox() {
    return Container(
      width: 250,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.blue.shade900,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.search, color: Colors.white, size: 18),
          SizedBox(width: 5),
          Text(
            "Search Here",
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // **Filter Buttons (Category & Location)**
  Widget _filterButton(IconData icon, String text) {
    return SizedBox(
      width: 180,
      height: 35,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black.withOpacity(0.7),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {},
        icon: Icon(icon, color: Colors.white, size: 16),
        label: Text(
          text,
          style: const TextStyle(fontSize: 14, color: Colors.white),
        ),
      ),
    );
  }

  // **Bottom Navigation Bar**
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: Colors.blue.shade900,
      unselectedItemColor: Colors.black,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.category), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
      ],
    );
  }
}
