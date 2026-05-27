import 'package:flutter/material.dart';

import 'package:flutter_application_1/screens/detail_screen.dart';

import '../items_widgets.dart';

class ItemListBuilder extends StatelessWidget {
  final List items;

  final List allItems;

  final Function(int originalIndex) onLongPress;

  const ItemListBuilder({
    super.key,
    required this.items,
    required this.allItems,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),

      itemCount: items.length,

      itemBuilder: (context, index) {
        final item = items[index];

        final originalIndex = allItems.indexOf(item);

        final imagePath = item.images.isNotEmpty ? item.images[0] : "";

        return Padding(
          padding: const EdgeInsets.only(bottom: 14),

          child: itemTile(
            item: item,

            imagePath: imagePath,

            onTap: () {
              Navigator.push(
                context,

                MaterialPageRoute(
                  builder:
                      (context) => DetailScreen(
                        name: item.name,

                        price: item.price.toString(),

                        stock: "Stock: ${item.quantity}",

                        tag: item.category,

                        imagePath: item.images,

                        index: originalIndex,
                      ),
                ),
              );
            },

            onLongPress: () {
              onLongPress(originalIndex);
            },
          ),
        );
      },
    );
  }
}
