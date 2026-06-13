import 'package:flutter/material.dart';

import 'package:flutter_application_1/colors/app_colors.dart';
import 'package:flutter_application_1/services/database_hive.dart';

import 'dashboard_stat_card.dart';

class DashboardStatsSection
    extends StatelessWidget {
  final DatabaseApp db;

  final VoidCallback onItemsTap;

  final VoidCallback onCategoryTap;

  final VoidCallback onLowStockTap;

  final VoidCallback onOutStockTap;

  const DashboardStatsSection({
    super.key,
    required this.db,
    required this.onItemsTap,
    required this.onCategoryTap,
    required this.onLowStockTap,
    required this.onOutStockTap,
  });
@override
Widget build(BuildContext context) {
  final isDesktop =
      MediaQuery.of(context).size.width > 900;

  if (isDesktop) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: buildTopCards()),
            const SizedBox(width: 12),
            Expanded(child: buildBottomCards()),
          ],
        ),
      ],
    );
  }

  return Column(
    children: [
      buildTopCards(),
      const SizedBox(height: 12),
      buildBottomCards(),
    ],
  );
}

  // TOP CARDS
  Widget buildTopCards() {
    return Row(
      children: [
        Expanded(
          child: ValueListenableBuilder(
            valueListenable:
                db.itemListenable(),

            builder:
                (context, box, _) {
                  final totalItems =
                      db
                          .getItems()
                          .length;

                  return DashboardStatCard(
                    title:
                        "Total Items",

                    value:
                        totalItems
                            .toString(),

                    icon: Icons
                        .list_alt_outlined,

                    color:
                        AppColors.primary,

                    onTap:
                        onItemsTap,
                  );
                },
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: ValueListenableBuilder(
            valueListenable:
                db
                    .categoryListenable(),

            builder:
                (context, box, _) {
                  return DashboardStatCard(
                    title:
                        "CATEGORIES",

                    value:
                        db
                            .getCategoryCount()
                            .toString(),

                    icon: Icons
                        .folder_outlined,

                    color:
                        AppColors.secondary,

                    onTap:
                        onCategoryTap,
                  );
                },
          ),
        ),
      ],
    );
  }

  // BOTTOM CARDS
  Widget buildBottomCards() {
    return Row(
      children: [
        Expanded(
          child: ValueListenableBuilder(
            valueListenable:
                db.itemListenable(),

            builder:
                (context, box, _) {
                  final items =
                      db.getItems();

                 final lowStockCount =
    items.where(
      (item) =>
          item.quantity > 0 &&
          item.quantity < 5,
    ).length;

                  return DashboardStatCard(
                    title:
                        "LOW STOCK",

                    value:
                        lowStockCount
                            .toString(),

                    icon: Icons
                        .warning_amber_rounded,

                    color:
                        AppColors.danger,

                    onTap:
                        onLowStockTap,
                  );
                },
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: ValueListenableBuilder(
            valueListenable:
                db.itemListenable(),

            builder:
                (context, box, _) {
                  final items =
                      db.getItems();

                  final outOfStockCount =
    items.where(
      (item) => item.quantity == 0,
    ).length;

                  return DashboardStatCard(
                    title:
                        "OUT OF STOCK",

                    value:
                        outOfStockCount
                            .toString(),

                    icon: Icons
                        .remove_shopping_cart,

                    color:
                        AppColors.warning,

                    onTap:
                        onOutStockTap,
                  );
                },
          ),
        ),
      ],
    );
  }
}