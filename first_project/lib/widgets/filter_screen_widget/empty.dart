import 'package:flutter/material.dart';

class EmptyCategoryText
    extends StatelessWidget {
  const EmptyCategoryText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      "No categories found",

      style: TextStyle(
        color: Colors.grey,
      ),
    );
  }
}