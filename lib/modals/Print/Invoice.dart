
import 'package:awafi_pos/modals/Print/supplier.dart';

class Invoice {
   InvoiceInfo? info;
   Supplier? supplier;
   List<InvoiceItem>? salesItems ;
   double? discount;
   double? delivery;
   int? table;

   Invoice({
      this.info,
      this.table,
      this.supplier,
     this.salesItems,
     this.discount,
     this.delivery
  });
}

class InvoiceInfo {
  final String description;
  final String number;
  final DateTime date;

  const InvoiceInfo({
     required this.description,
     required this.number,
     required this.date,

  });
}

class InvoiceItem {
  final String description;
  final double quantity;
  final double tax;
  final double gst;
  final double price;
  final double total;

  const InvoiceItem(
   {
     required this.tax,
     required this.description,
     required this.quantity,
     required this.gst,
     required this.price,
    required this.total, required int hsncode,
  });
}