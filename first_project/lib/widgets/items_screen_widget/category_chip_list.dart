import 'package:flutter/material.dart';

import 'package:flutter_application_1/services/database_hive.dart';

import 'category_chip.dart';

class CategoryChipList
    extends StatelessWidget {
  final DatabaseApp db;

  final int selectedIndex;

  final Function(int) onTap;

  const CategoryChipList({
    super.key,
    required this.db,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,

      child: ValueListenableBuilder(
        valueListenable:
            db.categoryListenable(),

        builder: (
          context,
          box,
          _,
        ) {
          final categories = [
            "All",
            ...db.getCategories(),
          ];

          return ListView.builder(
            scrollDirection:
                Axis.horizontal,

            itemCount:
                categories.length,

            itemBuilder: (
              context,
              index,
            ) {
              final isSelected =
                  selectedIndex ==
                  index;

              return CategoryChip(
                isSelected:
                    isSelected,

                title:
                    categories[index],

                onTap: () {
                  onTap(index);
                },
              );
            },
          );
        },
      ),
    );
  }
}