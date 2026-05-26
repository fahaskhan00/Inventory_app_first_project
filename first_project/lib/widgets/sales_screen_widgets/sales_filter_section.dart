import 'package:flutter/material.dart';

import '../../colors/app_colors.dart';

class SalesFilterSection
    extends StatelessWidget {
  final String selectedFilter;

  final Function(String)
  onSelected;

  const SalesFilterSection({
    super.key,
    required this.selectedFilter,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final filters = [
      "Today",
      "Weekly",
      "Monthly",
    ];

    return SizedBox(
      height: 42,

      child: ListView.builder(
        scrollDirection:
            Axis.horizontal,

        itemCount:
            filters.length,

        itemBuilder: (
          context,
          index,
        ) {
          final filter =
              filters[index];

          final isSelected =
              selectedFilter ==
              filter;

          return GestureDetector(
            onTap: () {
              onSelected(
                filter,
              );
            },

            child: Container(
              margin:
                  const EdgeInsets.only(
                right: 12,
              ),

              padding:
                  const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 10,
              ),

              decoration: BoxDecoration(
                color:
                    isSelected
                        ? AppColors.primary
                        : Colors.white,

                borderRadius:
                    BorderRadius.circular(
                  14,
                ),
              ),

              child: Text(
                filter,

                style: TextStyle(
                  color:
                      isSelected
                          ? Colors.white
                          : Colors.black,

                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}