import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';

class ProductPriceCard
    extends StatelessWidget {
  final dynamic price;

  final String salePrice;

  const ProductPriceCard({
    super.key,
    required this.price,
    required this.salePrice,
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

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          buildPriceTitle(),

          const SizedBox(height: 8),

          buildMainPrice(),

          if (salePrice
              .trim()
              .isNotEmpty) ...[
            const SizedBox(height: 18),

            buildSalePriceTitle(),

            const SizedBox(height: 6),

            buildSalePrice(),
          ],
        ],
      ),
    );
  }

  // PRICE TITLE
  Widget buildPriceTitle() {
    return Text(
      "Product Price",

      style: TextStyle(
        color: Colors.grey.shade600,
        fontSize: 14,
      ),
    );
  }

  // MAIN PRICE
  Widget buildMainPrice() {
    return Text(
      "₹ $price",

      style: const TextStyle(
        color: AppColors.primary,

        fontSize: 34,

        fontWeight: FontWeight.bold,
      ),
    );
  }

  // SALE PRICE TITLE
  Widget buildSalePriceTitle() {
    return Text(
      "Sale Price",

      style: TextStyle(
        color: Colors.grey.shade600,
        fontSize: 14,
      ),
    );
  }

  // SALE PRICE
  Widget buildSalePrice() {
    return Text(
      "₹ $salePrice",

      style: TextStyle(
        color: Colors.green.shade700,

        fontSize: 24,

        fontWeight: FontWeight.bold,
      ),
    );
  }
}