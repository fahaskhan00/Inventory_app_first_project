import 'package:flutter/material.dart';

class CategoryTextField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSubmit;

  const CategoryTextField({
    super.key,
    required this.controller,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,

      autofocus: true,

      onSubmitted: (_) => onSubmit(),

      style: const TextStyle(color: Colors.black),

      decoration: InputDecoration(
        labelText: "Category Name",

        labelStyle: TextStyle(color: Colors.grey.shade600),

        filled: true,

        fillColor: const Color(0xFFFFF8F2),

        prefixIcon: const Icon(
          Icons.edit_rounded,
          color: Color(0xFFFF8C42),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),

          borderSide: BorderSide(
            color: Colors.orange.withOpacity(0.15),
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),

          borderSide: const BorderSide(
            color: Color(0xFFFF8C42),
            width: 2,
          ),
        ),
      ),
    );
  }
}