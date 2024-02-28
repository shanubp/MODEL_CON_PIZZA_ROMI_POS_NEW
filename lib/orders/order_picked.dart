
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:awafi_pos/Branches/branches.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awafi_pos/flutter_flow/upload_media.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as im;
import '../main.dart';
import '../product_card.dart';

class PickedOrdersWidget extends StatefulWidget {
  final String orderId;
  const PickedOrdersWidget({Key? key, required this.orderId}) : super(key: key);

  @override
  _PickedOrdersWidgetState createState() => _PickedOrdersWidgetState();
}

class _PickedOrdersWidgetState extends State<PickedOrdersWidget> {
  bool _loadingButton = false;
  TextEditingController paidCashOrder = TextEditingController();
  TextEditingController paidBankOrder = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController discountVale = TextEditingController();
  TextEditingController amex = TextEditingController();
  TextEditingController mada = TextEditingController();
  TextEditingController visa = TextEditingController();
  TextEditingController master = TextEditingController();
  bool cash=false;
  bool lunch=false;
  double amexPaid=0;
  double masterPaid=0;
  double visaPaid=0;
  double madaPaid=0;
  bool tape=false;
  String? currentWaiterOnline;

  final scaffoldKey = GlobalKey<ScaffoldState>();
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
  List billItem=[];
  String pin='';
  TextEditingController deliveryPin= TextEditingController();

