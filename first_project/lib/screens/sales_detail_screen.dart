import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SalesDetailScreen extends StatelessWidget {
  final Map<String, dynamic> sale;

  const SalesDetailScreen({
    super.key,
    required this.sale,
  });

  @override
  Widget build(BuildContext context) {
    final List items = sale['items'];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,

        iconTheme: const IconThemeData(
          color: Colors.black,
        ),

        title: const Text(
          "Sale Details",

          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            /// TOTAL CARD
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(24),

              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(28),

                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,

                  colors: [
                    Color.fromARGB(255, 0, 0, 0),
                    Color.fromARGB(255, 72, 50, 36),
                  ],
                ),

                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 0, 0, 0).withOpacity(
                      0.22,
                    ),

                    blurRadius: 18,

                    offset: const Offset(0, 8),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Row(
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
                  ),
                  const SizedBox(height: 18),

                  Container(
  padding: const EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 6,
  ),

  decoration: BoxDecoration(
    color: Colors.white24,

    borderRadius: BorderRadius.circular(30),
  ),




  child: Text(
    "Qty : ${items.fold<int>(
      0,
      (sum, item) =>
          sum + ((item['qty'] ?? 0) as int),
    )}",

    style: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 12,
    ),
  ),
),

const SizedBox(height: 18),

                

                  const Text(
                    "Total Amount",

                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight:
                          FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 10),

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
            ),

            const SizedBox(height: 22),

            /// CUSTOMER DETAILS
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(24),

                boxShadow: [
                  BoxShadow(
                    color:
                        Colors.orange.withOpacity(
                      0.08,
                    ),

                    blurRadius: 15,

                    offset: const Offset(0, 6),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  const Row(
                    children: [

                      Icon(
                        Icons.person_outline,
                        color: Color(0xFFFF8C42),
                      ),

                      SizedBox(width: 10),

                      Text(
                        "Customer Details",

                        style: TextStyle(
                          color: Colors.black,
                          fontWeight:
                              FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  detailTile(
                    icon: Icons.person,
                    title: "Customer Name",
                    value:
                        sale['customerName'] ??
                        "",
                  ),

                  const SizedBox(height: 18),

                  detailTile(
                    icon: Icons.phone,
                    title: "Phone Number",
                    value:
                        sale['customerPhone'] ??
                        "",
                  ),

                  const SizedBox(height: 18),

                  detailTile(
                    icon: Icons.location_on,
                    title: "Address",
                    value:
                        sale['customerAddress'] ??
                        "",
                  ),
                  SizedBox(height: 18,),
                  detailTile(
  icon: Icons.currency_rupee,
  title: "Customer Sale Price",

  value:
      sale['customerSalePrice'] != null &&
              sale['customerSalePrice']
                  .toString()
                  .trim()
                  .isNotEmpty

          ? "₹ ${sale['customerSalePrice']}"

          : " Product Price",
),
                ],
              ),
            ),

           
            const SizedBox(height: 18),



SizedBox(height: 20,),
            /// ITEMS HEADER
            Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,

              children: [

                const Text(
                  "Sold Products",

                  style: TextStyle(
                    color: Colors.black,
                    fontWeight:
                        FontWeight.bold,
                    fontSize: 20,
                  ),
                ),

                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),

                  decoration: BoxDecoration(
                    color: const Color(
                      0xFFFFF3E8,
                    ),

                    borderRadius:
                        BorderRadius.circular(
                      30,
                    ),
                  ),

                  child: Text(
                    "${items.length} Items",

                    style: const TextStyle(
                      color: Color(0xFFFF8C42),
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            /// ITEMS LIST
            ListView.builder(
              shrinkWrap: true,

              physics:
                  const NeverScrollableScrollPhysics(),

              itemCount: items.length,

              itemBuilder: (context, index) {

                final item = items[index];

                final saleQty =
                    item['qty'] ?? 0;

                return Container(
                  margin:
                      const EdgeInsets.only(
                    bottom: 16,
                  ),

                  padding:
                      const EdgeInsets.all(18),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(
                      24,
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange
                            .withOpacity(
                          0.08,
                        ),

                        blurRadius: 14,

                        offset:
                            const Offset(0, 6),
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
                          Icons.inventory_2_rounded,

                          color:
                              Color(0xFFFF8C42),
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
                                color:
                                    const Color(
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
                                  color:
                                      Color(
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

  sale['customerSalePrice'] != null &&
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
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget detailTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
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
                CrossAxisAlignment.start,

            children: [

              Text(
                title,

                style: TextStyle(
                  color:
                      Colors.grey.shade600,

                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 4),

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