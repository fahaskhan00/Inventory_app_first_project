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

    backgroundColor:
        AppColors.white,

    shape:
        const RoundedRectangleBorder(
      borderRadius:
          BorderRadius.vertical(
        top: Radius.circular(24),
      ),
    ),

    builder: (context) {
      return SafeArea(
        child: Wrap(
          children: [
            buildGalleryTile(
              context,
              picker,
              images,
              onUpdate,
            ),

            buildCameraTile(
              context,
              picker,
              images,
              onUpdate,
            ),
          ],
        ),
      );
    },
  );
}

// GALLERY TILE
Widget buildGalleryTile(
  BuildContext context,
  ImagePicker picker,
  List<File> images,
  VoidCallback onUpdate,
) {
  return ListTile(
    leading: const Icon(
      Icons.photo_library,

      color: AppColors.primary,
    ),

    title: const Text(
      "Gallery",

      style: TextStyle(
        color: AppColors.black,
      ),
    ),

    onTap: () async {
      Navigator.pop(context);

      final pickedFiles =
          await picker.pickMultiImage();

      if (pickedFiles.isNotEmpty) {
        images.addAll(
          pickedFiles.map(
            (e) => File(e.path),
          ),
        );

        onUpdate();
      }
    },
  );
}

// CAMERA TILE
Widget buildCameraTile(
  BuildContext context,
  ImagePicker picker,
  List<File> images,
  VoidCallback onUpdate,
) {
  return ListTile(
    leading: const Icon(
      Icons.camera_alt,

      color: AppColors.primary,
    ),

    title: const Text(
      "Camera",

      style: TextStyle(
        color: AppColors.black,
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
  );
}