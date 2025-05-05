import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'selectionPage.dart';
import 'admin_currentprojects.dart';
import 'addnew_project.dart';
import 'complaint_page.dart';
import 'admin_feedbacks.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userName = user?.displayName ?? 'Admin';
    final userPhoto = user?.photoURL ?? '';

    return Scaffold(
      body: Stack(
        children: [
          // 🔵 Background image
          Positioned.fill(
            child: Image.asset(
              'Assets/backgroundimg.png',
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  // 🔙 Back button (top-left)
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const SelectionPage()),
                      ),
                      child: Image.asset('Assets/icons/back.png', height: 28),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // 🔝 Logo Centered
                  Center(
                    child: Image.asset('Assets/logo.png', height: 90),
                  ),

                  const SizedBox(height: 10),

                  // 👋 Greeting with profile pic Centered
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: userPhoto.isNotEmpty
                            ? NetworkImage(userPhoto)
                            : const AssetImage('Assets/icons/user.png')
                        as ImageProvider,
                        radius: 22,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Hello $userName!",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // 🟦 Buttons Grid
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      children: [
                        _DashboardCard(
                          title: 'Current Projects',
                          imagePath: 'Assets/admin1.png',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AdminCurrentProjects(),
                              ),
                            );
                          },
                        ),
                        _DashboardCard(
                          title: 'New requests',
                          imagePath: 'Assets/admin2.png',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AddNewProjectPage(),
                              ),
                            );
                          },
                        ),
                        _DashboardCard(
                          title: 'Complains',
                          imagePath: 'Assets/admin3.png',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ComplaintPage(),
                              ),
                            );
                          },
                        ),
                        _DashboardCard(
                          title: 'Feedbacks',
                          imagePath: 'Assets/admin4.png',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AdminViewFeedbacks(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const _DashboardCard({
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xff003c6e),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 60),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
