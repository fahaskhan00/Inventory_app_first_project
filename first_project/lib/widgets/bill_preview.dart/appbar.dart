import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';

class BillPreviewAppBar
    extends StatelessWidget
    implements PreferredSizeWidget {
  const BillPreviewAppBar({
    super.key,
  });

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
        "Bill Preview",

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