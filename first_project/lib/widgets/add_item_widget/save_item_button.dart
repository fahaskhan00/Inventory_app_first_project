import 'package:flutter/material.dart';

import 'package:flutter_application_1/colors/app_colors.dart';

class SaveItemButton extends StatelessWidget {
  final VoidCallback onTap;

  const SaveItemButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 58,

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,

          backgroundColor:
              AppColors.primary,

          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(18),
          ),
        ),

        onPressed: onTap,

        child: const Text(
          "Save Item",

          style: TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}