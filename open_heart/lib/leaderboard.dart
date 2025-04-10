import 'package:flutter/material.dart';
import 'home.dart';
import 'navigationbar.dart';
import 'FeatureInitiatives.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FeaturedInitiativesPage(),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.volunteer_activism),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomNavigationBar(),
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
              _buildTopThreeLeaderboard(),
              const SizedBox(height: 30),
              _buildOtherDonors(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon:
                    const Icon(Icons.arrow_back, size: 30, color: Colors.black),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
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
              IconButton(
                icon: const Icon(Icons.search, size: 30, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FeaturedInitiativesPage(),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            "Leaderboard",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopThreeLeaderboard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildTopUser("Jackson", "2000", "Assets/profile1.png", 2),
            _buildTopUser("Eiden", "2430", "Assets/profile2.png", 1),
            _buildTopUser("Emma Aria", "1674", "Assets/profile3.png", 3),
          ],
        ),
      ),
    );
  }

  Widget _buildTopUser(String name, String score, String imgPath, int rank) {
    double height = rank == 1
        ? 180
        : rank == 2
            ? 150
            : 130;
    Color badgeColor = rank == 1
        ? Colors.amber
        : rank == 2
            ? Colors.grey
            : Colors.brown;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: height,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 5)],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(radius: 30, backgroundImage: AssetImage(imgPath)),
              const SizedBox(height: 8),
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(score,
                  style: const TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Icon(Icons.emoji_events, color: badgeColor),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOtherDonors() {
    final donors = [
      {
        "name": "Sebastian",
        "username": "@auseim",
        "score": 1124,
        "image": "Assets/profile1.png"
      },
      {
        "name": "Jason",
        "username": "@natali",
        "score": 875,
        "image": "Assets/profile2.png"
      },
      {
        "name": "Natalie",
        "username": "@uaseim",
        "score": 774,
        "image": "Assets/profile3.png"
      },
      {
        "name": "Serenity",
        "username": "@serenity",
        "score": 633,
        "image": "Assets/profile1.png"
      },
      {
        "name": "Hannah",
        "username": "@hannah",
        "score": 559,
        "image": "Assets/profile2.png"
      },
    ];

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xff1c2331),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: donors.length,
        padding: const EdgeInsets.all(16),
        separatorBuilder: (_, __) => const Divider(color: Colors.white10),
        itemBuilder: (context, index) {
          final donor = donors[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(donor['image'] as String),
            ),
            title: Text(donor['name'] as String,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text(donor['username'] as String,
                style: const TextStyle(color: Colors.white54)),
            trailing: Text(donor['score'].toString(),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          );
        },
      ),
    );
  }
}
