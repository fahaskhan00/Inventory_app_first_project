import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';

class AddCategoryMainButton
    extends StatelessWidget {
  final VoidCallback onTap;

  const AddCategoryMainButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,

      child: ElevatedButton.icon(
        onPressed: onTap,

        icon: const Icon(
          Icons.add,
          color: AppColors.white,
        ),

        label: const Text(
          "Add new category",

          style: TextStyle(
            color: AppColors.white,
          ),
        ),

        style: ElevatedButton.styleFrom(
          backgroundColor:
              AppColors.primary,

          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}