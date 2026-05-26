import 'package:flutter/material.dart';

import 'package:flutter_application_1/services/database_hive.dart';

import 'empty_item_container.dart';
import 'item_list_builder.dart';

class ItemListSection
    extends StatelessWidget {
  final DatabaseApp db;

  final int selectedIndex;

  final String? filterCategory;

  final int filterSort;

  final int filterStock;

  final String searchQuery;

  final Function(
    dynamic item,
    int originalIndex,
  )
  onTap;

  final Function(int originalIndex)
  onLongPress;

  const ItemListSection({
    super.key,
    required this.db,
    required this.selectedIndex,
    required this.filterCategory,
    required this.filterSort,
    required this.filterStock,
    required this.searchQuery,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable:
          db.itemListenable(),

      builder: (
        context,
        box,
        _,
      ) {
        final allItems =
            db.getItems();

        final categories = [
          "All",
          ...db.getCategories(),
        ];

        final selectedCategory =
            categories[selectedIndex];

        List items = allItems;

        // CATEGORY FILTER
        if (filterCategory != null) {
          items =
              items
                  .where(
                    (
                      item,
                    ) =>
                        item.category ==
                        filterCategory,
                  )
                  .toList();
        } else {
          if (selectedCategory !=
              "All") {
            items =
                items
                    .where(
                      (
                        item,
                      ) =>
                          item.category ==
                          selectedCategory,
                    )
                    .toList();
          }
        }

        // STOCK FILTER
        if (filterStock == 2) {
          items =
              items
                  .where(
                    (
                      item,
                    ) =>
                        item.quantity <
                        2,
                  )
                  .toList();
        }

        if (filterStock == 1) {
          items =
              items
                  .where(
                    (
                      item,
                    ) =>
                        item.quantity >
                        0,
                  )
                  .toList();
        }

        // REVERSE
        items =
            items.reversed.toList();

        // SORT
        if (filterSort == 1) {
          items.sort(
            (
              a,
              b,
            ) => b.quantity.compareTo(
              a.quantity,
            ),
          );
        }

        if (filterSort == 2) {
          items.sort(
            (
              a,
              b,
            ) => a.name.compareTo(
              b.name,
            ),
          );
        }

        // SEARCH
        items =
            items.where((item) {
              return item.name
                  .toLowerCase()
                  .contains(
                    searchQuery,
                  );
            }).toList();

        // EMPTY
        if (items.isEmpty) {
          return const EmptyItemContainer();
        }

        // LIST
        return ItemListBuilder(
          items: items,

          allItems: allItems,

          onLongPress:
              onLongPress,
        );
      },
    );
  }
}