import 'package:flutter/material.dart';

class SalesAppBar
    extends StatelessWidget
    implements PreferredSizeWidget {
  const SalesAppBar({
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
        "Sales Dashboard",

        style: TextStyle(
          color: Colors.black,

          fontWeight:
              FontWeight.bold,

          fontSize: 22,
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