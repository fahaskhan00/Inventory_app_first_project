import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/sales_model.dart';
import 'package:flutter_application_1/screens/sales_detail_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class AllSalesScreen extends StatelessWidget {
  const AllSalesScreen({super.key});

  String formatDate(String rawDate) {

  final parsedDate =
      DateTime.parse(rawDate);

  return DateFormat(
    'dd-MMM-yyyy',
  ).format(parsedDate);
}
  @override
  Widget build(BuildContext context) {
    final salesBox = Hive.box('salesBox');

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,

        iconTheme: const IconThemeData(
          color: Colors.black,
        ),

        title: const Text(
          "All Sales",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),

      body: ValueListenableBuilder(
        valueListenable: salesBox.listenable(),

        builder: (context, box, _) {

          if (box.isEmpty) {
            return const Center(
              child: Text(
                "No sales history",

                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
            );
          }

          Map<String, List<Map<String, dynamic>>> groupedSales = {};

          for (int i = 0; i < box.length; i++) {

            final raw = Map<String, dynamic>.from(
              box.getAt(i),
            );

            final sale = SalesModel.fromMap(raw);

            String dateKey = formatDate(sale.date);

            if (!groupedSales.containsKey(dateKey)) {
              groupedSales[dateKey] = [];
            }

            groupedSales[dateKey]!.add(raw);
          }

          List<String> dates =
              groupedSales.keys.toList()
                ..sort((a, b) => b.compareTo(a));

          return ListView.builder(
            padding: const EdgeInsets.all(16),

            itemCount: dates.length,

            itemBuilder: (context, index) {

              String date = dates[index];

              List<Map<String, dynamic>> salesList =
                  groupedSales[date]!;

              return Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  /// DATE TITLE
                  Container(
                    margin:
                        const EdgeInsets.only(bottom: 14),

                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),

                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3E8),

                      borderRadius:
                          BorderRadius.circular(14),
                    ),

                    child: Text(
                      date,

                      style: const TextStyle(
                        color: Color(0xFFFF8C42),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),

                  ...salesList.reversed.map((saleMap) {

                    final sale =
                        SalesModel.fromMap(saleMap);

                    return GestureDetector(

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SalesDetailScreen(
                              sale: saleMap,
                            ),
                          ),
                        );
                      },

                      child: Container(
                        margin:
                            const EdgeInsets.only(
                          bottom: 14,
                        ),

                        padding:
                            const EdgeInsets.all(18),

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius:
                              BorderRadius.circular(22),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange
                                  .withOpacity(0.08),

                              blurRadius: 15,

                              offset:
                                  const Offset(0, 6),
                            ),
                          ],
                        ),

                        child: Row(
                          children: [

                            Container(
                              padding:
                                  const EdgeInsets.all(12),

                              decoration: BoxDecoration(
                                color:
                                    const Color(
                                  0xFFFFF3E8,
                                ),

                                borderRadius:
                                    BorderRadius.circular(
                                  16,
                                ),
                              ),

                              child: const Icon(
                                Icons.shopping_bag_rounded,

                                color:
                                    Color(0xFFFF8C42),
                              ),
                            ),

                            const SizedBox(width: 14),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,

                                children: [

                                  Text(
                                    "${sale.items.length} items",

                                    style:
                                        const TextStyle(
                                      color:
                                          Colors.black,

                                      fontWeight:
                                          FontWeight
                                              .bold,

                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Text(
                              "₹ ${sale.total}",

                              style: const TextStyle(
                                color:
                                    Color(0xFFFF8C42),

                                fontWeight:
                                    FontWeight.bold,

                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 14),
                ],
              );
            },
          );
        },
      ),
    );
  }
}