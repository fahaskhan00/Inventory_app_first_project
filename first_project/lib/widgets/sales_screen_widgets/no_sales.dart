import 'package:flutter/material.dart';

import '../sales_widget.dart';

class NoSalesWidget
    extends StatelessWidget {
  const NoSalesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return glassContainer(
      child: const Padding(
        padding:
            EdgeInsets.symmetric(
          vertical: 18,
        ),

        child: Center(
          child: Text(
            "No sales today",

            style: TextStyle(
              color: Colors.grey,

              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}