import 'package:flutter/material.dart';

void showEmptyItemSnackBar(
  BuildContext context,
) {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(
    const SnackBar(
      content: Text(
        "Please add items",
      ),

      backgroundColor:
          Colors.red,
    ),
  );
}