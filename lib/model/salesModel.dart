class SalesModel{
num? balance;
bool? bank;
List? billItems;
bool? cash;
String? currentBranchAddress;
String? currentBranchArabic;
String? currentBranchId;
String? currentBranchPhNo;
String? currentUserId;
num? deliveryCharge;
num? discount;
num? grandTotal;
num? invoiceNo;
num? paidBank;
num? paidCash;
DateTime? salesDate;
String? table;
num? tax;
num? token;
num? totalAmount;
String? creditName;
String? creditNumber;
bool? creditSale;
bool? AMEX;
bool? VISA;
bool? MADA;
bool? MASTER;
String? orderType;
String? waiterName;
bool? cancel;
bool? dinnerCertificate;
List? ingredientIds;
num? amexAmount;
num? madaAmount;
num? visaAmount;
num? masterAmount;



//<editor-fold desc="Data Methods">
  SalesModel({
    this.balance,
    this.bank,
    this.billItems,
    this.cash,
    this.currentBranchAddress,
    this.currentBranchArabic,
    this.currentBranchId,
    this.currentBranchPhNo,
    this.currentUserId,
    this.deliveryCharge,
    this.discount,
    this.grandTotal,
    this.invoiceNo,
    this.paidBank,
    this.paidCash,
    this.salesDate,
    this.table,
    this.tax,
    this.token,
    this.totalAmount,
    this.creditName,
    this.creditNumber,
    this.creditSale,
    this.AMEX,
    this.VISA,
    this.MADA,
    this.MASTER,
    this.orderType,
    this.waiterName,
    this.cancel,
    this.dinnerCertificate,
    this.ingredientIds,
    this.amexAmount,
    this.madaAmount,
    this.masterAmount,
    this.visaAmount
  });


  SalesModel copyWith({
    num? balance,
    bool? bank,
    List? billItems,
    bool? cash,
    String? currentBranchAddress,
    String? currentBranchArabic,
    String? currentBranchId,
    String? currentBranchPhNo,
    String? currentUserId,
    num? deliveryCharge,
    num? discount,
    num? grandTotal,
    num? invoiceNo,
    num? paidBank,
    num? paidCash,
    DateTime? salesDate,
    String? table,
    num? tax,
    num? token,
    num? totalAmount,
    String? creditName,
    String? creditNumber,
    bool? creditSale,
    bool? AMEX,
    bool? VISA,
    bool? MADA,
    bool? MASTER,
    String? orderType,
    String? waiterName,
    bool? cancel,
    bool? dinnerCertificate,
    List? ingredientIds,
    num? amexAmount,
    num? madaAmount,
    num? visaAmount,
    num? masterAmount,

  }) {
    return SalesModel(
      balance: balance ?? this.balance,
      bank: bank ?? this.bank,
      billItems: billItems ?? this.billItems,
      cash: cash ?? this.cash,
      currentBranchAddress: currentBranchAddress ?? this.currentBranchAddress,
      currentBranchArabic: currentBranchArabic ?? this.currentBranchArabic,
      currentBranchId: currentBranchId ?? this.currentBranchId,
      currentBranchPhNo: currentBranchPhNo ?? this.currentBranchPhNo,
      currentUserId: currentUserId ?? this.currentUserId,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      discount: discount ?? this.discount,
      grandTotal: grandTotal ?? this.grandTotal,
      invoiceNo: invoiceNo ?? this.invoiceNo,
      paidBank: paidBank ?? this.paidBank,
      paidCash: paidCash ?? this.paidCash,
      salesDate: salesDate ?? this.salesDate,
      table: table ?? this.table,
      tax: tax ?? this.tax,
      token: token ?? this.token,
      totalAmount: totalAmount ?? this.totalAmount,
      creditName: creditName ?? this.creditName,
      creditNumber: creditNumber ?? this.creditNumber,
      creditSale: creditSale ?? this.creditSale,
      AMEX: AMEX ?? this.AMEX,
      VISA: VISA ?? this.VISA,
      MADA: MADA ?? this.MADA,
      MASTER: MASTER ?? this.MASTER,
      orderType: orderType ?? this.orderType,
      waiterName: waiterName ?? this.waiterName,
      cancel: cancel ?? this.cancel,
      dinnerCertificate: dinnerCertificate ?? this.dinnerCertificate,
      ingredientIds: ingredientIds ?? this.ingredientIds,
      amexAmount: amexAmount ?? this.amexAmount,
      madaAmount: madaAmount ?? this.madaAmount,
      masterAmount: masterAmount ?? this.masterAmount,
      visaAmount: visaAmount ?? this.visaAmount
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'balance': this.balance,
      'bank': this.bank,
      'billItems': this.billItems,
      'cash': this.cash,
      'currentBranchAddress': this.currentBranchAddress,
      'currentBranchArabic': this.currentBranchArabic,
      'currentBranchId': this.currentBranchId,
      'currentBranchPhNo': this.currentBranchPhNo,
      'currentUserId': this.currentUserId,
      'deliveryCharge': this.deliveryCharge,
      'discount': this.discount,
      'grandTotal': this.grandTotal,
      'invoiceNo': this.invoiceNo,
      'paidBank': this.paidBank,
      'paidCash': this.paidCash,
      'salesDate': this.salesDate,
      'table': this.table,
      'tax': this.tax,
      'token': this.token,
      'totalAmount': this.totalAmount,
      'creditName': this.creditName,
      'creditNumber': this.creditNumber,
      'creditSale': this.creditSale,
      'AMEX': this.AMEX,
      'VISA': this.VISA,
      'MADA': this.MADA,
      'MASTER': this.MASTER,
      'orderType': this.orderType,
      'waiterName': this.waiterName,
      'cancel': this.cancel,
      'dinnerCertificate': this.dinnerCertificate,
      'ingredientIds' : this.ingredientIds,
      'amexAmount': this.amexAmount,
        'madaAmount' : this.madaAmount,
        'visaAmount': this.visaAmount,
        'masterAmount' : this.masterAmount
    };
  }

  factory SalesModel.fromMap(Map<String, dynamic> map) {
    return SalesModel(
      balance: map['balance'] ??0.0,
      bank: map['bank'] ??false,
      billItems: map['billItems'] ??[],
      cash: map['cash'] ??false,
      currentBranchAddress: map['currentBranchAddress'] ??"",
      currentBranchArabic: map['currentBranchArabic'] ??"",
      currentBranchId: map['currentBranchId'] ??"",
      currentBranchPhNo: map['currentBranchPhNo'] ??"",
      currentUserId: map['currentUserId'] ??"",
      deliveryCharge: map['deliveryCharge'] ??0.0,
      discount: map['discount'] ??0.0,
      grandTotal: map['grandTotal'] ??0.0,
      invoiceNo: map['invoiceNo'] ??0.0,
      paidBank: map['paidBank'] ??0.0,
      paidCash: map['paidCash'] ??0.0,
      salesDate: map['salesDate'] .toDate(),
      table: map['table'] ??"",
      tax: map['tax'] ??0.0,
      token: map['token'] ??0.0,
      totalAmount: map['totalAmount'] ??0.0,
      creditName: map['creditName'] ??"",
      creditNumber: map['creditNumber'] ??"",
      creditSale: map['creditSale'] ??false,
      AMEX: map['AMEX'] ??false,
      VISA: map['VISA'] ??false,
      MADA: map['MADA'] ??false,
      MASTER: map['MASTER'] ??false,
      orderType: map['orderType'] ??"",
      waiterName: map['waiterName'] ??"",
      cancel: map['cancel'] ??false,
      dinnerCertificate: map['dinnerCertificate'] ??false,
       ingredientIds: map['ingredientIds'] ?? [],
         amexAmount : map['amexAmount'] ?? 0.0,
      madaAmount : map['madaAmount'] ?? 0.0,
        visaAmount : map['visaAmount'] ?? 0.0,
       masterAmount : map['masterAmount'] ?? 0.0,

    );
  }

//</editor-fold>
}