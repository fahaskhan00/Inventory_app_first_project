import 'package:flutter/material.dart';

import 'package:flutter_application_1/models/sales_model.dart';

import '../sales_widget.dart';

class RecentSaleTile
    extends StatelessWidget {
  final SalesModel sale;

  final int index;

  final VoidCallback onTap;

  const RecentSaleTile({
    super.key,
    required this.sale,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: glassContainer(
        margin: const EdgeInsets.only(
          bottom: 14,
        ),

        child: Row(
          children: [
            Container(
              padding:
                  const EdgeInsets.all(
                12,
              ),

              decoration: BoxDecoration(
                color: const Color(
                  0xFFFFF3E8,
                ),

                borderRadius:
                    BorderRadius.circular(
                  16,
                ),
              ),

              child: const Icon(
                Icons
                    .shopping_bag_rounded,

                color: Color(
                  0xFFFF8C42,
                ),
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
                    "Sale ${index + 1}",

                    style:
                        const TextStyle(
                          color:
                              Colors.black,

                          fontWeight:
                              FontWeight
                                  .bold,

                          fontSize: 16,
                        ),
                  ),

                  const SizedBox(
                    height: 6,
                  ),

                  Text(
                    "${sale.items.length} items",

                    style:
                        const TextStyle(
                          color:
                              Colors.grey,

                          fontSize: 13,
                        ),
                  ),
                ],
              ),
            ),

            Text(
              "₹ ${sale.total}",

              style: const TextStyle(
                color: Color(
                  0xFFFF8C42,
                ),

                fontWeight:
                    FontWeight.bold,

                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}