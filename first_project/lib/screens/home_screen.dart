import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';
import 'package:flutter_application_1/screens/add_items_screen.dart';
import 'package:flutter_application_1/screens/catagories.dart';
import 'package:flutter_application_1/screens/detail_screen.dart';
import 'package:flutter_application_1/screens/item_screen.dart';
import 'package:flutter_application_1/screens/low_stock_screen.dart';
import 'package:flutter_application_1/screens/out_stock_screen.dart';
import 'package:flutter_application_1/screens/sales_screen.dart';
import 'package:flutter_application_1/screens/settings_screen.dart';
import 'package:flutter_application_1/services/database_hive.dart';
import 'package:flutter_application_1/widgets/delete_dialog.dart';
import '../widgets/home_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final List<Widget> screens = [
    HomeUI(),
    ItemsScreen(),
    CategoriesScreen(),
    SalesScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.bottomNav,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.bottomNav,
         
          currentIndex: currentIndex,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.subtitle,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'items',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'sales',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'settings',
            ),
          ],
        ),
      ),
    );
  }
}

class HomeUI extends StatelessWidget {
  HomeUI({super.key});

  final DatabaseApp db = DatabaseApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddItemScreen(),
            ),
          );
        },
        backgroundColor: AppColors.primary,
        elevation: 5,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              /// HEADER
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.primary
                              .withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.inventory_2_outlined,
                          color: AppColors.primary,
                        ),
                      ),

                      const SizedBox(width: 12),

                      const Text(
                        "MyInventory",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.text,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// STATS
              Row(
                children: [
                Expanded(
  child: GestureDetector(

    onTap: () {

      Navigator.push(
        context,

        MaterialPageRoute(
          builder:
              (context) =>
                  ItemsScreen(),
        ),
      );
    },

    child: ValueListenableBuilder(
      valueListenable:
          db.itemListenable(),

      builder: (context, box, _) {

        final totalItems =
            db.getItems().length;

        return statCard(
          'Total Items',

          totalItems.toString(),

          Icons.list_alt_outlined,

          AppColors.primary,
        );
      },
    ),
  ),
),

                  const SizedBox(width: 12),

                 Expanded(
  child: GestureDetector(

    onTap: () {

      Navigator.push(
        context,

        MaterialPageRoute(
          builder:
              (context) =>
                  CategoriesScreen(),
        ),
      );
    },

    child: ValueListenableBuilder(
      valueListenable:
          db.categoryListenable(),

      builder: (context, box, _) {

        return statCard(
          "CATEGORIES",

          db.getCategoryCount()
              .toString(),

          Icons.folder_outlined,

          AppColors.secondary,
        );
      },
    ),
  ),
),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
  child: GestureDetector(

    onTap: () {

      Navigator.push(
        context,

        MaterialPageRoute(
          builder:
              (context) =>
                  LowStockScreen(),
        ),
      );
    },

    child: ValueListenableBuilder(
                      valueListenable: db.itemListenable(),
                      builder: (context, box, _) {
                        final items = db.getItems();

                        final lowStockCount = items
                            .where(
                              (item) =>
                                  item.quantity < 5,
                            )
                            .length;

                        return statCard(
                          "LOW STOCK",
                          lowStockCount.toString(),
                          Icons.warning_amber_rounded,
                          AppColors.danger,
                        );
                      },
                    ),
                  ),),

                  const SizedBox(width: 12),

                  Expanded(
  child: GestureDetector(

    onTap: () {

      Navigator.push(
        context,

        MaterialPageRoute(
          builder:
              (context) =>
                  OutOfStockScreen(),
        ),
      );
    },

    child: ValueListenableBuilder(
      valueListenable:
          db.itemListenable(),

      builder: (context, box, _) {

        final items =
            db.getItems();

        final outOfStockCount =
            items.where(
              (item) =>
                  item.quantity == 0,
            ).length;

        return statCard(
          "OUT OF STOCK",

          outOfStockCount
              .toString(),

          Icons.remove_shopping_cart,

          AppColors.warning,
        );
      },
    ),
  ),
),
                ],
              ),

              const SizedBox(height: 24),

              /// ITEMS
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: db.itemListenable(),
                  builder: (context, box, _) {
                   final items =
    db.getItems().reversed.toList();

                    if (items.isEmpty) {
                      return Center(
                        child: Text(
                          "No items added",
                          style: TextStyle(
                            color: AppColors.subtitle,
                            fontSize: 16,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index]; 

final originalIndex =
    db.getItems().indexWhere(
      (e) =>
          e.name == item.name &&
          e.price == item.price &&
          e.quantity == item.quantity,
    );

                        final imagePath =
                            item.images.isNotEmpty
                                ? item.images[0]
                                : "";

                        return itemTile(
                          item: item,
                          imagePath: imagePath,

                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailScreen(
                                  name: item.name,
                                  price:
                                      item.price.toString(),
                                  stock:
                                      "Stock: ${item.quantity}",
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
                              builder: (context) =>
                                  DeleteDialog(
                                onDelete: () {
                                db.deleteItem(originalIndex);
                                },
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}