import 'package:flutter/material.dart';

import 'package:flutter_application_1/colors/app_colors.dart';
import 'package:flutter_application_1/models/item_model.dart';

class SalesBottomButton
    extends StatelessWidget {
  final List<ItemModel> selectedItems;

  final double totalPrice;

  final VoidCallback onTap;

  const SalesBottomButton({
    super.key,
    required this.selectedItems,
    required this.totalPrice,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.fromLTRB(
        16,
        8,
        16,
        30,
      ),

      child: GestureDetector(
        onTap: onTap,

        child: Container(
          padding:
              const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 20,
          ),

          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                AppColors.secondary,
                AppColors.primary,
              ],
            ),

            borderRadius:
                BorderRadius.circular(50),

            boxShadow: [
              BoxShadow(
                color: AppColors.primary
                    .withOpacity(0.18),

                blurRadius: 14,

                offset: const Offset(0, 6),
              ),
            ],
          ),

          child: Row(
            mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,

            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor:
                        AppColors.white,

                    child: Text(
                      selectedItems.length
                          .toString(),

                      style:
                          const TextStyle(
                        color:
                            AppColors.primary,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  const Text(
                    "Go To Sales Summary",

                    style: TextStyle(
                      color: AppColors.white,

                      fontWeight:
                          FontWeight.bold,

                      fontSize: 15,
                    ),
                  ),
                ],
              ),

              Text(
                "₹ ${totalPrice.toStringAsFixed(0)}",

                style: const TextStyle(
                  color: AppColors.white,

                  fontWeight:
                      FontWeight.bold,

                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}