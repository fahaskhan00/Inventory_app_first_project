import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';

Widget circleBtn(
  IconData icon,
  VoidCallback onTap, {
  bool isPrimary = false,
}) {
  return GestureDetector(
    onTap: onTap,

    child: Container(
      width: 46,
      height: 46,

      decoration: BoxDecoration(
        color: isPrimary
            ? AppColors.primary
            : Colors.grey.shade100,

        shape: BoxShape.circle,
      ),

      child: Icon(
        icon,

        size: 22,

        color: isPrimary
            ? Colors.white
            : AppColors.text,
      ),
    ),
  );
}