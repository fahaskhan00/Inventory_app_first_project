import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_application_1/colors/app_colors.dart';
import 'package:flutter_application_1/models/item_model.dart';

class SalesItemTile
    extends StatelessWidget {
  final ItemModel item;

  final bool isSelected;

  final VoidCallback onTap;

  const SalesItemTile({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        margin:
            const EdgeInsets.only(bottom: 16),

        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: AppColors.white,

          borderRadius:
              BorderRadius.circular(22),

          border: Border.all(
            color:
                isSelected
                    ? AppColors.primary
                    : Colors.transparent,

            width: 1.5,
          ),

          boxShadow: [
            BoxShadow(
              color: AppColors.primary
                  .withOpacity(0.08),

              blurRadius: 14,

              offset: const Offset(0, 6),
            ),
          ],
        ),

        child: Row(
          children: [
            buildImage(),

            const SizedBox(width: 14),

            buildItemDetails(),

            buildSelectButton(),
          ],
        ),
      ),
    );
  }

  Widget buildImage() {
    return Container(
      width: 70,
      height: 70,

      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(16),

        color: AppColors.lightOrange,

        image:
            item.images.isNotEmpty
                ? DecorationImage(
                  image: FileImage(
                    File(item.images[0]),
                  ),

                  fit: BoxFit.cover,
                )
                : null,
      ),
    );
  }

  Widget buildItemDetails() {
    return Expanded(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Text(
            item.name,

            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.black,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            "QTY: ${item.quantity}",

            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "₹ ${item.price}",

            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSelectButton() {
    return Container(
      width: 40,
      height: 40,

      decoration: BoxDecoration(
        gradient:
            isSelected
                ? const LinearGradient(
                  colors: [
                    AppColors.secondary,
                    AppColors.primary,
                  ],
                )
                : null,

        color:
            isSelected
                ? null
                : AppColors.lightOrange,

        borderRadius:
            BorderRadius.circular(14),
      ),

      child: Icon(
        isSelected
            ? Icons.check
            : Icons.add,

        color:
            isSelected
                ? AppColors.white
                : AppColors.primary,
      ),
    );
  }
}