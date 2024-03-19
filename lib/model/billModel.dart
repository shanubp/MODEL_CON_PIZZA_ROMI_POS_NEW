class BillModel {
  final double grandTotal;
  final String shopName;
  final String shopNameArabic;
  final String mobileNumber;
  final String vatNumber;
  final DateTime date;
  final int invoiceNumber;
  final String orderType;
  final List productItems;
  final double cash;
  final double vat;
  final double bank;
  final double balance;
  final String cashierName;
  final String cashierNameArabic;
  final double total;
  final double delcharge;
  final double discount;

  BillModel(
      {required this.shopName,
        required this.grandTotal,
        required this.shopNameArabic,
        required this.mobileNumber,
        required this.vatNumber,
        required this.date,
        required this.invoiceNumber,
        required this.orderType,
        required this.productItems,
        required this.cash,
        required this.bank,
        required this.balance,
        required this.cashierName,
        required this.cashierNameArabic,
        required this.vat,
        required this.total,
        required this.delcharge,
        required this.discount

      });
}
