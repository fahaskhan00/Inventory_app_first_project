import 'package:flutter/material.dart';

import 'package:flutter_application_1/colors/app_colors.dart';

class IntroNextButton
    extends StatelessWidget {
  final String text;

  final VoidCallback onTap;

  const IntroNextButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 24,
      ),

      child: SizedBox(
        width: double.infinity,

        height: 58,

        child: ElevatedButton(
          onPressed: onTap,

          style:
              ElevatedButton.styleFrom(
                elevation: 10,

                shadowColor:
                    Colors.orange
                        .withOpacity(
                          0.4,
                        ),

                backgroundColor:
                    AppColors.primary,

                foregroundColor:
                    AppColors.white,

                shape:
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                            18,
                          ),
                    ),
              ),

          child: Text(
            text,

            style: const TextStyle(
              fontSize: 17,

              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}