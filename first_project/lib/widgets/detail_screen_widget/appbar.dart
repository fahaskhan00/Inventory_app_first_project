import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';

class DetailAppBar
    extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback onEdit;

  final VoidCallback onDelete;

  const DetailAppBar({
    super.key,
    required this.onEdit,
    required this.onDelete,
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

      actions: [
        buildEditButton(),

        buildDeleteButton(),
      ],
    );
  }

  // EDIT BUTTON
  Widget buildEditButton() {
    return IconButton(
      onPressed: onEdit,

      icon: const Icon(
        Icons.edit_outlined,
        color: AppColors.primary,
      ),
    );
  }

  // DELETE BUTTON
  Widget buildDeleteButton() {
    return IconButton(
      onPressed: onDelete,

      icon: const Icon(
        Icons.delete_outline,
        color: AppColors.danger,
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(
        kToolbarHeight,
      );
}