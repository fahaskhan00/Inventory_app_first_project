import 'package:flutter/material.dart';

import 'package:flutter_application_1/colors/app_colors.dart';
import 'package:flutter_application_1/services/database_hive.dart';

import '../../screens/add_categories.dart';

class CategoryDropdown extends StatelessWidget {
  final String selectedCategory;

  final Function(String) onChanged;

  const CategoryDropdown({
    super.key,
    required this.selectedCategory,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final db = DatabaseApp.instance;

    final categories = db.getCategories();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius:
            BorderRadius.circular(22),

        border: Border.all(
          color: Colors.grey.shade200,
        ),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(0.03),

            blurRadius: 8,

            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: DropdownButton<String>(
        value:
            categories.isNotEmpty
                ? (categories.contains(
                      selectedCategory,
                    )
                    ? selectedCategory
                    : categories.first)
                : null,

        isExpanded: true,

        underline: const SizedBox(),

        dropdownColor: AppColors.white,

        style: const TextStyle(
          color: AppColors.text,
          fontWeight: FontWeight.w500,
        ),

        items: [
          ...categories.toSet().map(
            (e) => DropdownMenuItem<String>(
              value: e,

              child: Text(
                e,

                style: const TextStyle(
                  color: AppColors.text,
                ),
              ),
            ),
          ),

          const DropdownMenuItem<String>(
            value: "add_new",

            child: Text(
              "➕ Add Category",
            ),
          ),
        ],

        onChanged: (value) async {
          if (value == "add_new") {
            final newCategory =
                await Navigator.push(
              context,

              MaterialPageRoute(
                builder:
                    (context) =>
                        const AddCategoryScreen(),
              ),
            );

            if (newCategory != null) {
              db.addCategory(newCategory);

              onChanged(newCategory);
            }

            return;
          }

          onChanged(value!);
        },
      ),
    );
  }
}