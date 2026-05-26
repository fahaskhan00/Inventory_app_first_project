import 'package:flutter/material.dart';

class SoldProductHeader
    extends StatelessWidget {
  final int itemCount;

  const SoldProductHeader({
    super.key,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment
              .spaceBetween,

      children: [
        const Text(
          "Sold Products",

          style: TextStyle(
            color: Colors.black,

            fontWeight:
                FontWeight.bold,

            fontSize: 20,
          ),
        ),

        Container(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8,
          ),

          decoration: BoxDecoration(
            color: const Color(
              0xFFFFF3E8,
            ),

            borderRadius:
                BorderRadius.circular(
              30,
            ),
          ),

          child: Text(
            "$itemCount Items",

            style: const TextStyle(
              color: Color(
                0xFFFF8C42,
              ),

              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}