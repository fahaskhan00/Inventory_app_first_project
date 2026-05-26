import 'package:flutter/material.dart';

import 'sold_product_tile.dart';

class SoldProductList
    extends StatelessWidget {
  final Map<String, dynamic>
  sale;

  final List items;

  const SoldProductList({
    super.key,
    required this.sale,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,

      physics:
          const NeverScrollableScrollPhysics(),

      itemCount: items.length,

      itemBuilder: (
        context,
        index,
      ) {
        final item =
            items[index];

        return SoldProductTile(
          sale: sale,

          item: item,
        );
      },
    );
  }
}