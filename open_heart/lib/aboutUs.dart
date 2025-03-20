import 'package:flutter/material.dart';
import 'main.dart';


class FeaturedInitiativesPage extends StatefulWidget {
  const FeaturedInitiativesPage({super.key});

  @override
  _FeaturedInitiativesPageState createState() =>
      _FeaturedInitiativesPageState();
}

class _FeaturedInitiativesPageState extends State<FeaturedInitiativesPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

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
            colors: [Colors.white,  Color.fromARGB(255, 17, 125, 183)],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 50),

            // **Top Menu & Search Icons**
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.menu, size: 30, color: Colors.black),
                  const Text(
                    "about us",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Icon(Icons.search, size: 30, color: Colors.black),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // **Title**
            const Text(
              "Featured Initiatives",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 20),

            // **PageView with Swiping**
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: [
                  _buildDonationCard(
                    image: "Assets/aboutUS1.png",
                    title: "Suwaseriya Appeal",
                    description:
                        "Suwaseriya Sri Lanka, The Nation's Free Nationwide Emergency Ambulance Service...",
                    progress: 0.15,
                    raised: "LKR 1,499,218",
                    goal: "LKR 10,000,000",
                    bgColor: Colors.blue.shade100,
                  ),
                  _buildDonationCard(
                    image: "Assets/aboutUS2.png",
                    title: "Lets Help Speak And Smile",
                    description:
                        "A Baby Boy With Bilateral Cleft Lip And Palate Needs Urgent Surgery...",
                    progress: 0.60,
                    raised: "LKR 599,218",
                    goal: "LKR 1,000,000",
                    bgColor: Colors.green.shade100,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // **Indicator Dots**
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                2,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? Colors.blue.shade900
                        : Colors.grey,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // **Donation Card Widget**
  Widget _buildDonationCard({
    required String image,
    required String title,
    required String description,
    required double progress,
    required String raised,
    required String goal,
    required Color bgColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            // **Image with Overlay**
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.asset(
                    image,
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade900,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        "Double Your Donation",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // **Donation Details**
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),

                  const SizedBox(height: 10),

                  // **Progress Bar**
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      Container(
                        width: progress * 250,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade900,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // **Raised & Goal Amount**
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Raised: $raised",
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      Text(
                        "Goal: $goal",
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // **Donate Now Button**
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Donate Now",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
