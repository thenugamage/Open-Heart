import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'navbar.dart';
import 'sidebar.dart';
import 'donate.dart';
import 'chatbot.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userName;
  String? userPhoto;
  bool showSearchBar = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() {
    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      userName = user?.displayName ?? user?.email ?? "user";
      userPhoto = user?.photoURL ?? "https://i.pravatar.cc/150?img=9";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NewNavBar(selectedIndex: 0),
      bottomNavigationBar: const CustomNavigationBar(selectedIndex: 0),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade900,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ChatBotPage()),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Image.asset(
            'Assets/icons/bot.png',
            height: 26,
          ),
        ),
      ),
      body: Builder(
        builder: (context) => Container(
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
                if (showSearchBar) _buildSearchInput(),
                const SizedBox(height: 20),
                _buildLeaderboard(),
                const SizedBox(height: 20),
                _buildBanner(),
                const SizedBox(height: 20),
                _buildCategoryIcons(),
                const SizedBox(height: 20),
                _buildDonationButtons(),
                const SizedBox(height: 20),
                _buildSearchAndFilters(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(userPhoto!),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello ${userName ?? "User"}!",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Text("Where you want go",
                    style: TextStyle(fontSize: 13, color: Colors.grey)),
              ],
            ),
          ),
          IconButton(
            icon: Image.asset('Assets/icons/search.png', height: 22),
            onPressed: () {
              setState(() {
                showSearchBar = !showSearchBar;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: TextField(
          controller: _searchController,
          onSubmitted: (value) {
            debugPrint("Searching for: $value");
          },
          decoration: InputDecoration(
            hintText: 'Search here...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                _searchController.clear();
                setState(() => showSearchBar = false);
              },
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildLeaderboard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _leaderboardProfile("Jackson", "2000", "Assets/l1.png"),
            _leaderboardProfile("Eiden", "2430", "Assets/l2.png", true),
            _leaderboardProfile("Emma Aria", "1674", "Assets/l3.png"),
          ],
        ),
      ),
    );
  }

  Widget _leaderboardProfile(String name, String score, String imgPath, [bool isTop = false]) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            CircleAvatar(
              radius: isTop ? 30 : 25,
              backgroundImage: AssetImage(imgPath),
            ),
            if (isTop)
              const Positioned(
                bottom: -2,
                child: Icon(Icons.star, color: Colors.amber, size: 20),
              ),
          ],
        ),
        const SizedBox(height: 6),
        Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        Text(score, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset('Assets/homeimg1.png',
                width: double.infinity, height: 200, fit: BoxFit.cover),
            Column(
              children: [
                const Text("Start Your Own Funding",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                const Text("Create Your Own Hope Post",
                    style: TextStyle(fontSize: 14, color: Colors.white)),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DonatePage()),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _categoryIconImage("Assets/icons/all.png", "All"),
          _categoryIconImage("Assets/icons/pandemic.png", "Pandemic"),
          _categoryIconImage("Assets/icons/medicale.png", "Medical"),
          _categoryIconImage("Assets/icons/education.png", "Education"),
        ],
      ),
    );
  }

  Widget _categoryIconImage(String imagePath, String title) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Image.asset(imagePath, height: 28),
          ),
        ),
        const SizedBox(height: 5),
        Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildDonationButtons() {
    return Column(
      children: [
        _donationButton("Support A Donation Campaign", () {}),
        const SizedBox(height: 10),
        _donationButton("Start A Donation Campaign", () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DonatePage()),
          );
        }),
      ],
    );
  }

  Widget _donationButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: 300,
      height: 45,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.black),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(fontSize: 14, color: Colors.black)),
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
            Image.asset('Assets/homeimg2.png',
                width: double.infinity, height: 200, fit: BoxFit.cover),
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
        children: [
          Image.asset('Assets/icons/search.png', height: 18, color: Colors.white),
          const SizedBox(width: 5),
          const Text("Search Here", style: TextStyle(fontSize: 14, color: Colors.white)),
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
        label: Text(text, style: const TextStyle(fontSize: 14, color: Colors.white)),
      ),
    );
  }
}
