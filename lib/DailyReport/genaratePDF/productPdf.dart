
import 'dart:io';
import 'dart:typed_data';
import 'package:awafi_pos/DailyReport/genaratePDF/productReport_model.dart';
import 'package:awafi_pos/main.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:universal_html/html.dart' as html;

import '../../Branches/branches.dart';
import '../../modals/Print/pdf_api.dart';
import 'dailyReport_model.dart';
import 'package:intl/intl.dart';
var image;



var format = NumberFormat.simpleCurrency(locale: 'en_in');

class ProductPdfPage {

  static Future<File> generate(ProductReportData invoice) async {
    double gdtotal=0;
print(invoice.To);
print(invoice.From);
    final pdf = Document();
    image = await imageFromAssetBundle(logoPath);

    pdf.addPage(MultiPage(
      build: (context) => [

        // pw.Column(
        //     crossAxisAlignment: pw.CrossAxisAlignment.start,
        //     children:[
//START
              pw.Container(
                height: 100,
                width: 100,
                child:pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Image(image,width: 90,height: 90,fit: pw.BoxFit.contain),
                    ]
                ),
              ),
//STUDENT DETAIL
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [

                    pw.Container(
                      width: 250,
                      // color: PdfColors.green,
                      child:  pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [

                            pw.SizedBox(height: 20),
                            pw.Row(
                                children: [
                                  pw.Container(width: 70,child: pw.Text('Shop Name',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                  pw.Container(width: 170,child: pw.Text(': $currentBranchName',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),

                                ]
                            ),
                            pw.SizedBox(height: 5),
                            pw.Row(
                                children: [
                                  pw.Container(width: 70,child: pw.Text('Vat Number',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                  pw.Container(width: 170,child: pw.Text(': $vatNumber',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                ]
                            ),
                            pw.SizedBox(height: 5),
                            pw.Row(
                                children: [
                                  pw.Container(width: 70,child: pw.Text('Starting Date',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                   pw.Container(width: 170,child: pw.Text(': ${DateFormat("yyyy-MM-dd   hh:mm  aaa").format(invoice.From)}',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                ]
                            ),
                            pw.SizedBox(height: 5),
                            pw.Row(
                                children: [
                                  pw.Container(width: 70,child: pw.Text('Ending Date',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                   pw.Container(width: 170,child: pw.Text(': ${DateFormat("yyyy-MM-dd   hh:mm  aaa").format(invoice.To)}',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                ]
                            ),

                          ]
                      ),
                    ),


                  ]
              ),

              pw.SizedBox(height: 30),

              //table with list.generate

              pw.Container(
                child:  pw.Table.fromTextArray(
                    context: context,
                    headers: [
                      'Product Name',
                      'Price',
                      'Quantity',
                      'Total'

                    ],

                    data:
                    List.generate(invoice.productWiseData.length, (index) {
                      final item =invoice.productWiseData[index];
                      double total=double.tryParse(item["price"].toString())!*double.tryParse(item["qty"].toString())!;
                      gdtotal+=total;
                      print(item.toString()+'                    $index');
                      return [
                        item['name'],
                        item['price'].toStringAsFixed(2),
                        item['qty'],
                        total.toStringAsFixed(2)



                      ];
                    })

                ),
              ),



              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [

                    pw.Container(width: 120,child: pw.Text('Grand Total : ${gdtotal.toStringAsFixed(2)}',style: pw.TextStyle(fontSize: 11,)),)
                  ]
              ),

              pw.Container(
                  height: 40
              ),

              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('seal',style: pw.TextStyle(fontSize: 11,)),
                    pw.Container(width: 120,child: pw.Text('Official Signature',style: pw.TextStyle(fontSize: 11,)),)
                  ]
              ),
              pw.SizedBox(height: 30),

            ]
        ),

//END
//         pw.Container(
//           height: 50,
//           width: 700,
//
//         ),
//       ],
   // )
    );



    //web
    // final bytes = pdf.save();
    // final blob = html.Blob([bytes], 'application/pdf');
    // final url = html.Url.createObjectUrlFromBlob(
    //     await generate());
    // final anchor =
    // html.document.createElement('a') as html.AnchorElement
    //   ..href = url
    //   ..style.display = 'none'
    //   ..download = 'some_name.pdf';
    // html.document.body.children.add(anchor);
    // anchor.click();
    // html.document.body.children.remove(anchor);
    // html.Url.revokeObjectUrl(url);

    // await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
    // print('bbbbbbbbbbbbbbbbbbbbbbbb');

    //android
    return PdfApi.saveDocument(name: 'Product Wise Report.pdf', pdf: pdf);
    // return PdfApi.saveDocument(name: '${invoice.from.toDate().toString().substring(0,10)} - ${invoice.from.toDate().toString().substring(0,10)}.pdf', pdf: pdf);
  }


}