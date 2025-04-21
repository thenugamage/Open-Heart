import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/navigationbar.dart';
import 'sidebar_screen.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  bool showSearchBar = false;
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> donors = [
    {"name": "Sebastian", "username": "@usern", "score": 1124, "image": "https://i.pravatar.cc/150?img=1"},
    {"name": "Jason", "username": "@usern", "score": 875, "image": "https://i.pravatar.cc/150?img=2"},
    {"name": "Natalie", "username": "@usern", "score": 774, "image": "https://i.pravatar.cc/150?img=3"},
    {"name": "Serenity", "username": "@usern", "score": 723, "image": "https://i.pravatar.cc/150?img=4"},
    {"name": "Hannah", "username": "@usern", "score": 559, "image": "https://i.pravatar.cc/150?img=5"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe8f1fb),
      drawer: const NewNavBar(selectedIndex: 1),
      appBar: _buildAppBar(),
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
          const SizedBox(height: 10),
          buildTop3Section(),
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

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          final userPhoto = user?.photoURL ?? 'https://i.pravatar.cc/150?img=9';
          final userName = user?.displayName ?? user?.email ?? 'User';

          return AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leadingWidth: 70,
            leading: Builder(
              builder: (context) => GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(userPhoto),
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
                Text("Hello $userName",
                    style: const TextStyle(
                        color: Colors.black87, fontSize: 16)),
                Text(
                  "Where you want go",
                  style: TextStyle(color: Colors.pink[300], fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildTop3Section() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xff1c2331),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blueAccent, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildPodiumUser(
            position: 2,
            name: "Jackson",
            score: "2000",
            imageUrl: "https://i.pravatar.cc/100?img=6",
            color: Colors.blue,
          ),
          _buildPodiumUser(
            position: 1,
            name: "Elden",
            score: "2430",
            imageUrl: "https://i.pravatar.cc/100?img=7",
            color: Colors.orange,
            isCenter: true,
          ),
          _buildPodiumUser(
            position: 3,
            name: "Emma Aria",
            score: "1674",
            imageUrl: "https://i.pravatar.cc/100?img=8",
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildPodiumUser({
    required int position,
    required String name,
    required String score,
    required String imageUrl,
    required Color color,
    bool isCenter = false,
  }) {
    double avatarSize = isCenter ? 80 : 65;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: avatarSize + 10,
              height: avatarSize + 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 4),
              ),
              child: CircleAvatar(
                radius: avatarSize / 2,
                backgroundImage: NetworkImage(imageUrl),
              ),
            ),
            Positioned(
              top: -8,
              right: -8,
              child: CircleAvatar(
                radius: 10,
                backgroundColor: color,
                child: Text(
                  '$position',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        if (position == 1) ...[
          Image.asset(
            'Assets/icons/star.png',
            width: 26,
            height: 26,
          ),
          const SizedBox(height: 6),
        ],
        Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          score,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
