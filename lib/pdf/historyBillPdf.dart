



import 'dart:convert';
import 'dart:typed_data';
import 'package:awafi_pos/main.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as dt;
import 'package:awafi_pos/Branches/branches.dart';
// import 'package:awafi_pos/billModel.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../model/billModel.dart';

var myFont2;
BillModel? map;

generatePdfHistory(BillModel model) async {
  final image = await imageFromAssetBundle('assets/as.jpg');

  map = model;
  print("###################");
  print(map!.mobileNumber);
  print("###################");

  qr(String vatTotal1, String grantTotal) {
    // seller name
    String sellerName = currentBranchName!;
    String vat_registration = '$vatNumber';
    String vatTotal = vatTotal1;
    String invoiceTotal = grantTotal;
    BytesBuilder bytesBuilder = BytesBuilder();
    bytesBuilder.addByte(1);
    List<int> sellerNameBytes = utf8.encode(sellerName);
    bytesBuilder.addByte(sellerNameBytes.length);
    bytesBuilder.add(sellerNameBytes);
    //vat registration
    bytesBuilder.addByte(2);
    List<int> vat_registrationBytes = utf8.encode(vat_registration);
    bytesBuilder.addByte(vat_registrationBytes.length);
    bytesBuilder.add(vat_registrationBytes);

    //date
    bytesBuilder.addByte(3);
    String time = dt.DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(DateTime.now());
    List<int> date = utf8.encode(time);
    bytesBuilder.addByte(date.length);
    bytesBuilder.add(date);

    //invoice total
    bytesBuilder.addByte(4);
    List<int> invoiceTotals = utf8.encode(invoiceTotal);
    bytesBuilder.addByte(invoiceTotals.length);
    bytesBuilder.add(invoiceTotals);

    //vat total

    bytesBuilder.addByte(5);
    List<int> vatTotals = utf8.encode(vatTotal);
    bytesBuilder.addByte(vatTotals.length);
    bytesBuilder.add(vatTotals);

    Uint8List qrCodeAsBytes = bytesBuilder.toBytes();
    const Base64Encoder base64encoder = Base64Encoder();
    return base64encoder.convert(qrCodeAsBytes);
  }

  List itemWidgets1 = [];
  imageList = [];

  final pdf = Document(version: PdfVersion.pdf_1_5, compress: true);
  final font = await PdfGoogleFonts.nunitoExtraLight();

  var font2 = await rootBundle.load("assets/Amiri-Regular.ttf");
  myFont2 = Font.ttf(font2);

  pdf.addPage(
    Page(
      margin: EdgeInsets.zero,
      orientation: PageOrientation.portrait,
      pageFormat: PdfPageFormat.roll80,
      build: (context) {
        return Expanded(
            child: Container(
                width: printWidth * 1.6,
                child: Column(

                    children: [
                      Image(image, height: 100, width: 120),
                      SizedBox(height: 20),
                      Container(
                        color: PdfColors.white,
                        width: 200,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: Text(map!.shopNameArabic,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              font: myFont2,

                                              //  fontFamily: 'GE Dinar One Medium',
                                              color: PdfColors.black,
                                              fontSize: 8,
                                              fontWeight: FontWeight.bold),
                                          textDirection: TextDirection.rtl)),
                                  Text("  اسم الفرع",
                                      style: TextStyle(
                                        font: myFont2,
                                        // fontFamily: 'GE Dinar One Medium',
                                        color: PdfColors.black,
                                        fontSize: 8,
                                        // fontWeight: FontWeight.w600
                                      ),
                                      textDirection: TextDirection.rtl),
                                  // SizedBox(width: 50)
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Branch Name: ",
                                    style: const TextStyle(
                                      // fontFamily: 'GE Dinar One Medium',
                                      color: PdfColors.black,
                                      fontSize: 8,
                                      // fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  Expanded(
                                      child: Text(
                                        map!.shopName,
                                        textAlign: TextAlign.end,
                                        style: const TextStyle(
                                          // fontFamily: 'GE Dinar One Medium',
                                          color: PdfColors.black,
                                          fontSize: 8,
                                          // fontWeight: FontWeight.w600
                                        ),
                                      )),
                                ],
                              ),
                            ]),
                        //  ] ),
                      ),
                      Container(
                          decoration: const BoxDecoration(
                            color: PdfColors.white,
                          ),
                          child: Center(
                              child: Text(
                                '---------------------------------',
                                style: const TextStyle(
                                    color: PdfColors.black, fontSize: 18),
                              ))),

                      Text("CONTACT US : ${map!.mobileNumber}",
                          style: const TextStyle(
                            color: PdfColors.black,
                            fontSize: 15,
                            // fontWeight: FontWeight.w600
                          ),
                          textAlign: TextAlign.center),
                      Container(
                          decoration: const BoxDecoration(
                            color: PdfColors.white,
                          ),
                          child: Center(
                              child: Text(
                                '---------------------------------',
                                style: TextStyle(color: PdfColors.black, fontSize: 18),
                              ))),
                      Container(
                          width: 200,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Vat no:      ',
                                        style: const TextStyle(
                                          // fontFamily: 'GE Dinar One Medium',
                                          color: PdfColors.black,
                                          fontSize: 8,
                                          // fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      Text(
                                        map!.vatNumber,
                                        style: const TextStyle(
                                          // fontFamily: 'GE Dinar One Medium',
                                          color: PdfColors.black,
                                          fontSize: 8,
                                          // fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ]),
                                Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Date:      ',
                                        style: const TextStyle(
                                          // fontFamily: 'GE Dinar One Medium',
                                          color: PdfColors.black,
                                          fontSize: 8,
                                          // fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      Text(
                                        dt.DateFormat('dd-MM-yyyy')
                                            .format(map!.date),
                                        style: const TextStyle(
                                          // fontFamily: 'GE Dinar One Medium',
                                          color: PdfColors.black,
                                          fontSize: 8,
                                          // fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ]),
                                Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Invoice No:      ',
                                        style: const TextStyle(
                                          // fontFamily: 'GE Dinar One Medium',
                                          color: PdfColors.black,
                                          fontSize: 8,
                                          // fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      Text(
                                        map!.invoiceNumber.toString(),
                                        style: const TextStyle(
                                          // fontFamily: 'GE Dinar One Medium',
                                          color: PdfColors.black,
                                          fontSize: 8,
                                          // fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ]),
                              ])),
                      Container(
                          decoration: const BoxDecoration(
                            color: PdfColors.white,
                          ),
                          child: Center(
                              child: Text(
                                '-------------------------------',
                                style: TextStyle(color: PdfColors.black, fontSize: 18),
                              ))),
                      Text("Order Type : ${map!.orderType}",
                          style: const TextStyle(
                            color: PdfColors.black,
                            fontSize: 15,
                            // fontWeight: FontWeight.w600
                          ),
                          textAlign: TextAlign.center),
                      Container(
                          decoration: const BoxDecoration(
                            color: PdfColors.white,
                          ),
                          child: Center(
                              child: Text(
                                '---------------------------------',
                                style: const TextStyle(
                                    color: PdfColors.black, fontSize: 18),
                              ))),

                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [

                                TableHelper.fromTextArray(

                                    border: null,
                                    context: context,
                                    cellStyle: const TextStyle(fontSize: 7),
                                    headers: [
                                      'Product',
                                      'Qty',
                                      'Rate',
                                      'vat',
                                      'Total'
                                    ],
                                    headerAlignment: Alignment.topLeft,
                                    headerStyle: TextStyle(

                                      fontSize: 9,
                                      fontBold: Font.courierBold(),

                                    ),
                                    data: List.generate(map!.productItems.length,
                                            (index) {
                                          final data = map!.productItems[index];
                                          var addOnPrice =  data['addOnPrice']??0-data['removePrice']??0-data['addLessPrice']??0+data['addMorePrice']??0;

                                          String productName = data['pdtname'] ?? "";
                                          int qty = data['qty'] ?? 0;
                                          double rate = data['price'] ?? 0;
                                          double totalAmount = 0;
                                          totalAmount +=
                                              rate * double.tryParse(qty.toString())!;
                                          double vat =
                                              (double.tryParse(rate.toString())! + addOnPrice) *
                                                  15 /
                                                  115;
                                          //        List<TextAlign> alignments = [
                                          //   TextAlign.left,  // Product Name - left alignment
                                          //   TextAlign.center, // Quantity - center alignment
                                          //   TextAlign.center, // Rate - center alignment
                                          //   TextAlign.center, // VAT - center alignment
                                          //   TextAlign.right,  // Total - right alignment
                                          //  ];

                                          // Define widgets for each cell in the row
                                          List<Widget> rowData = [
                                            Expanded(
                                                child: Container(
                                                  width: 78,
                                                  child: Text(
                                                    style: const TextStyle(
                                                        fontSize: 8
                                                    ),
                                                    productName,
                                                    textAlign: TextAlign.left,
                                                  ),

                                                )

                                            ),
                                            Container(
                                              width: 17,
                                              child: Text(
                                                qty.toString(),
                                                style: const TextStyle(
                                                    fontSize: 8
                                                ),
                                                textAlign: TextAlign.center,
                                              ),

                                            ) ,


                                            Container(
                                              width: 17,
                                              child:  Text(
                                                rate.toString(),
                                                style: const TextStyle(
                                                    fontSize: 8
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),

                                            Container(
                                              width: 17,
                                              child:  Text(
                                                vat.toStringAsFixed(2),
                                                style: const TextStyle(
                                                    fontSize: 8
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),

                                            Container(
                                              width: 17,
                                              child:  Text(
                                                totalAmount.toString(),
                                                style: const TextStyle(
                                                    fontSize: 8
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ];





                                          return
                                            // <String>[
                                            //   productName,
                                            //   qty.toString(),
                                            //   rate.toString(),
                                            //   vat.toStringAsFixed(2),
                                            //   totalAmount.toString()
                                            // ];
                                            rowData;
                                        }))
                              ],


                            ),

//content

                            Container(
                                decoration: const BoxDecoration(
                                  color: PdfColors.white,
                                ),
                                child: Center(
                                    child: Text(
                                      '---------------------------------',
                                      style: TextStyle(
                                          color: PdfColors.black, fontSize: 18),
                                    ))),
                          ],
                        ),
                      ),


                      // Container(
                      //     decoration: const BoxDecoration(
                      //       color: PdfColors.white,
                      //     ),
                      //     child: Center(
                      //         child: Text(
                      //       '================',
                      //       style: const TextStyle(
                      //           color: PdfColors.black, fontSize: 18),
                      //     ))),
                      Container(
                        padding: const EdgeInsets.all(1.0),
                        decoration: const BoxDecoration(
                          color: PdfColors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total - الإجمالي     :  ',
                                style: TextStyle(
                                  font: myFont2,
                                  color: PdfColors.black,
                                  fontSize: 10,
                                  // fontWeight: FontWeight.w600
                                ),
                                textDirection: TextDirection.rtl),
                            Text(
                              map!.total.toStringAsFixed(2),
                              style: const TextStyle(
                                color: PdfColors.black,
                                fontSize: 10,
                                // fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(1.0),
                        decoration: const BoxDecoration(
                          color: PdfColors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('VAT -  رقم ضريبة  :   ',
                                style: TextStyle(
                                  font: myFont2,
                                  color: PdfColors.black,
                                  fontSize: 10,
                                  // fontWeight: FontWeight.w600
                                ),
                                textDirection: TextDirection.rtl),
                            Text(
                              map!.vat.toStringAsFixed(2),
                              style: const TextStyle(
                                color: PdfColors.black,
                                fontSize: 10,
                                // fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(1.0),
                        decoration: const BoxDecoration(
                          color: PdfColors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Delivery Charge - رسوم التوصيل : ',
                              style: TextStyle(
                                font: myFont2,
                                color: PdfColors.black,
                                fontSize: 10,
                                // fontWeight: FontWeight.w600
                              ),
                            ),
                            Text(
                              '${map!.delcharge.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: PdfColors.black,
                                fontSize: 10,
                                // fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(1.0),
                        decoration: const BoxDecoration(
                          color: PdfColors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Discount -  خصم  : ',
                              style: TextStyle(
                                font: myFont2,
                                color: PdfColors.black,
                                fontSize: 10,
                                // fontWeight: FontWeight.w600
                              ),
                            ),
                            Text(
                              (discount == null ? "0.00" : map!.discount.toStringAsFixed(2)),
                              style: TextStyle(
                                color: PdfColors.black,
                                fontSize: 10,
                                // fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),
                      ),


                      Container(
                          padding: const EdgeInsets.all(1.0),
                          decoration: const BoxDecoration(
                            color: PdfColors.white,
                          ),
                          child: Center(
                              child: Text(
                                '--------------------------------',
                                style: TextStyle(color: PdfColors.black, fontSize: 18),
                              ))),
                      Container(
                        decoration: const BoxDecoration(
                          color: PdfColors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('NET - المجموع الإجمالي  : ',
                                style: TextStyle(
                                  font: myFont2,
                                  color: PdfColors.black,
                                  fontSize: 10,
                                  // fontWeight: FontWeight.w700
                                ),
                                textDirection: TextDirection.rtl),
                            Text(
                              map!.grandTotal.toStringAsFixed(2),
                              style: const TextStyle(
                                color: PdfColors.black,
                                fontSize: 10,
                                // fontWeight: FontWeight.w700
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          decoration: const BoxDecoration(
                            color: PdfColors.white,
                          ),
                          child: Center(
                              child: Text(
                                '---------------------------------',
                                style: TextStyle(color: PdfColors.black, fontSize: 18),
                              ))),

                      Container(
                        padding: const EdgeInsets.all(1.0),
                        decoration: const BoxDecoration(
                          color: PdfColors.white,
                        ),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                // 'Cash      :  ${pc.toStringAsFixed(2)}',
                                'Cash      :  ${map!.cash}',
                                style: const TextStyle(
                                  color: PdfColors.black,
                                  fontSize: 9,
                                ),
                              ),
                              Text(
                                // 'Bank      :  ${pb.toStringAsFixed(2)}',
                                'Bank      :  ${map!.bank}',
                                style: const TextStyle(
                                  color: PdfColors.black,
                                  fontSize: 9,
                                ),
                              ),
                              Text(
                                // 'Change :  ${bal.toStringAsFixed(2)}',
                                'Change :  ${map!.balance}',
                                style: const TextStyle(
                                  color: PdfColors.black,
                                  fontSize: 9,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                          decoration: const BoxDecoration(
                            color: PdfColors.white,
                          ),
                          child: Center(
                              child: Text(
                                '---------------------------------',
                                style: TextStyle(color: PdfColors.black, fontSize: 18),
                              ))),

                      Container(
                        child: BarcodeWidget(
                          data: qr("100", "120"),
                          width: 70,
                          height: 70,
                          barcode: Barcode.qrCode(),
                          drawText: false,
                        ),
                      ),
                      // Container(
                      //     decoration: const BoxDecoration(
                      //       color: PdfColors.white,
                      //     ),
                      //     child: Center(
                      //         child: Text(
                      //       '---------------------------------',
                      //       style: TextStyle(color: PdfColors.black, fontSize: 18),
                      //     ))),
                      // Text('${PosUserIdToArabicName[currentUserId]}: المحاسب  ',
                      Text('${map!.cashierNameArabic}: المحاسب  ',
                          style: TextStyle(
                            font: myFont2,
                            color: PdfColors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textDirection: TextDirection.rtl),
                      Text(
                        'Cashier : ${map!.cashierName}',
                        style: TextStyle(
                            color: PdfColors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text('شكرًا لزيارتك ونتشوق لرؤيتك مرة أخرى',
                          style: TextStyle(
                            font: myFont2,
                            // fontFamily: 'GE Dinar One Medium',
                            color: PdfColors.black,
                            fontSize: 12,
                            // fontWeight: FontWeight.w600
                          ),
                          textDirection: TextDirection.rtl),
                      Text(
                        'THANK YOU VISIT AGAIN',
                        style: const TextStyle(
                          // fontFamily: 'GE Dinar One Medium',
                          color: PdfColors.black,
                          fontSize: 12,
                          // fontWeight: FontWeight.w600
                        ),
                      ),
                    ])));
      },
    ),
  );

  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());
}
