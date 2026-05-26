import 'package:flutter/material.dart';

import 'package:flutter_application_1/colors/app_colors.dart';

class IntroBackground
    extends StatelessWidget {
  const IntroBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -120,
          left: -50,

          child: Container(
            height: 320,
            width: 320,

            decoration: const BoxDecoration(
              shape: BoxShape.circle,

              gradient: LinearGradient(
                colors: [
                  AppColors.secondary,
                  AppColors.primary,
                ],

                begin:
                    Alignment.topLeft,

                end:
                    Alignment
                        .bottomRight,
              ),
            ),
          ),
        ),

        Positioned(
          top: -160,
          right: -80,

          child: Container(
            height: 280,
            width: 280,

            decoration: BoxDecoration(
              shape: BoxShape.circle,

              color: Colors.orange
                  .withOpacity(0.15),
            ),
          ),
        ),
      ],
    );
  }
}