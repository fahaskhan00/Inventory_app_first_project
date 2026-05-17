import 'package:flutter/material.dart';

Widget dragHandle() {
  return Container(
    height: 5,
    width: 50,

    decoration: BoxDecoration(
      color: Colors.grey.shade300,

      borderRadius:
          BorderRadius.circular(10),
    ),
  );
}

Widget header({
  required VoidCallback onClose,
}) {
  return Row(
    mainAxisAlignment:
        MainAxisAlignment.spaceBetween,

    children: [

      const SizedBox(width: 20),

      const Text(
        "Filter Items",

        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.black,
        ),
      ),

      GestureDetector(
        onTap: onClose,

        child: const Icon(
          Icons.close,
          color: Colors.black,
        ),
      ),
    ],
  );
}

Widget sectionTitle(String text) {
  return Padding(
    padding:
        const EdgeInsets.only(bottom: 12),

    child: Text(
      text,

      style: TextStyle(
        fontSize: 13,
        color: Colors.grey.shade700,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget chipWrap({
  required List<String> list,
  required int selectedIndex,
  required Function(int) onTap,
}) {
  return Wrap(
    spacing: 10,
    runSpacing: 10,

    children: List.generate(
      list.length,

      (index) {

        final isSelected =
            selectedIndex == index;

        return GestureDetector(
          onTap: () => onTap(index),

          child: Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),

            decoration: BoxDecoration(

              color:
                  isSelected
                      ? const Color(
                        0xFFFF8C42,
                      )
                      : Colors.white,

              borderRadius:
                  BorderRadius.circular(
                22,
              ),

              border: Border.all(
                color:
                    isSelected
                        ? const Color(
                          0xFFFF8C42,
                        )
                        : Colors.grey.shade300,
              ),

              boxShadow: [
                BoxShadow(
                  color: Colors.orange
                      .withOpacity(0.06),

                  blurRadius: 8,

                  offset:
                      const Offset(0, 3),
                ),
              ],
            ),

            child: Text(
              list[index],

              style: TextStyle(
                color:
                    isSelected
                        ? Colors.white
                        : Colors.black,

                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ),
        );
      },
    ),
  );
}