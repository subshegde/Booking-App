import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({Key? key}) : super(key: key);

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: const Text('Help Center', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to the Help Center',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Here you can find answers to common questions, contact support, and review our policies.',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 20),

            // FAQs Section
            const Text(
              'FAQs',
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(color: Colors.grey),
            _buildFAQItem('How do I book a place?', 'Select a location, choose the date, and confirm your booking.'),
            _buildFAQItem('How can I make a payment?', 'We support Razorpay for secure payments.'),
            _buildFAQItem('Can I cancel my booking?', 'Yes, you can cancel your booking before making the payment through "My Bookings".'),
            _buildFAQItem('How do I book a vehicle or restaurant?', 'Choose your preferred vehicle or restaurant, select the date, and confirm your booking.'),
            _buildFAQItem('How do I view my bookings?', 'Go to "My Bookings" in the app to view all your current and past bookings.'),
            _buildFAQItem('What should I do if I face an issue with payment?', 'If you face any issues, contact our support team via the "Contact Support" option.'),
            _buildFAQItem('Can I modify my booking after confirming it?', 'Bookings cannot be modified after confirmation. Please cancel and rebook if needed.'),
            _buildFAQItem('Is my personal information secure?', 'Yes, we use secure encryption protocols to protect your personal data.'),
            const SizedBox(height: 20),

            // Contact Support Button
            _buildActionButton('Contact Support', Icons.support_agent, Colors.black, Colors.white, () {
              _launchURL('mailto:support@yourapp.com'); // Example email
            }),

            const SizedBox(height: 20),

            // Placeholder for Missing Legal Info
            const Text(
              'Terms & Conditions & Privacy Policy will be available soon.',
              style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            answer,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color backgroundColor, Color textColor, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
