import 'package:flutter/material.dart';

class CategoryHeader extends StatelessWidget {
  const CategoryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(18),

          decoration: const BoxDecoration(
            color: Color(0xFFFFF3E8),
            shape: BoxShape.circle,
          ),

          child: const Icon(
            Icons.category_rounded,
            size: 36,
            color: Color(0xFFFF8C42),
          ),
        ),

        const SizedBox(height: 16),

        const Text(
          "Create New Category",

          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}