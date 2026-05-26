import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';

class ProductImageSlider
    extends StatelessWidget {
  final List imageList;

  const ProductImageSlider({
    super.key,
    required this.imageList,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,

      child: ListView.separated(
        scrollDirection: Axis.horizontal,

        itemCount: imageList.length,

        separatorBuilder:
            (context, index) =>
                const SizedBox(width: 14),

        itemBuilder: (context, index) {
          return Container(
            width:
                MediaQuery.of(context)
                        .size
                        .width -
                    40,

            decoration: BoxDecoration(
              color: AppColors.lightOrange,

              borderRadius:
                  BorderRadius.circular(
                26,
              ),

              image: DecorationImage(
                image: FileImage(
                  File(
                    imageList[index],
                  ),
                ),

                fit: BoxFit.cover,
              ),

              boxShadow: [
                BoxShadow(
                  color: AppColors.primary
                      .withOpacity(0.08),

                  blurRadius: 14,

                  offset: const Offset(
                    0,
                    6,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}