import 'package:flutter/material.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Help & Support',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Support Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.support_agent,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'How can we help you?',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '24/7 Support Available',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Quick Contact Buttons
              Row(
                children: [
                  Expanded(
                    child: _buildQuickContactButton(
                      icon: Icons.phone,
                      label: 'Call Us',
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildQuickContactButton(
                      icon: Icons.chat,
                      label: 'Live Chat',
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // FAQ Section
              const Text(
                'Frequently Asked Questions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _buildFAQCard(
                question: 'How do I book equipment?',
                answer: 'You can book equipment through our app by selecting the desired item, choosing your preferred time slot, and completing the payment process.',
              ),
              _buildFAQCard(
                question: 'What is the cancellation policy?',
                answer: 'You can cancel your booking up to 24 hours before the scheduled time for a full refund. Late cancellations may be subject to charges.',
              ),
              _buildFAQCard(
                question: 'How do I report equipment issues?',
                answer: 'If you encounter any issues with the equipment, please use the "Report Issue" feature in the app or contact our support team immediately.',
              ),
              _buildFAQCard(
                question: 'What payment methods are accepted?',
                answer: 'We accept all major credit/debit cards, UPI, and net banking. Payment must be made at the time of booking.',
              ),
              
              const SizedBox(height: 20),

              // Contact Form
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Send us a message',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Subject',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        maxLines: 4,
                        decoration: const InputDecoration(
                          labelText: 'Message',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {},
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
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.send),
                            SizedBox(width: 8),
                            Text('Send Message'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickContactButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Colors.green),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }

  Widget _buildFAQCard({
    required String question,
    required String answer,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              answer,
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