  getCreditDetailes(String mobileNo) async {
    FirebaseFirestore.
    instance.collection('creditUsers')
        .where("deleted",isEqualTo:false )
        .where("branchId",isEqualTo: currentBranchId)
        .where("phone",isEqualTo:mobileNo.trim())
        .get()
        .then((value){
      if(value.docs.isNotEmpty){
        credit=value.docs;
        for(var data in credit){
          creditMap[data.id]=data.data();

        }
      }

      setState(() {

      });
    });


  }
  List<int> bytes = [];
  List<int> kotBytes = [];
  abc(int invNo,List items,int token,String tableName, double pc,double pb, double balance, double netTotal, double discount1, double totalSum, ) async {
 //abc(invoiceNo, billItem, token,data[0]['table'],double.tryParse(paidCashOrder.text)??0,double.tryParse(paidBankOrder.text)??0,balance??0,netTotal,double.tryParse(discountVale.text)??0,totalSum,);

    List test=List.from(items);


    final CapabilityProfile profile = await CapabilityProfile.load();


    final generator = Generator(PaperSize.mm80, profile);
    bytes = [];
    kotBytes=[];
    final Uint8List imgBytes = data!.buffer.asUint8List();
    final im.Image? image = im.decodeImage(imgBytes);
    bytes += generator.imageRaster(image!);
    final im.Image? image1 = im.decodeImage(capturedImage1);
    bytes += generator.imageRaster(image1!);
    capturedImage10= await    screenshotController
        .captureFromWidget(Container(
      color: Colors.white,
      width: printWidth*3,
      child: ListView(
          shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          children:[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Date :', style: TextStyle(color: Colors.black, fontSize: fontSize + 2, fontWeight: FontWeight.w600),),
                Text(DateTime.now().toString().substring(0, 19), style: TextStyle(color: Colors.black, fontSize: fontSize, fontWeight: FontWeight.w600),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                Text('Invoice No:',style: TextStyle(color: Colors.black,fontSize: fontSize+2,fontWeight: FontWeight.w600),),
                Text('$invNo',style: TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
              ],),



          ]
      ),
    )
    );
    final im.Image? image10 = im.decodeImage(capturedImage10);
    bytes += generator.imageRaster(image10!);
    bytes +=generator.text("-------------------------------------------",styles: PosStyles(bold: true,align: PosAlign.center,height: PosTextSize.size2,));

    bytes +=generator.text("TABLE : $tableName",styles: PosStyles(bold: true,align: PosAlign.center,height: PosTextSize.size2,width: PosTextSize.size2));

    bytes +=generator.text("-------------------------------------------",styles: PosStyles(bold: true,align: PosAlign.center,height: PosTextSize.size2,));


    final im.Image? imagehead = im.decodeImage(capturedhead);

    bytes += generator.imageRaster(imagehead!,);

    // final im.Image image13 = im.decodeImage(capturedImage12);
    // bytes += generator.image(image13);

    String itemString = '';
    String itemStringArabic = '';
    String itemTotal = '';
    String itemGrossTotal = '';
    String itemTax = '';
    String addON = '';

    double deliveryCharge = 0;
    double grantTotal = 0;
    double totalAmount = 0;
    String arabic = '';
    String english = '';
    Map<String, dynamic> config = Map();
    List<Widget> itemWidgets=[];
    List<Widget> itemWidgets1=[];

    for (Map<String, dynamic> item in test) {

      double total = double.tryParse(item['price'].toString())! *
          double.tryParse(item['qty'].toString())!;
      double grossTotal = total * 100 / 115;
      double vat = total * 15 / 115;
      newAddOn = item['addOns']??''+item['addLess']??''+item['addMore']??''+item['remove']??'';
      arabic = item['arabicName'];
      english = item['pdtname'];

      grantTotal += total;

      deliveryCharge = item['deliveryCharge'] == null
          ? 0
          : double.tryParse(item['deliveryCharge'].toString())!;
      addON = newAddOn.isEmpty ? '' : newAddOn.toString();
      double price = double.tryParse(item['price'].toString())! * 100 / 115;
      totalAmount += price * double.tryParse(item['qty'].toString())!;


      itemWidgets1.add(
          Container(
              padding: const EdgeInsets.all(1.0),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),

              child: ListView(
                  shrinkWrap: true,
                  children:[
                    Container(
                      width: printWidth*3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0,right: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(english,
                                        // textDirection: TextDirection.rtl,
                                        style:  TextStyle(
                                          fontFamily: 'GE Dinar One Medium',
                                          fontSize: fontSize,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(arabic,
                                        // textDirection: TextDirection.rtl,
                                        style:  const TextStyle(
                                          fontFamily: 'GE Dinar One Medium',
                                          fontSize: 17,
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
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
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
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
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
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
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
                                  width: 45,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
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
                            SizedBox(height: 10,)
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
      if(itemWidgets1.length==itemCount){
        var capturedIm = await screenshotController
            .captureFromWidget(Container(
          width: printWidth*3,

          child: ListView.builder(
              shrinkWrap: true,
              itemCount: itemWidgets1.length,
              itemBuilder: (context, index) {
                return itemWidgets1[index];
              }),
        ));

        final im.Image? image2 = im.decodeImage(capturedIm);
        bytes += generator.imageRaster(image2!);
        itemWidgets1=[];
      }

      itemTotal += (totalAmount * ((100 + gst) / 100) -
          (double.tryParse(discount.toString()) ?? 0))
          .toStringAsFixed(2);
      itemGrossTotal += grossTotal.toStringAsFixed(2);
      itemTax += (totalAmount * gst / 100).toStringAsFixed(2);
    }
    if(itemWidgets1.length>0){
      var capturedIm = await screenshotController
          .captureFromWidget(Container(
        width: printWidth*3,

        child: ListView.builder(
            shrinkWrap: true,
            itemCount: itemWidgets1.length,
            itemBuilder: (context, index) {
              return itemWidgets1[index];
            }),
      ));

      final im.Image? image2 = im.decodeImage(capturedIm);
      bytes += generator.imageRaster(image2!);
      itemWidgets1=[];
    }
    List<Widget> itemWidgets2=[];
    itemWidgets.add( Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container( padding: const EdgeInsets.all(1.0),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child:  Center(child: Text('=====================',
              style: TextStyle(color: Colors.black,fontSize: printWidth*.25),))),
        Container(
          padding: const EdgeInsets.all(1.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child:     Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total - الإجمالي     :  ',style:  TextStyle(color: Colors.black,fontSize: fontSize+4,fontWeight: FontWeight.w600),),
              Text(totalAmount.toStringAsFixed(2),style:  TextStyle(color: Colors.black,fontSize: fontSize+4,fontWeight: FontWeight.w600),),
            ],
          ),),
        Container(padding: const EdgeInsets.all(1.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child:      Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('VAT -  رقم ضريبة  :   ',style:  TextStyle(color: Colors.black,fontSize: fontSize+4,fontWeight: FontWeight.w600),),
              Text((totalAmount * gst / 100).toStringAsFixed(2),style:  TextStyle(color: Colors.black,fontSize: fontSize+4,fontWeight: FontWeight.w600),),
            ],
          ),),
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
        Container(
          padding: const EdgeInsets.all(1.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Discount -  خصم  : ', style: TextStyle(color: Colors.black, fontSize: fontSize+4, fontWeight: FontWeight.w600),),
              Text((discount1 == null ? "0.00" : discount1.toStringAsFixed(2)), style: TextStyle(color: Colors.black, fontSize: fontSize+4, fontWeight: FontWeight.w600),),

            ],
          ),),
        Container( padding: const EdgeInsets.all(1.0),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child:  Center(child: Text('-------------------------------------------',
              style: TextStyle(color: Colors.black,fontSize: printWidth*.25),))),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child:     Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text('NET - المجموع الإجمالي  : ',style:  TextStyle(color: Colors.black,fontSize: fontSize+7,fontWeight: FontWeight.w700),),
              Text(netTotal.toStringAsFixed(2) ,style:  TextStyle(color: Colors.black,fontSize: fontSize+7,fontWeight: FontWeight.w700),),
            ],
          ),
        ),
        Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child:  Center(child: Text('-------------------------------------------',
              style: TextStyle(color: Colors.black,fontSize: printWidth*.25),))
        ),
        Container(padding: const EdgeInsets.all(1.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Center(
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Cash      :  ${pc.toStringAsFixed(2)}', style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize + 2,
                    fontWeight: FontWeight.w600),),
                Text('Bank      :  ${pb.toStringAsFixed(2)}', style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize + 2,
                    fontWeight: FontWeight.w600),),
                Text('Change :  ${balance.toStringAsFixed(2)}', style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize + 2,
                    fontWeight: FontWeight.w600),),
                // Text('waiter   :  ${currentWaiterOnline}', style: TextStyle(
                //     color: Colors.black,
                //     fontSize: fontSize + 2,
                //     fontWeight: FontWeight.w600),),

              ],
            ),
          ),
        ),
        Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child:  Center(child: Text('-------------------------------------------',
              style: TextStyle(color: Colors.black,fontSize: printWidth*.25),))
        ),
      ],
    ));

    String qrVat = (totalAmount * gst / 100).toStringAsFixed(2);
    String qrTotal = grantTotal.toStringAsFixed(2);
    itemWidgets.add(Container(
      color: Colors.white,
      width: printWidth*2.4,
      height: qrCode + 100,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          QrImageView(
            data: qr(qrVat, qrTotal),
            version: 6,
            size: size/1.5,
          ),
        ],
      ),
    ));



    var capturedImage2 = await screenshotController
        .captureFromWidget(Container(
      width: printWidth*3,

      child: ListView.builder(
          shrinkWrap: true,
          itemCount: itemWidgets.length,
          itemBuilder: (context, index) {
            return itemWidgets[index];
          }),
    ));

    final im.Image? image2 = im.decodeImage(capturedImage2);
    bytes += generator.imageRaster(image2!);
    final im.Image? footer = im.decodeImage(footerImage);
    bytes += generator.imageRaster(footer!,);
    bytes += generator.feed(2);

    bytes += generator.cut();


    try {
      flutterUsbPrinter.write(Uint8List.fromList(bytes));
    }
    catch (error) {
      print(error.toString(),);
    }
    print("end");

  }
  @override
  void initState() {
    super.initState();
    // currentWaiterOnline=null;
    approve=false;
    bankValue="Select";
    dinnerCertificate=false;
    deliveryPin=TextEditingController();
    paidCashOrder = TextEditingController(text: '0.0');
    paidBankOrder = TextEditingController(text: '0.0');
    mobileNo = TextEditingController();
    discountVale = TextEditingController(text: "0.0");
    amex = TextEditingController(text: "0.0");
    mada = TextEditingController(text: "0.0");
    visa = TextEditingController(text: "0.0");
    master = TextEditingController(text: "0.0");

    bankPaid=0;
    cashPaid=0;
    balance=0;
  }
  @override
  void dispose() {
    super.dispose();
    // paidCash.dispose();
    // paidBank.dispose();
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
          int invoiceNo=data[0]['invoiceNo'];
          int token=data[0]['token'];
          var bag=data[0]['salesItems'];
          List addOn=[];


          for(Map<String,dynamic> snap in bag){
            addOn=snap['addOn'];
          }
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.primaryColor,
              automaticallyImplyLeading: true,
              title: Text(
                'Order Details',
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              actions:  const [
                // Padding(
                //   padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                //   child: InkWell(
                //     onTap: () async {
                //       await showDialog(
                //         context: context,
                //         builder: (alertDialogContext) {
                //           return AlertDialog(
                //             title: const Text('dinner sale'),
                //             content: const Text('confirm Dinner Certificate Sale'),
                //             actions: [
                //               TextButton(
                //                 onPressed: () => Navigator.pop(alertDialogContext),
                //                 child: const Text('Cancel'),
                //               ),
                //               TextButton(
                //                 onPressed: () async {
                //                   // setItemWidgets(items);
                //                   dinnerCertificate=true;
                //                   paidCashOrder.text="0";
                //                   paidBankOrder.text="0";
                //                   setState(() {
                //
                //                   });
                //
                //                   Navigator.pop(alertDialogContext);
                //                   showUploadMessage(context, 'Dinner Certifiacate sale Enabled');
                //
                //                 },
                //                 child: Text('Confirm'),
                //               ),
                //             ],
                //           );
                //         },
                //       );
                //     },
                //     child: Container(
                //       height: 35,
                //       decoration: BoxDecoration(
                //           color: dinnerCertificate?Colors.green:Colors.red,
                //           borderRadius: BorderRadius.circular(15),
                //           border: Border.all(
                //               color: Colors.white,width: 2
                //           )
                //       ),
                //       child: Center(
                //         child: Padding(
                //           padding: const EdgeInsets.only(left: 10.0,right: 10),
                //           child: Text(arabicLanguage?"الرمز مسح: ":'Dinner Sale',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(width: 20,),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Container(
                //     height:70 ,
                //     width:150,
                //     decoration: BoxDecoration(
                //
                //         borderRadius: BorderRadius.circular(6),
                //         color: Colors.blue,
                //         border: Border.all(color: Colors.grey)
                //     ),
                //     child: Center(
                //       child: DropdownButton(
                //         borderRadius: BorderRadius.circular(10),
                //         alignment: AlignmentDirectional.centerStart,
                //         underline: Column(),
                //         dropdownColor: Colors.black,
                //         iconEnabledColor: Colors.white,
                //         style: const TextStyle(
                //             color: Colors.white,
                //             fontSize: 18,
                //             fontWeight: FontWeight.w500
                //         ),
                //         value: currentWaiterOnline,
                //         disabledHint: const Text("Waiter",style: TextStyle(
                //             color: Colors.white,
                //             fontSize: 18,
                //             fontWeight: FontWeight.w500
                //         )),
                //         hint: const Text("Waiter",style: TextStyle(
                //             color: Colors.white,
                //             fontSize: 18,
                //             fontWeight: FontWeight.w500
                //         )),
                //         icon: const Icon(
                //           Icons.expand_more,
                //         ),
                //         items: waitersName.map((String names) {
                //           return DropdownMenuItem(
                //             value: names,
                //             child: Text(
                //               names,
                //             ),
                //           );
                //         }).toList(),
                //         onChanged: (String newValue) {
                //           currentWaiterOnline = newValue;
                //           setState(() {
                //
                //           });
                //         },
                //       ),
                //     ),
                //   ),
                //
                // ),
              ],
              centerTitle: true,
              elevation: 0,
            ),
            backgroundColor: const Color(0xFFF5F5F5),
            body: SafeArea(
              child: SingleChildScrollView(
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
                                    const EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
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
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: bag==null?const Center(child: CircularProgressIndicator(),):

                      ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: bag.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context,int index){


                          double? addOnPrice=double.tryParse(bag[index]['addOnPrice'].toString());
                          double? addmorePrice=double.tryParse(bag[index]['addMorePrice'].toString());
                          double? addlessPrice=double.tryParse(bag[index]['addLessPrice'].toString());
                          double? removePrice=double.tryParse(bag[index]['removePrice'].toString());

                          List addOnName=[];
                          List addmoreName=[];
                          List addlessName=[];
                          List removeName=[];

                          List<dynamic> addOn = bag[index]['addOn'];
                          List<dynamic> addLess = bag[index]['addLess'];
                          List<dynamic> addMore = bag[index]['addMore'];
                          List<dynamic> remove = bag[index]['remove'];

                          List<dynamic> arabicAddOn = bag[index]['addOnArabic'];
                          List<dynamic> arabicAddLess = bag[index]['addLessArabic'];
                          List<dynamic> arabicAddMore = bag[index]['addMoreArabic'];
                          List<dynamic> arabicRemove = bag[index]['removeArabic'];


                          if(addOn.isNotEmpty){
                            for(Map<String,dynamic> items in addOn){
                              addOnName.add(items['addOn']);
                              //   addOnPrice+=double.tryParse(items['price']);
                            }
                          }
                          if(remove.isNotEmpty){
                            for(Map<String,dynamic> items in remove){

                              removeName.add(items['addOn']);
                              // removePrice+=double.tryParse(items['price']);
                            }
                          }
                          if(addMore.isNotEmpty){
                            for(Map<String,dynamic> items in addMore){
                              addmoreName.add(items['addOn']);
                              // addmorePrice+=double.tryParse(items['price']);
                            }
                          }
                          if(addLess.isNotEmpty){
                            for(Map<String,dynamic> items in addLess){

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
                            'addOns':addOnName,
                            'addLess': addlessName,
                            'addMore':addmoreName,
                            'remove': removeName,
                            'addOnPrice':addOnPrice,
                            'addMorePrice':addmorePrice,
                            'addLessPrice':addlessPrice,
                            'removePrice':removePrice,
                            'addOnArabic':arabicAddOn,
                            'removeArabic':arabicRemove,
                            'addLessArabic':arabicAddLess,
                            'addMoreArabic':arabicAddMore,
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
                                                  Text(variants.isEmpty?'': ' - ${variants['english']??""}',style: const TextStyle(fontWeight: FontWeight.w600),
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
                    const SizedBox(height: 10,),
                    data[0]['table']=='Home Delivery'?
                    Container(
                      height: 40,width: 150,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black
                          ),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: TextField(
                          controller: deliveryPin,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: const TextStyle(

                            fontSize: 18,
                            fontWeight:
                            FontWeight.normal,
                            color: Colors.black,

                          ),
                          decoration:

                          InputDecoration(
                            contentPadding: EdgeInsets.all(5),
                            fillColor: Colors.white,
                            hintText: 'ENTER DELIVERY PIN',
                            hintStyle:  TextStyle(
                                fontSize: 12,
                                fontWeight:
                                FontWeight.normal,
                                color: Colors.black
                                    .withOpacity(
                                    0.250)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    9),
                                borderSide: const BorderSide(
                                    color: Color
                                        .fromRGBO(
                                        42,
                                        172,
                                        146,
                                        0.0))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    9),
                                borderSide: const BorderSide(
                                    color: Color
                                        .fromRGBO(
                                        42,
                                        172,
                                        146,
                                        0.0))),
                            filled: true,
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(20),
                            //     borderSide: BorderSide(color: Colors.yellow)),
                          ),
                        ),
                      ),
                    )
                        :Container(),
                    SizedBox(height: 10,),
                    Align(
                      alignment: const AlignmentDirectional(0, 1),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 20, 40),
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
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children:  [
                                    Expanded(
                                      child: Text(
                                        arabicLanguage? 'مستخدم الائتمان  :  ':"CREDIT USER  :-",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),

                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width:30,
                                    ),
                                    Container(
                                      height: 45,
                                      width: MediaQuery.of(context).size.width*0.3,
                                      child: TextFormField(

                                        onChanged: (x){
                                          setState(() {
                                            print('value     $x');
                                            getCreditDetailes(x);

                                          });
                                        },
                                        onTap: () {
                                          setState(() {
                                            // keyboard = true;
                                          });
                                        },
                                        controller: mobileNo,
                                            keyboardType:TextInputType.number,
                                            decoration: InputDecoration(
                                            hoverColor: default_color,
                                            hintText: arabicLanguage?'رقمالهتف  :  ':'Mobile NO:',
                                            border:
                                            OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(5.0),
                                            ),
                                            focusedBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors
                                                      .pink.shade900,
                                                  width: 1.0),
                                            ),
                                            contentPadding: EdgeInsets.all(5)
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        // setState(() {
                                        keyboard = false;
                                        FocusScope.of(context)
                                            .unfocus();
                                        taped =true;
                                        if(taped){

                                          if(mobileNo.text!=""&&creditMap!=null&&creditMap.isNotEmpty){

                                            String  credituserId=creditMap.keys.toList()[0];
                                            userMap=creditMap[credituserId];
                                            return showDialog<void>(
                                              context: context,
                                              barrierDismissible: false, // user must tap button!
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text('Credit User'),
                                                  content:  SingleChildScrollView(
                                                    child: ListBody(
                                                      children: [
                                                        Column(
                                                          children: const [
                                                            CircleAvatar(radius: 30,
                                                              child: Icon(Icons.person),),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10,),
                                                        Text('Name        :${userMap["name"]}'),
                                                        Text('Mobile No   :${userMap["phone"]}'),

                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(

                                                      child:  const Text('Cancel',style: TextStyle(color: Colors.red),),
                                                      onPressed: () {
                                                        creditMap={};
                                                        userMap={};
                                                        approve=false;

                                                        paidCashOrder.text="0";
                                                        paidBankOrder.text="0";
                                                        mobileNo.text="";
                                                        setState(() {

                                                        });
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: const Text('Approve'),
                                                      onPressed: () {

                                                        approve=true;

                                                        paidCashOrder.text="0";
                                                        paidBankOrder.text="0";
                                                        setState(() {

                                                        });
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),

                                                  ],
                                                );
                                              },
                                            );
                                          }
                                          else{
                                            showUploadMessage(context, "Please Enter Valid Mobile Number");
                                          }
                                        }
                                        setState(() {

                                        });
                                        // Navigator.pop(context);


                                      },
                                      child: Container(
                                        width: 100,
                                        height: MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.06,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                            BorderRadius.circular(
                                                10)),
                                        child: const Center(
                                          child: Text(
                                            "ENTER",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 30,)

                                  ],
                                ),
                                const SizedBox(height: 5,),


                                Row(
                                  children:  [
                                    Expanded(
                                      child: Text(
                                       "DISCOUNT   :-",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),

                                  ],
                                ),
                                const SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width:30,
                                    ),
                                    Container(
                                      height: 45,
                                      width: MediaQuery.of(context).size.width*0.3,
                                      child: TextFormField(

                                        onChanged: (x){


                                        },


                                        onTap: () {
                                          setState(() {
                                            // keyboard = true;
                                          });
                                        },
                                        controller: discountVale,
                                        keyboardType:TextInputType.number,

                                        decoration: InputDecoration(


                                            hoverColor: default_color,
                                            hintText:'Discount Amount:',
                                            border:
                                            OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(5.0),
                                            ),
                                            focusedBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors
                                                      .pink.shade900,
                                                  width: 1.0),
                                            ),
                                            contentPadding: EdgeInsets.all(5)
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    tape?Container(
                                      width: 100,
                                      height: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.06,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                          BorderRadius.circular(
                                              10)),
                                      child: const Center(
                                        child: Icon(
                                            Icons.verified
                                          // "ENTER",
                                          // style: TextStyle(
                                          //     color: Colors.white,
                                          //     fontWeight:
                                          //     FontWeight.bold,
                                          //     fontSize: 16),
                                        ),
                                      ),
                                    ):InkWell(
                                      onTap: () async {

                                       tape=true;

                                        setState(() {

                                        });
                                        // Navigator.pop(context);


                                      },
                                      child:
                                      Container(
                                        width: 100,
                                        height: MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.06,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                            BorderRadius.circular(
                                                10)),
                                        child: const Center(
                                          child: Text(
                                            "ENTER",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 30,)

                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 50,),
                            approve==true||dinnerCertificate==true?Container(
                              height: 70,
                              width: 150,
                              color: Colors.red,
                              child: Center(child: Text(approve?"CREDIT SALE":"DINNER CERTIFICATE   SALE",style: TextStyle(color: Colors.white),),),
                            ):Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: 450,

                              child: Container(
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: Row(
                                          children: [
                                            SizedBox(width: 10,),
                                            Expanded(
                                              child: SizedBox(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "CASH :",
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                    Container(
                                                      height: 45,
                                                      width:200,
                                                      child: TextFormField(

                                                        onTap: () {

                                                          // double grandTotal=(totalAmount - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0));
                                                          // print(grandTotal);
                                                          double TotalCash=(double.tryParse(data[0]['total'].toString())!- double.tryParse(discountVale.text)!);
                                                          print(TotalCash);

                                                          cashPaid=TotalCash-madaPaid-visaPaid-masterPaid-amexPaid;
                                                          if(cashPaid<0){
                                                            cashPaid=0;
                                                            balance=TotalCash-cashPaid-amexPaid-masterPaid-visaPaid-madaPaid;
                                                          }
                                                          paidCashOrder.text=cashPaid.toStringAsFixed(2);


                                                          setState(() {
                                                            // keyboard = true;
                                                          });
                                                        },
                                                        onChanged: (value){
                                                          // double grandTotal=(totalAmount - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0));
                                                          double TotalCash=(double.tryParse(data[0]['total'].toString())!-double.tryParse(discountVale.text)!);
                                                          cashPaid=double.tryParse(value)??0;
                                                          bankPaid=TotalCash-cashPaid??0;
                                                          if(bankPaid<0){
                                                            bankPaid=0;
                                                          }
                                                          paidBankOrder.text=bankPaid.toString();
                                                          balance=TotalCash-cashPaid-masterPaid-visaPaid-amexPaid-madaPaid;
                                                          setState(() {
                                                            // keyboard = true;
                                                          });
                                                        },
                                                        controller: paidCashOrder,
                                                        keyboardType:
                                                        TextInputType.number,
                                                        decoration: InputDecoration(
                                                          // labelText: 'DISCOUNT',
                                                            hoverColor: default_color,
                                                            hintText: 'Enter Amount',
                                                            border:
                                                            OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(5.0),
                                                            ),
                                                            focusedBorder:
                                                            OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .pink.shade900,
                                                                  width: 1.0),
                                                            ),
                                                            prefixIcon: const Padding(
                                                              padding: EdgeInsets.all(0.0),
                                                              child: Icon(
                                                                Icons.money_outlined,
                                                                color: Colors.grey,
                                                              ), // icon is 48px widget.
                                                            ),
                                                            contentPadding: EdgeInsets.all(5)
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            Expanded(
                                              child: SizedBox(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "BANK :",
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                    // Container(
                                                    //   height: 45,
                                                    //   width:200,
                                                    //   child: TextFormField(
                                                    //
                                                    //     onEditingComplete: () {
                                                    //       FocusScope.of(context)
                                                    //           .unfocus();
                                                    //
                                                    //
                                                    //       setState(() {
                                                    //         keyboard = false;
                                                    //       });
                                                    //     },
                                                    //     onTap: () {
                                                    //
                                                    //       double TotalCash=double.tryParse(data[0]['total'].toString());
                                                    //
                                                    //
                                                    //       bankPaid=TotalCash-cashPaid;
                                                    //       if(bankPaid<0){
                                                    //         bankPaid=0;
                                                    //
                                                    //       }
                                                    //       paidBankOrder.text=bankPaid.toString();
                                                    //
                                                    //
                                                    //       balance=TotalCash-cashPaid-bankPaid;
                                                    //       setState(() {
                                                    //         // keyboard = true;
                                                    //       });
                                                    //     },
                                                    //     onChanged: (value){
                                                    //       print(value);
                                                    //       bankPaid=double.tryParse(value)??0;
                                                    //       // double grandTotal=(totalAmount - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0));
                                                    //       double TotalCash=double.tryParse(data[0]['total'].toString());
                                                    //       cashPaid=TotalCash-bankPaid;
                                                    //       if(cashPaid<0){
                                                    //         cashPaid=0;
                                                    //       }
                                                    //       paidCashOrder.text=cashPaid.toString();
                                                    //       print(bankPaid);
                                                    //       balance=TotalCash-cashPaid-bankPaid;
                                                    //       setState(() {
                                                    //         // keyboard = true;
                                                    //       });
                                                    //     },
                                                    //     controller: paidBankOrder,
                                                    //     keyboardType:
                                                    //     TextInputType.number,
                                                    //     decoration: InputDecoration(
                                                    //       // labelText: 'DISCOUNT',
                                                    //         prefixIcon: const Padding(
                                                    //           padding: EdgeInsets.all(0.0),
                                                    //           child: Icon(
                                                    //             Icons.home_repair_service_rounded,
                                                    //             color: Colors.grey,
                                                    //           ), // icon is 48px widget.
                                                    //         ),
                                                    //         hoverColor: default_color,
                                                    //         hintText: 'Enter Amount',
                                                    //         border:
                                                    //         OutlineInputBorder(
                                                    //           borderRadius:
                                                    //           BorderRadius
                                                    //               .circular(5.0),
                                                    //         ),
                                                    //         focusedBorder:
                                                    //         OutlineInputBorder(
                                                    //           borderSide: BorderSide(
                                                    //               color: Colors
                                                    //                   .pink.shade900,
                                                    //               width: 1.0),
                                                    //         ),
                                                    //         contentPadding: EdgeInsets.all(5)
                                                    //     ),
                                                    //   ),
                                                    // ),




                                                    // Container(
                                                    //     height: 45,
                                                    //     width:200,
                                                    //     // color: Colors.blue,
                                                    //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),
                                                    //       color: Colors.black,
                                                    //     ),
                                                    //     child:  DropdownButton(
                                                    //       borderRadius: BorderRadius.circular(10),
                                                    //       alignment: AlignmentDirectional.centerStart,
                                                    //       underline: Column(),
                                                    //       dropdownColor: Colors.green,
                                                    //       iconEnabledColor: Colors.blue,
                                                    //       style:  const TextStyle(
                                                    //           color: Colors.white,
                                                    //           fontSize: 18,
                                                    //           fontWeight: FontWeight.w500
                                                    //       ),
                                                    //       value: bankValue,
                                                    //       icon: const Padding(
                                                    //         padding: EdgeInsets.only(right: 5),
                                                    //         child: Icon(
                                                    //           Icons.account_balance,
                                                    //           color: Colors.white,
                                                    //
                                                    //         ),
                                                    //       ),
                                                    //       items: bankOptions.map((String items) {
                                                    //         return DropdownMenuItem(
                                                    //           value: items,
                                                    //           child: Text(
                                                    //             items,
                                                    //           ),
                                                    //         );
                                                    //       }).toList(),
                                                    //       onChanged: (String newValue) {
                                                    //         // setItemWidgets(items);
                                                    //         double TotalCash=double.tryParse(data[0]['total'].toString());
                                                    //
                                                    //         double grandTotal=TotalCash;
                                                    //         bankPaid=(grandTotal-cashPaid)??0;
                                                    //         cashPaid=grandTotal-bankPaid;
                                                    //         if(cashPaid<0){
                                                    //           cashPaid=0;
                                                    //         }
                                                    //         paidCashOrder.text=cashPaid.toStringAsFixed(2);
                                                    //         balance=grandTotal-cashPaid-bankPaid;
                                                    //         setState(() {
                                                    //
                                                    //         });
                                                    //
                                                    //
                                                    //
                                                    //
                                                    //
                                                    //
                                                    //         bankValue = newValue;
                                                    //              if(mounted){
                                                    //           setState(() {
                                                    //             // if(dropdownvalue=="Drive-Thru"){
                                                    //             //   deliveryCharge.text=DelCharge.toString();
                                                    //             // }
                                                    //           });
                                                    //         }
                                                    //       },
                                                    //     )
                                                    // ),
                                                    InkWell(
                                                      onTap:(){
                                                        showDialog<void>(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return AlertDialog(
                                                              title: Center(child: Text('Select option')),
                                                              content: StatefulBuilder(
                                                                builder: (BuildContext context, StateSetter setState) {
                                                                  return Container(
                                                                    height: MediaQuery.of(context).size.height*0.5,
                                                                    width: MediaQuery.of(context).size.width*0.4,
                                                                    color: Colors.white,
                                                                    child: ListView(
                                                                      shrinkWrap: true,
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsets.all(8.0),
                                                                          child: Container(
                                                                            child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                children:[
                                                                                  Container(
                                                                                      height: MediaQuery.of(context).size.height*0.05,
                                                                                      width:MediaQuery.of(context).size.width*0.07,
                                                                                      child: Center(
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                                            children: [
                                                                                              Container(
                                                                                                height:MediaQuery.of(context).size.height*0.180,
                                                                                                width:MediaQuery.of(context).size.width*0.070,
                                                                                                decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/american express.png"),fit: BoxFit.cover),),
                                                                                              )
                                                                                            ],
                                                                                          )
                                                                                      )
                                                                                  ),
                                                                                  Container(
                                                                                    height:MediaQuery.of(context).size.height*0.070,
                                                                                    width:MediaQuery.of(context).size.width*0.160,
                                                                                    child: Center(
                                                                                      child: TextFormField(

                                                                                        onTap: () {
                                                                                          // setItemWidgets(items);
                                                                                          double grandTotal=(double.tryParse(data[0]['total'].toString())!-double.tryParse(discountVale.text)!);



                                                                                          amexPaid=   grandTotal-cashPaid-madaPaid-visaPaid-masterPaid??0;
                                                                                          if(amexPaid<0){
                                                                                            amexPaid=0;

                                                                                          }
                                                                                          amex.text=amexPaid.toStringAsFixed(1);


                                                                                          balance=grandTotal-cashPaid-amexPaid-masterPaid-visaPaid-madaPaid;
                                                                                          setState(() {

                                                                                          }
                                                                                          );
                                                                                        },
                                                                                        onChanged: (value){
                                                                                          // print(value);
                                                                                          amexPaid=double.tryParse(value)??0;
                                                                                          double grandTotal=(double.tryParse(data[0]['total'].toString())!-double.tryParse(discountVale.text)!);
                                                                                          bankPaid=grandTotal-cashPaid??0;

                                                                                          cashPaid=grandTotal-madaPaid-masterPaid-visaPaid-amexPaid;
                                                                                          if(cashPaid<0){
                                                                                            cashPaid=0;
                                                                                          }
                                                                                          paidCashOrder.text=cashPaid.toStringAsFixed(1);
                                                                                          // print(bankPaid);
                                                                                          balance=grandTotal-cashPaid-madaPaid-masterPaid-visaPaid-amexPaid;
                                                                                          setState(() {
                                                                                            // keyboard = true;
                                                                                          });
                                                                                        },
                                                                                        controller: amex,
                                                                                        keyboardType:
                                                                                        TextInputType.number,
                                                                                        decoration: InputDecoration(
                                                                                          // labelText: 'DISCOUNT',
                                                                                            hoverColor: default_color,
                                                                                            hintText:arabicLanguage?'نقدأ':"Cash ",
                                                                                            border:
                                                                                            OutlineInputBorder(
                                                                                              borderRadius:
                                                                                              BorderRadius
                                                                                                  .circular(5.0),
                                                                                            ),
                                                                                            focusedBorder:
                                                                                            OutlineInputBorder(
                                                                                              borderSide: BorderSide(
                                                                                                  color: Colors
                                                                                                      .pink.shade900,
                                                                                                  width: 1.0),
                                                                                            ),
                                                                                            prefixIcon: const Padding(
                                                                                              padding: EdgeInsets.all(0.0),
                                                                                              child: Icon(
                                                                                                Icons.money_outlined,
                                                                                                color: Colors.grey,
                                                                                              ), // icon is 48px widget.
                                                                                            ),
                                                                                            contentPadding: EdgeInsets.all(5)
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),


                                                                                ]
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.all(8.0),
                                                                          child: Container(
                                                                            child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                children:[
                                                                                  Container(
                                                                                      height: MediaQuery.of(context).size.height*0.05,
                                                                                      width:MediaQuery.of(context).size.width*0.07,
                                                                                      child: Center(
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                                            children: [
                                                                                              Container(
                                                                                                height:MediaQuery.of(context).size.height*0.180,
                                                                                                width:MediaQuery.of(context).size.width*0.070,
                                                                                                decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/mada.png"),fit: BoxFit.contain),),
                                                                                              )
                                                                                            ],
                                                                                          )
                                                                                      )
                                                                                  ),
                                                                                  Container(
                                                                                    height:MediaQuery.of(context).size.height*0.070,
                                                                                    width:MediaQuery.of(context).size.width*0.160,
                                                                                    child: Center(
                                                                                      child: TextFormField(

                                                                                        onTap: () {
                                                                                          // setItemWidgets(items);
                                                                                          double grandTotal=(double.tryParse(data[0]['total'].toString())!-double.tryParse(discountVale.text)!);
                                                                                          // print(grandTotal);


                                                                                          madaPaid=   grandTotal-cashPaid-amexPaid-visaPaid-masterPaid??0;
                                                                                          if(madaPaid<0){
                                                                                            madaPaid=0;

                                                                                          }
                                                                                          mada.text=madaPaid.toStringAsFixed(1);


                                                                                          balance=grandTotal-cashPaid-madaPaid;
                                                                                          setState(() {
                                                                                            // keyboard = true;
                                                                                          }
                                                                                          );
                                                                                        },
                                                                                        onChanged: (value){
                                                                                          // print(value);
                                                                                          madaPaid=double.tryParse(value)??0;
                                                                                          double grandTotal=(double.tryParse(data[0]['total'].toString())!-double.tryParse(discountVale.text)!);
                                                                                          bankPaid=grandTotal-cashPaid??0;

                                                                                          cashPaid=grandTotal-madaPaid-masterPaid-visaPaid-amexPaid;
                                                                                          if(cashPaid<0){
                                                                                            cashPaid=0;
                                                                                          }
                                                                                          paidCashOrder.text=cashPaid.toStringAsFixed(1);
                                                                                          // print(bankPaid);
                                                                                          balance=grandTotal-cashPaid-madaPaid-masterPaid-visaPaid-amexPaid;
                                                                                          setState(() {

                                                                                          });
                                                                                        },
                                                                                        controller: mada,
                                                                                        keyboardType:
                                                                                        TextInputType.number,
                                                                                        decoration: InputDecoration(
                                                                                          // labelText: 'DISCOUNT',
                                                                                            hoverColor: default_color,
                                                                                            hintText:arabicLanguage?'نقدأ':"Cash ",
                                                                                            border:
                                                                                            OutlineInputBorder(
                                                                                              borderRadius:
                                                                                              BorderRadius
                                                                                                  .circular(5.0),
                                                                                            ),
                                                                                            focusedBorder:
                                                                                            OutlineInputBorder(
                                                                                              borderSide: BorderSide(
                                                                                                  color: Colors
                                                                                                      .pink.shade900,
                                                                                                  width: 1.0),
                                                                                            ),
                                                                                            prefixIcon: const Padding(
                                                                                              padding: EdgeInsets.all(0.0),
                                                                                              child: Icon(
                                                                                                Icons.money_outlined,
                                                                                                color: Colors.grey,
                                                                                              ), // icon is 48px widget.
                                                                                            ),
                                                                                            contentPadding: EdgeInsets.all(5)
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),


                                                                                ]
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.all(8.0),
                                                                          child: Container(
                                                                            child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                children:[
                                                                                  Container(
                                                                                      height: MediaQuery.of(context).size.height*0.05,
                                                                                      width:MediaQuery.of(context).size.width*0.07,
                                                                                      child: Center(
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                                            children: [
                                                                                              Container(
                                                                                                height:MediaQuery.of(context).size.height*0.180,
                                                                                                width:MediaQuery.of(context).size.width*0.070,
                                                                                                decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/MasterCard.png"),fit: BoxFit.contain),),
                                                                                              )
                                                                                            ],
                                                                                          )
                                                                                      )
                                                                                  ),
                                                                                  Container(
                                                                                    height:MediaQuery.of(context).size.height*0.070,
                                                                                    width:MediaQuery.of(context).size.width*0.160,
                                                                                    child: Center(
                                                                                      child: TextFormField(

                                                                                        onTap: () {
                                                                                          // setItemWidgets(items);
                                                                                          double grandTotal=(double.tryParse(data[0]['total'].toString())!-double.tryParse(discountVale.text)!);
                                                                                          // print(grandTotal);


                                                                                          masterPaid=   grandTotal-cashPaid-amexPaid-visaPaid-madaPaid??0;
                                                                                          if(masterPaid<0){
                                                                                            masterPaid=0;

                                                                                          }
                                                                                          master.text=masterPaid.toStringAsFixed(1);


                                                                                          balance=grandTotal-cashPaid-madaPaid-masterPaid-visaPaid-amexPaid;
                                                                                          setState(() {
                                                                                            // keyboard = true;
                                                                                          }
                                                                                          );
                                                                                        },
                                                                                        onChanged: (value){
                                                                                          // print(value);
                                                                                          masterPaid=double.tryParse(value)??0;
                                                                                          double grandTotal=(double.tryParse(data[0]['total'].toString())!-double.tryParse(discountVale.text)!);
                                                                                          bankPaid=grandTotal-cashPaid??0;

                                                                                          cashPaid=grandTotal-madaPaid-masterPaid-visaPaid-amexPaid;
                                                                                          if(cashPaid<0){
                                                                                            cashPaid=0;
                                                                                          }
                                                                                          paidCashOrder.text=cashPaid.toStringAsFixed(1);
                                                                                          // print(bankPaid);
                                                                                          balance=grandTotal-cashPaid-madaPaid-masterPaid-visaPaid-amexPaid;
                                                                                          setState(() {

                                                                                          });
                                                                                        },
                                                                                        controller: master,
                                                                                        keyboardType:
                                                                                        TextInputType.number,
                                                                                        decoration: InputDecoration(
                                                                                          // labelText: 'DISCOUNT',
                                                                                            hoverColor: default_color,
                                                                                            hintText:arabicLanguage?'نقدأ':"Cash ",
                                                                                            border:
                                                                                            OutlineInputBorder(
                                                                                              borderRadius:
                                                                                              BorderRadius
                                                                                                  .circular(5.0),
                                                                                            ),
                                                                                            focusedBorder:
                                                                                            OutlineInputBorder(
                                                                                              borderSide: BorderSide(
                                                                                                  color: Colors
                                                                                                      .pink.shade900,
                                                                                                  width: 1.0),
                                                                                            ),
                                                                                            prefixIcon: const Padding(
                                                                                              padding: EdgeInsets.all(0.0),
                                                                                              child: Icon(
                                                                                                Icons.money_outlined,
                                                                                                color: Colors.grey,
                                                                                              ), // icon is 48px widget.
                                                                                            ),
                                                                                            contentPadding: EdgeInsets.all(5)
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),


                                                                                ]
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.all(8.0),
                                                                          child: Container(
                                                                            child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                children:[
                                                                                  Container(
                                                                                      height: MediaQuery.of(context).size.height*0.05,
                                                                                      width:MediaQuery.of(context).size.width*0.07,
                                                                                      child: Center(
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                                            children:  [
                                                                                              Container(
                                                                                                height:MediaQuery.of(context).size.height*0.180,
                                                                                                width:MediaQuery.of(context).size.width*0.070,
                                                                                                decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/visa.png"),fit: BoxFit.contain),),
                                                                                              )
                                                                                            ],
                                                                                          )
                                                                                      )
                                                                                  ),
                                                                                  Container(
                                                                                    height:MediaQuery.of(context).size.height*0.070,
                                                                                    width:MediaQuery.of(context).size.width*0.160,
                                                                                    child: Center(
                                                                                      child: TextFormField(

                                                                                        onTap: () {
                                                                                          // setItemWidgets(items);
                                                                                          double grandTotal=(double.tryParse(data[0]['total'].toString())!-double.tryParse(discountVale.text)!);
                                                                                          // print(grandTotal);


                                                                                          visaPaid=   grandTotal-cashPaid-amexPaid-masterPaid-madaPaid??0;
                                                                                          if(visaPaid<0){
                                                                                            visaPaid=0;

                                                                                          }
                                                                                          visa.text=visaPaid.toStringAsFixed(1);


                                                                                          balance=grandTotal-cashPaid-madaPaid-masterPaid-visaPaid-amexPaid;
                                                                                          setState(() {
                                                                                            // keyboard = true;
                                                                                          }
                                                                                          );
                                                                                        },
                                                                                        onChanged: (value){
                                                                                          // print(value);
                                                                                          visaPaid=double.tryParse(value)??0;
                                                                                          double grandTotal=(double.tryParse(data[0]['total'].toString())!-double.tryParse(discountVale.text)!);
                                                                                          bankPaid=grandTotal-cashPaid??0;

                                                                                          cashPaid=grandTotal-madaPaid-masterPaid-visaPaid-amexPaid;
                                                                                          if(visaPaid<0){
                                                                                            visaPaid=0;
                                                                                          }
                                                                                          paidCashOrder.text=cashPaid.toStringAsFixed(1);
                                                                                          // print(bankPaid);
                                                                                          balance=grandTotal-cashPaid-madaPaid-masterPaid-visaPaid-amexPaid;
                                                                                          setState(() {

                                                                                          });
                                                                                        },
                                                                                        controller: visa,
                                                                                        keyboardType:
                                                                                        TextInputType.number,
                                                                                        decoration: InputDecoration(
                                                                                          // labelText: 'DISCOUNT',
                                                                                            hoverColor: default_color,
                                                                                            hintText:"Amount",
                                                                                            border:
                                                                                            OutlineInputBorder(
                                                                                              borderRadius:
                                                                                              BorderRadius
                                                                                                  .circular(5.0),
                                                                                            ),
                                                                                            focusedBorder:
                                                                                            OutlineInputBorder(
                                                                                              borderSide: BorderSide(
                                                                                                  color: Colors
                                                                                                      .pink.shade900,
                                                                                                  width: 1.0),
                                                                                            ),
                                                                                            prefixIcon: const Padding(
                                                                                              padding: EdgeInsets.all(0.0),
                                                                                              child: Icon(
                                                                                                Icons.money_outlined,
                                                                                                color: Colors.grey,
                                                                                              ), // icon is 48px widget.
                                                                                            ),
                                                                                            contentPadding: EdgeInsets.all(5)
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),


                                                                                ]
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(height: 20,),
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                          children: [
                                                                            ElevatedButton(onPressed: (){
                                                                              Navigator.pop(context);
                                                                              mada.text="0.0";
                                                                              master.text="0.0";
                                                                              visa.text="0.0";
                                                                              amex.text="0.0";
                                                                              madaPaid=0;
                                                                              visaPaid=0;
                                                                              masterPaid=0;
                                                                              amexPaid=0;
                                                                              balance=0;
                                                                            }, child: Text("CANCEL")),
                                                                            ElevatedButton(onPressed: (){
                                                                              Navigator.pop(context);
                                                                            }, child: Text("OK")),

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
                                                        height: 45,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(6),
                                                          color: Colors.blue,

                                                        ),
                                                        child: const Center(child: Text("OPTIONS",style: TextStyle(
                                                            color: Colors.white
                                                        ),)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10,),



                                          ],
                                        ),
                                      ),
                                    ),

                                    Container(
                                      height:MediaQuery.of(context).size.height * 0.05,
                                      child: Center(child: Text('Balance : ${balance.toStringAsFixed(2)}',style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17
                                      ),)),
                                    )

                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 30,),
                            // Container(
                            //   width: MediaQuery.of(context).size.width*0.1,
                            //   height: 50,
                            //   child: Row(
                            //     children: [
                            //       Text('Cash',style: TextStyle(
                            //           fontWeight: FontWeight.bold,
                            //           color: Colors.black,
                            //           fontSize: 17
                            //       ),
                            //       ),
                            //       Checkbox(
                            //         value: cash,
                            //         onChanged: (value) {
                            //           setState(() {
                            //             cash = !cash;
                            //             if(cash==true){
                            //               lunch=false;
                            //             }
                            //           });
                            //         },
                            //       ),
                            //
                            //     ],
                            //   ),
                            // ),
                            // Container(
                            //   width: MediaQuery.of(context).size.width*0.1,
                            //   height: 50,
                            //   child: Row(
                            //     children: [
                            //       Text('Bank',style: TextStyle(
                            //           fontWeight: FontWeight.bold,
                            //           color: Colors.black,
                            //           fontSize: 17
                            //       ),
                            //       ),
                            //       Checkbox(
                            //         value: lunch,
                            //         onChanged: (value) {
                            //           setState(() {
                            //             lunch = !lunch;
                            //             if(lunch==true){
                            //               cash=false;
                            //             }
                            //
                            //           });
                            //         },
                            //       ),
                            //
                            //     ],
                            //   ),
                            // ),
                            FFButtonWidget(
                              onPressed: () async {

                                  if(double.tryParse(paidCashOrder.text)!
                                      >0 ||double.tryParse(amex.text)!>0
                                      ||double.tryParse(visa.text)!>0||
                                      double.tryParse(master.text)!>0||

                                      double.tryParse(mada.text)!>0||
                                      dinnerCertificate==true||approve==true) {

                                    // if(currentWaiterOnline!=null){


                                      setState(() => _loadingButton = true);
                                      // if(data[0]['table']=='Home Delivery'){
                                      //   log('TRUEEE');
                                      //   try {
                                      //     pin=data[0]['deliveryPin'];
                                      //     if(deliveryPin.text!=''&&deliveryPin.text==pin.toString()){
                                      //       DocumentSnapshot order=data[0];
                                      //       order.reference.update({
                                      //         // 'cash':cash==true?true:false,
                                      //         'currentUserId':currentUserId,
                                      //         'status':2,
                                      //         'DeliveredTime':DateTime.now(),
                                      //       });
                                      //       Navigator.pop(context);
                                      //       showUploadMessage(context, ' Order Delivered');
                                      //     }else{
                                      //       deliveryPin.text==''?
                                      //       showUploadMessage(context, 'Please Enter Delivery Pin'):
                                      //       showUploadMessage(context, 'Wrong Delivery Pin');
                                      //     }
                                      //   } finally {
                                      //     setState(() => _loadingButton = false);
                                      //   }
                                      //
                                      // }elseif(data[0]['table']!='Home Delivery'){
                                      // double  netTotal=  dinnerCertificate?0.00:(double.tryParse(paidCashOrder.text??0) +(double.tryParse(paidBankOrder.text??0)));
                                      double  netTotal=  dinnerCertificate?0.00:(double.tryParse(data[0]['total']))!-double.tryParse(discountVale.text)!;
                                      double totalSum=(double.tryParse(data[0]['total']))!- double.tryParse(discountVale.text)!;
                                      // double  bankPaid1=totalSum-double.tryParse(paidCashOrder.text);
                                      double  bankPaid1=amexPaid+visaPaid+madaPaid+masterPaid;

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

                                      List<String> ingredientIds = [];
                                      for (var a in items) {
                                        for (var b in a['ingredients'] ?? []) {
                                          ingredientIds.add(b['ingredientId']);
                                        }
                                      }


                                      DocumentSnapshot order=data[0];
                                      order.reference.update({

                                        'currentUserId':currentUserId,
                                         // 'status':2,
                                        'DeliveredTime':DateTime.now(),
                                      });


                                      // }
                                      print(billItem.length);
                                      abc(invoiceNo, billItem, token,data[0]['table'],double.tryParse(paidCashOrder.text)??0,bankPaid1??0,balance??0,netTotal,double.tryParse(discountVale.text)??0,totalSum,);
                                      FirebaseFirestore.instance
                                          .collection("sales")
                                          .doc(currentBranchId)
                                          .collection("sales")
                                          .doc(data[0]['invoiceNo'].toString())
                                          .update({
                                        'currentUserId': currentUserId,
                                        'salesDate': DateTime.now(),
                                        'invoiceNo': invoiceNo,
                                        'token': token,
                                        'currentBranchId': currentBranchId,
                                        'currentBranchPhNo': currentBranchPhNo,
                                        'currentBranchAddress': currentBranchAddress,
                                        'currentBranchArabic': currentBranchAddressArabic,
                                        'deliveryCharge': double.tryParse(delivery) ?? 0,
                                        'table': selectedTable,
                                        // 'billItems': billItem,
                                        // 'discount': double.tryParse(discount) ?? 0,
                                        'totalAmount': totalAmount * 100 / (100 + gst),
                                        'tax': totalAmount * gst / (100 + gst),
                                        'paidCash': double.tryParse(paidCashOrder.text) ?? 0,
                                        'paidBank': approve||dinnerCertificate?0:bankPaid1 ?? 0,
                                        'cash': approve?false:paidCashOrder.text==''|| paidCashOrder.text=='0.0'||paidCashOrder.text=='0.0'||paidCashOrder.text==null||dinnerCertificate?false:true ,
                                        'bank': approve==true||dinnerCertificate==true?false:bankPaid1>0?true:false,
                                        'balance': balance,
                                        "ingredientIds": ingredientIds,
                                        'creditSale':approve?true:false,
                                        "creditName":approve?userMap["name"]:""??'',
                                        "creditNumber":approve?userMap["phone"]:""??'',
                                        "AMEX":amex.text!="0"&&amex.text!="0.0"&&amex.text!=""&&amex.text!=null?true:false,
                                        "VISA":visa.text!="0"&&visa.text!="0.0"&&visa.text!=""&&visa.text!=null?true:false,
                                        "MASTER":master.text!="0"&&master.text!="0.0"&&master.text!=""&&master.text!=null?true:false,
                                        "MADA":mada.text!="0"&&mada.text!="0.0"&&mada.text!=""&&mada.text!=null?true:false,
                                        "dinnerCertificate":dinnerCertificate?true:false,
                                        "amexAmount":double.tryParse(amex.text),
                                        "madaAmount":double.tryParse(mada.text),
                                        "visaAmount":double.tryParse(visa.text),
                                        "masterAmount":double.tryParse(master.text),
                                        "discount":double.tryParse(discountVale.text),
                                        'grandTotal': totalSum,
                                        // "waiterName":currentWaiterOnline
                                      });
                                      setState(() {
                                        creditMap={};
                                        userMap={};
                                        approve=false;
                                        amexPaid=0;
                                        masterPaid=0;
                                        visaPaid=0;
                                        madaPaid=0;

                                        amex.text="0";
                                        visa.text="0";
                                        master.text="0";
                                        mada.text="0";
                                        currentWaiterOnline=null;
                                        balance=0;
                                        Navigator.pop(context);

                                        showUploadMessage(context, ' Order Delivered');
                                      });

                                }
                                  else{
                                    showUploadMessage(context, "PLEASE CHOOSE PAYMENT METHOD");
                                  }



                              },
                              text: 'FINAL INVOICE',
                              options: FFButtonOptions(
                                width:160,
                                height: 45,
                                color: const Color(0xFF04C130),
                                textStyle: FlutterFlowTheme.subtitle2.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: 12,
                              ),
                              loading: _loadingButton, icon: Icon(Icons.print), iconData: Icons.print,
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width*0.1,)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
