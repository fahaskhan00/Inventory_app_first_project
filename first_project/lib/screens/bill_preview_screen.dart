import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class BillPreviewScreen extends StatelessWidget {
  final List items;
  final double total;
  final String customerName;
  final String customerPhone;
  final String customerAddress;
  final String customerSalePrice;

  const BillPreviewScreen({
    super.key,
    required this.items,
    required this.total,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.customerSalePrice,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        iconTheme: const IconThemeData(
          color: Colors.black,
        ),

        title: const Text(
          "Bill Preview",

          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 22,
          ),
        ),

        leading: IconButton(
          icon: const Icon(Icons.arrow_back),

          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            /// SUCCESS CARD
            Container(
              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(24),

                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.08),

                    blurRadius: 14,

                    offset: const Offset(0, 6),
                  ),
                ],
              ),

              child: Column(
                children: [

                  CircleAvatar(
                    radius: 28,

                    backgroundColor:
                        const Color(0xFFFFF3E8),

                    child: const Icon(
                      Icons.check_rounded,

                      color: Color(0xFFFF8C42),

                      size: 30,
                    ),
                  ),

                  const SizedBox(height: 14),

                  const Text(
                    "Bill Generated Successfully",

                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "MyInventory Store",

                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "TRANSACTION DATE\n${now.toString()}",

                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            /// CUSTOMER DETAILS
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E8),

                borderRadius:
                    BorderRadius.circular(18),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  const Text(
                    "CUSTOMER DETAILS",

                    style: TextStyle(
                      color: Color(0xFFFF8C42),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    customerName,

                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    customerPhone,

                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    customerAddress,

                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                    children: [

                      const Text(
                        "Customer Price",

                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      Text(
                        customerSalePrice
                                .trim()
                                .isEmpty
                            ? "Not Added"
                            : "₹ $customerSalePrice",

                        style: const TextStyle(
                          color: Color(0xFFFF8C42),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// ITEMS CARD
            Container(
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(24),

                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.08),

                    blurRadius: 14,

                    offset: const Offset(0, 6),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  const Text(
                    "ITEMIZED DETAILS",

                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF8C42),
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 18),

                  ...items.map((item) {

                    final qty =
                        item['qty'] ?? 1;

                    return Padding(
                      padding:
                          const EdgeInsets.only(
                        bottom: 16,
                      ),

                      child: Row(
                        children: [

                          Container(
                            width: 52,
                            height: 52,

                            decoration: BoxDecoration(
                              color:
                                  const Color(
                                0xFFFFF3E8,
                              ),

                              borderRadius:
                                  BorderRadius.circular(
                                14,
                              ),

                              image:
                                  item['images'] != null &&
                                          item['images']
                                              .isNotEmpty
                                      ? DecorationImage(
                                          image:
                                              FileImage(
                                            File(
                                              item['images'][0],
                                            ),
                                          ),

                                          fit:
                                              BoxFit.cover,
                                        )
                                      : null,
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
                                  item['name'],

                                  style:
                                      const TextStyle(
                                    color:
                                        Colors.black,

                                    fontWeight:
                                        FontWeight
                                            .w600,

                                    fontSize: 15,
                                  ),
                                ),

                                const SizedBox(
                                  height: 4,
                                ),

                                Text(
                                  "Qty: $qty",

                                  style: TextStyle(
                                    fontSize: 12,

                                    color: Colors
                                        .grey
                                        .shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Text(
                            "₹ ${item['price']}",

                            style: const TextStyle(
                              color:
                                  Color(0xFFFF8C42),

                              fontWeight:
                                  FontWeight.bold,

                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),

                  const Padding(
                    padding:
                        EdgeInsets.symmetric(
                      vertical: 10,
                    ),

                    child: Divider(
                      color:
                          Color(0xFFFFE0CC),
                    ),
                  ),

                  row(
                    "Subtotal",
                    total,
                  ),

                  const SizedBox(height: 10),

                  row("Tax", 0),

                  const Padding(
                    padding:
                        EdgeInsets.symmetric(
                      vertical: 14,
                    ),

                    child: Divider(
                      color:
                          Color(0xFFFFE0CC),
                    ),
                  ),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,

                    children: [

                      const Text(
                        "Total Amount",

                        style: TextStyle(
                          fontWeight:
                              FontWeight.bold,

                          color: Colors.black,

                          fontSize: 16,
                        ),
                      ),

                      Text(
                        "₹ ${total.toStringAsFixed(0)}",

                        style: const TextStyle(
                          fontWeight:
                              FontWeight.bold,

                          color:
                              Color(0xFFFF8C42),

                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// SAVE BUTTON
            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 18,
                  ),

                  backgroundColor:
                      const Color(
                    0xFFFF8C42,
                  ),

                  elevation: 0,

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      18,
                    ),
                  ),
                ),

                onPressed: () async {

                  final salesBox =
                      Hive.box('salesBox');

                  final itemsBox =
                      Hive.box('itemsBox');

                  await salesBox.add({
                    "items": items,
                    "total": total,
                    "date": now.toString(),

                    "customerName":
                        customerName,

                    "customerPhone":
                        customerPhone,

                    "customerAddress":
                        customerAddress,

                    "customerSalePrice":
                        customerSalePrice,
                  });

                  for (var soldItem
                      in items) {

                    final soldQty =
                        soldItem['qty'] ?? 1;

                    for (int i = 0;
                        i <
                            itemsBox.length;
                        i++) {

                      var product =
                          itemsBox.getAt(i);

                      if (product['name'] ==
                          soldItem['name']) {

                        int currentStock =
                            product['quantity'];

                        num newStock =
                            currentStock -
                                soldQty;

                        itemsBox.putAt(i, {
                          ...product,
                          'quantity':
                              newStock < 0
                                  ? 0
                                  : newStock,
                        });

                        break;
                      }
                    }
                  }

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Bill Saved & Updated",
                      ),
                    ),
                  );

                  Navigator.popUntil(
                    context,
                    (route) =>
                        route.isFirst,
                  );
                },

                child: const Text(
                  "Save Bill",

                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,

                    color: Colors.white,

                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 22),

            Text(
              "Thank you for your business!",

              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget row(
    String title,
    double value,
  ) {

    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,

      children: [

        Text(
          title,

          style: TextStyle(
            color:
                Colors.grey.shade600,
            fontSize: 14,
          ),
        ),

        Text(
          "₹ ${value.toStringAsFixed(0)}",

          style: const TextStyle(
            color: Colors.black,

            fontWeight:
                FontWeight.w600,

            fontSize: 15,
          ),
        ),
      ],
    );
  }
}