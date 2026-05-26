import 'package:flutter/material.dart';

import 'package:flutter_application_1/colors/app_colors.dart';

class HomeBottomNavbar
    extends StatelessWidget {
  final int currentIndex;

  final Function(int) onTap;

  const HomeBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bottomNav,

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(
              0.05,
            ),

            blurRadius: 10,

            offset: const Offset(
              0,
              -2,
            ),
          ),
        ],
      ),

      child: BottomNavigationBar(
        type:
            BottomNavigationBarType
                .fixed,

        backgroundColor:
            AppColors.bottomNav,

        currentIndex:
            currentIndex,

        selectedItemColor:
            AppColors.primary,

        unselectedItemColor:
            AppColors.subtitle,

        selectedLabelStyle:
            const TextStyle(
              fontWeight:
                  FontWeight.w600,
            ),

        onTap: onTap,

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
    );
  }
}