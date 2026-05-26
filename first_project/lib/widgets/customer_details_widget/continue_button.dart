import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';

class ContinueButton
    extends StatelessWidget {
  final VoidCallback onTap;

  const ContinueButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 58,

      child: ElevatedButton(
        style:
            ElevatedButton.styleFrom(
          backgroundColor:
              AppColors.primary,

          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
              18,
            ),
          ),
        ),

        onPressed: onTap,

        child: const Text(
          "Continue",

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