import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/sales_model.dart';
import 'package:flutter_application_1/screens/add_sales_screen.dart';
import 'package:flutter_application_1/screens/all_sales_history.dart';
import 'package:flutter_application_1/screens/sales_detail_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../widgets/sales_widget.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final salesBox = Hive.box('salesBox');

  bool showAllSales = false;

  double getTodayRevenue(Box box) {
    double total = 0;
    DateTime now = DateTime.now();

    for (int i = 0; i < box.length; i++) {
      final sale = SalesModel.fromMap(Map<String, dynamic>.from(box.getAt(i)));

      if (sale.date.isNotEmpty) {
        DateTime date = DateTime.parse(sale.date);

        if (date.year == now.year &&
            date.month == now.month &&
            date.day == now.day) {
          total += sale.total;
        }
      }
    }

    return total;
  }

  double getTotalRevenue(Box box) {
    double total = 0;

    for (int i = 0; i < box.length; i++) {
      final sale = SalesModel.fromMap(Map<String, dynamic>.from(box.getAt(i)));

      total += sale.total;
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,

        iconTheme: const IconThemeData(color: Colors.black),

        title: const Text(
          "Sales Dashboard",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFFF8C42),
        elevation: 4,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddSalesScreen(
  customerName: '',
  customerPhone: '',
  customerAddress: '',
)),
          );
        },

        icon: const Icon(Icons.add, color: Colors.white),

        label: const Text(
          "Add Sale",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              /// TOP CARDS
              ValueListenableBuilder(
                valueListenable: salesBox.listenable(),

                builder: (context, box, _) {
                  return Row(
                    children: [
                      Expanded(
                        child: buildStatCard(
                          icon: Icons.currency_rupee,
                          title: "TODAY SALES",
                          value: "₹ ${getTodayRevenue(box).toStringAsFixed(0)}",
                        ),
                      ),

                      const SizedBox(width: 14),

                     Expanded(
  child: GestureDetector(

    onTap: () {

      Navigator.push(
        context,

        MaterialPageRoute(
          builder:
              (context) =>
                  AllSalesScreen(),
        ),
      );
    },

    child: buildStatCard(
      icon: Icons.receipt_long,
      title: "TOTAL BILLS",
      value: "${box.length}",
    ),
  ),
),
                    ],
                  );
                },
              ),

              const SizedBox(height: 28),

              /// WEEKLY TREND
             /// SALES ANALYTICS
glassContainer(
  child: ValueListenableBuilder(
    valueListenable: salesBox.listenable(),
    builder: (context, box, _) {
      List<double> weeklyTotals = List.filled(7, 0);

      for (int i = 0; i < box.length; i++) {
        final sale = SalesModel.fromMap(
          Map<String, dynamic>.from(box.getAt(i)),
        );

        if (sale.date.isNotEmpty) {
          DateTime date = DateTime.parse(sale.date);

          int weekday = date.weekday - 1;

          weeklyTotals[weekday] += sale.total;
        }
      }

      double maxValue = weeklyTotals.reduce(
        (a, b) => a > b ? a : b,
      );

      if (maxValue == 0) {
        maxValue = 1;
      }

      double weekRevenue =
          weeklyTotals.fold(0, (sum, item) => sum + item);

      double averageSale =
          box.length == 0 ? 0 : weekRevenue / box.length;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.analytics_rounded,
                    color: Color(0xFFFF8C42),
                    size: 24,
                  ),

                  SizedBox(width: 10),

                  Text(
                    "Sales Analytics",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),

                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E8),
                  borderRadius: BorderRadius.circular(14),
                ),

                child: const Text(
                  "This Week",
                  style: TextStyle(
                    color: Color(0xFFFF8C42),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          /// TOP ANALYTICS CARDS
          Row(
            children: [

              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(18),

                  decoration: BoxDecoration(
                    color: const Color(0xFFFF8C42),
                    borderRadius: BorderRadius.circular(22),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Icon(
                        Icons.currency_rupee,
                        color: Colors.white,
                      ),

                      const SizedBox(height: 14),

                      Text(
                        "₹ ${weekRevenue.toStringAsFixed(0)}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),

                      const SizedBox(height: 6),

                      const Text(
                        "Weekly Revenue",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(18),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),

                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Icon(
                        Icons.show_chart,
                        color: Color(0xFFFF8C42),
                      ),

                      const SizedBox(height: 14),

                      Text(
                        "₹ ${averageSale.toStringAsFixed(0)}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),

                      const SizedBox(height: 6),

                      const Text(
                        "Average Sale",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          /// WEEKLY PERFORMANCE GRAPH
          const Text(
            "Weekly Performance",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 24),

          SizedBox(
            height: 150,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,

              children: List.generate(7, (index) {

                double height =
                    (weeklyTotals[index] / maxValue) * 90;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Text(
                      weeklyTotals[index] == 0
                          ? "0"
                          : weeklyTotals[index]
                              .toStringAsFixed(0),

                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),

                      width: 26,
                      height: height < 10 ? 10 : height,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),

                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,

                          colors: [
                            Color(0xFFFFB067),
                            Color(0xFFFF8C42),
                          ],
                        ),

                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFFF8C42).withOpacity(.25),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      ["M", "T", "W", "T", "F", "S", "S"][index],

                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      );
    },
  ),
),
              const SizedBox(height: 28),

              /// BUTTONS
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 12,
                    ),

                    decoration: BoxDecoration(
                      color: const Color(0xFFFF8C42),

                      borderRadius: BorderRadius.circular(30),
                    ),

                    child: const Text(
                      "Recent",

                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllSalesScreen(),
                        ),
                      );
                    },

                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 12,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(30),

                        border: Border.all(color: const Color(0xFFFF8C42)),
                      ),

                      child: const Text(
                        "All Sales",

                        style: TextStyle(
                          color: Color(0xFFFF8C42),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              /// TODAY SALES LIST
              ValueListenableBuilder(
                valueListenable: salesBox.listenable(),

                builder: (context, box, _) {
                  DateTime now = DateTime.now();

                  List todaySales = [];

                  for (int i = 0; i < box.length; i++) {
                    final sale = SalesModel.fromMap(
                      Map<String, dynamic>.from(box.getAt(i)),
                    );

                    if (sale.date.isNotEmpty) {
                      DateTime date = DateTime.parse(sale.date);

                      if (date.year == now.year &&
                          date.month == now.month &&
                          date.day == now.day) {
                        todaySales.add(sale);
                      }
                    }
                  }

                  if (todaySales.isEmpty) {
                    return glassContainer(
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 18),

                        child: Center(
                          child: Text(
                            "No sales today",

                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,

                    physics: const NeverScrollableScrollPhysics(),

                    itemCount: todaySales.length,

                    itemBuilder: (context, index) {
                      final sale = todaySales.reversed.toList()[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      SalesDetailScreen(sale: sale.toMap()),
                            ),
                          );
                        },

                        child: glassContainer(
                          margin: const EdgeInsets.only(bottom: 14),

                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),

                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF3E8),

                                  borderRadius: BorderRadius.circular(16),
                                ),

                                child: const Icon(
                                  Icons.shopping_bag_rounded,
                                  color: Color(0xFFFF8C42),
                                ),
                              ),

                              const SizedBox(width: 14),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Text(
                                      "Sale ${index + 1}",

                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),

                                    const SizedBox(height: 6),

                                    Text(
                                      "${sale.items.length} items",

                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Text(
                                "₹ ${sale.total}",

                                style: const TextStyle(
                                  color: Color(0xFFFF8C42),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
