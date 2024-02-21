

import 'package:awafi_pos/backend/backend.dart';

class ExpenseReportData {
  final List InvoiceList;
  final DateTime From;
  final DateTime To;



  const ExpenseReportData( {
    required this.InvoiceList,
    required this.From,
    required this.To,


  });
}