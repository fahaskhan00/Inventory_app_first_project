import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class SalesTotalCard
    extends StatelessWidget {
  final Map<String, dynamic>
  sale;

  final List items;

  const SalesTotalCard({
    super.key,
    required this.sale,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(
        24,
      ),

      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(
          28,
        ),

        gradient:
            const LinearGradient(
              begin:
                  Alignment.topLeft,

              end:
                  Alignment
                      .bottomRight,

              colors: [
                Color.fromARGB(
                  255,
                  0,
                  0,
                  0,
                ),

                Color.fromARGB(
                  255,
                  72,
                  50,
                  36,
                ),
              ],
            ),

        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(
              255,
              0,
              0,
              0,
            ).withOpacity(0.22),

            blurRadius: 18,

            offset: const Offset(
              0,
              8,
            ),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          buildTopRow(),

          const SizedBox(
            height: 18,
          ),

          buildQuantityTag(),

          const SizedBox(
            height: 18,
          ),

          const Text(
            "Total Amount",

            style: TextStyle(
              color: Colors.white70,

              fontSize: 14,

              fontWeight:
                  FontWeight.w500,
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          Text(
            "₹ ${sale['total']}",

            style: const TextStyle(
              color: Colors.white,

              fontSize: 34,

              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // TOP ROW
  Widget buildTopRow() {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment
              .spaceBetween,

      children: [
        Container(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8,
          ),

          decoration: BoxDecoration(
            color: Colors.white24,

            borderRadius:
                BorderRadius.circular(
              30,
            ),
          ),

          child: const Row(
            children: [
              Icon(
                Icons.receipt_long,

                color: Colors.white,

                size: 18,
              ),

              SizedBox(width: 8),

              Text(
                "Invoice",

                style: TextStyle(
                  color: Colors.white,

                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        Text(
          sale['date'] != null
              ? DateFormat(
                'dd-MMM-yyyy',
              ).format(
                DateTime.parse(
                  sale['date'],
                ),
              )
              : "",

          style: const TextStyle(
            color: Colors.white70,

            fontSize: 11,
          ),
        ),
      ],
    );
  }

  // QUANTITY TAG
  Widget buildQuantityTag() {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),

      decoration: BoxDecoration(
        color: Colors.white24,

        borderRadius:
            BorderRadius.circular(
          30,
        ),
      ),

      child: Text(
        "Qty : ${items.fold<int>(0, (sum, item) => sum + ((item['qty'] ?? 0) as int))}",

        style: const TextStyle(
          color: Colors.white,

          fontWeight:
              FontWeight.w600,

          fontSize: 12,
        ),
      ),
    );
  }
}