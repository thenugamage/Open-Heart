import 'package:flutter/material.dart';
import 'leaderboard.dart';
import 'navigationbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color.fromARGB(255, 17, 125, 183)],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              _buildTopBar(context),
              const SizedBox(height: 20),
              _buildLeaderboard(),
              const SizedBox(height: 20),
              _buildBanner(context),
              const SizedBox(height: 20),
              _buildCategoryIcons(),
              const SizedBox(height: 20),
              _buildDonationButtons(context),
              const SizedBox(height: 20),
              _buildSearchAndFilters(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(), // now handles settings
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.menu, size: 30, color: Colors.black),
            onPressed: () {},
          ),
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('Assets/profile.png'),
              ),
              const SizedBox(width: 10),
              const Text(
                "Hello Saduni Silva!",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Icon(Icons.search, size: 30, color: Colors.black),
        ],
      ),
    );
  }

  Widget _buildLeaderboard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _leaderboardProfile("Jackson", "2000", "Assets/profile1.png"),
                _leaderboardProfile(
                    "Eiden", "2430", "Assets/profile2.png", true),
                _leaderboardProfile("Emma Aria", "1674", "Assets/profile3.png"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _leaderboardProfile(String name, String score, String imgPath,
      [bool isTop = false]) {
    return Column(
      children: [
        CircleAvatar(
          radius: isTop ? 30 : 25,
          backgroundImage: AssetImage(imgPath),
        ),
        Text(name,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
        Text(score,
            style: const TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold)),
        if (isTop) const Icon(Icons.star, color: Colors.yellow, size: 20),
      ],
    );
  }

  Widget _buildBanner(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'Assets/homeimg1.png',
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LeaderboardPage()),
                    );
                  },
                  child: const Text("Start Now"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

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
        const SizedBox(height: 5),
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

  Widget _buildDonationButtons(BuildContext context) {
    return Column(
      children: [
        _donationButton("Support A Donation Campaign", context),
        const SizedBox(height: 10),
        _donationButton("Start A Donation Campaign", context),
      ],
    );
  }

  Widget _donationButton(String text, BuildContext context) {
    return SizedBox(
      width: 300,
      height: 45,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.black),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {
          // Removed navigation to PaymentPage
          // You can add a different action here if needed
        },
        child: Text(
          text,
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'Assets/homeimg2.png',
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
        label: Text(text,
            style: const TextStyle(fontSize: 14, color: Colors.white)),
      ),
    );
  }
}
