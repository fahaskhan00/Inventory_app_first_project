import 'package:flutter/material.dart';

import 'package:flutter_application_1/colors/app_colors.dart';

class SalesAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const SalesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:
          AppColors.transparent,

      elevation: 0,

      iconTheme: const IconThemeData(
        color: AppColors.black,
      ),

      title: const Text(
        "Add New Sale",

        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.black,
          fontSize: 22,
        ),
      ),

      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
        ),

        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(
        kToolbarHeight,
      );
}