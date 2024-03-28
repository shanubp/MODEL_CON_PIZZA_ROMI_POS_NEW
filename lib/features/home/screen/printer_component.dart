import 'dart:convert' show Base64Encoder, utf8;
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as im;
import 'package:esc_pos_printer_plus/esc_pos_printer_plus.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../Branches/branches.dart';
import '../../../main.dart';
import '../../product/screen/product_card.dart';

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
  List<int> date = utf8.encode(DateTime.now().toString().substring(0, 16));
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
abc(
    int invNo,
    double discount,
    List items,
    int token,
    String selectedTable,
    double deliveryAmount,
    double pc,
    double pb,
    double bal,
    double netTotal,
    String dropdownvalue,
    List<int> bytes,
    List<int> kotBytes,
   _getDevicelist
    ) async {
  try {
    print("abc start");
    print(DateTime.now());

    // final CapabilityProfile profile = await CapabilityProfile.load(name: "TP806L");
    final CapabilityProfile profile = await CapabilityProfile.load();
    const PaperSize paper1 = PaperSize.mm80;
    var profile1 = await CapabilityProfile.load();
    var printer1 = NetworkPrinter(paper1, profile1);
    print(DateTime.now());
    final generator = Generator(PaperSize.mm80, profile);
    bytes = [];
    kotBytes = [];

    final Uint8List imgBytes = data!.buffer.asUint8List();
    final im.Image? image = im.decodeImage(imgBytes);
    bytes += generator.imageRaster(image!);
    bytes += generator.feed(1);

    print(DateTime.now());

    final im.Image? image1 = im.decodeImage(capturedImage1);
    print("here");

    bytes += generator.imageRaster(
      image1!,
    );

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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text('Order Type', style: TextStyle(color: Colors.black, fontSize: fontSize + 2, fontWeight: FontWeight.w600),),
            //     Text(approve ? "Credit User" :dropdownvalue, style: TextStyle(color: Colors.black, fontSize: fontSize, fontWeight: FontWeight.w600),),
            //
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Invoice No:',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize + 5,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  '$invNo',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize + 5,
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
    bytes += generator.text("ORDER TYPE : $dropdownvalue",
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

    print(DateTime.now());

    final im.Image? imagehead = im.decodeImage(capturedhead);
    bytes += generator.imageRaster(
      imagehead!,
    );

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
    String addOnArabic = '';
    addOnArabic = newAddOnArabic.isEmpty ? '' : newAddOnArabic.toString();

    Map<String, dynamic> config = Map();
    List<Widget> itemWidgets = [];
    List<Widget> itemWidgets1 = [];
    for (Map<String, dynamic> item in items) {
      addOnPrice = item['addOnPrice'] ??
          0 - item['removePrice'] ??
          0 - item['addLessPrice'] ??
          0 + item['addMorePrice'] ??
          0;
      double total =
          (double.tryParse(item['price'].toString())! + addOnPrice) *
              double.tryParse(item['qty'].toString())!;
      double grossTotal = total * 100 / 115;
      double vat = (double.tryParse(item['price'].toString())! + addOnPrice) *
          15 /
          115;
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
      addOnArabic = newAddOnArabic.isEmpty ? '' : newAddOnArabic.toString();
      addON = newAddOn.isEmpty ? '' : newAddOn.toString();
      double price =
          (double.tryParse(item['price'].toString())! + addOnPrice) *
              100 /
              115;
      totalAmount += price * double.tryParse(item['qty'].toString())!;
      itemTotal += (totalAmount * ((100 + gst) / 100) -
          (double.tryParse(discount.toString()) ?? 0))
          .toStringAsFixed(2);
      itemGrossTotal += grossTotal.toStringAsFixed(2);
      itemTax += (totalAmount * gst / 100).toStringAsFixed(2);
    }

    for (im.Image a in imageList) {
      bytes += generator.imageRaster(a);
    }

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
                  style:
                  TextStyle(color: Colors.black, fontSize: printWidth * .25),
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
        Container(
          padding: const EdgeInsets.all(1.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Delivery Charge - رسوم التوصيل : ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize + 4,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '${deliveryAmount.toStringAsFixed(2)}',
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
                'Discount -  خصم  : ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize + 4,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                (discount == null ? "0.00" : (discount).toStringAsFixed(2)),
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
            child: Center(
                child: Text(
                  '-------------------------------------------',
                  style:
                  TextStyle(color: Colors.black, fontSize: printWidth * .25),
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
                netTotal.toStringAsFixed(2),
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
                  style:
                  TextStyle(color: Colors.black, fontSize: printWidth * .25),
                ))),
        Container(
          padding: const EdgeInsets.all(1.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cash      :  ${pc.toStringAsFixed(2)}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize + 2,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  'Bank      :  ${pb.toStringAsFixed(2)}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize + 2,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  'Change :  ${bal.toStringAsFixed(2)}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize + 2,
                      fontWeight: FontWeight.w600),
                ),
                // Text('Waiter   :  ${currentWaiter}',style:  TextStyle(color: Colors.black,fontSize: fontSize+2,fontWeight: FontWeight.w600),),
              ],
            ),
          ),
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
    ));

    String qrVat = (totalAmount * gst / 100).toStringAsFixed(2);
    String qrTotal = (grantTotal -
        (double.tryParse(discount.toString()) ?? 0) +
        (deliveryAmount ?? 0))
        .toStringAsFixed(2);

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

    var capturedImage2 =
    await screenshotController.captureFromWidget(Container(
        width: printWidth * 3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
              itemWidgets.length,
                  (index) {
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
    print(DateTime.now());

    final im.Image? image2 = im.decodeImage(capturedImage2);
    bytes += generator.imageRaster(image2!);
    final im.Image? footerImage1 = im.decodeImage(footerImage);
    bytes += generator.imageRaster(footerImage1!);
    bytes += generator.drawer(pin: PosDrawer.pin2);
    bytes += generator.feed(2);
    bytes += generator.cut();

    try {
      bool printSuccess = false;
      int i = 0;
      while (!printSuccess && i < 5) {
        // printSuccess = await flutterUsbPrinter.write(Uint8List.fromList(bytes));

        i++;
        if (!printSuccess) {
          await _getDevicelist();
          await Future.delayed(Duration(milliseconds: 200));
        } else {
          print("end");
          print(DateTime.now());
        }
      }
    } catch (ex) {
      print("usb exceptionnnnnnnnnnnnnnnnnn");
      print(ex.toString());
      // await await flutterUsbPrinter.write(Uint8List.fromList(bytes));
    }

    print('kot ********************************');
    try {
      List categories = [];
      for (Map<String, dynamic> item in items) {
        if (!categories.contains(item['category'])) {
          categories.add(item['category']);
        }
      }

      Map<String, dynamic> printerMap = {};
      for (var category in categories) {
        // if(category!="Beverage") {
        String printerID = allCategories[category]['printer'];

        if (printerMap[printerID] == null) {
          printerMap[printerID] = [category];
        } else {
          printerMap[printerID].add(category);
        }
        // }
      }
      for (var printerID in printerMap.keys.toList()) {
        kotPrinter = printers[printerID]['type'];
        List categoryLists = printerMap[printerID];
        if (kotPrinter == 0) {
          bytes += generator.feed(4);
          bytes += generator.text('Token No : $token',
              styles: const PosStyles(
                align: PosAlign.center,
                height: PosTextSize.size2,
                width: PosTextSize.size2,
              ));
          bytes += generator.feed(1);
          bytes += generator.text(
              'Date : ${DateTime.now().toString().substring(0, 16)}',
              styles: const PosStyles(
                  align: PosAlign.center,
                  height: PosTextSize.size1,
                  width: PosTextSize.size2));
          bytes += generator.feed(1);
          bytes += generator.text('Invoice No : $invNo',
              styles: const PosStyles(
                  align: PosAlign.center,
                  height: PosTextSize.size1,
                  width: PosTextSize.size2));
          bytes += generator.feed(1);
          bytes += generator.text('Order Type : $dropdownvalue',
              styles: const PosStyles(
                  align: PosAlign.center,
                  height: PosTextSize.size1,
                  width: PosTextSize.size2));
          bytes += generator.feed(1);
          if (dropdownvalue != "Take Away") {
            bytes += generator.text('Table No : $selectedTable',
                styles: const PosStyles(
                    align: PosAlign.center,
                    height: PosTextSize.size1,
                    width: PosTextSize.size2));
            bytes += generator.feed(1);
          }
          bytes += generator.text('=======================',
              styles: const PosStyles(
                  align: PosAlign.center,
                  height: PosTextSize.size1,
                  width: PosTextSize.size2));
          bytes += generator.feed(2);

          for (Map<String, dynamic> item in items) {
            if (categoryLists.contains(item['category'])) {
              List includeKot = item['addOns'] ?? [];
              List addLessKot = item['addLess'] ?? [];
              List addMoreKot = item['addMore'] ?? [];
              List removeKot = item['remove'] ?? [];
              // newAddOn = item['addOns'];
              // newAddOnArabic = item['addOnArabic'];
              addON = newAddOn.isEmpty ? '' : newAddOn.toString();
              bytes += generator.text(
                  "${int.tryParse(item['qty'].toString())} x ${item['pdtname']} ",
                  styles: const PosStyles(
                      height: PosTextSize.size1, width: PosTextSize.size2));
              bytes += generator.feed(1);
              if (includeKot.isNotEmpty) {
                bytes += generator.text("Include :$includeKot",
                    styles: const PosStyles(
                        align: PosAlign.left,
                        height: PosTextSize.size1,
                        width: PosTextSize.size2));
              }
              if (addLessKot.isNotEmpty) {
                bytes += generator.text("Add Less :$addLessKot",
                    styles: const PosStyles(
                        align: PosAlign.left,
                        height: PosTextSize.size1,
                        width: PosTextSize.size2));
              }
              if (addMoreKot.isNotEmpty) {
                bytes += generator.text("Add More :$addMoreKot",
                    styles: const PosStyles(
                        align: PosAlign.left,
                        height: PosTextSize.size1,
                        width: PosTextSize.size2));
              }
              if (removeKot.isNotEmpty) {
                bytes += generator.text("Remove :$removeKot",
                    styles: const PosStyles(
                        align: PosAlign.left,
                        height: PosTextSize.size1,
                        width: PosTextSize.size2));
              }
              bytes += generator.feed(1);
            }
          }
          bytes += generator.feed(2);
          bytes += generator.cut();
        }
      }
      try {
        bool? printSuccess = false;
        int i = 0;
        while (!printSuccess! && i < 5) {
          printSuccess =
          await flutterUsbPrinter.write(Uint8List.fromList(bytes));

          i++;
          if (!printSuccess!) {
            await _getDevicelist();
            await Future.delayed(Duration(milliseconds: 200));
          } else {
            print("end");
            print(DateTime.now());
          }
        }
        for (var printerID in printerMap.keys.toList()) {
          kotPrinter = printers[printerID]['type'];
          List categoryLists = printerMap[printerID];
          if (kotPrinter == 1) {
            String ip = printers[printerID]['ip'];
            int port = printers[printerID]['port'];

            try {
              PosPrintResult res = await printer1.connect(ip,
                  port: port, timeout: const Duration(seconds: 10));
              int j = 0;
              while (res != PosPrintResult.success && j < 5) {
                res = await printer1.connect(ip,
                    port: port, timeout: const Duration(seconds: 2));
                j++;
              }
              if (res == PosPrintResult.success) {
                printer1.feed(4);
                printer1.text('Token No : $token',
                    styles: const PosStyles(
                        align: PosAlign.center,
                        height: PosTextSize.size2,
                        width: PosTextSize.size2));
                printer1.feed(1);
                printer1.text(
                    'Date : ${DateTime.now().toString().substring(0, 16)}',
                    styles: const PosStyles(
                        align: PosAlign.center,
                        height: PosTextSize.size1,
                        width: PosTextSize.size2));
                printer1.feed(1);
                printer1.text('Invoice No : $invNo',
                    styles: const PosStyles(
                        align: PosAlign.center,
                        height: PosTextSize.size1,
                        width: PosTextSize.size2));
                printer1.feed(1);
                printer1.text('Oredre Type: $dropdownvalue',
                    styles: const PosStyles(
                        align: PosAlign.center,
                        height: PosTextSize.size1,
                        width: PosTextSize.size2));
                printer1.feed(1);
                if (dropdownvalue != "Take Away") {
                  printer1.text('Table  No : $selectedTable',
                      styles: const PosStyles(
                          align: PosAlign.center,
                          height: PosTextSize.size1,
                          width: PosTextSize.size2));
                }
                printer1.feed(4);
                for (Map<String, dynamic> item in items) {
                  if (categoryLists.contains(item['category'])) {
                    // newAddOn = item['addOns'];
                    // newAddOnArabic = item['addOnArabic'];
                    List includeKot2 = item['addOns'] ?? [];
                    List addLessKot2 = item['addLess'] ?? [];
                    List addMoreKot2 = item['addMore'] ?? [];
                    List removeKot2 = item['remove'] ?? [];
                    addON = newAddOn.isEmpty ? '' : newAddOn.toString();
                    printer1.text(
                        "${int.tryParse(item['qty'].toString())} x ${item['pdtname']} $addON",
                        styles: const PosStyles(
                            height: PosTextSize.size1,
                            width: PosTextSize.size2));
                    printer1.feed(1);
                    if (includeKot2.isNotEmpty) {
                      printer1.text("Include :$includeKot2",
                          styles: const PosStyles(
                              align: PosAlign.left,
                              height: PosTextSize.size1,
                              width: PosTextSize.size2));
                    }
                    if (addLessKot2.isNotEmpty) {
                      printer1.text("Add Less :$addLessKot2",
                          styles: const PosStyles(
                              align: PosAlign.left,
                              height: PosTextSize.size1,
                              width: PosTextSize.size2));
                    }
                    if (addMoreKot2.isNotEmpty) {
                      printer1.text("Add More :$addMoreKot2",
                          styles: const PosStyles(
                              align: PosAlign.left,
                              height: PosTextSize.size1,
                              width: PosTextSize.size2));
                    }
                    if (removeKot2.isNotEmpty) {
                      printer1.text("Remove :$removeKot2",
                          styles: const PosStyles(
                              align: PosAlign.left,
                              height: PosTextSize.size1,
                              width: PosTextSize.size2));
                    }
                    printer1.feed(1);
                  }
                }

                if (lastCut == true) {
                  printer1.feed(4);
                  printer1.cut();
                  printer1.disconnect(delayMs: 10);
                }
              } else {
                print(res.msg);
                print("no printer found");
              }
            } catch (e) {
              print("button catch");
              print(e.toString());
            }
          }
        }
      } catch (ex) {
        print("usb exceptionnnnnnnnnnnnnnnnnn");
        print(ex.toString());
        await await flutterUsbPrinter.write(Uint8List.fromList(bytes));
      }
    } catch (error) {
      print(
        error.toString(),
      );
    }

    print("end");
  } catch (e) {
    print("error occuredddddddddddddddddd");
    print(e.toString());
  }
}