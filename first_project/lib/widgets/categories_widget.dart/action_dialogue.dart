import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';

class CategoryActionDialog
    extends StatelessWidget {
  final VoidCallback onEdit;

  final VoidCallback onDelete;

  const CategoryActionDialog({
    super.key,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor:
          AppColors.transparent,

      child: Container(
        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(
          color: AppColors.white,

          borderRadius:
              BorderRadius.circular(26),

          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.08),

              blurRadius: 20,

              offset: const Offset(0, 8),
            ),
          ],
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            buildTopBar(),

            const SizedBox(height: 22),

            buildEditButton(),

            const SizedBox(height: 14),

            buildDeleteButton(),
          ],
        ),
      ),
    );
  }

  // TOP BAR
  Widget buildTopBar() {
    return Container(
      width: 45,
      height: 5,

      decoration: BoxDecoration(
        color: Colors.grey.shade300,

        borderRadius:
            BorderRadius.circular(20),
      ),
    );
  }

  // EDIT BUTTON
  Widget buildEditButton() {
    return InkWell(
      borderRadius:
          BorderRadius.circular(18),

      onTap: onEdit,

      child: Container(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),

        decoration: BoxDecoration(
          color:
              Colors.teal.withOpacity(0.08),

          borderRadius:
              BorderRadius.circular(18),
        ),

        child: const Row(
          children: [
            Icon(
              Icons.edit_rounded,
              color: Colors.teal,
            ),

            SizedBox(width: 14),

            Text(
              "Edit Category",

              style: TextStyle(
                fontWeight:
                    FontWeight.w600,
                fontSize: 15,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // DELETE BUTTON
  Widget buildDeleteButton() {
    return InkWell(
      borderRadius:
          BorderRadius.circular(18),

      onTap: onDelete,

      child: Container(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),

        decoration: BoxDecoration(
          color:
              Colors.red.withOpacity(0.08),

          borderRadius:
              BorderRadius.circular(18),
        ),

        child: const Row(
          children: [
            Icon(
              Icons.delete_rounded,
              color: Colors.redAccent,
            ),

            SizedBox(width: 14),

            Text(
              "Delete Category",

              style: TextStyle(
                fontWeight:
                    FontWeight.w600,
                fontSize: 15,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}