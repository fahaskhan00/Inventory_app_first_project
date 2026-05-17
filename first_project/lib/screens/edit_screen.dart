import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/database_hive.dart';
import '../models/item_model.dart';
import 'package:flutter/services.dart';
class EditItemScreen extends StatefulWidget {
  final int index;

  const EditItemScreen({super.key, required this.index});

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final nameController = TextEditingController();

  final priceController = TextEditingController();

  final descController = TextEditingController();
  final salePriceController = TextEditingController();

  int quantity = 1;

  String category = "";

  List<File> images = [];

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

    category = item.category;

    if (item.images.isNotEmpty) {
      images = item.images.map((e) => File(e)).toList();
    }
  }

  void pickImage() async {
    showModalBottomSheet(
      context: context,

      backgroundColor: Colors.white,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),

      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                  color: Color(0xFFFF8C42),
                ),

                title: const Text(
                  "Gallery",

                  style: TextStyle(color: Colors.black),
                ),

                onTap: () async {
                  Navigator.pop(context);

                  final pickedFiles = await picker.pickMultiImage();

                  if (pickedFiles.isNotEmpty) {
                    setState(() {
                      images.addAll(pickedFiles.map((e) => File(e.path)));
                    });
                  }
                },
              ),

              ListTile(
                leading: const Icon(Icons.camera_alt, color: Color(0xFFFF8C42)),

                title: const Text(
                  "Camera",

                  style: TextStyle(color: Colors.black),
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
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final db = DatabaseApp.instance;

    final categories = db.getCategories();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      appBar: AppBar(
        elevation: 0,

        toolbarHeight: 65,

        backgroundColor: Colors.transparent,

        iconTheme: const IconThemeData(color: Colors.black),

        title: const Text(
          "Edit Item",

          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),

        centerTitle: true,
      ),

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  /// IMAGE SECTION
                  GestureDetector(
                    onTap: pickImage,

                    child: Container(
                      width: double.infinity,

                      padding: const EdgeInsets.all(10),

                      margin: const EdgeInsets.all(10),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(22),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withOpacity(0.08),

                            blurRadius: 14,

                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),

                      child: Column(
                        children: [
                          Container(
                            height: 180,

                            width: double.infinity,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),

                              color: const Color(0xFFFFF3E8),
                            ),

                            child:
                                images.isEmpty
                                    ? const Center(
                                      child: Icon(
                                        Icons.image,

                                        size: 40,

                                        color: Color(0xFFFF8C42),
                                      ),
                                    )
                                    : ClipRRect(
                                      borderRadius: BorderRadius.circular(18),

                                      child: Image.file(
                                        images.last,

                                        fit: BoxFit.cover,

                                        width: double.infinity,
                                      ),
                                    ),
                          ),

                          const SizedBox(height: 10),

                          if (images.isNotEmpty)
                            SizedBox(
                              height: 80,

                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,

                                itemCount: images.length,

                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      Container(
                                        width: 70,

                                        height: 70,

                                        margin: const EdgeInsets.only(right: 8),

                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),

                                          image: DecorationImage(
                                            image: FileImage(images[index]),

                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),

                                      Positioned(
                                        top: 2,

                                        right: 10,

                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              images.removeAt(index);
                                            });
                                          },

                                          child: Container(
                                            padding: const EdgeInsets.all(3),

                                            decoration: const BoxDecoration(
                                              color: Colors.black54,

                                              shape: BoxShape.circle,
                                            ),

                                            child: const Icon(
                                              Icons.close,

                                              size: 14,

                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),

                          const SizedBox(height: 8),

                          Text(
                            "Tap to add images",

                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// FORM SECTION
                  Container(
                    padding: const EdgeInsets.all(16),

                    child: Column(
                      children: [
                        premiumField("Item Name", nameController, Icons.edit,),

                        const SizedBox(height: 12),

                        premiumField(
                          "Price",
                          
                          priceController,
                          Icons.currency_rupee,
                        ),
const SizedBox(height: 12),

premiumField(
  "Sale Price",

  salePriceController,
  Icons.sell_outlined,
),
                        const SizedBox(height: 12),

                        Container(
                          padding: const EdgeInsets.all(16),

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),

                            color: Colors.white,

                            boxShadow: [
                              BoxShadow(
                                color: Colors.orange.withOpacity(0.08),

                                blurRadius: 14,

                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),

                          child: TextField(
                            
                            controller: descController,

                            maxLines: 4,

                            style: const TextStyle(color: Colors.black),

                            decoration: InputDecoration(
                              label: Text('notes'),
                              hintText: "Enter notes...",

                              hintStyle: TextStyle(color: Colors.grey.shade500),

                              border: InputBorder.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14),

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),

                            color: Colors.white,

                            boxShadow: [
                              BoxShadow(
                                color: Colors.orange.withOpacity(0.08),

                                blurRadius: 14,

                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),

                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              dropdownColor: Colors.white,

                              value:
                                  categories.contains(category)
                                      ? category
                                      : null,

                              isExpanded: true,

                              hint: Text(
                                "Select Category",

                                style: TextStyle(color: Colors.grey.shade500),
                              ),

                              style: const TextStyle(color: Colors.black),

                              items:
                                  categories.map((e) {
                                    return DropdownMenuItem(
                                      value: e,

                                      child: Text(e),
                                    );
                                  }).toList(),

                              onChanged: (val) {
                                setState(() {
                                  category = val!;
                                });
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),
Container(
  padding: const EdgeInsets.all(14),

  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),

    color: Colors.white,

    boxShadow: [
      BoxShadow(
        color: Colors.orange.withOpacity(0.08),

        blurRadius: 14,

        offset: const Offset(0, 6),
      ),
    ],
  ),

  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,

    children: [
      const Text(
        "Quantity",

        style: TextStyle(
          color: Colors.black,

          fontWeight: FontWeight.w600,
        ),
      ),

      Row(
        children: [

        if (quantity > 0)
  circleBtn(Icons.remove, () {
    setState(() {
      quantity--;
    });
  }),

          const SizedBox(width: 12),

          SizedBox(
            width: 70,

            child: TextField(
  controller: TextEditingController(
    text: quantity.toString(),
  ),

  keyboardType: TextInputType.number,

  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
  ],

  textAlign: TextAlign.center,

  maxLength: 4,

  buildCounter: (
    context, {
    required currentLength,
    required isFocused,
    maxLength,
  }) {
    return null;
  },

  decoration: InputDecoration(
    contentPadding:
        const EdgeInsets.symmetric(
      vertical: 10,
    ),

    border: OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(14),

      borderSide: BorderSide(
        color: Colors.grey.shade300,
      ),
    ),
  ),

 onChanged: (value) {

  if (value.isEmpty) {
    quantity = 0;
    return;
  }

  final number =
      int.tryParse(value);

  if (number != null &&
      number <= 1000 &&
      number >= 0) {

    quantity = number;
  }
},
),
          ),

          const SizedBox(width: 12),

          circleBtn(Icons.add, () {
            setState(() {
              quantity++;
            });
          }, isPrimary: true),
        ],
      ),
    ],
  ),
),

                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// BUTTONS
          Container(
            padding: const EdgeInsets.all(16),

            color: Colors.white,

            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),

                      padding: const EdgeInsets.symmetric(vertical: 15),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),

                    onPressed: () {
                      db.deleteItem(widget.index);

                      Navigator.pop(context, true);
                    },

                    child: const Text(
                      "Delete",

                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF8C42),

                      padding: const EdgeInsets.symmetric(vertical: 15),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),

                    onPressed: () {
                      final updatedItem = ItemModel(
                        name: nameController.text,

                        price: int.tryParse(priceController.text) ?? 0,

                        quantity: quantity,

                        category: category,

                        images: images.map((e) => e.path).toList(),

                       notes: descController.text,

salePrice: salePriceController.text,
                      );

                      db.updateItem(widget.index, updatedItem);

                      Navigator.pop(context, true);
                    },

                    child: const Text(
                      "Save",

                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

Widget premiumField(
  String label,
  TextEditingController controller,
  IconData icon,
) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14),

    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),

      color: Colors.white,

      boxShadow: [
        BoxShadow(
          color: Colors.orange.withOpacity(0.08),

          blurRadius: 14,

          offset: const Offset(0, 6),
        ),
      ],
    ),

    child: TextField(
  controller: controller,

  keyboardType:
      label.toLowerCase().contains("price")
          ? TextInputType.number
          : TextInputType.text,

  inputFormatters:
      label.toLowerCase().contains("price")
          ? [
              FilteringTextInputFormatter
                  .digitsOnly,
            ]
          : null,

      style: const TextStyle(
        color: Colors.black,
      ),

      decoration: InputDecoration(
        labelText: label,

        labelStyle: TextStyle(
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w500,
        ),

        floatingLabelStyle: const TextStyle(
          color: Color(0xFFFF8C42),
          fontWeight: FontWeight.w600,
        ),

        prefixIcon: Icon(
          icon,
          color: const Color(0xFFFF8C42),
        ),

        border: InputBorder.none,
      ),
    ),
  );
}

  Widget circleBtn(
    IconData icon,
    VoidCallback onTap, {
    bool isPrimary = false,
  }) {
    return GestureDetector(
      onTap: onTap,

      child: CircleAvatar(
        backgroundColor:
            isPrimary ? const Color(0xFFFF8C42) : const Color(0xFFFFF3E8),

        child: Icon(
          icon,

          color: isPrimary ? Colors.white : const Color(0xFFFF8C42),
        ),
      ),
    );
  }
}
