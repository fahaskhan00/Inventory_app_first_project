import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/database_hive.dart';
import '../widgets/filter_widget.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() =>
      _FilterScreenState();
}

class _FilterScreenState
    extends State<FilterScreen> {

  int selectedSort = 0;
  int selectedStock = 0;
  int selectedCategory = -1;

  final List<String> sortOptions = [
    "Name (A-Z)",
    "Quantity (High-Low)",
    "Newest First",
  ];

  List<String> categories = [];

  final List<String> stockOptions = [
    "All",
    "In Stock",
    "Low Stock",
  ];

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  void loadCategories() {

    final db = DatabaseApp.instance;

    final List<String>
    loadedCategories =
        List<String>.from(
      db.getCategories(),
    );

    setState(() {
      categories =
          loadedCategories;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding:
          const EdgeInsets.all(16),

      height:
          MediaQuery.of(context)
                  .size
                  .height *
              0.75,

      decoration: const BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),

      child: Column(
        children: [

          dragHandle(),

          const SizedBox(height: 10),

          header(
            onClose:
                () => Navigator.pop(
                  context,
                ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child:
                SingleChildScrollView(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  const Text(
                    "SORT BY",

                    style: TextStyle(
                      color: Colors.black,
                      fontWeight:
                          FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 12),

                  chipWrap(
                    list: sortOptions,

                    selectedIndex:
                        selectedSort,

                    onTap: (i) {

                      setState(() {
                        selectedSort =
                            i;
                      });
                    },
                  ),

                  const SizedBox(
                    height: 24,
                  ),

                  const Text(
                    "CATEGORY",

                    style: TextStyle(
                      color: Colors.black,
                      fontWeight:
                          FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 12),

                  categories.isEmpty
                      ? const Text(
                        "No categories found",

                        style: TextStyle(
                          color:
                              Colors.grey,
                        ),
                      )

                      : chipWrap(
                        list:
                            categories,

                        selectedIndex:
                            selectedCategory,

                        onTap: (i) {

                          setState(() {
                            selectedCategory =
                                i;
                          });
                        },
                      ),

                  const SizedBox(
                    height: 24,
                  ),

                  const Text(
                    "STOCK LEVEL",

                    style: TextStyle(
                      color: Colors.black,
                      fontWeight:
                          FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 12),

                  chipWrap(
                    list:
                        stockOptions,

                    selectedIndex:
                        selectedStock,

                    onTap: (i) {

                      setState(() {
                        selectedStock =
                            i;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          Row(
            children: [

              TextButton(
                onPressed: () {

                  setState(() {

                    selectedSort = 0;

                    selectedStock = 0;

                    selectedCategory =
                        -1;
                  });
                },

                child: const Text(
                  "Reset",

                  style: TextStyle(
                    color:
                        Color(
                      0xFFFF8C42,
                    ),

                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ),

              const Spacer(),

              ElevatedButton(
                onPressed: () {

                  Navigator.pop(
                    context,

                    {
                      "sort":
                          selectedSort,

                      "stock":
                          selectedStock,

                      "category":
                          selectedCategory ==
                                  -1
                              ? null
                              : categories[
                                  selectedCategory
                                ],
                    },
                  );
                },

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(
                    0xFFFF8C42,
                  ),

                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 14,
                  ),

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      20,
                    ),
                  ),
                ),

                child: const Text(
                  "Apply Filters",

                  style: TextStyle(
                    color: Colors.white,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}