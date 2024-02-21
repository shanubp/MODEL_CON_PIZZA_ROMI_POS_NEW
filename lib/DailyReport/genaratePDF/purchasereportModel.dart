
import 'package:awafi_pos/backend/backend.dart';

class PurchaseReportData {
  final List InvoiceList;
  final DateTime From;
  final DateTime To;



  const PurchaseReportData( {
    required this.InvoiceList,
    required this.From,
    required this.To,


  });
}