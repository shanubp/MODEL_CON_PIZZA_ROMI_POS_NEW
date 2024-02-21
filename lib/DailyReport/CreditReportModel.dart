
import 'package:awafi_pos/backend/backend.dart';

class CreditReportData {
  final List creditSaleData;
  final DateTime From;
  final DateTime To;

  const CreditReportData( {
    required this.creditSaleData,
    required this.From,
    required this.To,


  });
}