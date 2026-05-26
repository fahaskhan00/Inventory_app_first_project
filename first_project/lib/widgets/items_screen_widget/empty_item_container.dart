import 'package:flutter/material.dart';

import 'package:flutter_application_1/colors/app_colors.dart';

class EmptyItemContainer
    extends StatelessWidget {
  const EmptyItemContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding:
            const EdgeInsets.all(
          24,
        ),

        decoration: BoxDecoration(
          color: AppColors.card,

          borderRadius:
              BorderRadius.circular(
            24,
          ),
        ),

        child: Text(
          "No items added",

          style: TextStyle(
            color: AppColors.subtitle,

            fontSize: 16,

            fontWeight:
                FontWeight.w500,
          ),
        ),
      ),
    );
  }
}