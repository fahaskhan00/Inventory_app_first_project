import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_application_1/models/sales_model.dart';
import 'package:flutter_application_1/screens/add_sales_screen.dart';
import 'package:flutter_application_1/screens/all_sales_history.dart';
import 'package:flutter_application_1/screens/sales_detail_screen.dart';
import '../widgets/sales_screen_widgets/appbar.dart';
import '../widgets/sales_screen_widgets/floating_button.dart';
import '../widgets/sales_screen_widgets/top_cards.dart';
import '../widgets/sales_screen_widgets/analytics_section.dart';
import '../widgets/sales_screen_widgets/filter_buttons.dart';
import '../widgets/sales_screen_widgets/today_sale_section.dart';
import '../widgets/sales_screen_widgets/sales_filter_section.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final salesBox = Hive.box('salesBox');

  bool showAllSales = false;

  String selectedFilter = "Today";

  // CHANGE FILTER
  void changeFilter(String filter) {
    setState(() {
      selectedFilter = filter;
    });
  }

  // TODAY REVENUE
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

  // TOTAL REVENUE
  double getTotalRevenue(Box box) {
    double total = 0;

    for (int i = 0; i < box.length; i++) {
      final sale = SalesModel.fromMap(Map<String, dynamic>.from(box.getAt(i)));

      total += sale.total;
    }

    return total;
  }

  // OPEN ADD SALE
  void openAddSale() {
    Navigator.push(
      context,

      MaterialPageRoute(
        builder:
            (context) => AddSalesScreen(
              customerName: '',

              customerPhone: '',

              customerAddress: '',
            ),
      ),
    );
  }

  // OPEN ALL SALES
  void openAllSales() {
    Navigator.push(
      context,

      MaterialPageRoute(builder: (context) => AllSalesScreen()),
    );
  }

  // OPEN DETAIL
  void openDetail(SalesModel sale) {
    Navigator.push(
      context,

      MaterialPageRoute(
        builder: (context) => SalesDetailScreen(sale: sale.toMap()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      appBar: const SalesAppBar(),

      floatingActionButton: SalesFloatingButton(onTap: openAddSale),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SalesTopCards(
                salesBox: salesBox,

                onTap: openAllSales,

                getTodayRevenue: getTodayRevenue,
              ),

              const SizedBox(height: 28),

              SalesFilterSection(
                selectedFilter: selectedFilter,

                onSelected: changeFilter,
              ),

              const SizedBox(height: 20),

              SalesAnalyticsSection(
                salesBox: salesBox,

                selectedFilter: selectedFilter,
              ),

              const SizedBox(height: 28),

              SalesFilterButtons(onTap: openAllSales),

              const SizedBox(height: 18),

              TodaySalesSection(salesBox: salesBox, onTap: openDetail),
            ],
          ),
        ),
      ),
    );
  }
}
