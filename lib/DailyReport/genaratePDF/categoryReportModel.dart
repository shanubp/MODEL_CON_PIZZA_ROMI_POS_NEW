

import 'package:awafi_pos/backend/backend.dart';

class CategoryReportData {
  final List categoryWiseData;
  final DateTime From;
  final DateTime To;

  const CategoryReportData( {
    required this.categoryWiseData,
    required this.From,
    required this.To,


  });
}