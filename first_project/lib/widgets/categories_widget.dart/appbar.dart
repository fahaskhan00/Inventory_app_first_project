import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';

class CategoriesAppBar
    extends StatelessWidget
    implements PreferredSizeWidget {
  const CategoriesAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,

      toolbarHeight: 85,

      backgroundColor:
          AppColors.transparent,

      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary,
              AppColors.secondary,
            ],

            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),

      title: const Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Text(
            "Inventory",

            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: 4),

          Text(
            "Categories",

            style: TextStyle(
              color: AppColors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(85);
}