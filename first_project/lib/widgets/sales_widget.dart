import 'package:flutter/material.dart';

Widget glassContainer({required Widget child, EdgeInsets? margin}) {
  return Container(
    margin: margin,
    padding: const EdgeInsets.all(18),

    decoration: BoxDecoration(
      color: Colors.white,

      borderRadius: BorderRadius.circular(24),

      boxShadow: [
        BoxShadow(
          color: Colors.orange.withOpacity(0.08),
          blurRadius: 15,
          offset: const Offset(0, 6),
        ),
      ],
    ),

    child: child,
  );
}

Widget buildStatCard({
  required IconData icon,
  required String title,
  required String value,
}) {
  return glassContainer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Container(
          padding: const EdgeInsets.all(10),

          decoration: BoxDecoration(
            color: const Color(0xFFFFF3E8),

            borderRadius: BorderRadius.circular(14),
          ),

          child: Icon(icon, color: const Color(0xFFFF8C42), size: 24),
        ),

        const SizedBox(height: 16),

        Text(
          title,

          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
            letterSpacing: 0.5,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          value,

          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}
