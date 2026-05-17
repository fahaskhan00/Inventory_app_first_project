import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/database_hive.dart';
import 'package:flutter_application_1/widgets/custom_snackbar.dart';
import 'add_categories.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final db = DatabaseApp();

  TextEditingController searchController = TextEditingController();

  String searchQuery = "";

  void goToAddCategory() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddCategoryScreen()),
    );

    if (result != null) {
      final categories = db.getCategories();

      if (categories.any(
        (c) => c.toLowerCase() == result.toString().toLowerCase(),
      )) {
        CustomSnackBar.show(context, 'Already name exist');

        return;
      }

      db.addCategory(result);

      setState(() {});
    }
  }

  void editCategory(int index) {
    final categories = db.getCategories();

    final controller = TextEditingController(text: categories[index]);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E293B),

          title: const Text(
            "Edit Category",
            style: TextStyle(color: Colors.white),
          ),

          content: TextField(
            controller: controller,

            style: const TextStyle(color: Colors.white),

            decoration: const InputDecoration(
              hintText: "Enter new category name",

              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),

          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),

              child: const Text(
                "Cancel",

                style: TextStyle(color: Colors.white70),
              ),
            ),

            TextButton(
              onPressed: () {
                final newName = controller.text.trim();

                if (newName.isEmpty) {
                  CustomSnackBar.show(context, "Name cannot be empty");

                  return;
                }

                final categories = db.getCategories();

                if (categories.any(
                  (c) => c.toLowerCase() == newName.toLowerCase(),
                )) {
                  CustomSnackBar.show(context, "Already name exist");

                  return;
                }

  final oldName = categories[index];

db.updateCategory(index, newName);

final items = db.getItems();

for (int i = 0; i < items.length; i++) {

  if (items[i].category == oldName) {

    items[i].category = newName;

    db.updateItem(i, items[i]);
  }
}

Navigator.pop(context);

setState(() {});
              },

              child: const Text(
                "Save",

                style: TextStyle(color: Colors.tealAccent),
              ),
            ),
          ],
        );
      },
    );
  }

  void deleteCategory(int index) {
    final categories = db.getCategories();

    final categoryName = categories[index];

    final items = db.getItems();

    final hasItems = items.any((item) => item.category == categoryName);

    if (hasItems) {
      CustomSnackBar.show(context, 'Remove all items before delete catagory');

      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E293B),

          title: const Text(
            "Delete Category",

            style: TextStyle(color: Colors.white),
          ),

          content: const Text(
            "Are you sure you want to delete this category?",

            style: TextStyle(color: Colors.white70),
          ),

          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),

              child: const Text(
                "Cancel",

                style: TextStyle(color: Colors.white70),
              ),
            ),

            TextButton(
              onPressed: () {
                db.deleteCategory(index);

                Navigator.pop(context);

                setState(() {});
              },

              child: const Text(
                "Delete",

                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final allCategories = db.getCategories();

    final categories =
        allCategories.where((category) {
          return category.toLowerCase().contains(searchQuery);
        }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),

      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 85,
        backgroundColor: Colors.transparent,

        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF7A00), Color(0xFFFF9800)],

              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
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
              "Categories",

              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
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
            /// SEARCH
            Container(
              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(22),

                border: Border.all(color: Colors.orange.withOpacity(0.08)),

                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.05),

                    blurRadius: 10,

                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: TextField(
                controller: searchController,

                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },

                decoration: const InputDecoration(
                  hintText: "Search categories...",

                  hintStyle: TextStyle(color: Colors.grey),

                  prefixIcon: Icon(Icons.search, color: Colors.grey),

                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child:
                  categories.isEmpty
                      ? const Center(
                        child: Text(
                          "No Categories Added",

                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                      : GridView.builder(
                        itemCount: categories.length,

                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,

                              crossAxisSpacing: 15,

                              mainAxisSpacing: 15,
                            ),

                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onLongPress: () => deleteCategory(index),

                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,

                                borderRadius: BorderRadius.circular(26),

                                border: Border.all(
                                  color: Colors.orange.withOpacity(0.08),
                                ),

                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.04),

                                    blurRadius: 10,

                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),

                              padding: const EdgeInsets.all(12),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,

                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,

                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,

                                            builder: (context) {
                                              return Dialog(
                                                backgroundColor:
                                                    Colors.transparent,

                                                child: Container(
                                                  padding: const EdgeInsets.all(
                                                    20,
                                                  ),

                                                  decoration: BoxDecoration(
                                                    color: Colors.white,

                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          26,
                                                        ),

                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.08),
                                                        blurRadius: 20,
                                                        offset: const Offset(
                                                          0,
                                                          8,
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,

                                                    children: [
                                                      Container(
                                                        width: 45,
                                                        height: 5,

                                                        decoration: BoxDecoration(
                                                          color:
                                                              Colors
                                                                  .grey
                                                                  .shade300,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                20,
                                                              ),
                                                        ),
                                                      ),

                                                      const SizedBox(
                                                        height: 22,
                                                      ),

                                                      /// EDIT
                                                      InkWell(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              18,
                                                            ),

                                                        onTap: () {
                                                          Navigator.pop(
                                                            context,
                                                          );

                                                          editCategory(index);
                                                        },

                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                horizontal: 16,
                                                                vertical: 14,
                                                              ),

                                                          decoration: BoxDecoration(
                                                            color: Colors.teal
                                                                .withOpacity(
                                                                  0.08,
                                                                ),

                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  18,
                                                                ),
                                                          ),

                                                          child: const Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .edit_rounded,
                                                                color:
                                                                    Colors.teal,
                                                              ),

                                                              SizedBox(
                                                                width: 14,
                                                              ),

                                                              Text(
                                                                "Edit Category",

                                                                style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 15,
                                                                  color:
                                                                      Colors
                                                                          .black,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                      const SizedBox(
                                                        height: 14,
                                                      ),

                                                      /// DELETE
                                                      InkWell(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              18,
                                                            ),

                                                        onTap: () {
                                                          Navigator.pop(
                                                            context,
                                                          );

                                                          deleteCategory(index);
                                                        },

                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                horizontal: 16,
                                                                vertical: 14,
                                                              ),

                                                          decoration: BoxDecoration(
                                                            color: Colors.red
                                                                .withOpacity(
                                                                  0.08,
                                                                ),

                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  18,
                                                                ),
                                                          ),

                                                          child: const Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .delete_rounded,
                                                                color:
                                                                    Colors
                                                                        .redAccent,
                                                              ),

                                                              SizedBox(
                                                                width: 14,
                                                              ),

                                                              Text(
                                                                "Delete Category",

                                                                style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 15,
                                                                  color:
                                                                      Colors
                                                                          .black,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },

                                        child: Container(
                                          padding: const EdgeInsets.all(6),

                                          decoration: BoxDecoration(
                                            color: Colors.orange.withOpacity(
                                              0.1,
                                            ),
                                            shape: BoxShape.circle,
                                          ),

                                          child: const Icon(
                                            Icons.edit,
                                            size: 18,
                                            color: Color(0xFFFF7A00),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,

                                      children: [
                                        const Icon(
                                          Icons.category,

                                          size: 42,

                                          color: Color(0xFFFF7A00),
                                        ),

                                        const SizedBox(height: 10),

                                        Text(
                                          categories[index],

                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,

                                            color: Color(0xFF1E293B),
                                          ),
                                        ),

                                        const SizedBox(height: 5),

                                        const Text(
                                          "Items",

                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                onPressed: goToAddCategory,

                icon: const Icon(Icons.add, color: Colors.white),

                label: const Text(
                  "Add new category",

                  style: TextStyle(color: Colors.white),
                ),

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF7A00),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
