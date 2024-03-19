import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:awafi_pos/Branches/branches.dart';
// import 'package:awafi_pos/acceptBillmodel.dart';
// import 'package:awafi_pos/acceptbillPdf.dart';
import 'package:awafi_pos/bill.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awafi_pos/flutter_flow/upload_media.dart';
import 'package:awafi_pos/salesPrint/new_sales_print.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as im;

import '../main.dart';
import '../model/acceptBillModel.dart';
import '../pdf/acceptBillPdf.dart';
import '../product_card.dart';

class AcceptedOrdersWidget extends StatefulWidget {
  final String orderId;
  const AcceptedOrdersWidget({Key? key, required this.orderId})
      : super(key: key);

  @override
  _AcceptedOrdersWidgetState createState() => _AcceptedOrdersWidgetState();
}

class _AcceptedOrdersWidgetState extends State<AcceptedOrdersWidget> {
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List billItem = [];
  List<int> bytes = [];
  qr(String vatTotal1, String grantTotal) {
    // seller name
    String sellerName = currentBranchName!;
    String vat_registration = vatNumber!;
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
    List<int> date = utf8.encode(DateTime.now().toString().substring(0, 10));
    bytesBuilder.addByte(date.length);
    bytesBuilder.add(date);
    print(date);

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

  ScreenshotController screenshotController = ScreenshotController();

  List<int> kotBytes = [];
  abc(int invNo, double discount, List items, int token,
      String tableName) async {
    final CapabilityProfile profile = await CapabilityProfile.load();

    final generator = Generator(PaperSize.mm80, profile);
    bytes = [];

    kotBytes = [];

    final Uint8List imgBytes = data!.buffer.asUint8List();
    final im.Image? image = im.decodeImage(imgBytes);
    bytes += generator.imageRaster(image!);

    final im.Image? image1 = im.decodeImage(capturedImage1);
    bytes += generator.imageRaster(image1!);
    capturedImage10 = await screenshotController.captureFromWidget(Container(
      color: Colors.white,
      width: printWidth * 3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
      // ListView(
      //     shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date :',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize + 2,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  '${DateTime.now().toString().substring(0, 19)}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Invoice No:',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize + 2,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  '$invNo',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ]),
    ));
    final im.Image? image10 = im.decodeImage(capturedImage10);
    bytes += generator.imageRaster(image10!);
    bytes += generator.text("-------------------------------------------",
        styles: PosStyles(
          bold: true,
          align: PosAlign.center,
          height: PosTextSize.size2,
        ));

    bytes += generator.text("TABLE : $tableName",
        styles: PosStyles(
            bold: true,
            align: PosAlign.center,
            height: PosTextSize.size2,
            width: PosTextSize.size2));

    bytes += generator.text("-------------------------------------------",
        styles: PosStyles(
          bold: true,
          align: PosAlign.center,
          height: PosTextSize.size2,
        ));

    final im.Image? imagehead = im.decodeImage(capturedhead);

    bytes += generator.imageRaster(
      imagehead!,
    );

    // final im.Image image13 = im.decodeImage(capturedImage12);
    // bytes += generator.image(image13);

    String itemString = '';
    String itemStringArabic = '';
    String itemTotal = '';
    String itemGrossTotal = '';
    String itemTax = '';
    String addON = '';

    double? deliveryCharge = 0;
    double grantTotal = 0;
    double totalAmount = 0;
    String arabic = '';
    String english = '';
    Map<String, dynamic> config = Map();
    List<Widget> itemWidgets = [];
    List<Widget> itemWidgets1 = [];

    for (Map<String, dynamic> item in items) {
      // print(item);
      // print(item["pdtname"]);
      // print(item["price"]);
      double total = double.tryParse(item['price'].toString())! *
          double.tryParse(item['qty'].toString())!;
      double grossTotal = total * 100 / 115;
      double vat = total * 15 / 115;
      newAddOn = item['addOns'] ??
          '' + item['addLess'] ??
          '' + item['addMore'] ??
          '' + item['remove'] ??
          '';

      arabic = item['arabicName'];
      english = item['pdtname'];

      grantTotal += total;

      deliveryCharge = item['deliveryCharge'] == null
          ? 0
          : double.tryParse(item['deliveryCharge'].toString());
      addON = newAddOn.isEmpty ? '' : newAddOn.toString();
      double price = double.tryParse(item['price'].toString())! * 100 / 115;
      totalAmount += price * double.tryParse(item['qty'].toString())!;

      itemWidgets1.add(Container(
          padding: const EdgeInsets.all(1.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
          // ListView(shrinkWrap: true,
              children: [
            Container(
              width: printWidth * 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                english,
                                // textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontFamily: 'GE Dinar One Medium',
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                arabic,
                                // textDirection: TextDirection.rtl,
                                style: const TextStyle(
                                  fontFamily: 'GE Dinar One Medium',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        // Text("${double.tryParse(item['qty'].toString())}     ${price.toStringAsFixed(2)}     ${vat.toStringAsFixed(2)}      ${total.toStringAsFixed(2)}",
                        //   textDirection: TextDirection.ltr,
                        //   textAlign:TextAlign.end,
                        //   style:  TextStyle(
                        //     fontSize: fontSize,
                        //
                        //     fontWeight: FontWeight.w600,
                        //     color: Colors.black,
                        //   ),
                        // ),
                        // Text("${double.tryParse(item['qty'].toString())}     ${price.toStringAsFixed(2)}     ${vat.toStringAsFixed(2)}     ${total.toStringAsFixed(2)}",
                        //
                        Container(
                          width: 45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '${double.tryParse(item['qty'].toString())}',
                                style: TextStyle(
                                    fontFamily: 'GE Dinar One Medium',
                                    color: Colors.black,
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '${price.toStringAsFixed(2)} ',
                                style: TextStyle(
                                    fontFamily: 'GE Dinar One Medium',
                                    color: Colors.black,
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '${vat.toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontFamily: 'GE Dinar One Medium',
                                    color: Colors.black,
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '${total.toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontFamily: 'GE Dinar One Medium',
                                    color: Colors.black,
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
            // Text("${item['pdtname']} $addON",
            //   textDirection: TextDirection.ltr,
            //   style: const TextStyle(
            //     fontSize: 14,
            //     color: Colors.black,
            //   ),
            // ),
          ])));
      if (itemWidgets1.length == itemCount) {
        var capturedIm = await screenshotController.captureFromWidget(Container(
          width: printWidth * 3,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: itemWidgets1.length,
              itemBuilder: (context, index) {
                return itemWidgets1[index];
              }),
        ));

        final im.Image? image2 = im.decodeImage(capturedIm);
        bytes += generator.imageRaster(image2!);
        itemWidgets1 = [];
      }

      itemTotal += (totalAmount * ((100 + gst) / 100) -
          (double.tryParse(discount.toString()) ?? 0))
          .toStringAsFixed(2);
      itemGrossTotal += grossTotal.toStringAsFixed(2);
      itemTax += (totalAmount * gst / 100).toStringAsFixed(2);
    }
    if (itemWidgets1.length > 0) {
      var capturedIm = await screenshotController.captureFromWidget(Container(
        width: printWidth * 3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(itemWidgets1.length, (index) {
            return itemWidgets1[index];
          }),
        )
        // ListView.builder(
        //     shrinkWrap: true,
        //     itemCount: itemWidgets1.length,
        //     itemBuilder: (context, index) {
        //       return itemWidgets1[index];
        //     }),
      ));

      final im.Image? image2 = im.decodeImage(capturedIm);
      bytes += generator.imageRaster(image2!);
      itemWidgets1 = [];
    }
    List<Widget> itemWidgets2 = [];
    itemWidgets.add(Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            padding: const EdgeInsets.all(1.0),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
                child: Text(
                  '=====================',
                  style: TextStyle(color: Colors.black, fontSize: printWidth * .25),
                ))),
        Container(
          padding: const EdgeInsets.all(1.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total - الإجمالي     :  ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize + 4,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                totalAmount.toStringAsFixed(2),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize + 4,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(1.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'VAT -  رقم ضريبة  :   ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize + 4,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '${(totalAmount * gst / 100).toStringAsFixed(2)}',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize + 4,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        // Container(    padding: const EdgeInsets.all(1.0),
        //   decoration: const BoxDecoration(
        //     color: Colors.white,
        //   ),
        //   child:     Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text('Delivery Charge - رسوم التوصيل : ',style:  TextStyle(color: Colors.black,fontSize: fontSize+4,fontWeight: FontWeight.w600),),
        //       Text('$deliveryCharge ',style:  TextStyle(color: Colors.black,fontSize: fontSize+4,fontWeight: FontWeight.w600),),
        //     ],
        //   ),),
        // Container(
        //   padding: const EdgeInsets.all(1.0),
        //   decoration: const BoxDecoration(
        //     color: Colors.white,
        //   ),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text('Discount -  خصم  : ', style: TextStyle(color: Colors.black, fontSize: fontSize+4, fontWeight: FontWeight.w600),),
        //       Text((discount == null ? "0.00" : discount.toStringAsFixed(2)), style: TextStyle(color: Colors.black, fontSize: fontSize+4, fontWeight: FontWeight.w600),),
        //
        //     ],
        //   ),),
        Container(
            padding: const EdgeInsets.all(1.0),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
                child: Text(
                  '-------------------------------------------',
                  style: TextStyle(color: Colors.black, fontSize: printWidth * .25),
                ))),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'NET - المجموع الإجمالي  : ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize + 7,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                grantTotal.toStringAsFixed(2),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize + 7,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
                child: Text(
                  '-------------------------------------------',
                  style: TextStyle(color: Colors.black, fontSize: printWidth * .25),
                ))),
      ],
    ));

    String qrVat = (totalAmount * gst / 100).toStringAsFixed(2);
    String qrTotal = grantTotal.toStringAsFixed(2);
    itemWidgets.add(Container(
      color: Colors.white,
      width: printWidth * 3.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QrImageView(
            data: qr(qrVat, qrTotal),
            version: 6,
            size: size / 1.5,
          )
        ],
      ),
    ));

    var capturedImage2 = await screenshotController.captureFromWidget(Container(
      width: printWidth * 3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(itemWidgets.length, (index) {
          return itemWidgets[index];
        }),
      )
      // ListView.builder(
      //     shrinkWrap: true,
      //     itemCount: itemWidgets.length,
      //     itemBuilder: (context, index) {
      //       return itemWidgets[index];
      //     }),
    ));

    final im.Image? image2 = im.decodeImage(capturedImage2);
    bytes += generator.imageRaster(image2!);
    final im.Image? footer = im.decodeImage(footerImage);
    bytes += generator.imageRaster(
      footer!,
    );
    bytes += generator.feed(2);

    bytes += generator.cut();

    try {
      flutterUsbPrinter.write(Uint8List.fromList(bytes));
    } catch (error) {
      print(
        error.toString(),
      );
    }
    print("end");
    print(Timestamp.now().seconds);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('orderId', isEqualTo: widget.orderId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          var data = snapshot.data!.docs;
          var bag = data[0]['salesItems'];
          int invoiceNo = data[0]['invoiceNo'];
          int token = data[0]['token'];

          List addOn = [];
          billItem = [];

          for (Map<String, dynamic> snap in bag) {
            addOn = snap['addOn'];
          }
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.primaryColor,
              automaticallyImplyLeading: true,
              iconTheme: IconThemeData(color: Colors.white),
              title: Text(
                'Order Details',
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              actions: const [],
              centerTitle: true,
              elevation: 0,
            ),
            backgroundColor: const Color(0xFFF5F5F5),
            body: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                          color: Colors.white,
                          elevation: 5,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Order Id : ${data[0]['orderId']}',
                                        style:
                                        FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 5, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Customer Name :${data[0]['name']}',
                                        style:
                                        FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 5, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Address : ${data[0]['address']}',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 5, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Phone Number : ${data[0]['phone']}',
                                        style:
                                        FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 5, 10, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Delivery Location : ${data[0]['address']}',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 5, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Branch : ${data[0]['branchName']}',
                                        style:
                                        FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 5, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Table : ',
                                        style:
                                        FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        '${data[0]['table']}',
                                        style: FlutterFlowTheme.bodyText1
                                            .override(
                                            fontFamily: 'Poppins',
                                            color: data[0]['table'] ==
                                                'Home Delivery'
                                                ? Colors.blue
                                                : data[0]['table'] ==
                                                'Take Away'
                                                ? Colors.green
                                                : Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                      const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: bag == null
                          ? const Center(
                        child: CircularProgressIndicator(),
                      )
                          : ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: bag.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          double addOnPrice = double.tryParse(
                              bag[index]['addOnPrice'].toString()) ??
                              0;
                          double addmorePrice = double.tryParse(bag[index]
                          ['addMorePrice']
                              .toString()) ??
                              0;
                          double addlessPrice = double.tryParse(bag[index]
                          ['addLessPrice']
                              .toString()) ??
                              0;
                          double removePrice = double.tryParse(
                              bag[index]['removePrice'].toString()) ??
                              0;

                          List addOnName = [];
                          List addmoreName = [];
                          List addlessName = [];
                          List removeName = [];

                          List<dynamic> addOn = bag[index]['addOn'] ?? [];
                          List<dynamic> addLess =
                              bag[index]['addLess'] ?? [];
                          List<dynamic> addMore =
                              bag[index]['addMore'] ?? [];
                          List<dynamic> remove =
                              bag[index]['remove'] ?? [];

                          List<dynamic> arabicAddOn =
                              bag[index]['addOnArabic'] ?? [];
                          List<dynamic> arabicAddLess =
                              bag[index]['addLessArabic'] ?? [];
                          List<dynamic> arabicAddMore =
                              bag[index]['addMoreArabic'] ?? [];
                          List<dynamic> arabicRemove =
                              bag[index]['removeArabic'] ?? [];

                          if (addOn.isNotEmpty) {
                            for (Map<String, dynamic> items in addOn) {
                              addOnName.add(items['addOn']);
                              //   addOnPrice+=double.tryParse(items['price']);
                            }
                          }
                          if (remove.isNotEmpty) {
                            for (Map<String, dynamic> items in remove) {
                              removeName.add(items['addOn']);
                              // removePrice+=double.tryParse(items['price']);
                            }
                          }
                          if (addMore.isNotEmpty) {
                            for (Map<String, dynamic> items in addMore) {
                              addmoreName.add(items['addOn']);
                              // addmorePrice+=double.tryParse(items['price']);
                            }
                          }
                          if (addLess.isNotEmpty) {
                            for (Map<String, dynamic> items in addLess) {
                              addlessName.add(items['addOn']);
                              // addlessPrice+=double.tryParse(items['price']);
                            }
                          }
                          Map<String, dynamic> variants = {};
                          if (bag.isNotEmpty) {
                            variants = bag[index]['variant'];
                          }

                          billItem.add({
                            'variant': variants,
                            'arabicName': bag[index]['arabicName'],
                            'category': bag[index]['category'],
                            'pdtname': bag[index]['productName'],
                            'price':
                            bag[index]['price'] / bag[index]['qty'],
                            'qty': int.tryParse(
                                bag[index]['qty'].toString()),
                            'addOns': addOnName,
                            'addLess': addlessName,
                            'addMore': addmoreName,
                            'remove': removeName,
                            'addOnPrice': addOnPrice,
                            'addMorePrice': addmorePrice,
                            'addLessPrice': addlessPrice,
                            'removePrice': removePrice,
                            'addOnArabic': arabicAddOn,
                            'removeArabic': arabicRemove,
                            'addLessArabic': arabicAddLess,
                            'addMoreArabic': arabicAddMore,
                            'return': false,
                            'returnQty': 0
                          });
                          // double addOnPrice=0;
                          //
                          // List addOnName=[];
                          // for(Map<String,dynamic> items in addOn){
                          //   addOnName.add(items['addOn']);
                          //   addOnPrice+=double.tryParse(items['price']);
                          //
                          // }
                          // Map<String,dynamic> variants={};
                          // if(bag.isNotEmpty){
                          //   variants=bag[index]['variant'];
                          // }
                          //
                          // billItem.add({
                          //   'addOnPrice':double.tryParse(addOnPrice.toStringAsFixed(2)),
                          //   'addOns':addOnName,
                          //   'addOnArabic':[],
                          //   'variant':variants,
                          //   'arabicName':bag[index]['arabicName'],
                          //   'pdtname':bag[index]['productName'],
                          //   'price':bag[index]['price']/bag[index]['qty'],
                          //   'qty':int.tryParse(bag[index]['qty'].toString()),
                          // });

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              color: Colors.transparent,
                              elevation: 5,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(0),
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: bag[index]['photoUrl'],
                                        width: 90,
                                        height: 90,
                                        fit: BoxFit.contain,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceEvenly,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    bag[index]
                                                    ['productName'],
                                                    style:
                                                    FlutterFlowTheme
                                                        .bodyText1
                                                        .override(
                                                      fontFamily:
                                                      'Poppins',
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    variants.isEmpty
                                                        ? ''
                                                        : ' - ${variants['english'] ?? ''}',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                        FontWeight
                                                            .w600),
                                                  ),
                                                ],
                                              ),
                                              addOnName.isNotEmpty
                                                  ? Row(
                                                children: [
                                                  Text(
                                                    "INCLUDE : ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight
                                                            .bold),
                                                  ),
                                                  Text(
                                                    "${addOnName.toString().substring(1, addOnName.toString().length - 1)}",
                                                  ),
                                                ],
                                              )
                                                  : Container(),
                                              removeName.isNotEmpty
                                                  ? Row(
                                                children: [
                                                  Text(
                                                    "REMOVE : ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight
                                                            .bold),
                                                  ),
                                                  Text(
                                                    "${removeName.toString().substring(1, removeName.toString().length - 1)}",
                                                  ),
                                                ],
                                              )
                                                  : Container(),
                                              addlessName.isNotEmpty
                                                  ? Row(
                                                children: [
                                                  Text(
                                                    "ADD LESS : ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight
                                                            .bold),
                                                  ),
                                                  Text(
                                                    "${addlessName.toString().substring(1, addlessName.toString().length - 1)}",
                                                  ),
                                                ],
                                              )
                                                  : Container(),
                                              addmoreName.isNotEmpty
                                                  ? Row(
                                                children: [
                                                  Text(
                                                    "ADD MORE : ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight
                                                            .bold),
                                                  ),
                                                  Text(
                                                    "${addmoreName.toString().substring(1, addmoreName.toString().length - 1)}",
                                                  ),
                                                ],
                                              )
                                                  : Container(),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Qty : ${bag[index]['qty'].toString()}',
                                                    style:
                                                    FlutterFlowTheme
                                                        .bodyText1
                                                        .override(
                                                      fontFamily:
                                                      'Poppins',
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    'SAR ${bag[index]['price'].toString()}',
                                                    style:
                                                    FlutterFlowTheme
                                                        .bodyText1
                                                        .override(
                                                      fontFamily:
                                                      'Poppins',
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0, 1),
                    child: Padding(
                      padding:
                      const EdgeInsetsDirectional.fromSTEB(10, 20, 20, 40),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Total Price : SAR ${data[0]['total']}',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0, 0.45),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FFButtonWidget(
                            onPressed: () async {

                              if(Platform.isWindows) {
                                setState(() => _loadingButton = true);
                                try {
                                  billItem = [];
                                  for (int i = 0; i < bag.length; i++) {
                                    double addOnPrice = 0;

                                    List addOnName = [];
                                    for (Map<String, dynamic> items in addOn) {
                                      addOnName.add(items['addOn']);
                                      addOnPrice +=
                                      double.tryParse(items['price'])!;
                                    }
                                    Map<String, dynamic> variants = {};
                                    if (bag.isNotEmpty) {
                                      variants = bag[i]['variant'];
                                    }

                                    billItem.add({
                                      'addOnPrice': double.tryParse(
                                          addOnPrice.toStringAsFixed(2)),
                                      'addOns': addOnName,
                                      'addOnArabic': [],
                                      'variant': variants,
                                      'arabicName': bag[i]['arabicName'],
                                      'pdtname': bag[i]['productName'],
                                      'price': bag[i]['price'] / bag[i]['qty'],
                                      'qty':
                                      int.tryParse(bag[i]['qty'].toString()),
                                    });
                                  }

                                  items = billItem;

                                  final billModel = BillModelOrderAccept(
                                    vat: double.tryParse(data[0]['tax']) ?? 0,
                                    grandTotal: double.tryParse(
                                        data[0]['total']) ?? 0,
                                    cashierName: PosUserIdToArabicName[currentUserId],
                                    cashierNameArabic: PosUserIdToArabicName[currentUserId],
                                    date: DateTime.now(),
                                    invoiceNumber: invoiceNo,
                                    mobileNumber: billMobileNo!,
                                    orderType: "online Order",
                                    productItems: billItem,
                                    shopName: currentBranchName!,
                                    shopNameArabic: currentBranchAddressArabic!,
                                    vatNumber: vatNumber!,
                                    total: double.tryParse(
                                        data[0]['subTotal']) ?? 0,
                                    table: data[0]['table'],
                                  );

                                  blue
                                      ? showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        items = billItem;
                                        return mytest(
                                          items: billItem,
                                          token: token,
                                          customer: data[0]['name'],
                                          discountPrice: 0,
                                          invoiceNo: invoiceNo.toString(),
                                          selectedTable: data[0]['table'],
                                        );
                                      })
                                      :

                                  // abc(invoiceNo, 0, billItem, token,data[0]['table']);

                                  generateAcceptBillPdf(billModel);

                                  showUploadMessage(
                                      context, 'Print Successfully..');
                                } finally {
                                  setState(() => _loadingButton = false);
                                }
                              }

                              else if(Platform.isAndroid){
                                setState(() => _loadingButton = true);
                                try {
                                  billItem=[];
                                  for(int i=0;i<bag.length;i++){
                                    double addOnPrice=0;

                                    List addOnName=[];
                                    for(Map<String,dynamic> items in addOn){
                                      addOnName.add(items['addOn']);
                                      addOnPrice+=double.tryParse(items['price'])!;

                                    }
                                    Map<String,dynamic> variants={};
                                    if(bag.isNotEmpty){
                                      variants=bag[i]['variant'];
                                    }

                                    billItem.add({
                                      'addOnPrice':double.tryParse(addOnPrice.toStringAsFixed(2)),
                                      'addOns':addOnName,
                                      'addOnArabic':[],
                                      'variant':variants,
                                      'arabicName':bag[i]['arabicName'],
                                      'pdtname':bag[i]['productName'],
                                      'price':bag[i]['price']/bag[i]['qty'],
                                      'qty':int.tryParse(bag[i]['qty'].toString()),
                                    });
                                  }
                                  // await showDialog(
                                  //     barrierDismissible: false,
                                  //     context: context,
                                  //     builder:
                                  //         (BuildContext context) {
                                  items = billItem;

                                  blue?
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder:
                                          (BuildContext context) {
                                        items = billItem;
                                        return  mytest(
                                          items: billItem,
                                          token:token,
                                          customer: data[0]['name'],
                                          discountPrice:0,
                                          invoiceNo: invoiceNo.toString(),
                                          selectedTable: data[0]['table'],
                                        );

                                      }):

                                  print("billItem");
                                  print(billItem);
                                  print(billItem.length);
                                  abc(invoiceNo, 0, billItem, token,data[0]['table']);
                                  // Navigator.pop(context);
                                  showUploadMessage(context, 'Print Successfully..');


                                } finally {
                                  setState(() => _loadingButton = false);
                                }
                              }
                            },
                            text: 'DUPLICATE BILL',
                            options: FFButtonOptions(
                              // width: 160,
                              height: 45,
                              color: const Color(0xFFC80707),
                              textStyle: FlutterFlowTheme.subtitle2.override(
                                fontFamily: 'Poppins',
                                color: Colors.red,
                                 fontSize: 13,
                              ),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: 12,
                            ),
                            loading: _loadingButton,
                            icon: Icon(Icons.book),
                            iconData: Icons.book,
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              setState(() => _loadingButton = true);
                              try {
                                DocumentSnapshot order = data[0];
                                order.reference.update({
                                  'status': 6,
                                  'pickedUpTime': DateTime.now(),
                                  // 'status':2,
                                  // 'DeliveredTime':DateTime.now(),
                                });
                                Navigator.pop(context);
                                showUploadMessage(context, ' Order Picked');
                              } finally {
                                setState(() => _loadingButton = false);
                              }
                            },
                            text: 'Mark As Picked',
                            options: FFButtonOptions(
                              // width: 160,
                              height: 45,
                              color: const Color(0xFFC80707),
                              textStyle: FlutterFlowTheme.subtitle2.override(
                                fontFamily: 'Poppins',
                                color: Colors.red,
                                fontSize: 13,
                              ),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: 12,
                            ),
                            loading: _loadingButton,
                            icon: Icon(Icons.arrow_circle_right_outlined),
                            iconData: Icons.arrow_circle_right_outlined,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
