import 'package:flutter/material.dart';

import 'detail_tile.dart';

class CustomerDetailCard extends StatelessWidget {
  final Map<String, dynamic> sale;

  const CustomerDetailCard({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.08),

            blurRadius: 15,

            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Row(
            children: [
              Icon(Icons.person_outline, color: Color(0xFFFF8C42)),

              SizedBox(width: 10),

              Text(
                "Customer Details",

                style: TextStyle(
                  color: Colors.black,

                  fontWeight: FontWeight.bold,

                  fontSize: 17,
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          DetailTile(
            icon: Icons.person,

            title: "Customer Name",

            value: sale['customerName'] ?? "",
          ),

          const SizedBox(height: 18),

          DetailTile(
            icon: Icons.phone,

            title: "Phone Number",

            value: sale['customerPhone'] ?? "",
          ),

          const SizedBox(height: 18),
        ],
      ),
    );
  }
}
