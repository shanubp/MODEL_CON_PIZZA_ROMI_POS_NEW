
import 'dart:typed_data';
import 'package:awafi_pos/DailyReport/ProductReport.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awafi_pos/Branches/branches.dart';
import 'package:awafi_pos/main.dart';
import 'package:awafi_pos/orders/orders_widget.dart';
import 'package:awafi_pos/reports/expense_reports.dart';
import 'package:awafi_pos/reports/purchase_reports.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import '../flutter_flow/upload_media.dart';
import '../modals/Print/pdf_api.dart';
import 'categoryReport.dart';
import 'creditReport.dart';
import 'genaratePDF/CardReportModel.dart';
import 'genaratePDF/cardPdf.dart';
import 'genaratePDF/dailyReport_model.dart';
import 'genaratePDF/pdfPage.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:image/image.dart' as im;


import 'ingredient_report.dart';

class DailyReportsWidget extends StatefulWidget {
  DailyReportsWidget({Key? key}) : super(key: key);


  @override
  _DailyReportsWidgetState createState() => _DailyReportsWidgetState();
}



class _DailyReportsWidgetState extends State<DailyReportsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ScreenshotController screenshotController = ScreenshotController();
  List salesData=[];
  List cardSale=[];
  var capturedImage1;
  Timestamp? datePicked1;
  Timestamp? datePicked2;
  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
  double totalvat=0;
  
  List<int> bytes=[];
  List<int> kotBytes=[];
  abc(List items) async {
    final CapabilityProfile profile = await CapabilityProfile.load();

    final generator = Generator(PaperSize.mm80, profile);
    bytes = [];



    bytes += generator.text('Sales Reports', styles: const PosStyles(align: PosAlign.center,underline: false));
    bytes+=generator.feed(2);
    bytes += generator.text('From ${DateFormat("dd-MM-yyyy hh:mm aaa").format(selectedFromDate)} To ${DateFormat("dd-MM-yyyy hh:mm aaa").format(selectedOutDate)}', styles: PosStyles(align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size1,underline: false));
    bytes+=generator.feed(2);
    bytes += generator.text('................................................', styles: const PosStyles(align: PosAlign.center,underline: false));
    bytes+=generator.feed(1);
    // bytes += generator.text('No    Bill No    Amt', styles: const PosStyles(align: PosAlign.center,underline: false));
    bytes += generator.row([
      PosColumn(text:"NO",styles: PosStyles(bold: true,align: PosAlign.left,height: PosTextSize.size1,width: PosTextSize.size1),width: 4),
      PosColumn(text:"BILL NO",styles: PosStyles(bold: true,align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size1),width: 4),
      PosColumn(text:"AMOUNT",styles: PosStyles(bold: true,align: PosAlign.right,height: PosTextSize.size1,width: PosTextSize.size1),width: 4),
    ]);
    bytes += generator.text('................................................', styles: const PosStyles(align: PosAlign.center,underline: false));
    int i=1;
    double total=0;
    for(var data in items){
      bytes += generator.row([
        PosColumn(text:"$i",styles: PosStyles(bold: true,align: PosAlign.left,height: PosTextSize.size1,width: PosTextSize.size1),width: 4),
        PosColumn(text:"${data['no']}",styles: PosStyles(bold: true,align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size1),width: 4),
        PosColumn(text:"${data['amount'].toStringAsFixed(2)}",styles: PosStyles(bold: true,align: PosAlign.right,height: PosTextSize.size1,width: PosTextSize.size1),width: 4),
      ]);
      bytes+=generator.feed(1);
      total+=data['amount'];

      i++;
    }
    bytes += generator.text('................................................', styles: PosStyles(align: PosAlign.center,underline: false));

    bytes +=generator.text('Total : ${total.toStringAsFixed(2)}',styles: const PosStyles(align: PosAlign.center));
    bytes +=generator.text('Cerdit Sale : ${totalCreditSales.toStringAsFixed(2)}',styles: const PosStyles(align: PosAlign.center));
    // bytes +=generator.text('Dinner Certificate Sale : ${totalDinnerSaleAmount.toStringAsFixed(2)}',styles: const PosStyles(align: PosAlign.center));
    
    bytes += generator.text('Balance : ${((totalSales-totalPurchase-totalExp)-(totalCreditSales)).toStringAsFixed(2)}', styles: PosStyles(align: PosAlign.center,underline: false));

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
  // daily_user_report(posUsers,name,cash ,bank,total, UID,arabicName)async{
  //   final CapabilityProfile profile = await CapabilityProfile.load();
  //   final generator = Generator(PaperSize.mm80, profile);
  //   bytes = [];
  //   bytes += generator.text('Sales Reports ', styles: const PosStyles(align: PosAlign.center,underline: false));
  //   bytes+=generator.feed(2);
  //   bytes += generator.text('From ${DateFormat("dd-MM-yyyy hh:mm aaa").format(selectedFromDate)} To ${DateFormat("dd-MM-yyyy hh:mm aaa").format(selectedOutDate)}', styles: PosStyles(align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size1,underline: false));
  //   bytes+=generator.feed(2);
  //   ScreenshotController screenshotController = ScreenshotController();
  //   var  capturedImage1= await    screenshotController
  //       .captureFromWidget(Container(
  //       color: Colors.white,
  //       width: printWidth*2,
  //       height: 55,
  //       child:
  //       Column(
  //         mainAxisAlignment:MainAxisAlignment.center,
  //         children: [
  //           Text('CASHIER : $name',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
  //             Text(' $arabicName  : المحاسب ''  المحاسب :$arabicName ',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
  //
  //         ],)));
  //   final im.Image? image1 = im.decodeImage(capturedImage1);
  //   bytes += generator.image(image1!,);
  //   bytes += generator.text('................................................', styles: const PosStyles(align: PosAlign.center,underline: false));
  //   bytes+=generator.feed(1);
  //   // bytes += generator.text('No    Bill No    Amt', styles: const PosStyles(align: PosAlign.center,underline: false));
  //   bytes += generator.row([
  //     PosColumn(text:"NO",styles: PosStyles(bold: true,align: PosAlign.left,height: PosTextSize.size1,width: PosTextSize.size1),width: 4),
  //     PosColumn(text:"BILL NO",styles: PosStyles(bold: true,align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size1),width: 4),
  //     PosColumn(text:"AMOUNT",styles: PosStyles(bold: true,align: PosAlign.right,height: PosTextSize.size1,width: PosTextSize.size1),width: 4),
  //   ]);
  //   bytes += generator.text('................................................', styles: const PosStyles(align: PosAlign.center,underline: false));
  //   int i=0;
  //   double total=0;
  //   for(var data in sale){
  //     if (data.get('currentUserId') == UID) {
  //       i++;
  //       bytes += generator.row([
  //         PosColumn(text:"$i",styles: PosStyles(bold: true,align: PosAlign.left,height: PosTextSize.size1,width: PosTextSize.size1),width: 4),
  //         PosColumn(text:"${data['invoiceNo']}",styles: PosStyles(bold: true,align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size1),width: 4),
  //         PosColumn(text:"${data['grandTotal'].toStringAsFixed(2)}",styles: PosStyles(bold: true,align: PosAlign.right,height: PosTextSize.size1,width: PosTextSize.size1),width: 4),
  //       ]);
  //       bytes+=generator.feed(1);
  //       total += data['grandTotal'];
  //     }
  //
  //   }
  //   bytes += generator.text('................................................', styles: PosStyles(align: PosAlign.center,underline: false));
  //   bytes += generator.feed(2);
  //   bytes += generator.text('Cash = $cash', styles: PosStyles(align: PosAlign.center,underline: false));
  //   bytes += generator.text('Bank = $bank', styles: PosStyles(align: PosAlign.center,underline: false));
  //   bytes += generator.text('credit Sale = ${totalCreditSales.toStringAsFixed(2)}', styles: PosStyles(align: PosAlign.center,underline: false));
  //   bytes +=generator.text('Total : ${total.toStringAsFixed(2)}',styles: const PosStyles(align: PosAlign.center));
  //   bytes += generator.feed(2);
  //   // bytes += generator.text('Dinner Sale = ${totalDinnerSaleAmount.toStringAsFixed(2)}', styles: PosStyles(align: PosAlign.center,underline: false));
  //
  //   // bytes +=generator.text('أمير',styles: const PosStyles(align: PosAlign.center));
  //
  //   bytes += generator.feed(2);
  //
  //   bytes += generator.cut();
  //   try {
  //
  //     flutterUsbPrinter.write(Uint8List.fromList(bytes));
  //   }
  //   catch (error) {
  //     print(error.toString(),);
  //   }
  //   print("end");
  //
  // }

  daily_user_report(posUsers, name, cash, bank, total, UID, arabicName) async {
    final CapabilityProfile profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    bytes = [];
    bytes += generator.text('Sales Reports ',
        styles: const PosStyles(align: PosAlign.center, underline: false));
    bytes += generator.text(
        'From ${DateFormat("yyyy-MM-dd hh:mm aaa").format(selectedFromDate)} To ${DateFormat("yyyy-MM-dd hh:mm aaa").format(selectedOutDate)}',
        styles: PosStyles(
            align: PosAlign.center,
            height: PosTextSize.size1,
            width: PosTextSize.size1,
            underline: false));
    // bytes += generator.text('User Name(المحاسب):- $name',styles: const PosStyles(align: PosAlign.center,underline: false));
    ScreenshotController screenshotController = ScreenshotController();
    var capturedImage1 = await screenshotController.captureFromWidget(Container(
        color: Colors.white,
        width: printWidth * 2,
        height: 55,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'CASHIER : $name',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '  المحاسب :$arabicName ',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        )));
    final im.Image image1 = im.decodeImage(capturedImage1)!;
    bytes += generator.imageRaster(
      image1,
    );

    bytes += generator.feed(2);

    bytes += generator.text('................................................',
        styles: const PosStyles(align: PosAlign.center, underline: false));
    bytes += generator.feed(1);
    // bytes += generator.text('No    Bill No    Amt', styles: const PosStyles(align: PosAlign.center,underline: false));
    bytes += generator.row([
      PosColumn(
          text: "NO",
          styles: PosStyles(
              bold: true,
              align: PosAlign.left,
              height: PosTextSize.size1,
              width: PosTextSize.size1),
          width: 4),
      PosColumn(
          text: "BILL NO",
          styles: PosStyles(
              bold: true,
              align: PosAlign.center,
              height: PosTextSize.size1,
              width: PosTextSize.size1),
          width: 4),
      PosColumn(
          text: "AMOUNT",
          styles: PosStyles(
              bold: true,
              align: PosAlign.right,
              height: PosTextSize.size1,
              width: PosTextSize.size1),
          width: 4),
    ]);
    bytes += generator.text('................................................',
        styles: const PosStyles(align: PosAlign.center, underline: false));
    int i = 0;
    double total = 0;
    for (var data in sale) {
      if (data.get('currentUserId') == UID) {
        i++;
        bytes += generator.row([
          PosColumn(
              text: "$i",
              styles: PosStyles(
                  bold: true,
                  align: PosAlign.left,
                  height: PosTextSize.size1,
                  width: PosTextSize.size1),
              width: 4),
          PosColumn(
              text: "${data['invoiceNo']}",
              styles: PosStyles(
                  bold: true,
                  align: PosAlign.center,
                  height: PosTextSize.size1,
                  width: PosTextSize.size1),
              width: 4),
          PosColumn(
              text: "${data['grandTotal'].toStringAsFixed(2)}",
              styles: PosStyles(
                  bold: true,
                  align: PosAlign.right,
                  height: PosTextSize.size1,
                  width: PosTextSize.size1),
              width: 4),
        ]);
        bytes += generator.feed(1);
        total += data['grandTotal'];
      }
    }
    bytes += generator.text('........................',
        styles: PosStyles(align: PosAlign.center, underline: false));
    bytes += generator.text('Cash = $cash',
        styles: PosStyles(align: PosAlign.center, underline: false));
    bytes += generator.text('Bank = $bank',
        styles: PosStyles(align: PosAlign.center, underline: false));
    bytes += generator.text('credit sale = $totalCreditSales',
        styles: PosStyles(align: PosAlign.center, underline: false));

    bytes += generator.text('Total : ${total.toStringAsFixed(2)}',
        styles: const PosStyles(align: PosAlign.center));

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

  dailyPrint() async {
    final CapabilityProfile profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    bytes = [];


    bytes += generator.text('Reports', styles: PosStyles(align: PosAlign.center,underline: false));
    bytes+=generator.feed(2);
    bytes += generator.text('From ${DateFormat("dd-MM-yyyy hh:mm aaa").format(selectedFromDate)} To ${DateFormat("dd-MM-yyyy hh:mm aaa").format(selectedOutDate)}', styles: PosStyles(align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size1,underline: false));
    bytes+=generator.feed(1);
    bytes += generator.text('Sales : ${sale==null?'0':sale.length.toString()}', styles: PosStyles(align: PosAlign.center,underline: false));
    bytes += generator.text('Credit Sale : ${creditSale==null?'0':creditSale.length.toString()}', styles: PosStyles(align: PosAlign.center,underline: false));
    // bytes += generator.text('Dinner Sale : ${dinnerSale==null?'0':dinnerSale.length.toString()}', styles: PosStyles(align: PosAlign.center,underline: false));

    bytes += generator.text('Purchase : ${purchase==null?'0':purchase.length.toString()}', styles: PosStyles(align: PosAlign.center,underline: false));
    bytes += generator.text('Expense : ${expense==null?'0':expense.length.toString()}', styles: PosStyles(align: PosAlign.center,underline: false));
    bytes += generator.text('Return : ${noOfReturn.toString()==null?"0":noOfReturn.toString()}', styles: PosStyles(align: PosAlign.center,underline: false));
    bytes += generator.text('.........................', styles: PosStyles(align: PosAlign.center,underline: false));
    bytes+=generator.feed(1);

    bytes += generator.text('Total Sales : ${totalSales.toStringAsFixed(2)}', styles: PosStyles(align: PosAlign.center,underline: false));
    bytes+=generator.feed(1);

    bytes += generator.text('Credit Sale  : ${totalCreditSales.toStringAsFixed(2)}', styles: PosStyles(align: PosAlign.center,underline: false));
    bytes+=generator.feed(1);

    // bytes += generator.text('Dinner Sale  : ${totalDinnerSaleAmount.toStringAsFixed(2)}', styles: PosStyles(align: PosAlign.center,underline: false));

    bytes+=generator.feed(1);
    bytes += generator.text('Total Purchase : ${totalPurchase.toStringAsFixed(2)}', styles: PosStyles(align: PosAlign.center,underline: false));
    bytes+=generator.feed(1);
    bytes += generator.text('Total Expense : ${totalExp.toStringAsFixed(2)}', styles: PosStyles(align: PosAlign.center,underline: false));
    bytes+=generator.feed(1);
    bytes += generator.text('Total Return : ${returnAmount.toStringAsFixed(2)}', styles: PosStyles(align: PosAlign.center,underline: false));
    bytes+=generator.feed(1);
    bytes += generator.text('Vat Payable : ${(((totVatSale*15/100)-totalvat)-rtnVat).toStringAsFixed(2)}', styles: PosStyles(align: PosAlign.center,underline: false));
    bytes+=generator.feed(1);
    bytes += generator.text('Balance : ${((totalSales-totalPurchase-totalExp)-(totalCreditSales)-(returnAmount)).toStringAsFixed(2)}', styles: PosStyles(align: PosAlign.center,underline: false));
    bytes+= generator.emptyLines(1);
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

  var purchase;
  double totalPurchase=0;
  double totalPurchaseAmount=0;
  double purchaseCash=0;
  double purchaseBank=0;
  getPurchase() async {
    QuerySnapshot purchases =await FirebaseFirestore.instance.collection('purchases')
        .doc(currentBranchId)
        .collection('purchases')
        .where('salesDate', isGreaterThanOrEqualTo:datePicked1)
        .where('salesDate', isLessThanOrEqualTo:datePicked2)
        .get();

    purchase=purchases.docs;
    totalPurchase=0;
    totalvat=0;
    totalPurchaseAmount=0;
    purchaseCash=0;
    purchaseBank=0;
    for(var data in purchases.docs){
      // totalPurchase+=(double.tryParse(data['amount'].toString()))??0+(double.tryParse(data['amount'].toString()))??0;
      totalPurchase+=(double.tryParse(data['amount'].toString()))??0;
      totalvat+=double.tryParse(data['gst'].toString())!;
      if(data.get('cash')==true){
        purchaseCash+=double.tryParse(data.get('amount').toString())!;
      }else{
        purchaseBank+=double.tryParse(data.get('amount').toString())!;
      }
    }

    setState(() {
    });
  }

  var sale;
  double cashInHand=0;
  double cashInBank=0;
  double totalSales=0;
  double totVatSale=0;
  double amexSale=0;
  double madaSale=0;
  double masterSale=0;
  double visaSale=0;
  double totDiscount=0;
  QuerySnapshot? sales;


  
  getSales() async {

     sales =await FirebaseFirestore.instance.collection('sales')
        .doc(currentBranchId)
        .collection('sales')
        .where('salesDate', isGreaterThanOrEqualTo:datePicked1)
        .where('salesDate', isLessThanOrEqualTo:datePicked2)
        .where('dinnerCertificate', isEqualTo:false)
        .get();
    sale=sales!.docs;
    totalSales=0;
    cashInHand=0;
    cashInBank=0;
    salesList=[];

amexSale=0;
madaSale=0;
visaSale=0;
masterSale=0;
 cardSale=[];
    for(var data in sales!.docs){
      if(data.get('AMEX')==true){
        amexSale+=data.get("amexAmount");

      }
      if(data.get('MADA')==true){
        madaSale+=data.get("madaAmount");

      }

      if(data.get('VISA')==true){
        visaSale+=data.get("visaAmount");

      }
       if(data.get('MASTER')==true){
        masterSale+=data.get("masterAmount");

      }


    }
    cardSale.add({
      "NAME":"AMEX",
      "TOTAL":amexSale,
    });
    cardSale.add({
      "NAME":"MADA",
      "TOTAL":madaSale,
    });
    cardSale.add({
      "NAME":"VISA",
      "TOTAL":visaSale,
    });
    cardSale.add({
      "NAME":"MASTER",
      "TOTAL":masterSale,
    });
    
totDiscount=0;
totVatSale=0;
    for(var data in sales!.docs){
      totVatSale+=data.get('totalAmount');
      totDiscount+=data.get('discount');
      totalSales+=data.get('grandTotal');
      if(data.get('cash')==true&&data.get('bank')==true){
        // cashInHand+=data.get('grandTotal');
        cashInHand+=(double.tryParse(data.get('paidCash').toString())! +double.tryParse(data.get('balance').toString())!);
        cashInBank+=(double.tryParse(data.get('paidBank').toString()))!;
        // cashSaleNo+=1;
      }else if(data.get('cash')==true&&data.get('bank')==false){
        cashInHand+=(double.tryParse(data.get('paidCash').toString())! +double.tryParse(data.get('balance').toString())!);
        // cashInBank+=data.get('grandTotal');
        // bankSaleNo+=1;
      }else{
        cashInBank+=(double.tryParse(data.get('paidBank').toString())!);
      }

      salesList.add({
        'no': data.get('invoiceNo'),
        'amount':data.get('grandTotal'),
      }
      );
    }
if(mounted) {
  setState(() {

  });
}

  }

  var creditSale;
  QuerySnapshot? creditSales;
  double totalCreditSales=0;
  List creditSaleData=[];
  getCreditSales() async {
    creditSales =await FirebaseFirestore.instance.collection('sales')
        .doc(currentBranchId)
        .collection('sales')
        .where('salesDate', isGreaterThanOrEqualTo:selectedFromDate)
        .where('salesDate', isLessThanOrEqualTo:selectedOutDate)
        .where('creditSale', isEqualTo:true)
        .get();
    creditSale=creditSales!.docs;
    totalCreditSales=0;
    creditSaleData=[];
    for(var data in creditSales!.docs){
      totalCreditSales+=data.get('grandTotal');
      creditSaleData.add({
        "name":data.get("creditName"),
        "phone":data.get("creditNumber"),
        "grandTotal":data.get("grandTotal"),

      });
    }
    setState(() {

    });

  }

  var dinnerSale;
  QuerySnapshot? dinnerSales;
  double totalDinnerSaleAmount=0;
  int dinnerSaleCount=0;
  getDinnerSales() async {
    dinnerSales=await FirebaseFirestore.instance.collection('sales')
        .doc(currentBranchId)
        .collection('sales')
        .where('salesDate', isGreaterThanOrEqualTo:selectedFromDate)
        .where('salesDate', isLessThanOrEqualTo:selectedOutDate)
        .where('dinnerCertificate', isEqualTo:true)
        .get();
    // .then((value) {

      dinnerSale=dinnerSales!.docs;
      dinnerSaleCount=dinnerSales!.docs.length;
      totalDinnerSaleAmount=0;
      for(var data in dinnerSales!.docs){
        totalDinnerSaleAmount+=data.get('grandTotal');


      }
      setState(() {

      });

    // });

  }




  var expense;
  double totalExp=0;
  double expCash=0;
  double expBank=0;
  DateTime selectedOutDate = DateTime.now();
  DateTime selectedFromDate = DateTime.now();
  getExpense() async {
    QuerySnapshot exp =await FirebaseFirestore.instance.collection('expenses')
        .doc(currentBranchId)
        .collection('expenses')
        .where('salesDate', isGreaterThanOrEqualTo:datePicked1)
        .where('salesDate', isLessThanOrEqualTo:datePicked2)
        .get();
    expense=exp.docs;
    totalExp=0;
    expCash=0;
    expBank=0;
    for(var data in exp.docs){
      totalExp+=data.get('amount');
      if(data.get('cash')==true){
        expCash+=double.tryParse(data.get('amount').toString())!;
      }else{
        expBank+=double.tryParse(data.get('amount').toString())!;
      }
    }
    setState(() {

    });
  }

  var rtns;
  int noOfReturn=0;
  double returnAmount=0;
  double rtnVat=0;
  getReturn() async {
    QuerySnapshot rtn =await FirebaseFirestore.instance.collection('salesReturn')
        .doc(currentBranchId)
        .collection('salesReturn')
        .where('salesReturnDate', isGreaterThanOrEqualTo:datePicked1)
        .where('salesReturnDate', isLessThanOrEqualTo:datePicked2)
        .get();
    rtns=rtn.docs;
    noOfReturn=rtn.docs.length;
    returnAmount=0;
    rtnVat=0;
    for(var data in rtn.docs){

      returnAmount+=double.tryParse(data.get('grandTotal').toString())!;
      rtnVat+=double.tryParse(data.get('tax').toString())!;

    }
    if(mounted) {
      setState(() {

    });
    }
  }

  // var amexCardSale;
  // QuerySnapshot amexCardSales;
  // double totalAmexSales=0;
  // List amexCardData=[];
  // getAmextCardSales() async {
  //   creditSales =await FirebaseFirestore.instance.collection('sales')
  //       .doc(currentBranchId)
  //       .collection('sales')
  //       .where('salesDate', isGreaterThanOrEqualTo:selectedFromDate)
  //       .where('salesDate', isLessThanOrEqualTo:selectedOutDate)
  //       .where('Amex', isEqualTo:true)
  //       .get();
  //   amexCardSale=amexCardSales.docs;
  //   totalAmexSales=0;
  //   creditSaleData=[];
  //   for(var data in creditSales.docs){
  //     totalCreditSales+=data.get('grandTotal');
  //     amexCardData.add({
  //       "name":data.get("creditName"),
  //       "phone":data.get("creditNumber"),
  //       "grandTotal":data.get("grandTotal"),
  //
  //     });
  //   }
  //   setState(() {
  //
  //   });

  // }

  List salesList=[];
  final format = DateFormat("yyyy-MM-dd hh:mm aaa");

  @override
  void initState() {
    super.initState();
    DateTime today=DateTime.now();
    selectedFromDate =DateTime(today.year,today.month,today.day,0,0,0);
    datePicked1 =Timestamp.fromDate(DateTime(today.year,today.month,today.day,0,0,0));
    datePicked2 =Timestamp.fromDate(DateTime(today.year,today.month,today.day,23,59,59));
    getSales();
    getPurchase();
    getExpense();
    getReturn();
    getCreditSales();
    getDinnerSales();

  }
  @override
  Widget build(BuildContext context) {
    salesData=[];
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: default_color,
        automaticallyImplyLeading: true,
        title: Text(
          'Daily Report',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: fontSize+5,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
                onTap: (){

                  if(blue){
                    bluetooth!.printCustom('Reports', 2, 1);
                    bluetooth!.printCustom('From ${DateFormat("yyyy-MM-dd hh:mm aaa").format(selectedFromDate)} To ${DateFormat("yyyy-MM-dd hh:mm aaa").format(selectedOutDate)}', 1, 1);
                    bluetooth!.printCustom('Sales : ${sale==null?'0':sale.length.toString()}', 1, 1);
                    bluetooth!.printCustom('Credit Sales : ${creditSale==null?'0':creditSale.length.toString()}', 1, 1);

                    bluetooth!.printCustom('Purchase : ${purchase==null?'0':purchase.length.toString()}', 1, 1);
                    bluetooth!.printCustom('Expense : ${expense==null?'0':expense.length.toString()}', 1, 1);
                    bluetooth!.printCustom('Return : ${noOfReturn.toString()}', 1, 1);
                    bluetooth!.printCustom('........................................', 1, 1);
                    bluetooth!.printCustom('Total sales : ${totalSales.toStringAsFixed(2)}', 1, 1);
                    bluetooth!.printCustom('Total Credit Sales : ${totalCreditSales.toStringAsFixed(2)}', 1, 1);

                    bluetooth!.printCustom('Total Purchase : ${totalPurchase.toStringAsFixed(2)}', 1, 1);
                    bluetooth!.printCustom('Total Expense : ${totalExp.toStringAsFixed(2)}', 1, 1);
                    bluetooth!.printCustom('Total Return : ${returnAmount.toStringAsFixed(2)}', 1, 1);
                    bluetooth!.printCustom('Vat Payable : ${((totVatSale*15/100)-totalvat).toStringAsFixed(2)}', 1, 1);
                    bluetooth!.printCustom('Balance : ${(totalSales-totalPurchase-totalExp).toStringAsFixed(2)}', 1, 1);
                    bluetooth!.printNewLine();
                    bluetooth!.printNewLine();

                    bluetooth!.paperCut();

                  }else{
                    dailyPrint();

                  }



                },
                child: const Icon(Icons.print)),
          ),

        ],
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {

          if(salesList.isNotEmpty){

            if(blue){
              bluetooth!.printCustom('Sales Reports', 2, 1);
              bluetooth!.printNewLine();
              bluetooth!.printCustom('From ${DateFormat("yyyy-MM-dd hh:mm aaa").format(selectedFromDate)} To ${DateFormat("yyyy-MM-dd hh:mm aaa").format(selectedOutDate)}', 1, 1);
              bluetooth!.printCustom('.....................................', 1, 1);
              bluetooth!.printCustom('          No        Bill No        Amt', 1, 0);
              bluetooth!.printCustom('.....................................', 1, 1);

              int i=1;
              double total=0;
              for(var item in salesList){
                bluetooth!.printCustom('          $i         ${item['no']}         ${item['amount']}', 1, 0);

                total+=item['amount'];
                i++;
              }
              bluetooth!.printCustom('........................................', 1, 1);
              bluetooth!.printCustom('      Total credit sale: ${totalCreditSales.toStringAsFixed(2)}       ', 2, 2);

              bluetooth!.printCustom('      Total : ${total.toStringAsFixed(2)}       ', 2, 2);
              bluetooth!.printNewLine();
              bluetooth!.printNewLine();
              bluetooth!.printNewLine();
              bluetooth!.printNewLine();
              bluetooth!.paperCut();
            }else{
              abc(salesList);
            }

          }else{
            showUploadMessage(context, 'No Sales');
          }
        },
        backgroundColor: Color(0xFF2b0e10),
        elevation: 10,
        child: Icon(
          Icons.print,
          color: Colors.white,
          size: 24,
        ),
      ),


      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 5,),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // TextButton(
                  //
                  //     onPressed: () {
                  //       showDatePicker(
                  //           context: context,
                  //           initialDate: selectedDate1,
                  //           firstDate: DateTime(1901, 1),
                  //           lastDate: DateTime(2100,1)).then((value){
                  //
                  //         setState(() {
                  //           DateFormat("yyyy-MM-dd").format(value);
                  //           datePicked1 = Timestamp.fromDate(DateTime(value.year,value.month,value.day,0,0,0));
                  //           selectedDate1=value;
                  //         });
                  //       });
                  //
                  //     },
                  //     child: Text(
                  //       datePicked1==null?'Choose Ending Date': datePicked1.toDate().toString().substring(0,10),
                  //       style: FlutterFlowTheme.bodyText1.override(
                  //         fontFamily: 'Poppins',
                  //         color: Colors.blue,
                  //         fontSize: 13,
                  //         fontWeight: FontWeight.w600,),
                  //     )),
                  // Text(
                  //   'To',
                  //   style: FlutterFlowTheme.bodyText1.override(
                  //     fontFamily: 'Poppins',
                  //   ),
                  // ),
                  // TextButton(
                  //
                  //     onPressed: () {
                  //       showDatePicker(
                  //           context: context,
                  //           initialDate: selectedDate2,
                  //           firstDate: DateTime(1901, 1),
                  //           lastDate: DateTime(2100,1)).then((value){
                  //
                  //         setState(() {
                  //           DateFormat("yyyy-MM-dd").format(value);
                  //
                  //           datePicked2 = Timestamp.fromDate(DateTime(value.year,value.month
                  //               ,value.day,0,0,0));
                  //
                  //           selectedDate2=value;
                  //         });
                  //       });
                  //
                  //     },
                  //     child: Text(
                  //       datePicked2==null?'Choose Ending Date': datePicked2.toDate().toString().substring(0,10),
                  //       style: FlutterFlowTheme.bodyText1.override(
                  //         fontFamily: 'Poppins',
                  //         color: Colors.blue,
                  //         fontSize: 13,
                  //         fontWeight: FontWeight.w600,),
                  //     )),
                 Column(
                   children: [
                     Text("FROM DATE",style: TextStyle(fontSize: fontSize+5,fontWeight: FontWeight.bold)),
                     Container(
                       height: 80,
                       width: 250,
                       decoration: BoxDecoration(
                           border: Border.all(
                               color: Colors.white,
                               width: 1),
                           borderRadius:
                           BorderRadius.circular(
                               10)),
                       child: DateTimeField(

                         decoration: InputDecoration(

                           border: OutlineInputBorder(
                             borderRadius:
                             BorderRadius
                                 .circular(
                                 5.0),
                           ),
                           focusedBorder:
                           OutlineInputBorder(
                             borderSide: BorderSide(
                                 color: Colors
                                     .pink
                                     .shade900,
                                 width: 3.0),
                           ),

                         ),


                         initialValue:selectedFromDate ,
                         format: format,
                         onShowPicker: (context,
                             currentValue) async {
                           final date =
                           await showDatePicker(
                               context: context,
                               firstDate:
                               DateTime(1900),
                               initialDate:
                               currentValue ??
                                   DateTime
                                       .now(),
                               lastDate:
                               DateTime(2100));
                           if (date != null) {
                             final time =
                             await showTimePicker(
                               context: context,
                               initialTime: TimeOfDay
                                   .fromDateTime(
                                   currentValue ??
                                       DateTime
                                           .now()),
                             );
                             selectedFromDate =
                                 DateTime(
                                     date.year,
                                     date.month,
                                     date.day,
                                     time!.hour,
                                     time.minute);
                             datePicked1=Timestamp.fromDate(selectedFromDate);
                             return DateTimeField
                                 .combine(date, time);
                           } else {
                             return currentValue;
                           }
                         },
                       ),
                     ),
                   ],
                 ),
                  // Text(
                  //   'To',
                  //   style: FlutterFlowTheme.bodyText1.override(
                  //     fontFamily: 'Poppins',
                  //     fontSize: fontSize+10
                  //   ),
                  // ),
                  Column(
                    children: [
                      Text("TO DATE",style: TextStyle(fontSize: fontSize+5,fontWeight: FontWeight.bold),),
                      Container(
                        height: 80,
                        width: 250,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.white,
                                width: 1),
                            borderRadius:
                            BorderRadius.circular(
                                10)),
                        child: DateTimeField(
                          decoration: InputDecoration(

                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  5.0),
                            ),
                            focusedBorder:
                            OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors
                                      .pink
                                      .shade900,
                                  width: 3.0),
                            ),

                          ),
                          initialValue:selectedOutDate ,
                          format: format,
                          onShowPicker: (context,
                              currentValue) async {
                            final date =
                            await showDatePicker(
                                context: context,
                                firstDate:
                                DateTime(1900),
                                initialDate:
                                currentValue ??
                                    DateTime
                                        .now(),
                                lastDate:
                                DateTime(2100));
                            if (date != null) {
                              final time =
                              await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay
                                    .fromDateTime(
                                    currentValue ??
                                        DateTime
                                            .now()),
                              );
                              selectedOutDate =
                                  DateTime(
                                      date.year,
                                      date.month,
                                      date.day,
                                      time!.hour,
                                      time.minute);
                              datePicked2=Timestamp.fromDate(selectedOutDate) ;
                              return DateTimeField
                                  .combine(date, time);
                            } else {
                              return currentValue;
                            }
                          },
                        ),
                      ),
                    ],
                  ),

                  FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 20,
                    borderWidth: 1,
                    buttonSize: 50,
                    icon: const FaIcon(
                      FontAwesomeIcons.search,
                      color: Colors.black,
                      size: 40,
                    ),
                    onPressed: () async {
                      if(datePicked1!=null&&datePicked2!=null){

                        getSales();
                        getExpense();
                        getPurchase();
                        getReturn();
                        getCreditSales();
                        getDinnerSales();

                      }else{
                        datePicked1==null? showUploadMessage(context, 'Please Choose Starting Date'):
                        showUploadMessage(context, 'Please Choose Ending Date');
                      }



                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [


                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder:(context) => ProductReport(
                        salesData:sales!,
                        From:selectedFromDate,
                        To:selectedOutDate,

                      ),));
                    },
                    child: Container(
                      width: 150,
                      height: 40,
                      decoration: BoxDecoration(
                          color: const Color(0xFF2b0e10),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: const Center(
                        child: Text('Product Report',style: TextStyle(
                            fontSize: 16,
                            color: Colors.white
                        ),),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder:(context) => CreditReport(
                        creditSaleData:creditSaleData,
                        From:selectedFromDate,
                        To:selectedOutDate,

                      ),));
                    },
                    child: Container(
                      width: 150,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color(0xFF2b0e10),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: const Center(
                        child: Text('Credit Report',style: TextStyle(
                            fontSize: 16,
                            color: Colors.white
                        ),),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder:(context) => CategoryReport(
                        salesData:sales!,
                        From:selectedFromDate,
                        To:selectedOutDate,

                      ),));
                    },
                    child: Container(
                      width: 150,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color(0xFF2b0e10),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Text('Category Report',style: TextStyle(
                            fontSize: 16,
                            color: Colors.white
                        ),),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder:(context) => IngredientReport(
                        salesData:sales!,
                        From:selectedFromDate,
                        To:selectedOutDate,

                      ),));
                    },
                    child: Container(
                      width: 150,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color(0xFF2b0e10),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Text('Ingredient  Report',style: TextStyle(
                            fontSize: 16,
                            color: Colors.white
                        ),),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      try {
                        final invoice =
                        CardReportData(
                          card:cardSale,
                          From:selectedFromDate,
                          To:selectedOutDate,


                        );

                        final pdfFile =
                            await CardPdfPage.generate(invoice);
                        await PdfApi.openFile(pdfFile);
                      } catch (e) {
                        print(e);

                      }
                    },
                    child: Container(
                      width: 150,
                      height: 40,
                      decoration: BoxDecoration(
                          color: const Color(0xFF2b0e10),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: const Center(
                        child: Text('Card Report',style: TextStyle(
                            fontSize: 16,
                            color: Colors.white
                        ),),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {

                      try {
                        final invoice =
                        DailyReportData(

                          from:selectedFromDate,
                          to: selectedOutDate,
                          purchaseAmount: totalPurchase,
                          expenseAmount: totalExp,
                          saleAmount: totalSales,
                          balance: totalSales-totalPurchase-totalExp-returnAmount-totalCreditSales,
                          rtn:noOfReturn,
                          rtnAmount: returnAmount,
                          sale:double.tryParse(sale.length.toString())!,
                          purchase:double.tryParse(purchase.length.toString())!,
                          expense:double.tryParse(expense.length.toString())!,
                          userSaleData: salesData, vatPayable:double.tryParse((((totVatSale*15/100)-totalvat)-rtnVat).toStringAsFixed(2))!,
                          creditSaleCount:creditSale.length,
                          dinnerSaleCount:dinnerSale.length,
                          creditSale:totalCreditSales,
                          dinnerSale:totalDinnerSaleAmount

                        );

                        final pdfFile =
                            await B2bPdfInvoiceApi.generate(invoice);
                        await PdfApi.openFile(pdfFile);
                      } catch (e) {
                        print(e);
                        // return showDialog(
                        //     context: context,
                        //     builder: (context) {
                        //       return AlertDialog(
                        //         title: Text('error'),
                        //         content: Text(e.toString()),
                        //
                        //         actions: <Widget>[
                        //           new FlatButton(
                        //             child: new Text('ok'),
                        //             onPressed: () {
                        //               Navigator.of(context).pop();
                        //             },
                        //           )
                        //         ],
                        //       );
                        //     });
                      }

                    },
                    child: Container(
                      width: 150,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color(0xFF2b0e10),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Text('Genarate PDF',style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                        ),),
                      ),
                    ),
                  ),

                ],
              ),

              SizedBox(height:40),
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30),
                child: Wrap(
                  // mainAxisSize: MainAxisSize.max,
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          onTap: () async {
                            await  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  SalesReport()),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.13,
                            height: MediaQuery.of(context).size.width*0.15,
                            decoration: BoxDecoration(
                              color: Color(0xFFEEEEEE),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Sales',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  sale==null?'0':sale.length.toString(),
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'TOTAL SAR ${totalSales.toStringAsFixed(2)}',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10,right: 10),
                                  child: Divider(color: Colors.grey,thickness: 1,),
                                ),
                                Text(
                                  'CASH : SAR ${cashInHand.toStringAsFixed(2)}',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Bank : SAR ${cashInBank.toStringAsFixed(2)}',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.13,
                          height: MediaQuery.of(context).size.width*0.15,
                          decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Credit Sale',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                creditSale==null?'0':creditSale.length.toString(),
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 1,),
                              Text(
                                'SAR ${totalCreditSales.toStringAsFixed(2)}',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: 10),
                    //   child: Material(
                    //     color: Colors.transparent,
                    //     elevation: 5,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(12),
                    //     ),
                    //     child: Container(
                    //       width: MediaQuery.of(context).size.width*0.13,
                    //       height: MediaQuery.of(context).size.width*0.15,
                    //       decoration: BoxDecoration(
                    //         color: Color(0xFFEEEEEE),
                    //         borderRadius: BorderRadius.circular(12),
                    //       ),
                    //       child: Column(
                    //         mainAxisSize: MainAxisSize.max,
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Text(
                    //             'Dinner Certificate',
                    //             style: FlutterFlowTheme.bodyText1.override(
                    //               fontFamily: 'Poppins',
                    //               color: Colors.black,
                    //               fontSize: 16,
                    //               fontWeight: FontWeight.w600,
                    //             ),
                    //           ),
                    //           Text(
                    //               // totDinnerSale+=data.get('grandTotal');
                    //               // dinnerSaleCount+=1;
                    //             dinnerSaleCount.toString(),
                    //             style: FlutterFlowTheme.bodyText1.override(
                    //               fontFamily: 'Poppins',
                    //               color: Colors.black,
                    //               fontSize: 14,
                    //               fontWeight: FontWeight.w600,
                    //             ),
                    //           ),
                    //           SizedBox(height: 1,),
                    //           Text(
                    //             'SAR ${totalDinnerSaleAmount}',
                    //             style: FlutterFlowTheme.bodyText1.override(
                    //               fontFamily: 'Poppins',
                    //               color: Colors.black,
                    //               fontSize: 14,
                    //               fontWeight: FontWeight.w600,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(width: 10,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.13,
                          height: MediaQuery.of(context).size.width*0.15,
                          decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Total Discount',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                  // totDinnerSale+=data.get('grandTotal');
                                  // dinnerSaleCount+=1;
                                "",
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 1,),
                              Text(
                                'SAR ${totDiscount.toStringAsFixed(2)}',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          onTap: () async {

                            await  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  PurchaseReport()),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.13,
                            height: MediaQuery.of(context).size.width*0.15,
                            decoration: BoxDecoration(
                              color: Color(0xFFEEEEEE),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Purchase',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  purchase==null?'0':purchase.length.toString(),
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                   // 'SAR ${(totalPurchase+totalvat).toStringAsFixed(2)}',
                                   'SAR ${totalPurchase.toStringAsFixed(2)}',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10,right: 10),
                                  child: Divider(color: Colors.grey,thickness: 1,),
                                ),
                                Text(
                                  'CASH : SAR ${purchaseCash.toStringAsFixed(2)}',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Bank : SAR ${purchaseBank.toStringAsFixed(2)}',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          onTap: () async {
                            await  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  ExpenseReport()),
                            );

                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.13,
                            height: MediaQuery.of(context).size.width*0.15,
                            decoration: BoxDecoration(
                              color: Color(0xFFEEEEEE),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Expense',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  expense==null?'0':expense.length.toString(),
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'SAR ${totalExp.toStringAsFixed(2)}',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10,right: 10),
                                  child: Divider(color: Colors.grey,thickness: 1,),
                                ),
                                Text(
                                  'CASH : SAR ${expCash.toStringAsFixed(2)}',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Bank : SAR ${expBank.toStringAsFixed(2)}',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.13,
                          height: MediaQuery.of(context).size.width*0.15,
                          decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Return',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 1,),
                              Text(
                                noOfReturn.toString(),
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 1,),
                              Text(
                                'SAR ${returnAmount.toStringAsFixed(2)}',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.13,
                          height: MediaQuery.of(context).size.width*0.15,
                          decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'VAT Payable',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 1,),
                              Text(
                                'SAR ${(((totVatSale*15/100)-totalvat)-rtnVat).toStringAsFixed(2)}',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.13,
                          height: MediaQuery.of(context).size.width*0.15,
                          decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Balance',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 1,),
                              Text(
                                'SAR ${((totalSales-totalExp-totalPurchase-returnAmount)-(totalCreditSales)).toStringAsFixed(2)}',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),


                  ],
                ),
              ),

              SizedBox(height: 20,),

              FittedBox(
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text(
                        'Name',
                        style: TextStyle(fontWeight: FontWeight.bold)
                    )),
                    DataColumn(label: Text(
                        'Sale',
                        style: TextStyle( fontWeight: FontWeight.bold)
                    )),

                    DataColumn(label: Text(
                        'Cash (S)',
                        style: TextStyle( fontWeight: FontWeight.bold)
                    )),
                    DataColumn(label: Text(
                        'Bank  (S)',
                        style: TextStyle(fontWeight: FontWeight.bold)
                    )),
                    DataColumn(label: Text(
                        'Credit Sale',
                        style: TextStyle( fontWeight: FontWeight.bold)
                    )),
                    // DataColumn(label: Text(
                    //     'Dinner Sale',
                    //     style: TextStyle( fontWeight: FontWeight.bold)
                    // )),
                    DataColumn(label: Text(
                        'Purchase',
                        style: TextStyle( fontWeight: FontWeight.bold)
                    )),
                    DataColumn(label: Text(
                        'Cash (P)',
                        style: TextStyle(fontWeight: FontWeight.bold)
                    )),
                    DataColumn(label: Text(
                        'Bank (P)',
                        style: TextStyle( fontWeight: FontWeight.bold)
                    )),
                    DataColumn(label: Text(
                        'Expense',
                        style: TextStyle( fontWeight: FontWeight.bold)
                    )),
                    DataColumn(label: Text(
                        'Cash (E)',
                        style: TextStyle( fontWeight: FontWeight.bold)
                    )),
                    DataColumn(label: Text(
                        'Bank (E)',
                        style: TextStyle( fontWeight: FontWeight.bold)
                    )),
                    DataColumn(label: Text(
                        'Return',
                        style: TextStyle( fontWeight: FontWeight.bold)
                    )),
                    DataColumn(label: Text(
                        'Print',
                        style: TextStyle( fontWeight: FontWeight.bold)
                    )),
                    // DataColumn(label: Text(
                    //     'Balance',
                    //     style: TextStyle( fontWeight: FontWeight.bold)
                    // )),
                  ],
                  rows: List.generate(
                      posUsers.length,
                          (index) {


                        double usrBalance=0;
                            int userTotalSaleNo=0;
                            double userTotalSaleAmount=0;
                            double userTotalSaleAmountInCash=0;
                            double userTotalSaleAmountInBank=0;
                            if(sale!=null){
                              String uId=posUsers[index].id;
                              for(var userSale in sale){
                                if(userSale.get('currentUserId')==uId){
                                  userTotalSaleNo+=1;
                                  userTotalSaleAmount+=userSale.get('grandTotal');

                                  if(userSale.get('cash')==true&&userSale.get('bank')==true){
                                    userTotalSaleAmountInCash+=(double.tryParse(userSale.get('paidCash').toString())!+double.tryParse(userSale.get('balance').toString())!);
                                    userTotalSaleAmountInBank+=userSale.get('paidBank');

                                  }else if(userSale.get('cash')==true&&userSale.get('bank')==false){
                                    userTotalSaleAmountInCash+=(double.tryParse(userSale.get('paidCash').toString())!+double.tryParse(userSale.get('balance').toString())!);
                                  }else{
                                    userTotalSaleAmountInBank+=userSale.get('paidBank');

                                  }
                                }
                              }


                            }

                            int userPurchaseNo=0;
                            double userPurchaseAmount=0;
                            double userPurchaseAmountInCash=0;
                            double userPurchaseAmountInBank=0;
                            if(purchase!=null){
                              String uId=posUsers[index].id;
                              for(var userPurchase in purchase){
                                if(userPurchase.get('currentUserId')==uId){
                                  userPurchaseNo+=1;
                                  // userPurchaseAmount+=(double.tryParse(userPurchase.get('amount').toString()))+(double.tryParse(userPurchase.get('gst').toString()))??0;
                                  userPurchaseAmount+=(double.tryParse(userPurchase.get('amount').toString())!);
                                  if(userPurchase.get('cash')==true){
                                    // userPurchaseAmountInCash+=(double.tryParse(userPurchase.get('amount').toString())+double.tryParse(userPurchase.get('gst').toString()));
                                    userPurchaseAmountInCash+=double.tryParse(userPurchase.get('amount').toString())!;
                                  }else{
                                    userPurchaseAmountInBank+=double.tryParse(userPurchase.get('amount').toString())!;
                                  }
                                }
                              }
                            }

                            int userExpNo=0;
                            double userExpAmount=0;
                            double userExpAmountInCash=0;
                            double userExpAmountInBank=0;
                            if(expense!=null){
                              String uId=posUsers[index].id;
                              for(var userPurchase in expense){
                                if(userPurchase.get('currentUserId')==uId){
                                  userExpNo+=1;
                                  userExpAmount+=userPurchase.get('amount');
                                  if(userPurchase.get('cash')==true){
                                    userExpAmountInCash+=userPurchase.get('amount');
                                  }else{
                                    userExpAmountInBank+=userPurchase.get('amount');
                                  }
                                }
                              }
                            }

                            double userReturnAmount=0;
                            if(rtns!=null){
                              String uId=posUsers[index].id;
                              for(var item in rtns){
                                if(item.get('currentUserId')==uId) {
                                  userReturnAmount+=double.tryParse(item.get('grandTotal').toString())!;
                                }
                              }
                            }

                        int userCreditCount=0;
                        double userCreditSale=0;
                        if(creditSales!=null){
                          String uId=posUsers[index].id;
                          for(var item in creditSale){
                            if(item.get('currentUserId')==uId) {
                              userCreditCount+=1;
                              userCreditSale+=double.tryParse(item.get('grandTotal').toString())!;
                            }
                          }
                        }

                        int userDinnerCount=0;
                        double userDinnerSale=0;

                        if(dinnerSales!=null){
                          String uId=posUsers[index].id;
                          for(var item in dinnerSale){
                            print(item);
                            print("item----------------------");
                            if(item.get('currentUserId')==uId) {
                              userDinnerCount+=1;
                              userDinnerSale+=double.tryParse(item.get('grandTotal').toString())!;
                            }
                          }

                        }


                        salesData.add({
                          'name':posUsers[index]['name'],
                          'saleAmount':userTotalSaleAmount,
                          'saleAmountCash':userTotalSaleAmountInCash,
                          'saleAmountBank':userTotalSaleAmountInBank,
                          'puchaseAmount':userPurchaseAmount,
                          'purchaseAmountCash':userPurchaseAmountInCash,
                          'purchaseAmountBank':userPurchaseAmountInBank,
                          'expenseAmount':userExpAmount,
                          'expenseAmountInCash':userExpAmountInCash,
                          'expenseAmountInBank':userExpAmountInBank,
                          "userCreditSale":userCreditSale,
                          "userCreditCount":userCreditCount,
                          'returnAmount':userReturnAmount,
                          "dinnerSale":userDinnerSale
                        });

                        usrBalance=userTotalSaleAmount-(userPurchaseAmount+userExpAmount);
                        return DataRow(
                            cells: [
                              DataCell(Text(posUsers[index]['name'],style: TextStyle(fontWeight: FontWeight.w500),)),
                              DataCell(Text(userTotalSaleAmount.toStringAsFixed(2))),
                              DataCell(Text(userTotalSaleAmountInCash.toStringAsFixed(2))),
                              DataCell(Text(userTotalSaleAmountInBank.toStringAsFixed(2))),
                              DataCell(Text(userCreditSale.toStringAsFixed(2))),
                              // DataCell(Text(userDinnerSale.toStringAsFixed(2))),
                              DataCell(Text(userPurchaseAmount.toStringAsFixed(2))),
                              DataCell(Text(userPurchaseAmountInCash.toStringAsFixed(2))),
                              DataCell(Text(userPurchaseAmountInBank.toStringAsFixed(2))),
                              DataCell(Text(userExpAmount.toStringAsFixed(2))),
                              DataCell(Text(userExpAmountInCash.toStringAsFixed(2))),
                              DataCell(Text(userExpAmountInBank.toStringAsFixed(2))),
                              DataCell(Text(userReturnAmount.toStringAsFixed(2))),

                              // DataCell(Text(usrBalance.toStringAsFixed(2))),
                              DataCell(InkWell(
                                  onTap: () async {


                                    if (salesList.isNotEmpty) {
                                      if (blue) {
                                        bluetooth!.printCustom('Sales Reports', 2, 1);
                                        bluetooth!.printNewLine();
                                        bluetooth!.printCustom(
                                            'From ${DateFormat("yyyy-MM-dd hh:mm aaa").format(selectedFromDate)} To ${DateFormat("yyyy-MM-dd hh:mm aaa").format(selectedOutDate)}',
                                            1,
                                            1);
                                        bluetooth!.printNewLine();
                                        // bluetooth!.printCustom('  user Name: ${posUsers[index]['name']}', 1, 0);
                                        // bluetooth!.printCustom('  user Name: ${posUsers[index]['name']}', 1, 0);
                                        ScreenshotController screenshotController =
                                        ScreenshotController();
                                        var capturedImage1 = await screenshotController
                                            .captureFromWidget(Container(
                                            color: Colors.white,
                                            width: printWidth * 2,
                                            height: 55,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'CASHIER : ${posUsers[index]['name']}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                Text(
                                                  '  المحاسب :${posUsers[index]['arabicName']} ',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            )));
                                        bluetooth!.printImageBytes(capturedImage1);

                                        bluetooth!.printNewLine();
                                        bluetooth!.printCustom(
                                            '           No         Bill No      Amt',
                                            1,
                                            0);
                                        bluetooth!.printCustom(
                                            '..................................', 1, 1);

                                        int i = 1;
                                        double total = 0;
                                        if (sale != null) {
                                          String uId = posUsers[index].id;

                                          for (var item in sale) {
                                            print(item);
                                            if (item.get('currentUserId') == uId) {
                                              bluetooth!.printCustom(
                                                  '           $i         ${item['invoiceNo']}         ${item['grandTotal']}',
                                                  1,
                                                  0);

                                              total += item['grandTotal'];
                                              i++;
                                            }
                                          }
                                        }
                                        bluetooth!.printCustom(
                                            '................................', 1, 1);
                                        bluetooth!.printCustom(
                                            'CASH  = ${userTotalSaleAmountInCash.toStringAsFixed(2)}',
                                            1,
                                            1);
                                        bluetooth!.printNewLine();
                                        bluetooth!.printCustom(
                                            'BANK  = ${(userTotalSaleAmountInBank.toStringAsFixed(2))}',
                                            1,
                                            1);
                                        bluetooth!.printNewLine();
                                        bluetooth!.printCustom(
                                            'Total : ${(userTotalSaleAmount.toStringAsFixed(2))}       ',
                                            2,
                                            2);
                                        bluetooth!.printNewLine();
                                        bluetooth!.printNewLine();
                                        bluetooth!.printNewLine();
                                        bluetooth!.printNewLine();
                                        bluetooth!.paperCut();
                                      } else {
                                        daily_user_report(
                                            salesList,
                                            posUsers[index]['name'],
                                            userTotalSaleAmountInCash.toStringAsFixed(2),
                                            (userTotalSaleAmountInBank
                                                .toStringAsFixed(2)),
                                            (userTotalSaleAmount.toStringAsFixed(2)),
                                            posUsers[index].id.toString(),
                                            posUsers[index]['arabicName']);
                                      }
                                    } else {
                                      showUploadMessage(context, 'No Sales');
                                    }

                                    // if(salesList.isNotEmpty){
                                    //   if(blue) {
                                    //     bluetooth!.printCustom('Sales Reports', 2, 1);
                                    //     bluetooth!.printNewLine();
                                    //     bluetooth!.printCustom(
                                    //         'From ${DateFormat("yyyy-MM-dd hh:mm aaa").format(selectedFromDate)} To ${DateFormat("yyyy-MM-dd hh:mm aaa").format(selectedOutDate)}', 1,
                                    //         1);
                                    //     bluetooth!.printNewLine();
                                    //     // bluetooth.printCustom('  user Name: ${posUsers[index]['name']}', 1, 0);
                                    //     // bluetooth.printCustom('  user Name: ${posUsers[index]['name']}', 1, 0);
                                    //     ScreenshotController screenshotController = ScreenshotController();
                                    //     var  capturedImage1= await    screenshotController
                                    //         .captureFromWidget(Container(
                                    //         color: Colors.white,
                                    //         width: printWidth*2,
                                    //         height: 55,
                                    //         child:
                                    //         Column(
                                    //           mainAxisAlignment:MainAxisAlignment.center,
                                    //           children: [
                                    //             Text('CASHIER : ${posUsers[index]['name']}',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                                    //              Text('  المحاسب :${posUsers[index]['arabicName']} ',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                                    //
                                    //           ],)));
                                    //     bluetooth!.printImageBytes(capturedImage1);
                                    //
                                    //     bluetooth!.printNewLine();
                                    //     bluetooth!.printCustom(
                                    //         '           No         Bill No      Amt', 1, 0);
                                    //     bluetooth!.printCustom(
                                    //         '..................................', 1, 1);
                                    //
                                    //
                                    //     int i = 1;
                                    //     double total = 0;
                                    //     if (sale != null) {
                                    //       String uId = posUsers[index].id;
                                    //
                                    //       for (var item in sale) {
                                    //         print(item);
                                    //         if (item.get('currentUserId') == uId) {
                                    //           bluetooth!.printCustom('           $i         ${item['invoiceNo']}         ${item['grandTotal']}', 1, 0);
                                    //
                                    //           total += item['grandTotal'];
                                    //           i++;
                                    //         }
                                    //       }
                                    //     }
                                    //     bluetooth!.printCustom(
                                    //         '................................', 1, 1);
                                    //     bluetooth!.printCustom(
                                    //         'CASH  = ${userTotalSaleAmountInCash.toStringAsFixed(2)}', 1, 1);
                                    //     bluetooth!.printNewLine();
                                    //     bluetooth!.printCustom(
                                    //         'BANK  = ${(userTotalSaleAmountInBank.toStringAsFixed(2))}', 1, 1);
                                    //     bluetooth!.printNewLine();
                                    //     bluetooth!.printCustom(
                                    //         'Total : ${(userTotalSaleAmount.toStringAsFixed(2))}       ', 2, 2);
                                    //     bluetooth!.printNewLine();
                                    //     bluetooth!.printNewLine();
                                    //     bluetooth!.printNewLine();
                                    //     bluetooth!.printNewLine();
                                    //     bluetooth!.paperCut();
                                    //
                                    //   }else{
                                    //     daily_user_report(salesList,posUsers[index]['name'],userTotalSaleAmountInCash.toStringAsFixed(2),(userTotalSaleAmountInBank.toStringAsFixed(2)),(userTotalSaleAmount.toStringAsFixed(2)),posUsers[index].id.toString(),posUsers[index]['arabicName']);
                                    //   }
                                    //
                                    // }else{
                                    //   showUploadMessage(context, 'No Sales');
                                    // }
                                  },
                                  child: CircleAvatar(backgroundColor: Color(0xFF2b0e10),radius: 17,child: Icon(Icons.print,size: 18,),))),
                            ]);
                      }
                ),
                ),
              ),
              SizedBox(height: 100,)

            ],
          ),
        ),
      ),
    );





  }
}