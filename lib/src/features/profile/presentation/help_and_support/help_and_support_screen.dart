import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@yourapp.com',
      query: Uri.encodeFull('subject=Help & Support Request'),
    );

    await _launchUri(emailUri);
  }

  Future<void> _launchPhone() async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: '+1234567890',
    );

    await _launchUri(phoneUri);
  }

  Future<void> _launchUri(Uri uri) async {
    try {
      final bool launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched) {
        throw 'Could not launch $uri';
      }
    } catch (e) {
      debugPrint('Error launching $uri: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    final Color accent = Colors.deepPurpleAccent;
    final Color textColor = Colors.white.withOpacity(0.9);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Help & Support",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              "Need Assistance?",
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "We’re here to help you with any issue or question you may have. You can reach us anytime through the options below or explore our FAQs.",
              style: TextStyle(color: textColor, fontSize: 15, height: 1.4),
            ),
            const SizedBox(height: 24),

            // Contact Options
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildContactCard(
                  icon: LucideIcons.mail,
                  label: "Email Us",
                  color: AppColors.primary,
                  onTap: _launchEmail,
                ),
                _buildContactCard(
                  icon: LucideIcons.phone,
                  label: "Call Us",
                  color: AppColors.primary,
                  onTap: _launchPhone,
                ),
              ],
            ),

            const SizedBox(height: 32),

            // FAQ Section
            Text(
              "Frequently Asked Questions",
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            _buildFAQItem(
              question: "How can I update the app to the latest version?",
              answer:
              "Visit the App Store or Google Play, search for the app, and tap Update if a newer version is available.",
            ),
            _buildFAQItem(
              question: "How can I contact support?",
              answer:
              "You can reach us anytime via email or by calling our support line. We’ll get back to you as soon as possible.",
            ),
            _buildFAQItem(
              question: "Why am I logged out automatically?",
              answer:
              "For your security, the app automatically logs out after extended inactivity. You can sign in again anytime.",
            ),
            _buildFAQItem(
              question: "How do I update my profile information?",
              answer:
              "Go to Profile > Edit Profile, make your changes, and tap Save. Your updated information will be visible immediately.",
            ),
            _buildFAQItem(
              question: "Is my personal data secure?",
              answer:
              "Yes. We follow strict privacy and encryption standards to ensure your data remains protected and confidential.",
            ),

            const SizedBox(height: 40),

            // Footer
            Center(
              child: Text(
                "© 2025 Parthtrada. All rights reserved.",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 130,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.35),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem({
    required String question,
    required String answer,
  }) {
    return Theme(
      data: ThemeData.dark().copyWith(dividerColor: Colors.transparent),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ExpansionTile(
          collapsedIconColor: Colors.white70,
          iconColor: AppColors.primary,
          title: Text(
            question,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          childrenPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            Text(
              answer,
              style: TextStyle(
                color: Colors.white70,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
