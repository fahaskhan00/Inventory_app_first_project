import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/item_model.dart';
import 'bill_preview_screen.dart';
import '../widgets/sales_summary_widget.dart';

class SalesSummaryScreen extends StatefulWidget {
  final List<ItemModel> selectedItems;
  final String customerName;
  final String customerPhone;
  final String customerAddress;
  final String customerSalePrice;

  const SalesSummaryScreen({
    super.key,
    required this.selectedItems,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.customerSalePrice,
  });

  @override
  State<SalesSummaryScreen> createState() => _SalesSummaryScreenState();
}

class _SalesSummaryScreenState extends State<SalesSummaryScreen> {
  Map<int, int> quantities = {};

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.selectedItems.length; i++) {
      quantities[i] = 1;
    }
  }

  double get subtotal {
    double total = 0;

    for (int i = 0; i < widget.selectedItems.length; i++) {
      final item = widget.selectedItems[i];

      final qty = quantities[i] ?? 1;

      final price = item.price.toDouble();

      total += price * qty;
    }

    return total;
  }

  double get total => subtotal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      appBar: AppBar(
        backgroundColor: Colors.transparent,

        elevation: 0,

        centerTitle: true,

        iconTheme: const IconThemeData(color: Colors.black),

        title: const Text(
          "Sale Summary",

          style: TextStyle(
            fontWeight: FontWeight.bold,

            color: Colors.black,

            fontSize: 22,
          ),
        ),
      ),

      body: Column(
        children: [
          /// ITEMS LIST
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),

              itemCount: widget.selectedItems.length,

              itemBuilder: (context, index) {
                final item = widget.selectedItems[index];

                final qty = quantities[index] ?? 1;

                final stock = item.quantity;

                return saleItemTile(
                  context: context,
                  item: item,
                  qty: qty,
                  stock: stock,

                  onRemove: () {
                    if (qty > 1) {
                      setState(() {
                        quantities[index] = qty - 1;
                      });
                    }
                  },

              onAdd: () {

  if (qty < stock) {

    setState(() {
      quantities[index] = qty + 1;
    });

  } else {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text("Only $stock items available"),

        backgroundColor: Colors.red,
      ),
    );
  }
},
onQtyChanged: (value) {

  setState(() {

    quantities[index] = value;
  });
},

                  onDelete: () {
                    setState(() {
                      widget.selectedItems.removeAt(index);

                      quantities.remove(index);
                    });
                  },
                );
              },
            ),
          ),

          /// TOTAL CARD
          totalCard(
            child: Column(
              children: [
                row("Subtotal", subtotal),

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),

                  child: Divider(color: Color(0xFFFFE0CC), height: 1),
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text(
                      "Customer",

                      style: TextStyle(
                        color: Colors.grey.shade600,

                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    Text(
                      widget.customerName,

                      style: const TextStyle(
                        color: Colors.black,

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text(
                      "Customer Price",

                      style: TextStyle(
                        color: Colors.grey.shade600,

                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    Text(
                      widget.customerSalePrice.trim().isEmpty
                          ? "Not Added"
                          : "₹ ${widget.customerSalePrice}",

                      style: const TextStyle(
                        color: Colors.black,

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// BUTTON
          Container(
            width: double.infinity,

            padding: const EdgeInsets.fromLTRB(16, 0, 16, 35),

            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF8C42),

                foregroundColor: Colors.white,

                elevation: 0,

                padding: const EdgeInsets.symmetric(vertical: 18),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),

              onPressed: () {
                if (widget.selectedItems.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please add items"),

                      backgroundColor: Colors.red,
                    ),
                  );

                  return;
                }

                List updatedItems = [];

                for (int i = 0; i < widget.selectedItems.length; i++) {
                  final item = widget.selectedItems[i];

                  final qty = quantities[i] ?? 1;

                  updatedItems.add({...item.toMap(), "qty": qty});
                }

                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder:
                        (_) => BillPreviewScreen(
                          items: updatedItems,

                          total: total,

                          customerName: widget.customerName,

                          customerPhone: widget.customerPhone,

                          customerAddress: widget.customerAddress,

                          customerSalePrice: widget.customerSalePrice,
                        ),
                  ),
                );
              },

              child: const Text(
                "Confirm & Generate Bill",

                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget row(String title, double value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Text(
          title,

          style: TextStyle(
            color: Colors.grey.shade600,

            fontWeight: FontWeight.w500,

            fontSize: 14,
          ),
        ),

        Text(
          "₹ ${value.toStringAsFixed(0)}",

          style: const TextStyle(
            color: Colors.black,

            fontWeight: FontWeight.w600,

            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
