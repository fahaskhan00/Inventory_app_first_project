import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter_application_1/models/sales_model.dart';

import '../sales_widget.dart';

import 'analytics_card.dart';
import 'weekly_graph.dart';

class SalesAnalyticsSection
    extends StatelessWidget {
  final Box salesBox;

  final String selectedFilter;

  const SalesAnalyticsSection({
    super.key,
    required this.salesBox,
    required this.selectedFilter,
  });

  @override
  Widget build(BuildContext context) {
    return glassContainer(
      child: ValueListenableBuilder(
        valueListenable:
            salesBox.listenable(),

        builder: (
          context,
          box,
          _,
        ) {
          List<double>
          weeklyTotals =
              List.filled(
                7,
                0,
              );

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

              int weekday =
                  date.weekday - 1;

              DateTime now =
                  DateTime.now();

              bool shouldAdd =
                  false;

              if (selectedFilter ==
                  "Today") {
                shouldAdd =
                    date.year ==
                        now.year &&
                    date.month ==
                        now.month &&
                    date.day ==
                        now.day;
              }

              if (selectedFilter ==
                  "Weekly") {
                shouldAdd =
                    now
                            .difference(
                              date,
                            )
                            .inDays <=
                        7;
              }

              if (selectedFilter ==
                  "Monthly") {
                shouldAdd =
                    date.year ==
                        now.year &&
                    date.month ==
                        now.month;
              }

              if (shouldAdd) {
                weeklyTotals[weekday] +=
                    sale.total;
              }
            }
          }

          double maxValue =
              weeklyTotals.reduce(
                (
                  a,
                  b,
                ) => a > b
                    ? a
                    : b,
              );

          if (maxValue == 0) {
            maxValue = 1;
          }

          double weekRevenue =
              weeklyTotals.fold(
                0,
                (
                  sum,
                  item,
                ) => sum + item,
              );

          double averageSale =
              box.length == 0
                  ? 0
                  : weekRevenue /
                      box.length;

          return Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [
              buildHeader(),

              const SizedBox(
                height: 24,
              ),

              AnalyticsCards(
                weekRevenue:
                    weekRevenue,

                averageSale:
                    averageSale,
              ),

              const SizedBox(
                height: 30,
              ),

              Text(
                "$selectedFilter Performance",

                style: const TextStyle(
                  color: Colors.black,

                  fontWeight:
                      FontWeight.bold,

                  fontSize: 16,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              WeeklyGraph(
                weeklyTotals:
                    weeklyTotals,

                maxValue:
                    maxValue,
              ),
            ],
          );
        },
      ),
    );
  }

  // HEADER
  Widget buildHeader() {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment
              .spaceBetween,

      children: [
        const Row(
          children: [
            Icon(
              Icons.analytics_rounded,

              color: Color(
                0xFFFF8C42,
              ),

              size: 24,
            ),

            SizedBox(width: 10),

            Text(
              "Sales Analytics",

              style: TextStyle(
                fontSize: 19,

                fontWeight:
                    FontWeight.bold,

                color: Colors.black,
              ),
            ),
          ],
        ),

        Container(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8,
          ),

          decoration: BoxDecoration(
            color: const Color(
              0xFFFFF3E8,
            ),

            borderRadius:
                BorderRadius.circular(
              14,
            ),
          ),

          child: Text(
            selectedFilter,

            style: const TextStyle(
              color: Color(
                0xFFFF8C42,
              ),

              fontWeight:
                  FontWeight.w600,

              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}