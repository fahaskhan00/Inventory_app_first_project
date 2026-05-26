import 'package:flutter/material.dart';

class LowStockAppBar
    extends StatelessWidget
    implements PreferredSizeWidget {
  const LowStockAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:
          Colors.transparent,

      elevation: 0,

      centerTitle: true,

      iconTheme:
          const IconThemeData(
            color: Colors.black,
          ),

      title: const Text(
        "Low Stock Items",

        style: TextStyle(
          color: Colors.black,

          fontWeight:
              FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(
        kToolbarHeight,
      );
}