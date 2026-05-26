import 'package:flutter/material.dart';

import 'package:flutter_application_1/colors/app_colors.dart';

class FilterSectionTitle
    extends StatelessWidget {
  final String title;

  const FilterSectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,

      style: const TextStyle(
        color: AppColors.black,

        fontWeight:
            FontWeight.bold,

        fontSize: 15,
      ),
    );
  }
}