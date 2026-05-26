import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';

class ImagePreviewList
    extends StatelessWidget {
  final List<File> images;

  final Function(int) onRemove;

  const ImagePreviewList({
    super.key,
    required this.images,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95,

      child: ListView.separated(
        scrollDirection: Axis.horizontal,

        itemCount: images.length,

        separatorBuilder: (_, __) =>
            const SizedBox(width: 12),

        itemBuilder: (context, index) {
          return Stack(
            clipBehavior: Clip.none,

            children: [
              Container(
                width: 95,
                height: 95,

                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(18),

                  border: Border.all(
                    color: Colors.grey.shade200,
                  ),

                  image: DecorationImage(
                    image:
                        FileImage(images[index]),

                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Positioned(
                top: -8,
                right: -8,

                child: GestureDetector(
                  onTap: () {
                    onRemove(index);
                  },

                  child: Container(
                    padding:
                        const EdgeInsets.all(6),

                    decoration:
                        const BoxDecoration(
                      color: AppColors.danger,
                      shape: BoxShape.circle,
                    ),

                    child: const Icon(
                      Icons.close,
                      color: AppColors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}