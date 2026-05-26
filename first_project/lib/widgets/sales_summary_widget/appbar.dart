import 'package:flutter/material.dart';

class SalesSummaryAppBar
    extends StatelessWidget
    implements PreferredSizeWidget {
  const SalesSummaryAppBar({
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
        "Sale Summary",

        style: TextStyle(
          fontWeight:
              FontWeight.bold,

          color: Colors.black,

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