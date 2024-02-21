
import 'package:awafi_pos/backend/backend.dart';

class DailyReportData {


  final double purchaseAmount;
  final double expenseAmount;
  final double saleAmount;
  final double balance;
  final double sale;
  final double purchase;
  final double expense;
  final double rtnAmount;
  final int rtn;
  final List userSaleData;
  final double vatPayable;
  final DateTime from;
  final DateTime to;
  final double creditSale;
  final double dinnerSale;
  final int creditSaleCount;
  final int dinnerSaleCount;


  const DailyReportData(  {
    required this.from,
    required this.to,
    required this.purchaseAmount,
    required this.expenseAmount,
    required this.saleAmount,
    required this.balance,
    required this.sale,
    required this.purchase,
    required this.expense,
    required this.rtn,
    required this.rtnAmount,
    required this.userSaleData,
    required this.vatPayable,
    required this. creditSale,
    required this.dinnerSale,
    required this.creditSaleCount,
    required this.dinnerSaleCount,

  });
}




