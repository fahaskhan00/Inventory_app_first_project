import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/sales_model.dart';
import 'package:flutter_application_1/screens/sales_detail_screen.dart';

class SalesHistoryTile
    extends StatelessWidget {
  final Map<String, dynamic> saleMap;

  const SalesHistoryTile({
    super.key,
    required this.saleMap,
  });

  @override
  Widget build(BuildContext context) {
    final sale = SalesModel.fromMap(
      saleMap,
    );

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,

          MaterialPageRoute(
            builder:
                (context) =>
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

              offset: const Offset(0, 6),
            ),
          ],
        ),

        child: Row(
          children: [
            buildLeadingIcon(),

            const SizedBox(width: 14),

            buildItemDetails(sale),

            buildPrice(sale),
          ],
        ),
      ),
    );
  }

  // LEADING ICON
  Widget buildLeadingIcon() {
    return Container(
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: const Color(
          0xFFFFF3E8,
        ),

        borderRadius:
            BorderRadius.circular(16),
      ),

      child: const Icon(
        Icons.shopping_bag_rounded,

        color: Color(0xFFFF8C42),
      ),
    );
  }

  // ITEM DETAILS
  Widget buildItemDetails(
    SalesModel sale,
  ) {
    return Expanded(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Text(
            "${sale.items.length} items",

            style: const TextStyle(
              color: Colors.black,

              fontWeight:
                  FontWeight.bold,

              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  // PRICE
  Widget buildPrice(SalesModel sale) {
    return Text(
      "₹ ${sale.total}",

      style: const TextStyle(
        color: Color(0xFFFF8C42),

        fontWeight: FontWeight.bold,

        fontSize: 17,
      ),
    );
  }
}