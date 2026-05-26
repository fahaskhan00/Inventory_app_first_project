import 'package:flutter/material.dart';

class DetailTile
    extends StatelessWidget {
  final IconData icon;

  final String title;

  final String value;

  const DetailTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        Container(
          width: 44,
          height: 44,

          decoration: BoxDecoration(
            color: const Color(
              0xFFFFF3E8,
            ),

            borderRadius:
                BorderRadius.circular(
              14,
            ),
          ),

          child: Icon(
            icon,

            color: const Color(
              0xFFFF8C42,
            ),

            size: 20,
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [
              Text(
                title,

                style: TextStyle(
                  color:
                      Colors
                          .grey
                          .shade600,

                  fontSize: 13,
                ),
              ),

              const SizedBox(
                height: 4,
              ),

              Text(
                value,

                style: const TextStyle(
                  color: Colors.black,

                  fontWeight:
                      FontWeight.w600,

                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}