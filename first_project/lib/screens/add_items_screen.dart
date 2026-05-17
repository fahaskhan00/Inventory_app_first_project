import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_application_1/colors/app_colors.dart';
import 'package:flutter_application_1/models/item_model.dart';
import 'package:flutter_application_1/services/database_hive.dart';
import 'package:flutter_application_1/widgets/custom_snackbar.dart';
import 'package:flutter/services.dart';

import 'package:flutter_application_1/widgets/add_item_widget/image_picker_box.dart';
import 'package:flutter_application_1/widgets/add_item_widget/premium_field.dart';

import 'package:flutter_application_1/widgets/add_item_widget/notes_box.dart';

import 'add_categories.dart';

class AddItemScreen extends StatefulWidget {
  final bool isEdit;
  final int? editIndex;

  const AddItemScreen({super.key, this.isEdit = false, this.editIndex});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();

  
}

class _AddItemScreenState extends State<AddItemScreen> {
  /// =========================
  /// CONTROLLERS
  /// =========================
  final nameController = TextEditingController();

  final priceController = TextEditingController();

  final discController = TextEditingController();
  final quantityController = TextEditingController(text: "1");
  final salePriceController = TextEditingController();

  /// =========================
  /// VARIABLES
  /// =========================
  int quantity = 1;

  String selectedCategory = "General";

  List<File> images = [];

  final picker = ImagePicker();

  /// =========================
  /// INIT STATE
  /// =========================
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

  /// =========================
  /// IMAGE PICKER OPTIONS
  /// =========================
  void showImagePickerOptions() {
    showModalBottomSheet(
      context: context,

      backgroundColor: Colors.white,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),

      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(18),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              Container(
                width: 45,
                height: 5,

                decoration: BoxDecoration(
                  color: Colors.grey.shade300,

                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              const SizedBox(height: 24),

              /// CAMERA
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),

                leading: Container(
                  padding: const EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.10),

                    borderRadius: BorderRadius.circular(14),
                  ),

                  child: const Icon(
                    Icons.camera_alt_outlined,
                    color: AppColors.primary,
                  ),
                ),

                title: const Text(
                  "Take Photo",

                  style: TextStyle(
                    fontWeight: FontWeight.w600,

                    color: AppColors.text,
                  ),
                ),

