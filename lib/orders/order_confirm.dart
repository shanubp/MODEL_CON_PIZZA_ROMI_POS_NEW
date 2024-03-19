
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awafi_pos/Branches/branches.dart';
import 'package:awafi_pos/flutter_flow/upload_media.dart';
import 'package:awafi_pos/salesPrint/new_sales_print.dart';
import 'package:esc_pos_printer_plus/esc_pos_printer_plus.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'package:image/image.dart' as im;
import '../product_card.dart';

class OrderConfirmWidget extends StatefulWidget {
  final String orderId;
  final String customerName;
  const OrderConfirmWidget({Key? key, required this.orderId, required this.customerName}) : super(key: key);

  @override
  _OrderConfirmWidgetState createState() => _OrderConfirmWidgetState();
}

class _OrderConfirmWidgetState extends State<OrderConfirmWidget> {
  bool _loadingButton1 = false;
  bool _loadingButton2 = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List billItem=[];
  TextEditingController paidCash = TextEditingController();
  TextEditingController paidBank = TextEditingController();

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
  getAllCategories(){
    FirebaseFirestore.instance.collection('category').where("branchId",isEqualTo:currentBranchId).get().then((value){
      for(DocumentSnapshot<Map<String,dynamic>> category in value.docs){
        allCategories[category['name']]=category.data();
      }
    });
  }


  ScreenshotController screenshotController = ScreenshotController();

  List<int> kotBytes = [];

