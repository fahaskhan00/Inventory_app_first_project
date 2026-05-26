import 'package:flutter/material.dart';

import 'package:flutter_application_1/colors/app_colors.dart';

class ItemAppBar
    extends StatelessWidget
    implements PreferredSizeWidget {
  const ItemAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,

      toolbarHeight: 85,

      backgroundColor:
          Colors.transparent,

      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary,
              AppColors.secondary,
            ],

            begin: Alignment.topLeft,

            end:
                Alignment.bottomRight,
          ),
        ),
      ),

      title: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: const [
          Text(
            "Inventory",

            style: TextStyle(
              color: Colors.white70,

              fontSize: 14,

              fontWeight:
                  FontWeight.w500,
            ),
          ),

          SizedBox(height: 4),

          Text(
            "My Items",

            style: TextStyle(
              color: Colors.white,

              fontSize: 28,

              fontWeight:
                  FontWeight.bold,
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