import 'package:flutter/material.dart';
import 'navigationbar.dart';
import 'payment.dart';
// ✅ Import the payment screen

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
        child: Column(
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.menu, size: 30, color: Colors.black),
                  Row(
                    children: const [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('Assets/profile.png'),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Hello Saduni Silva!",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Icon(Icons.search, size: 30, color: Colors.black),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Featured Initiatives",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: [
                  SingleChildScrollView(
                    child: Column(
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
                        const SizedBox(height: 20),
                        _buildDonationCard(
                          image: "Assets/aboutUS2.png",
                          title: "Lets Help Speak And Smile",
                          description:
                              "A Baby Boy With Bilateral Cleft Lip And Palate Needs Urgent Surgery To Improve His Speech",
                          progress: 0.6,
                          raised: "LKR 599,218",
                          goal: "LKR 1,000,000",
                          bgColor: const Color(0xFFC6E3C5),
                          label1: "Donate To Children",
                          label2: "Double Your Donation",
                          organization: "MedicalAid.lk",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                1,
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

  Widget _buildDonationCard({
    required String image,
    required String title,
    required String description,
    required double progress,
    required String raised,
    required String goal,
    required Color bgColor,
    String? label1,
    String? label2,
    String organization = "Islandwide",
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.asset(
                    image,
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                  if (label1 != null || label2 != null)
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (label1 != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                label1,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          const SizedBox(height: 5),
                          if (label2 != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                label2,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  const Icon(Icons.verified_user,
                      size: 16, color: Colors.black54),
                  const SizedBox(width: 5),
                  Text(
                    organization,
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 8, 15, 5),
              child: Text(
                description,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Stack(
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
                    width: MediaQuery.of(context).size.width * progress * 0.75,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Raised : ",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    raised,
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  const Text(
                    "Goal : ",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    goal,
                    style: const TextStyle(fontSize: 14, color: Colors.teal),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PaymentPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3F3F2F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Donate Now",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
