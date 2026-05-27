import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';

class AddItemAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final bool isEdit;

  const AddItemAppBar({
    super.key,
    required this.isEdit,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,

      centerTitle: true,

      backgroundColor: AppColors.white,

      surfaceTintColor:
          AppColors.white,

      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },

        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,

          color: AppColors.text,

          size: 20,
        ),
      ),

      title: Text(
        isEdit ? "Edit Item" : "Add Item",

        style: const TextStyle(
          color: AppColors.text,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight);
}