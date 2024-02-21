import 'package:awafi_pos/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../modals/Print/pdf_api.dart';
import 'CreditReportModel.dart';
import 'creditPdf.dart';

class CreditReport extends StatefulWidget {
  final List creditSaleData;
  final DateTime From;
  final DateTime To;

  const CreditReport({Key? key, required this.creditSaleData, required this.From, required this.To  }) : super(key: key);

  @override
  State<CreditReport> createState() => _CreditReportState();
}

class _CreditReportState extends State<CreditReport> {

  @override
  void initState(){
    super.initState();
    print(widget.From);
    print(widget.To);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Credit Report"),
        centerTitle: true,
        backgroundColor: default_color,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(onPressed: () async {

              try {
                final invoice =
                CreditReportData(
                  creditSaleData: widget.creditSaleData,
                  From:widget.From,
                  To:widget.To,
                );

                final pdfFile =
                await CreditPdfPage.generate(invoice);
                await PdfApi.openFile(pdfFile);
              } catch (e) {
                print(e);

              }

            }, icon: Icon(Icons.picture_as_pdf)),


          ),
          SizedBox(width:30)
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: widget.creditSaleData.length,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (buildContext,int index){


                  return Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                    child: Container(
                      width: double.infinity,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            color: Color(0x520E151B),
                            offset: Offset(0, 2),
                          )
                        ],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                        child: Row(
                          // mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // ClipRRect(
                            //   borderRadius: BorderRadius.circular(6),
                            //   child: CachedNetworkImage(
                            //     imageUrl:
                            //     productImgByName[newPrd.keys.toList()[index]],
                            //     width: 80,
                            //     height: 80,
                            //     fit: BoxFit.cover,
                            //   ),
                            // ),
                            SizedBox(width: 50,),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width*0.3,
                                child: Text(
                                  widget.creditSaleData[index]["name"],
                                  style: FlutterFlowTheme.subtitle1.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF090F13),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.3,
                              child: Center(
                                child: Text(
                                  widget.creditSaleData[index]["phone"],
                                  style: FlutterFlowTheme.bodyText2.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF57636C),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.3,
                              child: Center(
                                child: Text(
                                  widget.creditSaleData[index]["grandTotal"].toString(),
                                  style: FlutterFlowTheme.bodyText2.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF57636C),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(width: 50,),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}