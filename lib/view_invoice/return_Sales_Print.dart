
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:awafi_pos/Branches/branches.dart';
import 'package:awafi_pos/modals/Print/Invoice.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import '../main.dart';
import '../main.dart';
import '../product_card.dart';
import 'package:path_provider/path_provider.dart';

class return_salesPrint extends StatefulWidget {
  final DateTime? salesDate;
  final String? invoiceNo;
  final double? discountPrice;
  final double? delivery;
  final double? grandTotal;
  final double? vatTotal;
  final double? cashPaid;
  final double? bankPaid;
  final double? balance;
  final double? total;
  final int? token;
  final List? items;
  final List ?returnItems;
  final String ?customer;
  final String? tableName;

  const return_salesPrint(
      {Key? key,
        this.salesDate,
        this.invoiceNo,
        this.discountPrice,
        this.token,
        this.customer,
        this.delivery, this.items,
        this.returnItems,
        this.grandTotal,
        this.vatTotal,
        this.total,
        this.tableName,
        this.cashPaid,
        this.balance,
        this.bankPaid})
      : super(key: key);

  @override
  _mytestState createState() => _mytestState();
}

class _mytestState extends State<return_salesPrint> {

  @override
  void initState() {
    super.initState();
    if (!connected) {
      initPlatformState();
      initSavetoPath();
    } else {
      _tesPrint();
    }
  }

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
    List<int> date = utf8.encode(widget.salesDate.toString());
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

  initSavetoPath() async {
    //read and write
    //image max 300px X 300px
    const filename = 'pizzaromiBill.png';
    const filename1 = 'assets/pizzaromiBill.png';
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

  Future<void> initPlatformState() async {
    List<BluetoothDevice> devices = [];

    try {
      devices = await bluetooth!.getBondedDevices();
    } on PlatformException {
      // TODO - Error
    }

    bluetooth!.onStateChanged().listen((state) {
      print("connect");
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          setState(() {
            connected = true;
            pressed = false;
          });
          break;
        case BlueThermalPrinter.DISCONNECTED:
          setState(() {
            connected = false;
            pressed = false;
          });
          break;
        default:
          print(state);
          break;
      }
    });

    if (!mounted) return;
    setState(() {
      btDevices = devices;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AlertDialog(
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Device:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton(
                    items: _getDeviceItems(),
                    onChanged: (value) => setState(() => device = value),
                    value: device,
                  ),
                  ElevatedButton(
                    onPressed: pressed
                        ? null
                        : connected
                        ? _disconnect
                        : _connect,
                    child: Text(connected ? 'Disconnect' : 'Connect'),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  if (connected) {
                    _tesPrint();
                  } else {}
                },
                child: const Text('Print'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (btDevices.isEmpty) {
      items.add(const DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      btDevices.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name!),
          value: device,
        ));
      });
    }
    return items;
  }

  void _connect() {
    if (device == null) {
      show('No device selected.');
    } else {
      bluetooth!.isConnected.then((isConnected) {
        print("here");
        if (isConnected!) {
          bluetooth!.connect(device!).catchError((error) {
            print(error);
            setState(() {
              pressed = false;
              connected = false;
            });
          });
          setState(() {
            pressed = true;
            connected = true;
          });
        } else {
          setState(() {
            pressed = true;
            connected = true;
          });
        }
      });
    }
  }

  void _disconnect() {
    bluetooth!.disconnect();
    setState(() => pressed = true);
  }

//write to app path
  Future<File> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
  ArabicNumbers arabicNumber = ArabicNumbers();
  ScreenshotController screenshotController = ScreenshotController();

