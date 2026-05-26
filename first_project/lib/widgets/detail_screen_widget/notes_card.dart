import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';

class NotesCard
    extends StatelessWidget {
  final String notes;

  const NotesCard({
    super.key,
    required this.notes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(
        20,
      ),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius:
            BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: AppColors.primary
                .withOpacity(0.08),

            blurRadius: 14,

            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          buildTitle(),

          const SizedBox(height: 12),

          buildNotesText(),
        ],
      ),
    );
  }

  // TITLE
  Widget buildTitle() {
    return const Text(
      "Notes",

      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      ),
    );
  }

  // NOTES TEXT
  Widget buildNotesText() {
    return Text(
      notes.trim().isEmpty
          ? "No notes added"
          : notes,

      style: TextStyle(
        color: Colors.grey.shade700,
        height: 1.5,
      ),
    );
  }
}