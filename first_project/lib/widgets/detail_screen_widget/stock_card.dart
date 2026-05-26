import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';

class StockCard
    extends StatelessWidget {
  final int stock;

  const StockCard({
    super.key,
    required this.stock,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(
        20,
      ),

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

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

        children: [
          buildTitle(),

          buildStockValue(),
        ],
      ),
    );
  }

  // TITLE
  Widget buildTitle() {
    return const Text(
      "Available Stock",

      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
    );
  }

  // STOCK VALUE
  Widget buildStockValue() {
    return Text(
      "$stock",

      style: const TextStyle(
        color: AppColors.primary,

        fontSize: 24,

        fontWeight: FontWeight.bold,
      ),
    );
  }
}