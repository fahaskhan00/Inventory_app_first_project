import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_1/colors/app_colors.dart';
import 'package:flutter_application_1/models/item_model.dart';
import 'package:flutter_application_1/services/database_hive.dart';
import 'package:flutter_application_1/widgets/add_item_widget/premium_field.dart';
import 'package:flutter_application_1/widgets/edit_screen_widget/appbar.dart';
import 'package:flutter_application_1/widgets/edit_screen_widget/image_section.dart';
import 'package:flutter_application_1/widgets/edit_screen_widget/notes_field.dart';
import 'package:flutter_application_1/widgets/edit_screen_widget/catagories_dropdown.dart';
import 'package:flutter_application_1/widgets/edit_screen_widget/quantity.dart';
import 'package:flutter_application_1/widgets/edit_screen_widget/update.dart';
import 'package:flutter_application_1/widgets/edit_screen_widget/image_picker_bottom_sheet.dart';

class EditItemScreen extends StatefulWidget {
  final int index;

  const EditItemScreen({super.key, required this.index});

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  // CONTROLLERS
  final nameController = TextEditingController();

  final priceController = TextEditingController();

  final descController = TextEditingController();

  final salePriceController = TextEditingController();

  final quantityController = TextEditingController();

  // QUANTITY
  int quantity = 1;

  // CATEGORY
  String category = "";

  // IMAGES
  List<File> images = [];

  // PICKER
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    final item = DatabaseApp.instance.getItems()[widget.index];

    nameController.text = item.name;

    priceController.text = item.price.toString();

    salePriceController.text = item.salePrice ?? '';

    descController.text = item.notes;

    quantity = item.quantity;

    quantityController.text = quantity.toString();

    category = item.category;

    if (item.images.isNotEmpty) {
      images = item.images.map((e) => File(e)).toList();
    }
  }

  // PICK IMAGE
  void pickImage() async {
    showImagePickerBottomSheet(
      context: context,
      picker: picker,
      images: images,

      onUpdate: () {
        setState(() {});
      },
    );
  }

  // REMOVE IMAGE
  void removeImage(int index) {
    setState(() {
      images.removeAt(index);
    });
  }

  // UPDATE ITEM
  void updateItem() {
    final updatedItem = ItemModel(
      name: nameController.text,

      price: int.tryParse(priceController.text) ?? 0,

      quantity: quantity,

      category: category,

      images: images.map((e) => e.path).toList(),

      notes: descController.text,

      salePrice: salePriceController.text,
    );

    DatabaseApp.instance.updateItem(widget.index, updatedItem);

    Navigator.pop(context, true);
  }

  // GET CATEGORIES
  List getCategories() {
    return DatabaseApp.instance.getCategories();
  }

  // APP BAR
  PreferredSizeWidget buildAppBar() {
    return const EditItemAppBar();
  }

  // IMAGE SECTION
  Widget buildImageSection() {
    return EditImageSection(
      images: images,

      onTap: pickImage,

      onRemove: removeImage,
    );
  }

  // NAME FIELD
  Widget buildNameField() {
    return premiumField("Item Name", nameController, Icons.edit);
  }

  // PRICE FIELD
  Widget buildPriceField() {
    return premiumField("Price", priceController, Icons.currency_rupee);
  }

  // SALE PRICE FIELD
  Widget buildSalePriceField() {
    return premiumField("Sale Price", salePriceController, Icons.sell_outlined);
  }

  // NOTES FIELD
  Widget buildNotesField() {
    return EditNotesField(controller: descController);
  }

  // CATEGORY DROPDOWN
  Widget buildCategoryDropdown() {
    return EditCategoryDropdown(
      category: category,

      categories: getCategories(),

      onChanged: (value) {
        setState(() {
          category = value!;
        });
      },
    );
  }

  // QUANTITY SECTION
  Widget buildQuantitySection() {
    return EditQuantitySection(
      quantity: quantity,

      controller: quantityController,

      onIncrease: () {
        setState(() {
          quantity++;

          quantityController.text = quantity.toString();
        });
      },

      onDecrease: () {
        setState(() {
          if (quantity > 1) {
            quantity--;

            quantityController.text = quantity.toString();
          }
        });
      },

      onChanged: (value) {
        setState(() {
          quantity = int.tryParse(value) ?? 0;
        });
      },
    );
  }

  // UPDATE BUTTON
  Widget buildUpdateButton() {
    return UpdateItemButton(onTap: updateItem);
  }

  // BODY
  Widget buildBody() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildImageSection(),

                Container(
                  padding: const EdgeInsets.all(16),

                  child: Column(
                    children: [
                      buildNameField(),

                      const SizedBox(height: 12),

                      buildPriceField(),

                      const SizedBox(height: 12),

                      buildSalePriceField(),

                      const SizedBox(height: 12),

                      buildNotesField(),

                      const SizedBox(height: 12),

                      buildCategoryDropdown(),

                      const SizedBox(height: 12),

                      buildQuantitySection(),

                      const SizedBox(height: 24),

                      buildUpdateButton(),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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
