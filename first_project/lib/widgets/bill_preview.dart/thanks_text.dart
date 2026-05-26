import 'package:flutter/material.dart';

class ThankYouText
    extends StatelessWidget {
  const ThankYouText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Thank you for your business!",

      style: TextStyle(
        color: Colors.grey.shade600,
        fontSize: 14,
      ),
    );
  }
}