                onTap: () async {
                  Navigator.pop(context);

                  final picked = await picker.pickImage(
                    source: ImageSource.camera,
                  );

                  if (picked != null) {
                    setState(() {
                      images.add(File(picked.path));
                    });
                  }
                },
              ),

              const SizedBox(height: 10),

              /// GALLERY
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),

                leading: Container(
                  padding: const EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.10),

                    borderRadius: BorderRadius.circular(14),
                  ),

                  child: const Icon(
                    Icons.photo_library_outlined,
                    color: AppColors.success,
                  ),
                ),

                title: const Text(
                  "Choose From Gallery",

                  style: TextStyle(
                    fontWeight: FontWeight.w600,

                    color: AppColors.text,
                  ),
                ),

                onTap: () async {
                  Navigator.pop(context);

                  final picked = await picker.pickMultiImage();

                  if (picked.isNotEmpty) {
                    setState(() {
                      images.addAll(picked.map((e) => File(e.path)));
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// =========================
  /// BUILD
  /// =========================
  @override
  Widget build(BuildContext context) {
    final db = DatabaseApp.instance;

    final categories = db.getCategories();

    return Scaffold(
      backgroundColor: AppColors.background,

      /// =========================
      /// APP BAR
      /// =========================
      appBar: AppBar(
        elevation: 0,

        centerTitle: true,

        backgroundColor: Colors.white,

        surfaceTintColor: Colors.white,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },

          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,

            color: AppColors.text,
            size: 20,
          ),
        ),

        title: Text(
          widget.isEdit ? "Edit Item" : "Add Item",

          style: const TextStyle(
            color: AppColors.text,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      /// =========================
      /// BODY
      /// =========================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            /// IMAGE PICKER
           /// IMAGE PICKER
imagePickerBox(
  images: images,
  onTap: showImagePickerOptions,
),

const SizedBox(height: 14),

/// SELECTED IMAGES PREVIEW
if (images.isNotEmpty)
  SizedBox(
    height: 95,

    child: ListView.separated(
      scrollDirection: Axis.horizontal,

      itemCount: images.length,

      separatorBuilder: (_, __) => const SizedBox(width: 12),

      itemBuilder: (context, index) {
        return Stack(
          clipBehavior: Clip.none,

          children: [
            /// IMAGE
            Container(
              width: 95,
              height: 95,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),

                border: Border.all(
                  color: Colors.grey.shade200,
                ),

                image: DecorationImage(
                  image: FileImage(images[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            /// REMOVE BUTTON
            Positioned(
              top: -8,
              right: -8,

              child: GestureDetector(
                onTap: () {
                  setState(() {
                    images.removeAt(index);
                  });
                },

                child: Container(
                  padding: const EdgeInsets.all(6),

                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ),
  ),

const SizedBox(height: 22),
            /// PRICE FIELD
          /// PRODUCT NAME FIELD
premiumField(
  "Product Name",
  nameController,
  Icons.inventory_2_outlined,

  label: 'Product Name',
),

const SizedBox(height: 16),

/// PRODUCT PRICE FIELD
premiumField(
  "₹ 70",
  priceController,
  Icons.currency_rupee_rounded,

  label: 'Product Price',

  isNumber: true,
),

const SizedBox(height: 16),

/// SALE PRICE FIELD
premiumField(
  "₹ 80",
  salePriceController,
  Icons.sell_outlined,

  label: 'Sale Price (Optional)',

  isNumber: true,
),

const SizedBox(height: 16),
            /// CATEGORY DROPDOWN
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(22),

                border: Border.all(color: Colors.grey.shade200),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),

                    blurRadius: 8,

                    offset: const Offset(0, 3),
                  ),
                ],
              ),

              child: DropdownButton<String>(
                value:
                    categories.isNotEmpty
                        ? (categories.contains(selectedCategory)
                            ? selectedCategory
                            : categories.first)
                        : null,

                isExpanded: true,

                underline: const SizedBox(),

                dropdownColor: Colors.white,

                style: const TextStyle(
                  color: AppColors.text,
                  fontWeight: FontWeight.w500,
                ),

                items: [
                  ...categories.toSet().map(
                    (e) => DropdownMenuItem<String>(
                      value: e,

                      child: Text(
                        e,

                        style: const TextStyle(color: AppColors.text),
                      ),
                    ),
                  ),

                  const DropdownMenuItem<String>(
                    value: "add_new",

                    child: Text("➕ Add Category"),
                  ),
                ],

                onChanged: (value) async {
                  if (value == "add_new") {
                    final newCategory = await Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (context) => AddCategoryScreen(),
                      ),
                    );

                    if (newCategory != null) {
                      db.addCategory(newCategory);

                      setState(() {
                        selectedCategory = newCategory;
                      });
                    }

                    return;
                  }

                  setState(() {
                    selectedCategory = value!;
                  });
                },
              ),
            ),

            const SizedBox(height: 16),

            /// QUANTITY BOX
          /// QUANTITY SECTION
Container(
  padding: const EdgeInsets.symmetric(
    horizontal: 18,
    vertical: 16,
  ),

  decoration: BoxDecoration(
    color: Colors.white,

    borderRadius: BorderRadius.circular(22),

    border: Border.all(
      color: Colors.grey.shade200,
    ),

    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.03),
        blurRadius: 8,
        offset: const Offset(0, 3),
      ),
    ],
  ),

  child: Row(
    children: [
      /// TITLE
      const Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              "Quantity",

              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.text,
              ),
            ),

            SizedBox(height: 4),

            Text(
              "Add available stock",

              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),

      /// MINUS BUTTON
      GestureDetector(
        onTap: () {
          setState(() {
            if (quantity > 1) {
             quantity--;

quantityController.text = quantity.toString();
            }
          });
        },

        child: Container(
          width: 38,
          height: 38,

          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),

          child: const Icon(Icons.remove),
        ),
      ),

      const SizedBox(width: 10),

      /// MANUAL INPUT
      SizedBox(
        width: 70,

        child: TextFormField(
         controller: quantityController,
         keyboardType: TextInputType.number,

inputFormatters: [
  FilteringTextInputFormatter.digitsOnly,
],

          textAlign: TextAlign.center,

          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 10),

            filled: true,
            fillColor: Colors.grey.shade100,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),

          onChanged: (value) {
           quantity = int.tryParse(value) ?? 1;

quantityController.text = quantity.toString();

quantityController.selection = TextSelection.fromPosition(
  TextPosition(offset: quantityController.text.length),
);
          },
        ),
      ),

      const SizedBox(width: 10),

      /// PLUS BUTTON
      GestureDetector(
        onTap: () {
          setState(() {
           quantity++;

quantityController.text = quantity.toString();
          });
        },

        child: Container(
          width: 38,
          height: 38,

          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),

          child: const Icon(
            Icons.add,
            color: AppColors.primary,
          ),
        ),
      ),
    ],
  ),
),
            const SizedBox(height: 16),

            /// NOTES BOX
            notesBox(discController),

            const SizedBox(height: 30),

            /// SAVE BUTTON
            SizedBox(
              width: double.infinity,
              height: 58,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,

                  backgroundColor: AppColors.primary,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),

                onPressed: () {
                  if (nameController.text.isEmpty ||
                      priceController.text.isEmpty) {
                    return CustomSnackBar.show(
                      context,
                      'Enter required fields',
                    );
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

                  if (widget.isEdit && widget.editIndex != null) {
                    db.updateItem(widget.editIndex!, item);
                  } else {
                    db.addItem(item);
                  }

                  Navigator.pop(context, true);
                },

                child: const Text(
                  "Save Item",

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
