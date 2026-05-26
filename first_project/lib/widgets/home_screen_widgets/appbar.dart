import 'package:flutter/material.dart';

import 'package:flutter_application_1/colors/app_colors.dart';

class HomeAppBar
    extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment
              .spaceBetween,

      children: [
        Row(
          children: [
            Container(
              padding:
                  const EdgeInsets.all(
                10,
              ),

              decoration: BoxDecoration(
                color: AppColors.primary
                    .withOpacity(0.1),

                borderRadius:
                    BorderRadius.circular(
                  14,
                ),
              ),

              child: const Icon(
                Icons
                    .inventory_2_outlined,

                color:
                    AppColors.primary,
              ),
            ),

            const SizedBox(width: 12),

            const Text(
              "MyInventory",

              style: TextStyle(
                fontSize: 24,

                fontWeight:
                    FontWeight.bold,

                color:
                    AppColors.text,
              ),
            ),
          ],
        ),
      ],
    );
  }
}