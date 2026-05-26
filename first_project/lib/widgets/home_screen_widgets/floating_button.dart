import 'package:flutter/material.dart';

import 'package:flutter_application_1/colors/app_colors.dart';

class FloatingAddButton
    extends StatelessWidget {
  final VoidCallback onTap;

  const FloatingAddButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onTap,

      backgroundColor:
          AppColors.primary,

      elevation: 5,

      child: const Icon(
        Icons.add,

        color: Colors.white,
      ),
    );
  }
}