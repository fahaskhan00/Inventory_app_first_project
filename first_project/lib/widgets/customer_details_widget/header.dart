import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';

class CustomerHeader
    extends StatelessWidget {
  const CustomerHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Add Customer",

      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
    );
  }
}