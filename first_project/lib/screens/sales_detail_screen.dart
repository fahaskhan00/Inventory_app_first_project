import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/invoice_services.dart';
import '../colors/app_colors.dart';
import '../widgets/sales_details_widget/appbar.dart';
import '../widgets/sales_details_widget/total_card.dart';
import '../widgets/sales_details_widget/detail_card.dart';
import '../widgets/sales_details_widget/sold_product_header.dart';
import '../widgets/sales_details_widget/sold_product_list.dart';

class SalesDetailScreen extends StatelessWidget {
  final Map<String, dynamic> sale;

  const SalesDetailScreen({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    final List items = sale['items'];

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const SalesDetailAppBar(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
         SalesTotalCard(
  sale: sale,
  items: items,
),

const SizedBox(height: 16),

SizedBox(
  width: double.infinity,

  child: ElevatedButton.icon(
   onPressed: () async {
  final success =
      await InvoiceService.downloadInvoice(
    sale: sale,
  );

  ScaffoldMessenger.of(context)
      .showSnackBar(
    SnackBar(
      content: Text(
        success
            ? 'Invoice downloaded successfully'
            : 'Failed to download invoice',
      ),
    ),
  );
},

    icon: const Icon(
      Icons.download,
    ),

    label: const Text(
      'Download Invoice',
    ),
  ),
),

const SizedBox(height: 22),

            const SizedBox(height: 22),

            CustomerDetailCard(sale: sale),

            const SizedBox(height: 18),

            const SizedBox(height: 20),

            SoldProductHeader(itemCount: items.length),

            const SizedBox(height: 18),

            SoldProductList(sale: sale, items: items),
          ],
        ),
      ),
    );
  }
}
