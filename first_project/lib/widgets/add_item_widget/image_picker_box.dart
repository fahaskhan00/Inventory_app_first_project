import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';

Widget imagePickerBox({
  required List<File> images,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,

    child: Container(
      width: double.infinity,
      height: 210,

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(28),

        border: Border.all(
          color: Colors.grey.shade200,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: images.isEmpty
          ? Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,

              children: [

                Container(
                  padding:
                      const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: AppColors.primary
                        .withOpacity(0.10),

                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.cloud_upload_outlined,
                    size: 38,
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(height: 18),

                const Text(
                  "Upload Product Images",

                  style: TextStyle(
                    fontSize: 17,
                    fontWeight:
                        FontWeight.w700,
                    color: AppColors.text,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  "Tap here to select product photos",

                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.subtitle,
                  ),
                ),
              ],
            )
          : ListView.builder(
              scrollDirection:
                  Axis.horizontal,

              itemCount: images.length,

              padding:
                  const EdgeInsets.all(14),

              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(
                    right: 14,
                  ),

                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(
                            22),

                    child: Image.file(
                      images[index],
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
    ),
  );
}