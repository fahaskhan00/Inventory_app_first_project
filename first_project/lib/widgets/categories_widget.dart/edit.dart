import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';

class EditCategoryDialog
    extends StatelessWidget {
  final TextEditingController controller;

  final VoidCallback onSave;

  const EditCategoryDialog({
    super.key,
    required this.controller,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:
          AppColors.text,

      title: const Text(
        "Edit Category",

        style: TextStyle(
          color: AppColors.white,
        ),
      ),

      content: TextField(
        controller: controller,

        style: const TextStyle(
          color: AppColors.white,
        ),

        decoration: const InputDecoration(
          hintText:
              "Enter new category name",

          hintStyle: TextStyle(
            color: Colors.white70,
          ),
        ),
      ),

      actions: [
        buildCancelButton(context),

        buildSaveButton(),
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

  // SAVE BUTTON
  Widget buildSaveButton() {
    return TextButton(
      onPressed: onSave,

      child: const Text(
        "Save",

        style: TextStyle(
          color: Colors.tealAccent,
        ),
      ),
    );
  }
}