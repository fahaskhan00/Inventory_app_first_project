import 'package:flutter/material.dart';

import 'package:flutter_application_1/colors/app_colors.dart';

class UpdateItemButton
    extends StatelessWidget {
  final VoidCallback onTap;

  const UpdateItemButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              AppColors.primary,

          padding:
              const EdgeInsets.symmetric(
            vertical: 15,
          ),

          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
              16,
            ),
          ),
        ),

        onPressed: onTap,

        child: const Text(
          "Save",

          style: TextStyle(
            color: AppColors.white,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),
    );
  }
}