import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Terms & Conditions',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionCard(
                title: 'Welcome to Farm Resources App',
                content: 'By accessing and using this application, you accept and agree to be bound by the terms and provisions of this agreement.',
                icon: Icons.handshake_outlined,
              ),
              _buildExpandableSection(
                title: '1. User Agreement',
                content: '''• You must be 18 years or older to use this service
• You are responsible for maintaining the confidentiality of your account
• You agree to provide accurate and complete information
• You agree not to use the service for any illegal purposes''',
                icon: Icons.gavel_outlined,
              ),
              _buildExpandableSection(
                title: '2. Service Usage',
                content: '''• The service is provided "as is" without warranties
• We reserve the right to modify or discontinue the service
• Users must follow community guidelines
• Misuse of the service may result in account termination''',
                icon: Icons.construction_outlined,
              ),
              _buildExpandableSection(
                title: '3. Booking & Payments',
                content: '''• All bookings are subject to availability
• Payment must be made in advance
• Cancellation policies apply
• Refunds are processed according to our policy''',
                icon: Icons.payment_outlined,
              ),
              _buildExpandableSection(
                title: '4. Equipment Usage',
                content: '''• Users are responsible for proper equipment handling
• Any damage must be reported immediately
• Safety guidelines must be followed
• Equipment must be returned in original condition''',
                icon: Icons.agriculture_outlined,
              ),
              _buildExpandableSection(
                title: '5. Privacy Policy',
                content: '''• We collect and process personal data
• Your data is protected under privacy laws
• We do not share data with third parties
• You can request your data deletion''',
                icon: Icons.privacy_tip_outlined,
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('I Understand'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.green, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              content,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}