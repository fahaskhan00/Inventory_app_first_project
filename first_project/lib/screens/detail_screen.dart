import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/edit_screen.dart';
import 'package:flutter_application_1/services/database_hive.dart';

class DetailScreen extends StatefulWidget {
  final String name;
  final String price;
  final String stock;
  final String tag;
  final List<String> imagePath;
  final int index;

  const DetailScreen({
    super.key,
    required this.name,
    required this.price,
    required this.stock,
    required this.tag,
    required this.imagePath,
    required this.index,
  });

  @override
  State<DetailScreen> createState() =>
      _DetailScreenState();
}

class _DetailScreenState
    extends State<DetailScreen> {
  void deleteItem(BuildContext context) {
    final db = DatabaseApp.instance;

    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,

          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(22),
          ),

          title: const Text(
            "Delete Item",

            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),

          content: Text(
            "Are you sure you want to delete this item?",

            style: TextStyle(
              color: Colors.grey.shade700,
            ),
          ),

          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context),

              child: Text(
                "Cancel",

                style: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),
            ),

            TextButton(
              onPressed: () {
                db.deleteItem(widget.index);

                Navigator.pop(context);

                Navigator.pop(context, true);
              },

              child: const Text(
                "Delete",

                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final db = DatabaseApp.instance;

    final item =
        db.getItems()[widget.index];

    final imageList = item.images;

    return Scaffold(
      backgroundColor:
          const Color(0xFFF7F8FA),

      appBar: AppBar(
        elevation: 0,

        backgroundColor:
            Colors.transparent,

        centerTitle: true,

        title: const Text(
          "Item Details",

          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        leading: IconButton(
          onPressed: () =>
              Navigator.pop(context),

          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () async {
              final result =
                  await Navigator.push(
                context,

                MaterialPageRoute(
                  builder:
                      (context) =>
                          EditItemScreen(
                    index:
                        widget.index,
                  ),
                ),
              );

              if (result == true) {
                Navigator.pop(
                  context,
                  true,
                );
              }
            },

            icon: const Icon(
              Icons.edit_outlined,
              color: Color(0xFFFF8C42),
            ),
          ),

          IconButton(
            onPressed: () =>
                deleteItem(context),

            icon: const Icon(
              Icons.delete_outline,
              color: Colors.red,
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            /// IMAGE
            Container(
              height: 260,
              width: double.infinity,

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                  28,
                ),
              ),

              child:
                  imageList.isEmpty
                      ? Center(
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .center,

                          children: [
                            Icon(
                              Icons.image_outlined,
                              size: 50,
                              color: Colors
                                  .grey
                                  .shade400,
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            Text(
                              "No Image",

                              style: TextStyle(
                                color: Colors
                                    .grey
                                    .shade500,
                              ),
                            ),
                          ],
                        ),
                      )
                      : ClipRRect(
                        borderRadius:
                            BorderRadius.circular(
                          28,
                        ),

                        child:
                            PageView.builder(
                          itemCount:
                              imageList.length,

                          itemBuilder:
                              (
                                context,
                                index,
                              ) {
                            return Image.file(
                              File(
                                imageList[
                                    index],
                              ),

                              fit:
                                  BoxFit.cover,
                            );
                          },
                        ),
                      ),
            ),

            const SizedBox(height: 22),

            /// NAME + CATEGORY
            Container(
              width: double.infinity,

              padding:
                  const EdgeInsets.all(
                20,
              ),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                  24,
                ),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [
                  Text(
                    item.name,

                    style:
                        const TextStyle(
                      fontSize: 28,
                      fontWeight:
                          FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(
                    height: 14,
                  ),

                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),

                    decoration:
                        BoxDecoration(
                      color:
                          const Color(
                        0xFFFFF3E8,
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        18,
                      ),
                    ),

                    child: Text(
                      item.category,

                      style:
                          const TextStyle(
                        color: Color(
                          0xFFFF8C42,
                        ),

                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// PRICE
            Container(
              width: double.infinity,

              padding:
                  const EdgeInsets.all(
                20,
              ),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                  24,
                ),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [
                  Text(
                    "Product Price",

                    style: TextStyle(
                      color:
                          Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  Text(
                    "₹ ${item.price}",

                    style:
                        const TextStyle(
                      color: Color(
                        0xFFFF8C42,
                      ),

                      fontSize: 34,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  if (item.salePrice !=
                          null &&
                      item.salePrice!
                          .trim()
                          .isNotEmpty) ...[
                    const SizedBox(
                      height: 18,
                    ),

                    Text(
                      "Sale Price",

                      style: TextStyle(
                        color: Colors
                            .grey
                            .shade600,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(
                      height: 6,
                    ),

                    Text(
                      "₹ ${item.salePrice}",

                      style: TextStyle(
                        color: Colors
                            .green
                            .shade700,

                        fontSize: 24,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// STOCK
            Container(
              width: double.infinity,

              padding:
                  const EdgeInsets.all(
                20,
              ),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                  24,
                ),
              ),

              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,

                children: [
                  const Text(
                    "Available Stock",

                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),

                  Text(
                    "${item.quantity}",

                    style:
                        const TextStyle(
                      color: Color(
                        0xFFFF8C42,
                      ),

                      fontSize: 24,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// NOTES
            Container(
              width: double.infinity,

              padding:
                  const EdgeInsets.all(
                20,
              ),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                  24,
                ),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [
                  const Text(
                    "Notes",

                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  Text(
                    item.notes
                            .trim()
                            .isEmpty
                        ? "No notes added"
                        : item.notes,

                    style: TextStyle(
                      color:
                          Colors.grey.shade700,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}