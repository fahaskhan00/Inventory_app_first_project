import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';

class PaymentRow extends StatelessWidget {
  final String title;

  final double value;

  const PaymentRow({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,

      children: [
        Text(
          title,

          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),

        Text(
          "₹ ${value.toStringAsFixed(0)}",

          style: const TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}