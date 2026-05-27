import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_application_1/colors/app_colors.dart';

class QuantitySection extends StatelessWidget {
  final int quantity;

  final TextEditingController controller;

  final VoidCallback onIncrease;

  final VoidCallback onDecrease;

  final Function(String) onChanged;

  const QuantitySection({
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
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 16,
      ),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius:
            BorderRadius.circular(22),

        border: Border.all(
          color: Colors.grey.shade200,
        ),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(0.03),

            blurRadius: 8,

            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  "Quantity",

                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  "Add available stock",

                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // DECREASE BUTTON
          GestureDetector(
            onTap: onDecrease,

            child: Container(
              width: 38,
              height: 38,

              decoration: BoxDecoration(
                color: Colors.grey.shade100,

                borderRadius:
                    BorderRadius.circular(
                  12,
                ),
              ),

              child: const Icon(
                Icons.remove,
              ),
            ),
          ),

          const SizedBox(width: 10),

          // QUANTITY FIELD
          SizedBox(
            width: 70,

            child: TextFormField(
              controller: controller,

              keyboardType:
                  TextInputType.number,

              inputFormatters: [
                FilteringTextInputFormatter
                    .digitsOnly,
              ],

              textAlign: TextAlign.center,

              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(
                  vertical: 10,
                ),

                filled: true,

                fillColor:
                    Colors.grey.shade100,

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    14,
                  ),

                  borderSide:
                      BorderSide.none,
                ),
              ),

              onChanged: (value) {
                if (value.isEmpty) {
                  onChanged("0");

                  return;
                }

                final parsedValue =
                    int.tryParse(value);

                if (parsedValue != null) {
                  onChanged(
                    parsedValue.toString(),
                  );
                }
              },
            ),
          ),

          const SizedBox(width: 10),

          // INCREASE BUTTON
          GestureDetector(
            onTap: onIncrease,

            child: Container(
              width: 38,
              height: 38,

              decoration: BoxDecoration(
                color: AppColors.primary
                    .withOpacity(0.12),

                borderRadius:
                    BorderRadius.circular(
                  12,
                ),
              ),

              child: const Icon(
                Icons.add,

                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}