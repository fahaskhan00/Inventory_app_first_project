import 'package:flutter/material.dart';

class TermsContent extends StatelessWidget {
  const TermsContent({super.key});

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
              _title("Last updated"),
              _text("May 02, 2026"),

              const SizedBox(height: 20),

              _title("Overview"),
              _text(
                "These Terms and Conditions govern your use of the myinventory application. "
                "By using the app, you agree to comply with these terms.",
              ),

              const SizedBox(height: 20),

              _title("Definitions"),
              _bullet("Application: myinventory app"),
              _bullet("Company: myinventory"),
              _bullet("Country: Kerala, India"),
              _bullet("Service: The application features"),

              const SizedBox(height: 20),

              _title("Acceptance"),
              _text(
                "By accessing or using the Service, you agree to be bound by these Terms. "
                "If you disagree, you may not use the Service.",
              ),

              const SizedBox(height: 20),

              _title("Age Requirement"),
              _text("You must be at least 18 years old to use this Service."),

              const SizedBox(height: 20),

              _title("External Links"),
              _text(
                "We are not responsible for third-party websites or services linked in the app.",
              ),

              const SizedBox(height: 20),

              _title("Third-Party Services"),
              _text(
                "Any third-party content or services are not controlled by us and are used at your own risk.",
              ),

              const SizedBox(height: 20),

              _title("Termination"),
              _text(
                "We may suspend or terminate access to the Service if you violate these terms.",
              ),

              const SizedBox(height: 20),

              _title("Limitation of Liability"),
              _text(
                "We are not liable for indirect or incidental damages including data loss or business interruption.",
              ),

              const SizedBox(height: 20),

              _title("Disclaimer"),
              _text(
                "The Service is provided 'AS IS' without any warranties of any kind.",
              ),

              const SizedBox(height: 20),

              _title("Governing Law"),
              _text("These Terms are governed by the laws of Kerala, India."),

              const SizedBox(height: 20),

              _title("Disputes"),
              _text(
                "Disputes should first be resolved informally by contacting us.",
              ),

              const SizedBox(height: 20),

              _title("Changes"),
              _text(
                "We may update these Terms at any time. Continued use means acceptance.",
              ),

              const SizedBox(height: 20),

              _title("Contact"),
              _text("fahaskhan2004a@gmail.com"),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _text(String text) {
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

  Widget _bullet(String text) {
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
