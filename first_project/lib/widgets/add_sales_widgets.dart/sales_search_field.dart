import 'package:flutter/material.dart';

import 'package:flutter_application_1/colors/app_colors.dart';

class SalesSearchField
    extends StatelessWidget {
  final TextEditingController controller;

  final Function(String) onChanged;

  const SalesSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),

      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,

          borderRadius:
              BorderRadius.circular(18),

          boxShadow: [
            BoxShadow(
              color: AppColors.primary
                  .withOpacity(0.08),

              blurRadius: 14,

              offset: const Offset(0, 6),
            ),
          ],
        ),

        child: TextField(
          controller: controller,

          onChanged: onChanged,

          style: const TextStyle(
            color: AppColors.black,
          ),

          decoration: InputDecoration(
            hintText: "Search items...",

            hintStyle: TextStyle(
              color: Colors.grey.shade500,
            ),

            prefixIcon: const Icon(
              Icons.search,
              color: AppColors.primary,
            ),

            border: InputBorder.none,

            contentPadding:
                const EdgeInsets.all(16),
          ),
        ),
      ),
    );
  }
}