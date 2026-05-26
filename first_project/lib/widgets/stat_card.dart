import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String value;
  final String title;
  final IconData icon;
  final Color color;

  const StatCard({
    super.key,
    required this.value,
    required this.title,
    required this.icon,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(title, style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
