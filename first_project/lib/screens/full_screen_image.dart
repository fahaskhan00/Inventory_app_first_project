import 'dart:io';

import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final String imagePath;

  const FullScreenImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(backgroundColor: Colors.black,
      iconTheme: const IconThemeData(
    color: Colors.white,
  ),
),

      body: Center(
        child: InteractiveViewer(
          minScale: 1,
          maxScale: 5,

          child: Image.file(File(imagePath), fit: BoxFit.contain),
        ),
      ),
    );
  }
}
