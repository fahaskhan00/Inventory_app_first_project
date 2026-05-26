import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/sales_screen_widgets/rescent_tile.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter_application_1/models/sales_model.dart';

import 'no_sales.dart';


class TodaySalesSection
    extends StatelessWidget {
  final Box salesBox;

  final Function(
    SalesModel sale,
  )
  onTap;

  const TodaySalesSection({
    super.key,
    required this.salesBox,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable:
          salesBox.listenable(),

      builder: (
        context,
        box,
        _,
      ) {
        DateTime now =
            DateTime.now();

        List todaySales = [];

        for (
          int i = 0;
          i < box.length;
          i++
        ) {
          final sale =
              SalesModel.fromMap(
                Map<String, dynamic>.from(
                  box.getAt(i),
                ),
              );

          if (sale.date.isNotEmpty) {
            DateTime date =
                DateTime.parse(
                  sale.date,
                );

            if (date.year ==
                    now.year &&
                date.month ==
                    now.month &&
                date.day ==
                    now.day) {
              todaySales.add(
                sale,
              );
            }
          }
        }

        if (todaySales.isEmpty) {
          return const NoSalesWidget();
        }

        return ListView.builder(
          shrinkWrap: true,

          physics:
              const NeverScrollableScrollPhysics(),

          itemCount:
              todaySales.length,

          itemBuilder: (
            context,
            index,
          ) {
            final sale =
                todaySales
                    .reversed
                    .toList()[index];

            return RecentSaleTile(
              sale: sale,

              index: index,

              onTap: () {
                onTap(sale);
              },
            );
          },
        );
      },
    );
  }
}