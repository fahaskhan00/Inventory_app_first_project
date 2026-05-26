import 'dart:io';

import 'package:flutter/material.dart';

class EditImagePreview
    extends StatelessWidget {
  final File image;

  final VoidCallback onRemove;

  const EditImagePreview({
    super.key,
    required this.image,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 70,

          height: 70,

          margin:
              const EdgeInsets.only(
            right: 8,
          ),

          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(
              12,
            ),

            image: DecorationImage(
              image: FileImage(image),

              fit: BoxFit.cover,
            ),
          ),
        ),

        Positioned(
          top: 2,

          right: 10,

          child: GestureDetector(
            onTap: onRemove,

            child: Container(
              padding:
                  const EdgeInsets.all(3),

              decoration:
                  const BoxDecoration(
                color: Colors.black54,

                shape: BoxShape.circle,
              ),

              child: const Icon(
                Icons.close,

                size: 14,

                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}