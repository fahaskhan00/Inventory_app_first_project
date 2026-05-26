import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import '../sales_widget.dart';

class SalesTopCards
    extends StatelessWidget {
  final Box salesBox;

  final VoidCallback onTap;

  final double Function(Box)
  getTodayRevenue;

  const SalesTopCards({
    super.key,
    required this.salesBox,
    required this.onTap,
    required this.getTodayRevenue,
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
        return Row(
          children: [
            Expanded(
              child: buildStatCard(
                icon:
                    Icons.currency_rupee,

                title:
                    "TODAY SALES",

                value:
                    "₹ ${getTodayRevenue(box).toStringAsFixed(0)}",
              ),
            ),

            const SizedBox(
              width: 14,
            ),

            Expanded(
              child: GestureDetector(
                onTap: onTap,

                child: buildStatCard(
                  icon:
                      Icons.receipt_long,

                  title:
                      "TOTAL BILLS",

                  value:
                      "${box.length}",
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}