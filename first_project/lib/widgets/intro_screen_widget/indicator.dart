import 'package:flutter/material.dart';

import 'package:flutter_application_1/colors/app_colors.dart';

class IntroIndicator
    extends StatelessWidget {
  final int currentIndex;

  final int length;

  const IntroIndicator({
    super.key,
    required this.currentIndex,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center,

      children: List.generate(
        length,

        (index) => AnimatedContainer(
          duration:
              const Duration(
                milliseconds: 300,
              ),

          margin:
              const EdgeInsets.all(
                5,
              ),

          width:
              currentIndex == index
                  ? 28
                  : 10,

          height: 10,

          decoration: BoxDecoration(
            color:
                currentIndex == index
                    ? AppColors.primary
                    : Colors.orange
                        .shade100,

            borderRadius:
                BorderRadius.circular(
              20,
            ),
          ),
        ),
      ),
    );
  }
}