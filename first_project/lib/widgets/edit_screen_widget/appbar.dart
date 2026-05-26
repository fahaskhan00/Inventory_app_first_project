import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';

class EditItemAppBar
    extends StatelessWidget
    implements PreferredSizeWidget {
  const EditItemAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,

      toolbarHeight: 65,

      backgroundColor:
          AppColors.transparent,

      iconTheme: const IconThemeData(
        color: AppColors.black,
      ),

      centerTitle: true,

      title: const Text(
        "Edit Item",

        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(
        65,
      );
}