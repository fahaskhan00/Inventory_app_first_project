import 'package:flutter/material.dart';

class EmptySalesWidget
    extends StatelessWidget {
  const EmptySalesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "No sales history",

        style: TextStyle(
          color: Colors.grey,
          fontSize: 15,
        ),
      ),
    );
  }
}