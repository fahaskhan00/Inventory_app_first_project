import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';

Widget notesBox(
  TextEditingController controller,
) {
  return Container(
    padding: const EdgeInsets.all(18),

    decoration: BoxDecoration(
      color: Colors.white,

      borderRadius:
          BorderRadius.circular(22),

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

    child: Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        const Text(
          "Additional Notes",

          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.text,
          ),
        ),

        const SizedBox(height: 12),

        TextField(
          controller: controller,

          maxLines: 4,

          style: const TextStyle(
            color: AppColors.text,
            fontSize: 14,
          ),

          decoration: const InputDecoration(
            border: InputBorder.none,

            hintText:
                "Write extra information about this product...",

            hintStyle: TextStyle(
              color: AppColors.subtitle,
            ),
          ),
        ),
      ],
    ),
  );
}