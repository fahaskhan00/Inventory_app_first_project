import 'package:flutter/material.dart';

class PrivacyPolicyContent extends StatelessWidget {
  const PrivacyPolicyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0D0D0D), Color(0xFF1A1A1A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle("Last updated"),
              _sectionText("May 02, 2026"),

              const SizedBox(height: 20),

              _sectionTitle("Overview"),
              _sectionText(
                "This Privacy Policy describes how we collect, use, and protect your information when using the Myinvontory application. "
                "By using the app, you agree to this policy.",
              ),

              const SizedBox(height: 20),

              _sectionTitle("Data We Collect"),
              _bulletText("Email address"),
              _bulletText("First and last name"),
              _bulletText("Usage data"),
              _bulletText("Device information"),

              const SizedBox(height: 20),

              _sectionTitle("Usage Data"),
              _sectionText(
                "We collect data such as IP address, browser type, time spent, and pages visited to improve user experience.",
              ),

              const SizedBox(height: 20),

              _sectionTitle("Permissions"),
              _sectionText(
                "We may request access to camera and photos to provide features. "
                "You can disable this anytime in device settings.",
              ),

              const SizedBox(height: 20),

              _sectionTitle("How We Use Data"),
              _bulletText("To improve the app"),
              _bulletText("To manage accounts"),
              _bulletText("To communicate updates"),
              _bulletText("To provide services"),

              const SizedBox(height: 20),

              _sectionTitle("Data Sharing"),
              _sectionText(
                "We may share data with service providers or legal authorities when required.",
              ),

              const SizedBox(height: 20),

              _sectionTitle("Data Retention"),
              _sectionText(
                "We retain your data only as long as necessary, typically up to 24 months depending on usage.",
              ),

              const SizedBox(height: 20),

              _sectionTitle("Security"),
              _sectionText(
                "We take reasonable steps to protect your data but cannot guarantee 100% security.",
              ),

              const SizedBox(height: 20),

              _sectionTitle("Children's Privacy"),
              _sectionText(
                "Our service is not intended for users under 16 years of age.",
              ),

              const SizedBox(height: 20),

              _sectionTitle("Changes"),
              _sectionText(
                "We may update this policy anytime. Continued use means acceptance.",
              ),

              const SizedBox(height: 20),

              _sectionTitle("Contact"),
              _sectionText("fahaskhan2004a@gmail.com"),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _sectionText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 14,
          height: 1.6,
        ),
      ),
    );
  }

  Widget _bulletText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(color: Colors.white70)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
