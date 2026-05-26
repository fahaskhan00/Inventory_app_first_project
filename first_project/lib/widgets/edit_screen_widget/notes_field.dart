import 'package:flutter/material.dart';

import 'package:flutter_application_1/colors/app_colors.dart';

class EditNotesField
    extends StatelessWidget {
  final TextEditingController
  controller;

  const EditNotesField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        16,
      ),

      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(20),

        color: AppColors.white,

        boxShadow: [
          BoxShadow(
            color: AppColors.primary
                .withOpacity(0.08),

            blurRadius: 14,

            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: TextField(
        controller: controller,

        maxLines: 4,

        style: const TextStyle(
          color: AppColors.black,
        ),

        decoration: InputDecoration(
          label: const Text(
            'notes',
          ),

          hintText: "Enter notes...",

          hintStyle: TextStyle(
            color: Colors.grey.shade500,
          ),

          border: InputBorder.none,
        ),
      ),
    );
  }
}