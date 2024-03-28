import 'dart:developer';
import 'dart:io';
import "package:awafi_pos/bill.dart";
import 'package:awafi_pos/core/loader.dart';
import 'package:awafi_pos/features/home/screen/printer_component.dart';
import 'package:flutter/foundation.dart';
import 'package:awafi_pos/features/product/screen/productandcat.dart';
import 'package:awafi_pos/salesPrint/new_sales_print.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:typed_data';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as im;
import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_usb_printer/flutter_usb_printer.dart';
import 'package:path_provider/path_provider.dart';
import '../../../Branches/branches.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../flutter_flow/upload_media.dart';
import '../../../main.dart';
import '../../../model/billModel.dart';
import '../../../orders/live_orders.dart';
import '../../../orders/order_confirm.dart';
import '../../../pdf/generatePdf.dart';
import '../../product/screen/product_card.dart';
import '../controller/home_controller.dart';
import 'home_drawer.dart';
import 'home_page.dart';

class HomeBody extends ConsumerStatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends ConsumerState<HomeBody> {
  ArabicNumbers arabicNumber = ArabicNumbers();
  bool _connected = false;
  bool _pressed = false;
  bool enable = false;
  bool disable = false;
  int selectedTableIndex = 0;
  int count = 300;
  List<String> tables = [];
  TextEditingController mobileNo = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController deliveryCharge = TextEditingController();
  TextEditingController paidCash = TextEditingController();
  TextEditingController paidBank = TextEditingController();
  TextEditingController tableController = TextEditingController();
  TextEditingController amex = TextEditingController();
  TextEditingController mada = TextEditingController();
  TextEditingController visa = TextEditingController();
  TextEditingController master = TextEditingController();
  double amexPaid = 0;
  double masterPaid = 0;
  double visaPaid = 0;
  double madaPaid = 0;

  _getDevicelist() async {
    List<Map<String, dynamic>> results = [];
    results = await FlutterUsbPrinter.getUSBDeviceList();
    for (dynamic device in results) {
      _connect(int.parse(device['vendorId']), int.parse(device['productId']));
    }
    if (mounted) {
      setState(() {
        devices = results;
      });
    }
  }