  void _tesPrint() async {
    //SIZE
    // 0- normal size text
    // 1- only bold text
    // 2- bold with medium text
    // 3- bold with large text
    //ALIGN
    // 0- ESC_ALIGN_LEFT
    // 1- ESC_ALIGN_CENTER
    // 2- ESC_ALIGN_RIGHT

    bluetooth!.isConnected.then((isConnected) async {
      if (isConnected!) {
        String arabic = '';
        String english = '';
        print("connect");
        Map<String, dynamic> config = Map();
        String itemString = '';
        String itemStringArabic = '';
        String itemTotal = '';
        String itemGrossTotal = '';
        String itemTax = '';
        String addON = '';
        String tokenNo = '';
        double deliveryCharge = 0;
        double grantTotal = 0;
        double totalAmount = 0;
        String addOnArabic = '';
        addOnArabic = newAddOnArabic.isEmpty ? '' : newAddOnArabic.toString();
        var  filePathAndName;
        final invoice = Invoice(
            info: InvoiceInfo(
              description: currentBranchName!,
              number: '',
              date: DateTime.now(),
            ),
            salesItems: [],
            table: int.tryParse(selectedTable),
            delivery: double.tryParse(delivery.toString()) ?? 0,
            discount: double.tryParse(discount.toString()) ?? 0);
        // bluetooth.printNewLine();
        List<Widget> itemWidgets = [];
        for (Map<String, dynamic> item in items) {
          addOnPrice= item['addOnPrice']??0-item['removePrice']??0-item['addLessPrice']??0+item['addMorePrice']??0;
          double total = (double.tryParse(item['price'].toString())!+addOnPrice) *
              double.tryParse(item['qty'].toString())!;
          double grossTotal = total * 100 / 115;
          double vat = (double.tryParse(item['price'].toString())!+addOnPrice) * 15 / 115;
          newAddOn = item['addOns']??''+item['addLess']??''+item['addMore']??''+item['remove']??'';
          arabic = item['arabicName'];
          tokenNo = item['token'].toString();
          String arabic1 = StringUtils.reverse(arabic);
          arabic1 = arabic1.padLeft(30, " ");
          grantTotal += total;

          deliveryCharge = item['deliveryCharge'] == null
              ? 0
              : double.tryParse(item['deliveryCharge'].toString())!;
          addON = newAddOn.isEmpty ? '' : newAddOn.toString();
          double price =
              (double.tryParse(item['price'].toString())!+addOnPrice) * 100 / 115;
          totalAmount += price * double.tryParse(item['qty'].toString())!;

          itemString += "${item['pdtname']} $addON             \n";
          itemString += arabic1;

          itemString +=
          "${int.tryParse(item['qty'].toString())}  ${price.toStringAsFixed(2)}  ${vat.toStringAsFixed(2)}  ${total.toStringAsFixed(2)} \n";
          String rowItem = "${item['pdtname']} $addON             \n";

          rowItem +=
          "$arabic ${int.tryParse(item['qty'].toString())}  ${price.toStringAsFixed(2)}  ${vat.toStringAsFixed(2)}  ${total.toStringAsFixed(2)}";

          itemTotal += (totalAmount * ((100 + gst) / 100) - (double.tryParse(discount.toString()) ?? 0))
              .toStringAsFixed(2);
          itemGrossTotal += grossTotal.toStringAsFixed(2);
          itemTax += (totalAmount * gst / 100).toStringAsFixed(2);

        }

        bluetooth!.printImage(topImage!);

        bluetooth!.printNewLine();//path of your image/logo
        bluetooth!.printNewLine(); ////path of your image/logo

        print('print start');
        // bluetooth.printCustom("Sharayya No.5 Makkah near Sulthan Sweets", 1, 1);
        var  capturedImage1= await    screenshotController
            .captureFromWidget(Container(
          color: Colors.white,
          width: printWidth*3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(currentBranchAddressArabic!,style:  TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
            ],
          ),
        ));
        bluetooth!.printImageBytes(capturedImage1);
        var    capturedImage6= await    screenshotController
            .captureFromWidget(Container(
          color: Colors.white,
          width: printWidth*3,
          height: 45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text('رقم الهاتف  :  ${arabicNumber.convert(currentBranchPhNo)}',style:  TextStyle(color: Colors.black,fontSize: fontSize+2,fontWeight: FontWeight.w600),),
                  Text('Phone No  :  $currentBranchPhNo',style:  TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),

                ],
              )
            ],
          ),
        ));
        bluetooth!.printImageBytes(capturedImage6);
        var   capturedImage7= await    screenshotController
            .captureFromWidget(Container(
          color: Colors.white,
          width: printWidth*3,
          height: 45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [Column(
              children: [
                Text('رقم ضريبة  :  ${arabicNumber.convert(vatNumber)}',style: TextStyle(color: Colors.black,fontSize: fontSize+2,fontWeight: FontWeight.w600),),
                Text('Vat  : $vatNumber',style: TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),

              ],
            )],
          ),
        ));
        bluetooth!.printImageBytes(capturedImage7);
        var  capturedImage8= await    screenshotController
            .captureFromWidget(Container(
          color: Colors.white,
          width: printWidth*3,
          height: 45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Column(
                children: [
                  Text(' تاريخ  :  ${DateTime.now().toString().substring(0, 19)} ',style:  TextStyle(color: Colors.black,fontSize: fontSize+2,fontWeight: FontWeight.w600),),
                  Text('Date  :  ${DateTime.now().toString().substring(0, 19)} ',style:  TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),

                ],
              )
            ],
          ),
        ));
        bluetooth!.printImageBytes(capturedImage8);
        var  capturedImage9= await    screenshotController
            .captureFromWidget(Container(
          color: Colors.white,
          width: printWidth*3,
          height: 45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              // Text('${widget.invoiceNo}: رقم الفاتورة  '
              Column(
                children: [
                  Text('  رقم الفاتورة  :${arabicNumber.convert(widget.invoiceNo)}     ',style:  TextStyle(color: Colors.black,fontSize: fontSize+2,fontWeight: FontWeight.w600),),
                  Text(' Invoice No :  ${widget.invoiceNo}',style:  TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),

                ],
              )
            ],
          ),
        ));
        bluetooth!.printImageBytes(capturedImage9);
        var  capturedImage10= await    screenshotController
            .captureFromWidget(Container(
          color: Colors.white,
          width: printWidth*3,
          height: 45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:   [
              Column(
                children: [
                  Text('  زبون سفري',style: TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
                  Text('Walking Customer',style: TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),

                ],
              )
            ],
          ),
        ));
        // bluetooth.printImageBytes(capturedImage10);
        // var capturedImage11= await    screenshotController
        //     .captureFromWidget(Container(
        //   color: Colors.white,
        //   width: printWidth*3,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children:   [
        //       Text('${widget.token.toString()}: Token( رقم رمزي ) ',
        //         // Text('${widget.token.toString()}: رقم رمزي   ',
        //         style:  TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
        //     ],
        //   ),
        // ));

        bluetooth!.printImageBytes(capturedImage11);

        var capturedImage15= await    screenshotController
            .captureFromWidget(Container(
          color: Colors.white,
          width: printWidth*3,
          height: 75,
          padding: EdgeInsets.only(top: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:   [Column(
              children: [
                Text(' رقم الطلب  : ${arabicNumber.convert(widget.token)}', style:  TextStyle(color: Colors.black,fontSize: fontSize+10,fontWeight: FontWeight.w600),),
                Text('TOKEN  :  ${widget.token}', style:  TextStyle(color: Colors.black,fontSize: fontSize+10,fontWeight: FontWeight.w600),),

              ],
            )],
          ),
        ));
        bluetooth!.printImageBytes(capturedImage15);

        bluetooth!.printCustom("................................", 1, 1);
        print('date end');
        // await bluetooth.printImage(heading);
        //path of your image/logo
        print('heading end');
        var capturedhead= await    screenshotController
            .captureFromWidget(Container(
          color: Colors.white,
          width: printWidth*3,
          height: 50,
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:   [
              //pdt
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('منتج',
                      style:  TextStyle(
                        fontFamily: 'GE Dinar One Medium',
                        fontSize: fontSize,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text('Product',
                      style:  TextStyle(
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
                    Text('كمية',
                      style:  TextStyle(
                          fontFamily: 'GE Dinar One Medium',
                          color: Colors.black,
                          fontSize: fontSize,
                          fontWeight: FontWeight.w600),
                    ),
                    Text('Qty',
                      style:  TextStyle(
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
                    Text('سعر',
                      style:  TextStyle(
                          fontFamily: 'GE Dinar One Medium',
                          color: Colors.black,
                          fontSize: fontSize,
                          fontWeight: FontWeight.w600),
                    ),
                    Text('Rate',
                      style:  TextStyle(
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
                    Text('ضريبة',
                      style:  TextStyle(
                          fontFamily: 'GE Dinar One Medium',
                          color: Colors.black,
                          fontSize: fontSize,
                          fontWeight: FontWeight.w600),
                    ),
                    Text('vat',
                      style:  TextStyle(
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
                    Text('المجموع',
                      style:  TextStyle(
                          fontFamily: 'GE Dinar One Medium',
                          color: Colors.black,
                          fontSize: fontSize,
                          fontWeight: FontWeight.w600),
                    ),
                    Text('Total',
                      style:  TextStyle(
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
        ));

        bluetooth!.printImageBytes(capturedhead);

        bluetooth!.printCustom("................................", 1, 1);

        for (Map<String, dynamic> item in widget.items!) {
          print(item);
          addOnPrice= item['addOnPrice']??0-item['removePrice']??0-item['addLessPrice']??0+item['addMorePrice']??0;
          double total = (double.tryParse(item['price'].toString())!+addOnPrice) *
              double.tryParse(item['qty'].toString())!;

          double vat =(double.tryParse(item['price'].toString())!+addOnPrice) * 15 / 115;
          newAddOn = item['addOns']??''+item['addLess']??''+item['addMore']??''+item['remove']??'';
          arabic = item['arabicName'];
          english = item['pdtname'];
          tokenNo = item['token'].toString();
          arabic = arabic.replaceAll('(', ')');
          arabic = arabic.replaceAll('(', '(');
          arabic = arabic.replaceAll(')', '(');
          arabic = arabic.replaceAll(')', ')');
          arabic = arabic.replaceAll('[', ']');
          arabic = arabic.replaceAll(']', '[');

          // String arabic1 = StringUtils.reverse(arabic);
          String english1 = english;

          addON = newAddOn.isEmpty ? '' : newAddOn.toString();
          double price = (double.tryParse(item['price'].toString())!+addOnPrice) * 100 / 115;
          // bluetooth.printCustom(
          //     "${item['pdtname']} $addON             ", size, 0,
          //     charset: charset);
          String secondLine = "";
          if (product == true) {
            secondLine += english1;
          }
          secondLine +=
          "${double.tryParse(item['qty'].toString())}  ${price.toStringAsFixed(2)}  ${vat.toStringAsFixed(2)}  ${total.toStringAsFixed(2)}\n";
          // bluetooth.printCustom(secondLine, size, 2, charset: charset);

          var  capturedImage2= await    screenshotController
              .captureFromWidget(
              Container(
                  width: printWidth*3.2,
                  padding: const EdgeInsets.all(1.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: ListView(
                      shrinkWrap: true,
                      children:[
                        Container(
                          width: printWidth*3.2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0,right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('$arabic $addOnArabic',
                                        // textDirection: TextDirection.rtl,
                                        style:  TextStyle(
                                          fontFamily: 'GE Dinar One Medium',
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text('$english $addON',
                                        // textDirection: TextDirection.rtl,
                                        style:  TextStyle(
                                          fontFamily: 'GE Dinar One Medium',
                                          fontSize: fontSize,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),

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
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${arabicNumber.convert(double.tryParse(item['qty'].toString())!.toStringAsFixed(2))}',
                                        style:  TextStyle(
                                            fontFamily: 'GE Dinar One Medium',
                                            color: Colors.black,
                                            fontSize: fontSize+2,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text('${double.tryParse(item['qty'].toString())}',
                                        style:  TextStyle(
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
                                      Text('${arabicNumber.convert(price.toStringAsFixed(2))} ',
                                        style:  TextStyle(
                                            fontFamily: 'GE Dinar One Medium',
                                            color: Colors.black,
                                            fontSize: fontSize+2,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text('${price.toStringAsFixed(2)} ',
                                        style:  TextStyle(
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
                                      Text('${arabicNumber.convert(vat.toStringAsFixed(2))}',
                                        style:  TextStyle(
                                            fontFamily: 'GE Dinar One Medium',
                                            color: Colors.black,
                                            fontSize: fontSize+2,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text('${vat.toStringAsFixed(2)}',
                                        style:  TextStyle(
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
                                      Text('${arabicNumber.convert(total.toStringAsFixed(2))}',
                                        style:  TextStyle(
                                            fontFamily: 'GE Dinar One Medium',
                                            color: Colors.black,
                                            fontSize: fontSize+2,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text('${total.toStringAsFixed(2)}',
                                        style:  TextStyle(
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
                          ),
                        ),
                        // Text("${item['pdtname']} $addON",
                        //   textDirection: TextDirection.ltr,
                        //   style: const TextStyle(
                        //     fontSize: 14,
                        //     color: Colors.black,
                        //   ),
                        // ),

                      ]
                  )));
          bluetooth!.printImageBytes(capturedImage2);

        }
        bluetooth!.printCustom("................................", 1, 1);

        var   capturedImage3= await    screenshotController
            .captureFromWidget(Container(
          color: Colors.white,
          width: printWidth*3,
          height: 45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:   [
              Column(
                children: [
                  Text('  الإجمالي  :  ${arabicNumber.convert(totalAmount.toStringAsFixed(2))}',style:  TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
                  Text(' Total Amount  :  ${totalAmount.toStringAsFixed(2)}',style:  TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
                ],
              )

            ],
          ),
        ));
        bluetooth!.printImageBytes(capturedImage3);
        var  capturedImage13= await    screenshotController
            .captureFromWidget(Container(
          color: Colors.white,
          width: printWidth*3,
          height: 45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(' رقم ضريبة  :  ${arabicNumber.convert((totalAmount * gst / 100).toStringAsFixed(2))}',style:  TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
              Text('Vat  :  ${(totalAmount * gst / 100).toStringAsFixed(2)}',style:  TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
            ],
          ),
        ));
        var  capturedImage31= await    screenshotController
            .captureFromWidget(Container(
          color: Colors.white,
          width: printWidth*3,
          height: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children:   [
                  Text('نقدأ  :  ${arabicNumber.convert(widget.cashPaid!.toStringAsFixed(2))}',style:  TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
                  Text('Cash  :  ${widget.cashPaid}',style:  TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
                  Text('مصرف  :  ${arabicNumber.convert(widget.bankPaid!.toStringAsFixed(2))}',style:  TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
                  Text('bank  :  ${widget.bankPaid}',style:  TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
                  Text('المتبقي :  ${arabicNumber.convert(widget.balance!.toStringAsFixed(2))}',style:  TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
                  Text('Change :  ${widget.balance}',style:  TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),

                ],
              ),
            ],
          ),
        ));
        bluetooth!.printImageBytes(capturedImage31);
        bluetooth!.printImageBytes(capturedImage13);
        var   capturedImage23= await    screenshotController
            .captureFromWidget(Container(
          color: Colors.white,
          width: printWidth*3,
          height: 45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:   [
              Column(
                children: [
                  Text(' رسوم التوصيل  :  ${arabicNumber.convert(invoice.delivery!.toStringAsFixed(2))}',style:  TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
                  Text('Delivery Charge  :  ${invoice.delivery!.toStringAsFixed(2)}',style:  TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
                ],
              )
            ],
          ),
        ));
        bluetooth!.printImageBytes(capturedImage23);
        bluetooth!.printCustom("................................", 1, 1);
        var  capturedImage33= await    screenshotController
            .captureFromWidget(Container(
          color: Colors.white,
          width: printWidth*3,
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:   [
              // Text('خص : ${invoice.discount.toStringAsFixed(2)}'
              Column(
                children: [
                  Text(' خصم  :  ${arabicNumber.convert(invoice.discount!.toStringAsFixed(2))}',style:  TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
                  Text('Discount  :  ${invoice.discount!.toStringAsFixed(2)}',style:  TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),

                ],
              )
            ],
          ),
        ));
        bluetooth!.printImageBytes(capturedImage33);
        var  capturedImage43= await    screenshotController
            .captureFromWidget(Container(
          color: Colors.white,
          width: printWidth*3,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:   [
              // Text('المجموع الإجمالي : ${grantTotal.toStringAsFixed(2)}'
              Column(
                children: [
                  Text('Grand Total  :   ${(grantTotal-invoice.discount! +invoice.delivery!).toStringAsFixed(2)}',style:  TextStyle(color: Colors.black,fontSize: fontSize+5,fontWeight: FontWeight.w600),),
                  Text(' المجموع الإجمالي  :  ${arabicNumber.convert((grantTotal-invoice.discount!+invoice.delivery!).toStringAsFixed(2))}',style:  TextStyle(color: Colors.black,fontSize: fontSize+8,fontWeight: FontWeight.w600),),
                ],
              )
            ],
          ),
        ));


        bluetooth!.printImageBytes(capturedImage43);





        String qrVat = (widget.total !* gst / 100).toStringAsFixed(2);
        String qrTotal = widget.grandTotal!.toStringAsFixed(2);
        //  String qrTotal = (widget.grandTotal-invoice.discount+invoice.delivery).toStringAsFixed(2);

        bluetooth!.printQRcode(qr(qrVat, qrTotal), size.toInt(), size.toInt(), 1);



        var  capturedImage53= await    screenshotController
            .captureFromWidget( Container(
          color: Colors.white,
          width: printWidth*3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:   const [
              Text('لعناصر المرتجعة',style:  TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600),),
            ],
          ),
        ));



        await  bluetooth!.printImageBytes(capturedImage53);
        bluetooth!.printCustom("......................................", 1, 1);


        for (Map<String, dynamic> item in widget.returnItems!) {
          addOnPrice= item['addOnPrice']??0-item['removePrice']??0-item['addLessPrice']??0+item['addMorePrice']??0;
          double total = (double.tryParse(item['price'].toString())!+addOnPrice) *
              double.tryParse(item['qty'].toString())!;

          double vat = total * 15 / 115;
          newAddOn = item['addOns']??''+item['addLess']??''+item['addMore']??''+item['remove']??'';
          arabic = item['arabicName'];
          english = item['pdtname'];
          tokenNo = item['token'].toString();
          String arabic1 = StringUtils.reverse(arabic);

          addON = newAddOn.isEmpty ? '' : newAddOn.toString();
          double price =
              (double.tryParse(item['price'].toString())!+addOnPrice) * 100 / 115;

          String secondLine = "";
          secondLine += arabic1;
          secondLine += "  ${int.tryParse(item['qty'].toString())}  ${price.toStringAsFixed(2)}  ${vat.toStringAsFixed(2)}  ${total.toStringAsFixed(2)} \n";
          // bluetooth.printCustom(secondLine,1,2,charset: "ISO-8859-6");
          var capturedImage25 = await screenshotController.captureFromWidget(Container(
              width: printWidth*3,
              padding: const EdgeInsets.all(1.0),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              // child: ListView(shrinkWrap: true, children: [
              //
              //   Row(
              //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Expanded(
              //         flex: 4,
              //         child: Text(
              //           '$arabic  $addON  $english' ,
              //           textDirection: TextDirection.rtl,
              //           style:  TextStyle(
              //             fontFamily: 'Amiri',
              //             fontSize: fontSize,
              //             fontWeight: FontWeight.w600,
              //             color: Colors.black,
              //           ),
              //         ),
              //       ),
              //       const SizedBox(
              //         width: 11,
              //       ),
              //       Expanded(
              //         flex: 6,
              //         child: Text(
              //           "${double.tryParse(item['qty'].toString())}   ${price.toStringAsFixed(2)}   ${vat.toStringAsFixed(2)}   ${total.toStringAsFixed(2)}",
              //           textDirection: TextDirection.ltr,
              //           style:  TextStyle(
              //               fontSize: fontSize,
              //               color: Colors.black,
              //               fontWeight: FontWeight.w600),
              //         ),
              //       ),
              //     ],
              //   )
              // ])));
              child: ListView(
                  shrinkWrap: true,
                  children:[
                    Container(
                      width: printWidth*3.2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0,right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(arabic,
                                    // textDirection: TextDirection.rtl,
                                    style:  TextStyle(
                                      fontFamily: 'GE Dinar One Medium',
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(english,
                                    // textDirection: TextDirection.rtl,
                                    style:  TextStyle(
                                      fontFamily: 'GE Dinar One Medium',
                                      fontSize: fontSize,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            const SizedBox(width:20),
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${arabicNumber.convert(double.tryParse(item['qty'].toString())!.toStringAsFixed(2))}',
                                    style:  TextStyle(
                                        fontFamily: 'GE Dinar One Medium',
                                        color: Colors.black,
                                        fontSize: fontSize+2,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text('${double.tryParse(item['qty'].toString())}',
                                    style:  TextStyle(
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
                                  Text('${arabicNumber.convert(price.toStringAsFixed(2))} ',
                                    style:  TextStyle(
                                        fontFamily: 'GE Dinar One Medium',
                                        color: Colors.black,
                                        fontSize: fontSize+2,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text('${price.toStringAsFixed(2)} ',
                                    style:  TextStyle(
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
                                  Text('${arabicNumber.convert(vat.toStringAsFixed(2))}',
                                    style:  TextStyle(
                                        fontFamily: 'GE Dinar One Medium',
                                        color: Colors.black,
                                        fontSize: fontSize+2,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text('${vat.toStringAsFixed(2)}',
                                    style:  TextStyle(
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
                                  Text('${arabicNumber.convert(total.toStringAsFixed(2))}',
                                    style:  TextStyle(
                                        fontFamily: 'GE Dinar One Medium',
                                        color: Colors.black,
                                        fontSize: fontSize+2,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text('${total.toStringAsFixed(2)}',
                                    style:  TextStyle(
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
                      ),
                    ),
                    // Text("${item['pdtname']} $addON",
                    //   textDirection: TextDirection.ltr,
                    //   style: const TextStyle(
                    //     fontSize: 14,
                    //     color: Colors.black,
                    //   ),
                    // ),

                  ]
              )));
          await  bluetooth!.printImageBytes(capturedImage25);

        }
        bluetooth!.printCustom("......................................", 1, 1);

        var  capturedImageCashier= await    screenshotController
            .captureFromWidget(Container(
            color: Colors.white,
            width: printWidth*2,
            height: 55,
            child:
            Column(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                Text('${PosUserIdToArabicName[currentUserId]}: المحاسب  ',style: TextStyle(color: Colors.black,fontSize: fontSize+2,fontWeight: FontWeight.bold, ),),
                Text('Cashier : ${PosUserIdToName[currentUserId]}',style: TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.bold),),

              ],)));
        await bluetooth!.printImageBytes(capturedImageCashier);

        var  capturedImage5= await    screenshotController
            .captureFromWidget(Container(
          color: Colors.white,
          width: printWidth*3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  const [
              Text('شكرًا لزيارتك ونتشوق لرؤيتك مرة أخرى',style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w600),),
            ],
          ),
        ));
        await  bluetooth!.printImageBytes(capturedImage5);
        bluetooth!.printCustom("THANK YOU VISIT AGAIN", 1, 1);
        bluetooth!.printNewLine();
        bluetooth!.printNewLine();
        bluetooth!.printNewLine();
        bluetooth!.printNewLine();
        bluetooth!.paperCut();



      }
    });

    Navigator.pop(context);
  }


  Future show(
      String message, {
        Duration duration: const Duration(seconds: 3),
      }) async {
    await Future.delayed(const Duration(milliseconds: 100));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        duration: duration,
      ),
    );
  }
}
