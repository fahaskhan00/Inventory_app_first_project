import 'package:flutter/material.dart';

class DashboardStatCard extends StatelessWidget {
  final String title;

  final String value;

  final IconData icon;

  final Color color;

  final VoidCallback onTap;

  const DashboardStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 244, 232, 232),

          borderRadius: BorderRadius.circular(22),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),

              blurRadius: 10,

              offset: const Offset(0, 3),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.12),

              child: Icon(icon, color: color),
            ),

            const SizedBox(height: 14),

            Text(
              value,

              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 4),

            Text(
              title,

              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
