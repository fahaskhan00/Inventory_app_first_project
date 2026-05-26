import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';

class CategoriesSearchField
    extends StatelessWidget {
  final TextEditingController controller;

  final Function(String) onChanged;

  const CategoriesSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius:
            BorderRadius.circular(22),

        border: Border.all(
          color: AppColors.primary
              .withOpacity(0.08),
        ),

        boxShadow: [
          BoxShadow(
            color: AppColors.primary
                .withOpacity(0.05),

            blurRadius: 10,

            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: TextField(
        controller: controller,

        onChanged: onChanged,

        decoration: const InputDecoration(
          hintText: "Search categories...",

          hintStyle: TextStyle(
            color: Colors.grey,
          ),

          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
          ),

          border: InputBorder.none,
        ),
      ),
    );
  }
}