import 'package:flutter/material.dart';

import 'package:flutter_application_1/colors/app_colors.dart';

class ApplyFilterButton
    extends StatelessWidget {
  final VoidCallback onTap;

  const ApplyFilterButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,

      style: ElevatedButton.styleFrom(
        backgroundColor:
            AppColors.primary,

        padding:
            const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 14,
        ),

        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20),
        ),
      ),

      child: const Text(
        "Apply Filters",

        style: TextStyle(
          color: AppColors.white,

          fontWeight:
              FontWeight.bold,
        ),
      ),
    );
  }
}