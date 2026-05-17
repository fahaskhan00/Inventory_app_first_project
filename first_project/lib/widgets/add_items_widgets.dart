import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/colors/app_colors.dart';

/// =====================
/// IMAGE PICKER BOX
/// =====================
Widget imagePickerBox({
  required List<File> images,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,

    child: Container(
      height: 190,
      width: double.infinity,

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(24),

        border: Border.all(
          color: Colors.grey.shade200,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
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
                      const EdgeInsets.all(18),

                  decoration: BoxDecoration(
                    color: AppColors.primary
                        .withOpacity(0.10),

                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.camera_alt_outlined,
                    size: 34,
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(height: 14),

                const Text(
                  "Upload Product Images",

                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.w700,

                    color: AppColors.text,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  "Tap here to choose images",

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
                  const EdgeInsets.all(12),

              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(
                    right: 12,
                  ),

                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(
                            18),

                    child: Image.file(
                      images[index],

                      width: 135,
                      height: 135,

                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
    ),
  );
}

/// =====================
/// PREMIUM FIELD
/// =====================
Widget premiumField(
  String hint,
  TextEditingController controller,
  IconData icon, {
  bool isNumber = false,
}) {
  return Container(
    padding:
        const EdgeInsets.symmetric(
      horizontal: 16,
    ),

    decoration: BoxDecoration(
      color: Colors.white,

      borderRadius:
          BorderRadius.circular(20),

      border: Border.all(
        color: Colors.grey.shade200,
      ),

      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),

    child: TextField(
      controller: controller,

      style: const TextStyle(
        color: AppColors.text,
        fontWeight: FontWeight.w500,
      ),

      keyboardType: isNumber
          ? TextInputType.number
          : TextInputType.text,

      inputFormatters: isNumber
          ? [
              FilteringTextInputFormatter
                  .digitsOnly,
            ]
          : null,

      decoration: InputDecoration(
        border: InputBorder.none,

        prefixIcon: Container(
          margin:
              const EdgeInsets.only(
            right: 10,
          ),

          child: Icon(
            icon,
            color: AppColors.primary,
          ),
        ),

        hintText: hint,

        hintStyle: const TextStyle(
          color: AppColors.subtitle,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  );
}

/// =====================
/// QUANTITY BOX
/// =====================
Widget quantityBox({
  required int quantity,
  required VoidCallback onMinus,
  required VoidCallback onPlus,
}) {
  return Container(
    padding: const EdgeInsets.all(16),

    decoration: BoxDecoration(
      color: Colors.white,

      borderRadius:
          BorderRadius.circular(20),

      border: Border.all(
        color: Colors.grey.shade200,
      ),

      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),

    child: Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,

      children: [

        Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: const [

            Text(
              "Quantity",

              style: TextStyle(
                fontSize: 15,
                fontWeight:
                    FontWeight.w700,

                color: AppColors.text,
              ),
            ),

            SizedBox(height: 4),

            Text(
              "Manage stock quantity",

              style: TextStyle(
                fontSize: 12,
                color: AppColors.subtitle,
              ),
            ),
          ],
        ),

        Row(
          children: [

            circleBtn(
              Icons.remove_rounded,
              onMinus,
            ),

            Container(
              margin:
                  const EdgeInsets.symmetric(
                horizontal: 14,
              ),

              padding:
                  const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),

              decoration: BoxDecoration(
                color: Colors.grey.shade100,

                borderRadius:
                    BorderRadius.circular(
                        14),
              ),

              child: Text(
                "$quantity",

                style: const TextStyle(
                  fontSize: 16,
                  fontWeight:
                      FontWeight.w700,

                  color: AppColors.text,
                ),
              ),
            ),

            circleBtn(
              Icons.add_rounded,
              onPlus,
              isPrimary: true,
            ),
          ],
        ),
      ],
    ),
  );
}

/// =====================
/// NOTES BOX
/// =====================
Widget notesBox(
  TextEditingController controller,
) {
  return Container(
    padding: const EdgeInsets.all(18),

    decoration: BoxDecoration(
      color: Colors.white,

      borderRadius:
          BorderRadius.circular(20),

      border: Border.all(
        color: Colors.grey.shade200,
      ),

      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),

    child: TextField(
      controller: controller,

      maxLines: 4,

      style: const TextStyle(
        color: AppColors.text,
      ),

      decoration: const InputDecoration(
        border: InputBorder.none,

        hintText:
            "Add additional details...",

        hintStyle: TextStyle(
          color: AppColors.subtitle,
        ),
      ),
    ),
  );
}

/// =====================
/// CIRCLE BUTTON
/// =====================
Widget circleBtn(
  IconData icon,
  VoidCallback onTap, {
  bool isPrimary = false,
}) {
  return GestureDetector(
    onTap: onTap,

    child: Container(
      width: 42,
      height: 42,

      decoration: BoxDecoration(
        color: isPrimary
            ? AppColors.primary
            : Colors.grey.shade100,

        shape: BoxShape.circle,
      ),

      child: Icon(
        icon,

        size: 20,

        color: isPrimary
            ? Colors.white
            : AppColors.text,
      ),
    ),
  );
}