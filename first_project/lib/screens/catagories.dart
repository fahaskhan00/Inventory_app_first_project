import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';
import 'package:flutter_application_1/services/database_hive.dart';
import 'package:flutter_application_1/widgets/custom_snackbar.dart';
import 'add_categories.dart';
import '../widgets/categories_widget.dart/appbar.dart';
import '../widgets/categories_widget.dart/search_field.dart';
import '../widgets/categories_widget.dart/empty_catagory_widget.dart';
import '../widgets/categories_widget.dart/grid_tile.dart';
import '../widgets/categories_widget.dart/action_dialogue.dart';
import '../widgets/categories_widget.dart/edit.dart';
import '../widgets/categories_widget.dart/delete.dart';
import '../widgets/categories_widget.dart/add_button.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  // DATABASE
  final db = DatabaseApp();

  // SEARCH CONTROLLER
  TextEditingController searchController = TextEditingController();

  // SEARCH QUERY
  String searchQuery = "";

  // GO TO ADD CATEGORY
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

  // EDIT CATEGORY
  void editCategory(int index) {
    final categories = db.getCategories();

    final controller = TextEditingController(text: categories[index]);

    showDialog(
      context: context,

      builder: (context) {
        return EditCategoryDialog(
          controller: controller,

          onSave: () {
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
        );
      },
    );
  }

  // DELETE CATEGORY
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
        return DeleteCategoryDialog(
          onDelete: () {
            db.deleteCategory(index);

            Navigator.pop(context);

            setState(() {});
          },
        );
      },
    );
  }

  // SEARCH CHANGED
  void onSearchChanged(String value) {
    setState(() {
      searchQuery = value.toLowerCase();
    });
  }

  // GET ALL CATEGORIES
  List getAllCategories() {
    return db.getCategories();
  }

  // FILTERED CATEGORIES
  List getFilteredCategories(List allCategories) {
    return allCategories.where((category) {
      return category.toLowerCase().contains(searchQuery);
    }).toList();
  }

  // APP BAR
  PreferredSizeWidget buildAppBar() {
    return const CategoriesAppBar();
  }

  // SEARCH FIELD
  Widget buildSearchField() {
    return CategoriesSearchField(
      controller: searchController,
      onChanged: onSearchChanged,
    );
  }

  // EMPTY WIDGET
  Widget buildEmptyWidget() {
    return const EmptyCategoriesWidget();
  }

  // GRID
  Widget buildGrid(List categories) {
    return GridView.builder(
      itemCount: categories.length,

      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,

        crossAxisSpacing: 15,

        mainAxisSpacing: 15,
      ),

      itemBuilder: (context, index) {
        return buildCategoryTile(categories, index);
      },
    );
  }

  // CATEGORY TILE
  Widget buildCategoryTile(List categories, int index) {
    return CategoryGridTile(
      categoryName: categories[index],

      onEdit: () {
        showCategoryActions(index);
      },

      onDelete: () {
        deleteCategory(index);
      },
    );
  }

  // SHOW ACTIONS
  void showCategoryActions(int index) {
    showDialog(
      context: context,

      builder: (context) {
        return CategoryActionDialog(
          onEdit: () {
            Navigator.pop(context);

            editCategory(index);
          },

          onDelete: () {
            Navigator.pop(context);

            deleteCategory(index);
          },
        );
      },
    );
  }

  // CATEGORY SECTION
  Widget buildCategorySection(List categories) {
    return Expanded(
      child: categories.isEmpty ? buildEmptyWidget() : buildGrid(categories),
    );
  }

  // ADD BUTTON
  Widget buildAddButton() {
    return AddCategoryMainButton(onTap: goToAddCategory);
  }

  // BODY
  Widget buildBody() {
    final allCategories = getAllCategories();

    final categories = getFilteredCategories(allCategories);

    return Padding(
      padding: const EdgeInsets.all(16),

      child: Column(
        children: [
          buildSearchField(),

          const SizedBox(height: 20),

          buildCategorySection(categories),

          const SizedBox(height: 20),

          buildAddButton(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.card,

      appBar: buildAppBar(),

      body: buildBody(),
    );
  }
}
