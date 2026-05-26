import 'package:flutter/material.dart';

import 'package:flutter_application_1/colors/app_colors.dart';

class SkipButton
    extends StatelessWidget {
  final VoidCallback onTap;

  const SkipButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),

      child: Align(
        alignment:
            Alignment.topRight,

        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,

            borderRadius:
                BorderRadius.circular(
              30,
            ),

            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(0.08),

                blurRadius: 10,
              ),
            ],
          ),

          child: TextButton(
            onPressed: onTap,

            child: const Text(
              "SKIP",

              style: TextStyle(
                color:
                    AppColors.primary,

                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}