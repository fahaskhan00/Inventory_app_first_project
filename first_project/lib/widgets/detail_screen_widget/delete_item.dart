import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';

class DeleteItemDialog
    extends StatelessWidget {
  final VoidCallback onDelete;

  const DeleteItemDialog({
    super.key,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:
          AppColors.white,

      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(22),
      ),

      title: const Text(
        "Delete Item",

        style: TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
      ),

      content: Text(
        "Are you sure you want to delete this item?",

        style: TextStyle(
          color: Colors.grey.shade700,
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

      child: Text(
        "Cancel",

        style: TextStyle(
          color: Colors.grey.shade700,
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
          color: AppColors.danger,
        ),
      ),
    );
  }
}