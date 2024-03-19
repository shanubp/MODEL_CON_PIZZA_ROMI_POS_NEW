
import 'package:awafi_pos/Branches/branches.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';

import 'package:awafi_pos/order_details/order_details_widget.dart';
import 'package:awafi_pos/view_invoice/view_invoice.dart';
import 'package:intl/intl.dart';

import '../DailyReport/genaratePDF/expensePdf.dart';
import '../DailyReport/genaratePDF/expenseReportModel.dart';
import '../DailyReport/genaratePDF/pdf_api.dart';
import '../DailyReport/genaratePDF/purchasePdf.dart';
import '../DailyReport/genaratePDF/purchasereportModel.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../flutter_flow/upload_media.dart';
import '../main.dart';
import 'expense_reports.dart';

class PurchaseReport extends StatefulWidget {
  const PurchaseReport({Key? key}) : super(key: key);

  @override
  _PurchaseReportState createState() => _PurchaseReportState();
}

class _PurchaseReportState extends State<PurchaseReport> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController invoiceController = TextEditingController();
  DateTime fromDate=DateTime.now();
  DateTime toDate=DateTime.now();
  QuerySnapshot? invoices;
  final format = DateFormat("yyyy-MM-dd hh:mm aaa");
  DateTime selectedOutDate = DateTime.now();
  DateTime selectedFromDate = DateTime.now();
  @override
  void initState() {
    invoiceController=TextEditingController();
    super.initState();
    getDailyInvoice();
    DateTime today=DateTime.now();
    selectedFromDate =DateTime(today.year,today.month,today.day,0,0,0);
  }
  getInvoiceByNo() async {
    invoices = await FirebaseFirestore.instance
        .collection('purchases')
        .doc(currentBranchId)
        .collection('purchases')
        .where('invoiceNo', isEqualTo: invoiceController.text)
        .get();
    setState(() {});
  }
  List invoiceList = [];
  // getInvoiceByDate() async {
  //   if (fromDate != null && toDate != null) {
  //     print(fromDate);
  //     print(toDate);
  //     print(selectedFromDate);
  //     print(selectedOutDate);
  //
  //     Timestamp fromDateTimeStamp = Timestamp.fromDate(selectedFromDate);
  //     Timestamp toDateTimeStamp = Timestamp.fromDate(selectedOutDate);
  //     invoices = await FirebaseFirestore.instance
  //         .collection('purchases')
  //         .doc(currentBranchId)
  //         .collection('purchases')
  //         .where('salesDate', isGreaterThanOrEqualTo: fromDateTimeStamp)
  //         .where('salesDate', isLessThan: toDateTimeStamp)
  //         .get()
  //         .then((value) {
  //       invoices = value;
  //       for (var item in value.docs) {
  //         invoiceList.add({
  //           'staff': PosUserIdToName[item['currentUserId']],
  //           'amount': item['amount'],
  //           'invoiceNo': item['invoiceNo'],
  //           'description': item['description'],
  //           'voucherNo': item['voucherNo'],
  //         });
  //         setState(() {});
  //       }
  //     });
  //   }
  // }
  getInvoiceByDate() async {
    if (fromDate != null && toDate != null) {
      print(fromDate);
      print(toDate);
      print(selectedFromDate);
      print(selectedOutDate);
      Timestamp fromDateTimeStamp = Timestamp.fromDate(selectedFromDate);
      Timestamp toDateTimeStamp = Timestamp.fromDate(selectedOutDate);
      FirebaseFirestore.instance
          .collection('purchases')
          .doc(currentBranchId)
          .collection('purchases')
          .where('salesDate', isGreaterThanOrEqualTo: fromDateTimeStamp)
          .where('salesDate', isLessThan: toDateTimeStamp)
          .get()
          .then((value) {
        invoices = value;
        invoiceList=[];
        for (var item in value.docs) {
          invoiceList.add({
            'staff': PosUserIdToName[item['currentUserId']],
            'vat': item['gst'],
            'vatNumber': item['vatNumber'],
            'amount': item['amount'],
            'invoiceNo': item['invoiceNo'],
            'description': item['description'],
            'voucherNo': item['voucherNo'],
            'salesDate':item['salesDate']
          });
           setState(() {});
        }
      });
    }
  }
  getDailyInvoice() async {
    var now = DateTime.now();
    var lastMidnight =
    Timestamp.fromDate(DateTime(now.year, now.month, now.day));

    FirebaseFirestore.instance
        .collection('purchases')
        .doc(currentBranchId)
        .collection('purchases')
        .where('salesDate', isGreaterThanOrEqualTo: lastMidnight)
        .get()
        .then((value) {
      invoices = value;
      for (var item in value.docs) {
        print(123);
        invoiceList.add({
          'staff': PosUserIdToName[item['currentUserId']],
          'amount': item['amount'],
          'vat': item['gst'],
          'vatNumber': item['vatNumber'],
          'invoiceNo': item['invoiceNo'],
          'description': item['description'],
          'voucherNo': item['voucherNo'],
          'salesDate':item['salesDate']
        });
        setState(() {});
      }
    });
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: default_color,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Purchase Report',
          style: FlutterFlowTheme.title1.override(
              fontFamily: 'Poppins',color: Colors.white
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () async {
                try {
                  final invoice = PurchaseReportData(
                    InvoiceList: invoiceList,
                    From: selectedFromDate,
                    To: selectedOutDate,
                  );

                  final pdfFile = await PurchasePdfPage.generate(invoice);
                  await PdfApi.openFile(pdfFile);
                } catch (e) {
                  print(e);
                  return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('error'),
                          content: Text(e.toString()),
                          actions: <Widget>[
                            TextButton(
                              child: new Text('ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });
                }
              },
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white, width: 2)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Text(
                      "Download pdf",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.16,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.white),
                      child: Center(
                        child: TextFormField(
                          controller: invoiceController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Bill No',
                            hoverColor: Colors.red,
                            hintText: 'search bill no 🔍',
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
                  ),
                   SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  TextButton(
                    onPressed: (){
                      FocusScope.of(context).unfocus();
                      getInvoiceByNo();

                    },
                    child: const Text('Search By invoiceNo 🔍'),
                  ),
                  // InkWell(
                  //   onTap: () async {
                  //     final DateTime picked = await showDatePicker(
                  //         context: context,
                  //         initialDate: fromDate??DateTime.now(),
                  //         firstDate: DateTime(2015, 8),
                  //         lastDate: DateTime(2101));
                  //     if (picked != null && picked != fromDate) {
                  //       setState(() {
                  //         fromDate = picked;
                  //       });
                  //     }
                  //   },
                  //   child:Container(
                  //     width: 200,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(3),
                  //         color: Colors.white),
                  //     child: Center(
                  //       child: Text(
                  //           fromDate==null?'Date From':fromDate.toLocal().toString().substring(0,10)
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(width: 20,),
                  // InkWell(
                  //   onTap: () async {
                  //     final DateTime picked = await showDatePicker(
                  //         context: context,
                  //         initialDate: toDate??DateTime.now(),
                  //         firstDate: DateTime(2015, 8),
                  //         lastDate: DateTime(2101));
                  //     if (picked != null && picked != toDate) {
                  //       setState(() {
                  //         toDate = picked;
                  //       });
                  //     }
                  //   },
                  //   child:Container(
                  //     width: 200,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(3),
                  //         color: Colors.white),
                  //     child: Center(
                  //       child: Text(
                  //           toDate==null?'To Date ':toDate.toLocal().toString().substring(0,10)
                  //       ),
                  //     ),
                  //   ),
                  // ),
                   SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.18,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.white,
                            width: 1),
                        borderRadius:
                        BorderRadius.circular(
                            10)),
                    child: DateTimeField(
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
                          // datePicked1=Timestamp.fromDate(selectedFromDate);
                          return DateTimeField
                              .combine(date, time);
                        } else {
                          return currentValue;
                        }
                      },
                    ),
                  ),
                   SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                  Text(
                    'To',
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',fontWeight: FontWeight.bold
                    ),
                  ),
                   SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.18,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.white,
                            width: 1),
                        borderRadius:
                        BorderRadius.circular(
                            10)),
                    child: DateTimeField(
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
                          // datePicked2=Timestamp.fromDate(selectedOutDate) ;
                          return DateTimeField
                              .combine(date, time);
                        } else {
                          return currentValue;
                        }
                      },
                    ),
                  ),
                   SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.05,
                    child: TextButton(
                      onPressed: (){

                        getInvoiceByDate();

                      },
                      child: const Icon(Icons.search,color: Colors.black,size:35 ),
                    ),
                  ),
                ],

              ),
            ),

            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.all(10),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing:10,
                  childAspectRatio: .7,
                ),
                itemCount:
                invoices==null?0:invoices!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot invoice =
                  invoices!.docs[index];
                  return invoices!.docs==null?Center(child: CircularProgressIndicator()):
                  invoices!.docs.length==0?Center(child: Text('No Data')):InkWell(
                    child: Card(
                      child: Column(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                final currentContext = context; // Store a reference to the context
                                if (invoice.get('image') != '' && invoice.get('image') != null) {
                                  showDialog(
                                    context: currentContext, // Use the stored context
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Container(
                                          height: MediaQuery.of(context).size.height * 0.7,
                                          width: MediaQuery.of(context).size.width * 0.5,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(invoice.get('image')),
                                            ),
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              downloadImage(invoice.get('image'), currentContext); // Pass the stored context
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Download'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  showUploadMessage(context, 'Image Not Exist!');
                                }
                              },
                              child: Container(
                                color: Colors.grey.shade300,
                                height: 200,
                                child:invoice.get('image')!='' && invoice.get('image')!=null
                                    ? CachedNetworkImage(
                                  imageUrl: invoice.get('image')
                                  ,fit: BoxFit.cover,
                                )
                                    :Container(
                                    height:220
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Voucher No"),
                                  Text(":"),
                                  Text(invoice
                                      .get('voucherNo')
                                      .toString())
                                ]),
                          ),
                          Divider(),
                          Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Invoice No"),
                                    Text(":"),
                                    Text(invoice
                                        .get('invoiceNo')
                                        .toString()),
                                  ])),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Taxable Amount"),
                                  Text(":"),
                                  Text(
                                      invoice.get('amount').toString()),
                                ]),
                          ),
                          Divider(),
                          // Padding(
                          //     padding: const EdgeInsets.only(left: 10,right: 10),
                          //     child: Row(
                          //         mainAxisAlignment:
                          //         MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Text("Vat Amount"),
                          //           Text(":"),
                          //           Text(invoice.get('gst').toString()),
                          //         ])),
                          // Divider(),
                          Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Description"),
                                    Text(":"),
                                    Text(invoice
                                        .get('description')
                                        .toString()),
                                  ])),
                          Divider(),
                          Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Staff"),
                                    Text(":"),
                                    Text(PosUserIdToName[invoice
                                        .get('currentUserId')
                                        .toString()]),
                                  ]
                              )
                          ),
                          IconButton(onPressed: () async {
                            bool proceed = await alert(context, 'You want to Delete?');
                            if(proceed){
                              invoice.reference.delete();
                              setState(() {
                              });
                              Navigator.pop(context);
                            }
                          }, icon: Icon(Icons.delete,color: Colors.red,))
                        ],
                      ),
                    ),
                  ) ;
                },
              ),
            )

            // Expanded(
            //   child: GridView.builder(
            //     shrinkWrap: true,
            //     primary: false,
            //     padding: const EdgeInsets.all(10),
            //     gridDelegate:
            //     const SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 5,
            //       crossAxisSpacing: 10,
            //       mainAxisSpacing:10,
            //       childAspectRatio: .7,
            //     ),
            //
            //     itemCount:
            //     invoices==null?0:invoices!.docs.length,
            //     itemBuilder: (context, index) {
            //       DocumentSnapshot invoice =
            //       invoices!.docs[index];
            //       return invoices!.docs==null?Center(child: CircularProgressIndicator()):
            //       invoices!.docs.length==0?Center(child: Text('No Data')):InkWell(
            //         // onTap: () async {
            //         //   await Navigator.push(
            //         //     context,
            //         //     MaterialPageRoute(builder: (context) =>  ViewInvoice(invoiceNo: int.tryParse(invoice.id)??0,)),
            //         //   );
            //         // },
            //         child: Card(
            //           child: Column(
            //             children: [
            //               Expanded(
            //                 child: InkWell(
            //                   onTap: (){
            //                     showDialog(
            //                         context: context,
            //                         builder: (BuildContext context) {
            //                           return AlertDialog(
            //                             title: Container(
            //                               height: MediaQuery.of(context).size.height*0.7,
            //                               width: MediaQuery.of(context).size.width*0.5,
            //                               decoration: BoxDecoration(image: DecorationImage( image: NetworkImage(invoice.get('image')))),
            //                             ),
            //                             actions: <Widget>[
            //                               TextButton(
            //                                 onPressed: () {
            //
            //                                   Navigator.pop(context);
            //                                 },
            //                                 child: const Text('OK'),
            //                               ),
            //                             ],
            //                           );
            //                         });
            //
            //                   },
            //                   child: Container(
            //                     color: Colors.grey.shade300,
            //                     height: 200,
            //                     child:invoice.get('image')!='' && invoice.get('image')!=null
            //                         ? CachedNetworkImage(
            //                       imageUrl: invoice.get('image')
            //                       ,fit: BoxFit.cover,
            //
            //                     )
            //                         :InkWell(
            //                       onTap: (){
            //                         showUploadMessage(context, "Image Not Found");
            //                       },
            //                           child: Container(
            //                               height:220
            //                           ),
            //                         ),
            //                   ),
            //                 ),
            //
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.only(left: 10,right: 10),
            //                 child: Row(
            //                     mainAxisAlignment:
            //                     MainAxisAlignment.spaceBetween,
            //                     children: [
            //                       Text("Voucher No"),
            //                       Text(":"),
            //                       Text(invoice
            //                           .get('voucherNo')
            //                           .toString())
            //                     ]),
            //               ),
            //               Divider(),
            //               Padding(
            //                   padding: const EdgeInsets.only(left: 10,right: 10),
            //                   child: Row(
            //                       mainAxisAlignment:
            //                       MainAxisAlignment.spaceBetween,
            //                       children: [
            //                         Text("Invoice No"),
            //                         Text(":"),
            //                         Text(invoice
            //                             .get('invoiceNo')
            //                             .toString()),
            //                       ])),
            //               Divider(),
            //               Padding(
            //                 padding: const EdgeInsets.only(left: 10,right: 10),
            //                 child: Row(
            //                     mainAxisAlignment:
            //                     MainAxisAlignment.spaceBetween,
            //                     children: [
            //                       Text("Total Amount"),
            //                       Text(":"),
            //                       Text(
            //                           invoice.get('amount').toString()),
            //                     ]),
            //               ),
            //               Divider(),
            //               Padding(
            //                   padding: const EdgeInsets.only(left: 10,right: 10),
            //                   child: Row(
            //                       mainAxisAlignment:
            //                       MainAxisAlignment.spaceBetween,
            //                       children: [
            //                         Text("Vat Amount"),
            //                         Text(":"),
            //                         Text(invoice.get('gst').toString()),
            //                       ])),
            //               Divider(),
            //               Padding(
            //                   padding: const EdgeInsets.only(left: 10,right: 10),
            //                   child: Row(
            //                       mainAxisAlignment:
            //                       MainAxisAlignment.spaceBetween,
            //                       children: [
            //                         Text("Description"),
            //                         Text(":"),
            //                         Text(invoice
            //                             .get('description')
            //                             .toString()),
            //                       ])),
            //               Divider(),
            //               Padding(
            //                   padding: const EdgeInsets.only(left: 10,right: 10),
            //                   child: Row(
            //                       mainAxisAlignment:
            //                       MainAxisAlignment.spaceBetween,
            //                       children: [
            //                         Text("Staff"),
            //
            //                         Text(":"),
            //                         Text(PosUserIdToName[invoice
            //                             .get('currentUserId')
            //                             .toString()]),
            //                       ]
            //                   )
            //               ),
            //               IconButton(onPressed: () async {
            //                 bool proceed = await alert(context, 'You want to Delete?');
            //                 if(proceed){
            //                   invoice.reference.delete();
            //                   setState(() {
            //                   });
            //                   Navigator.pop(context);
            //                 }
            //
            //
            //
            //               }, icon: Icon(Icons.delete,color: Colors.red,))
            //             ],
            //           ),
            //         ),
            //       ) ;
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
