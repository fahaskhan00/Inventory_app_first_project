import 'package:flutter/material.dart';

Widget summaryRow(
  String title,
  double value,
) {
  return Row(
    mainAxisAlignment:
        MainAxisAlignment
            .spaceBetween,

    children: [
      Text(
        title,

        style: TextStyle(
          color:
              Colors.grey.shade600,

          fontWeight:
              FontWeight.w500,

          fontSize: 14,
        ),
      ),

      Text(
        "₹ ${value.toStringAsFixed(0)}",

        style: const TextStyle(
          color: Colors.black,

          fontWeight:
              FontWeight.w600,

          fontSize: 15,
        ),
      ),
    ],
  );
}