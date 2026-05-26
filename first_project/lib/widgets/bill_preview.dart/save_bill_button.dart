import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';

class SaveBillButton
    extends StatelessWidget {
  final VoidCallback onTap;

  const SaveBillButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding:
              const EdgeInsets.symmetric(
            vertical: 18,
          ),

          backgroundColor:
              AppColors.primary,

          elevation: 0,

          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(18),
          ),
        ),

        onPressed: onTap,

        child: const Text(
          "Save Bill",

          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}