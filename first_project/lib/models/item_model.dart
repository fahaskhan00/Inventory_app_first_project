class ItemModel {
  final String name;
  String category;
  final int price;
  final int quantity;
  final List<String> images;
  final String notes;
  String? salePrice;

  ItemModel({
    this.salePrice,
    required this.name,
    required this.category,
    required this.price,
    required this.quantity,
    required this.images,
    required this.notes,
  });

  factory ItemModel.fromMap(Map<String, dynamic> item) {
    return ItemModel(
      name: item['name'] ?? '',
      category: item['category'] ?? '',
      price: int.tryParse(item['price'].toString()) ?? 0,
      quantity: int.tryParse(item['quantity'].toString()) ?? 0,
      images: List<String>.from(item['images'] ?? []),
      salePrice: item['salePrice'] ?? '',
      notes: item['notes'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'salePrice': salePrice,
      'category': category,
      'price': price,
      'quantity': quantity,
      'images': images,
      'notes': notes,
    };
  }
}
