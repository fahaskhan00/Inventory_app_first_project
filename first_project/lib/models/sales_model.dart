class SalesModel {
  final String date;
  final double total;
  final List items;
  final String customerName;
  final String customerPhone;
  final String customerAddress;

  SalesModel({
    required this.date,
    required this.total,
    required this.items,
    required this.customerAddress,
    required this.customerName,
    required this.customerPhone,
  });

  factory SalesModel.fromMap(Map<String, dynamic> map) {
    return SalesModel(
      customerAddress: map['customerAddress'] ?? "",
      customerName: map['customerName'] ?? "",
      customerPhone: map['customerPhone'] ?? "",
      date: map['date'] ?? "",
      total: (map['total'] ?? 0).toDouble(),
      items: map['items'] ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'total': total,
      'items': items,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'customerAddress': customerAddress,
    };
  }
}
