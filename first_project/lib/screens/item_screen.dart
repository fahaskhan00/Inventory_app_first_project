import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';
import 'package:flutter_application_1/screens/add_items_screen.dart';
import 'package:flutter_application_1/screens/detail_screen.dart';
import 'package:flutter_application_1/screens/filter_screen.dart';
import 'package:flutter_application_1/services/database_hive.dart';
import 'package:flutter_application_1/widgets/delete_dialog.dart';
import 'package:flutter_application_1/widgets/items_screen_widget/item_list_section.dart';
import '../widgets/items_screen_widget/appbar.dart';
import '../widgets/items_screen_widget/search_filter.dart';
import '../widgets/items_screen_widget/category_chip_list.dart';
import '../widgets/items_screen_widget/item_floating_button.dart';

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

  // OPEN FILTER
  Future<void> openFilter() async {
    final result = await showModalBottomSheet(
      context: context,

      isScrollControlled: true,

      backgroundColor: Colors.transparent,

      builder: (context) => const FilterScreen(),
    );

    if (result != null) {
      setState(() {
        filterSort = result["sort"];

        filterCategory = result["category"];

        filterStock = result["stock"];
      });
    }
  }

  // GO TO ADD SCREEN
  Future<void> goToAddScreen() async {
    await Navigator.push(
      context,

      MaterialPageRoute(builder: (context) => AddItemScreen()),
    );
  }

  // GO TO DETAIL
  void goToDetail(dynamic item, int originalIndex) {
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
  }

  // DELETE ITEM
  void deleteItem(DatabaseApp db, int originalIndex) {
    showDialog(
      context: context,

      builder:
          (context) => DeleteDialog(
            onDelete: () {
              db.deleteItem(originalIndex);
            },
          ),
    );
  }

  // CHANGE CATEGORY
  void changeCategory(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  // SEARCH
  void searchItem(String value) {
    setState(() {
      searchQuery = value.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    final db = DatabaseApp();

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const ItemAppBar(),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            SearchFilterSection(
              controller: searchController,

              onChanged: searchItem,

              onFilterTap: openFilter,
            ),

            const SizedBox(height: 22),

            CategoryChipList(
              db: db,

              selectedIndex: selectedIndex,

              onTap: changeCategory,
            ),

            const SizedBox(height: 22),

            Expanded(
              child: ItemListSection(
                db: db,

                selectedIndex: selectedIndex,

                filterCategory: filterCategory,

                filterSort: filterSort,

                filterStock: filterStock,

                searchQuery: searchQuery,

                onTap: goToDetail,

                onLongPress: (originalIndex) {
                  deleteItem(db, originalIndex);
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: ItemFloatingButton(onTap: goToAddScreen),
    );
  }
}
