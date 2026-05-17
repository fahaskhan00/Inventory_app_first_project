import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/custom_snackbar.dart';
import 'package:flutter_application_1/services/database_hive.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final TextEditingController controller = TextEditingController();

 void addCategory() {
  String categoryName =
      controller.text.trim();

  if (categoryName.isEmpty) {
    CustomSnackBar.show(
      context,
      'enter category name',
    );

    return;
  }

  final categories =
      DatabaseApp.instance
          .getCategories();

  final alreadyExists =
      categories.any(
    (e) =>
        e.toLowerCase() ==
        categoryName.toLowerCase(),
  );

  if (alreadyExists) {
    CustomSnackBar.show(
      context,
      'Category already exists',
    );

    return;
  }

  Navigator.pop(
    context,
    categoryName,
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      appBar: AppBar(
        title: const Text(
          "Add Category",

          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),

        centerTitle: true,

        backgroundColor: Colors.transparent,

        elevation: 0,

        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Container(
            padding: const EdgeInsets.all(24),

            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.circular(28),

              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.08),

                  blurRadius: 16,

                  offset: const Offset(0, 6),
                ),
              ],
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                Container(
                  padding: const EdgeInsets.all(18),

                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3E8),

                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.category_rounded,

                    size: 36,

                    color: Color(0xFFFF8C42),
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  "Create New Category",

                  style: TextStyle(
                    color: Colors.black,

                    fontSize: 22,

                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 28),

                TextField(
                  controller: controller,

                  autofocus: true,

                  onSubmitted: (_) => addCategory(),

                  style: const TextStyle(color: Colors.black),

                  decoration: InputDecoration(
                    labelText: "Category Name",

                    labelStyle: TextStyle(color: Colors.grey.shade600),

                    filled: true,

                    fillColor: const Color(0xFFFFF8F2),

                    prefixIcon: const Icon(
                      Icons.edit_rounded,

                      color: Color(0xFFFF8C42),
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),

                      borderSide: BorderSide(
                        color: Colors.orange.withOpacity(0.15),
                      ),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),

                      borderSide: const BorderSide(
                        color: Color(0xFFFF8C42),

                        width: 2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,

                  child: InkWell(
                    onTap: addCategory,

                    borderRadius: BorderRadius.circular(50),

                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFFB067), Color(0xFFFF8C42)],
                        ),

                        borderRadius: BorderRadius.circular(50),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withOpacity(0.20),

                            blurRadius: 12,

                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),

  child: Padding(
  padding: const EdgeInsets.symmetric(
    vertical: 14,
  ),

  child: Row(
    mainAxisAlignment:
        MainAxisAlignment.center,

    children: [

      Container(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 12,
        ),

        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 254, 254, 254),

          borderRadius:
              BorderRadius.circular(40),

          border: Border.all(
            color:
                const Color.fromARGB(255, 218, 109, 8),
            width: 1.5,
          ),
        ),

        child: const Row(
          mainAxisSize:
              MainAxisSize.min,

          children: [

            Icon(
              Icons.add,
              color:
                  Color(0xFFFF8C42),
            ),

            SizedBox(width: 8),

            Text(
              "Add new category",

              style: TextStyle(
                color:
                    Color(0xFFFF8C42),

                fontSize: 16,

                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ],
  ),
),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
