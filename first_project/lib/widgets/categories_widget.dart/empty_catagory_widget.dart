import 'package:flutter/material.dart';

class EmptyCategoriesWidget
    extends StatelessWidget {
  const EmptyCategoriesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "No Categories Added",

        style: TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
}