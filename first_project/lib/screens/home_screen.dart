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
import '../widgets/home_screen_widgets/bottom_nav_bar.dart';
import '../widgets/home_screen_widgets/appbar.dart';
import '../widgets/home_screen_widgets/dash_stat_section.dart';
import '../widgets/home_screen_widgets/item_list.dart';
import '../widgets/home_screen_widgets/empty_item.dart';
import '../widgets/home_screen_widgets/floating_button.dart';

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

  // CHANGE TAB
  void changeTab(int index) {
    setState(() {
      currentIndex = index;
    });
  }
@override
Widget build(BuildContext context) {
  final isDesktop =
      MediaQuery.of(context).size.width > 900;

  if (isDesktop) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: currentIndex,

            onDestinationSelected: changeTab,

            labelType:
                NavigationRailLabelType.all,

            backgroundColor:
                AppColors.bottomNav,

            selectedIconTheme:
                const IconThemeData(
                  color: AppColors.primary,
                ),

            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Home'),
              ),

              NavigationRailDestination(
                icon: Icon(Icons.list),
                label: Text('Items'),
              ),

              NavigationRailDestination(
                icon: Icon(Icons.category),
                label: Text('Categories'),
              ),

              NavigationRailDestination(
                icon: Icon(Icons.bar_chart),
                label: Text('Sales'),
              ),

              NavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text('Settings'),
              ),
            ],
          ),

          const VerticalDivider(
            thickness: 1,
            width: 1,
          ),

          Expanded(
            child: screens[currentIndex],
          ),
        ],
      ),
    );
  }

  return Scaffold(
    body: screens[currentIndex],

    bottomNavigationBar: HomeBottomNavbar(
      currentIndex: currentIndex,

      onTap: changeTab,
    ),
  );
}
}

class HomeUI extends StatelessWidget {
  HomeUI({super.key});

  final DatabaseApp db = DatabaseApp();

  // GO TO ADD SCREEN
  Future<void> goToAddScreen(BuildContext context) async {
    await Navigator.push(
      context,

      MaterialPageRoute(builder: (context) => AddItemScreen()),
    );
  }

  // GO TO ITEMS
  void goToItems(BuildContext context) {
    Navigator.push(
      context,

      MaterialPageRoute(builder: (context) => ItemsScreen()),
    );
  }

  // GO TO CATEGORY
  void goToCategory(BuildContext context) {
    Navigator.push(
      context,

      MaterialPageRoute(builder: (context) => CategoriesScreen()),
    );
  }

  // GO TO LOW STOCK
  void goToLowStock(BuildContext context) {
    Navigator.push(
      context,

      MaterialPageRoute(builder: (context) => LowStockScreen()),
    );
  }

  // GO TO OUT STOCK
  void goToOutStock(BuildContext context) {
    Navigator.push(
      context,

      MaterialPageRoute(builder: (context) => OutOfStockScreen()),
    );
  }

  // GO TO DETAIL
  void goToDetail(BuildContext context, dynamic item, int originalIndex) {
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
  void deleteItem(BuildContext context, int originalIndex) {
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

  // EMPTY WIDGET
  Widget buildEmptyWidget() {
    return const EmptyItemWidget();
  }

  // ITEM LIST
  Widget buildItemList(BuildContext context) {
    return DashboardItemList(
      db: db,

      onTap: (item, originalIndex) {
        goToDetail(context, item, originalIndex);
      },

      onLongPress: (originalIndex) {
        deleteItem(context, originalIndex);
      },
    );
  }

  // BODY
  Widget buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            const HomeAppBar(),

            const SizedBox(height: 24),

            DashboardStatsSection(
              db: db,

              onItemsTap: () {
                goToItems(context);
              },

              onCategoryTap: () {
                goToCategory(context);
              },

              onLowStockTap: () {
                goToLowStock(context);
              },

              onOutStockTap: () {
                goToOutStock(context);
              },
            ),

            const SizedBox(height: 24),

            Expanded(
              child: ValueListenableBuilder(
                valueListenable: db.itemListenable(),

                builder: (context, box, _) {
                  final items = db.getItems();

                  if (items.isEmpty) {
                    return buildEmptyWidget();
                  }

                  return buildItemList(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      floatingActionButton: FloatingAddButton(
        onTap: () {
          goToAddScreen(context);
        },
      ),

      body: buildBody(context),
    );
  }
}
