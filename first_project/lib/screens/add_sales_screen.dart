import 'package:flutter/material.dart';

import 'package:flutter_application_1/colors/app_colors.dart';
import 'package:flutter_application_1/models/item_model.dart';
import 'package:flutter_application_1/screens/sales_summary_screen.dart';
import 'package:flutter_application_1/services/database_hive.dart';

import 'package:flutter_application_1/widgets/add_sales_widgets.dart/sales_appbar.dart';
import 'package:flutter_application_1/widgets/add_sales_widgets.dart/sales_search_field.dart';
import 'package:flutter_application_1/widgets/add_sales_widgets.dart/sales_item_tile.dart';
import 'package:flutter_application_1/widgets/add_sales_widgets.dart/sales_bottom_button.dart';

class AddSalesScreen extends StatefulWidget {
  final String customerName;

  final String customerPhone;

  final String customerAddress;

  const AddSalesScreen({
    super.key,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
  });

  @override
  State<AddSalesScreen> createState() => _AddSalesScreenState();
}

class _AddSalesScreenState extends State<AddSalesScreen> {
  // DATABASE
  final db = DatabaseApp.instance;
  String selectedFilter = 'All';

  // SELECTED ITEMS
  List<ItemModel> selectedItems = [];

  // SELECTED INDEXES
  List<int> selectedIndexes = [];

  // SEARCH CONTROLLER
  TextEditingController searchController = TextEditingController();

  // SEARCH QUERY
  String searchQuery = "";

  // TOTAL PRICE
  double get totalPrice {
    double total = 0;

    for (var item in selectedItems) {
      total += item.price.toDouble();
    }

    return total;
  }

  // SEARCH CHANGED
  void onSearchChanged(String value) {
    setState(() {
      searchQuery = value;
    });
  }

  // OUT OF STOCK MESSAGE
  void showOutOfStockMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Add quantity to create sale"),

        backgroundColor: AppColors.danger,
      ),
    );
  }

  // ITEM TAP
  void onItemTap(ItemModel item, int originalIndex, List<ItemModel> items) {
    if (item.quantity == 0) {
      showOutOfStockMessage();

      return;
    }

    setState(() {
      if (selectedIndexes.contains(originalIndex)) {
        selectedIndexes.remove(originalIndex);
      } else {
        selectedIndexes.add(originalIndex);
      }

      selectedItems = selectedIndexes.map((i) => items[i]).toList();
    });
  }

  // GO TO CUSTOMER DETAILS
  void goToSummaryScreen() {
    if (selectedItems.isEmpty) return;

    Navigator.push(
      context,

      MaterialPageRoute(
        builder:
            (_) => SalesSummaryScreen(
              selectedItems: selectedItems,

              customerName: '',

              customerPhone: '',
            ),
      ),
    );
  }

  // GET ITEMS
  List<ItemModel> getItems() {
    return db.getItems();
  }

  // FILTER ITEMS
  List<ItemModel> getFilteredItems(List<ItemModel> items) {
    return items.where((item) {
      final matchesSearch = item.name.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );

      bool matchesFilter = true;

      switch (selectedFilter) {
        case 'In Stock':
          matchesFilter = item.quantity >= 5;
          break;

        case 'Low Stock':
          matchesFilter = item.quantity > 0 && item.quantity < 5;
          break;

        case 'Out of Stock':
          matchesFilter = item.quantity == 0;
          break;

        default:
          matchesFilter = true;
      }

      return matchesSearch && matchesFilter;
    }).toList();
  }

  // FILTER ITEMS
  Widget buildFilterSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ChoiceChip(
              label: const Text('All'),
              selected: selectedFilter == 'All',
              onSelected: (_) {
                setState(() {
                  selectedFilter = 'All';
                });
              },
            ),

            const SizedBox(width: 8),
            ChoiceChip(
              label: const Text('In Stock'),

              selected: selectedFilter == 'In Stock',

              onSelected: (_) {
                setState(() {
                  selectedFilter = 'In Stock';
                });
              },
            ),

            const SizedBox(width: 8),

            ChoiceChip(
              label: const Text('Low Stock'),
              selected: selectedFilter == 'Low Stock',
              onSelected: (_) {
                setState(() {
                  selectedFilter = 'Low Stock';
                });
              },
            ),

            const SizedBox(width: 8),

            ChoiceChip(
              label: const Text('Out of Stock'),
              selected: selectedFilter == 'Out of Stock',
              onSelected: (_) {
                setState(() {
                  selectedFilter = 'Out of Stock';
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  // APP BAR
  PreferredSizeWidget buildAppBar() {
    return const SalesAppBar();
  }

  // SEARCH FIELD
  Widget buildSearchField() {
    return SalesSearchField(
      controller: searchController,
      onChanged: onSearchChanged,
    );
  }

  // ITEMS LIST
  Widget buildItemsList(List<ItemModel> filteredItems, List<ItemModel> items) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),

        itemCount: filteredItems.length,

        itemBuilder: (context, index) {
          final item = filteredItems[index];

          final originalIndex = items.indexOf(item);

          final isSelected = selectedIndexes.contains(originalIndex);

          return buildItemTile(item, isSelected, originalIndex, items);
        },
      ),
    );
  }

  // ITEM TILE
  Widget buildItemTile(
    ItemModel item,
    bool isSelected,
    int originalIndex,
    List<ItemModel> items,
  ) {
    return SalesItemTile(
      item: item,

      isSelected: isSelected,

      onTap: () {
        onItemTap(item, originalIndex, items);
      },
    );
  }

  // BOTTOM BUTTON
  Widget buildBottomButton() {
    return SalesBottomButton(
      selectedItems: selectedItems,

      totalPrice: totalPrice,

      onTap: goToSummaryScreen,
    );
  }

  // BODY
  Widget buildBody() {
    final items = getItems();

    final filteredItems = getFilteredItems(items);

    return Column(
      children: [
        buildSearchField(),

        buildFilterSection(),

        buildItemsList(filteredItems, items),

        buildBottomButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: buildAppBar(),

      body: buildBody(),
    );
  }
}
