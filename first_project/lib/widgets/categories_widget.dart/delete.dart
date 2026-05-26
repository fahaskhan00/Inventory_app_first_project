import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';

class DeleteCategoryDialog
    extends StatelessWidget {
  final VoidCallback onDelete;

  const DeleteCategoryDialog({
    super.key,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:
          AppColors.text,

      title: const Text(
        "Delete Category",

        style: TextStyle(
          color: AppColors.white,
        ),
      ),

      content: const Text(
        "Are you sure you want to delete this category?",

        style: TextStyle(
          color: Colors.white70,
        ),
      ),

      actions: [
        buildCancelButton(context),

        buildDeleteButton(),
      ],
    );
  }

  // CANCEL BUTTON
  Widget buildCancelButton(
    BuildContext context,
  ) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },

      child: const Text(
        "Cancel",

        style: TextStyle(
          color: Colors.white70,
        ),
      ),
    );
  }

  // DELETE BUTTON
  Widget buildDeleteButton() {
    return TextButton(
      onPressed: onDelete,

      child: const Text(
        "Delete",

        style: TextStyle(
          color: Colors.redAccent,
        ),
      ),
    );
  }
}