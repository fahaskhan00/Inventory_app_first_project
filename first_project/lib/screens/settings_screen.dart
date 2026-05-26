import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/privacy_policy.dart';
import 'package:flutter_application_1/screens/terms_condition.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      appBar: AppBar(
        backgroundColor: Colors.transparent,

        elevation: 0,

        centerTitle: true,

        iconTheme: const IconThemeData(color: Colors.black),

        title: const Text(
          'Settings',

          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            /// TERMS
            settingTile(
              title: "Terms & Conditions",

              icon: Icons.description_rounded,

              onTap: () {
                Navigator.push(
                  context,

                  MaterialPageRoute(builder: (_) => TermsScreen()),
                );
              },
            ),

            const SizedBox(height: 14),

            /// PRIVACY
            settingTile(
              title: "Privacy Policy",

              icon: Icons.privacy_tip_rounded,

              onTap: () {
                Navigator.push(
                  context,

                  MaterialPageRoute(builder: (_) => PrivacyPolicyScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget settingTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(22),

          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.08),

              blurRadius: 14,

              offset: const Offset(0, 6),
            ),
          ],
        ),

        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),

              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E8),

                borderRadius: BorderRadius.circular(14),
              ),

              child: Icon(icon, color: const Color(0xFFFF8C42)),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Text(
                title,

                style: const TextStyle(
                  color: Colors.black,

                  fontWeight: FontWeight.w600,

                  fontSize: 15,
                ),
              ),
            ),

            Icon(
              Icons.arrow_forward_ios_rounded,

              color: Colors.grey.shade500,

              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
