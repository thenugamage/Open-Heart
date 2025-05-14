import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  // Add search-related state variables
  String _searchQuery = '';
  List<Map<String, dynamic>> _donationCampaigns = [];
  List<Map<String, dynamic>> _filteredCampaigns = [];
  String _selectedCategory = 'All';

  // List to store top 3 leaderboard users
  List<Map<String, dynamic>> topUsers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    _fetchTopLeaderboardUsers();
    _fetchDonationCampaigns(); // Fetch campaigns when the page loads

    // Add listener to search controller
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  // Search change listener
  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
      _filterCampaigns();
    });
  }

  // Filter campaigns based on search query and category
  void _filterCampaigns() {
    if (_searchQuery.isEmpty && _selectedCategory == 'All') {
      _filteredCampaigns = List.from(_donationCampaigns);
    } else {
      _filteredCampaigns =
          _donationCampaigns.where((campaign) {
            // Filter by search query
            final matchesQuery =
                _searchQuery.isEmpty ||
                campaign['title'].toString().toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ) ||
                campaign['description'].toString().toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                );

            // Filter by category
            final matchesCategory =
                _selectedCategory == 'All' ||
                campaign['category'] == _selectedCategory;

            return matchesQuery && matchesCategory;
          }).toList();
    }
  }

  // Method to set selected category
  void _setCategory(String category) {
    setState(() {
      _selectedCategory = category;
      _filterCampaigns();
    });
  }

  void _getCurrentUser() {
    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      userName = user?.displayName ?? user?.email ?? "user";
      userPhoto = user?.photoURL ?? "https://i.pravatar.cc/150?img=9";
    });
  }

  // Fetch donation campaigns from Firestore
  Future<void> _fetchDonationCampaigns() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('campaigns').get();

      final campaigns =
          snapshot.docs.map((doc) {
            final data = doc.data();
            return {
              'id': doc.id,
              'title': data['title'] ?? 'Untitled Campaign',
              'description': data['description'] ?? 'No description',
              'category': data['category'] ?? 'All',
              'location': data['location'] ?? 'Not specified',
              'goal': data['goal'] ?? 0,
              'current': data['current'] ?? 0,
              'image': data['image'] ?? 'https://via.placeholder.com/150',
              'createdBy': data['createdBy'] ?? 'Anonymous',
              'createdAt': data['createdAt'] ?? Timestamp.now(),
            };
          }).toList();

      setState(() {
        _donationCampaigns = campaigns;
        _filteredCampaigns = campaigns; // Initially show all campaigns
      });
    } catch (e) {
      debugPrint("Error fetching campaigns: $e");
      // Use sample data if there's an error
      setState(() {
        _donationCampaigns = [
          {
            'id': '1',
            'title': 'Help Children\'s Education',
            'description': 'Support education for underprivileged children',
            'category': 'Education',
            'location': 'New York',
            'goal': 5000,
            'current': 2500,
            'image': 'https://via.placeholder.com/150',
            'createdBy': 'Education Foundation',
          },
          {
            'id': '2',
            'title': 'COVID-19 Relief Fund',
            'description': 'Help families affected by the pandemic',
            'category': 'Pandemic',
            'location': 'Global',
            'goal': 10000,
            'current': 4500,
            'image': 'https://via.placeholder.com/150',
            'createdBy': 'Relief Organization',
          },
          {
            'id': '3',
            'title': 'Medical Support for Sarah',
            'description': 'Help Sarah with her medical treatment',
            'category': 'Medical',
            'location': 'Chicago',
            'goal': 8000,
            'current': 3200,
            'image': 'https://via.placeholder.com/150',
            'createdBy': 'Sarah\'s Family',
          },
        ];
        _filteredCampaigns = _donationCampaigns;
      });
    }
  }

  Future<void> _fetchTopLeaderboardUsers() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Fetch leaderboard users from Firestore
      final snapshot =
          await FirebaseFirestore.instance
              .collection('leaderboard')
              .orderBy('points', descending: true)
              .limit(3)
              .get();

      final fetchedUsers =
          snapshot.docs.map((doc) {
            final data = doc.data();
            return {
              'name': data['displayName'] ?? 'User',
              'score': data['points']?.toString() ?? '0',
              'image': data['photoURL'] ?? 'https://i.pravatar.cc/150?img=9',
            };
          }).toList();

      // If we have less than 3 users, add demo users
      if (fetchedUsers.length < 3) {
        final demoUsers = [
          {
            "name": "Jackson",
            "score": "2000",
            "image": "https://i.pravatar.cc/150?img=1",
          },
          {
            "name": "Eiden",
            "score": "2430",
            "image": "https://i.pravatar.cc/150?img=2",
          },
          {
            "name": "Emma Aria",
            "score": "1674",
            "image": "https://i.pravatar.cc/150?img=3",
          },
        ];

        while (fetchedUsers.length < 3) {
          fetchedUsers.add(demoUsers[fetchedUsers.length]);
        }
      }

      setState(() {
        topUsers = fetchedUsers;
        isLoading = false;
      });
    } catch (e) {
      // Fallback to demo data if there's an error
      setState(() {
        topUsers = [
          {
            "name": "Jackson",
            "score": "2000",
            "image": "https://i.pravatar.cc/150?img=1",
          },
          {
            "name": "Eiden",
            "score": "2430",
            "image": "https://i.pravatar.cc/150?img=2",
          },
          {
            "name": "Emma Aria",
            "score": "1674",
            "image": "https://i.pravatar.cc/150?img=3",
          },
        ];
        isLoading = false;
      });
      debugPrint("Error fetching leaderboard data: $e");
    }
  }

  // Method to refresh all data
  Future<void> _refreshData() async {
    await Future.wait([_fetchTopLeaderboardUsers(), _fetchDonationCampaigns()]);
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
          child: Image.asset('Assets/icons/bot.png', height: 26),
        ),
      ),
      body: Builder(
        builder:
            (context) => Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Color.fromARGB(255, 17, 125, 183)],
                ),
              ),
              child: RefreshIndicator(
                onRefresh: _refreshData,
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
                      const SizedBox(height: 20),
                      // Display filtered campaigns
                      _buildCampaignsList(),
                      const SizedBox(height: 30),
                    ],
                  ),
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
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Text(
                  "Where you want go",
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Image.asset('Assets/icons/search.png', height: 22),
            onPressed: () {
              setState(() {
                showSearchBar = !showSearchBar;
                // Clear search when hiding the search bar
                if (!showSearchBar) {
                  _searchController.clear();
                  _searchQuery = '';
                  _filterCampaigns();
                }
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
            setState(() {
              _searchQuery = value;
              _filterCampaigns();
            });
          },
          decoration: InputDecoration(
            hintText: 'Search campaigns...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                _searchController.clear();
                setState(() {
                  showSearchBar = false;
                  _searchQuery = '';
                  _filterCampaigns();
                });
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
        child:
            isLoading
                ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Display 2nd place (index 1)
                    _leaderboardProfile(
                      topUsers.length > 1 ? topUsers[1]['name'] : 'User',
                      topUsers.length > 1 ? topUsers[1]['score'] : '0',
                      topUsers.length > 1
                          ? topUsers[1]['image']
                          : 'https://i.pravatar.cc/150?img=1',
                    ),
                    // Display 1st place (index 0) with star
                    _leaderboardProfile(
                      topUsers.isNotEmpty ? topUsers[0]['name'] : 'User',
                      topUsers.isNotEmpty ? topUsers[0]['score'] : '0',
                      topUsers.isNotEmpty
                          ? topUsers[0]['image']
                          : 'https://i.pravatar.cc/150?img=2',
                      true,
                    ),
                    // Display 3rd place (index 2)
                    _leaderboardProfile(
                      topUsers.length > 2 ? topUsers[2]['name'] : 'User',
                      topUsers.length > 2 ? topUsers[2]['score'] : '0',
                      topUsers.length > 2
                          ? topUsers[2]['image']
                          : 'https://i.pravatar.cc/150?img=3',
                    ),
                  ],
                ),
      ),
    );
  }

  Widget _leaderboardProfile(
    String name,
    String score,
    String imgPath, [
    bool isTop = false,
  ]) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isTop ? Colors.amber : Colors.blue,
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: isTop ? 30 : 25,
                backgroundImage: NetworkImage(imgPath),
              ),
            ),
            if (isTop)
              const Positioned(
                bottom: -2,
                child: Icon(Icons.star, color: Colors.amber, size: 20),
              ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          score,
          style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
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
          _categoryIconButton("Assets/icons/all.png", "All"),
          _categoryIconButton("Assets/icons/pandemic.png", "Pandemic"),
          _categoryIconButton("Assets/icons/medicale.png", "Medical"),
          _categoryIconButton("Assets/icons/education.png", "Education"),
        ],
      ),
    );
  }

  // Updated to make categories interactive
  Widget _categoryIconButton(String imagePath, String title) {
    final isSelected = _selectedCategory == title;

    return GestureDetector(
      onTap: () => _setCategory(title),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: isSelected ? Colors.blue.shade900 : Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Image.asset(
                imagePath,
                height: 28,
                color: isSelected ? Colors.white : null,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.blue.shade900 : Colors.black,
            ),
          ),
        ],
      ),
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
    return GestureDetector(
      onTap: () {
        setState(() {
          showSearchBar = true;
        });
      },
      child: Container(
        width: 250,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.blue.shade900,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'Assets/icons/search.png',
              height: 18,
              color: Colors.white,
            ),
            const SizedBox(width: 5),
            const Text(
              "Search Here",
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ],
        ),
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
        onPressed: () {
          // Show filter dialog based on button
          if (text == "Category") {
            _showCategoryFilterDialog();
          } else if (text == "Location") {
            _showLocationFilterDialog();
          }
        },
        icon: Icon(icon, color: Colors.white, size: 16),
        label: Text(
          text,
          style: const TextStyle(fontSize: 14, color: Colors.white),
        ),
      ),
    );
  }

  // Method to show category filter dialog
  void _showCategoryFilterDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Select Category"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _filterDialogOption("All"),
                _filterDialogOption("Pandemic"),
                _filterDialogOption("Medical"),
                _filterDialogOption("Education"),
              ],
            ),
          ),
    );
  }

  // Method to show location filter dialog
  void _showLocationFilterDialog() {
    // You can fetch this data from Firestore if needed
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Select Location"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _filterDialogOption("All Locations", isLocation: true),
                _filterDialogOption("New York", isLocation: true),
                _filterDialogOption("Chicago", isLocation: true),
                _filterDialogOption("Global", isLocation: true),
              ],
            ),
          ),
    );
  }

  // Helper for filter dialog options
  Widget _filterDialogOption(String option, {bool isLocation = false}) {
    return ListTile(
      title: Text(option),
      onTap: () {
        Navigator.pop(context);
        setState(() {
          if (!isLocation) {
            _selectedCategory = option;
          } else {
            // Handle location filtering similarly (not implemented in this example)
          }
          _filterCampaigns();
        });
      },
    );
  }

  // Widget to display filtered campaigns
  Widget _buildCampaignsList() {
    if (_filteredCampaigns.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Text(
            "No campaigns found matching your search criteria.",
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            _searchQuery.isNotEmpty || _selectedCategory != 'All'
                ? "Search Results"
                : "Recent Campaigns",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _filteredCampaigns.length,
          itemBuilder: (context, index) {
            final campaign = _filteredCampaigns[index];
            return _buildCampaignCard(campaign);
          },
        ),
      ],
    );
  }

  // Campaign card widget
  Widget _buildCampaignCard(Map<String, dynamic> campaign) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              child: Image.network(
                campaign['image'],
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) => Container(
                      height: 150,
                      color: Colors.grey.shade200,
                      child: const Center(child: Icon(Icons.image, size: 50)),
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          campaign['category'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.location_on,
                        size: 14,
                        color: Colors.grey.shade600,
                      ),
                      Text(
                        campaign['location'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    campaign['title'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    campaign['description'],
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Progress bar
                  LinearProgressIndicator(
                    value: (campaign['current'] / campaign['goal']).clamp(
                      0.0,
                      1.0,
                    ),
                    backgroundColor: Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.blue.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${campaign['current']} raised",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Goal: \$${campaign['goal']}",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade900,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        // Navigate to campaign details page
                      },
                      child: const Text("Donate Now"),
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
}
