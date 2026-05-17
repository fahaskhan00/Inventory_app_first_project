import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/models/item_model.dart';

class DatabaseApp {
  static final DatabaseApp instance = DatabaseApp.internal();

  DatabaseApp.internal();

  factory DatabaseApp() => instance;

  Box get categoryBox => Hive.box('categoriesBox');
  Box get itemBox => Hive.box('itemsBox');

  //  CATEGORY

  void addCategory(String name) {
    categoryBox.add(name);
  }

  void deleteCategory(int index) {
    categoryBox.deleteAt(index);
  }

  List<String> getCategories() {
    return categoryBox.values.cast<String>().toList();
  }

  ValueListenable<Box> categoryListenable() {
    return categoryBox.listenable();
  }

  int getCategoryCount() {                                                                                      
    return categoryBox.length;
  }

  //  ITEMS

  void addItem(ItemModel item) {
    itemBox.add(item.toMap());
  }

  List<ItemModel> getItems() {
    return itemBox.values.map((e) {
      return ItemModel.fromMap(Map<String, dynamic>.from(e));
    }).toList();
  }

  ValueListenable<Box> itemListenable() {
    return itemBox.listenable();
  }

  void deleteItem(int index) {
    itemBox.deleteAt(index);
  }

  void updateCategory(int index, String newName) {
    categoryBox.putAt(index, newName);
  }

  void updateItem(int index, ItemModel newItem) {
    itemBox.putAt(index, newItem.toMap());
  }
}
