import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_application_1/colors/app_colors.dart';

void showImagePickerBottomSheet({
  required BuildContext context,
  required ImagePicker picker,
  required List<File> images,
  required VoidCallback onUpdate,
}) {
  showModalBottomSheet(
    context: context,

    backgroundColor: AppColors.white,

    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24),
      ),
    ),

    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(18),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Container(
              width: 45,
              height: 5,

              decoration: BoxDecoration(
                color: Colors.grey.shade300,

                borderRadius:
                    BorderRadius.circular(20),
              ),
            ),

            const SizedBox(height: 24),

            // CAMERA
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(18),
              ),

              leading: Container(
                padding:
                    const EdgeInsets.all(10),

                decoration: BoxDecoration(
                  color: AppColors.primary
                      .withOpacity(0.10),

                  borderRadius:
                      BorderRadius.circular(
                    14,
                  ),
                ),

                child: const Icon(
                  Icons.camera_alt_outlined,
                  color: AppColors.primary,
                ),
              ),

              title: const Text(
                "Take Photo",

                style: TextStyle(
                  fontWeight:
                      FontWeight.w600,

                  color: AppColors.text,
                ),
              ),

              onTap: () async {
                Navigator.pop(context);

                final picked =
                    await picker.pickImage(
                  source: ImageSource.camera,
                );

                if (picked != null) {
                  images.add(
                    File(picked.path),
                  );

                  onUpdate();
                }
              },
            ),

            const SizedBox(height: 10),

            // GALLERY
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(18),
              ),

              leading: Container(
                padding:
                    const EdgeInsets.all(10),

                decoration: BoxDecoration(
                  color: AppColors.success
                      .withOpacity(0.10),

                  borderRadius:
                      BorderRadius.circular(
                    14,
                  ),
                ),

                child: const Icon(
                  Icons.photo_library_outlined,
                  color: AppColors.success,
                ),
              ),

              title: const Text(
                "Choose From Gallery",

                style: TextStyle(
                  fontWeight:
                      FontWeight.w600,

                  color: AppColors.text,
                ),
              ),

              onTap: () async {
                Navigator.pop(context);

                final picked =
                    await picker.pickMultiImage();

                if (picked.isNotEmpty) {
                  images.addAll(
                    picked.map(
                      (e) => File(e.path),
                    ),
                  );

                  onUpdate();
                }
              },
            ),
          ],
        ),
      );
    },
  );
}