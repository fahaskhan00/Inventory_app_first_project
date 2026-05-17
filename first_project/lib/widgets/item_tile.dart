import 'dart:io';
import 'package:flutter/material.dart';

class ItemTile extends StatelessWidget {
  final String tag;
  final String name;
  final String price;
  final String stock;
  final String imagePath;

  const ItemTile({
    super.key,
    required this.tag,
    required this.name,
    required this.price,
    required this.stock,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: imagePath.isNotEmpty
                ? Image.file(
                    File(imagePath),
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey[300],
                    child: Icon(Icons.image),
                  ),
          ),

          SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 5),
              Text(
                // ignore: prefer_interpolation_to_compose_strings
                stock.replaceAll("Stock: ", "") + " units",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}