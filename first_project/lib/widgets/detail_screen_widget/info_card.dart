import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';

class ProductInfoCard
    extends StatelessWidget {
  final String itemName;

  final String category;

  const ProductInfoCard({
    super.key,
    required this.itemName,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(
        20,
      ),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius:
            BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: AppColors.primary
                .withOpacity(0.08),

            blurRadius: 14,

            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          buildItemName(),

          const SizedBox(height: 10),

          buildCategoryTag(),
        ],
      ),
    );
  }

  // ITEM NAME
  Widget buildItemName() {
    return Text(
      itemName,

      style: const TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
    );
  }

  // CATEGORY TAG
  Widget buildCategoryTag() {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),

      decoration: BoxDecoration(
        color: AppColors.lightOrange,

        borderRadius:
            BorderRadius.circular(30),
      ),

      child: Text(
        category,

        style: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}