  bool working = false;
  List<int> bytes = [];
  List<int> kotBytes = [];
  setItemWidgets(List items) async {
    while (working) {
      await Future.delayed(const Duration(milliseconds: 300));
    }
    working = true;

    List itemWidgets1 = [];
    imageList = [];

    for (Map<String, dynamic> item in items) {
      double addOnPrice = item['addOnPrice'] ??
          0 - item['removePrice'] ??
          0 - item['addLessPrice'] ??
          0 + item['addMorePrice'] ??
          0;
      double total = (double.tryParse(item['price'].toString()) ?? 0.0) +
          addOnPrice * (double.tryParse(item['qty'].toString()) ?? 0.0);

      double grossTotal = total * 100 / 115;
      double vat =
          (double.tryParse(item['price'].toString())! + addOnPrice) * 15 / 115;
      List newAddOn = item['addOns'] ??
          '' + item['addLess'] ??
          '' + item['addMore'] ??
          '' + item['remove'] ??
          '';

      String arabic = item['arabicName'] + " " + item["variantNameArabic"];
      String english = item['pdtname'] + " " + item["variantName"];

      newAddOn = item['addOns'] ??
          '' + item['addLess'] ??
          '' + item['addMore'] ??
          '' + item['remove'] ??
          '';
      newAddOnArabic = item['addOnArabic'] ??
          '' + item['addLessArabic'] ??
          '' + item['addMoreArabic'] ??
          '' + item['removeArabic'] ??
          '';
      String addOnArabic =
          newAddOnArabic.isEmpty ? '' : newAddOnArabic.toString();
      String addON = newAddOn.isEmpty ? '' : newAddOn.toString();
      double price =
          (double.tryParse(item['price'].toString())! + addOnPrice)! *
              100 /
              115;

      itemWidgets1.add(Container(
          width: printWidth * 3,
          padding: const EdgeInsets.all(1.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              // ListView(
              //     shrinkWrap: true,
              children: [
                SizedBox(
                  width: printWidth * 3,
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
                                  '$arabic $addOnArabic',
                                  // textDirection: TextDirection.rtl,
                                  style: const TextStyle(
                                    fontFamily: 'GE Dinar One Medium',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '$english $addON',
                                  // textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontFamily: 'GE Dinar One Medium',
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 45,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text('${arabicNumber.convert(double.tryParse(item['qty'].toString()).toStringAsFixed(2))}',
                                //   style:  TextStyle(
                                //       fontFamily: 'GE Dinar One Medium',
                                //       color: Colors.black,
                                //       fontSize: fontSize+2,
                                //       fontWeight: FontWeight.w600),
                                // ),
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
                          SizedBox(
                            width: 45,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text('${arabicNumber.convert(price.toStringAsFixed(2))} ',
                                //   style:  TextStyle(
                                //       fontFamily: 'GE Dinar One Medium',
                                //       color: Colors.black,
                                //       fontSize: fontSize+2,
                                //       fontWeight: FontWeight.w600),
                                // ),
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
                          SizedBox(
                            width: 45,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text('${arabicNumber.convert(vat.toStringAsFixed(2))}',
                                //   style:  TextStyle(
                                //       fontFamily: 'GE Dinar One Medium',
                                //       color: Colors.black,
                                //       fontSize: fontSize+2,
                                //       fontWeight: FontWeight.w600),
                                // ),
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
                          SizedBox(
                            width: 50,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text('${arabicNumber.convert(total.toStringAsFixed(2))}',
                                //   style:  TextStyle(
                                //       fontFamily: 'GE Dinar One Medium',
                                //       color: Colors.black,
                                //       fontSize: fontSize+2,
                                //       fontWeight: FontWeight.w600),
                                // ),
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
                      const SizedBox(height: 10)
                    ],
                  ),
                ),
              ])));
      if (itemWidgets1.length == itemCount) {
        itemImage = await screenshotController.captureFromWidget(Container(
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

        final im.Image? image22 = im.decodeImage(itemImage);
        imageList.add(image22!);
        itemWidgets1 = [];
      }
    }
    if (itemWidgets1.isNotEmpty) {
      var capturedIm = await screenshotController.captureFromWidget(Container(
          width: printWidth * 3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // ListView.builder(
            //     shrinkWrap: true,
            children: List.generate(itemWidgets1.length, (index) {
              return itemWidgets1[index];
            }),
          )));

      final im.Image? image22 = im.decodeImage(capturedIm);
      imageList.add(image22!);

      itemWidgets1 = [];
    }
    if (itemWidgets1.isEmpty) {
      setState(() {
        enable = true;
      });
    }
    working = false;
  }

  counter() async {
    for (int i = count; i > 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      if (i == 5) {
        final CapabilityProfile profile = await CapabilityProfile.load();
        final generator = Generator(PaperSize.mm80, profile);

        bytes = generator.beep(duration: PosBeepDuration.beep50ms, n: 1);
        flutterUsbPrinter.write(Uint8List.fromList(bytes));
        bytes = [];
        i = count;
      }
    }
  }

  Future setItemWidgets1(List items) async {
    while (working) {
      await Future.delayed(const Duration(milliseconds: 300));
    }
    working = true;

    List itemWidgets1 = [];
    imageList = [];

    for (Map<String, dynamic> item in items) {
      double addOnPrice = item['addOnPrice'] ??
          0 - item['removePrice'] ??
          0 - item['addLessPrice'] ??
          0 + item['addMorePrice'] ??
          0;
      double total = (double.tryParse(item['price'].toString()) ?? 0.0) +
          addOnPrice * (double.tryParse(item['qty'].toString()) ?? 0.0);

      double grossTotal = total * 100 / 115;
      double vat =
          (double.tryParse(item['price'].toString())! + addOnPrice) * 15 / 115;
      List newAddOn = item['addOns'] ??
          '' + item['addLess'] ??
          '' + item['addMore'] ??
          '' + item['remove'] ??
          '';
      String arabic = item['arabicName'];
      String english = item['pdtname'];

      newAddOn = item['addOns'] ??
          '' + item['addLess'] ??
          '' + item['addMore'] ??
          '' + item['remove'] ??
          '';
      newAddOnArabic = item['addOnArabic'] ??
          '' + item['addLessArabic'] ??
          '' + item['addMoreArabic'] ??
          '' + item['removeArabic'] ??
          '';
      String addOnArabic =
          newAddOnArabic.isEmpty ? '' : newAddOnArabic.toString();
      String addON = newAddOn.isEmpty ? '' : newAddOn.toString();
      double price =
          (double.tryParse(item['price'].toString())! + addOnPrice) * 100 / 115;

      itemWidgets1.add(Container(
          width: printWidth * 3,
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
                                  '$arabic $addOnArabic',
                                  // textDirection: TextDirection.rtl,
                                  style: const TextStyle(
                                    fontFamily: 'GE Dinar One Medium',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '$english $addON',
                                  // textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontFamily: 'GE Dinar One Medium',
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 45,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text('${arabicNumber.convert(double.tryParse(item['qty'].toString()).toStringAsFixed(2))}',
                                //   style:  TextStyle(
                                //       fontFamily: 'GE Dinar One Medium',
                                //       color: Colors.black,
                                //       fontSize: fontSize+2,
                                //       fontWeight: FontWeight.w600),
                                // ),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text('${arabicNumber.convert(price.toStringAsFixed(2))} ',
                                //   style:  TextStyle(
                                //       fontFamily: 'GE Dinar One Medium',
                                //       color: Colors.black,
                                //       fontSize: fontSize+2,
                                //       fontWeight: FontWeight.w600),
                                // ),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text('${arabicNumber.convert(vat.toStringAsFixed(2))}',
                                //   style:  TextStyle(
                                //       fontFamily: 'GE Dinar One Medium',
                                //       color: Colors.black,
                                //       fontSize: fontSize+2,
                                //       fontWeight: FontWeight.w600),
                                // ),
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
                            width: 50,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text('${arabicNumber.convert(total.toStringAsFixed(2))}',
                                //   style:  TextStyle(
                                //       fontFamily: 'GE Dinar One Medium',
                                //       color: Colors.black,
                                //       fontSize: fontSize+2,
                                //       fontWeight: FontWeight.w600),
                                // ),
                                Text(
                                  total.toStringAsFixed(2),
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
                      const SizedBox(height: 10)
                    ],
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
        itemImage = await screenshotController.captureFromWidget(Container(
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

        final im.Image? image22 = im.decodeImage(itemImage);
        imageList.add(image22!);
        itemWidgets1 = [];
      }
    }
    if (itemWidgets1.isNotEmpty) {
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

      final im.Image? image22 = im.decodeImage(capturedIm);
      imageList.add(image22!);

      itemWidgets1 = [];
    }
    if (itemWidgets1.isEmpty) {
      setState(() {
        enable = true;
        print("enaable---------------------------");
        print(enable);
      });
    }

    working = false;
  }

  List previousItems = [];

  @override
  void dispose() {
    super.dispose();
  }

  // ScreenshotController screenshotController = ScreenshotController();

  getAlert() {
    FirebaseFirestore.instance
        .collection('orders')
        .where('branchId', isEqualTo: currentBranchId)
        .orderBy('salesDate', descending: true)
        .where('status', isEqualTo: 0)
        .snapshots()
        .listen((event) {
      if (event.docs.isNotEmpty) {
        // print('mmm');
        for (var doc in event.docs) {
          if (doc.get('orderId') != null && doc.get('status') == 0) {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: Text('Online Order'),
                content: Container(
                  height: MediaQuery.of(context).size.width * 0.09,
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          "You have received a new order",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                      Text("Table  :${(doc.get('table'))}"),
                      Text("Customer Name :${(doc.get('name'))}"),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderConfirmWidget(
                                    orderId: doc.get('orderId'),
                                    customerName: doc.get('userName'),
                                  )));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: default_color,
                          borderRadius: BorderRadius.circular(7)),
                      padding: const EdgeInsets.all(14),
                      child: const Text(
                        "view",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }
      }
    });
  }

  _connect(int vendorId, int productId) async {
    bool? returned;
    try {
      returned = await flutterUsbPrinter.connect(vendorId, productId);
    } on PlatformException {}
    if (returned!) {
      setState(() {
        connected = true;
      });
    }
  }

  setPrinterImages() async {
    while (printWidth == 0) {
      await Future.delayed(const Duration(seconds: 1));
    }
    capturedImage1 = await screenshotController.captureFromWidget(Container(
      color: Colors.white,
      width: printWidth * 3,
      height: 200,
      child:
          // ListView(shrinkWrap: true,
          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text(
              currentBranchAddressArabic!,
              style: TextStyle(
                  fontFamily: 'GE Dinar One Medium',
                  color: Colors.black,
                  fontSize: fontSize + 2,
                  fontWeight: FontWeight.w600),
            )),
            Text(
              " : اسم الفرع",
              style: TextStyle(
                  fontFamily: 'GE Dinar One Medium',
                  color: Colors.black,
                  fontSize: fontSize + 2,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Branch Name: ",
              style: TextStyle(
                  fontFamily: 'GE Dinar One Medium',
                  color: Colors.black,
                  fontSize: fontSize + 2,
                  fontWeight: FontWeight.w600),
            ),
            Expanded(
                child: Text(
              currentBranchAddress!,
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontFamily: 'GE Dinar One Medium',
                  color: Colors.black,
                  fontSize: fontSize + 2,
                  fontWeight: FontWeight.w600),
            )),
          ],
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
        Text("☎️ $billMobileNo",
            style: TextStyle(
                color: Colors.black,
                fontSize: fontSize + 14,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center),
        Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
                child: Text(
              '-------------------------------------------',
              style: TextStyle(color: Colors.black, fontSize: printWidth * .25),
            ))),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Vat No:',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: fontSize + 2,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              vatNumber!,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ]),
    ));
    capturedhead = await screenshotController.captureFromWidget(Container(
      color: Colors.white,
      width: printWidth * 3,
      height: 85,
      padding: const EdgeInsets.only(top: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //pdt
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'منتج',
                      style: TextStyle(
                        fontFamily: 'GE Dinar One Medium',
                        fontSize: fontSize,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Product',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'GE Dinar One Medium',
                          fontSize: fontSize,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Container(
                width: 45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'كمية',
                      style: TextStyle(
                          fontFamily: 'GE Dinar One Medium',
                          color: Colors.black,
                          fontSize: fontSize,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Qty',
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'سعر',
                      style: TextStyle(
                          fontFamily: 'GE Dinar One Medium',
                          color: Colors.black,
                          fontSize: fontSize,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Rate',
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ضريبة',
                      style: TextStyle(
                          fontFamily: 'GE Dinar One Medium',
                          color: Colors.black,
                          fontSize: fontSize,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'vat',
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
                width: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'المجموع',
                      style: TextStyle(
                          fontFamily: 'GE Dinar One Medium',
                          color: Colors.black,
                          fontSize: fontSize,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Total',
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
          Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Center(
                  child: Text(
                '-------------------------------------------',
                style:
                    TextStyle(color: Colors.black, fontSize: printWidth * .25),
              ))),
        ],
      ),
    ));
    while (PosUserIdToArabicName[currentUserId] == null) {
      await Future.delayed(Duration(seconds: 1));
    }
    print("finished");
    footerImage = await screenshotController.captureFromWidget(Container(
      width: printWidth * 3,
      height: printWidth * 1.2,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(
                height: 8,
              ),
              Text(
                '${PosUserIdToArabicName[currentUserId]}: المحاسب  ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: fontSize + 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Cashier : ${PosUserIdToName[currentUserId]}',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'شكرًا لزيارتك ونتشوق لرؤيتك مرة أخرى',
                style: TextStyle(
                    fontFamily: 'GE Dinar One Medium',
                    color: Colors.black,
                    fontSize: fontSize + 3,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'THANK YOU VISIT AGAIN',
                style: TextStyle(
                    fontFamily: 'GE Dinar One Medium',
                    color: Colors.black,
                    fontSize: fontSize + 3,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    ));
  }

  ingredientsUpdate(List billItems, WidgetRef ref) {
    ref.read(homeControllerProvider).ingredientsUpdate(billItems);
  }

  getCreditDetailes(String mobileNo, WidgetRef ref) {
    ref.read(homeControllerProvider).getCreditDetails(mobileNo);
  }

  @override
  void initState() {
    enable = false;
    dropdownvalue = "Take Away";
    currentWaiter = null;
    bankValue = "Select";
    setPrinterImages();
    super.initState();
    getAlert();
    getPrinters();
    getAllCategories();
    counter();
    _getDevicelist();
    bluetooth = BlueThermalPrinter.instance;
    initPlatformState();
    initSavetoPath();
    mobileNo = TextEditingController();
    discountController = TextEditingController();
    deliveryCharge = TextEditingController();
    paidCash = TextEditingController(text: '0');
    paidBank = TextEditingController(text: '0');
    tableController = TextEditingController();

    amex = TextEditingController(text: "0.0");
    mada = TextEditingController(text: "0.0");
    visa = TextEditingController(text: "0.0");
    master = TextEditingController(text: "0.0");

    // getAlert();
  }

  getPrinters() {
    ref.read(homeControllerProvider).getPrinters();
    setState(() {});
  }

  getAllCategories() {
    ref.read(homeControllerProvider).getAllCategories();
    setState(() {});
  }

  setSearchParam(String caseNumber) {
    List<String> caseSearchList = [];
    String temp = "";

    List<String> nameSplits = caseNumber.split(" ");
    for (int i = 0; i < nameSplits.length; i++) {
      String name = "";

      for (int k = i; k < nameSplits.length; k++) {
        name = "$name${nameSplits[k]} ";
      }
      temp = "";

      for (int j = 0; j < name.length; j++) {
        temp = temp + name[j];
        caseSearchList.add(temp.toUpperCase());
      }
    }
    return caseSearchList;
  }

  int token = 0;

  initSavetoPath() async {
    //read and write
    //image max 300px X 300px
    const filename = 'pizzaromiBill.png';
    const filename1 = 'pizzaromiBill.png';
    var bytes = await rootBundle.load("assets/pizzaromiBill.png");
    var bytes1 = await rootBundle.load("assets/pizzaromiBill.png");
    String dir = (await getApplicationDocumentsDirectory()).path;
    writeToFile(bytes, '$dir/$filename');
    writeToFile(bytes1, '$dir/$filename1');
    setState(() {
      topImage = '$dir/$filename';
      heading = '$dir/$filename1';
    });
  }

  Future<File> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future<void> initPlatformState() async {
    List<BluetoothDevice>? devices = [];

    try {
      devices = await bluetooth?.getBondedDevices();
    } on PlatformException {
      // TODO - Error
    }
    bluetooth!.onStateChanged().listen((state) {
      print("connect");
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          setState(() {
            _connected = true;
            _pressed = false;
          });
          break;
        case BlueThermalPrinter.DISCONNECTED:
          setState(() {
            _connected = false;
            _pressed = false;
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return;
    setState(() {
      btDevices = devices!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return ref.watch(getPosUserProvider).when(
            data: (d) {
              return ref.watch(getSettingsProvider).when(
                    data: (da) {
                      return ref.watch(getTokenProvider).when(
                            data: (dat) {
                              token = dat;
                              return ref.watch(getTablesProvider).when(
                                    data: (tab) {
                                      tables = [];
                                      tables = tab;
                                      return Scaffold(
                                          drawer:
                                              HomeDrawer(setState: setState),
                                          body: Builder(
                                            builder: (context) => Row(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.08,
                                                  padding: EdgeInsets.only(
                                                      top:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.05),
                                                  color: default_color,
                                                  child: Column(
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {
                                                            Scaffold.of(context)
                                                                .openDrawer();
                                                            // FocusScope.of(context).unfocus();
                                                          },
                                                          tooltip: MaterialLocalizations
                                                                  .of(context)
                                                              .openAppDrawerTooltip,
                                                          icon: const Icon(
                                                            Icons.menu,
                                                            color: Colors.white,
                                                            size: 30,
                                                          )),
                                                      const SingleChildScrollView(
                                                        child: SizedBox(
                                                          height: 20,
                                                        ),
                                                      ),
                                                      IconButton(
                                                          onPressed: () async {
                                                            Map<String, dynamic>
                                                                items = {};

                                                            items =
                                                                await showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return StatefulBuilder(builder:
                                                                          (context,
                                                                              setState) {
                                                                        return AlertDialog(
                                                                          title:
                                                                              Container(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 20, right: 20),
                                                                            height:
                                                                                100,
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                const SizedBox(
                                                                                  height: 10,
                                                                                ),
                                                                                const Text(
                                                                                  "Add Token",
                                                                                  style: TextStyle(fontSize: 12),
                                                                                ),
                                                                                const SizedBox(
                                                                                  height: 20,
                                                                                ),
                                                                                Expanded(
                                                                                  child: Container(
                                                                                    padding: const EdgeInsets.all(3),
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(5),
                                                                                      color: Colors.black,
                                                                                    ),
                                                                                    child: Row(
                                                                                      children: [
                                                                                        Container(
                                                                                          width: 200,
                                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.white),
                                                                                          child: Center(
                                                                                            child: TextFormField(
                                                                                              onEditingComplete: () {
                                                                                                FocusScope.of(context).unfocus();

                                                                                                setState(() {
                                                                                                  keyboard = false;
                                                                                                });
                                                                                              },
                                                                                              onTap: () {
                                                                                                setState(() {
                                                                                                  keyboard = true;
                                                                                                });
                                                                                              },
                                                                                              controller: tableController,
                                                                                              keyboardType: TextInputType.number,
                                                                                              decoration: InputDecoration(
                                                                                                labelText: 'Token No',
                                                                                                hoverColor: default_color,
                                                                                                hintText: 'Token No',
                                                                                                border: OutlineInputBorder(
                                                                                                  borderRadius: BorderRadius.circular(5.0),
                                                                                                ),
                                                                                                focusedBorder: OutlineInputBorder(
                                                                                                  borderSide: BorderSide(color: Colors.pink.shade900, width: 1.0),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          actions: <Widget>[
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                FocusScope.of(context).unfocus();
                                                                                Navigator.pop(
                                                                                  context,
                                                                                );
                                                                                keyboard = false;
                                                                              },
                                                                              child: const Text('Cancel'),
                                                                            ),
                                                                            TextButton(
                                                                              onPressed: () async {
                                                                                FocusScope.of(context).unfocus();
                                                                                keyboard = false;
                                                                                ref.read(homeControllerProvider).addTable(tableController.text, context);
                                                                                tableController.clear();
                                                                                // Navigator.pop(context, items);
                                                                              },
                                                                              child: const Text('Add'),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      });
                                                                    });
                                                          },
                                                          icon: const Icon(
                                                            Icons.add,
                                                            color: Colors.white,
                                                            size: 30,
                                                          )),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Expanded(
                                                        child: ListView.builder(
                                                            itemCount:
                                                                tables.length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return Column(
                                                                  children: [
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    InkWell(
                                                                      onLongPress:
                                                                          () async {
                                                                        ref.read(homeControllerProvider).deleteTable(
                                                                            tables[index].toString(),
                                                                            context);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        padding: const EdgeInsets
                                                                            .fromLTRB(
                                                                            0,
                                                                            5,
                                                                            0,
                                                                            5),
                                                                        height:
                                                                            60,
                                                                        width:
                                                                            60,
                                                                        decoration: BoxDecoration(
                                                                            shape: BoxShape
                                                                                .circle,
                                                                            color: index == selectedTableIndex
                                                                                ? Colors.white
                                                                                : default_color,
                                                                            border: Border.all(color: Colors.white)),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            arabicLanguage
                                                                                ? arabicNumber.convert(tables[index])
                                                                                : tables[index],
                                                                            style: TextStyle(
                                                                                color: index != selectedTableIndex ? Colors.white : default_color,
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      onTap:
                                                                          () {
                                                                        arabicLanguage
                                                                            ? arabicNumber.convert(tables[index])
                                                                            : tables[index];
                                                                        selectedTableIndex =
                                                                            index;

                                                                        if (mounted) {
                                                                          setState(
                                                                              () {
                                                                            selectedTable =
                                                                                tables[index];

                                                                            selectedTableIndex =
                                                                                index;
                                                                          });
                                                                        }
                                                                      },
                                                                    ),
                                                                  ]);
                                                            }),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      //appbar
                                                      Container(
                                                        color: default_color,
                                                        // decoration: BoxDecoration(
                                                        //     image: DecorationImage(
                                                        //         image: AssetImage("assets/awafi/coffeeappbar.jpg"),fit: BoxFit.cover
                                                        //     )
                                                        // ),
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.15,
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 15,
                                                                top: 15),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Container(
                                                                height: 70,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.12,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            6),
                                                                    color: Colors
                                                                        .blue,
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .grey)),
                                                                child: Center(
                                                                  child:
                                                                      DropdownButton(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    alignment:
                                                                        AlignmentDirectional
                                                                            .centerStart,
                                                                    underline:
                                                                        Column(),
                                                                    dropdownColor:
                                                                        Colors
                                                                            .black,
                                                                    iconEnabledColor:
                                                                        Colors
                                                                            .white,
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                    value:
                                                                        dropdownvalue,
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .expand_more,
                                                                    ),
                                                                    items: abcd.map(
                                                                        (String
                                                                            items) {
                                                                      return DropdownMenuItem(
                                                                        value:
                                                                            items,
                                                                        child:
                                                                            Text(
                                                                          items,
                                                                        ),
                                                                      );
                                                                    }).toList(),
                                                                    onChanged:
                                                                        (String?
                                                                            newValue) {
                                                                      dropdownvalue =
                                                                          newValue;
                                                                      print(
                                                                          dropdownvalue);
                                                                      dropdownvalue == "Drive-Thru" && (deliveryCharge.text.isEmpty || deliveryCharge.text == "0")
                                                                          ? delivery = DelCharge!.toStringAsFixed(
                                                                              2)
                                                                          : delivery =
                                                                              deliveryCharge.text;
                                                                      if (mounted) {
                                                                        setState(
                                                                            () {
                                                                          if (dropdownvalue ==
                                                                              "Drive-Thru") {
                                                                            deliveryCharge.text =
                                                                                DelCharge.toString();
                                                                          }
                                                                        });
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 15,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  FFButtonWidget(
                                                                onPressed: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              const Live_Orders_Widget()));
                                                                },
                                                                text: arabicLanguage
                                                                    ? "الطلبات عبر الإنترنت"
                                                                    : 'Online Order',
                                                                options:
                                                                    FFButtonOptions(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.12,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.1,
                                                                  color: Colors
                                                                      .red,
                                                                  textStyle: FlutterFlowTheme
                                                                      .subtitle2
                                                                      .override(
                                                                    fontFamily:
                                                                        'Overpass',
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                  elevation: 10,
                                                                  borderSide:
                                                                      const BorderSide(
                                                                    color: Colors
                                                                        .grey,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                      12,
                                                                ),
                                                                // icon: const Icon(Icons.back_hand_sharp),
                                                                // iconData: Icons.back_hand_sharp,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 15,
                                                            ),

                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  arabicLanguage
                                                                      ? branchNameArabic!
                                                                      : currentBranchName!,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          25),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                const Text(
                                                                  "LOGGED IN USER",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          10,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              width: 15,
                                                            ),
                                                            // const CircleAvatar(
                                                            //   backgroundImage: NetworkImage("https://scontent.fcok4-1.fna.fbcdn.net/v/t1.6435-9/41645109"
                                                            //       "_1747771551988756_2209695106821259264_n.jpg?_nc_cat=102&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=Ir5KrY_qwQcAX-4TTg1&_nc_ht=scontent.fcok4-1.fna&oh=6f210f4258122449225c7fc2ab0606dd&oe=6176D772"),
                                                            // ),
                                                            Expanded(
                                                                child: Center(
                                                                    child: Text(
                                                              arabicLanguage
                                                                  ? "${arabicNumber.convert(token)}  : رمز"
                                                                  : "Token : $token",
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 25,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ))),
                                                            const SizedBox(
                                                              width: 15,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top:
                                                                          10.0),
                                                              child: InkWell(
                                                                onTap:
                                                                    () async {
                                                                  await showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (alertDialogContext) {
                                                                      return AlertDialog(
                                                                        title: const Text(
                                                                            'Clear Tokens !'),
                                                                        content:
                                                                            const Text('Do  You want to clear Tokens?'),
                                                                        actions: [
                                                                          TextButton(
                                                                            onPressed: () =>
                                                                                Navigator.pop(alertDialogContext),
                                                                            child:
                                                                                const Text('Cancel'),
                                                                          ),
                                                                          TextButton(
                                                                            onPressed:
                                                                                () async {
                                                                              ref.read(homeControllerProvider).tokenClear(context);
                                                                            },
                                                                            child:
                                                                                Text('Confirm'),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.07,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .white,
                                                                          width:
                                                                              2)),
                                                                  child: Center(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              10.0,
                                                                          right:
                                                                              10),
                                                                      child:
                                                                          Text(
                                                                        arabicLanguage
                                                                            ? "الرمز مسح: ${arabicNumber.convert(token)}"
                                                                            : 'Token Clear $token',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.white),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 15,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),

                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.4,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.5),
                                                                    offset:
                                                                        const Offset(
                                                                      0.0,
                                                                      -1.0,
                                                                    ),
                                                                    blurRadius:
                                                                        20.0,
                                                                    spreadRadius:
                                                                        1.0,
                                                                  ), //BoxShadow
                                                                  //BoxShadow
                                                                ],
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color:
                                                                                Colors.grey.withOpacity(0.5),
                                                                            offset:
                                                                                const Offset(
                                                                              0.0,
                                                                              -1.0,
                                                                            ),
                                                                            blurRadius:
                                                                                20.0,
                                                                            spreadRadius:
                                                                                1.0,
                                                                          ), //BoxShadow
                                                                          //BoxShadow
                                                                        ],
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                MediaQuery.of(context).size.height * 0.07,
                                                                            color:
                                                                                Colors.grey.shade200,
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Expanded(
                                                                                  flex: 1,
                                                                                  child: Center(
                                                                                      child: Text(
                                                                                    arabicLanguage ? "عدد" : "NO:",
                                                                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                                                                  )),
                                                                                ),
                                                                                Expanded(
                                                                                  flex: 6,
                                                                                  child: Center(
                                                                                      child: Text(
                                                                                    arabicLanguage ? 'منتج' : "NAME",
                                                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                                                  )),
                                                                                ),
                                                                                Expanded(
                                                                                  flex: 3,
                                                                                  child: Center(
                                                                                      child: Text(
                                                                                    arabicLanguage ? 'سعر' : "PRICE",
                                                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                                                  )),
                                                                                ),
                                                                                Expanded(
                                                                                  flex: 2,
                                                                                  child: Center(
                                                                                      child: Text(
                                                                                    arabicLanguage ? "كمية" : "QTY",
                                                                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                                                                  )),
                                                                                ),
                                                                                const Expanded(
                                                                                  flex: 1,
                                                                                  child: Center(
                                                                                      child: Text(
                                                                                    "",
                                                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                                                  )),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),

                                                                          //Add Section
                                                                          Expanded(
                                                                            child:
                                                                                SingleChildScrollView(
                                                                              child: ref.watch(getTablesItemProvider).when(
                                                                                    data: (snapshot) {
                                                                                      items = [];
                                                                                      itemList = [];

                                                                                      totalAmount = 0;
                                                                                      if (snapshot.data()!['items'] != null) {
                                                                                        items = snapshot.data()!['items'];

                                                                                        previousItems = [];
                                                                                        for (dynamic item in snapshot.data()!['items']) {
                                                                                          previousItems.add(item);

                                                                                          itemList.add({
                                                                                            'arabicName': item['arabicName'],
                                                                                            'addOnArabic': item['addOnArabic'],
                                                                                            'variants': item['variants'],
                                                                                            'pdtname': item['pdtname'],
                                                                                            'price': item['price'],
                                                                                            'category': item['category'],
                                                                                            'qty': item['qty'],
                                                                                            'addOns': item['addOns'] ?? [],
                                                                                            'addOnPrice': item['addOnPrice'] ?? 0 + item['removePrice'] ?? 0 + item['addLessPrice'] ?? 0 + item['addMorePrice'] ?? 0,
                                                                                            'ingredients': item['ingredients'],
                                                                                            'addLess': item['addLess'] ?? [],
                                                                                            'addMore': item['addMore'] ?? [],
                                                                                            'remove': item['remove'] ?? [],
                                                                                            'removeArabic': item['removeArabic'] ?? [],
                                                                                            'addLessArabic': item['addLessArabic'] ?? [],
                                                                                            'addMoreArabic': item['addMoreArabic'] ?? [],
                                                                                            'addMorePrice': item['addMorePrice'] ?? 0,
                                                                                            'addLessPrice': item['addLessPrice'] ?? 0,
                                                                                            'removePrice': item['removePrice'] ?? 0,
                                                                                            "variantName": item['variantName'] ?? '',
                                                                                            "variantNameArabic": item['variantNameArabic'] ?? '',
                                                                                            'return': false,
                                                                                            'returnQty': 0
                                                                                          });
                                                                                          print(double.tryParse(item['price'].toString()));
                                                                                          print(double.tryParse(item['addOnPrice'].toString()));
                                                                                          print(double.tryParse(item['addLessPrice'].toString()));
                                                                                          print(double.tryParse(item['addMorePrice'].toString()));
                                                                                          print(double.tryParse(item['removePrice'].toString()));

                                                                                          totalAmount += (double.tryParse(item['price'].toString())! + double.tryParse((item['addOnPrice'] ?? 0).toString())! + double.tryParse((item['addLessPrice'] ?? 0).toString())! + double.tryParse((item['addMorePrice'] ?? 0).toString())! + double.tryParse((item['removePrice'] ?? 0).toString())!) * item['qty'];

                                                                                          double grandTotal = (totalAmount - (double.tryParse(discount) ?? 0) + (double.tryParse(delivery) ?? 0)) ?? 0;
                                                                                          // paidCash.text=grandTotal.toStringAsFixed(2)??0;
                                                                                        }
                                                                                      }
                                                                                      return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                                                        Container(
                                                                                          padding: const EdgeInsets.only(top: 10),
                                                                                          // child:  Container(),
                                                                                          child: keyboard
                                                                                              ? Container()
                                                                                              : BillWidget(
                                                                                                  items: snapshot.data()!['items'],
                                                                                                ),
                                                                                        ),
                                                                                        Container(
                                                                                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                                                                          color: Colors.blueGrey.shade100,
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              Column(
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  Text(
                                                                                                    arabicLanguage ? "الإجمالي                                  : " : "Total Amount",
                                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey.shade700),
                                                                                                  ),
                                                                                                  Text(
                                                                                                    arabicLanguage ? "تخفيض                                   :   " : "Discount",
                                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey.shade700),
                                                                                                  ),
                                                                                                  Text(
                                                                                                    arabicLanguage ? "رقم ضريبة                               : " : "Vat ",
                                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey.shade700),
                                                                                                  ),
                                                                                                  Text(
                                                                                                    arabicLanguage ? "توصيل                                    :  " : "Delivery ",
                                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey.shade700),
                                                                                                  ),
                                                                                                  const SizedBox(
                                                                                                    height: 10,
                                                                                                  ),
                                                                                                  Text(
                                                                                                    arabicLanguage ? "المجموع الإجمالي                  : " : "Grand Total",
                                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey.shade700),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                              Column(
                                                                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                                                                children: [
                                                                                                  Text(
                                                                                                    arabicLanguage ? "SR ${arabicNumber.convert((totalAmount * 100 / (100 + gst)).toStringAsFixed(2))}" : "SR ${(totalAmount * 100 / (100 + gst)).toStringAsFixed(2)}",
                                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey.shade700),
                                                                                                  ),
                                                                                                  Text(
                                                                                                    arabicLanguage ? (double.tryParse(discount) == null ? arabicNumber.convert(00) : "SR ${arabicNumber.convert(double.tryParse(discount)!.toStringAsFixed(2))}") : (double.tryParse(discount) == null ? "0.00" : "SR ${double.tryParse(discount)!.toStringAsFixed(2)}"),
                                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey.shade700),
                                                                                                  ),
                                                                                                  Text(
                                                                                                    arabicLanguage ? " SR ${arabicNumber.convert((totalAmount * gst / (100 + gst)).toStringAsFixed(2))}" : " SR ${(totalAmount * gst / (100 + gst)).toStringAsFixed(2)}",
                                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey.shade700),
                                                                                                  ),
                                                                                                  Text(
                                                                                                    arabicLanguage ? (double.tryParse(delivery) == null ? arabicNumber.convert(00) : "SR ${arabicNumber.convert(double.tryParse(delivery)!.toStringAsFixed(2))}") : (double.tryParse(delivery) == null ? "0.00" : "SR ${double.tryParse(delivery)!.toStringAsFixed(2)}"),
                                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey.shade700),
                                                                                                  ),
                                                                                                  const SizedBox(
                                                                                                    height: 10,
                                                                                                  ),
                                                                                                  Text(
                                                                                                    arabicLanguage ? "SR ${arabicNumber.convert((totalAmount - (double.tryParse(discount) ?? 0) + (double.tryParse(delivery) ?? 0)).toStringAsFixed(2))}" : "SR ${(totalAmount - (double.tryParse(discount) ?? 0) + (double.tryParse(delivery) ?? 0)).toStringAsFixed(2)}",
                                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey.shade700),
                                                                                                  ),
                                                                                                ],
                                                                                              )
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ]);
                                                                                    },
                                                                                    error: (error, stackTrace) {
                                                                                      print(error);
                                                                                      return Text(error.toString());
                                                                                    },
                                                                                    loading: () => const Loader(),
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  // const SizedBox(
                                                                  //   height: 20,
                                                                  // ),

                                                                  //DISCOUNT AND DELIVERY
                                                                  SizedBox(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.12,
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: Text(
                                                                                arabicLanguage ? "تخفيض" : "DISCOUNT  :",
                                                                                textAlign: TextAlign.start,
                                                                                style: const TextStyle(fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: Text(
                                                                                arabicLanguage ? "توصيل" : "DELIVERY  :",
                                                                                textAlign: TextAlign.start,
                                                                                style: const TextStyle(fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: Text(
                                                                                arabicLanguage ? 'مستخدم الائتمان  :  ' : "CREDIT USER  :-",
                                                                                textAlign: TextAlign.center,
                                                                                style: const TextStyle(fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: Container(
                                                                                height: MediaQuery.of(context).size.height * 0.07,
                                                                                child: TextFormField(
                                                                                  onEditingComplete: () {
                                                                                    FocusScope.of(context).unfocus();
                                                                                    if (discountController.text.contains("%")) {
                                                                                      double disc = double.tryParse(discountController.text.replaceAll("%", "").trim()) ?? 0;
                                                                                      discount = (totalAmount * disc / 100).toStringAsFixed(2);
                                                                                    } else {
                                                                                      discount = discountController.text;
                                                                                    }

                                                                                    setState(() {
                                                                                      keyboard = false;
                                                                                    });
                                                                                  },
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      // keyboard = true;
                                                                                    });
                                                                                  },
                                                                                  controller: discountController,
                                                                                  keyboardType: TextInputType.text,
                                                                                  decoration: InputDecoration(
                                                                                      // labelText: 'DISCOUNT',
                                                                                      hoverColor: default_color,
                                                                                      hintText: arabicLanguage ? "تخفيض" : 'Discount',
                                                                                      border: OutlineInputBorder(
                                                                                        borderRadius: BorderRadius.circular(5.0),
                                                                                      ),
                                                                                      focusedBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(color: Colors.pink.shade900, width: 1.0),
                                                                                      ),
                                                                                      contentPadding: EdgeInsets.all(5)),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 5,
                                                                            ),
                                                                            InkWell(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  keyboard = false;
                                                                                  FocusScope.of(context).unfocus();
                                                                                  if (discountController.text.contains("%")) {
                                                                                    double disc = double.tryParse(discountController.text.replaceAll("%", "").trim()) ?? 0;
                                                                                    discount = (totalAmount * disc / 100).toStringAsFixed(2);
                                                                                  } else {
                                                                                    discount = discountController.text;
                                                                                  }
                                                                                });
                                                                              },
                                                                              child: Container(
                                                                                // width: 100,
                                                                                // height: MediaQuery.of(context)
                                                                                //     .size
                                                                                //     .height *
                                                                                //     0.06,
                                                                                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10)),
                                                                                child: const Center(
                                                                                    child: Padding(
                                                                                  padding: EdgeInsets.all(8.0),
                                                                                  child: Icon(
                                                                                    Icons.check,
                                                                                    color: Colors.white,
                                                                                    size: 30,
                                                                                  ),
                                                                                )
                                                                                    // child: Text(
                                                                                    //  arabicLanguage? "يدخل":"ENTER",
                                                                                    //   style: const TextStyle(
                                                                                    //       color: Colors.white,
                                                                                    //       fontWeight:
                                                                                    //       FontWeight.bold,
                                                                                    //       fontSize: 16),
                                                                                    // ),
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                            Expanded(
                                                                              child: Container(
                                                                                height: MediaQuery.of(context).size.height * 0.07,
                                                                                child: TextFormField(
                                                                                  onEditingComplete: () {
                                                                                    FocusScope.of(context).unfocus();
                                                                                    delivery = deliveryCharge.text;
                                                                                    setState(() {
                                                                                      // keyboard = false;
                                                                                    });
                                                                                  },
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      // keyboard = true;
                                                                                    });
                                                                                  },
                                                                                  controller: deliveryCharge,
                                                                                  keyboardType: TextInputType.number,
                                                                                  decoration: InputDecoration(
                                                                                      // labelText: 'DELIVERY',
                                                                                      hoverColor: default_color,
                                                                                      hintText: arabicLanguage ? "رسوم التوصيل" : 'Delivery Charge',
                                                                                      border: OutlineInputBorder(
                                                                                        borderRadius: BorderRadius.circular(5.0),
                                                                                      ),
                                                                                      focusedBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(color: Colors.pink.shade900, width: 1.0),
                                                                                      ),
                                                                                      contentPadding: EdgeInsets.all(5)),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 5,
                                                                            ),
                                                                            InkWell(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  keyboard = false;
                                                                                  FocusScope.of(context).unfocus();
                                                                                  delivery = deliveryCharge.text;
                                                                                });
                                                                              },
                                                                              child: Container(
                                                                                // width: 100,
                                                                                // height: MediaQuery.of(context)
                                                                                //     .size
                                                                                //     .height *
                                                                                //     0.06,
                                                                                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10)),
                                                                                child: Center(
                                                                                    child: Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: Icon(
                                                                                    Icons.check,
                                                                                    color: Colors.white,
                                                                                    size: 30,
                                                                                  ),
                                                                                )
                                                                                    // child: Text(
                                                                                    //   arabicLanguage? "يدخل":"ENTER",
                                                                                    //   style: TextStyle(
                                                                                    //       color: Colors.white,
                                                                                    //       fontWeight:
                                                                                    //       FontWeight.bold,
                                                                                    //       fontSize: 16),
                                                                                    // ),
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                            Expanded(
                                                                              child: Container(
                                                                                height: MediaQuery.of(context).size.height * 0.07,
                                                                                child: TextFormField(
                                                                                  onChanged: (x) {
                                                                                    setState(() {
                                                                                      getCreditDetailes(x, ref);
                                                                                    });
                                                                                  },
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      // keyboard = true;
                                                                                    });
                                                                                  },
                                                                                  controller: mobileNo,
                                                                                  keyboardType: TextInputType.number,
                                                                                  decoration: InputDecoration(
                                                                                      hoverColor: default_color,
                                                                                      hintText: arabicLanguage ? 'رقمالهتف  :  ' : 'Mobile NO:',
                                                                                      border: OutlineInputBorder(
                                                                                        borderRadius: BorderRadius.circular(5.0),
                                                                                      ),
                                                                                      focusedBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(color: Colors.pink.shade900, width: 1.0),
                                                                                      ),
                                                                                      contentPadding: EdgeInsets.all(5)),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 5,
                                                                            ),
                                                                            InkWell(
                                                                              onTap: () async {
                                                                                if (items.isNotEmpty) {
                                                                                  // if(currentWaiter!=null){
                                                                                  setItemWidgets1(
                                                                                    items,
                                                                                  ).then((value) {
                                                                                    if (enable) {
                                                                                      keyboard = false;
                                                                                      FocusScope.of(context).unfocus();
                                                                                      taped = true;
                                                                                      if (taped) {
                                                                                        print("$creditMap---------------------------111111");
                                                                                        if (mobileNo.text != "" && creditMap != null && creditMap.isNotEmpty) {
                                                                                          print("$creditMap---------------------------22222");

                                                                                          String credituserId = creditMap.keys.toList()[0];
                                                                                          userMap = creditMap[credituserId];

                                                                                          return showDialog<void>(
                                                                                            context: context,
                                                                                            barrierDismissible: false, // user must tap button!
                                                                                            builder: (BuildContext context) {
                                                                                              return AlertDialog(
                                                                                                content: StatefulBuilder(
                                                                                                  builder: (BuildContext context, StateSetter setState) {
                                                                                                    setState;
                                                                                                    return SingleChildScrollView(
                                                                                                      child: ListBody(
                                                                                                        children: [
                                                                                                          Column(
                                                                                                            children: const [
                                                                                                              CircleAvatar(
                                                                                                                radius: 30,
                                                                                                                child: Icon(Icons.person),
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
                                                                                                          SizedBox(
                                                                                                            height: 10,
                                                                                                          ),
                                                                                                          Text('Name        :${userMap["name"]}'),
                                                                                                          Text('Mobile No   :${userMap["phone"]}'),
                                                                                                          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                                                                                                            TextButton(
                                                                                                              child: const Text(
                                                                                                                'Cancel',
                                                                                                                style: TextStyle(color: Colors.red),
                                                                                                              ),
                                                                                                              onPressed: () {
                                                                                                                creditMap = {};
                                                                                                                userMap = {};
                                                                                                                approve = false;
                                                                                                                Navigator.of(context).pop();
                                                                                                                paidCash.text = "0";
                                                                                                                paidBank.text = "0";
                                                                                                                mobileNo.text = "";
                                                                                                              },
                                                                                                            ),
                                                                                                            TextButton(
                                                                                                              child: const Text('Approve'),
                                                                                                              onPressed: () async {
                                                                                                                // onTap: () async {
                                                                                                                print("approve============================");
                                                                                                                print(approve);
                                                                                                                print(userMap["name"]);
                                                                                                                approve = true;

                                                                                                                paidCash.text = "0";
                                                                                                                paidBank.text = "0";
                                                                                                                // if(currentWaiter!=null) {
                                                                                                                String billDiscount = discount;
                                                                                                                if (!disable) {
                                                                                                                  // List itemsList=items;
                                                                                                                  for (var b in items) {
                                                                                                                    if (b["variantName"] != '') {
                                                                                                                      b['pdtname'] = "${b["pdtname"]} ${b["variantName"] ?? ''}";
                                                                                                                      b['arabicName'] = "${b["pdtname"]} ${b["variantNameArabic"] ?? ''}";
                                                                                                                    }
                                                                                                                  }
                                                                                                                  double netTotal = approve ? 0.00 : totalAmount - (double.tryParse(discount) ?? 0) + (double.tryParse(delivery) ?? 0);
                                                                                                                  print("netTotal=========================");
                                                                                                                  print(netTotal);
                                                                                                                  bankPaid = (amexPaid + madaPaid + visaPaid + masterPaid ?? 0);
                                                                                                                  disable = true;
                                                                                                                  try {
                                                                                                                    if (items.isNotEmpty) {
                                                                                                                      print("evide ethi mohneeeeeeeeeeeeeeeeeeeee");
                                                                                                                      DocumentSnapshot invoiceNoDoc = await ref.read(homeControllerProvider).getInvoices();

                                                                                                                      int invoiceNo = invoiceNoDoc.get('sales');
                                                                                                                      int token = invoiceNoDoc.get('token');
                                                                                                                      invoiceNo++;
                                                                                                                      token++;

                                                                                                                      List<String> ingredientIds = [];
                                                                                                                      for (var a in items) {
                                                                                                                        for (var b in a['ingredients'] ?? []) {
                                                                                                                          ingredientIds.add(b['ingredientId']);
                                                                                                                        }
                                                                                                                      }
                                                                                                                      blue
                                                                                                                          ? showDialog(
                                                                                                                              barrierDismissible: false,
                                                                                                                              context: context,
                                                                                                                              builder: (BuildContext context) {
                                                                                                                                items = items;
                                                                                                                                printCopy = items;
                                                                                                                                copyToken = token;
                                                                                                                                copyInvoice = invoiceNo;
                                                                                                                                copyCustomer = 'Walking Customer';
                                                                                                                                copyDate = DateTime.now();
                                                                                                                                copyDelivery = double.tryParse(discount) ?? 0;
                                                                                                                                copyDiscount = double.tryParse(discount) ?? 0.0;
                                                                                                                                return mytest(salesDate: DateTime.now(), items: items, token: token, delivery: double.tryParse(discount), customer: 'Walking Customer', discountPrice: double.tryParse(discount), invoiceNo: invoiceNo.toString(), selectedTable: selectedTable, cashPaid: double.tryParse(paidCash.text) ?? 0, bankPaid: double.tryParse(paidBank.text) ?? 0, balance: balance ?? 0);
                                                                                                                              })
                                                                                                                          : abc(invoiceNo, double.tryParse(discount)!, items, token, selectedTable, double.tryParse(delivery) ?? 0, double.tryParse(paidCash.text) ?? 0, double.tryParse(paidBank.text) ?? 0, balance ?? 0, netTotal ?? 0, dropdownvalue ?? 'Take Away', bytes, kotBytes, _getDevicelist());

                                                                                                                      await ref.read(homeControllerProvider).creditUserApprove(invoiceNo, token, paidCash.text, ingredientIds, amex.text, visa.text, mada.text, master.text, dropdownvalue ?? 'Take Away', context, approve);
                                                                                                                      setState(() {
                                                                                                                        mobileNo.text = '';
                                                                                                                        deliveryCharge.text = '0';

                                                                                                                        qty = 0;
                                                                                                                        enable = false;
                                                                                                                        approve = false;
                                                                                                                      });
                                                                                                                    }
                                                                                                                  } catch (e) {
                                                                                                                    disable = false;
                                                                                                                    showUploadMessage(context, e.toString());
                                                                                                                  }
                                                                                                                  setState(() {
                                                                                                                    approve = false;
                                                                                                                  });
                                                                                                                } else {
                                                                                                                  showUploadMessage(context, "Another Print Already In Queue");
                                                                                                                }
                                                                                                                // }

                                                                                                                setState(() {
                                                                                                                  approve = false;
                                                                                                                  creditMap = {};
                                                                                                                  userMap = {};
                                                                                                                  discount = '0.00';
                                                                                                                  delivery = '0.00';
                                                                                                                  disable = false;
                                                                                                                  paidCash.text = '';
                                                                                                                  paidBank.text = '';
                                                                                                                  totalAmount = 0;
                                                                                                                  balance = 0;
                                                                                                                  cashPaid = 0;
                                                                                                                  bankPaid = 0;
                                                                                                                  dropdownvalue = "Take Away";
                                                                                                                  currentWaiter = null;
                                                                                                                  Navigator.of(context).pop();
                                                                                                                });
                                                                                                              },
                                                                                                            ),
                                                                                                          ])
                                                                                                        ],
                                                                                                      ),
                                                                                                    );
                                                                                                  },
                                                                                                ),
                                                                                              );
                                                                                            },
                                                                                          );
                                                                                        } else {
                                                                                          showUploadMessage(context, "Please Enter Valid Mobile Number");
                                                                                        }
                                                                                      }
                                                                                      setState(() {});
                                                                                    }
                                                                                  });
                                                                                  // }
                                                                                  //   else{
                                                                                  // showUploadMessage(context, "Please Choose Waiter Name");
                                                                                  //  }
                                                                                } else {
                                                                                  showUploadMessage(context, "PLEASE CHOOSE ITEMS");
                                                                                }
                                                                              },
                                                                              child: Container(
                                                                                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10)),
                                                                                child: const Center(
                                                                                    child: Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: Icon(
                                                                                    Icons.check,
                                                                                    color: Colors.white,
                                                                                    size: 30,
                                                                                  ),
                                                                                )
                                                                                    // child: Text(
                                                                                    //   "ENTER",
                                                                                    //   style: TextStyle(
                                                                                    //       color: Colors.white,
                                                                                    //       fontWeight:
                                                                                    //       FontWeight.bold,
                                                                                    //       fontSize: 16),
                                                                                    // ),
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.5,
                                                              decoration:
                                                                  const BoxDecoration(),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .stretch,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color:
                                                                                Colors.grey.withOpacity(0.5),
                                                                            offset:
                                                                                const Offset(
                                                                              0.0,
                                                                              -1.0,
                                                                            ),
                                                                            blurRadius:
                                                                                20.0,
                                                                            spreadRadius:
                                                                                1.0,
                                                                          ), //BoxShadow
                                                                          //BoxShadow
                                                                        ],
                                                                      ),
                                                                      child: products
                                                                          ?  ItemsPage(arabicLanguage: arabicLanguage,)
                                                                          : Container(),
                                                                      // child: const ItemsPage(),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  SizedBox(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.15,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              MediaQuery.of(context).size.height * 0.15,
                                                                          width:
                                                                              MediaQuery.of(context).size.width * 0.11,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                            boxShadow: [
                                                                              BoxShadow(
                                                                                color: Colors.grey.withOpacity(0.5),
                                                                                offset: const Offset(
                                                                                  0.0,
                                                                                  -1.0,
                                                                                ),
                                                                                blurRadius: 20.0,
                                                                                spreadRadius: 1.0,
                                                                              ), //BoxShadow
                                                                              //BoxShadow
                                                                            ],
                                                                          ),
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            children: [
                                                                              Container(
                                                                                width: MediaQuery.of(context).size.width * 0.09,
                                                                                height: MediaQuery.of(context).size.height * 0.062,
                                                                                child: ElevatedButton(
                                                                                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                                                                                    onPressed: () async {
                                                                                      // print('paidCash.text');
                                                                                      // print(paidCash.text);
                                                                                      // print(paidBank.text);

                                                                                      // if(paidBank.text!=''  || paidCash.text!=''){
                                                                                      if (blue) {
                                                                                        // print('paidCash.text');
                                                                                        // print(paidCash.text);

                                                                                        await showDialog(
                                                                                            barrierDismissible: false,
                                                                                            context: context,
                                                                                            builder: (BuildContext context) {
                                                                                              return mytest(items: printCopy, token: copyToken, salesDate: copyDate, delivery: copyDelivery, customer: 'Walking Customer', discountPrice: copyDiscount, invoiceNo: copyInvoice.toString(), cashPaid: double.tryParse(paidCash.text) ?? 0, bankPaid: double.tryParse(paidBank.text) ?? 0, balance: balance ?? 0);
                                                                                            });
                                                                                        setState(() {
                                                                                          paidCash.text = '0';
                                                                                          paidCash.text = '0';
                                                                                          enable = false;
                                                                                          approve = false;
                                                                                          mobileNo.text = '';
                                                                                        });
                                                                                      } else {
                                                                                        flutterUsbPrinter.write(Uint8List.fromList(bytes));
                                                                                        bytes = [];
                                                                                        if (lastCut == true) {
                                                                                          flutterUsbPrinter.write(Uint8List.fromList(kotBytes));
                                                                                        }
                                                                                      }
                                                                                    },
                                                                                    child: Text(
                                                                                      arabicLanguage ? "ينسخ" : 'COPY',
                                                                                      style: TextStyle(color: Colors.white),
                                                                                    )),
                                                                              ),
                                                                              Container(
                                                                                width: MediaQuery.of(context).size.width * 0.09,
                                                                                height: MediaQuery.of(context).size.height * 0.062,
                                                                                child: ElevatedButton(
                                                                                    style: ButtonStyle(
                                                                                        backgroundColor: MaterialStatePropertyAll(
                                                                                      Colors.blue,
                                                                                    )),
                                                                                    onPressed: () async {
                                                                                      print("tapped");
                                                                                      print(approve);
                                                                                      if (paidCash.text != '' || amex.text != '' || visa.text != '' || master.text != '' || mada.text != '') {
                                                                                        print("tapped2");
                                                                                        print(approve);
                                                                                        // if(currentWaiter!=null){
                                                                                        if (!disable) {
                                                                                          bankPaid = (amexPaid + madaPaid + visaPaid + masterPaid ?? 0);
                                                                                          print("bankPaid============================");

                                                                                          // List itemsList=items;
                                                                                          for (var b in items) {
                                                                                            if (b["variantName"] != '') {
                                                                                              b['pdtname'] = "${b["pdtname"]} ${b["variantName"] ?? ''}";
                                                                                              b['arabicName'] = "${b["pdtname"]} ${b["variantNameArabic"] ?? ''}";
                                                                                            }
                                                                                          }
                                                                                          String billDiscount = discount;
                                                                                          disable = true;
                                                                                          print("tapped3");
                                                                                          print(approve);

                                                                                          print(approve);
                                                                                          await ref.read(homeControllerProvider).saveSales(paidCash.text, amex.text, visa.text, mada.text, master.text, context);
                                                                                          print("tapped6");
                                                                                          print(approve);
                                                                                          paidCash.text = '0';
                                                                                          paidCash.text = '0';
                                                                                          ;
                                                                                          setState(() {
                                                                                            creditMap = {};
                                                                                            userMap = {};
                                                                                            discountController.text = '0';
                                                                                            discount = '0.00';
                                                                                            deliveryCharge.text = '0';
                                                                                            delivery = '0.00';
                                                                                            qty = 0;
                                                                                            paidCash.text = '0';
                                                                                            paidBank.text = '0';
                                                                                            totalAmount = 0;
                                                                                            balance = 0;
                                                                                            cashPaid = 0;
                                                                                            bankPaid = 0;
                                                                                            disable = false;
                                                                                            enable = false;
                                                                                            approve = false;
                                                                                            mobileNo.text = '';
                                                                                            mada.text = "0.0";
                                                                                            master.text = "0.0";
                                                                                            visa.text = "0.0";
                                                                                            amex.text = "0.0";
                                                                                            madaPaid = 0;
                                                                                            visaPaid = 0;
                                                                                            masterPaid = 0;
                                                                                            amexPaid = 0;
                                                                                            print("tapped7");
                                                                                            print(approve);
                                                                                            dropdownvalue = "Take Away";
                                                                                          });
                                                                                          print("tapped8");
                                                                                          print(approve);
                                                                                        }
                                                                                      } else {
                                                                                        showUploadMessage(context, 'PLEASE SELECT PAYMET METHOD');
                                                                                        print("tapped9");
                                                                                        print(approve);
                                                                                      }
                                                                                    },
                                                                                    child: Text(arabicLanguage ? 'يحفظ' : "SAVE", style: TextStyle(color: Colors.white))),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),

                                                                        //Cash and bank
                                                                        Expanded(
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                MediaQuery.of(context).size.height * 0.15,
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.25,
                                                                            child: approve == true || dinnerCertificate == true
                                                                                ? Center(
                                                                                    child: Text(
                                                                                      approve ? "CREDIT SALE" : "DINNER CERTIFICATE   SALE",
                                                                                      style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold, fontSize: fontSize + 10),
                                                                                    ),
                                                                                  )
                                                                                : Column(
                                                                                    children: [
                                                                                      Expanded(
                                                                                        child: Container(
                                                                                          child: Row(
                                                                                            children: [
                                                                                              SizedBox(
                                                                                                width: 10,
                                                                                              ),
                                                                                              Expanded(
                                                                                                child: SizedBox(
                                                                                                  child: SingleChildScrollView(
                                                                                                    child: Column(
                                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                      children: [
                                                                                                        Text(
                                                                                                          arabicLanguage ? ' نقدأ:' : "CASH :",
                                                                                                          textAlign: TextAlign.start,
                                                                                                          style: TextStyle(fontWeight: FontWeight.bold),
                                                                                                        ),
                                                                                                        Container(
                                                                                                          height: MediaQuery.of(context).size.height * 0.065,
                                                                                                          // 45,
                                                                                                          child: TextFormField(
                                                                                                            onTap: () {
                                                                                                              setItemWidgets(
                                                                                                                items,
                                                                                                              );
                                                                                                              double grandTotal = (totalAmount - (double.tryParse(discount) ?? 0) + (double.tryParse(delivery) ?? 0));
                                                                                                              // print(grandTotal);

                                                                                                              cashPaid = grandTotal - masterPaid - amexPaid - visaPaid - madaPaid;
                                                                                                              if (cashPaid < 0) {
                                                                                                                cashPaid = 0;
                                                                                                                balance = grandTotal - cashPaid - madaPaid - masterPaid - visaPaid - amexPaid;
                                                                                                              }

                                                                                                              paidCash.text = cashPaid.toStringAsFixed(1);

                                                                                                              setState(() {
                                                                                                                // keyboard = true;
                                                                                                              });
                                                                                                            },
                                                                                                            onChanged: (value) {
                                                                                                              double grandTotal = (totalAmount - (double.tryParse(discount) ?? 0) + (double.tryParse(delivery) ?? 0));

                                                                                                              cashPaid = double.tryParse(value) ?? 0;
                                                                                                              bankPaid = grandTotal - cashPaid ?? 0;
                                                                                                              if (bankPaid < 0) {
                                                                                                                bankPaid = 0;
                                                                                                              }

                                                                                                              paidBank.text = bankPaid.toStringAsFixed(1);
                                                                                                              balance = grandTotal - cashPaid - madaPaid - masterPaid - visaPaid - amexPaid;
                                                                                                              setState(() {
                                                                                                                // keyboard = true;
                                                                                                              });
                                                                                                            },
                                                                                                            controller: paidCash,
                                                                                                            keyboardType: TextInputType.number,
                                                                                                            decoration: InputDecoration(
                                                                                                                // labelText: 'DISCOUNT',
                                                                                                                hoverColor: default_color,
                                                                                                                hintText: arabicLanguage ? 'نقدأ' : "Cash ",
                                                                                                                border: OutlineInputBorder(
                                                                                                                  borderRadius: BorderRadius.circular(5.0),
                                                                                                                ),
                                                                                                                focusedBorder: OutlineInputBorder(
                                                                                                                  borderSide: BorderSide(color: Colors.pink.shade900, width: 1.0),
                                                                                                                ),
                                                                                                                prefixIcon: const Padding(
                                                                                                                  padding: EdgeInsets.all(0.0),
                                                                                                                  child: Icon(
                                                                                                                    Icons.money_outlined,
                                                                                                                    color: Colors.grey,
                                                                                                                  ), // icon is 48px widget.
                                                                                                                ),
                                                                                                                contentPadding: EdgeInsets.all(5)),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              const SizedBox(
                                                                                                width: 10,
                                                                                              ),
                                                                                              Expanded(
                                                                                                child: SingleChildScrollView(
                                                                                                  child: Column(
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Text(
                                                                                                        arabicLanguage ? 'مصرف: ' : "BANK :",
                                                                                                        textAlign: TextAlign.start,
                                                                                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                                                                                      ),
                                                                                                      InkWell(
                                                                                                        onTap: () {
                                                                                                          showDialog<void>(
                                                                                                            context: context,
                                                                                                            builder: (BuildContext context) {
                                                                                                              return AlertDialog(
                                                                                                                title: Center(child: Text('Select option')),
                                                                                                                content: StatefulBuilder(
                                                                                                                  builder: (BuildContext context, StateSetter setState) {
                                                                                                                    return Container(
                                                                                                                      height: MediaQuery.of(context).size.height * 0.5,
                                                                                                                      width: MediaQuery.of(context).size.width * 0.4,
                                                                                                                      color: Colors.white,
                                                                                                                      child: ListView(
                                                                                                                        shrinkWrap: true,
                                                                                                                        children: [
                                                                                                                          Padding(
                                                                                                                            padding: const EdgeInsets.all(8.0),
                                                                                                                            child: Container(
                                                                                                                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                                                                                                                                Container(
                                                                                                                                    height: MediaQuery.of(context).size.height * 0.05,
                                                                                                                                    width: MediaQuery.of(context).size.width * 0.07,
                                                                                                                                    child: Center(
                                                                                                                                        child: Row(
                                                                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                                                                      children: [
                                                                                                                                        // Text('AMEX'),
                                                                                                                                        Container(
                                                                                                                                          // height: 180,
                                                                                                                                          height: MediaQuery.of(context).size.height * 0.180,
                                                                                                                                          width: MediaQuery.of(context).size.width * 0.070,
                                                                                                                                          // width: 80,
                                                                                                                                          decoration: BoxDecoration(
                                                                                                                                            image: DecorationImage(image: AssetImage("assets/american express.png"), fit: BoxFit.cover),
                                                                                                                                          ),
                                                                                                                                        )
                                                                                                                                      ],
                                                                                                                                    ))),
                                                                                                                                Container(
                                                                                                                                  // height: 50,
                                                                                                                                  // width:200,
                                                                                                                                  height: MediaQuery.of(context).size.height * 0.070,
                                                                                                                                  width: MediaQuery.of(context).size.width * 0.160,
                                                                                                                                  child: Center(
                                                                                                                                    child: TextFormField(
                                                                                                                                      onTap: () {
                                                                                                                                        setItemWidgets(items);
                                                                                                                                        double grandTotal = (totalAmount - (double.tryParse(discount) ?? 0) + (double.tryParse(delivery) ?? 0));

                                                                                                                                        amexPaid = grandTotal - cashPaid - madaPaid - visaPaid - masterPaid ?? 0;
                                                                                                                                        if (amexPaid < 0) {
                                                                                                                                          amexPaid = 0;
                                                                                                                                        }
                                                                                                                                        amex.text = amexPaid.toStringAsFixed(1);

                                                                                                                                        balance = grandTotal - cashPaid - amexPaid - masterPaid - visaPaid - madaPaid;
                                                                                                                                        setState(() {});
                                                                                                                                      },
                                                                                                                                      onChanged: (value) {
                                                                                                                                        // print(value);
                                                                                                                                        amexPaid = double.tryParse(value) ?? 0;
                                                                                                                                        double grandTotal = (totalAmount - (double.tryParse(discount) ?? 0) + (double.tryParse(delivery) ?? 0));
                                                                                                                                        bankPaid = grandTotal - cashPaid ?? 0;

                                                                                                                                        cashPaid = grandTotal - madaPaid - masterPaid - visaPaid - amexPaid;
                                                                                                                                        if (cashPaid < 0) {
                                                                                                                                          cashPaid = 0;
                                                                                                                                        }
                                                                                                                                        paidCash.text = cashPaid.toStringAsFixed(1);
                                                                                                                                        // print(bankPaid);
                                                                                                                                        balance = grandTotal - cashPaid - madaPaid - masterPaid - visaPaid - amexPaid;
                                                                                                                                        setState(() {
                                                                                                                                          // keyboard = true;
                                                                                                                                        });
                                                                                                                                      },
                                                                                                                                      controller: amex,
                                                                                                                                      keyboardType: TextInputType.number,
                                                                                                                                      decoration: InputDecoration(
                                                                                                                                          // labelText: 'DISCOUNT',
                                                                                                                                          hoverColor: default_color,
                                                                                                                                          hintText: "Amount",
                                                                                                                                          border: OutlineInputBorder(
                                                                                                                                            borderRadius: BorderRadius.circular(5.0),
                                                                                                                                          ),
                                                                                                                                          focusedBorder: OutlineInputBorder(
                                                                                                                                            borderSide: BorderSide(color: Colors.pink.shade900, width: 1.0),
                                                                                                                                          ),
                                                                                                                                          prefixIcon: const Padding(
                                                                                                                                            padding: EdgeInsets.all(0.0),
                                                                                                                                            child: Icon(
                                                                                                                                              Icons.money_outlined,
                                                                                                                                              color: Colors.grey,
                                                                                                                                            ), // icon is 48px widget.
                                                                                                                                          ),
                                                                                                                                          contentPadding: EdgeInsets.all(5)),
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                ),
                                                                                                                              ]),
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                          Padding(
                                                                                                                            padding: const EdgeInsets.all(8.0),
                                                                                                                            child: Container(
                                                                                                                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                                                                                                                                Container(
                                                                                                                                    height: MediaQuery.of(context).size.height * 0.05,
                                                                                                                                    width: MediaQuery.of(context).size.width * 0.07,
                                                                                                                                    child: Center(
                                                                                                                                        child: Row(
                                                                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                                                                      children: [
                                                                                                                                        // Text('MADA'),
                                                                                                                                        Container(
                                                                                                                                          height: MediaQuery.of(context).size.height * 0.180,
                                                                                                                                          width: MediaQuery.of(context).size.width * 0.070,
                                                                                                                                          decoration: BoxDecoration(
                                                                                                                                            image: DecorationImage(image: AssetImage("assets/mada.png"), fit: BoxFit.contain),
                                                                                                                                          ),
                                                                                                                                        )
                                                                                                                                      ],
                                                                                                                                    ))),
                                                                                                                                Container(
                                                                                                                                  height: MediaQuery.of(context).size.height * 0.070,
                                                                                                                                  width: MediaQuery.of(context).size.width * 0.160,
                                                                                                                                  child: Center(
                                                                                                                                    child: TextFormField(
                                                                                                                                      onTap: () {
                                                                                                                                        setItemWidgets(items);
                                                                                                                                        double grandTotal = (totalAmount - (double.tryParse(discount) ?? 0) + (double.tryParse(delivery) ?? 0));
                                                                                                                                        // print(grandTotal);

                                                                                                                                        madaPaid = grandTotal - cashPaid - amexPaid - visaPaid - masterPaid ?? 0;
                                                                                                                                        if (madaPaid < 0) {
                                                                                                                                          madaPaid = 0;
                                                                                                                                        }
                                                                                                                                        mada.text = madaPaid.toStringAsFixed(1);

                                                                                                                                        balance = grandTotal - cashPaid - madaPaid - masterPaid - visaPaid - amexPaid;
                                                                                                                                        setState(() {
                                                                                                                                          // keyboard = true;
                                                                                                                                        });
                                                                                                                                      },
                                                                                                                                      onChanged: (value) {
                                                                                                                                        // print(value);
                                                                                                                                        madaPaid = double.tryParse(value) ?? 0;
                                                                                                                                        double grandTotal = (totalAmount - (double.tryParse(discount) ?? 0) + (double.tryParse(delivery) ?? 0));
                                                                                                                                        bankPaid = grandTotal - cashPaid ?? 0;

                                                                                                                                        cashPaid = grandTotal - madaPaid - masterPaid - visaPaid - amexPaid;
                                                                                                                                        if (cashPaid < 0) {
                                                                                                                                          cashPaid = 0;
                                                                                                                                        }
                                                                                                                                        paidCash.text = cashPaid.toStringAsFixed(1);
                                                                                                                                        // print(bankPaid);
                                                                                                                                        balance = grandTotal - cashPaid - madaPaid - masterPaid - visaPaid - amexPaid;
                                                                                                                                        setState(() {});
                                                                                                                                      },
                                                                                                                                      controller: mada,
                                                                                                                                      keyboardType: TextInputType.number,
                                                                                                                                      decoration: InputDecoration(
                                                                                                                                          // labelText: 'DISCOUNT',
                                                                                                                                          hoverColor: default_color,
                                                                                                                                          hintText: "Amount",
                                                                                                                                          border: OutlineInputBorder(
                                                                                                                                            borderRadius: BorderRadius.circular(5.0),
                                                                                                                                          ),
                                                                                                                                          focusedBorder: OutlineInputBorder(
                                                                                                                                            borderSide: BorderSide(color: Colors.pink.shade900, width: 1.0),
                                                                                                                                          ),
                                                                                                                                          prefixIcon: const Padding(
                                                                                                                                            padding: EdgeInsets.all(0.0),
                                                                                                                                            child: Icon(
                                                                                                                                              Icons.money_outlined,
                                                                                                                                              color: Colors.grey,
                                                                                                                                            ), // icon is 48px widget.
                                                                                                                                          ),
                                                                                                                                          contentPadding: EdgeInsets.all(5)),
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                ),
                                                                                                                              ]),
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                          Padding(
                                                                                                                            padding: const EdgeInsets.all(8.0),
                                                                                                                            child: Container(
                                                                                                                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                                                                                                                                Container(
                                                                                                                                    height: MediaQuery.of(context).size.height * 0.05,
                                                                                                                                    width: MediaQuery.of(context).size.width * 0.07,
                                                                                                                                    child: Center(
                                                                                                                                        child: Row(
                                                                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                                                                      children: [
                                                                                                                                        // Text('MASTER'),
                                                                                                                                        Container(
                                                                                                                                          height: MediaQuery.of(context).size.height * 0.180,
                                                                                                                                          width: MediaQuery.of(context).size.width * 0.070,
                                                                                                                                          decoration: BoxDecoration(
                                                                                                                                            image: DecorationImage(image: AssetImage("assets/MasterCard.png"), fit: BoxFit.contain),
                                                                                                                                          ),
                                                                                                                                        )
                                                                                                                                      ],
                                                                                                                                    ))),
                                                                                                                                Container(
                                                                                                                                  height: MediaQuery.of(context).size.height * 0.070,
                                                                                                                                  width: MediaQuery.of(context).size.width * 0.160,
                                                                                                                                  child: Center(
                                                                                                                                    child: TextFormField(
                                                                                                                                      onTap: () {
                                                                                                                                        setItemWidgets(items);
                                                                                                                                        double grandTotal = (totalAmount - (double.tryParse(discount) ?? 0) + (double.tryParse(delivery) ?? 0));
                                                                                                                                        // print(grandTotal);

                                                                                                                                        masterPaid = grandTotal - cashPaid - amexPaid - visaPaid - madaPaid ?? 0;
                                                                                                                                        if (masterPaid < 0) {
                                                                                                                                          masterPaid = 0;
                                                                                                                                        }
                                                                                                                                        master.text = masterPaid.toStringAsFixed(1);

                                                                                                                                        balance = grandTotal - cashPaid - madaPaid - masterPaid - visaPaid - amexPaid;
                                                                                                                                        setState(() {
                                                                                                                                          // keyboard = true;
                                                                                                                                        });
                                                                                                                                      },
                                                                                                                                      onChanged: (value) {
                                                                                                                                        // print(value);
                                                                                                                                        masterPaid = double.tryParse(value) ?? 0;
                                                                                                                                        double grandTotal = (totalAmount - (double.tryParse(discount) ?? 0) + (double.tryParse(delivery) ?? 0));
                                                                                                                                        bankPaid = grandTotal - cashPaid ?? 0;

                                                                                                                                        cashPaid = grandTotal - madaPaid - masterPaid - visaPaid - amexPaid;
                                                                                                                                        if (cashPaid < 0) {
                                                                                                                                          cashPaid = 0;
                                                                                                                                        }
                                                                                                                                        paidCash.text = cashPaid.toStringAsFixed(1);
                                                                                                                                        // print(bankPaid);
                                                                                                                                        balance = grandTotal - cashPaid - madaPaid - masterPaid - visaPaid - amexPaid;
                                                                                                                                        setState(() {});
                                                                                                                                      },
                                                                                                                                      controller: master,
                                                                                                                                      keyboardType: TextInputType.number,
                                                                                                                                      decoration: InputDecoration(
                                                                                                                                          // labelText: 'DISCOUNT',
                                                                                                                                          hoverColor: default_color,
                                                                                                                                          hintText: 'Amount',
                                                                                                                                          border: OutlineInputBorder(
                                                                                                                                            borderRadius: BorderRadius.circular(5.0),
                                                                                                                                          ),
                                                                                                                                          focusedBorder: OutlineInputBorder(
                                                                                                                                            borderSide: BorderSide(color: Colors.pink.shade900, width: 1.0),
                                                                                                                                          ),
                                                                                                                                          prefixIcon: const Padding(
                                                                                                                                            padding: EdgeInsets.all(0.0),
                                                                                                                                            child: Icon(
                                                                                                                                              Icons.money_outlined,
                                                                                                                                              color: Colors.grey,
                                                                                                                                            ), // icon is 48px widget.
                                                                                                                                          ),
                                                                                                                                          contentPadding: EdgeInsets.all(5)),
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                ),
                                                                                                                              ]),
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                          Padding(
                                                                                                                            padding: const EdgeInsets.all(8.0),
                                                                                                                            child: Container(
                                                                                                                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                                                                                                                                Container(
                                                                                                                                    height: MediaQuery.of(context).size.height * 0.05,
                                                                                                                                    width: MediaQuery.of(context).size.width * 0.07,
                                                                                                                                    child: Center(
                                                                                                                                        child: Row(
                                                                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                                                                      children: [
                                                                                                                                        // Text('VISA'),
                                                                                                                                        Container(
                                                                                                                                          height: MediaQuery.of(context).size.height * 0.180,
                                                                                                                                          width: MediaQuery.of(context).size.width * 0.070,
                                                                                                                                          decoration: BoxDecoration(
                                                                                                                                            image: DecorationImage(image: AssetImage("assets/visa.png"), fit: BoxFit.contain),
                                                                                                                                          ),
                                                                                                                                        )
                                                                                                                                      ],
                                                                                                                                    ))),
                                                                                                                                Container(
                                                                                                                                  height: MediaQuery.of(context).size.height * 0.070,
                                                                                                                                  width: MediaQuery.of(context).size.width * 0.160,
                                                                                                                                  child: Center(
                                                                                                                                    child: TextFormField(
                                                                                                                                      onTap: () {
                                                                                                                                        setItemWidgets(items);
                                                                                                                                        double grandTotal = (totalAmount - (double.tryParse(discount) ?? 0) + (double.tryParse(delivery) ?? 0));
                                                                                                                                        // print(grandTotal);

                                                                                                                                        visaPaid = grandTotal - cashPaid - amexPaid - masterPaid - madaPaid ?? 0;
                                                                                                                                        if (visaPaid < 0) {
                                                                                                                                          visaPaid = 0;
                                                                                                                                        }
                                                                                                                                        visa.text = visaPaid.toStringAsFixed(1);

                                                                                                                                        balance = grandTotal - cashPaid - madaPaid - visaPaid - masterPaid - amexPaid;
                                                                                                                                        setState(() {
                                                                                                                                          // keyboard = true;
                                                                                                                                        });
                                                                                                                                      },
                                                                                                                                      onChanged: (value) {
                                                                                                                                        // print(value);
                                                                                                                                        visaPaid = double.tryParse(value) ?? 0;
                                                                                                                                        double grandTotal = (totalAmount - (double.tryParse(discount) ?? 0) + (double.tryParse(delivery) ?? 0));
                                                                                                                                        bankPaid = grandTotal - cashPaid ?? 0;

                                                                                                                                        cashPaid = grandTotal - madaPaid - masterPaid - visaPaid - amexPaid;
                                                                                                                                        if (visaPaid < 0) {
                                                                                                                                          visaPaid = 0;
                                                                                                                                        }
                                                                                                                                        paidCash.text = cashPaid.toStringAsFixed(1);
                                                                                                                                        // print(bankPaid);
                                                                                                                                        balance = grandTotal - cashPaid - madaPaid - masterPaid - visaPaid - amexPaid;
                                                                                                                                        setState(() {});
                                                                                                                                      },
                                                                                                                                      controller: visa,
                                                                                                                                      keyboardType: TextInputType.number,
                                                                                                                                      decoration: InputDecoration(
                                                                                                                                          // labelText: 'DISCOUNT',
                                                                                                                                          hoverColor: default_color,
                                                                                                                                          hintText: 'Amount ',
                                                                                                                                          border: OutlineInputBorder(
                                                                                                                                            borderRadius: BorderRadius.circular(5.0),
                                                                                                                                          ),
                                                                                                                                          focusedBorder: OutlineInputBorder(
                                                                                                                                            borderSide: BorderSide(color: Colors.pink.shade900, width: 1.0),
                                                                                                                                          ),
                                                                                                                                          prefixIcon: const Padding(
                                                                                                                                            padding: EdgeInsets.all(0.0),
                                                                                                                                            child: Icon(
                                                                                                                                              Icons.money_outlined,
                                                                                                                                              color: Colors.grey,
                                                                                                                                            ), // icon is 48px widget.
                                                                                                                                          ),
                                                                                                                                          contentPadding: EdgeInsets.all(5)),
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                ),
                                                                                                                              ]),
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                          SizedBox(
                                                                                                                            height: 20,
                                                                                                                          ),
                                                                                                                          Row(
                                                                                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                                                            children: [
                                                                                                                              ElevatedButton(
                                                                                                                                  onPressed: () {
                                                                                                                                    Navigator.pop(context);
                                                                                                                                    mada.text = "0.0";
                                                                                                                                    master.text = "0.0";
                                                                                                                                    visa.text = "0.0";
                                                                                                                                    amex.text = "0.0";
                                                                                                                                    madaPaid = 0;
                                                                                                                                    visaPaid = 0;
                                                                                                                                    masterPaid = 0;
                                                                                                                                    amexPaid = 0;
                                                                                                                                    balance = 0;
                                                                                                                                  },
                                                                                                                                  child: Text("CANCEL")),
                                                                                                                              ElevatedButton(
                                                                                                                                  onPressed: () {
                                                                                                                                    Navigator.pop(context);
                                                                                                                                  },
                                                                                                                                  child: Text("OK")),
                                                                                                                            ],
                                                                                                                          )
                                                                                                                        ],
                                                                                                                      ),
                                                                                                                    );
                                                                                                                  },
                                                                                                                ),
                                                                                                              );
                                                                                                            },
                                                                                                          );
                                                                                                        },
                                                                                                        child: Container(
                                                                                                          height: MediaQuery.of(context).size.height * 0.065,
                                                                                                          // 45,
                                                                                                          decoration: BoxDecoration(
                                                                                                            borderRadius: BorderRadius.circular(6),
                                                                                                            color: Colors.blue,
                                                                                                          ),
                                                                                                          child: const Center(
                                                                                                              child: Text(
                                                                                                            "OPTIONS",
                                                                                                            style: TextStyle(color: Colors.white),
                                                                                                          )),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              const SizedBox(
                                                                                                width: 10,
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        height: MediaQuery.of(context).size.height * 0.05,
                                                                                        child: Center(
                                                                                            child: Text(
                                                                                          arabicLanguage ? '  المتبقي:${arabicNumber.convert(balance.toString())}' : 'Balance :${balance.toStringAsFixed(2)} ',
                                                                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                                                                                        )),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                          ),
                                                                        ),
                                                                        InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            setState(() {
                                                                              discountController.text = '0';
                                                                              discount = '0';
                                                                              deliveryCharge.text = '0';
                                                                              paidBank.text = '0';
                                                                              paidCash.text = '0';
                                                                              balance = 0;
                                                                              delivery = '0';
                                                                              qty = 0;
                                                                              totalAmount = 0;
                                                                              balance = 0;
                                                                              cashPaid = 0;
                                                                              bankPaid = 0;
                                                                              enable = false;
                                                                              approve = false;
                                                                              mobileNo.text = '';
                                                                              dinnerCertificate = false;
                                                                              mada.text = "0.0";
                                                                              master.text = "0.0";
                                                                              visa.text = "0.0";
                                                                              amex.text = "0.0";
                                                                              madaPaid = 0;
                                                                              visaPaid = 0;
                                                                              masterPaid = 0;
                                                                              amexPaid = 0;
                                                                              balance = 0;
                                                                              currentWaiter = null;
                                                                            });
                                                                            ref.read(homeControllerProvider).cancelOrder();
                                                                            setState(() {});
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                MediaQuery.of(context).size.height * 0.15,
                                                                            // width: 120,
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.08,
                                                                            decoration:
                                                                                const BoxDecoration(color: Colors.red),
                                                                            child:
                                                                                Column(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.delete,
                                                                                  size: 35,
                                                                                  color: Colors.white,
                                                                                ),
                                                                                Text(
                                                                                  arabicLanguage ? "يلغي" : "CANCEL",
                                                                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        enable
                                                                            ? InkWell(
                                                                                onLongPress: () {
                                                                                  disable = false;
                                                                                  showUploadMessage(context, "print queue cleared successfully");
                                                                                },
                                                                                onTap: () async {
                                                                                  log("start");

                                                                                  if (paidCash.text != '' || amex.text != '' || visa.text != '' || master.text != '' || mada.text != '') {
                                                                                    for (var b in items) {
                                                                                      if (b["variantName"] != '') {
                                                                                        b['pdtname'] = "${b["pdtname"]} ${b["variantName"] ?? ''}";
                                                                                        b['arabicName'] = "${b["arabicName"]} ${b["variantNameArabic"] ?? ''}";
                                                                                      }
                                                                                    }
                                                                                    // if(currentWaiter!=null){
                                                                                    if (!disable) {
                                                                                      // List itemsList=items;

                                                                                      disable = true;
                                                                                      String billDiscount = discount;
                                                                                      try {
                                                                                        if (Platform.isWindows) {
                                                                                          print(DateTime.now());
                                                                                          double netTotal = dinnerCertificate ? 0.00 : totalAmount - (double.tryParse(discount) ?? 0) + (double.tryParse(delivery) ?? 0);

                                                                                          print("*************************======================");
                                                                                          print(double.tryParse(paidCash.text));
                                                                                          print(amexPaid);
                                                                                          print(madaPaid);
                                                                                          print(visaPaid);
                                                                                          print(masterPaid);

                                                                                          bankPaid = (amexPaid + madaPaid + visaPaid + masterPaid ?? 0);
                                                                                          print("bankPaid============================");
                                                                                          print(bankPaid);
                                                                                          // balance=totalAmount-(bankPaid??0+(double.tryParse(paidCash.text??0)));
                                                                                          if (items.isNotEmpty) {
                                                                                            DocumentSnapshot invoiceNoDoc = await ref.read(homeControllerProvider).getInvoices();
                                                                                            // await FirebaseFirestore
                                                                                            //     .instance
                                                                                            //     .collection(
                                                                                            //     'invoiceNo')
                                                                                            //     .doc(
                                                                                            //     currentBranchId)
                                                                                            //     .get();

                                                                                            int invoiceNo = invoiceNoDoc.get('sales');
                                                                                            int token = invoiceNoDoc.get('token');
                                                                                            invoiceNo++;
                                                                                            token++;

                                                                                            List<String> ingredientIds = [];
                                                                                            for (var a in items) {
                                                                                              for (var b in a['ingredients'] ?? []) {
                                                                                                ingredientIds.add(b['ingredientId']);
                                                                                              }
                                                                                            }

                                                                                            if (blue) {
                                                                                              showDialog(
                                                                                                  barrierDismissible: false,
                                                                                                  context: context,
                                                                                                  builder: (BuildContext context) {
                                                                                                    items = items;
                                                                                                    printCopy = items;
                                                                                                    copyToken = token;
                                                                                                    copyInvoice = invoiceNo;
                                                                                                    copyCustomer = 'Walking Customer';
                                                                                                    copyDate = DateTime.now();
                                                                                                    copyDelivery = double.tryParse(discount) ?? 0;
                                                                                                    copyDiscount = double.tryParse(discount)!;
                                                                                                    return mytest(salesDate: DateTime.now(), items: items, token: token, delivery: double.tryParse(discount), customer: 'Walking Customer', discountPrice: double.tryParse(discount), invoiceNo: invoiceNo.toString(), selectedTable: selectedTable, cashPaid: double.tryParse(paidCash.text) ?? 0, bankPaid: double.tryParse(paidBank.text) ?? 0, balance: balance ?? 0);
                                                                                                  });
                                                                                            } else {
                                                                                              print("items");
                                                                                              print(items);
                                                                                              final billModel = BillModel(
                                                                                                vat: totalAmount * gst / (100 + gst),
                                                                                                grandTotal: totalAmount - (double.tryParse(discount) ?? 0) + (double.tryParse(delivery) ?? 0),
                                                                                                balance: balance,
                                                                                                bank: bankPaid,
                                                                                                cash: double.tryParse(paidCash.text) ?? 0,
                                                                                                cashierName: PosUserIdToArabicName[currentUserId],
                                                                                                cashierNameArabic: PosUserIdToArabicName[currentUserId],
                                                                                                date: DateTime.now(),
                                                                                                invoiceNumber: invoiceNo,
                                                                                                mobileNumber: billMobileNo!,
                                                                                                orderType: dropdownvalue!,
                                                                                                productItems: items,
                                                                                                shopName: currentBranchAddress!,
                                                                                                shopNameArabic: currentBranchAddressArabic!,
                                                                                                vatNumber: vatNumber!,
                                                                                                total: totalAmount * 100 / (100 + gst),
                                                                                                delcharge: double.tryParse(deliveryCharge.text) ?? 0,
                                                                                                discount: double.tryParse(discountController.text) ?? 0,
                                                                                              );
                                                                                              generatePdf(billModel);
                                                                                            }
                                                                                            print(DateTime.now());
                                                                                            ingredientsUpdate(items, ref);
                                                                                            await ref.read(homeControllerProvider).printOrder(invoiceNo, token, paidCash.text, visa.text, mada.text, amex.text, master.text, ingredientIds, context);
                                                                                            setState(() {
                                                                                              discountController.text = '0';
                                                                                              deliveryCharge.text = '0';
                                                                                              enable = false;
                                                                                              mobileNo.text = '';

                                                                                              qty = 0;
                                                                                            });
                                                                                          }

                                                                                          discount = '0.00';
                                                                                          delivery = '0.00';
                                                                                          disable = false;
                                                                                          paidCash.text = '0';
                                                                                          paidBank.text = '0';
                                                                                          totalAmount = 0;
                                                                                          balance = 0;
                                                                                          cashPaid = 0;
                                                                                          bankPaid = 0;
                                                                                          dropdownvalue = arabicLanguage ? "تناول الطعام في" : "Take Away";
                                                                                          bankValue = arabicLanguage ? "تناول الطعام في" : "Select";
                                                                                          dinnerCertificate = false;
                                                                                          mada.text = "0.0";
                                                                                          master.text = "0.0";
                                                                                          visa.text = "0.0";
                                                                                          amex.text = "0.0";
                                                                                          madaPaid = 0;
                                                                                          visaPaid = 0;
                                                                                          masterPaid = 0;
                                                                                          amexPaid = 0;
                                                                                          currentWaiter = null;
                                                                                          enable = false;
                                                                                        } else if (Platform.isAndroid) {
                                                                                          print(DateTime.now());
                                                                                          double netTotal = dinnerCertificate ? 0.00 : totalAmount - (double.tryParse(discount) ?? 0) + (double.tryParse(delivery) ?? 0);

                                                                                          print("*************************======================");
                                                                                          print(double.tryParse(paidCash.text));
                                                                                          print(amexPaid);
                                                                                          print(madaPaid);
                                                                                          print(visaPaid);
                                                                                          print(masterPaid);

                                                                                          bankPaid = (amexPaid + madaPaid + visaPaid + masterPaid ?? 0);
                                                                                          print("bankPaid============================");
                                                                                          print(bankPaid);
                                                                                          // balance=totalAmount-(bankPaid??0+(double.tryParse(paidCash.text??0)));
                                                                                          if (items.isNotEmpty) {
                                                                                            DocumentSnapshot invoiceNoDoc = await ref.read(homeControllerProvider).getInvoices();

                                                                                            int invoiceNo = invoiceNoDoc.get('sales');
                                                                                            int token = invoiceNoDoc.get('token');
                                                                                            invoiceNo++;
                                                                                            token++;

                                                                                            List<String> ingredientIds = [];
                                                                                            for (var a in items) {
                                                                                              for (var b in a['ingredients'] ?? []) {
                                                                                                ingredientIds.add(b['ingredientId']);
                                                                                              }
                                                                                            }

                                                                                            if (blue) {
                                                                                              showDialog(
                                                                                                  barrierDismissible: false,
                                                                                                  context: context,
                                                                                                  builder: (BuildContext context) {
                                                                                                    items = items;
                                                                                                    printCopy = items;
                                                                                                    copyToken = token;
                                                                                                    copyInvoice = invoiceNo;
                                                                                                    copyCustomer = 'Walking Customer';
                                                                                                    copyDate = DateTime.now();
                                                                                                    copyDelivery = double.tryParse(discount) ?? 0;
                                                                                                    copyDiscount = double.tryParse(discount)!;
                                                                                                    return mytest(salesDate: DateTime.now(), items: items, token: token, delivery: double.tryParse(discount), customer: 'Walking Customer', discountPrice: double.tryParse(discount), invoiceNo: invoiceNo.toString(), selectedTable: selectedTable, cashPaid: double.tryParse(paidCash.text) ?? 0, bankPaid: double.tryParse(paidBank.text) ?? 0, balance: balance ?? 0);
                                                                                                  });
                                                                                            } else {
                                                                                              print(DateTime.now());

                                                                                              print("bankPaid---------------------------------------");
                                                                                              print(bankPaid);
                                                                                              abc(invoiceNo, double.tryParse(discountController.text) ?? 0, items, token, selectedTable, double.tryParse(deliveryCharge.text) ?? 0, double.tryParse(paidCash.text) ?? 0, bankPaid ?? 0, balance ?? 0, netTotal ?? 0, dropdownvalue ?? 'Take Away', bytes, kotBytes, _getDevicelist()
                                                                                                  // currentWaiter
                                                                                                  );
                                                                                            }
                                                                                            print(DateTime.now());
                                                                                            ingredientsUpdate(items, ref);
                                                                                            await ref.read(homeControllerProvider).printOrder(invoiceNo, token, paidCash.text, visa.text, mada.text, amex.text, master.text, ingredientIds, context);
                                                                                            setState(() {
                                                                                              discountController.text = '0';
                                                                                              deliveryCharge.text = '0';
                                                                                              enable = false;
                                                                                              mobileNo.text = '';

                                                                                              qty = 0;
                                                                                            });
                                                                                          }

                                                                                          discount = '0.00';
                                                                                          delivery = '0.00';
                                                                                          disable = false;
                                                                                          paidCash.text = '0';
                                                                                          paidBank.text = '0';
                                                                                          totalAmount = 0;
                                                                                          balance = 0;
                                                                                          cashPaid = 0;
                                                                                          bankPaid = 0;
                                                                                          dropdownvalue = arabicLanguage ? "تناول الطعام في" : "Take Away";
                                                                                          bankValue = arabicLanguage ? "تناول الطعام في" : "Select";
                                                                                          dinnerCertificate = false;
                                                                                          mada.text = "0.0";
                                                                                          master.text = "0.0";
                                                                                          visa.text = "0.0";
                                                                                          amex.text = "0.0";
                                                                                          madaPaid = 0;
                                                                                          visaPaid = 0;
                                                                                          masterPaid = 0;
                                                                                          amexPaid = 0;
                                                                                          currentWaiter = null;
                                                                                          enable = false;
                                                                                        }
                                                                                      } catch (e) {
                                                                                        disable = false;
                                                                                        showUploadMessage(context, "Some Technical Errors Occured");
                                                                                      }
                                                                                    } else {
                                                                                      //my change
                                                                                      disable = false;

                                                                                      showUploadMessage(context, "another print already in queue");
                                                                                    }
                                                                                    // }
                                                                                    // else{
                                                                                    //   showUploadMessage(context, 'PLEASE CHOOSE WAITER NAME');
                                                                                    // }
                                                                                  } else {
                                                                                    disable = false;
                                                                                    showUploadMessage(context, 'PLEASE SELECT THE PAYMENT METHOD');
                                                                                  }
                                                                                  approve = false;
                                                                                },
                                                                                child: Container(
                                                                                  height: MediaQuery.of(context).size.height * 0.15,
                                                                                  width: MediaQuery.of(context).size.width * 0.08,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.green.shade700,
                                                                                  ),
                                                                                  child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      const Icon(
                                                                                        Icons.print,
                                                                                        size: 35,
                                                                                        color: Colors.white,
                                                                                      ),
                                                                                      Text(
                                                                                        arabicLanguage ? 'مطبعة' : "PRINT",
                                                                                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            : InkWell(
                                                                                onLongPress: () {
                                                                                  disable = false;
                                                                                  enable = true;
                                                                                  showUploadMessage(context, "print queue cleared successfully");
                                                                                },
                                                                                child: Container(
                                                                                  height: MediaQuery.of(context).size.height * 0.15,
                                                                                  width: MediaQuery.of(context).size.width * 0.08,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.grey.shade400,
                                                                                  ),
                                                                                  child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      const Icon(
                                                                                        Icons.print,
                                                                                        size: 25,
                                                                                        color: Colors.white,
                                                                                      ),
                                                                                      Text(
                                                                                        arabicLanguage ? 'مطبعة' : "PRINT",
                                                                                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ));
                                    },
                                    error: (error, stackTrace) {
                                      print(error.toString());
                                      return Text(error.toString());
                                    },
                                    loading: () => const Loader(),
                                  );
                            },
                            error: (error, stackTrace) {
                              print(error.toString());
                              return Text(error.toString());
                            },
                            loading: () => const Loader(),
                          );
                    },
                    error: (error, stackTrace) {
                      print(error.toString());
                      return Text(error.toString());
                    },
                    loading: () => const Loader(),
                  );
            },
            error: (error, stackTrace) {
              print(error.toString());
              return Text(error.toString());
            },
            loading: () => const Loader(),
          );
    });
  }
}
