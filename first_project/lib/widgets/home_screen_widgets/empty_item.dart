import 'package:flutter/material.dart';

import 'package:flutter_application_1/colors/app_colors.dart';

class EmptyItemWidget
    extends StatelessWidget {
  const EmptyItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "No items added",

        style: TextStyle(
          color: AppColors.subtitle,

          fontSize: 16,
        ),
      ),
    );
  }
}