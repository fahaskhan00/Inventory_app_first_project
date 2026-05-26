import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';
import 'package:flutter_application_1/widgets/bill_preview.dart/appbar.dart';
import 'package:flutter_application_1/widgets/bill_preview.dart/customer_detail_card.dart';
import 'package:flutter_application_1/widgets/bill_preview.dart/itemized_details_card.dart';
import 'package:flutter_application_1/widgets/bill_preview.dart/save_bill_button.dart';
import 'package:flutter_application_1/widgets/bill_preview.dart/success_card.dart';
import 'package:flutter_application_1/widgets/bill_preview.dart/thanks_text.dart';
import 'package:hive/hive.dart';

class BillPreviewScreen extends StatelessWidget {
  final List items;

  final double total;

  final String customerName;

  final String customerPhone;

  const BillPreviewScreen({
    super.key,
    required this.items,
    required this.total,
    required this.customerName,
    required this.customerPhone,
  });

  // CURRENT DATE
  DateTime getCurrentDate() {
    return DateTime.now();
  }

  // SALES BOX
  Box getSalesBox() {
    return Hive.box('salesBox');
  }

  // ITEMS BOX
  Box getItemsBox() {
    return Hive.box('itemsBox');
  }

  // SAVE BILL
  Future<void> saveBill(BuildContext context, DateTime now) async {
    final salesBox = getSalesBox();

    final itemsBox = getItemsBox();

    await salesBox.add({
      "items": items,
      "total": total,
      "date": now.toString(),

      "customerName": customerName,

      "customerPhone": customerPhone,
    });

    for (var soldItem in items) {
      final soldQty = soldItem['qty'] ?? 1;

      for (int i = 0; i < itemsBox.length; i++) {
        var product = itemsBox.getAt(i);

        if (product['name'] == soldItem['name']) {
          int currentStock = product['quantity'];

          num newStock = currentStock - soldQty;

          itemsBox.putAt(i, {
            ...product,
            'quantity': newStock < 0 ? 0 : newStock,
          });

          break;
        }
      }
    }

    showSaveMessage(context);

    navigateToHome(context);
  }

  // SAVE MESSAGE
  void showSaveMessage(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Bill Saved & Updated")));
  }

  // NAVIGATE HOME
  void navigateToHome(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  // APP BAR
  PreferredSizeWidget buildAppBar() {
    return const BillPreviewAppBar();
  }

  // SUCCESS CARD
  Widget buildSuccessCard(DateTime now) {
    return SuccessCard(now: now);
  }

  // CUSTOMER CARD
  Widget buildCustomerCard() {
    return CustomerDetailsCard(
      customerName: customerName,
      customerPhone: customerPhone,
    );
  }

  // ITEMIZED CARD
  Widget buildItemizedCard() {
    return ItemizedDetailsCard(items: items, total: total);
  }

  // SAVE BUTTON
  Widget buildSaveButton(BuildContext context, DateTime now) {
    return SaveBillButton(
      onTap: () {
        saveBill(context, now);
      },
    );
  }

  // THANK YOU
  Widget buildThankYouText() {
    return const ThankYouText();
  }

  // BODY
  Widget buildBody(BuildContext context, DateTime now) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),

      child: Column(
        children: [
          buildSuccessCard(now),

          const SizedBox(height: 18),

          buildCustomerCard(),

          const SizedBox(height: 20),

          buildItemizedCard(),

          const SizedBox(height: 24),

          buildSaveButton(context, now),

          const SizedBox(height: 22),

          buildThankYouText(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = getCurrentDate();

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: buildAppBar(),

      body: buildBody(context, now),
    );
  }
}
