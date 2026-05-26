import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';
import 'package:flutter_application_1/widgets/bill_preview.dart/payment_row.dart';


class ItemizedDetailsCard
    extends StatelessWidget {
  final List items;

  final double total;

  const ItemizedDetailsCard({
    super.key,
    required this.items,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius:
            BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: AppColors.primary
                .withOpacity(0.08),

            blurRadius: 14,

            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          buildTitle(),

          const SizedBox(height: 18),

          ...items.map((item) {
            return buildItemTile(item);
          }).toList(),

          buildDivider(),

          buildSubtotal(),

          const SizedBox(height: 10),

          buildTax(),

          buildBottomDivider(),

          buildTotalAmount(),
        ],
      ),
    );
  }

  // TITLE
  Widget buildTitle() {
    return const Text(
      "ITEMIZED DETAILS",

      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
        fontSize: 15,
      ),
    );
  }

  // ITEM TILE
  Widget buildItemTile(dynamic item) {
    final qty = item['qty'] ?? 1;

    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 16,
      ),

      child: Row(
        children: [
          buildItemImage(item),

          const SizedBox(width: 14),

          buildItemDetails(item, qty),

          buildItemPrice(item),
        ],
      ),
    );
  }

  // ITEM IMAGE
  Widget buildItemImage(dynamic item) {
    return Container(
      width: 52,
      height: 52,

      decoration: BoxDecoration(
        color: AppColors.lightOrange,

        borderRadius:
            BorderRadius.circular(14),

        image:
            item['images'] != null &&
                    item['images']
                        .isNotEmpty
                ? DecorationImage(
                  image: FileImage(
                    File(
                      item['images'][0],
                    ),
                  ),

                  fit: BoxFit.cover,
                )
                : null,
      ),
    );
  }

  // ITEM DETAILS
  Widget buildItemDetails(
    dynamic item,
    int qty,
  ) {
    return Expanded(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Text(
            item['name'],

            style: const TextStyle(
              color: AppColors.black,

              fontWeight:
                  FontWeight.w600,

              fontSize: 15,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            "Qty: $qty",

            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  // ITEM PRICE
  Widget buildItemPrice(dynamic item) {
    return Text(
      "₹ ${item['price']}",

      style: const TextStyle(
        color: AppColors.primary,

        fontWeight: FontWeight.bold,

        fontSize: 15,
      ),
    );
  }

  // DIVIDER
  Widget buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),

      child: Divider(
        color: AppColors.orangeBorder,
      ),
    );
  }

  // SUBTOTAL
  Widget buildSubtotal() {
    return PaymentRow(
      title: "Subtotal",
      value: total,
    );
  }

  // TAX
  Widget buildTax() {
    return const PaymentRow(
      title: "Tax",
      value: 0,
    );
  }

  // BOTTOM DIVIDER
  Widget buildBottomDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(
        vertical: 14,
      ),

      child: Divider(
        color: AppColors.orangeBorder,
      ),
    );
  }

  // TOTAL AMOUNT
  Widget buildTotalAmount() {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,

      children: [
        const Text(
          "Total Amount",

          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.black,
            fontSize: 16,
          ),
        ),

        Text(
          "₹ ${total.toStringAsFixed(0)}",

          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}