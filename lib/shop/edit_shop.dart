// //@dart=2.9
// import 'package:built_collection/built_collection.dart';
//
// import 'package:intl/intl.dart';
// import 'package:awafi_pos/backend/firebase_storage/storage.dart';
// import 'package:awafi_pos/backend/schema/shops_record.dart';
// import 'package:awafi_pos/flutter_flow/upload_media.dart';
// import '../flutter_flow/flutter_flow_theme.dart';
// import '../flutter_flow/flutter_flow_widgets.dart';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:google_maps_place_picker/google_maps_place_picker.dart' as gMapPlacePicker;
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import '../main.dart';
//
// class EditShopWidget extends StatefulWidget {
//   final ShopsRecord shop;
//   EditShopWidget({Key key, this.shop}) : super(key: key);
//
//
//
//   @override
//   _EditShopWidgetState createState() =>
//       _EditShopWidgetState();
// }
//
// class _EditShopWidgetState extends State<EditShopWidget> {
//   _EditShopWidgetState();
//   ShopsRecord shop;
//   TextEditingController textController1;
//   TextEditingController textController2;
//   TextEditingController textController3;
//   TextEditingController textController4;
//   TextEditingController textController5;
//   TextEditingController searchController;
//   String uploadedFileUrl1="";
//   String datePicked1 = "";
//   String datePicked2 = '';
//   String datePicked3 = '';
//   String datePicked4 = '';
//   String datePicked5 = '';
//   String datePicked6 = '';
//   String datePicked7 = '';
//   String datePicked8 = '';
//   String datePicked10 = '';
//   String datePicked9 = '';
//   String datePicked11 = '';
//   String datePicked12 = '';
//   String datePicked13 = '';
//   String datePicked14 = '';
//   List<String> admins=[];
//   bool checkboxListTileValue;
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   var placePickerValue = LatLng(0.0, 0.0);
//
//   TextEditingController  locationController;
//   gMapPlacePicker.PickResult result;
//   set(){
//     setState(() {
//
//     });
//   }
//
//
//   ListBuilder<String> convertListToListBuilder(List<String> list) {
//     ListBuilder<String> listBuilder = ListBuilder<String>();
//     for (var items in list) {
//       listBuilder.add(items);
//     }
//     return listBuilder;
//   }
//
//
//   @override
//   void initState() {
//     super.initState();
//     textController1 = TextEditingController();
//     textController2 = TextEditingController();
//     textController3 = TextEditingController();
//     textController4 = TextEditingController();
//     textController5 = TextEditingController();
//     locationController = TextEditingController();
//     shop=widget.shop;
//       uploadedFileUrl1=shop.imageUrl;
//       datePicked1 = shop.sunFrom;
//       datePicked2 = shop.sunTo;
//       datePicked3 = shop.monFrom;
//     datePicked4 =shop.monTo;
//       datePicked5 = shop.tueFrom;
//       datePicked6 = shop.tueTo;
//       datePicked7 = shop.wedFrom;
//       datePicked8 = shop.wedTo;
//       datePicked10 = shop.thuFrom;
//       datePicked9 = shop.thuTo;
//       datePicked11 = shop.friFrom;
//       datePicked12 = shop.friTo;
//       datePicked13 = shop.satFrom;
//       datePicked14 = shop.satTo;
//     textController1.text = shop.name;
//     textController2.text = shop.address;
//     textController3.text = shop.phoneNumber;
//     textController4.text= shop.email;
//     textController5.text = shop.fSSAIRegNo;
//     for(String shop in shop.admins ){
//       admins.add(shop);
//     }
//
//   }
//   setSearchParam(String caseNumber) {
//     ListBuilder<String> caseSearchList = ListBuilder<String>();
//     String temp = "";
//
//     List<String> nameSplits = caseNumber.split(" ");
//     for (int i = 0; i < nameSplits.length; i++) {
//       String name = "";
//
//       for (int k = i; k < nameSplits.length; k++) {
//         name = name + nameSplits[k] + " ";
//       }
//       temp = "";
//
//       for (int j = 0; j < name.length; j++) {
//         temp = temp + name[j];
//         caseSearchList.add(temp.toUpperCase());
//       }
//     }
//     return caseSearchList;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       key: scaffoldKey,
//       appBar: AppBar(
//         backgroundColor: FlutterFlowTheme.primaryColor,
//         automaticallyImplyLeading: true,
//         title: Text(
//           'Shops',
//           style: FlutterFlowTheme.bodyText1.override(
//             fontFamily: 'Poppins',
//           ),
//         ),
//         actions: [],
//         centerTitle: true,
//         elevation: 4,
//       ),
//
//       body: SafeArea(
//         child :SingleChildScrollView(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.max,
//                         children: [
//                           Row(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment:
//                             MainAxisAlignment.spaceEvenly,
//                             children: [
//                               IconButton(
//                                 onPressed: () async {
//                                   final selectedMedia = await selectMedia(
//                                     maxWidth: 1080.00,
//                                     maxHeight: 1320.00,
//                                   );
//                                   if (selectedMedia != null &&
//                                       validateFileFormat(
//                                           selectedMedia.storagePath,
//                                           context)) {
//                                     showUploadMessage(
//                                         context, 'Uploading file...',
//                                         showLoading: true);
//                                     final downloadUrl = await uploadData(
//                                         selectedMedia.storagePath,
//                                         selectedMedia.bytes);
//                                     ScaffoldMessenger.of(context)
//                                         .hideCurrentSnackBar();
//                                     if (downloadUrl != null) {
//                                       setState(() =>
//                                       uploadedFileUrl1 = downloadUrl);
//                                       showUploadMessage(
//                                           context, 'Success!');
//                                     } else {
//                                       showUploadMessage(context,
//                                           'Failed to upload media');
//                                     }
//                                   }
//                                 },
//                                 icon: Icon(
//                                   Icons.camera_alt,
//                                   color: Colors.black,
//                                   size: 30,
//                                 ),
//                                 iconSize: 30,
//                               ),
//                               IconButton(
//                                 onPressed: () async {
//                                   final selectedMedia = await selectMedia(
//                                     maxWidth: 1080.00,
//                                     maxHeight: 1320.00,
//                                   );
//                                   if (selectedMedia != null &&
//                                       validateFileFormat(
//                                           selectedMedia.storagePath,
//                                           context)) {
//                                     showUploadMessage(
//                                         context, 'Uploading file...',
//                                         showLoading: true);
//                                     final downloadUrl = await uploadData(
//                                         selectedMedia.storagePath,
//                                         selectedMedia.bytes);
//                                     ScaffoldMessenger.of(context)
//                                         .hideCurrentSnackBar();
//                                     if (downloadUrl != null) {
//                                       setState(() =>
//                                       uploadedFileUrl1 = downloadUrl);
//                                       showUploadMessage(context,
//                                           'Media upload Success!');
//                                     } else {
//                                       showUploadMessage(context,
//                                           'Failed to upload media');
//                                     }
//                                   }
//                                 },
//                                 icon: Icon(
//                                   Icons.image,
//                                   color: Colors.black,
//                                   size: 30,
//                                 ),
//                                 iconSize: 30,
//                               )
//                             ],
//                           ),
//                           Padding(
//                             padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
//                             child: Container(
//                               width: double.infinity,
//                               height: 30,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(20),
//                                 border: Border.all(
//                                   color: Color(0x8AA7A1A1),
//                                   width: 2,
//                                 ),
//                               ),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Expanded(
//                                     child: TextFormField(
//                                       controller: textController1,
//                                       obscureText: false,
//                                       decoration: InputDecoration(
//                                         isDense: true,
//                                         hintText: 'name',
//                                         hintStyle: FlutterFlowTheme.bodyText1.override(
//                                           fontFamily: 'Poppins',
//                                           fontSize: 13,
//                                         ),
//                                         enabledBorder: InputBorder.none,
//                                         focusedBorder: InputBorder.none,
//                                         filled: true,
//                                       ),
//                                       style: FlutterFlowTheme.bodyText1.override(
//                                         fontFamily: 'Poppins',
//                                         fontSize: 13,
//                                       ),
//                                       textAlign: TextAlign.justify,
//                                     ),
//                                   ),
//
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
//                             child: Container(
//                               width: double.infinity,
//                               height: 30,
//                               decoration: BoxDecoration(
//                                 color: Color(0xFFA6A6A6),
//                               ),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
//                                     child: Text(
//                                       'Location',
//                                       textAlign: TextAlign.start,
//                                       style: FlutterFlowTheme.bodyText1.override(
//                                         fontFamily: 'Poppins',
//                                         color: Colors.black,
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                           IconButton(onPressed: () async {
//
//                             await Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => gMapPlacePicker.PlacePicker(
//                                   apiKey: "AIzaSyCfSWYXBcU_tvYV8vljjokKGMAyUvfQKrE",
//                                   // Put YOUR OWN KEY here.
//                                 initialPosition: LatLng(shop.latitude,shop.longitude),
//                                   searchForInitialValue: true,
//                                   selectInitialPosition: true,
//                                   onPlacePicked: (res) {
//
//                                     result=res;
//
//                                     textController2.text=res.formattedAddress;
//                                     Navigator.of(context).pop();
//                                     set();
//                                   },
//
//                                   useCurrentLocation: true,
//
//                                 ),
//                               ),
//                             );
//
//
//
//                           }, icon: Icon(Icons.location_on)),
//                           Padding(
//                             padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
//                             child: Container(
//                               width: double.infinity,
//                               height: 30,
//                               decoration: BoxDecoration(
//                                 color: Color(0xFFA6A6A6),
//                               ),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
//                                     child: Text(
//                                       'Address',
//                                       textAlign: TextAlign.start,
//                                       style: FlutterFlowTheme.bodyText1.override(
//                                         fontFamily: 'Poppins',
//                                         color: Colors.black,
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
//                             child: Container(
//                               width: 350,
//                               height: 70,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(
//                                   color: Color(0x8A000000),
//                                 ),
//                               ),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: [
//                                   Expanded(
//                                     child: Padding(
//                                       padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
//                                       child: Row(
//                                         mainAxisSize: MainAxisSize.max,
//                                         children: [
//                                           Expanded(
//                                             child: TextFormField(
//                                               controller: textController2,
//                                               obscureText: false,
//                                               decoration: InputDecoration(
//                                                 hintText: 'Address',
//                                                 hintStyle:
//                                                 FlutterFlowTheme.bodyText1.override(
//                                                   fontFamily: 'Poppins',
//                                                   fontSize: 9,
//                                                   fontWeight: FontWeight.w500,
//                                                 ),
//                                                 enabledBorder: UnderlineInputBorder(
//                                                   borderSide: BorderSide(
//                                                     color: Color(0x00000000),
//                                                     width: 1,
//                                                   ),
//                                                   borderRadius: const BorderRadius.only(
//                                                     topLeft: Radius.circular(4.0),
//                                                     topRight: Radius.circular(4.0),
//                                                   ),
//                                                 ),
//                                                 focusedBorder: UnderlineInputBorder(
//                                                   borderSide: BorderSide(
//                                                     color: Color(0x00000000),
//                                                     width: 1,
//                                                   ),
//                                                   borderRadius: const BorderRadius.only(
//                                                     topLeft: Radius.circular(4.0),
//                                                     topRight: Radius.circular(4.0),
//                                                   ),
//                                                 ),
//                                               ),
//                                               style:
//                                               FlutterFlowTheme.bodyText1.override(
//                                                 fontFamily: 'Poppins',
//                                                 fontSize: 9,
//                                                 fontWeight: FontWeight.w500,
//                                               ),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
//                             child: Container(
//                               width: double.infinity,
//                               height: 30,
//                               decoration: BoxDecoration(
//                                 color: Color(0xFFA6A6A6),
//                               ),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
//                                     child: Text(
//                                       'Contact Details',
//                                       textAlign: TextAlign.start,
//                                       style: FlutterFlowTheme.bodyText1.override(
//                                         fontFamily: 'Poppins',
//                                         color: Colors.black,
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
//                             child: Container(
//                               width: 350,
//                               height: 40,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(
//                                   color: Color(0x8A242222),
//                                 ),
//                               ),
//                               child: Padding(
//                                 padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Expanded(
//                                       child: TextFormField(
//                                         controller: textController3,
//                                         obscureText: false,
//                                         decoration: InputDecoration(
//                                           hintText:
//                                           'Phone Number',
//                                           hintStyle:
//                                           FlutterFlowTheme.bodyText1.override(
//                                             fontFamily: 'Poppins',
//                                             fontSize: 12,
//                                           ),
//                                           enabledBorder: UnderlineInputBorder(
//                                             borderSide: BorderSide(
//                                               color: Color(0x00000000),
//                                               width: 1,
//                                             ),
//                                             borderRadius: const BorderRadius.only(
//                                               topLeft: Radius.circular(4.0),
//                                               topRight: Radius.circular(4.0),
//                                             ),
//                                           ),
//                                           focusedBorder: UnderlineInputBorder(
//                                             borderSide: BorderSide(
//                                               color: Color(0x00000000),
//                                               width: 1,
//                                             ),
//                                             borderRadius: const BorderRadius.only(
//                                               topLeft: Radius.circular(4.0),
//                                               topRight: Radius.circular(4.0),
//                                             ),
//                                           ),
//                                         ),
//                                         style: FlutterFlowTheme.bodyText1.override(
//                                           fontFamily: 'Poppins',
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
//                             child: Container(
//                               width: 350,
//                               height: 40,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(
//                                   color: Color(0x8A242222),
//                                 ),
//                               ),
//                               child: Padding(
//                                 padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Expanded(
//                                       child: TextFormField(
//                                         controller: textController4,
//                                         obscureText: false,
//                                         decoration: InputDecoration(
//                                           hintText: 'email',
//                                           hintStyle:
//                                           FlutterFlowTheme.bodyText1.override(
//                                             fontFamily: 'Poppins',
//                                             fontSize: 12,
//                                           ),
//                                           enabledBorder: UnderlineInputBorder(
//                                             borderSide: BorderSide(
//                                               color: Color(0x00000000),
//                                               width: 1,
//                                             ),
//                                             borderRadius: const BorderRadius.only(
//                                               topLeft: Radius.circular(4.0),
//                                               topRight: Radius.circular(4.0),
//                                             ),
//                                           ),
//                                           focusedBorder: UnderlineInputBorder(
//                                             borderSide: BorderSide(
//                                               color: Color(0x00000000),
//                                               width: 1,
//                                             ),
//                                             borderRadius: const BorderRadius.only(
//                                               topLeft: Radius.circular(4.0),
//                                               topRight: Radius.circular(4.0),
//                                             ),
//                                           ),
//                                         ),
//                                         style: FlutterFlowTheme.bodyText1.override(
//                                           fontFamily: 'Poppins',
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
//                             child: Container(
//                               width: double.infinity,
//                               height: 30,
//                               decoration: BoxDecoration(
//                                 color: Color(0xFFA6A6A6),
//                               ),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
//                                     child: Text(
//                                       'FSSAI Registration Details (Optional)',
//                                       textAlign: TextAlign.start,
//                                       style: FlutterFlowTheme.bodyText1.override(
//                                         fontFamily: 'Poppins',
//                                         color: Colors.black,
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.max,
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     'Optional for non-food organization and its mandatory for food related organization',
//                                     style: FlutterFlowTheme.bodyText1.override(
//                                       fontFamily: 'Poppins',
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                           Container(
//                             width: 350,
//                             height: 40,
//                             decoration: BoxDecoration(
//                               color: FlutterFlowTheme.tertiaryColor,
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(
//                                 color: Color(0x8A242222),
//                               ),
//                             ),
//                             child: Padding(
//                               padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: [
//                                   Expanded(
//                                     child: TextFormField(
//                                       controller: textController5,
//                                       obscureText: false,
//                                       decoration: InputDecoration(
//                                         hintText:
//                                         'fSSAIRegNo',
//                                         hintStyle: FlutterFlowTheme.bodyText1.override(
//                                           fontFamily: 'Poppins',
//                                         ),
//                                         enabledBorder: UnderlineInputBorder(
//                                           borderSide: BorderSide(
//                                             color: Color(0x00000000),
//                                             width: 1,
//                                           ),
//                                           borderRadius: const BorderRadius.only(
//                                             topLeft: Radius.circular(4.0),
//                                             topRight: Radius.circular(4.0),
//                                           ),
//                                         ),
//                                         focusedBorder: UnderlineInputBorder(
//                                           borderSide: BorderSide(
//                                             color: Color(0x00000000),
//                                             width: 1,
//                                           ),
//                                           borderRadius: const BorderRadius.only(
//                                             topLeft: Radius.circular(4.0),
//                                             topRight: Radius.circular(4.0),
//                                           ),
//                                         ),
//                                       ),
//                                       style: FlutterFlowTheme.bodyText1.override(
//                                         fontFamily: 'Poppins',
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
//                             child: Container(
//                               width: double.infinity,
//                               height: 30,
//                               decoration: BoxDecoration(
//                                 color: Color(0xFFA6A6A6),
//                               ),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
//                                     child: Text(
//                                       'Opening Hours',
//                                       textAlign: TextAlign.start,
//                                       style: FlutterFlowTheme.bodyText1.override(
//                                         fontFamily: 'Poppins',
//                                         color: Colors.black,
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.max,
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     'Sunday',
//                                     style: FlutterFlowTheme.bodyText1.override(
//                                       fontFamily: 'Poppins',
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
//                                   child: Text(
//                                     ':',
//                                     style: FlutterFlowTheme.bodyText1.override(
//                                       fontFamily: 'Poppins',
//                                     ),
//                                   ),
//                                 ),
//                                 FFButtonWidget(
//                                   onPressed: () async {
//                                     await DatePicker.showTime12hPicker(context,
//                                         showTitleActions: true, onConfirm: (date) {
//                                           setState(() => datePicked1 = DateFormat.jm().format(date));
//                                         }, currentTime: DateTime.now());
//                                   },
//                                   text: datePicked1.toString(),
//                                   options: FFButtonOptions(
//                                     width: 100,
//                                     height: 35,
//                                     color: Colors.white,
//                                     textStyle: FlutterFlowTheme.subtitle2.override(
//                                       fontFamily: 'Poppins',
//                                       color: Color(0xFF242224),
//                                     ),
//                                     borderSide: BorderSide(
//                                       color: Color(0x8A242222),
//                                       width: 1,
//                                     ),
//                                     borderRadius: 10,
//                                   ),
//                                 ),
//                                 Text(
//                                   '-',
//                                   style: FlutterFlowTheme.bodyText1.override(
//                                     fontFamily: 'Poppins',
//                                   ),
//                                 ),
//                                 FFButtonWidget(
//                                   onPressed: () async {
//                                     await DatePicker.showTime12hPicker(context,
//                                         showTitleActions: true, onConfirm: (date) {
//                                           setState(() => datePicked2 = DateFormat.jm().format(date));
//                                         }, currentTime: DateTime.now());
//                                   },
//                                   text: datePicked2.toString(),
//                                   options: FFButtonOptions(
//                                     width: 100,
//                                     height: 35,
//                                     color: Colors.white,
//                                     textStyle: FlutterFlowTheme.subtitle2.override(
//                                       fontFamily: 'Poppins',
//                                       color: Color(0xFF242224),
//                                     ),
//                                     borderSide: BorderSide(
//                                       color: Color(0x8A242222),
//                                       width: 1,
//                                     ),
//                                     borderRadius: 10,
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.max,
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     'Monday',
//                                     style: FlutterFlowTheme.bodyText1.override(
//                                       fontFamily: 'Poppins',
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
//                                   child: Text(
//                                     ':',
//                                     style: FlutterFlowTheme.bodyText1.override(
//                                       fontFamily: 'Poppins',
//                                     ),
//                                   ),
//                                 ),
//                                 FFButtonWidget(
//                                   onPressed: () async {
//                                     await DatePicker.showTime12hPicker(context,
//                                         showTitleActions: true, onConfirm: (date) {
//                                           setState(() => datePicked3 =  DateFormat.jm().format(date));
//                                         }, currentTime: DateTime.now());
//                                   },
//                                   text: datePicked3.toString(),
//                                   options: FFButtonOptions(
//                                     width: 100,
//                                     height: 35,
//                                     color: Colors.white,
//                                     textStyle: FlutterFlowTheme.subtitle2.override(
//                                       fontFamily: 'Poppins',
//                                       color: Color(0xFF242224),
//                                     ),
//                                     borderSide: BorderSide(
//                                       color: Color(0x8A242222),
//                                       width: 1,
//                                     ),
//                                     borderRadius: 10,
//                                   ),
//                                 ),
//                                 Text(
//                                   '-',
//                                   style: FlutterFlowTheme.bodyText1.override(
//                                     fontFamily: 'Poppins',
//                                   ),
//                                 ),
//                                 FFButtonWidget(
//                                   onPressed: () async {
//                                     await DatePicker.showTime12hPicker(context,
//                                         showTitleActions: true, onConfirm: (date) {
//                                           setState(() => datePicked4 = DateFormat.jm().format(date));
//                                         }, currentTime: DateTime.now());
//                                   },
//                                   text: datePicked4.toString(),
//                                   options: FFButtonOptions(
//                                     width: 100,
//                                     height: 35,
//                                     color: Colors.white,
//                                     textStyle: FlutterFlowTheme.subtitle2.override(
//                                       fontFamily: 'Poppins',
//                                       color: Color(0xFF242224),
//                                     ),
//                                     borderSide: BorderSide(
//                                       color: Color(0x8A242222),
//                                       width: 1,
//                                     ),
//                                     borderRadius: 10,
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.max,
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     'Tuesday',
//                                     style: FlutterFlowTheme.bodyText1.override(
//                                       fontFamily: 'Poppins',
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
//                                   child: Text(
//                                     ':',
//                                     style: FlutterFlowTheme.bodyText1.override(
//                                       fontFamily: 'Poppins',
//                                     ),
//                                   ),
//                                 ),
//                                 FFButtonWidget(
//                                   onPressed: () async {
//                                     await DatePicker.showTime12hPicker(context,
//                                         showTitleActions: true, onConfirm: (date) {
//                                           setState(() => datePicked5 = DateFormat.jm().format(date));
//                                         }, currentTime: DateTime.now());
//                                   },
//                                   text: datePicked5.toString(),
//                                   options: FFButtonOptions(
//                                     width: 100,
//                                     height: 35,
//                                     color: Colors.white,
//                                     textStyle: FlutterFlowTheme.subtitle2.override(
//                                       fontFamily: 'Poppins',
//                                       color: Color(0xFF242224),
//                                     ),
//                                     borderSide: BorderSide(
//                                       color: Color(0x8A242222),
//                                       width: 1,
//                                     ),
//                                     borderRadius: 10,
//                                   ),
//                                 ),
//                                 Text(
//                                   '-',
//                                   style: FlutterFlowTheme.bodyText1.override(
//                                     fontFamily: 'Poppins',
//                                   ),
//                                 ),
//                                 FFButtonWidget(
//                                   onPressed: () async {
//                                     await DatePicker.showTime12hPicker(context,
//                                         showTitleActions: true, onConfirm: (date) {
//                                           setState(() => datePicked6 = DateFormat.jm().format(date));
//                                         }, currentTime: DateTime.now());
//                                   },
//                                   text: datePicked6.toString(),
//                                   options: FFButtonOptions(
//                                     width: 100,
//                                     height: 35,
//                                     color: Colors.white,
//                                     textStyle: FlutterFlowTheme.subtitle2.override(
//                                       fontFamily: 'Poppins',
//                                       color: Color(0xFF242224),
//                                     ),
//                                     borderSide: BorderSide(
//                                       color: Color(0x8A242222),
//                                       width: 1,
//                                     ),
//                                     borderRadius: 10,
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.max,
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     'Wednesday',
//                                     style: FlutterFlowTheme.bodyText1.override(
//                                       fontFamily: 'Poppins',
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
//                                   child: Text(
//                                     ':',
//                                     style: FlutterFlowTheme.bodyText1.override(
//                                       fontFamily: 'Poppins',
//                                     ),
//                                   ),
//                                 ),
//                                 FFButtonWidget(
//                                   onPressed: () async {
//                                     await DatePicker.showTime12hPicker(context,
//                                         showTitleActions: true, onConfirm: (date) {
//                                           setState(() => datePicked7 = DateFormat.jm().format(date));
//                                         }, currentTime: DateTime.now());
//                                   },
//                                   text: datePicked7.toString(),
//                                   options: FFButtonOptions(
//                                     width: 100,
//                                     height: 35,
//                                     color: Colors.white,
//                                     textStyle: FlutterFlowTheme.subtitle2.override(
//                                       fontFamily: 'Poppins',
//                                       color: Color(0xFF242224),
//                                     ),
//                                     borderSide: BorderSide(
//                                       color: Color(0x8A242222),
//                                       width: 1,
//                                     ),
//                                     borderRadius: 10,
//                                   ),
//                                 ),
//                                 Text(
//                                   '-',
//                                   style: FlutterFlowTheme.bodyText1.override(
//                                     fontFamily: 'Poppins',
//                                   ),
//                                 ),
//                                 FFButtonWidget(
//                                   onPressed: () async {
//                                     await DatePicker.showTime12hPicker(context,
//                                         showTitleActions: true, onConfirm: (date) {
//                                           setState(() => datePicked8 = DateFormat.jm().format(date));
//                                         }, currentTime: DateTime.now());
//                                   },
//                                   text: datePicked8.toString(),
//                                   options: FFButtonOptions(
//                                     width: 100,
//                                     height: 35,
//                                     color: Colors.white,
//                                     textStyle: FlutterFlowTheme.subtitle2.override(
//                                       fontFamily: 'Poppins',
//                                       color: Color(0xFF242224),
//                                     ),
//                                     borderSide: BorderSide(
//                                       color: Color(0x8A242222),
//                                       width: 1,
//                                     ),
//                                     borderRadius: 10,
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.max,
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     'Thursday',
//                                     style: FlutterFlowTheme.bodyText1.override(
//                                       fontFamily: 'Poppins',
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
//                                   child: Text(
//                                     ':',
//                                     style: FlutterFlowTheme.bodyText1.override(
//                                       fontFamily: 'Poppins',
//                                     ),
//                                   ),
//                                 ),
//                                 FFButtonWidget(
//                                   onPressed: () async {
//                                     await DatePicker.showTime12hPicker(context,
//                                         showTitleActions: true, onConfirm: (date) {
//                                           setState(() => datePicked9 = DateFormat.jm().format(date));
//                                         }, currentTime: DateTime.now());
//                                   },
//                                   text: datePicked9.toString(),
//                                   options: FFButtonOptions(
//                                     width: 100,
//                                     height: 35,
//                                     color: Colors.white,
//                                     textStyle: FlutterFlowTheme.subtitle2.override(
//                                       fontFamily: 'Poppins',
//                                       color: Color(0xFF242224),
//                                     ),
//                                     borderSide: BorderSide(
//                                       color: Color(0x8A242222),
//                                       width: 1,
//                                     ),
//                                     borderRadius: 10,
//                                   ),
//                                 ),
//                                 Text(
//                                   '-',
//                                   style: FlutterFlowTheme.bodyText1.override(
//                                     fontFamily: 'Poppins',
//                                   ),
//                                 ),
//                                 FFButtonWidget(
//                                   onPressed: () async {
//                                     await DatePicker.showTime12hPicker(context,
//                                         showTitleActions: true, onConfirm: (date) {
//                                           setState(() => datePicked10 = DateFormat.jm().format(date));
//                                         }, currentTime: DateTime.now());
//                                   },
//                                   text: datePicked10.toString(),
//                                   options: FFButtonOptions(
//                                     width: 100,
//                                     height: 35,
//                                     color: Colors.white,
//                                     textStyle: FlutterFlowTheme.subtitle2.override(
//                                       fontFamily: 'Poppins',
//                                       color: Color(0xFF242224),
//                                     ),
//                                     borderSide: BorderSide(
//                                       color: Color(0x8A242222),
//                                       width: 1,
//                                     ),
//                                     borderRadius: 10,
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.max,
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     'Friday',
//                                     style: FlutterFlowTheme.bodyText1.override(
//                                       fontFamily: 'Poppins',
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
//                                   child: Text(
//                                     ':',
//                                     style: FlutterFlowTheme.bodyText1.override(
//                                       fontFamily: 'Poppins',
//                                     ),
//                                   ),
//                                 ),
//                                 FFButtonWidget(
//                                   onPressed: () async {
//                                     await DatePicker.showTime12hPicker(context,
//                                         showTitleActions: true, onConfirm: (date) {
//                                           setState(() => datePicked11 =DateFormat.jm().format(date));
//                                         }, currentTime: DateTime.now());
//                                   },
//                                   text: datePicked11.toString(),
//                                   options: FFButtonOptions(
//                                     width: 100,
//                                     height: 35,
//                                     color: Colors.white,
//                                     textStyle: FlutterFlowTheme.subtitle2.override(
//                                       fontFamily: 'Poppins',
//                                       color: Color(0xFF242224),
//                                     ),
//                                     borderSide: BorderSide(
//                                       color: Color(0x8A242222),
//                                       width: 1,
//                                     ),
//                                     borderRadius: 10,
//                                   ),
//                                 ),
//                                 Text(
//                                   '-',
//                                   style: FlutterFlowTheme.bodyText1.override(
//                                     fontFamily: 'Poppins',
//                                   ),
//                                 ),
//                                 FFButtonWidget(
//                                   onPressed: () async {
//                                     await DatePicker.showTime12hPicker(context,
//                                         showTitleActions: true, onConfirm: (date) {
//                                           setState(() => datePicked12 =DateFormat.jm().format(date));
//                                         }, currentTime: DateTime.now());
//                                   },
//                                   text:datePicked12.toString(),
//                                   options: FFButtonOptions(
//                                     width: 100,
//                                     height: 35,
//                                     color: Colors.white,
//                                     textStyle: FlutterFlowTheme.subtitle2.override(
//                                       fontFamily: 'Poppins',
//                                       color: Color(0xFF242224),
//                                     ),
//                                     borderSide: BorderSide(
//                                       color: Color(0x8A242222),
//                                       width: 1,
//                                     ),
//                                     borderRadius: 10,
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.max,
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     'Saturday',
//                                     style: FlutterFlowTheme.bodyText1.override(
//                                       fontFamily: 'Poppins',
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
//                                   child: Text(
//                                     ':',
//                                     style: FlutterFlowTheme.bodyText1.override(
//                                       fontFamily: 'Poppins',
//                                     ),
//                                   ),
//                                 ),
//                                 FFButtonWidget(
//                                   onPressed: () async {
//                                     await DatePicker.showTime12hPicker(context,
//                                         showTitleActions: true, onConfirm: (date) {
//                                           setState(() => datePicked13 = DateFormat.jm().format(date));
//                                         }, currentTime: DateTime.now());
//                                   },
//                                   text: datePicked13.toString(),
//                                   options: FFButtonOptions(
//                                     width: 100,
//                                     height: 35,
//                                     color: Colors.white,
//                                     textStyle: FlutterFlowTheme.subtitle2.override(
//                                       fontFamily: 'Poppins',
//                                       color: Color(0xFF242224),
//                                     ),
//                                     borderSide: BorderSide(
//                                       color: Color(0x8A242222),
//                                       width: 1,
//                                     ),
//                                     borderRadius: 10,
//                                   ),
//                                 ),
//                                 Text(
//                                   '-',
//                                   style: FlutterFlowTheme.bodyText1.override(
//                                     fontFamily: 'Poppins',
//                                   ),
//                                 ),
//                                 FFButtonWidget(
//                                   onPressed: () async {
//                                     await DatePicker.showTime12hPicker(context,
//                                         showTitleActions: true, onConfirm: (date) {
//                                           setState(() => datePicked14 =DateFormat.jm().format(date));
//                                         }, currentTime: DateTime.now());
//                                   },
//                                   text: datePicked14.toString(),
//                                   options: FFButtonOptions(
//                                     width: 100,
//                                     height: 35,
//                                     color: Colors.white,
//                                     textStyle: FlutterFlowTheme.subtitle2.override(
//                                       fontFamily: 'Poppins',
//                                       color: Color(0xFF242224),
//                                     ),
//                                     borderSide: BorderSide(
//                                       color: Color(0x8A242222),
//                                       width: 1,
//                                     ),
//                                     borderRadius: 10,
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//
//                           Padding(
//                             padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
//                             child: Container(
//                               width: double.infinity,
//                               height: 30,
//                               decoration: BoxDecoration(
//                                 color: Color(0xFFA6A6A6),
//                               ),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
//                                     child: Text(
//                                       'Shop Admins',
//                                       textAlign: TextAlign.start,
//                                       style: FlutterFlowTheme.bodyText1.override(
//                                         fontFamily: 'Poppins',
//                                         color: Colors.black,
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Container(
//                             height: 200,
//                             child: ListView.builder(
//                                 padding: EdgeInsets.zero,
//                                 scrollDirection: Axis.vertical,
//                                 itemCount: admins.length+1,
//                                 itemBuilder: (context,index){
//                                   TextEditingController admin$index=TextEditingController();
//                                   admin$index.text=index==(admins.length)?"":admins[index];
//                                   return    Padding(
//                                     padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
//                                     child: Container(
//                                       width: 350,
//                                       height: 40,
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(10),
//                                         border: Border.all(
//                                           color: Color(0x8A242222),
//                                         ),
//                                       ),
//                                       child: Padding(
//                                         padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
//                                         child: Row(
//                                           mainAxisSize: MainAxisSize.max,
//                                           mainAxisAlignment: MainAxisAlignment.start,
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Expanded(
//                                               child: TextFormField(
//                                                 // onFieldSubmitted: (value){
//                                                 //   setState(() {
//                                                 //     print(value);
//                                                 //   });
//                                                 // },
//                                                 controller: admin$index,
//                                                 obscureText: false,
//                                                 decoration: InputDecoration(
//                                                   hintText: 'admin email',
//                                                   hintStyle:
//                                                   FlutterFlowTheme.bodyText1.override(
//                                                     fontFamily: 'Poppins',
//                                                     fontSize: 12,
//                                                   ),
//
//                                                   enabledBorder: UnderlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                       color: Color(0x00000000),
//                                                       width: 1,
//                                                     ),
//                                                     borderRadius: const BorderRadius.only(
//                                                       topLeft: Radius.circular(4.0),
//                                                       topRight: Radius.circular(4.0),
//                                                     ),
//                                                   ),
//                                                   focusedBorder: UnderlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                       color: Color(0x00000000),
//                                                       width: 1,
//                                                     ),
//                                                     borderRadius: const BorderRadius.only(
//                                                       topLeft: Radius.circular(4.0),
//                                                       topRight: Radius.circular(4.0),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 style: FlutterFlowTheme.bodyText1.override(
//                                                   fontFamily: 'Poppins',
//                                                   fontSize: 12,
//                                                 ),
//                                               ),
//                                             ),
//                                             IconButton(onPressed: (){
//                                               if(index==(admins.length)){
//                                                 admins.add(admin$index.text);
//                                               }
//                                               else{
//                                                 admins.removeAt(index);
//                                               }
//                                               setState(() {
//
//                                               });
//                                             }, icon: index==(admins.length)?Icon(Icons.add):Icon(Icons.delete))
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 }),
//                           ),
//                           Row(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               FFButtonWidget(
//                                 onPressed: () async {
//                                   final shopsAddData = createShopsRecordData(
//                                     imageUrl: uploadedFileUrl1,
//                                     name: textController1.text,
//                                     address: textController2.text,
//                                     phoneNumber:textController3.text,
//                                     email: textController4.text,
//                                     sunFrom:  datePicked1.toString(),
//                                     sunTo:  datePicked2.toString(),
//                                     monFrom:  datePicked3.toString(),
//                                     monTo:  datePicked4.toString(),
//                                     tueFrom:  datePicked5.toString(),
//                                     tueTo: datePicked6.toString(),
//                                     wedFrom:  datePicked7.toString(),
//                                     wedTo:  datePicked8.toString(),
//                                     thuFrom: datePicked9.toString(),
//                                     thuTo:  datePicked10.toString(),
//                                     friFrom:  datePicked11.toString(),
//                                     friTo: datePicked12.toString(),
//                                     satFrom:  datePicked13.toString(),
//                                     satTo:  datePicked14.toString(),
//                                     search: setSearchParam(textController1.text),
//                                     admins: convertListToListBuilder(admins),
//                                     branchId: "currentBranchId",
//                                     latitude: result.geometry.location.lat,
//                                     longitude: result.geometry.location.lng,
//                                   );
//                                   await shop.reference
//                                       .update(shopsAddData);
//                                   showUploadMessage(
//                                       context, 'Update Success!');
//                                 },
//                                 text: 'Update',
//                                 options: FFButtonOptions(
//                                   width: 350,
//                                   height: 25,
//                                   color: FlutterFlowTheme.secondaryColor,
//                                   textStyle: FlutterFlowTheme.subtitle2.override(
//                                     fontFamily: 'Poppins',
//                                     color: Colors.black,
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                   borderSide: BorderSide(
//                                     color: Colors.transparent,
//                                     width: 1,
//                                   ),
//                                   borderRadius: 10,
//                                 ),
//                               )
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//
//
//
//       ),
//     );
//   }
// }
