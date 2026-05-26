import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_application_1/colors/app_colors.dart';
import 'package:flutter_application_1/widgets/edit_screen_widget/image_preview.dart';

class EditImageSection
    extends StatelessWidget {
  final List<File> images;

  final VoidCallback onTap;

  final Function(int) onRemove;

  const EditImageSection({
    super.key,
    required this.images,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        width: double.infinity,

        padding: const EdgeInsets.all(
          10,
        ),

        margin: const EdgeInsets.all(
          10,
        ),

        decoration: BoxDecoration(
          color: AppColors.white,

          borderRadius:
              BorderRadius.circular(22),

          boxShadow: [
            BoxShadow(
              color: AppColors.primary
                  .withOpacity(0.08),

              blurRadius: 14,

              offset: const Offset(0, 6),
            ),
          ],
        ),

        child: Column(
          children: [
            buildMainImage(),

            const SizedBox(height: 10),

            buildImagePreview(),

            const SizedBox(height: 8),

            buildBottomText(),
          ],
        ),
      ),
    );
  }

  // MAIN IMAGE
  Widget buildMainImage() {
    return Container(
      height: 180,

      width: double.infinity,

      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(18),

        color: AppColors.lightOrange,
      ),

      child:
          images.isEmpty
              ? const Center(
                child: Icon(
                  Icons.image,

                  size: 40,

                  color: AppColors.primary,
                ),
              )
              : ClipRRect(
                borderRadius:
                    BorderRadius.circular(
                  18,
                ),

                child: Image.file(
                  images.last,

                  fit: BoxFit.cover,

                  width: double.infinity,
                ),
              ),
    );
  }

  // IMAGE PREVIEW
  Widget buildImagePreview() {
    if (images.isEmpty) {
      return const SizedBox();
    }

    return SizedBox(
      height: 80,

      child: ListView.builder(
        scrollDirection:
            Axis.horizontal,

        itemCount: images.length,

        itemBuilder: (
          context,
          index,
        ) {
          return EditImagePreview(
            image: images[index],

            onRemove: () {
              onRemove(index);
            },
          );
        },
      ),
    );
  }

  // BOTTOM TEXT
  Widget buildBottomText() {
    return Text(
      "Tap to add images",

      style: TextStyle(
        color: Colors.grey.shade700,
      ),
    );
  }
}