import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_application_1/colors/app_colors.dart';

class EditQuantitySection
    extends StatelessWidget {
  final int quantity;

  final TextEditingController controller;

  final VoidCallback onIncrease;

  final VoidCallback onDecrease;

  final Function(String) onChanged;

  const EditQuantitySection({
    super.key,
    required this.quantity,
    required this.controller,
    required this.onIncrease,
    required this.onDecrease,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        14,
      ),

      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(20),

        color: AppColors.white,

        boxShadow: [
          BoxShadow(
            color: AppColors.primary
                .withOpacity(0.08),

            blurRadius: 14,

            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,

        children: [
          buildTitle(),

          buildControls(),
        ],
      ),
    );
  }

  // TITLE
  Widget buildTitle() {
    return const Text(
      "Quantity",

      style: TextStyle(
        color: AppColors.black,

        fontWeight:
            FontWeight.w600,
      ),
    );
  }

  // CONTROLS
  Widget buildControls() {
    return Row(
      children: [
        if (quantity > 0)
          buildCircleButton(
            Icons.remove,
            onDecrease,
          ),

        const SizedBox(width: 12),

        buildQuantityField(),

        const SizedBox(width: 12),

        buildCircleButton(
          Icons.add,
          onIncrease,

          isPrimary: true,
        ),
      ],
    );
  }

  // QUANTITY FIELD
  Widget buildQuantityField() {
    return SizedBox(
      width: 70,

      child: TextField(
        controller: controller,

        keyboardType:
            TextInputType.number,

        inputFormatters: [
          FilteringTextInputFormatter
              .digitsOnly,
        ],

        textAlign: TextAlign.center,

        maxLength: 4,

        buildCounter: (
          context, {
          required currentLength,
          required isFocused,
          maxLength,
        }) {
          return null;
        },

        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(
            vertical: 10,
          ),

          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(
              14,
            ),

            borderSide: BorderSide(
              color:
                  Colors.grey.shade300,
            ),
          ),
        ),

        onChanged: onChanged,
      ),
    );
  }

  // CIRCLE BUTTON
  Widget buildCircleButton(
    IconData icon,
    VoidCallback onTap, {
    bool isPrimary = false,
  }) {
    return GestureDetector(
      onTap: onTap,

      child: CircleAvatar(
        backgroundColor:
            isPrimary
                ? AppColors.primary
                : AppColors
                    .lightOrange,

        child: Icon(
          icon,

          color:
              isPrimary
                  ? AppColors.white
                  : AppColors.primary,
        ),
      ),
    );
  }
}