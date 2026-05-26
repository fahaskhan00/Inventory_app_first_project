import 'package:flutter/material.dart';

class AddCategoryButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddCategoryButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,

      child: InkWell(
        onTap: onTap,

        borderRadius: BorderRadius.circular(50),

        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFFFFB067),
                Color(0xFFFF8C42),
              ],
            ),

            borderRadius: BorderRadius.circular(50),

            boxShadow: [
              BoxShadow(
                color: Colors.orange.withOpacity(0.20),

                blurRadius: 12,

                offset: const Offset(0, 5),
              ),
            ],
          ),

          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 14,
            ),

            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,

              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 12,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(40),

                    border: Border.all(
                      color: const Color.fromARGB(
                        255,
                        218,
                        109,
                        8,
                      ),

                      width: 1.5,
                    ),
                  ),

                  child: const Row(
                    mainAxisSize:
                        MainAxisSize.min,

                    children: [
                      Icon(
                        Icons.add,
                        color: Color(0xFFFF8C42),
                      ),

                      SizedBox(width: 8),

                      Text(
                        "Add new category",

                        style: TextStyle(
                          color:
                              Color(0xFFFF8C42),

                          fontSize: 16,

                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}