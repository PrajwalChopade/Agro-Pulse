import 'package:flutter/material.dart';

class ResourcePage extends StatelessWidget {
  final Map<String, dynamic> resource;

  const ResourcePage({super.key, required this.resource});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(resource['name'] ?? "Resource Details"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Image.asset(
            resource['image'] ?? 'assets/placeholder.jpg',
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  resource['name'] ?? '',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  resource['type'] ?? '',
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      resource['price'] ?? '',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    ElevatedButton(
                      onPressed: resource['available'] ? () {} : null,
                      child: const Text("Book Now"),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  "Status: ${resource['available'] ? 'Available' : 'Booked'}",
                  style: TextStyle(fontSize: 16, color: resource['available'] ? Colors.green : Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
