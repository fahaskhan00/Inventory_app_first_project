import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';
import 'package:flutter_application_1/screens/edit_screen.dart';
import 'package:flutter_application_1/services/database_hive.dart';
import 'package:flutter_application_1/widgets/detail_screen_widget/appbar.dart';
import 'package:flutter_application_1/widgets/detail_screen_widget/image_slider.dart';
import 'package:flutter_application_1/widgets/detail_screen_widget/info_card.dart';
import 'package:flutter_application_1/widgets/detail_screen_widget/price_card.dart';
import 'package:flutter_application_1/widgets/detail_screen_widget/stock_card.dart';
import 'package:flutter_application_1/widgets/detail_screen_widget/notes_card.dart';
import 'package:flutter_application_1/widgets/detail_screen_widget/delete_item.dart';

class DetailScreen extends StatefulWidget {
  final String name;

  final String price;

  final String stock;

  final String tag;

  final List<String> imagePath;

  final int index;

  const DetailScreen({
    super.key,
    required this.name,
    required this.price,
    required this.stock,
    required this.tag,
    required this.imagePath,
    required this.index,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // DELETE ITEM
  void deleteItem(BuildContext context) {
    final db = DatabaseApp.instance;

    showDialog(
      context: context,

      builder: (context) {
        return DeleteItemDialog(
          onDelete: () {
            db.deleteItem(widget.index);

            Navigator.pop(context);

            Navigator.pop(context, true);
          },
        );
      },
    );
  }

  // GO TO EDIT SCREEN
  Future<void> goToEditScreen() async {
    final result = await Navigator.push(
      context,

      MaterialPageRoute(
        builder: (context) => EditItemScreen(index: widget.index),
      ),
    );

    if (result == true) {
      Navigator.pop(context, true);
    }
  }

  // GET ITEM
  dynamic getItem() {
    final db = DatabaseApp.instance;

    return db.getItems()[widget.index];
  }

  // APP BAR
  PreferredSizeWidget buildAppBar() {
    return DetailAppBar(
      onEdit: goToEditScreen,

      onDelete: () {
        deleteItem(context);
      },
    );
  }

  // IMAGE SLIDER
  Widget buildImageSlider(List imageList) {
    return ProductImageSlider(imageList: imageList);
  }

  // PRODUCT INFO
  Widget buildProductInfoCard(dynamic item) {
    return ProductInfoCard(itemName: item.name, category: item.category);
  }

  // PRICE CARD
  Widget buildPriceCard(dynamic item) {
    return ProductPriceCard(price: item.price, salePrice: item.salePrice ?? "");
  }

  // STOCK CARD
  Widget buildStockCard(dynamic item) {
    return StockCard(stock: item.quantity);
  }

  // NOTES CARD
  Widget buildNotesCard(dynamic item) {
    return NotesCard(notes: item.notes);
  }

  // BODY
  Widget buildBody(dynamic item) {
    final imageList = item.images;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          buildImageSlider(imageList),

          const SizedBox(height: 22),

          buildProductInfoCard(item),

          const SizedBox(height: 16),

          buildPriceCard(item),

          const SizedBox(height: 16),

          buildStockCard(item),

          const SizedBox(height: 16),

          buildNotesCard(item),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = getItem();

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: buildAppBar(),

      body: buildBody(item),
    );
  }
}
