

import 'package:cloud_firestore/cloud_firestore.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DeliveredDetailsWidget extends StatefulWidget {
  final String? orderId;
  const DeliveredDetailsWidget({Key? key, this.orderId}) : super(key: key);

  @override
  _DeliveredDetailsWidgetState createState() => _DeliveredDetailsWidgetState();
}

class _DeliveredDetailsWidgetState extends State<DeliveredDetailsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List billItem=[];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('orders')
            .where('orderId',isEqualTo: widget.orderId)
            .where('status',isEqualTo: 2).snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator());
          }
          var data=snapshot.data?.docs;
          var bag=data![0]['salesItems'];
          List addOn=[];


          for(Map<String,dynamic> snap in bag){
            addOn=snap['addOn'];
          }
          Timestamp date2=data[0]['DeliveredTime'];
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.primaryColor,
              automaticallyImplyLeading: true,
              iconTheme: IconThemeData(color: Colors.white),
              title: Text(
                'Delivery Details',
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
                                  padding: const EdgeInsets.all(8.0),
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Delivery Location : ${data[0]['address']}',
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
                                        'Delivery Time : ${date2.toDate().toString().substring(0,16) }',
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
                  Expanded(
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
                                                  Text(variants.isEmpty?'': '  ${variants['english']??""}',style: const TextStyle(fontWeight: FontWeight.w600),
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

                ],
              ),
            ),
          );
        }
    );
  }
}
