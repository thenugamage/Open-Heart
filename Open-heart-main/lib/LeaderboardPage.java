import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'navbar.dart'; // Bottom nav bar
import 'sidebar.dart'; // Sidebar drawer

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  bool showSearchBar = false;
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> donors = [
    {
      "name": "Sebastian",
      "username": "@auseim",
      "score": 1124,
      "image": "https://i.pravatar.cc/150?img=1"
    },
    {
      "name": "Jason",
      "username": "@natali",
      "score": 921,
      "image": "https://i.pravatar.cc/150?img=2"
    },
    {
      "name": "Natalie",
      "username": "@uaseim",
      "score": 774,
      "image": "https://i.pravatar.cc/150?img=3"
    },
    {
      "name": "Serenity",
      "username": "@uaseim",
      "score": 633,
      "image": "https://i.pravatar.cc/150?img=4"
    },
    {
      "name": "Hannah",
      "username": "@hannah",
      "score": 559,
      "image": "https://i.pravatar.cc/150?img=5"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userPhoto = user?.photoURL ?? 'Assets/icons/user.png';
    final userName = user?.displayName ?? user?.email ?? 'User';

    return Scaffold(
      backgroundColor: const Color(0xffe8f1fb),
      drawer: const NewNavBar(selectedIndex: 1),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 60,
        leading: Builder(
          builder: (context) => GestureDetector(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: userPhoto.startsWith("http")
                    ? NetworkImage(userPhoto)
                    : AssetImage(userPhoto) as ImageProvider,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Image.asset('Assets/icons/search.png', height: 22),
            onPressed: () {
              setState(() {
                showSearchBar = !showSearchBar;
              });
            },
          ),
        ],
        title: showSearchBar
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "Search...",
                  border: InputBorder.none,
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello $userName",
                    style: const TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                  Text(
                    "Where you want go",
                    style: TextStyle(color: Colors.pink[300], fontSize: 12),
                  ),
                ],
              ),
      ),

      body: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            "Leaderboard",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildTopUser("Jackson", "https://i.pravatar.cc/100?img=6", "2000", 2),
                buildTopUser("Elden", "https://i.pravatar.cc/100?img=7", "2430", 1),
                buildTopUser("Emma Aria", "https://i.pravatar.cc/100?img=8", "1800", 3),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xff1c2331),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: donors.length,
                separatorBuilder: (_, __) => const Divider(color: Colors.white10),
                itemBuilder: (context, index) {
                  final donor = donors[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(donor['image']),
                    ),
                    title: Text(
                      donor['name'],
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      donor['username'],
                      style: const TextStyle(color: Colors.white54),
                    ),
                    trailing: Text(
                      donor['score'].toString(),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: const CustomNavigationBar(selectedIndex: 1),
    );
  }

  Widget buildTopUser(String name, String imageUrl, String score, int position) {
    double avatarSize = position == 1 ? 80 : 60;
    Color circleColor = position == 1
        ? Colors.orange
        : position == 2
            ? Colors.blue
            : Colors.green;

    return Column(
      children: [
        CircleAvatar(
          radius: avatarSize / 2,
          backgroundColor: circleColor,
          child: CircleAvatar(
            radius: avatarSize / 2 - 4,
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
        const SizedBox(height: 8),
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(
          score,
          style: TextStyle(
            color: position == 1
                ? Colors.orange
                : (position == 2 ? Colors.cyan : Colors.green),
          ),
        ),
        if (position == 1) const Icon(Icons.star, color: Colors.amber),
      ],
    );
  }
}
