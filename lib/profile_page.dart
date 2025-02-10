import 'package:agri_app/about_page.dart';
import 'package:agri_app/bookresources_page.dart';
import 'package:agri_app/connect_page.dart';
import 'package:agri_app/terms_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 0;
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.green[700],
        title: const Text(
          "My Profile 👤",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications coming soon!')),
              );
            },
          ),
          IconButton(
            icon: Icon(
              _isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _isDarkMode = !_isDarkMode;
              });
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: _isDarkMode ? Colors.grey[900] : Colors.white,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.green[700]!,
                      Colors.green[500]!,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 45, color: Colors.green),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Prajwal Chopade',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Farmer ID: AGR-1234',
                      style: TextStyle(color: Colors.green[100]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: _isDarkMode ? Colors.grey[900] : Colors.grey[100],
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: _isDarkMode ? Colors.grey[850] : Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Stack(
                        children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.green[100],
                          backgroundImage: AssetImage('assets/images/farmer.png'),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.green, width: 2),
                            ),
                            child: Icon(
                              Icons.edit,
                              size: 20,
                              color: Colors.green[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Prajwal Chopade",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: _isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(
                      "Premium Member",
                      style: TextStyle(
                        color: Colors.green[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _buildInfoCard(
                      icon: Icons.email_outlined,
                      title: "Email",
                      value: "prajwal.2242046@viit.ac.in",
                      isDarkMode: _isDarkMode,
                    ),
                    _buildInfoCard(
                      icon: Icons.phone_outlined,
                      title: "Phone",
                      value: "+91 9359475561",
                      isDarkMode: _isDarkMode,
                    ),
                    _buildInfoCard(
                      icon: Icons.location_on_outlined,
                      title: "Location",
                      value: "Maharashtra, India",
                      isDarkMode: _isDarkMode,
                    ),
                    _buildInfoCard(
                      icon: Icons.agriculture_outlined,
                      title: "Farm Size",
                      value: "5 Acres",
                      isDarkMode: _isDarkMode,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatsCard(
                            "Crops",
                            "4",
                            Icons.grass,
                            Colors.green,
                            _isDarkMode,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildStatsCard(
                            "Resources",
                            "3",
                            Icons.book,
                            Colors.blue,
                            _isDarkMode,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.white,
        selectedItemColor: Colors.green[700],
        unselectedItemColor: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            activeIcon: Icon(Icons.bookmark),
            label: 'Resources',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.connect_without_contact_outlined),
            activeIcon: Icon(Icons.connect_without_contact),
            label: 'Connect',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });

          switch (index) {
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const BookResourcesPage()),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) =>  ConnectPage()),
              );
              break;
          }
        },
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required bool isDarkMode,
  }) {
    return Card(
      color: isDarkMode ? Colors.grey[850] : Colors.white,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.green[700]),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard(
    String title,
    String value,
    IconData icon,
    Color color,
    bool isDarkMode,
  ) {
    return Card(
      color: isDarkMode ? Colors.grey[850] : Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}