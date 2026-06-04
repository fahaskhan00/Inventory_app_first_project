import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class InvoiceService {
  static Future<bool> downloadInvoice({
    required Map<String, dynamic> sale,
  }) async {
    try {
      final pdf = pw.Document();

      final List items = sale['items'] ?? [];

      print('Items: $items');

      pdf.addPage(
        pw.MultiPage(
          build: (context) => [
            pw.Text(
              'MYventory Invoice',
              style: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
              ),
            ),

            pw.SizedBox(height: 20),

            pw.Text(
              'Customer Name : ${sale['customerName']}',
            ),

            pw.Text(
              'Phone : ${sale['customerPhone']}',
            ),

            pw.Text(
              'Address : ${sale['customerAddress']}',
            ),

            pw.Text(
              'Date : ${sale['date']}',
            ),

            pw.SizedBox(height: 20),

            pw.Text(
              'Sold Products',
              style: pw.TextStyle(
                fontSize: 18,
                fontWeight: pw.FontWeight.bold,
              ),
            ),

            pw.SizedBox(height: 10),

            pw.Table.fromTextArray(
              headers: const [
                'Product',
                'Price',
              ],

              data: items.map((item) {
                return [
                  item['name'].toString(),
                  item['price'].toString(),
                ];
              }).toList(),
            ),

            pw.SizedBox(height: 20),

            pw.Divider(),

            pw.Text(
              'Total Amount : Rs.${sale['total']}',
              style: pw.TextStyle(
                fontSize: 18,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ],
        ),
      );

     final directory =
    Directory(
      '/storage/emulated/0/Download',
    );
      final file = File(
        '${directory.path}/invoice_${DateTime.now().millisecondsSinceEpoch}.pdf',
      );

      await file.writeAsBytes(
        await pdf.save(),
      );
      print(
  'Saved to: ${file.path}',
);

    

      return true;
    } catch (e) {
      print(
        'Invoice Error : $e',
      );

      return false;
    }
  }
}