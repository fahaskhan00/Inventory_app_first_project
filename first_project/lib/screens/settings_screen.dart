//==================== settings_screen.dart ====================//

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/privacy_policy.dart';
import 'package:flutter_application_1/screens/terms_condition.dart';
import 'package:flutter_application_1/services/settings_services.dart';

import 'package:flutter_application_1/widgets/settings_widget/settings_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
            //==================== TERMS & CONDITIONS ====================//
            SettingsTile(
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

            //==================== PRIVACY POLICY ====================//
            SettingsTile(
              title: "Privacy Policy",

              icon: Icons.privacy_tip_rounded,

              onTap: () {
                Navigator.push(
                  context,

                  MaterialPageRoute(builder: (_) => PrivacyPolicyScreen()),
                );
              },
            ),

            const SizedBox(height: 14),

            //==================== CLEAR ALL DATA ====================//
            SettingsTile(
              title: "Clear All Data",

              icon: Icons.delete_forever_rounded,

              iconColor: Colors.red,

              onTap: () {
                SettingsService.showClearDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
