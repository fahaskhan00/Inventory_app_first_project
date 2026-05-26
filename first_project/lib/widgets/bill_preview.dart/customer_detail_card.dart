import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';

class CustomerDetailsCard
    extends StatelessWidget {
  final String customerName;

  final String customerPhone;

  const CustomerDetailsCard({
    super.key,
    required this.customerName,
    required this.customerPhone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: AppColors.lightOrange,

        borderRadius:
            BorderRadius.circular(18),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          buildTitle(),

          const SizedBox(height: 12),

          buildCustomerName(),

          const SizedBox(height: 6),

          buildCustomerPhone(),
        ],
      ),
    );
  }

  // TITLE
  Widget buildTitle() {
    return const Text(
      "CUSTOMER DETAILS",

      style: TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );
  }

  // CUSTOMER NAME
  Widget buildCustomerName() {
    return Text(
      customerName,

      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColors.black,
        fontSize: 15,
      ),
    );
  }

  // CUSTOMER PHONE
  Widget buildCustomerPhone() {
    return Text(
      customerPhone,

      style: TextStyle(
        color: Colors.grey.shade700,
      ),
    );
  }
}