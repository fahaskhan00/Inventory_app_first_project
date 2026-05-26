import 'package:flutter/material.dart';

import 'package:flutter_application_1/colors/app_colors.dart';

class ResetButton
    extends StatelessWidget {
  final VoidCallback onTap;

  const ResetButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,

      child: const Text(
        "Reset",

        style: TextStyle(
          color: AppColors.primary,

          fontWeight:
              FontWeight.w600,
        ),
      ),
    );
  }
}