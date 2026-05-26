import 'package:flutter/material.dart';

class SalesFloatingButton
    extends StatelessWidget {
  final VoidCallback onTap;

  const SalesFloatingButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor:
          const Color(
            0xFFFF8C42,
          ),

      elevation: 4,

      shape:
          RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
                  18,
                ),
          ),

      onPressed: onTap,

      icon: const Icon(
        Icons.add,

        color: Colors.white,
      ),

      label: const Text(
        "Add Sale",

        style: TextStyle(
          color: Colors.white,

          fontWeight:
              FontWeight.bold,
        ),
      ),
    );
  }
}