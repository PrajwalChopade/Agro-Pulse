import 'package:flutter/material.dart';

class Company {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String description;
  final String logo;
  final List<String> products;
  final String website;

  Company({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.description,
    required this.logo,
    required this.products,
    required this.website,
  });
}

class ConnectPage extends StatelessWidget {
  ConnectPage({Key? key}) : super(key: key);

  final List<Company> companies = [
    Company(
      name: "AgroFresh Ltd.",
      email: "contact@agrofresh.com",
      phone: "+1 (555) 123-4567",
      address: "123 Farming Valley, Agricultural District, CA 94105",
      description: "AgroFresh Ltd. is a leading provider of organic farming solutions and fresh produce distribution. With over 20 years of experience, we specialize in connecting farmers with premium markets worldwide.",
      logo: "assets/images/agrofresh_logo.png",
      products: ["Organic Vegetables", "Fresh Fruits", "Dairy Products", "Grains"],
      website: "www.agrofresh.com",
    ),
    Company(
      name: "GreenHarvest Industries",
      email: "info@greenharvest.com",
      phone: "+1 (555) 234-5678",
      address: "456 Eco Park Road, Sustainable City, NY 10001",
      description: "GreenHarvest Industries pioneers sustainable agricultural practices with cutting-edge technology. We help farmers maximize yields while minimizing environmental impact.",
      logo: "assets/images/greenharvest_logo.png",
      products: ["Sustainable Farming Equipment", "Organic Seeds", "Bio Fertilizers"],
      website: "www.greenharvest.com",
    ),
    Company(
      name: "FarmPure Foods",
      email: "support@farmpure.com",
      phone: "+1 (555) 345-6789",
      address: "789 Pure Foods Avenue, Fresh Town, TX 75001",
      description: "FarmPure Foods connects local farmers with consumers seeking farm-fresh products. We ensure quality and transparency in every step of the food supply chain.",
      logo: "assets/images/farmpure_logo.png",
      products: ["Organic Meat", "Farm Fresh Eggs", "Artisanal Cheese", "Honey"],
      website: "www.farmpure.com",
    ),
    Company(
      name: "Organic Valley Co.",
      email: "hello@organicvalley.com",
      phone: "+1 (555) 456-7890",
      address: "321 Organic Lane, Green City, WA 98101",
      description: "Organic Valley Co. is a farmer-owned cooperative dedicated to producing the highest quality organic dairy and meat products while supporting sustainable farming practices.",
      logo: "assets/images/organicvalley_logo.png",
      products: ["Organic Milk", "Grass-fed Beef", "Organic Butter", "Yogurt"],
      website: "www.organicvalley.com",
    ),
    Company(
      name: "FreshFarm Exports",
      email: "sales@freshfarm.com",
      phone: "+1 (555) 567-8901",
      address: "567 Export Hub, International Zone, FL 33101",
      description: "FreshFarm Exports specializes in connecting local farmers with international markets. We handle logistics, compliance, and distribution to ensure smooth export operations.",
      logo: "assets/images/freshfarm_logo.png",
      products: ["Export Services", "Cold Chain Solutions", "Quality Certification", "Market Analysis"],
      website: "www.freshfarm.com",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              "Connect with Leading Agricultural Companies",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: companies.length,
              itemBuilder: (context, index) {
                return CompanyCard(company: companies[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CompanyCard extends StatelessWidget {
  final Company company;

  const CompanyCard({
    Key? key,
    required this.company,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.business, size: 40, color: Colors.green.shade700),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        company.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        company.website,
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 8,
              runSpacing: 8,
              children: [
                SizedBox(
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(Icons.email, company.email),
                      const SizedBox(height: 8),
                      _buildInfoRow(Icons.phone, company.phone),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _showCompanyDetails(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(Icons.connect_without_contact),
                  label: const Text("Connect"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  void _showCompanyDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.business, size: 40, color: Colors.green.shade700),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        company.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailSection("About", company.description),
                    const SizedBox(height: 16),
                    _buildDetailSection("Contact Information", """
Email: ${company.email}
Phone: ${company.phone}
Address: ${company.address}
Website: ${company.website}
                    """),
                    const SizedBox(height: 16),
                    _buildDetailSection("Products & Services",
                        company.products.map((p) => "• $p").join("\n")),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Close"),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            // Implement email/contact functionality
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text("Send Message"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(fontSize: 14, height: 1.5),
        ),
      ],
    );
  }
}