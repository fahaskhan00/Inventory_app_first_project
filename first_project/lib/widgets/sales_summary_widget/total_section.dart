import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/sales_summary_widget/summary_row.dart';

import '../sales_summary_widget.dart';

class SalesTotalSection extends StatelessWidget {
  final double subtotal;

  final String customerName;

  const SalesTotalSection({
    super.key,
    required this.subtotal,
    required this.customerName,
  });

  @override
  Widget build(BuildContext context) {
    return totalCard(
      child: Column(
        children: [
          const SizedBox(height: 14),

          summaryRow("Total", subtotal),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),

            child: Divider(color: Color(0xFFFFE0CC), height: 1),
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
