import 'package:flutter/material.dart';

import 'package:flutter_application_1/models/item_model.dart';
import 'package:flutter_application_1/widgets/sales_summary_widget/item_tile.dart';


class SalesSummaryItemList
    extends StatelessWidget {
  final List<ItemModel>
  selectedItems;

  final Map<int, int>
  quantities;

  final Function(
    int index,
    int qty,
  )
  onRemove;

  final Function(
    int index,
    int qty,
    int stock,
  )
  onAdd;

  final Function(
    int index,
    int value,
  )
  onQtyChanged;

  final Function(int index)
  onDelete;

  const SalesSummaryItemList({
    super.key,
    required this.selectedItems,
    required this.quantities,
    required this.onRemove,
    required this.onAdd,
    required this.onQtyChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding:
          const EdgeInsets.all(
        16,
      ),

      itemCount:
          selectedItems.length,

      itemBuilder: (
        context,
        index,
      ) {
        final item =
            selectedItems[index];

        final qty =
            quantities[index] ??
            1;

        final stock =
            item.quantity;

        return saleItemTile(
          context: context,

          item: item,

          qty: qty,

          stock: stock,

          onRemove: () {
            onRemove(
              index,
              qty,
            );
          },

          onAdd: () {
            onAdd(
              index,
              qty,
              stock,
            );
          },

          onQtyChanged: (
            value,
          ) {
            onQtyChanged(
              index,
              value,
            );
          },

          onDelete: () {
            onDelete(
              index,
            );
          },
        );
      },
    );
  }
}