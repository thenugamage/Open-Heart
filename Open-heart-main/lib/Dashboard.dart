import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F0FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black87),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("Assets/.png"),
              ),
              const SizedBox(height: 8),
              const Text("Hello Saduni Silva!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),

              // Top Contributors
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _topContributor("Jackson", 2000, Colors.blue),
                    _topContributor("Elden", 2430, Colors.orange, isStar: true),
                    _topContributor("Emma Aria", 1674, Colors.green),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Banner
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset("Assets/banner.png"),
                    Column(
                      children: [
                        const Text("Start Your Own Funding",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        const Text("Create Your Own Dono Post"),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("Start Now"),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Categories
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _categoryIcon(Icons.apps, "All"),
                  _categoryIcon(Icons.coronavirus, "Pandemic"),
                  _categoryIcon(Icons.local_hospital, "Medical"),
                  _categoryIcon(Icons.school, "Education"),
                ],
              ),

              const SizedBox(height: 20),

              // Buttons
              ElevatedButton(
                onPressed: () {},
                child: const Text("Support A Donation Campaign"),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () {},
                child: const Text("Start A Donation Campaign"),
              ),

              const SizedBox(height: 20),

              // Search section
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage("Assets/search_bg.png"),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    _searchField("Search Here"),
                    const SizedBox(height: 10),
                    _searchField("Category"),
                    const SizedBox(height: 10),
                    _searchField("Location"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),

          BottomNavigationBarItem(icon: Icon(Icons.volunteer_activism), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }

  Widget _topContributor(String name, int score, Color color, {bool isStar = false}) {
    return Column(
      children: [
        CircleAvatar(radius: 24, backgroundColor: color),
        const SizedBox(height: 6),
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(score.toString(), style: TextStyle(color: color)),
        if (isStar) const Icon(Icons.star, color: Colors.amber, size: 16),
      ],
    );
  }

  Widget _categoryIcon(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(icon, color: Colors.black),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12))
      ],
    );
  }

  Widget _searchField(String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.white),
          const SizedBox(width: 10),
          Text(hint, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}