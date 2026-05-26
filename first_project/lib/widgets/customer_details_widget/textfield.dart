import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_application_1/colors/app_colors.dart';

class CustomerTextField
    extends StatelessWidget {
  final TextEditingController
  controller;

  final String hint;

  final IconData icon;

  final int maxLines;

  final TextInputType?
  keyboardType;

  final List<TextInputFormatter>?
  inputFormatters;

  final String? Function(String?)?
  validator;

  const CustomerTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.maxLines = 1,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,

      maxLines: maxLines,

      keyboardType: keyboardType,

      inputFormatters:
          inputFormatters,

      validator:
          validator ??
          (value) {
            if (value == null ||
                value.isEmpty) {
              return "Required field";
            }

            return null;
          },

      decoration: InputDecoration(
        labelText: hint,

        hintText: hint,

        labelStyle:
            const TextStyle(
          color: AppColors.primary,
          fontWeight:
              FontWeight.w600,
        ),

        prefixIcon: Icon(
          icon,
          color: AppColors.primary,
        ),

        filled: true,

        fillColor:
            AppColors.white,

        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            18,
          ),

          borderSide:
              BorderSide.none,
        ),

        enabledBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            18,
          ),

          borderSide:
              BorderSide.none,
        ),

        focusedBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            18,
          ),

          borderSide:
              const BorderSide(
            color:
                AppColors.primary,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}