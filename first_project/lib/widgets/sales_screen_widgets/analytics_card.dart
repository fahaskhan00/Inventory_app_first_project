import 'package:flutter/material.dart';

class AnalyticsCards
    extends StatelessWidget {
  final double weekRevenue;

  final double averageSale;

  const AnalyticsCards({
    super.key,
    required this.weekRevenue,
    required this.averageSale,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding:
                const EdgeInsets.all(
              18,
            ),

            decoration: BoxDecoration(
              color: const Color(
                0xFFFF8C42,
              ),

              borderRadius:
                  BorderRadius.circular(
                22,
              ),
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [
                const Icon(
                  Icons.currency_rupee,

                  color: Colors.white,
                ),

                const SizedBox(
                  height: 14,
                ),

                Text(
                  "₹ ${weekRevenue.toStringAsFixed(0)}",

                  style:
                      const TextStyle(
                        color:
                            Colors.white,

                        fontWeight:
                            FontWeight
                                .bold,

                        fontSize: 22,
                      ),
                ),

                const SizedBox(
                  height: 6,
                ),

                const Text(
                  "Weekly Revenue",

                  style: TextStyle(
                    color:
                        Colors.white70,

                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Container(
            padding:
                const EdgeInsets.all(
              18,
            ),

            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius:
                  BorderRadius.circular(
                22,
              ),

              border: Border.all(
                color: Colors
                    .grey
                    .shade200,
              ),
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [
                const Icon(
                  Icons.show_chart,

                  color: Color(
                    0xFFFF8C42,
                  ),
                ),

                const SizedBox(
                  height: 14,
                ),

                Text(
                  "₹ ${averageSale.toStringAsFixed(0)}",

                  style:
                      const TextStyle(
                        color:
                            Colors.black,

                        fontWeight:
                            FontWeight
                                .bold,

                        fontSize: 22,
                      ),
                ),

                const SizedBox(
                  height: 6,
                ),

                const Text(
                  "Average Sale",

                  style: TextStyle(
                    color:
                        Colors.grey,

                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}