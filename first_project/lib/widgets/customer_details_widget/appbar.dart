import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';

class CustomerDetailsAppBar
    extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomerDetailsAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:
          AppColors.transparent,

      elevation: 0,

      centerTitle: true,

      iconTheme:
          const IconThemeData(
        color: AppColors.black,
      ),

      title: const Text(
        "Customer Details",

        style: TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.bold,
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