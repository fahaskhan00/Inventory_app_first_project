//==================== settings_service.dart ====================//

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingsService {
  //==================== SHOW CLEAR DIALOG ====================//

  static Future<void> showClearDialog(BuildContext context) async {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text('Clear All Data'),

          content: const Text('Are you sure you want to delete all app data?'),

          actions: [
            //==================== CANCEL BUTTON ====================//
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text('Cancel'),
            ),

            //==================== CLEAR BUTTON ====================//
            ElevatedButton(
              onPressed: () async {
                await clearAppData();

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('All data cleared successfully'),
                  ),
                );
              },

              child: const Text('Clear'),
            ),
          ],
        );
      },
    );
  }

  //==================== CLEAR APP DATA ====================//

  static Future<void> clearAppData() async {
    print("DATA CLEARED");

    //==================== PRODUCT BOX ====================//

    await Hive.box('productBox').clear();

    //==================== CATEGORY BOX ====================//

    await Hive.box('categoriesBox').clear();

    //==================== ITEMS BOX ====================//

    await Hive.box('itemsBox').clear();

    //==================== SALES BOX ====================//

    await Hive.box('salesBox').clear();

    //==================== APP BOX ====================//

    await Hive.box('appBox').clear();
  }
}
