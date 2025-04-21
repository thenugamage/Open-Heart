import 'package:flutter/material.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Color(0xFF117DB7)],
              ),
            ),
          ),

          /// Background Image
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            bottom: 0,
            child: Opacity(
              opacity: 0.8,
              child: Image.asset(
                'Assets/backgroundimg.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// Page Content
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  /// Top Icons and Logo
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.person_outline, size: 28),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),

                  Image.asset("Assets/logo.png", height: 80),


                  const SizedBox(height: 20),

                  /// Greeting
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("Assets/user_profile.png"),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Hello!",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 30),

                  /// Grid Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1,
                      children: [
                        _DashboardTile(
                          imagePath: "Assets/currentProjects.png",
                          label: "Current Projects",
                          onTap: () {},
                        ),
                        _DashboardTile(
                          imagePath: "Assets/newRquests.png",
                          label: "New requests",
                          onTap: () {},
                        ),
                        _DashboardTile(
                          imagePath: "Assets/complains.png",
                          label: "Complains",
                          onTap: () {},
                        ),
                        _DashboardTile(
                          imagePath: "Assets/feedbacks.png",
                          label: "Feedbacks",
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardTile extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const _DashboardTile({
    required this.imagePath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF08385F),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Image.asset(imagePath)),
              const SizedBox(height: 10),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
