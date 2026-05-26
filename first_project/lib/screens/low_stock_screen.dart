import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/database_hive.dart';
import '../colors/app_colors.dart';
import '../widgets/low_stock_widget/appbar.dart';
import '../widgets/low_stock_widget/empty.dart';
import '../widgets/low_stock_widget/stock_list.dart';

class LowStockScreen extends StatelessWidget {
  LowStockScreen({super.key});

  final DatabaseApp db = DatabaseApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const LowStockAppBar(),

      body: ValueListenableBuilder(
        valueListenable: db.itemListenable(),

        builder: (context, box, _) {
          final items =
              db
                  .getItems()
                  .where((item) => item.quantity < 5 && item.quantity > 0)
                  .toList();

          if (items.isEmpty) {
            return const LowStockEmpty();
          }

          return LowStockList(items: items);
        },
      ),
    );
  }
}
