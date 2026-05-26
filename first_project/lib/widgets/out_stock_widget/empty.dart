import 'package:flutter/material.dart';

class OutStockEmpty
    extends StatelessWidget {
  const OutStockEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "No out of stock items",
      ),
    );
  }
}