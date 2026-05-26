import 'package:flutter/material.dart';

class LowStockEmpty
    extends StatelessWidget {
  const LowStockEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "No low stock items",
      ),
    );
  }
}