import 'package:flutter/material.dart';

import 'package:flutter_application_1/colors/app_colors.dart';

class CategoryChip
    extends StatelessWidget {
  final bool isSelected;

  final String title;

  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.isSelected,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(
        right: 10,
      ),

      child: AnimatedContainer(
        duration:
            const Duration(
              milliseconds: 250,
            ),

        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppColors.primary
                  : AppColors.card,

          borderRadius:
              BorderRadius.circular(
            14,
          ),

          border: Border.all(
            color:
                isSelected
                    ? AppColors.primary
                    : Colors.grey
                        .withOpacity(
                          0.1,
                        ),
          ),
        ),

        child: InkWell(
          borderRadius:
              BorderRadius.circular(
            14,
          ),

          onTap: onTap,

          child: Padding(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 12,
            ),

            child: Text(
              title,

              style: TextStyle(
                color:
                    isSelected
                        ? Colors.white
                        : AppColors.text,

                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}