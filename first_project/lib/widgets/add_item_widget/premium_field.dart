import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/colors/app_colors.dart';

Widget premiumField(
  String hint,
  TextEditingController controller,
  IconData icon, {
  bool isNumber = false,
  String? label,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,

    children: [
      /// LABEL
      if (label != null) ...[
        Text(
          label,

          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.text,
          ),
        ),

        const SizedBox(height: 8),
      ],

      Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 2,
        ),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(22),

          border: Border.all(
            color: Colors.grey.shade200,
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),

        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,

              decoration: BoxDecoration(
                color:
                    AppColors.primary.withOpacity(0.10),

                borderRadius:
                    BorderRadius.circular(14),
              ),

              child: Icon(
                icon,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: TextField(
                controller: controller,

                style: const TextStyle(
                  color: AppColors.text,
                  fontWeight: FontWeight.w600,
                ),

                keyboardType: isNumber
                    ? TextInputType.number
                    : TextInputType.text,

                inputFormatters: isNumber
                    ? [
                        FilteringTextInputFormatter
                            .digitsOnly,
                      ]
                    : null,

                decoration: InputDecoration(
                  border: InputBorder.none,

                  hintText: hint,

                  hintStyle: const TextStyle(
                    color: AppColors.subtitle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}