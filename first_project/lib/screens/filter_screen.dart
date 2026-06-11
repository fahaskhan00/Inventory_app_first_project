import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';
import 'package:flutter_application_1/services/database_hive.dart';
import '../widgets/filter_widget.dart';
import '../widgets/filter_screen_widget/header.dart';
import '../widgets/filter_screen_widget/title.dart';
import '../widgets/filter_screen_widget/chip_wrap.dart';
import '../widgets/filter_screen_widget/empty.dart';
import '../widgets/filter_screen_widget/reset_button.dart';
import '../widgets/filter_screen_widget/apply_button.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int selectedSort = 0;

  int selectedStock = 0;

  int selectedCategory = -1;
  int selectedPrice = 0;

  final List<String> sortOptions = [
    "Name (A-Z)",
    "Quantity (High-Low)",
    "Newest First",
  ];

  List<String> categories = [];

  final List<String> stockOptions = ["All", "In Stock", "Low Stock"];
  final List<String> priceOptions = [
    "All",
    "Below ₹1,000",
    "₹1,000 - ₹5,000",
    "₹5,000 - ₹10,000",
    "Above ₹10,000",
  ];

  @override
  void initState() {
    super.initState();

    loadCategories();
  }

  // LOAD CATEGORIES
  void loadCategories() {
    final db = DatabaseApp.instance;

    final List<String> loadedCategories = List<String>.from(db.getCategories());

    setState(() {
      categories = loadedCategories;
    });
  }

  // APPY FILTERS
  void applyFilters() {
    Navigator.pop(context, {
      "sort": selectedSort,

      "stock": selectedStock,

      "price": selectedPrice,

      "category": selectedCategory == -1 ? null : categories[selectedCategory],
    });
  }

  // RESET FILTERS
  void resetFilters() {
    setState(() {
      selectedSort = 0;

      selectedStock = 0;

      selectedPrice = 0;

      selectedCategory = -1;
    });
  }

  // SORT SECTION
  Widget buildSortSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const FilterSectionTitle(title: "SORT BY"),

        const SizedBox(height: 12),

        FilterChipWrap(
          list: sortOptions,

          selectedIndex: selectedSort,

          onTap: (i) {
            setState(() {
              selectedSort = i;
            });
          },
        ),
      ],
    );
  }

  // CATEGORY SECTION
  Widget buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const FilterSectionTitle(title: "CATEGORY"),

        const SizedBox(height: 12),

        categories.isEmpty
            ? const EmptyCategoryText()
            : FilterChipWrap(
              list: categories,

              selectedIndex: selectedCategory,

              onTap: (i) {
                setState(() {
                  selectedCategory = i;
                });
              },
            ),
      ],
    );
  }

  // STOCK SECTION
  Widget buildStockSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const FilterSectionTitle(title: "STOCK LEVEL"),

        const SizedBox(height: 12),

        FilterChipWrap(
          list: stockOptions,

          selectedIndex: selectedStock,

          onTap: (i) {
            setState(() {
              selectedStock = i;
            });
          },
        ),
      ],
    );
  }

  Widget buildPriceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const FilterSectionTitle(title: "PRICE RANGE"),

        const SizedBox(height: 12),

        FilterChipWrap(
          list: priceOptions,

          selectedIndex: selectedPrice,

          onTap: (i) {
            setState(() {
              selectedPrice = i;
            });
          },
        ),
      ],
    );
  }

  // BOTTOM BUTTONS
  Widget buildBottomButtons() {
    return Row(
      children: [
        ResetButton(onTap: resetFilters),

        const Spacer(),

        ApplyFilterButton(onTap: applyFilters),
      ],
    );
  }

  // BODY
  Widget buildBody() {
    return Column(
      children: [
        dragHandle(),

        const SizedBox(height: 10),

        FilterHeader(
          onClose: () {
            Navigator.pop(context);
          },
        ),

        const SizedBox(height: 20),

        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                buildSortSection(),

                const SizedBox(height: 24),

                buildCategorySection(),

                const SizedBox(height: 24),

                buildStockSection(),

                const SizedBox(height: 24),

                buildPriceSection(),
              ],
            ),
          ),
        ),

        buildBottomButtons(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),

      height: MediaQuery.of(context).size.height * 0.75,

      decoration: const BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),

      child: buildBody(),
    );
  }
}
