import 'package:flutter/material.dart';

class SoldProductTile
    extends StatelessWidget {
  final Map<String, dynamic>
  sale;

  final dynamic item;

  const SoldProductTile({
    super.key,
    required this.sale,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final saleQty =
        item['qty'] ?? 0;

    return Container(
      margin: const EdgeInsets.only(
        bottom: 16,
      ),

      padding: const EdgeInsets.all(
        18,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(
          24,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.orange
                .withOpacity(0.08),

            blurRadius: 14,

            offset: const Offset(
              0,
              6,
            ),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,

            decoration: BoxDecoration(
              color: const Color(
                0xFFFFF3E8,
              ),

              borderRadius:
                  BorderRadius.circular(
                18,
              ),
            ),

            child: const Icon(
              Icons
                  .inventory_2_rounded,

              color: Color(
                0xFFFF8C42,
              ),
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [
                Text(
                  item['name'],

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
                  height: 8,
                ),

                Container(
                  padding:
                      const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),

                  decoration:
                      BoxDecoration(
                        color: const Color(
                          0xFFFFF3E8,
                        ),

                        borderRadius:
                            BorderRadius.circular(
                              30,
                            ),
                      ),

                  child: Text(
                    "Qty : $saleQty",

                    style:
                        const TextStyle(
                          color: Color(
                            0xFFFF8C42,
                          ),

                          fontWeight:
                              FontWeight
                                  .bold,

                          fontSize: 12,
                        ),
                  ),
                ),
              ],
            ),
          ),

          Text(
            sale['customerSalePrice'] !=
                        null &&
                    sale['customerSalePrice']
                        .toString()
                        .trim()
                        .isNotEmpty
                ? "₹ ${sale['customerSalePrice']}"
                : "₹ ${item['price']}",

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
    );
  }
}