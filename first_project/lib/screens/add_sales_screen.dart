import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/customer_details.dart';
import '../services/database_hive.dart';
import '../models/item_model.dart';


class AddSalesScreen extends StatefulWidget {
  final String customerName;
  final String customerPhone;
  final String customerAddress;
  const AddSalesScreen({
    super.key,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
  });

  @override
  State<AddSalesScreen> createState() => _AddSalesScreenState();
}

class _AddSalesScreenState extends State<AddSalesScreen> {
  final db = DatabaseApp.instance;

  List<ItemModel> selectedItems = [];
  List<int> selectedIndexes = [];

  TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  double get totalPrice {
    double total = 0;
    for (var item in selectedItems) {
      total += item.price.toDouble();
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final items = db.getItems();

    final filteredItems =
        items.where((item) {
          return item.name.toLowerCase().contains(searchQuery.toLowerCase());
        }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        iconTheme: const IconThemeData(color: Colors.black),

        title: const Text(
          "Add New Sale",

          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 22,
          ),
        ),

        leading: IconButton(
          icon: const Icon(Icons.arrow_back),

          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Column(
        children: [
          /// SEARCH
          Padding(
            padding: const EdgeInsets.all(16),

            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(18),

                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.08),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),

              child: TextField(
                controller: searchController,

                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },

                style: const TextStyle(color: Colors.black),

                decoration: InputDecoration(
                  hintText: "Search items...",

                  hintStyle: TextStyle(color: Colors.grey.shade500),

                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFFFF8C42),
                  ),

                  border: InputBorder.none,

                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),
          ),

          /// ITEMS
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),

              itemCount: filteredItems.length,

              itemBuilder: (context, index) {
                final item = filteredItems[index];

                final originalIndex = items.indexOf(item);

                final isSelected = selectedIndexes.contains(originalIndex);

                return GestureDetector(
                  onTap: () {
                    if (item.quantity == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Add quantity to create sale"),

                          backgroundColor: Colors.red,
                        ),
                      );

                      return;
                    }

                    setState(() {
                      if (selectedIndexes.contains(originalIndex)) {
                        selectedIndexes.remove(originalIndex);
                      } else {
                        selectedIndexes.add(originalIndex);
                      }

                      selectedItems =
                          selectedIndexes.map((i) => items[i]).toList();
                    });
                  },

                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),

                    padding: const EdgeInsets.all(16),

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(22),

                      border: Border.all(
                        color:
                            isSelected
                                ? const Color(0xFFFF8C42)
                                : Colors.transparent,

                        width: 1.5,
                      ),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.08),

                          blurRadius: 14,

                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),

                    child: Row(
                      children: [
                        Container(
                          width: 70,
                          height: 70,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),

                            color: const Color(0xFFFFF3E8),

                            image:
                                item.images.isNotEmpty
                                    ? DecorationImage(
                                      image: FileImage(File(item.images[0])),

                                      fit: BoxFit.cover,
                                    )
                                    : null,
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text(
                                item.name,

                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,

                                  color: Colors.black,

                                  fontSize: 16,
                                ),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                "QTY: ${item.quantity}",

                                style: TextStyle(
                                  color: Colors.grey.shade600,

                                  fontSize: 13,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                "₹ ${item.price}",

                                style: const TextStyle(
                                  color: Color(0xFFFF8C42),

                                  fontWeight: FontWeight.bold,

                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          width: 40,
                          height: 40,

                          decoration: BoxDecoration(
                            gradient:
                                isSelected
                                    ? const LinearGradient(
                                      colors: [
                                        Color(0xFFFFB067),
                                        Color(0xFFFF8C42),
                                      ],
                                    )
                                    : null,

                            color: isSelected ? null : const Color(0xFFFFF3E8),

                            borderRadius: BorderRadius.circular(14),
                          ),

                          child: Icon(
                            isSelected ? Icons.check : Icons.add,

                            color:
                                isSelected
                                    ? Colors.white
                                    : const Color(0xFFFF8C42),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          /// BOTTOM BUTTON
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 30),

            child: GestureDetector(
              onTap: () {
                if (selectedItems.isEmpty) return;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => CustomerDetailsScreen(selectedItems: selectedItems),
                  ),
                );
              },

              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 20,
                ),

                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFB067), Color(0xFFFF8C42)],
                  ),

                  borderRadius: BorderRadius.circular(50),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.18),

                      blurRadius: 14,

                      offset: const Offset(0, 6),
                    ),
                  ],
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,

                          child: Text(
                            selectedItems.length.toString(),

                            style: const TextStyle(
                              color: Color(0xFFFF8C42),

                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        const Text(
                          "Add Customer Details",

                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,

                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),

                    Text(
                      "₹ ${totalPrice.toStringAsFixed(0)}",

                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,

                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
