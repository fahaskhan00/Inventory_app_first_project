import 'package:flutter/material.dart';

class OutStockAppBar
    extends StatelessWidget
    implements PreferredSizeWidget {
  const OutStockAppBar({
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
        "Out Of Stock",

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