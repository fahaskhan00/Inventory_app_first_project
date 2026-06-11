import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductImageSlider
    extends StatefulWidget {
  final List imageList;

  const ProductImageSlider({
    super.key,
    required this.imageList,
  });

  @override
  State<ProductImageSlider> createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  int currentIndex = 0;
@override
Widget build(BuildContext context) {
  return Column(
    children: [
      CarouselSlider(
        options: CarouselOptions(
          height: 260,
          viewportFraction: 1,
          enlargeCenterPage: true,
          onPageChanged: (index, reason) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
        items: widget.imageList.map((image) {
          return Container(
            width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
              color: AppColors.lightOrange,
              borderRadius: BorderRadius.circular(26),
              image: DecorationImage(
                image: FileImage(
                  File(image),
                ),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.08),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
          );
        }).toList(),
      ),

      const SizedBox(height: 12),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.imageList.asMap().entries.map((entry) {
          return Container(
            width: currentIndex == entry.key ? 12 : 8,
            height: currentIndex == entry.key ? 12 : 8,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentIndex == entry.key
                  ? AppColors.primary
                  : Colors.grey.shade400,
            ),
          );
        }).toList(),
      ),
    ],
  );
}
}