import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget saleItemTile({
  required BuildContext context,
  required dynamic item,
  required int qty,
  required int stock,
  required VoidCallback onRemove,

  required VoidCallback onAdd,
  required VoidCallback onDelete,
  required Function(int) onQtyChanged,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),

    decoration: BoxDecoration(
      color: Colors.white,

      borderRadius: BorderRadius.circular(22),

      boxShadow: [
        BoxShadow(
          color: Colors.orange.withOpacity(0.08),
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
      ],
    ),

    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        /// IMAGE
        Container(
          width: 70,
          height: 70,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),

            color: const Color(0xFFFFF3E8),

            image:
                item.images.isNotEmpty
                    ? DecorationImage(
                      image: FileImage(File(item.images[0])),
                      fit: BoxFit.cover,
                    )
                    : null,
          ),
        ),

        const SizedBox(width: 14),

        /// DETAILS
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                item.name,

                maxLines: 1,
                overflow: TextOverflow.ellipsis,

                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                "₹ ${item.price}",

                style: const TextStyle(
                  color: Color(0xFFFF8C42),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                "Available: $stock",

                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),

              const SizedBox(height: 12),

              /// QTY BUTTONS
              Row(
                children: [
                  qtyBtn(Icons.remove, onRemove),

                  const SizedBox(width: 12),

                  SizedBox(
                    width: 55,

                    height: 38,

                    child: TextFormField(
                      controller: TextEditingController.fromValue(
                        TextEditingValue(
                          text: qty.toString(),

                          selection: TextSelection.collapsed(
                            offset: qty.toString().length,
                          ),
                        ),
                      ),

                      keyboardType: TextInputType.number,

                      textAlign: TextAlign.center,

                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,

                        filled: true,

                        fillColor: const Color(0xFFFFF3E8),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),

                          borderSide: BorderSide.none,
                        ),
                      ),

                      onChanged: (value) {
                        final number = int.tryParse(value);

                        if (number != null) {
                          onQtyChanged(number);
                        }
                      },
                    ),
                  ),

                  const SizedBox(width: 12),

                  if (qty < stock) qtyBtn(Icons.add, onAdd),
                ],
              ),
            ],
          ),
        ),

        /// DELETE BUTTON
        IconButton(
          icon: Icon(Icons.delete_outline, color: Colors.grey.shade500),

          onPressed: onDelete,
        ),
      ],
    ),
  );
}

Widget totalCard({required Widget child}) {
  return Container(
    padding: const EdgeInsets.all(20),

    margin: const EdgeInsets.all(16),

    decoration: BoxDecoration(
      color: Colors.white,

      borderRadius: BorderRadius.circular(24),

      boxShadow: [
        BoxShadow(
          color: Colors.orange.withOpacity(0.08),
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
      ],
    ),

    child: child,
  );
}

Widget qtyBtn(IconData icon, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,

    child: Container(
      width: 34,
      height: 34,

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFB067), Color(0xFFFF8C42)],
        ),

        borderRadius: BorderRadius.circular(10),
      ),

      child: Icon(icon, size: 18, color: Colors.white),
    ),
  );
}
