import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/database_hive.dart';
import '../../models/item_model.dart';

class EditItemController {
  final DatabaseApp db = DatabaseApp.instance;

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();

  int quantity = 1;
  String category = ""; 
  List<File> images = [];

  final picker = ImagePicker();

  void loadItem(int index) {
    final item = db.getItems()[index];

    nameController.text = item.name;
    priceController.text = item.price.toString();
    descController.text = "";
    quantity = item.quantity;
    category = item.category;

    if (item.images.isNotEmpty) {
      images = item.images.map((e) => File(e)).toList();
    }
  }

  Future<void> pickImage(Function refresh) async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      images = [File(picked.path)];
      refresh();
    }
  }

  List<String> getCategories() => db.getCategories();

  void deleteItem(int index) {
    db.deleteItem(index);
  }

  void updateItem(int index) {
    final updatedItem = ItemModel(
      name: nameController.text,
      price: int.tryParse(priceController.text) ?? 0,
      quantity: quantity,
      category: category,
      images: images.map((e) => e.path).toList(),
      notes: descController.text,
    );

    db.updateItem(index, updatedItem);
  }
}
