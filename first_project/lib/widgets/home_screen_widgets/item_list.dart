import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';
import 'package:flutter_application_1/services/database_hive.dart';


class DashboardItemList
    extends StatelessWidget {
  final DatabaseApp db;

  final Function(
    dynamic item,
    int originalIndex,
  )
  onTap;

  final Function(int originalIndex)
  onLongPress;

  const DashboardItemList({
    super.key,
    required this.db,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final items =
        db.getItems().reversed.toList();

    return ListView.builder(
      itemCount: items.length,

      itemBuilder: (
        context,
        index,
      ) {
        final item = items[index];

        final originalIndex = db
            .getItems()
            .indexWhere(
              (e) =>
                  e.name ==
                      item.name &&
                  e.price ==
                      item.price &&
                  e.quantity ==
                      item.quantity,
            );

        final imagePath =
            item.images.isNotEmpty
                ? item.images[0]
                : "";

        return itemTile(
          item: item,

          imagePath: imagePath,

          onTap: () {
            onTap(
              item,
              originalIndex,
            );
          },

          onLongPress: () {
            onLongPress(
              originalIndex,
            );
          },
        );
      },
    );
  }
}

Widget itemTile({
  required dynamic item,
  required String imagePath,
  required VoidCallback onTap,
  required VoidCallback onLongPress,
}) {
  return GestureDetector(
    onTap: onTap,
    onLongPress: onLongPress,

    child: Container(
      margin: const EdgeInsets.only(bottom: 15),

      padding: const EdgeInsets.all(8),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(12),

        border: Border.all(color: Colors.grey.shade100),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: Offset(5, 8),
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          /// IMAGE
          Container(
            width: 58,
            height: 58,

            decoration: BoxDecoration(
              color: Colors.grey.shade100,

              borderRadius: BorderRadius.circular(14),

              border: Border.all(color: Colors.grey.shade200),
            ),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),

              child:
                  imagePath.isNotEmpty
                      ? Image.file(File(imagePath), fit: BoxFit.cover)
                      : Container(
                        alignment: Alignment.center,

                        child: const Icon(
                          Icons.inventory_2_outlined,
                          color: AppColors.subtitle,
                          size: 24,
                        ),
                      ),
            ),
          ),

          const SizedBox(width: 15),

          /// CENTER DETAILS
          Expanded(
            child: SizedBox(
              height: 62,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  /// NAME
                  Text(
                    item.name,

                    maxLines: 1,

                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text,
                    ),
                  ),

                  /// CATEGORY
                  Row(
                    children: [
                      Icon(
                        Icons.category_outlined,
                        size: 13,
                        color: Colors.grey.shade500,
                      ),

                      const SizedBox(width: 5),

                      Expanded(
                        child: Text(
                          item.category,

                          maxLines: 1,

                          overflow: TextOverflow.ellipsis,

                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),

                  /// STOCK
                  Row(
                    children: [
                      Container(
                        width: 7,
                        height: 7,

                        decoration: BoxDecoration(
                          color:
                              item.quantity == 0
                                  ? AppColors.danger
                                  : item.quantity < 5
                                  ? Colors.orange
                                  : AppColors.success,

                          shape: BoxShape.circle,
                        ),
                      ),

                      const SizedBox(width: 6),

                      Expanded(
                        child: Text(
                          item.quantity == 0
                              ? "Out Of Stock - ${item.quantity} stocks"
                              : item.quantity < 5
                              ? "Low Stock - ${item.quantity} Left"
                              : "${item.quantity} Units Available",

                          maxLines: 1,

                          overflow: TextOverflow.ellipsis,

                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,

                            color:
                                item.quantity == 0
                                    ? AppColors.danger
                                    : item.quantity < 5
                                    ? Colors.orange
                                    : AppColors.success,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 10),

          /// RIGHT SIDE
          SizedBox(
            height: 65,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,

              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                /// PRICE
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Text(
                    "₹${item.price}",

                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                  ),
                ),

                /// STATUS
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 9,
                  ),

                  decoration: BoxDecoration(
                    color:
                        item.quantity > 1
                            ? AppColors.success.withOpacity(0.10)
                            : const Color.fromARGB(
                              255,
                              227,
                              6,
                              6,
                            ).withOpacity(0.10),

                    borderRadius: BorderRadius.circular(30),
                  ),

                  child: Text(
                    item.quantity > 1 ? "Available" : "Out Stock",

                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,

                      color:
                          item.quantity > 1
                              ? AppColors.success
                              : AppColors.danger,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}