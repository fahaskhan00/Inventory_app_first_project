import 'package:flutter/material.dart';

class SalesDateHeader extends StatelessWidget {
  final String date;

  const SalesDateHeader({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),

      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),

      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E8),

        borderRadius: BorderRadius.circular(14),
      ),

      child: Text(
        date,

        style: const TextStyle(
          color: Color(0xFFFF8C42),
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }
}
