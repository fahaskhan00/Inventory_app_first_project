import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';

class SuccessCard extends StatelessWidget {
  final DateTime now;

  const SuccessCard({
    super.key,
    required this.now,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),

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
        children: [
          buildSuccessIcon(),

          const SizedBox(height: 14),

          buildTitle(),

          const SizedBox(height: 6),

          buildStoreName(),

          const SizedBox(height: 12),

          buildDate(),
        ],
      ),
    );
  }

  // SUCCESS ICON
  Widget buildSuccessIcon() {
    return CircleAvatar(
      radius: 28,

      backgroundColor:
          AppColors.lightOrange,

      child: const Icon(
        Icons.check_rounded,

        color: AppColors.primary,

        size: 30,
      ),
    );
  }

  // TITLE
  Widget buildTitle() {
    return const Text(
      "Bill Generated Successfully",

      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: AppColors.black,
      ),
    );
  }

  // STORE NAME
  Widget buildStoreName() {
    return Text(
      "MyInventory Store",

      style: TextStyle(
        color: Colors.grey.shade600,
        fontSize: 14,
      ),
    );
  }

  // DATE
  Widget buildDate() {
    return Text(
      "TRANSACTION DATE\n${now.toString()}",

      textAlign: TextAlign.center,

      style: TextStyle(
        fontSize: 12,
        color: Colors.grey.shade600,
      ),
    );
  }
}