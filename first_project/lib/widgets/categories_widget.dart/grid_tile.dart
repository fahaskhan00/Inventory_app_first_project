import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';

class CategoryGridTile
    extends StatelessWidget {
  final String categoryName;

  final VoidCallback onEdit;

  final VoidCallback onDelete;

  const CategoryGridTile({
    super.key,
    required this.categoryName,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onDelete,

      child: Container(
        padding: const EdgeInsets.all(12),

        decoration: BoxDecoration(
          color: AppColors.white,

          borderRadius:
              BorderRadius.circular(26),

          border: Border.all(
            color: AppColors.primary
                .withOpacity(0.08),
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.04),

              blurRadius: 10,

              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch,

          children: [
            buildEditButton(),

            buildCategoryDetails(),
          ],
        ),
      ),
    );
  }

  // EDIT BUTTON
  Widget buildEditButton() {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.end,

      children: [
        GestureDetector(
          onTap: onEdit,

          child: Container(
            padding:
                const EdgeInsets.all(6),

            decoration: BoxDecoration(
              color: AppColors.primary
                  .withOpacity(0.1),

              shape: BoxShape.circle,
            ),

            child: const Icon(
              Icons.edit,
              size: 18,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }

  // CATEGORY DETAILS
  Widget buildCategoryDetails() {
    return Expanded(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [
          const Icon(
            Icons.category,

            size: 42,

            color: AppColors.primary,
          ),

          const SizedBox(height: 10),

          Text(
            categoryName,

            style: const TextStyle(
              fontWeight:
                  FontWeight.bold,

              color: AppColors.text,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            "Items",

            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}