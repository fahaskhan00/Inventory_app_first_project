import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/database_hive.dart';
import 'package:flutter_application_1/widgets/home_widgets.dart';
import '../colors/app_colors.dart';

class LowStockScreen extends StatelessWidget {
  LowStockScreen({super.key});

  final DatabaseApp db = DatabaseApp();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        centerTitle: true,

        iconTheme:
            const IconThemeData(
          color: Colors.black,
        ),

        title: const Text(
          "Low Stock Items",

          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ValueListenableBuilder(
        valueListenable: db.itemListenable(),

        builder: (context, box, _) {

          final items = db
              .getItems()
              .where(
                (item) =>
                    item.quantity < 5,
              )
              .toList();

          if (items.isEmpty) {

            return const Center(
              child: Text(
                "No low stock items",
              ),
            );
          }

          return ListView.builder(
            padding:
                const EdgeInsets.all(16),

            itemCount: items.length,

            itemBuilder:
                (context, index) {

              final item =
                  items[index];

              final imagePath =
                  item.images.isNotEmpty
                      ? item.images[0]
                      : "";

              return itemTile(
                item: item,
                imagePath: imagePath,

                onTap: () {},

                onLongPress: () {},
              );
            },
          );
        },
      ),
    );
  }
}