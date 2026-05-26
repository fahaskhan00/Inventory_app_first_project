import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';
import 'package:flutter_application_1/models/sales_model.dart';
import 'package:flutter_application_1/widgets/all_sales_history.dart/sales_history.dart';
import 'package:flutter_application_1/widgets/all_sales_history.dart/empty_sales.dart';
import 'package:flutter_application_1/widgets/all_sales_history.dart/sales_date_header.dart';
import 'package:flutter_application_1/widgets/all_sales_history.dart/sales_history_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class AllSalesScreen extends StatelessWidget {
  const AllSalesScreen({super.key});

  // FORMAT DATE
  String formatDate(String rawDate) {
    final parsedDate = DateTime.parse(rawDate);

    return DateFormat('dd-MMM-yyyy').format(parsedDate);
  }

  // GET SALES BOX
  Box getSalesBox() {
    return Hive.box('salesBox');
  }

  // GROUP SALES
  Map<String, List<Map<String, dynamic>>> groupSales(Box box) {
    Map<String, List<Map<String, dynamic>>> groupedSales = {};

    for (int i = 0; i < box.length; i++) {
      final raw = Map<String, dynamic>.from(box.getAt(i));

      final sale = SalesModel.fromMap(raw);

      String dateKey = formatDate(sale.date);

      if (!groupedSales.containsKey(dateKey)) {
        groupedSales[dateKey] = [];
      }

      groupedSales[dateKey]!.add(raw);
    }

    return groupedSales;
  }

  // SORT DATES
  List<String> getSortedDates(
    Map<String, List<Map<String, dynamic>>> groupedSales,
  ) {
    return groupedSales.keys.toList()..sort((a, b) => b.compareTo(a));
  }

  // APP BAR
  PreferredSizeWidget buildAppBar() {
    return const AllSalesAppBar();
  }

  // EMPTY SCREEN
  Widget buildEmptyWidget() {
    return const EmptySalesWidget();
  }

  // SALES LIST
  Widget buildSalesList(
    List<String> dates,
    Map<String, List<Map<String, dynamic>>> groupedSales,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),

      itemCount: dates.length,

      itemBuilder: (context, index) {
        String date = dates[index];

        List<Map<String, dynamic>> salesList = groupedSales[date]!;

        return buildDateSection(context, date, salesList);
      },
    );
  }

  // DATE SECTION
  Widget buildDateSection(
    BuildContext context,
    String date,
    List<Map<String, dynamic>> salesList,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        buildDateHeader(date),

        ...salesList.reversed.map((saleMap) {
          return buildSalesTile(context, saleMap);
        }),

        buildBottomSpacing(),
      ],
    );
  }

  // DATE HEADER
  Widget buildDateHeader(String date) {
    return SalesDateHeader(date: date);
  }

  // SALES TILE
  Widget buildSalesTile(BuildContext context, Map<String, dynamic> saleMap) {
    return SalesHistoryTile(saleMap: saleMap);
  }

  // SPACING
  Widget buildBottomSpacing() {
    return const SizedBox(height: 14);
  }

  // BODY
  Widget buildBody() {
    final salesBox = getSalesBox();

    return ValueListenableBuilder(
      valueListenable: salesBox.listenable(),

      builder: (context, box, _) {
        if (box.isEmpty) {
          return buildEmptyWidget();
        }

        final groupedSales = groupSales(box);

        final dates = getSortedDates(groupedSales);

        return buildSalesList(dates, groupedSales);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: buildAppBar(),

      body: buildBody(),
    );
  }
}
