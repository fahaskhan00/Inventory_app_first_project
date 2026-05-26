import 'package:flutter/material.dart';

import 'package:flutter_application_1/colors/app_colors.dart';

class EditCategoryDropdown
    extends StatelessWidget {
  final String category;

  final List categories;

  final Function(String?)
  onChanged;

  const EditCategoryDropdown({
    super.key,
    required this.category,
    required this.categories,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 14,
      ),

      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(20),

        color: AppColors.white,

        boxShadow: [
          BoxShadow(
            color: AppColors.primary
                .withOpacity(0.08),

            blurRadius: 14,

            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: DropdownButtonHideUnderline(
       child: DropdownButton<String>(
  dropdownColor: AppColors.white,

  value:
      categories.contains(category)
          ? category.toString()
          : null,

  isExpanded: true,

  hint: Text(
    "Select Category",

    style: TextStyle(
      color: Colors.grey.shade500,
    ),
  ),

  style: const TextStyle(
    color: AppColors.black,
  ),

  items:
      categories
          .map<DropdownMenuItem<String>>(
            (e) {
              return DropdownMenuItem<String>(
                value: e.toString(),

                child: Text(
                  e.toString(),
                ),
              );
            },
          )
          .toList(),

  onChanged: onChanged,
),
      ),
    );
  }
}