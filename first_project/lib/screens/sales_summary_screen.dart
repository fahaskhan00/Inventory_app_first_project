import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/item_model.dart';
import 'package:flutter_application_1/screens/customer_details.dart';
import '../widgets/sales_summary_widget/appbar.dart';
import '../widgets/sales_summary_widget/summary_item_list.dart';
import '../widgets/sales_summary_widget/total_section.dart';
import '../widgets/sales_summary_widget/confirm_button.dart';

class SalesSummaryScreen extends StatefulWidget {
  final List<ItemModel> selectedItems;

  final String customerName;

  final String customerPhone;

  const SalesSummaryScreen({
    super.key,
    required this.selectedItems,
    required this.customerName,
    required this.customerPhone,
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

  // REMOVE QUANTITY
  void removeQuantity(int index, int qty) {
    if (qty > 1) {
      setState(() {
        quantities[index] = qty - 1;
      });
    }
  }

  // ADD QUANTITY
  void addQuantity(int index, int qty, int stock) {
    if (qty < stock) {
      setState(() {
        quantities[index] = qty + 1;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Only $stock items available"),

          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // CHANGE QUANTITY
  void changeQuantity(int index, int value) {
    final stock = widget.selectedItems[index].quantity;

    if (value <= 0) {
      quantities[index] = 1;

      setState(() {});

      return;
    }

    if (value > stock) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Only $stock items available"),

          backgroundColor: Colors.red,
        ),
      );

      quantities[index] = stock;

      setState(() {});

      return;
    }

    setState(() {
      quantities[index] = value;
    });
  }

  // DELETE ITEM
  void deleteItem(int index) {
    setState(() {
      widget.selectedItems.removeAt(index);

      quantities.remove(index);
    });
  }

  // GENERATE BILL
  void generateBill() {
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
            (_) => CustomerDetailsScreen(
              selectedItems: widget.selectedItems,

              updatedItems: updatedItems,

              total: total,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      appBar: const SalesSummaryAppBar(),

      body: Column(
        children: [
          Expanded(
            child: SalesSummaryItemList(
              selectedItems: widget.selectedItems,

              quantities: quantities,

              onRemove: removeQuantity,

              onAdd: addQuantity,

              onQtyChanged: changeQuantity,

              onDelete: deleteItem,
            ),
          ),

          SalesTotalSection(
            subtotal: subtotal,

            customerName: widget.customerName,
          ),

          SalesConfirmButton(onTap: generateBill),
        ],
      ),
    );
  }
}