  abc(int invNo,double discount,List items,int token,String table) async {
    print('start ************************************************************************************************'   );
    print(Timestamp.now().seconds);
    final CapabilityProfile profile = await CapabilityProfile.load();
    print(Timestamp.now().seconds);
    const PaperSize paper1 = PaperSize.mm80;
    var profile1 = await CapabilityProfile.load();
    var printer1 = NetworkPrinter(paper1, profile1);
    final generator = Generator(PaperSize.mm80, profile);
    bytes = [];

    kotBytes=[];





// final Uint8List imgBytes = data.buffer.asUint8List();
    // final im.Image image = im.decodeImage(imgBytes);
    // bytes += generator.image(image);
    //
    // var capturedImage1= await    screenshotController
    //     .captureFromWidget(Container(
    //   color: Colors.white,
    //   width: printWidth*3,
    //   child: ListView(
    //       shrinkWrap: true,
    //       children:[
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Text(currentBranchArabic,style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: fontSize+2,fontWeight: FontWeight.w600),),
    //           ],
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Text('$currentBranchPhNo: Ph( رقمالهتف )  ',style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600)),
    //           ],
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children:  [
    //             Text(' $VatNumber :'+ 'Vat( رقم ضريبة )',style: TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
    //           ],
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children:  [
    //             Text('${DateTime.now().toString().substring(0, 19)}: Date( تاريخ )  ',style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
    //           ],
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children:  [
    //             Text('$invNo: Invoice No( رقم الفاتورة )  '
    //               ,style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
    //           ],
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children:   [
    //             Text('Walking Customer( زبون : زبون مشي )',style: TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
    //           ],
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children:   [
    //             Text('$token: Token( رقم رمزي ) ',style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
    //           ],
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children:   [
    //             Text('TOKEN : $table',
    //               style:  TextStyle(color: Colors.black,fontSize: fontSize+13,fontWeight: FontWeight.w600),),
    //           ],
    //         ),
    //         Container( padding: const EdgeInsets.all(1.0),
    //             decoration: const BoxDecoration(
    //               color: Colors.white,
    //             ),
    //             child:  Center(child: Text('...........................................',
    //               style: TextStyle(color: Colors.black,fontSize: printWidth*.25),))),
    //       ]
    //   ),
    // ));
    // print('***************');
    // print(printWidth);
    // print('***************');
    // final im.Image image1 = im.decodeImage(capturedImage1);
    // bytes += generator.image(image1);
    //
    //
    // final Uint8List imgBytes1 = data1.buffer.asUint8List();
    // final im.Image image11 = im.decodeImage(imgBytes1);
    // bytes += generator.image(image11);
    //
    // var capturedImage12= await    screenshotController
    //     .captureFromWidget(Container(
    //   color: Colors.white,
    //   width: printWidth*3,
    //   height: 15,
    //   child:Container(
    //       padding: const EdgeInsets.all(1.0),
    //       decoration: const BoxDecoration(
    //         color: Colors.white,
    //       ),
    //       child: Center(child: Text('.........................................',
    //         style: TextStyle(color: Colors.black,fontSize: printWidth*.25),))
    //   ),
    // )
    // );
    //
    // final im.Image image13 = im.decodeImage(capturedImage12);
    // bytes += generator.image(image13);
    //
    // String itemString = '';
    // String itemStringArabic = '';
    // String itemTotal = '';
    // String itemGrossTotal = '';
    // String itemTax = '';
    //
    // double deliveryCharge = 0;
    // double grantTotal = 0;
    // double totalAmount = 0;

    // String english = '';
    // Map<String, dynamic> config = Map();
    // List<Widget> itemWidgets=[];
    // List<Widget> itemWidgets1=[];
    // for (Map<String, dynamic> item in items) {
    //
    //   double total = double.tryParse(item['price'].toString()) *
    //       double.tryParse(item['qty'].toString());
    //   double grossTotal = total * 100 / 115;
    //   double vat = total * 15 / 115;
    //   newAddOn = item['addOns'];
    //   arabic = item['arabicName'];
    //   english = item['pdtname'];
    //
    //
    //   grantTotal += total;
    //
    //   deliveryCharge = item['deliveryCharge'] == null ? 0
    //       : double.tryParse(item['deliveryCharge'].toString());
    //   addON = newAddOn.isEmpty ? '' : newAddOn.toString();
    //   double price = double.tryParse(item['price'].toString()) * 100 / 115;
    //   totalAmount += price * double.tryParse(item['qty'].toString());
    //
    //   itemWidgets1.add(
    //       Container(
    //           padding: const EdgeInsets.all(1.0),
    //           decoration: const BoxDecoration(
    //             color: Colors.white,
    //           ),
    //           child: ListView(
    //               shrinkWrap: true,
    //               children:[
    //                 Text(english+' '+ arabic,
    //                   // textDirection: TextDirection.rtl,
    //                   style:  TextStyle(
    //                     fontFamily:'GE Dinar One Medium',
    //                     fontSize: fontSize,
    //                     fontWeight: FontWeight.w600,
    //                     color: Colors.black,
    //                   ),
    //                 ),
    //                 // Text("${item['pdtname']} $addON",
    //                 //   textDirection: TextDirection.ltr,
    //                 //   style: const TextStyle(
    //                 //     fontSize: 14,
    //                 //     color: Colors.black,
    //                 //   ),
    //                 // ),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.end,
    //                   children: [
    //                     Text("${double.tryParse(item['qty'].toString())}  ${price.toStringAsFixed(2)}  ${vat.toStringAsFixed(2)}  ${total.toStringAsFixed(2)}",
    //                       textDirection: TextDirection.ltr,
    //                       style:  TextStyle(
    //                         fontSize: fontSize,
    //                         fontWeight: FontWeight.w600,
    //                         color: Colors.black,
    //                       ),
    //                     ),
    //                   ],
    //                 )
    //               ]
    //           )));
    //   print('mid ************************************************************************************************'   );
    //   if(itemWidgets1.length==itemCount){
    //     var capturedIm = await screenshotController
    //         .captureFromWidget(Container(
    //       width: printWidth*3,
    //
    //       child: ListView.builder(
    //           shrinkWrap: true,
    //           itemCount: itemWidgets1.length,
    //           itemBuilder: (context, index) {
    //             return itemWidgets1[index];
    //           }),
    //     ));
    //
    //     final im.Image image2 = im.decodeImage(capturedIm);
    //     bytes += generator.image(image2);
    //     itemWidgets1=[];
    //   }
    //   itemTotal += (totalAmount * ((100 + gst) / 100) -
    //       (double.tryParse(discount.toString()) ?? 0))
    //       .toStringAsFixed(2);
    //   itemGrossTotal += grossTotal.toStringAsFixed(2);
    //   itemTax += (totalAmount * gst / 100).toStringAsFixed(2);
    // }
    //
    // if(itemWidgets1.length>0){
    //   var capturedIm = await screenshotController
    //       .captureFromWidget(Container(
    //     width: printWidth*3,
    //
    //     child: ListView.builder(
    //         shrinkWrap: true,
    //         itemCount: itemWidgets1.length,
    //         itemBuilder: (context, index) {
    //           return itemWidgets1[index];
    //         }),
    //   ));
    //
    //   final im.Image image2 = im.decodeImage(capturedIm);
    //   bytes += generator.image(image2);
    //   itemWidgets1=[];
    // }
    // List<Widget> itemWidgets2=[];
    // itemWidgets.add( Column(
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [
    //     Container( padding: const EdgeInsets.all(1.0),
    //         decoration: const BoxDecoration(
    //           color: Colors.white,
    //         ),
    //         child:  Center(child: Text('...........................................',
    //           style: TextStyle(color: Colors.black,fontSize: printWidth*.25),))),
    //     Container(
    //       padding: const EdgeInsets.all(1.0),
    //       decoration: const BoxDecoration(
    //         color: Colors.white,
    //       ),
    //       child:     Center(
    //         child: Text("  Total Amount( الاجمامي ) : ${totalAmount.toStringAsFixed(2)}",
    //           style:  TextStyle(
    //             fontFamily:'GE Dinar One Medium',
    //             fontSize: printWidth*.16,
    //             fontWeight: FontWeight.w600,
    //             color: Colors.black,
    //           ),
    //         ),
    //       ),),
    //     Container(    padding: const EdgeInsets.all(1.0),
    //       decoration: const BoxDecoration(
    //         color: Colors.white,
    //       ),
    //       child:     Center(
    //         child: Text("Vat( رقم ضريبة ) : ${(totalAmount * gst / 100).toStringAsFixed(2)}",
    //           // textDirection: TextDirection.rtl,
    //           style:  TextStyle(
    //             fontFamily: 'GE Dinar One Medium',
    //             fontSize: fontSize,
    //             fontWeight: FontWeight.w600,
    //             color: Colors.black,
    //           ),
    //         ),
    //       ),),
    //     Container(    padding: const EdgeInsets.all(1.0),
    //       decoration: const BoxDecoration(
    //         color: Colors.white,
    //       ),
    //       child:     Center(
    //         child: Text("Delivery Charge( رسوم التوصيل ) : $deliveryCharge",
    //           // textDirection: TextDirection.rtl,
    //           style:  TextStyle(
    //             fontFamily: 'GE Dinar One Medium',
    //             fontSize: fontSize,
    //             fontWeight: FontWeight.w600,
    //             color: Colors.black,
    //           ),
    //         ),
    //       ),),
    //     Container( padding: const EdgeInsets.all(1.0),
    //         decoration: const BoxDecoration(
    //           color: Colors.white,
    //         ),
    //         child:  Center(child: Text('.............................................',
    //           style: TextStyle(color: Colors.black,fontSize: printWidth*.25),))),
    //     Container(    padding: const EdgeInsets.all(1.0),
    //       decoration: const BoxDecoration(
    //         color: Colors.white,
    //       ),
    //       child:     Center(
    //         child: Text(" Discount( خص ) : ${(discount==null?"0.00":discount.toStringAsFixed(2))}",
    //           // textDirection: TextDirection.rtl,
    //           style:  TextStyle(
    //             fontFamily: 'GE Dinar One Medium',
    //             fontSize: fontSize,
    //             fontWeight: FontWeight.w600,
    //             color: Colors.black,
    //           ),
    //         ),
    //       ),),
    //     Container(    padding: const EdgeInsets.all(1.0),
    //       decoration: const BoxDecoration(
    //         color: Colors.white,
    //       ),
    //       child:     Center(
    //         child: Text("Grand Total( المجموع الإجمالي ) : ${grantTotal.toStringAsFixed(2)}",
    //           // textDirection: TextDirection.rtl,
    //           style:  TextStyle(
    //             fontFamily: 'GE Dinar One Medium',
    //             fontSize: fontSize,
    //             fontWeight: FontWeight.w600,
    //             color: Colors.black,
    //           ),
    //         ),
    //       ),),
    //   ],
    // ));
    //
    // String qrVat = (totalAmount * gst / 100).toStringAsFixed(2);
    // String qrTotal = grantTotal.toStringAsFixed(2);
    // // bluetooth.printQRcode(qr(qrVat, qrTotal), 200, 200, 1);
    // itemWidgets.add(Container(
    //   color: Colors.white,
    //   width: printWidth*2.4,
    //
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       QrImage(
    //         data: qr(qrVat, qrTotal),
    //         version: 6,
    //         size: size/1.5,
    //       ),
    //     ],
    //   ),
    // ));
    //
    // itemWidgets.add(Container(
    //   color: Colors.white,
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children:  [
    //       Text('شكرا لك الزيارة مرة أخرى',style: TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
    //     ],
    //   ),
    // ));
    //
    // var capturedImage2 = await screenshotController
    //     .captureFromWidget(Container(
    //   width: printWidth*3,
    //
    //   child: ListView.builder(
    //       shrinkWrap: true,
    //       itemCount: itemWidgets.length,
    //       itemBuilder: (context, index) {
    //         return itemWidgets[index];
    //       }),
    // ));
    //
    // final im.Image image2 = im.decodeImage(capturedImage2);
    // bytes += generator.image(image2);
    // bytes += generator.feed(2);
    // print('end ************************************************************************************************'   );
    //
    // bytes += generator.cut();






    // print('kot ************************************************************************************************'   );
    // try {
    //   String addON = '';
    //   String arabic = '';
    //   flutterUsbPrinter.write(Uint8List.fromList(bytes));
    //   kotBytes+=generator.text('Token No : '+token.toString(),styles: const PosStyles(align: PosAlign.center,));
    //   kotBytes+=generator.text('Date : '+DateTime.now().toString().substring(0,16),styles: const PosStyles(align: PosAlign.center,));
    //   kotBytes+=generator.text('Invoice No : '+invNo.toString(),styles: const PosStyles(align: PosAlign.center,));
    //
    //
    //   for (Map<String, dynamic> item in items) {
    //
    //     double total = double.tryParse(item['price'].toString()) *
    //         double.tryParse(item['qty'].toString());
    //
    //     double vat = total * 15 / 115;
    //     newAddOn = item['addOns'];
    //
    //     token = item['token'];
    //     String arabic1 = StringUtils.reverse(arabic);
    //
    //     addON = newAddOn.isEmpty ? '' : newAddOn.toString();
    //     double price =
    //         double.tryParse(item['price'].toString()) * 100 / 115;
    //
    //
    //     kotBytes+=generator.text("${int.tryParse(item['qty']
    //         .toString())} x ${item['pdtname']} $addON");
    //
    //   }
    //
    //   if(lastCut==true){
    //     kotBytes += generator.feed(2);
    //
    //     kotBytes += generator.cut();
    //     flutterUsbPrinter.write(Uint8List.fromList(kotBytes));//double print
    //   }
    //
    //
    //
    // }
    // catch (error) {
    //   print(error.toString(),);
    // }
    //


    print('kot ********************************'   );
    try {
      String addON = '';
      String arabic = '';
      List categories=[];
      for (Map<String, dynamic> item in items) {
        print(item);
        print(item['category']);
        if(!categories.contains(item['category'])) {
          categories.add(item['category']);

        }
      }
      print("----------------categories ------------------");
      print(categories);
      Map<String,dynamic> printerMap={};
      for(var category in categories) {
        // if(category!="Beverage"){
        print("category_____________________");
        print(category);
        String printerID = allCategories[category]['printer'];
        print("$printerID              printer iddddddd");
        // print("allCategories*******************************");
        // print("$allCategories*******************************");


        if(printerMap[printerID]==null){
          printerMap[printerID]=[category];
        }else{
          printerMap[printerID].add(category);
        }
        // }



      }
      print("$printerMap              printer mappppppppppppp");

      for(var printerID in printerMap.keys.toList()) {

        print("$printerID                 printer idddddddddddd");
        kotPrinter=printers[printerID]['type'];
        List categoryLists=printerMap[printerID];
        print("$categoryLists              catrgoryList=printer map[printer id]---------------");

        if(kotPrinter==0) {
          bytes +=generator.feed(4);
          bytes += generator.text('Token No : ' + token.toString(),
              styles: const PosStyles(align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size2));
          print("33333333333333333333");
          bytes +=generator.feed(1);
          bytes += generator.text(
              'Date : ' + DateTime.now().toString().substring(0, 16),
              styles: const PosStyles(align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size2));
          bytes +=generator.feed(1);
          print("0000000000000000");
          bytes += generator.text('Invoice No : ' + '${invNo.toString()}',
              styles: const PosStyles(align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size2));
          bytes +=generator.feed(1);



          bytes += generator.text('Order Type : ${table =="Take Away"?"Take Away":"Dine-In"}',
              styles: const PosStyles(align: PosAlign.left,height: PosTextSize.size1,width: PosTextSize.size2));
          bytes +=generator.feed(1);
          if(table!="Take Away"){
            bytes += generator.text('Table No : $table',
                styles: const PosStyles(align: PosAlign.left,height: PosTextSize.size1,width: PosTextSize.size2));
            bytes +=generator.feed(1);
          }
          bytes += generator.text('Name :${widget.customerName}',
              styles: const PosStyles(align: PosAlign.left,height: PosTextSize.size1,width: PosTextSize.size2));
          bytes +=generator.feed(1);
          bytes += generator.text('======================',
              styles: const PosStyles(align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size2));
          bytes +=generator.feed(2);


          for (Map<String, dynamic> item in items) {
            if (categoryLists.contains(item['category'])) {
              List includeKot=item['addOns']??[];
              List addLessKot=item['addLess']??[];
              List addMoreKot=item['addMore']??[];
              List removeKot=item['remove']??[];
              // newAddOn = item['addOns'];
              // newAddOnArabic = item['addOnArabic'];
              addON = newAddOn.isEmpty ? '' : newAddOn.toString();
              bytes += generator.text("${int.tryParse(item['qty']
                  .toString())} x ${item['pdtname']} ",styles: const PosStyles(align: PosAlign.left,height: PosTextSize.size1,width: PosTextSize.size2));
              bytes += generator.feed(1);
              if (includeKot.isNotEmpty){
                bytes += generator.feed(1);
                bytes += generator.text( "Include :$includeKot",styles: const PosStyles(align: PosAlign.left,));
              }
              if (addLessKot.isNotEmpty){
                bytes += generator.feed(1);
                bytes += generator.text( "Add Less :$addLessKot",styles: const PosStyles(align: PosAlign.left,));
              }
              if (addMoreKot.isNotEmpty){
                bytes += generator.feed(1);
                bytes += generator.text( "Add More :$addMoreKot",styles: const PosStyles(align: PosAlign.left,));
              }
              if (removeKot.isNotEmpty){
                bytes += generator.feed(1);
                bytes += generator.text( "Remove :$removeKot",styles: const PosStyles(align: PosAlign.left,));
              }
              bytes += generator.feed(1);
              bytes += generator.feed(1);

            }
          }
          bytes += generator.feed(5);
          bytes += generator.cut();
          //double print


        }

        else if(kotPrinter==1){
          // await Future.delayed(Duration(seconds: 10));


          String ip=printers[printerID]['ip'];
          int port=printers[printerID]['port'];

          try{

            PosPrintResult res = await printer1.connect(ip, port: port,timeout: const Duration(seconds: 10));
            while(res!=PosPrintResult.success) {
              res = await printer1.connect(ip, port: port,timeout: const Duration(seconds: 10));
            }
            if (res == PosPrintResult.success) {
              printer1.feed(5);
              printer1.text('Token No : $token',
                  styles: const PosStyles(align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size2));
              printer1.feed(1);
              printer1.text(
                  'Date : ${DateTime.now().toString().substring(0, 16)}',
                  styles: const PosStyles(align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size2));
              printer1.feed(1);
              printer1.text('Invoice No : $invNo',
                  styles: const PosStyles(align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size2));
              printer1.feed(1);
              printer1.text('Order Type : ${table =="Take Away"?"Take Away":"Dine-In"}',
                  styles: const PosStyles(align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size2));
              printer1.feed(1);
              if(table!="Take Away"){
                printer1.text('Table No : $table',
                    styles: const PosStyles(align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size2));
                printer1.feed(1);
              }
              printer1.feed(1);
              printer1.text('Name :${widget.customerName}',
                  styles: const PosStyles(align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size2));
              bytes +=generator.feed(1);
              printer1.text('======================',
                  styles: const PosStyles(align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size2));
              printer1.feed(2);


              for (Map<String, dynamic> item in items) {
                if (categoryLists.contains(item['category'])) {
                  // newAddOn = item['addOns'];
                  // newAddOnArabic = item['addOnArabic'];
                  List includeKot2=item['addOns']??[];
                  List addLessKot2=item['addLess']??[];
                  List addMoreKot2=item['addMore']??[];
                  List removeKot2=item['remove']??[];
                  addON = newAddOn.isEmpty ? '' : newAddOn.toString();
                  printer1.text("${int.tryParse(item['qty'].toString())} x ${item['pdtname']} $addON",styles: const PosStyles(align: PosAlign.left,height: PosTextSize.size1,width: PosTextSize.size2));
                  printer1.feed(1);
                  if (includeKot2.isNotEmpty){
                    bytes += generator.feed(1);
                    printer1.text( "Include :$includeKot2",styles: const PosStyles(align: PosAlign.left));
                  }
                  if (addLessKot2.isNotEmpty){
                    bytes += generator.feed(1);
                    printer1.text( "Add Less :$addLessKot2",styles: const PosStyles(align: PosAlign.left));
                  }
                  if (addMoreKot2.isNotEmpty){
                    bytes += generator.feed(1);
                    printer1.text( "Add More :$addMoreKot2",styles: const PosStyles(align: PosAlign.left,));
                  }
                  if (removeKot2.isNotEmpty){
                    bytes += generator.feed(1);
                    printer1.text( "Remove :$removeKot2",styles: const PosStyles(align: PosAlign.left,));
                  }
                  printer1.feed(1);
                }
              }
              if (lastCut == true) {
                printer1.feed(4);
                printer1.cut();
                printer1.disconnect(delayMs: 10);
              }
            }else
            {

              print(res.msg);
              print("no printer found");
              // printer.disconnect(delayMs: 10);
            }
          }catch(e){
            print("button catch");
            print(e.toString());
          }
        }

      }
      try {
        await flutterUsbPrinter.write(Uint8List.fromList(bytes));
      }
      catch(ex){
        print("usb exceptionnnnnnnnnnnnnnnnnn");
        print(ex.toString());
        await flutterUsbPrinter.write(Uint8List.fromList(bytes));
      }

      // bytes = [];
    }
    catch (error) {
      print(error.toString(),);
    }



    print("end");
    print(Timestamp.now().seconds);


  }




  @override
  void initState() {
    super.initState();
    getAllCategories();
    paidCash = TextEditingController(text: '');
    paidBank = TextEditingController(text: '');
    bankPaid=0;
    cashPaid=0;
    balance=0;
  }
  @override
  void dispose() {
    super.dispose();
    paidCash.dispose();
    paidBank.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('orders')
            .where('orderId',isEqualTo: widget.orderId)
            .snapshots(),
        builder: (context, snapshot) {

          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator());
          }

          var data=snapshot.data!.docs;
          if(data.isEmpty){
            return const Center(child: CircularProgressIndicator());
          }
          var bag=data[0]['salesItems'];
          List addOn=[];
          List remove=[];
          List addmore=[];
          List addless=[];
          // var addOnItems=bag[index]['addOn'];
          billItem=[];


          for(Map<String,dynamic> snap in bag){
            addOn=snap['addOn'];
            addmore=snap['addMore'];
            addless=snap['addLess'];
            remove=snap['remove'];
          }




          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.primaryColor,
              automaticallyImplyLeading: true,
              iconTheme: IconThemeData(color: Colors.white),
              title: Text(
                'Confirm Order',
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              actions: const [],
              centerTitle: true,
              elevation: 0,
            ),
            backgroundColor: const Color(0xFFF5F5F5),
            body: SingleChildScrollView(
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
                            width: MediaQuery.of(context).size.width*0.9,


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
                                  padding:
                                  const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Order Id : ${data[0]['orderId']}',
                                        style: FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Customer Name :${data[0]['name']}',
                                        style: FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Address : ${data[0]['address']}',
                                          style: FlutterFlowTheme.bodyText1.override(
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
                                  padding:
                                  const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Phone Number : ${data[0]['phone']}',
                                        style: FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Delivery Location : ${data[0]['address']}',
                                          style: FlutterFlowTheme.bodyText1.override(
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
                                  padding:
                                  const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Branch : ${data[0]['branchName']}',
                                        style: FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Table : ',
                                        style: FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        '${data[0]['table']}',
                                        style: FlutterFlowTheme.bodyText1.override(
                                            fontFamily: 'Poppins',
                                            color:data[0]['table']=='Home Delivery'? Colors.blue
                                                : data[0]['table']=='Take Away'?Colors.green
                                                : Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold
                                        ),
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
                  Container(
                    height: MediaQuery.of(context).size.height*0.36,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: bag==null?const Center(child: CircularProgressIndicator(),):
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: bag.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context,int index){

                          double addOnPrice=double.tryParse(bag[index]['addOnPrice'].toString())??0;
                          double addmorePrice=double.tryParse(bag[index]['addMorePrice'].toString())??0;
                          double addlessPrice=double.tryParse(bag[index]['addLessPrice'].toString())??0;
                          double removePrice=double.tryParse(bag[index]['removePrice'].toString())??0;

                          List addOnName=[];
                          List addmoreName=[];
                          List addlessName=[];
                          List removeName=[];

                          List<dynamic> addOn = bag[index]['addOn'];
                          List<dynamic> addLess = bag[index]['addLess'];
                          List<dynamic> addMore = bag[index]['addMore'];
                          List<dynamic> remove = bag[index]['remove'];

                          List<dynamic> arabicAddOn = bag[index]['addOnArabic'] ?? [];
                          List<dynamic> arabicAddLess = bag[index]['addLessArabic'] ?? [];
                          List<dynamic> arabicAddMore = bag[index]['addMoreArabic'] ?? [];
                          List<dynamic> arabicRemove = bag[index]['removeArabic'] ?? [];

                          if(addOn.isNotEmpty){
                            for(Map<String,dynamic> items in addOn){
                              print(items['addOn']);
                              addOnName.add(items['addOn']);
                              //   addOnPrice+=double.tryParse(items['price']);
                            }
                          }
                          if(remove.isNotEmpty){
                            for(Map<String,dynamic> items in remove){
                              print("remove   ${items['addOn']}");
                              removeName.add(items['addOn']);
                              // removePrice+=double.tryParse(items['price']);
                            }
                          }
                          if(addMore.isNotEmpty){
                            for(Map<String,dynamic> items in addMore){
                              print("addmore  $items");
                              addmoreName.add(items['addOn']);
                              // addmorePrice+=double.tryParse(items['price']);
                            }
                          }
                          if(addLess.isNotEmpty){
                            for(Map<String,dynamic> items in addLess){
                              print("addless $items");
                              addlessName.add(items['addOn']);
                              // addlessPrice+=double.tryParse(items['price']);
                            }
                          }
                          Map<String,dynamic> variants={};
                          if(bag.isNotEmpty){
                            variants=bag[index]['variant'];
                          }


                          billItem.add({
                            'variant':variants,
                            'arabicName':bag[index]['arabicName'],
                            'category':bag[index]['category'],
                            'pdtname':bag[index]['productName'],
                            'price':bag[index]['price']/bag[index]['qty'],
                            'qty':int.tryParse(bag[index]['qty'].toString()),
                            'addOns':addOnName??'',
                            'addLess': addlessName??'',
                            'addMore':addmoreName??'',
                            'remove': removeName??'',
                            'addOnPrice':addOnPrice??0,
                            'addMorePrice':addmorePrice??0,
                            'addLessPrice':addlessPrice??0,
                            'removePrice':removePrice??0,
                            'addOnArabic':arabicAddOn??'',
                            'removeArabic':arabicRemove??'',
                            'addLessArabic':arabicAddLess??'',
                            'addMoreArabic':arabicAddMore??'',
                            'return':false,
                            'returnQty':0

                          });

                          return  Padding(
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
                                        imageUrl:
                                        bag[index]['photoUrl'],
                                        width: 90,
                                        height: 90,
                                        fit: BoxFit.contain,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(

                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    bag[index]['productName'],
                                                    style:
                                                    FlutterFlowTheme.bodyText1.override(
                                                      fontFamily: 'Poppins',

                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(variants.isEmpty?'': '  ${variants['english']??''}',style: const TextStyle(fontWeight: FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                              addOnName.isNotEmpty
                                                  ? Row(
                                                children: [
                                                  Text("INCLUDE : ",style: TextStyle(fontWeight: FontWeight.bold),),
                                                  Text("${addOnName.toString().substring(1,addOnName.toString().length-1)}",),
                                                ],
                                              )
                                                  : Container(),
                                              removeName.isNotEmpty
                                                  ? Row(
                                                children: [
                                                  Text("REMOVE : ",style: TextStyle(fontWeight: FontWeight.bold),),
                                                  Text("${removeName.toString().substring(1,removeName.toString().length-1)}",),
                                                ],
                                              )
                                                  : Container(),
                                              addlessName.isNotEmpty
                                                  ? Row(
                                                children: [
                                                  Text("ADD LESS : ",style: TextStyle(fontWeight: FontWeight.bold),),
                                                  Text("${addlessName.toString().substring(1,addlessName.toString().length-1)}",),
                                                ],
                                              )
                                                  : Container(),
                                              addmoreName.isNotEmpty
                                                  ? Row(
                                                children: [
                                                  Text("ADD MORE : ",style: TextStyle(fontWeight: FontWeight.bold),),
                                                  Text("${addmoreName.toString().substring(1,addmoreName.toString().length-1)}",),
                                                ],
                                              )
                                                  : Container(),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    'Qty : ${bag[index]['qty'].toString()}',
                                                    style:
                                                    FlutterFlowTheme.bodyText1.override(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    'SAR ${bag[index]['price'].toString()}',
                                                    style:
                                                    FlutterFlowTheme.bodyText1.override(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500,
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
                  // Align(
                  //   alignment: const AlignmentDirectional(0, 1),
                  //   child: Padding(
                  //     padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 20, 40),
                  //     child:
                  //   ),
                  // ),
                  Align(
                    alignment: const AlignmentDirectional(0, 0.45),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
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
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FFButtonWidget(
                                onPressed: () async {

                                  DocumentSnapshot order=data[0];
                                  await order.reference.update({

                                    'status':4,

                                  });
                                  Navigator.pop(context);
                                },
                                text: 'Reject',
                                options: FFButtonOptions(
                                  width: 130,
                                  height: 45,
                                  color: const Color(0xFFC80707),
                                  textStyle: FlutterFlowTheme.subtitle2.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.red,
                                  ),
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: 12,
                                ),
                                loading: _loadingButton1, icon: Icon(Icons.close), iconData: Icons.close,
                              ),
                              // Container(
                              //   height: MediaQuery.of(context).size.height * 0.15,
                              //   width: 450,
                              //
                              //   child: Container(
                              //     child: Column(
                              //       children: [
                              //         Expanded(
                              //           child: Container(
                              //             child: Row(
                              //               children: [
                              //                 SizedBox(width: 10,),
                              //                 Expanded(
                              //                   child: SizedBox(
                              //                     child: Column(
                              //                       crossAxisAlignment: CrossAxisAlignment.start,
                              //                       children: [
                              //                         Text(
                              //                           "CASH :",
                              //                           textAlign: TextAlign.start,
                              //                           style: TextStyle(
                              //                               fontWeight: FontWeight.bold),
                              //                         ),
                              //                         Container(
                              //                           height: 45,
                              //                           width:200,
                              //                           child: TextFormField(
                              //                             onEditingComplete: () {
                              //                               FocusScope.of(context)
                              //                                   .unfocus();
                              //                               // textController.selection =
                              //                               //     TextSelection.collapsed(offset: textController.text.length);
                              //
                              //
                              //                               setState(() {
                              //                                 keyboard = false;
                              //                               });
                              //                             },
                              //                             onTap: () {
                              //
                              //                               // double grandTotal=(totalAmount - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0));
                              //                               // print(grandTotal);
                              //                               double TotalCash=double.tryParse(data[0]['total'].toString());
                              //
                              //                               cashPaid=TotalCash-bankPaid;
                              //                               if(cashPaid<0){
                              //                                 cashPaid=0;
                              //                                 balance=TotalCash-cashPaid-bankPaid;
                              //                               }
                              //                               paidCash.text=cashPaid.toString();
                              //
                              //
                              //                               setState(() {
                              //                                 // keyboard = true;
                              //                               });
                              //                             },
                              //                             onChanged: (value){
                              //                               // double grandTotal=(totalAmount - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0));
                              //                               double TotalCash=double.tryParse(data[0]['total'].toString());
                              //                               cashPaid=double.tryParse(value)??0;
                              //                               bankPaid=TotalCash-cashPaid??0;
                              //                               if(bankPaid<0){
                              //                                 bankPaid=0;
                              //                               }
                              //                               paidBank.text=bankPaid.toString();
                              //                               balance=TotalCash-cashPaid-bankPaid;
                              //                               setState(() {
                              //                                 // keyboard = true;
                              //                               });
                              //                             },
                              //                             controller: paidCash,
                              //                             keyboardType:
                              //                             TextInputType.number,
                              //                             decoration: InputDecoration(
                              //                               // labelText: 'DISCOUNT',
                              //                                 hoverColor: default_color,
                              //                                 hintText: 'Enter Amount',
                              //                                 border:
                              //                                 OutlineInputBorder(
                              //                                   borderRadius:
                              //                                   BorderRadius
                              //                                       .circular(5.0),
                              //                                 ),
                              //                                 focusedBorder:
                              //                                 OutlineInputBorder(
                              //                                   borderSide: BorderSide(
                              //                                       color: Colors
                              //                                           .pink.shade900,
                              //                                       width: 1.0),
                              //                                 ),
                              //                                 prefixIcon: Padding(
                              //                                   padding: EdgeInsets.all(0.0),
                              //                                   child: Icon(
                              //                                     Icons.money_outlined,
                              //                                     color: Colors.grey,
                              //                                   ), // icon is 48px widget.
                              //                                 ),
                              //                                 contentPadding: EdgeInsets.all(5)
                              //                             ),
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   ),
                              //                 ),
                              //                 SizedBox(width: 10,),
                              //                 Expanded(
                              //                   child: SizedBox(
                              //                     child: Column(
                              //                       crossAxisAlignment: CrossAxisAlignment.start,
                              //                       children: [
                              //                         Text(
                              //                           "BANK :",
                              //                           textAlign: TextAlign.start,
                              //                           style: TextStyle(
                              //                               fontWeight: FontWeight.bold),
                              //                         ),
                              //                         Container(
                              //                           height: 45,
                              //                           width:200,
                              //                           child: TextFormField(
                              //
                              //                             onEditingComplete: () {
                              //                               FocusScope.of(context)
                              //                                   .unfocus();
                              //
                              //
                              //                               setState(() {
                              //                                 keyboard = false;
                              //                               });
                              //                             },
                              //                             onTap: () {
                              //
                              //                               double TotalCash=double.tryParse(data[0]['total'].toString());
                              //
                              //
                              //                               bankPaid=TotalCash-cashPaid;
                              //                               if(bankPaid<0){
                              //                                 bankPaid=0;
                              //
                              //                               }
                              //                               paidBank.text=bankPaid.toString();
                              //
                              //
                              //                               balance=TotalCash-cashPaid-bankPaid;
                              //                               setState(() {
                              //                                 // keyboard = true;
                              //                               });
                              //                             },
                              //                             onChanged: (value){
                              //                               print(value);
                              //                               bankPaid=double.tryParse(value)??0;
                              //                               // double grandTotal=(totalAmount - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0));
                              //                               double TotalCash=double.tryParse(data[0]['total'].toString());
                              //                               cashPaid=TotalCash-bankPaid;
                              //                               if(cashPaid<0){
                              //                                 cashPaid=0;
                              //                               }
                              //                               paidCash.text=cashPaid.toString();
                              //                               print(bankPaid);
                              //                               balance=TotalCash-cashPaid-bankPaid;
                              //                               setState(() {
                              //                                 // keyboard = true;
                              //                               });
                              //                             },
                              //                             controller: paidBank,
                              //                             keyboardType:
                              //                             TextInputType.number,
                              //                             decoration: InputDecoration(
                              //                               // labelText: 'DISCOUNT',
                              //                                 prefixIcon: Padding(
                              //                                   padding: EdgeInsets.all(0.0),
                              //                                   child: Icon(
                              //                                     Icons.home_repair_service_rounded,
                              //                                     color: Colors.grey,
                              //                                   ), // icon is 48px widget.
                              //                                 ),
                              //                                 hoverColor: default_color,
                              //                                 hintText: 'Enter Amount',
                              //                                 border:
                              //                                 OutlineInputBorder(
                              //                                   borderRadius:
                              //                                   BorderRadius
                              //                                       .circular(5.0),
                              //                                 ),
                              //                                 focusedBorder:
                              //                                 OutlineInputBorder(
                              //                                   borderSide: BorderSide(
                              //                                       color: Colors
                              //                                           .pink.shade900,
                              //                                       width: 1.0),
                              //                                 ),
                              //                                 contentPadding: EdgeInsets.all(5)
                              //                             ),
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   ),
                              //                 ),
                              //                 SizedBox(width: 10,),
                              //
                              //
                              //
                              //               ],
                              //             ),
                              //           ),
                              //         ),
                              //
                              //         Container(
                              //           height:MediaQuery.of(context).size.height * 0.05,
                              //           child: Center(child: Text('Balance : $balance',style: TextStyle(
                              //               fontWeight: FontWeight.bold,
                              //               fontSize: 17
                              //           ),)),
                              //         )
                              //
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              FFButtonWidget(
                                onPressed: () async {

                                  // if(paidCash.text!='' || paidBank.text!='') {
                                  setState(() =>

                                  _loadingButton2 = true

                                  );
                                  try {
                                    double deliveryCharge = double.tryParse(
                                        data[0]['deliveryCharge'].toString())!;
                                    DocumentSnapshot order = data[0];

                                    DocumentSnapshot invoiceNoDoc =
                                    await FirebaseFirestore
                                        .instance
                                        .collection('invoiceNo')
                                        .doc(currentBranchId)
                                        .get();
                                    FirebaseFirestore.instance
                                        .collection('invoiceNo')
                                        .doc(currentBranchId)
                                        .update({
                                      'sales':
                                      FieldValue.increment(1),
                                      'token':
                                      FieldValue.increment(1)
                                    });
                                    int invoiceNo =
                                    invoiceNoDoc.get('sales');
                                    int token =
                                    invoiceNoDoc.get('token');
                                    invoiceNo++;
                                    token++;

                                    await FirebaseFirestore.instance
                                        .collection('sales')
                                        .doc(currentBranchId)
                                        .collection('sales')
                                        .doc(invoiceNo.toString())
                                        .set({
                                      'currentUserId': currentUserId,
                                      'salesDate': DateTime.now(),
                                      'invoiceNo': invoiceNo,
                                      // 'cash': true,
                                      'token': token,
                                      'currentBranchId': currentBranchId,
                                      'currentBranchPhNo': currentBranchPhNo,
                                      'currentBranchAddress': currentBranchAddress,
                                      'currentBranchArabic': currentBranchAddressArabic,
                                      'deliveryCharge': double.tryParse(
                                          deliveryCharge.toStringAsFixed(2)) ?? 0,
                                      'table': data[0]['table'],
                                      'billItems': billItem,
                                      'discount': 0,
                                      'totalAmount': double.tryParse(data[0]['subTotal']),
                                      'tax': double.tryParse(data[0]['tax']),
                                      'grandTotal': double.tryParse(data[0]['total']),
                                      'paidCash':0,
                                      'paidBank':0,
                                      'cash':false ,
                                      'bank': false,
                                      'balance':balance,
                                      "creditSale":false,
                                      "creditName":'',
                                      "creditNumber":'',
                                      "AMEX":false,
                                      "VISA":false,
                                      "MASTER":false,
                                      "MADA":false,
                                      "dinnerCertificate":false,
                                      "cancel":false,
                                      "waiterName":"",
                                      "orderType":data[0]['table']

                                    });

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
                                              selectedTable: data[0]['table'],  salesDate: DateTime.now(), delivery: null, cashPaid: null, bankPaid:0.0
                                          );

                                        }):

                                    abc(invoiceNo, 0, billItem, token,data[0]['table']);
                                    await order.reference.update({
                                      'acceptedTime': DateTime.now(),
                                      'status': 1,
                                      // 'status': 0,
                                      'token': token,
                                      'invoiceNo': invoiceNo,

                                    });
                                    paidCash.text='';
                                    paidBank.text='';
                                    totalAmount=0;
                                    balance=0;
                                    cashPaid=0;
                                    bankPaid=0;

                                    // Navigator.pop(context);
                                    // Navigator.pop(context);
                                    showUploadMessage(
                                        context, 'Order Confirmed...');
                                    Navigator.pop(context);
                                  } finally {
                                    setState(() => _loadingButton2 = false);
                                  }
                                  // }else{
                                  //   showUploadMessage(context, 'PLEASE SELECT THE PAYMENT METHOD');
                                  // }
                                },
                                text: 'Accept',
                                options: FFButtonOptions(
                                  width: 130,
                                  height: 45,
                                  color: const Color(0xFF04C130),
                                  textStyle: FlutterFlowTheme.subtitle2.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.green,
                                  ),
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: 12,
                                ),
                                loading: _loadingButton2, icon: Icon(Icons.arrow_forward_sharp), iconData: Icons.arrow_right_alt_outlined,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}
