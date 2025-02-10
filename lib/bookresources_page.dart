import 'package:flutter/material.dart';
import 'resources_page.dart';

class BookResourcesPage extends StatefulWidget {
  const BookResourcesPage({super.key});

  @override
  State<BookResourcesPage> createState() => _BookResourcesPageState();
}

class _BookResourcesPageState extends State<BookResourcesPage> {
  String selectedCategory = 'All';

  final List<Map<String, dynamic>> resources = [
    {
      'name': 'Tractor - John Deere',
      'type': 'Vehicles',
      'image': 'assets/images/tracter.jpeg',
      'price': '\₹50/hour',
      'description': 'Modern farming tractor with advanced features',
      'available': true,
    },
    {
      'name': 'Harvester Machine',
      'type': 'Equipment',
      'image': 'assets/images/harvestor.jpeg',
      'price': '\₹75/hour',
      'description': 'High-capacity crop harvesting machine',
      'available': true,
    },
    {
      'name': 'Expert Farmer Team',
      'type': 'Manpower',
      'image': 'assets/images/expert_farmert.jpg',
      'price': '\₹200/day',
      'description': 'Skilled agricultural workers for various farming tasks',
      'available': false,
    },
    {
      'name': 'Irrigation System',
      'type': 'Tools',
      'image': 'assets/images/irrigation.jpeg',
      'price': '\₹30/day',
      'description': 'Advanced water distribution system for crops',
      'available': true,
    },
  ];

  List<Map<String, dynamic>> get filteredResources {
    if (selectedCategory == 'All') {
      return resources;
    }
    return resources.where((resource) => resource['type'] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Farm Resources",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Filter Section
          Container(
            color: Colors.green,
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'Categories',
                    style: TextStyle(
                      color: Colors.green[50],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    children: [
                      _buildCategoryChip('All'),
                      _buildCategoryChip('Equipment'),
                      _buildCategoryChip('Manpower'),
                      _buildCategoryChip('Tools'),
                      _buildCategoryChip('Vehicles'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Resources List
          Expanded(
            child: Container(
              color: Colors.grey[100],
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filteredResources.length,
                itemBuilder: (context, index) {
                  final resource = filteredResources[index];
                  return _buildResourceCard(context, resource);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
    final bool isSelected = selectedCategory == label;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: FilterChip(
        label: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.green : Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        selected: isSelected,
        onSelected: (bool value) {
          setState(() {
            selectedCategory = label;
          });
        },
        backgroundColor: Colors.green[700],
        selectedColor: Colors.white,
        checkmarkColor: Colors.green,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  Widget _buildResourceCard(BuildContext context, Map<String, dynamic> resource) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: resource['available']
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResourcePage(resource: resource),
                  ),
                );
              }
            : null,
        child: Column(
          children: [
            // Image Section
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(
                  resource['image'],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.image, size: 50, color: Colors.grey),
                    );
                  },
                ),
              ),
            ),
            // Content Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              resource['name'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                resource['type'],
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: resource['available']
                              ? Colors.green[100]
                              : Colors.red[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          resource['available'] ? 'Available' : 'Booked',
                          style: TextStyle(
                            color: resource['available']
                                ? Colors.green[800]
                                : Colors.red[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    resource['description'],
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        resource['price'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      if (resource['available'])
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ResourcePage(resource: resource),
                              ),
                            );
                          },
                          icon: const Icon(Icons.calendar_today_outlined),
                          label: const Text('Book Now'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                    ],
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