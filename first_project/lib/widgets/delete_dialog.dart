import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final VoidCallback onDelete;

  const DeleteDialog({
    super.key,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Delete Item"),
      content: Text("Are you sure you want to delete this item?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            onDelete();
            Navigator.pop(context);
          },
          child: Text(
            "Delete",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}