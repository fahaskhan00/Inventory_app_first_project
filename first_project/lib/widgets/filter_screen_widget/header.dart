import 'package:flutter/material.dart';

import 'package:flutter_application_1/colors/app_colors.dart';

class FilterHeader
    extends StatelessWidget {
  final VoidCallback onClose;

  const FilterHeader({
    super.key,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "Filters",

          style: TextStyle(
            fontSize: 22,
            fontWeight:
                FontWeight.bold,
            color: AppColors.black,
          ),
        ),

        const Spacer(),

        GestureDetector(
          onTap: onClose,

          child: Container(
            padding:
                const EdgeInsets.all(8),

            decoration: BoxDecoration(
              color:
                  Colors.grey.shade100,

              shape: BoxShape.circle,
            ),

            child: const Icon(
              Icons.close,

              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}