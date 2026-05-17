import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';
import 'package:flutter_application_1/screens/add_items_screen.dart';
import 'package:flutter_application_1/screens/detail_screen.dart';
import 'package:flutter_application_1/screens/filter_screen.dart';
import 'package:flutter_application_1/services/database_hive.dart';
import 'package:flutter_application_1/widgets/delete_dialog.dart';
import '../widgets/items_widgets.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({super.key});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  int selectedIndex = 0;

  TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  String? filterCategory;
  int filterSort = 0;
  int filterStock = 0;

  @override
  Widget build(BuildContext context) {
    final db = DatabaseApp();

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 85,
        backgroundColor: Colors.transparent,

        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Inventory",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(height: 4),

            Text(
              "My Items",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// SEARCH + FILTER
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 14, 97, 179),
                borderRadius: BorderRadius.circular(22),

                border: Border.all(color: AppColors.primary.withOpacity(0.08)),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 9),
                  ),
                ],
              ),

              child: Row(
                children: [
                  Expanded(
                    child: buildSearchBar(
                      controller: searchController,

                      onChanged: (value) {
                        setState(() {
                          searchQuery = value.toLowerCase();
                        });
                      },
                    ),
                  ),

                  const SizedBox(width: 12),

                  filterButton(() async {
                    final result = await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => FilterScreen(),
                    );

                    if (result != null) {
                      setState(() {
                        filterSort = result["sort"];
                        filterCategory = result["category"];
                        filterStock = result["stock"];
                      });
                    }
                  }),
                ],
              ),
            ),

            const SizedBox(height: 22),

            /// CATEGORY CHIPS
            SizedBox(
              height: 50,
              child: ValueListenableBuilder(
                valueListenable: db.categoryListenable(),
                builder: (context, box, _) {
                  final categories = ["All", ...db.getCategories()];

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,

                    itemBuilder: (context, index) {
                      final isSelected = selectedIndex == index;

                      return Padding(
                        padding: const EdgeInsets.only(right: 10),

                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),

                          decoration: BoxDecoration(
                            color:
                                isSelected ? AppColors.primary : AppColors.card,

                            borderRadius: BorderRadius.circular(14),

                            border: Border.all(
                              color:
                                  isSelected
                                      ? AppColors.primary
                                      : Colors.grey.withOpacity(0.1),
                            ),
                          ),

                          child: InkWell(
                            borderRadius: BorderRadius.circular(14),

                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },

                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 12,
                              ),

                              child: Text(
                                categories[index],

                                style: TextStyle(
                                  color:
                                      isSelected
                                          ? Colors.white
                                          : AppColors.text,

                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 22),

            /// ITEMS
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: db.itemListenable(),

                builder: (context, box, _) {
                  final allItems = db.getItems();

                  final categories = ["All", ...db.getCategories()];

                  final selectedCategory = categories[selectedIndex];

                  List items = allItems;

                  if (filterCategory != null) {
                    items =
                        items
                            .where((item) => item.category == filterCategory)
                            .toList();
                  } else {
                    if (selectedCategory != "All") {
                      items =
                          items
                              .where(
                                (item) => item.category == selectedCategory,
                              )
                              .toList();
                    }
                  }

                  if (filterStock == 2) {
                    items = items.where((item) => item.quantity < 2).toList();
                  }

                  if (filterStock == 1) {
                    items = items.where((item) => item.quantity > 0).toList();
                  }

                items = items.reversed.toList();

if (filterSort == 1) {
  items.sort((a, b) => b.quantity.compareTo(a.quantity));
}

if (filterSort == 2) {
  items.sort((a, b) => a.name.compareTo(b.name));
}

                  items =
                      items.where((item) {
                        return item.name.toLowerCase().contains(searchQuery);
                      }).toList();

                  if (items.isEmpty) {
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.all(24),

                        decoration: BoxDecoration(
                          color: AppColors.card,
                          borderRadius: BorderRadius.circular(24),
                        ),

                        child: Text(
                          "No items added",
                          style: TextStyle(
                            color: AppColors.subtitle,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),

                    itemCount: items.length,

                    itemBuilder: (context, index) {
                    final item = items[index];

final originalIndex =
    allItems.indexOf(item);
                      final imagePath =
                          item.images.isNotEmpty ? item.images[0] : "";

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),

                        child: itemTile(
                          item: item,
                          imagePath: imagePath,

                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => DetailScreen(
                                      name: item.name,
                                      price: item.price.toString(),
                                      stock: "Stock: ${item.quantity}",
                                      tag: item.category,
                                      imagePath: item.images,
                                    index: originalIndex,
                                    ),
                              ),
                            );
                          },

                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder:
                                  (context) => DeleteDialog(
                                    onDelete: () {
                                     db.deleteItem(originalIndex);
                                    },
                                  ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),

          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
          ),

          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.35),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),

        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.transparent,

          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddItemScreen()),
            );
          },

          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),
    );
  }
}
