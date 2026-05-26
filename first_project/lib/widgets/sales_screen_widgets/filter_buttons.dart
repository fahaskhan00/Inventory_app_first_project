import 'package:flutter/material.dart';

class SalesFilterButtons
    extends StatelessWidget {
  final VoidCallback onTap;

  const SalesFilterButtons({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 12,
          ),

          decoration: BoxDecoration(
            color: const Color(
              0xFFFF8C42,
            ),

            borderRadius:
                BorderRadius.circular(
              30,
            ),
          ),

          child: const Text(
            "Recent",

            style: TextStyle(
              color: Colors.white,

              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(
          width: 12,
        ),

        GestureDetector(
          onTap: onTap,

          child: Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 12,
            ),

            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius:
                  BorderRadius.circular(
                30,
              ),

              border: Border.all(
                color: const Color(
                  0xFFFF8C42,
                ),
              ),
            ),

            child: const Text(
              "All Sales",

              style: TextStyle(
                color: Color(
                  0xFFFF8C42,
                ),

                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}