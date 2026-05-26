import 'package:flutter/material.dart';

import 'package:flutter_application_1/colors/app_colors.dart';

class ItemFloatingButton
    extends StatelessWidget {
  final VoidCallback onTap;

  const ItemFloatingButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(
          18,
        ),

        gradient: const LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.secondary,
          ],
        ),

        boxShadow: [
          BoxShadow(
            color: AppColors.primary
                .withOpacity(0.35),

            blurRadius: 18,

            offset: const Offset(
              0,
              8,
            ),
          ),
        ],
      ),

      child: FloatingActionButton(
        elevation: 0,

        backgroundColor:
            Colors.transparent,

        onPressed: onTap,

        child: const Icon(
          Icons.add,

          color: Colors.white,

          size: 30,
        ),
      ),
    );
  }
}