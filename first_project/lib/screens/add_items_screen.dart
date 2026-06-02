import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_application_1/colors/app_colors.dart';
import 'package:flutter_application_1/models/item_model.dart';
import 'package:flutter_application_1/services/database_hive.dart';
import 'package:flutter_application_1/widgets/custom_snackbar.dart';

import 'package:flutter_application_1/widgets/add_item_widget/image_picker_box.dart';
import 'package:flutter_application_1/widgets/add_item_widget/premium_field.dart';
import 'package:flutter_application_1/widgets/add_item_widget/notes_box.dart';

import 'package:flutter_application_1/widgets/add_item_widget/add_item_appbar.dart';
import 'package:flutter_application_1/widgets/add_item_widget/image_preview_list.dart';
import 'package:flutter_application_1/widgets/add_item_widget/catagory_dropdown.dart';
import 'package:flutter_application_1/widgets/add_item_widget/quantity_section.dart';
import 'package:flutter_application_1/widgets/add_item_widget/save_item_button.dart';
import 'package:flutter_application_1/widgets/add_item_widget/image_picker_bottom_sheet.dart';

class AddItemScreen extends StatefulWidget {
  final bool isEdit;
  final int? editIndex;

  const AddItemScreen({super.key, this.isEdit = false, this.editIndex});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final nameController = TextEditingController();

  final priceController = TextEditingController();

  final discController = TextEditingController();

  final quantityController = TextEditingController(text: "1");

  final salePriceController = TextEditingController();

  int quantity = 1;

  String selectedCategory = "General";

  List<File> images = [];

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    if (widget.isEdit && widget.editIndex != null) {
      final item = DatabaseApp().getItems()[widget.editIndex!];

      nameController.text = item.name;

      priceController.text = item.price.toString();

      discController.text = "";

      quantity = item.quantity;

      quantityController.text = quantity.toString();

      selectedCategory = item.category;

      images = item.images.map((e) => File(e)).toList();
    }
  }

  void showImagePickerOptions() {
    showImagePickerBottomSheet(
      context: context,
      picker: picker,
      images: images,
      onUpdate: () {
        setState(() {});
      },
    );
  }

  void removeImage(int index) {
    setState(() {
      images.removeAt(index);
    });
  }

  void increaseQty() {
    setState(() {
      quantity++;

      quantityController.text = quantity.toString();
    });
  }

  void decreaseQty() {
    setState(() {
      if (quantity > 1) {
        quantity--;

        quantityController.text = quantity.toString();
      }
    });
  }

  void onQtyChanged(String value) {
    quantity = int.tryParse(value) ?? 1;

    quantityController.text = quantity.toString();

    quantityController.selection = TextSelection.fromPosition(
      TextPosition(offset: quantityController.text.length),
    );
  }

  void saveItem() {
    if (nameController.text.isEmpty || priceController.text.isEmpty) {
      return CustomSnackBar.show(context, 'Enter required fields');
    }

    final item = ItemModel(
      name: nameController.text,

      price: int.tryParse(priceController.text) ?? 0,

      quantity: quantity,

      category: selectedCategory,

      images: images.map((e) => e.path).toList(),

      notes: discController.text,

      salePrice: salePriceController.text,
    );

    final db = DatabaseApp.instance;

    if (widget.isEdit && widget.editIndex != null) {
      db.updateItem(widget.editIndex!, item);
    } else {
      db.addItem(item);
    }

    Navigator.pop(context, true);
  }

  Widget buildImagePicker() {
    return imagePickerBox(images: images, onTap: showImagePickerOptions);
  }

  Widget buildImagePreview() {
    return ImagePreviewList(images: images, onRemove: removeImage);
  }

  Widget buildProductNameField() {
    return premiumField(
      "Product Name",
      nameController,
      Icons.inventory_2_outlined,
      label: 'Product Name',
    );
  }

  Widget buildPriceField() {
    return premiumField(
      "₹ 70",
      priceController,
      Icons.currency_rupee_rounded,
      label: 'Product Price',
      isNumber: true,
    );
  }

  Widget buildSalePriceField() {
    return premiumField(
      "₹ 80", 
      salePriceController,
      Icons.sell_outlined,
      label: 'Sale Price (Optional)',
      isNumber: true,
    );
  }

  Widget buildCategoryDropdown() {
    return CategoryDropdown(
      selectedCategory: selectedCategory,

      onChanged: (value) {
        setState(() {
          selectedCategory = value;
        });
      },
    );
  }

  Widget buildQuantitySection() {
    return QuantitySection(
      quantity: quantity,

      controller: quantityController,

      onIncrease: increaseQty,

      onDecrease: decreaseQty,

      onChanged: onQtyChanged,
    );
  }

  Widget buildNotesBox() {
    return notesBox(discController);
  }

  Widget buildSaveButton() {
    return SaveItemButton(onTap: saveItem);
  }

  Widget buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          buildImagePicker(),

          const SizedBox(height: 14),

          if (images.isNotEmpty) buildImagePreview(),

          const SizedBox(height: 22),

          buildProductNameField(),

          const SizedBox(height: 16),

          buildPriceField(),

          const SizedBox(height: 16),

          buildSalePriceField(),

          const SizedBox(height: 16),

          buildCategoryDropdown(),

          const SizedBox(height: 16),

          buildQuantitySection(),

          const SizedBox(height: 16),

          buildNotesBox(),

          const SizedBox(height: 30),

          buildSaveButton(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AddItemAppBar(isEdit: widget.isEdit),

      body: buildBody(),
    );
  }
}
