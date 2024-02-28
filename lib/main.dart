import 'dart:async';
import 'dart:convert' show Base64Encoder, utf8;
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:awafi_pos/firebase_options.dart';
import 'package:awafi_pos/return/sales_return.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esc_pos_printer_plus/esc_pos_printer_plus.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_usb_printer/flutter_usb_printer.dart';
import 'package:geocoding/geocoding.dart';
import 'package:awafi_pos/productandcat.dart';
import 'package:awafi_pos/purchase.dart';
import 'package:awafi_pos/reports/expense_reports.dart';
import 'package:awafi_pos/reports/purchase_reports.dart';
import 'package:awafi_pos/salesPrint/new_sales_print.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'Branches/branches.dart';
import 'DailyReport/dailyReport.dart';
import 'History/history.dart';
import 'auth/auth_util.dart';
import 'auth/firebase_user_provider.dart';
import 'backend/backend.dart';
import 'backend/settingModal.dart';
import 'bill.dart';
import 'expenses.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_widgets.dart';
import 'flutter_flow/upload_media.dart';
import 'login.dart';
import 'modals/user.dart';
import 'orders/live_orders.dart';
import 'orders/order_confirm.dart';
import 'orders/orders_widget.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import '../product_card.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:image/image.dart' as im;
import 'package:arabic_numbers/arabic_numbers.dart';

final sound='wegoaudio.mp3';
bool dinnerCertificate = false;
bool approve = false;
bool enable=false;
bool taped = false;
bool arabicLanguage=false;
final default_color=Colors.green[900];
bool _connected = false;
bool _pressed = false;
 bool offer =false;
int vendorId=0;
int productId=0;
bool bluetoothConnected=false;
int ?kotPrinter;
String ?currentUserId;
String ?currentUserName;
Map PosUserIdToName={};
Map PosUserIdToArabicName={};
var posUsers;
var credit;
Map<String,dynamic> creditMap={};
Map userMap={};

const logoPath="assets/pizzaromi512.png";

List<String> waitersName=[];

getWaiters() async {
  await FirebaseFirestore.instance
      .collection("waiter")
      .where('deleted',isEqualTo: false)
      .get()
  .then((value) {
    waitersName=[];
    for(var names in value.docs){
      waitersName.add(
          names.get("name")
      );
    }
  });
}
Map<String,dynamic> printers={};
getPosUser(){
  FirebaseFirestore.instance
      .collection('posUsers')
      .where('deleted',isEqualTo: false)
      .snapshots()
      .listen((event) {
        posUsers=event.docs;
    for(var doc in event.docs){
      PosUserIdToName[doc.id] = doc.get('name');
      PosUserIdToArabicName[doc.id] = doc.get('arabicName');
    }
  });
}
ScreenshotController screenshotController = ScreenshotController();
var capturedImage1;
var capturedhead;
var footerImage;
var itemImage;

List<im.Image> imageList=[];



setPrinterImages() async {
  while(printWidth==0){
    await Future.delayed(Duration(seconds: 1));
  }
  capturedImage1= await    screenshotController
      .captureFromWidget(Container(
    color: Colors.white,
    width: printWidth*3,
     height: 200,
    child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children:[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(currentBranchAddressArabic!,style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black, fontSize: fontSize+2,fontWeight: FontWeight.w600),)),
              Text(" : اسم الفرع",style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black, fontSize: fontSize+2,fontWeight: FontWeight.w600),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Branch Name: ",style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black, fontSize: fontSize+2,fontWeight: FontWeight.w600),),
              Expanded(child: Text(currentBranchAddress!,textAlign: TextAlign.end,style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black, fontSize: fontSize+2,fontWeight: FontWeight.w600),)),
            ],
          ),
          Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child:  Center(child: Text('-------------------------------------------',
                style: TextStyle(color: Colors.black,fontSize: printWidth*.25),))
          ),
          Text("☎️ $billMobileNo", style: TextStyle(color: Colors.black, fontSize: fontSize + 14, fontWeight: FontWeight.w600),textAlign: TextAlign.center),
          Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child:  Center(child: Text('-------------------------------------------',
                style: TextStyle(color: Colors.black,fontSize: printWidth*.25),))
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Text('Vat No:',style: TextStyle(color: Colors.black,fontSize: fontSize+2,fontWeight: FontWeight.w600),),
              Text(vatNumber!,style: TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
            ],),


        ]
    ),
  )
  );
  capturedhead = await screenshotController
      .captureFromWidget(Container(
    color: Colors.white,
    width: printWidth * 3,
    height: 85,
    padding: const EdgeInsets.only(top: 4),
    child: Column(
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //pdt
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('منتج',
                    style: TextStyle(
                      fontFamily: 'GE Dinar One Medium',
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Text('Product',
                    style: TextStyle(
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
                    style: TextStyle(
                        fontFamily: 'GE Dinar One Medium',
                        color: Colors.black,
                        fontSize: fontSize,
                        fontWeight: FontWeight.w600),
                  ),
                  Text('Qty',
                    style: TextStyle(
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
                    style: TextStyle(
                        fontFamily: 'GE Dinar One Medium',
                        color: Colors.black,
                        fontSize: fontSize,
                        fontWeight: FontWeight.w600),
                  ),
                  Text('Rate',
                    style: TextStyle(
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
                    style: TextStyle(
                        fontFamily: 'GE Dinar One Medium',
                        color: Colors.black,
                        fontSize: fontSize,
                        fontWeight: FontWeight.w600),
                  ),
                  Text('vat',
                    style: TextStyle(
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
                    style: TextStyle(
                        fontFamily: 'GE Dinar One Medium',
                        color: Colors.black,
                        fontSize: fontSize,
                        fontWeight: FontWeight.w600),
                  ),
                  Text('Total',
                    style: TextStyle(
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
        Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child:  Center(child: Text('-------------------------------------------',
              style: TextStyle(color: Colors.black,fontSize: printWidth*.25),))
        ),
      ],
    ),
  ));
  while(PosUserIdToArabicName[currentUserId]==null){
    await Future.delayed(Duration(seconds: 1));
  }
  print("finished");
  footerImage=await screenshotController
      .captureFromWidget(Container(
    width: printWidth * 3,
    height: printWidth*1.2 ,
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            SizedBox(height: 8,),
            Text('${PosUserIdToArabicName[currentUserId]}: المحاسب  ',
              style: TextStyle(color: Colors.black,
                fontSize: fontSize + 2,
                fontWeight: FontWeight.bold,),),
            Text('Cashier : ${PosUserIdToName[currentUserId]}',
              style: TextStyle(color: Colors.black,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold),),

            SizedBox(height: 8,),
            Text('شكرًا لزيارتك ونتشوق لرؤيتك مرة أخرى', style: TextStyle(
                fontFamily: 'GE Dinar One Medium',
                color: Colors.black,
                fontSize: fontSize + 3,
                fontWeight: FontWeight.w600),),
            Text('THANK YOU VISIT AGAIN', style: TextStyle(
                fontFamily: 'GE Dinar One Medium',
                color: Colors.black,
                fontSize: fontSize + 3,
                fontWeight: FontWeight.w600),),
          ],
        ),
      ],
    ),
  ));
}

// setPrinterImages() async {
//   while (printWidth == 0) {
//     await Future.delayed(const Duration(seconds: 1));
//   }
//   capturedImage1 = await screenshotController.captureFromWidget(Container(
//     height: 130,
//     color: Colors.white,
//     width: printWidth * 3,
//     child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         // shrinkWrap: true,
//         // physics: NeverScrollableScrollPhysics(),
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 currentBranchAddressArabic!,
//                 style: TextStyle(
//                     fontFamily: 'GE Dinar One Medium',
//                     color: Colors.black,
//                     fontSize: fontSize + 2,
//                     fontWeight: FontWeight.w600),
//               ),
//               Text(
//                 " : اسم الفرع",
//                 style: TextStyle(
//                     fontFamily: 'GE Dinar One Medium',
//                     color: Colors.black,
//                     fontSize: fontSize + 2,
//                     fontWeight: FontWeight.w600),
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Branch Name:",
//                 style: TextStyle(
//                     fontFamily: 'GE Dinar One Medium',
//                     color: Colors.black,
//                     fontSize: fontSize + 2,
//                     fontWeight: FontWeight.w600),
//               ),
//               Expanded(
//                 child: Text(
//                   currentBranchAddress!,
//                   style: TextStyle(
//                       fontFamily: 'GE Dinar One Medium',
//                       color: Colors.black,
//                       fontSize: fontSize + 2,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Contact No: ',
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: fontSize + 2,
//                     fontWeight: FontWeight.w600),
//               ),
//               Text(
//                 '$currentBranchPhNo ',
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: fontSize,
//                     fontWeight: FontWeight.w600),
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Vat No:',
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: fontSize + 2,
//                     fontWeight: FontWeight.w600),
//               ),
//               Text(
//                 vatNumber!,
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: fontSize,
//                     fontWeight: FontWeight.w600),
//               ),
//             ],
//           ),
//         ]),
//   ));
//   capturedhead = await screenshotController.captureFromWidget(Container(
//     color: Colors.white,
//     width: printWidth * 3,
//     height: 85,
//     padding: const EdgeInsets.only(top: 4),
//     child: Column(
//       children: [
//         //Heading (Product - Qty - Rate - vat - Total)
//         Row(
//           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               //Product
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'منتج',
//                     style: TextStyle(
//                       fontFamily: 'GE Dinar One Medium',
//                       fontSize: fontSize,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black,
//                     ),
//                   ),
//                   Text(
//                     'Product',
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: 'GE Dinar One Medium',
//                         fontSize: fontSize,
//                         fontWeight: FontWeight.w600),
//                   ),
//                 ],
//               ),
//             ),
//             //Qty
//             Container(
//               width: 45,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'كمية',
//                     style: TextStyle(
//                         fontFamily: 'GE Dinar One Medium',
//                         color: Colors.black,
//                         fontSize: fontSize,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   Text(
//                     'Qty',
//                     style: TextStyle(
//                         fontFamily: 'GE Dinar One Medium',
//                         color: Colors.black,
//                         fontSize: fontSize,
//                         fontWeight: FontWeight.w600),
//                   ),
//                 ],
//               ),
//             ),
//             //Rate
//             Container(
//               width: 45,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'سعر',
//                     style: TextStyle(
//                         fontFamily: 'GE Dinar One Medium',
//                         color: Colors.black,
//                         fontSize: fontSize,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   Text(
//                     'Rate',
//                     style: TextStyle(
//                         fontFamily: 'GE Dinar One Medium',
//                         color: Colors.black,
//                         fontSize: fontSize,
//                         fontWeight: FontWeight.w600),
//                   ),
//                 ],
//               ),
//             ),
//             //Vat
//             Container(
//               width: 45,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'ضريبة',
//                     style: TextStyle(
//                         fontFamily: 'GE Dinar One Medium',
//                         color: Colors.black,
//                         fontSize: fontSize,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   Text(
//                     'vat',
//                     style: TextStyle(
//                         fontFamily: 'GE Dinar One Medium',
//                         color: Colors.black,
//                         fontSize: fontSize,
//                         fontWeight: FontWeight.w600),
//                   ),
//                 ],
//               ),
//             ),
//
//             //Total
//             Container(
//               width: 50,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'المجموع',
//                     style: TextStyle(
//                         fontFamily: 'GE Dinar One Medium',
//                         color: Colors.black,
//                         fontSize: fontSize,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   Text(
//                     'Total',
//                     style: TextStyle(
//                         fontFamily: 'GE Dinar One Medium',
//                         color: Colors.black,
//                         fontSize: fontSize,
//                         fontWeight: FontWeight.w600),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         Container(
//             decoration: const BoxDecoration(
//               color: Colors.white,
//             ),
//             child: Center(
//                 child: Text(
//                   '-------------------------------------------',
//                   style: TextStyle(color: Colors.black, fontSize: printWidth * .25),
//                 ))),
//       ],
//     ),
//   ));
//   while (PosUserIdToArabicName[currentUserId] == null) {
//     await Future.delayed(Duration(seconds: 1));
//   }
//   footerImage = await screenshotController.captureFromWidget(Container(
//     width: printWidth * 3,
//     height: printWidth + 30,
//     color: Colors.white,
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Column(
//           children: [
//             SizedBox(
//               height: 8,
//             ),
//             Text(
//               '${PosUserIdToArabicName[currentUserId]}: المحاسب  ',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: fontSize + 2,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               "Cashier :", // ${PosUserIdToName[currentUserId]}",
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: fontSize,
//                   fontWeight: FontWeight.bold),
//             ),
//             SizedBox(
//               height: 8,
//             ),
//             Text(
//               'شكرًا لزيارتك ونتشوق لرؤيتك مرة أخرى',
//               style: TextStyle(
//                   fontFamily: 'GE Dinar One Medium',
//                   color: Colors.black,
//                   fontSize: fontSize + 3,
//                   fontWeight: FontWeight.w600),
//             ),
//             Text(
//               'THANK YOU VISIT AGAIN',
//               style: TextStyle(
//                   fontFamily: 'GE Dinar One Medium',
//                   color: Colors.black,
//                   fontSize: fontSize + 3,
//                   fontWeight: FontWeight.w600),
//             ),
//           ],
//         ),
//       ],
//     ),
//   ));
// }

ingredientsUpdate(List billItems){
  for(var a in billItems){
    for(var b in a['ingredients']??[]){
      FirebaseFirestore.instance.collection("ingredients").doc(b['ingredientId']).update({
        "quantity":FieldValue.increment(-1*((b['quantity'])*a['qty'])),
      });
    }
    for(var b in a['variants']??[]){
      for(var c in b['ingredients']??[]){
        FirebaseFirestore.instance.collection("ingredients").doc(c['ingredientId']).update({
          "quantity":FieldValue.increment(-1*(c['quantity']*a['qty'])),
        });
      }
    }
  }
}
bool blue=false;
ByteData? data;
ByteData? data1;
double charset = 0;
double qrCode = 0;
double size = 0;
String? heading;
String? topImage;
bool disable = false;
bool product = false;

Stream? categoryChange;
double xOffset = 0;
double yOffset = 0;
int count=300;
double scaleFactor = 1;
String discount = '';
String delivery = '';
int? table;
List items = [];
final primaryColor = Colors.green[900];
const secondaryColor = Colors.black;
bool isDrawerOpen = false;
QuerySnapshot? branches;
//List shippingAddress = [];
int selectedShippingAddress = 0;
User? currentUserModel;
String? loggedInAs;
String? promoCode;
String? branchName;
bool fromBucket = false;
bool products = false;
int noOfAlerts = 0;
double fontSize = 0;
double printWidth=0;
double qr=0;
int paymentMethod = 0;
String currentPage = 'HomePage';
DesignSettings? currentSetting;
Function? homeSet;
Placemark? plcmrk;
String selectedTable = '1';
bool keyboard = false;
int selectedTableIndex = 0;
bool cash = true;
bool bank = false;
double totalAmount = 0;
String tableName='';
double gst = 15;
String webApi = "AIzaSyDMik73EbwPr20maocafDBHS6GjccIMuUA";
List<Map<String, dynamic>> devices = [];
FlutterUsbPrinter flutterUsbPrinter = FlutterUsbPrinter();
bool connected = false;
bool pressed = false;
bool lastCut = false;
BlueThermalPrinter? bluetooth ;
List<BluetoothDevice> btDevices = [];
BluetoothDevice? device;
int itemCount=5;
bool display_image=true;
Map<String,dynamic> allCategories={};
double cashPaid=0;
double bankPaid=0;
double balance=0;


// var capturedImage1;
var capturedImage2;
var capturedImage3;
var capturedImage5;
var capturedImage6;
var capturedImage7;
var capturedImage8;
var capturedImage9;
var capturedImage10;
var capturedImage11;
var capturedImage13;
var capturedImage23;
var capturedImage33;
var capturedImage43;
bool notificationArrived=false;
AndroidNotificationChannel channel=const AndroidNotificationChannel(
    'high_importance_channel',
    // 'High importance Notifications',
    'this is a channel test',
    importance: Importance.high,
    playSound: true,
    sound:RawResourceAndroidNotificationSound("wegoaudio"),
    enableVibration: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =FlutterLocalNotificationsPlugin();
Future<void>_firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  notificationArrived=true;

}
Future<void> main() async {
  if(Platform.isAndroid){
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await FirebaseMessaging.instance.subscribeToTopic('admin-app');
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    // The following lines are the same as previously explained in "Handling uncaught errors"
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    runApp( HomePage());
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
  }
  else{
      WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp( HomePage());
  }
}


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  _HomePageState createState() => _HomePageState();
}
String? dropdownvalue;
String? currentWaiter;
String? bankValue;

var abcd = [
  'Take Away',
  'Dine-In',
  'Drive-Thru',
];

var bankOptions=["Select","AMEX","VISA","MASTER","MADA"];
int? DelCharge;
class _HomePageState extends State<HomePage> {

  List<Map<String, dynamic>> devices = [];
  FlutterUsbPrinter flutterUsbPrinter = FlutterUsbPrinter();
  DhaboEcommerceFirebaseUser? initialUser;
  Stream<DhaboEcommerceFirebaseUser>? userStream;

printerr() async {
  // const PaperSize paper = PaperSize.mm80;
  // var profile = await CapabilityProfile.load();
  // printer = NetworkPrinter(paper, profile);
}

  // addRef() async {
  //   var data = await FirebaseFirestore.instance.collection("category").get();
  //   for(var element in data.docs){
  //     element.reference.update({
  //       "reference": element.reference
  //     });
  //   }
  // }

  @override
  void initState() {
    // addRef();

    printerr();
    try{

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {

        RemoteNotification? notification =message.notification;
        AndroidNotification? android =message.notification?.android;
        if(notification!=null && android !=null){

          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                  android: AndroidNotificationDetails(
                    channel.id,
                    channel.name,
                    // channel.description,
                    color:Colors.blue,
                    playSound: true,
                    icon: '@mipmap/ic_launcher',
                    sound:RawResourceAndroidNotificationSound("wegoaudio"),
                  )
              ));
        }
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
        RemoteNotification? notification =message.notification;
        AndroidNotification? android =message.notification?.android;
        if(notification!=null && android !=null){

          setState(() {
            notificationArrived=true;
            // orderData =json.decode(message.data['extradata']);
          });


        }
        else{
          print('else');
        }
      });
    }
    catch(exception){
      print(exception);
    }
    super.initState();
    getPrintImages();
    userStream = dhaboEcommerceFirebaseUserStream()
      ..listen((user) => initialUser ?? setState(() => initialUser = user));
  }

  set() {
    setState(() {});
  }

  getPrintImages() async {
  print("print image");
    data = await rootBundle.load('assets/as.jpg');
    data1 = await rootBundle.load('assets/as.jpg');
  }



  @override
  Widget build(BuildContext context) {
    // if (initialUser != null) {
    //   if (initialUser.loggedIn) {
    //     print('-------------------------------------------------');
    //     loggedInAs = "Google";
    //     maybeCreateUser(initialUser.user).then((value) {
    //       setState(() {});
    //     });
    //   }
    // }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      ),
      home: initialUser == null
          ? const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xff4b39ef)),
        ),
      )
          : currentUser!.loggedIn && currentUserModel != null
          ? const HomeBody()
          : const Login(),
      // :HomeBody(),
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {

  ArabicNumbers arabicNumber = ArabicNumbers();

  List<String> tables = [];
  TextEditingController mobileNo = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController deliveryCharge = TextEditingController();
  TextEditingController paidCash= TextEditingController();
  TextEditingController paidBank = TextEditingController();
  TextEditingController tableController = TextEditingController();
  TextEditingController amex = TextEditingController();
  TextEditingController mada = TextEditingController();
  TextEditingController visa = TextEditingController();
  TextEditingController master = TextEditingController();

  double amexPaid=0;
  double masterPaid=0;
  double visaPaid=0;
  double madaPaid=0;

  _getDevicelist() async {
    List<Map<String, dynamic>> results = [];
    results = await FlutterUsbPrinter.getUSBDeviceList();
    for (dynamic device in results) {
      _connect(int.parse(device['vendorId']), int.parse(device['productId']));
    }
    if (mounted) {
      setState(() {
        devices = results;
      });
    }
  }

  bool working=false;
  Future setItemWidgets1(List items) async {
    while (working) {
      await Future.delayed(const Duration(milliseconds: 300));
    }
    working = true;

    List itemWidgets1 = [];
    imageList = [];

    for (Map<String, dynamic> item in items) {
      double addOnPrice =  item['addOnPrice']??0-item['removePrice']??0-item['addLessPrice']??0+item['addMorePrice']??0;
      double total = (double.tryParse(item['price'].toString()) ?? 0.0) +
          addOnPrice * (double.tryParse(item['qty'].toString()) ?? 0.0);

      double grossTotal = total * 100 / 115;
      double vat = (double.tryParse(item['price'].toString())! + addOnPrice) *
          15 /
          115;
      List newAddOn = item['addOns']??''+item['addLess']??''+item['addMore']??''+item['remove']??'';
      String arabic = item['arabicName'];
      String english = item['pdtname'];


      newAddOn = item['addOns']??''+item['addLess']??''+item['addMore']??''+item['remove']??'';
      newAddOnArabic = item['addOnArabic']??''+item['addLessArabic']??''+item['addMoreArabic']??''+item['removeArabic']??'';      String addOnArabic = newAddOnArabic.isEmpty ? '' : newAddOnArabic
          .toString();
      String addON = newAddOn.isEmpty ? '' : newAddOn.toString();
      double price = (double.tryParse(item['price'].toString())! + addOnPrice) *
          100 / 115;

      itemWidgets1.add(Container(
          width: printWidth * 3,
          padding: const EdgeInsets.all(1.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
              // shrinkWrap: true,
              children: [
                Container(
                  width: printWidth * 3,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('$arabic $addOnArabic',
                                  // textDirection: TextDirection.rtl,
                                  style: const TextStyle(
                                    fontFamily: 'GE Dinar One Medium',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                Text('$english $addON',
                                  // textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontFamily: 'GE Dinar One Medium',
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),

                              ],
                            ),
                          ),


                          Container(
                            width: 45,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text('${arabicNumber.convert(double.tryParse(item['qty'].toString()).toStringAsFixed(2))}',
                                //   style:  TextStyle(
                                //       fontFamily: 'GE Dinar One Medium',
                                //       color: Colors.black,
                                //       fontSize: fontSize+2,
                                //       fontWeight: FontWeight.w600),
                                // ),
                                Text(
                                  '${double.tryParse(item['qty'].toString())}',
                                  style: TextStyle(
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
                                // Text('${arabicNumber.convert(price.toStringAsFixed(2))} ',
                                //   style:  TextStyle(
                                //       fontFamily: 'GE Dinar One Medium',
                                //       color: Colors.black,
                                //       fontSize: fontSize+2,
                                //       fontWeight: FontWeight.w600),
                                // ),
                                Text('${price.toStringAsFixed(2)} ',
                                  style: TextStyle(
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
                                // Text('${arabicNumber.convert(vat.toStringAsFixed(2))}',
                                //   style:  TextStyle(
                                //       fontFamily: 'GE Dinar One Medium',
                                //       color: Colors.black,
                                //       fontSize: fontSize+2,
                                //       fontWeight: FontWeight.w600),
                                // ),
                                Text('${vat.toStringAsFixed(2)}',
                                  style: TextStyle(
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
                                // Text('${arabicNumber.convert(total.toStringAsFixed(2))}',
                                //   style:  TextStyle(
                                //       fontFamily: 'GE Dinar One Medium',
                                //       color: Colors.black,
                                //       fontSize: fontSize+2,
                                //       fontWeight: FontWeight.w600),
                                // ),
                                Text(total.toStringAsFixed(2),
                                  style: TextStyle(
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
                      const SizedBox(height: 10)
                    ],
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
          )
      ));

      if (itemWidgets1.length == itemCount) {
        itemImage = await screenshotController
            .captureFromWidget(Container(
          width: printWidth * 3,
          child: Column(
              // shrinkWrap: true,
            mainAxisSize: MainAxisSize.min,
              children:List.generate(itemWidgets1.length, (index) {
                return itemWidgets1[index];
              })


              ),

        ));

        final im.Image? image22 = im.decodeImage(itemImage);
        imageList.add(image22!);
        itemWidgets1 = [];
      }
    }
    if (itemWidgets1.isNotEmpty) {

      var capturedIm = await screenshotController
          .captureFromWidget(Container(
        width: printWidth * 3,

        child: Column(
            mainAxisSize: MainAxisSize.min,
            children:List.generate(itemWidgets1.length, (index) {
              return itemWidgets1[index];
            })
        )
      ));

      final im.Image? image22 = im.decodeImage(capturedIm);
      imageList.add(image22!);

      itemWidgets1 = [];
    }
    if (itemWidgets1.isEmpty) {
      setState(() {
        enable = true;
        print("enaable---------------------------");
        print(enable);
      });
    }

    working = false;
  }
  setItemWidgets(List items) async {

    while(working){
      await Future.delayed(const Duration(milliseconds: 300));
    }
    print("starrrrrrrrrrrrrrrrrrrrt");
    print(DateTime.now());
    working=true;

    List itemWidgets1=[];
    imageList=[];

    for (Map<String, dynamic> item in items) {
      double addOnPrice =  item['addOnPrice']??0-item['removePrice']??0-item['addLessPrice']??0+item['addMorePrice']??0;
      double total = (double.tryParse(item['price'].toString()) ?? 0.0) +
          addOnPrice * (double.tryParse(item['qty'].toString()) ?? 0.0);

      double grossTotal = total * 100 / 115;
      double vat = (double.tryParse(item['price'].toString())! + addOnPrice) * 15 /
          115;
      List newAddOn = item['addOns']??''+item['addLess']??''+item['addMore']??''+item['remove']??'';

      String arabic = item['arabicName']+" "+item["variantNameArabic"];
      String english = item['pdtname']+" "+item["variantName"];



      newAddOn = item['addOns']??''+item['addLess']??''+item['addMore']??''+item['remove']??'';
      newAddOnArabic = item['addOnArabic']??''+item['addLessArabic']??''+item['addMoreArabic']??''+item['removeArabic']??'';      String addOnArabic = newAddOnArabic.isEmpty ? '' : newAddOnArabic.toString();
      String addON = newAddOn.isEmpty ? '' : newAddOn.toString();
      double price = (double.tryParse(item['price'].toString())! + addOnPrice)! *
          100 / 115;

      itemWidgets1.add(Container(
              width: printWidth * 3,
              padding: const EdgeInsets.all(1.0),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),

              child:  Column(mainAxisSize: MainAxisSize.min, children: [
              // ListView(
              //     shrinkWrap: true,
              //     children: [
                    Container(
                      width: printWidth*3,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('$arabic $addOnArabic',
                                      // textDirection: TextDirection.rtl,
                                      style:  const TextStyle(
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


                              Container(
                                width: 45,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text('${arabicNumber.convert(double.tryParse(item['qty'].toString()).toStringAsFixed(2))}',
                                    //   style:  TextStyle(
                                    //       fontFamily: 'GE Dinar One Medium',
                                    //       color: Colors.black,
                                    //       fontSize: fontSize+2,
                                    //       fontWeight: FontWeight.w600),
                                    // ),
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
                                    // Text('${arabicNumber.convert(price.toStringAsFixed(2))} ',
                                    //   style:  TextStyle(
                                    //       fontFamily: 'GE Dinar One Medium',
                                    //       color: Colors.black,
                                    //       fontSize: fontSize+2,
                                    //       fontWeight: FontWeight.w600),
                                    // ),
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
                                    // Text('${arabicNumber.convert(vat.toStringAsFixed(2))}',
                                    //   style:  TextStyle(
                                    //       fontFamily: 'GE Dinar One Medium',
                                    //       color: Colors.black,
                                    //       fontSize: fontSize+2,
                                    //       fontWeight: FontWeight.w600),
                                    // ),
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
                                    // Text('${arabicNumber.convert(total.toStringAsFixed(2))}',
                                    //   style:  TextStyle(
                                    //       fontFamily: 'GE Dinar One Medium',
                                    //       color: Colors.black,
                                    //       fontSize: fontSize+2,
                                    //       fontWeight: FontWeight.w600),
                                    // ),
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
                          SizedBox(height:10)
                        ],
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
              )
          ));
      if (itemWidgets1.length == itemCount) {
        itemImage = await screenshotController
            .captureFromWidget(Container(
          width: printWidth * 3,

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(itemWidgets1.length, (index) {
              return itemWidgets1[index];
            }),
          ),
          // ListView.builder(
          //     shrinkWrap: true,
          //     itemCount: itemWidgets1.length,
          //     itemBuilder: (context, index) {
          //       return itemWidgets1[index];
          //     }),
        ));

        final im.Image image22 = im.decodeImage(itemImage)!;
        imageList.add(image22);
        itemWidgets1 = [];
      }



    }
    if (itemWidgets1.isNotEmpty) {
      var capturedIm = await screenshotController
          .captureFromWidget(Container(
        width: printWidth * 3,

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(itemWidgets1.length, (index) {
            return itemWidgets1[index];
          }),
        ),
        // ListView.builder(
        //     shrinkWrap: true,
        //     itemCount: itemWidgets1.length,
        //     itemBuilder: (context, index) {
        //       return itemWidgets1[index];
        //     }),
      ));

      final im.Image? image22 = im.decodeImage(capturedIm);
      imageList.add(image22!);

      itemWidgets1 = [];
    }
    if (itemWidgets1.isEmpty) {

      setState(() {
        enable = true;

      });
    }
    working=false;

  }


  List<int> bytes = [];
  List<int> kotBytes = [];

  counter() async {

    for(int i=count;i>0;i--){
      await Future.delayed(const Duration(seconds: 1));
      if(i==5){

        final CapabilityProfile profile = await CapabilityProfile.load();
        final generator = Generator(PaperSize.mm80, profile);

        bytes=generator.beep(duration: PosBeepDuration.beep50ms,n:1 );
        flutterUsbPrinter.write(Uint8List.fromList(bytes));
        bytes=[];
        i=count;
      }

    }
  }


List previousItems=[];
@override
  void deactivate() {
  print("deactivate");
  // countVar=0;
    super.deactivate();
  }
  @override
  void dispose() {


    super.dispose();
  }
  // ScreenshotController screenshotController = ScreenshotController();
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
    String time =DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(DateTime.now());
    List<int> date = utf8.encode(time);
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

  abc(int invNo,double discount,List items,int token,String selectedTable,
      double deliveryAmount,double pc,double pb,double bal,double netTotal,
      String dropdownvalue, ) async {
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
  bytes += generator.imageRaster(image1!,);

  capturedImage10= await    screenshotController
      .captureFromWidget(Container(
    color: Colors.white,
    width: printWidth*3,
    child: Column(
        mainAxisSize: MainAxisSize.min,
        // shrinkWrap: true,
        // physics: NeverScrollableScrollPhysics(),
        children:[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Date :', style: TextStyle(color: Colors.black, fontSize: fontSize + 2, fontWeight: FontWeight.w600),),
              Text('${DateTime.now().toString().substring(0, 19)}', style: TextStyle(color: Colors.black, fontSize: fontSize, fontWeight: FontWeight.w600),),

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
            children:  [
              Text('Invoice No:',style: TextStyle(color: Colors.black,fontSize: fontSize+5,fontWeight: FontWeight.w600),),
              Text('$invNo',style: TextStyle(color: Colors.black,fontSize: fontSize+5,fontWeight: FontWeight.w600),),
            ],),
        ]
    ),
  ));
  //
  final im.Image? image10 = im.decodeImage(capturedImage10);
  bytes += generator.imageRaster(image10!);

  bytes +=generator.text("-------------------------------------------",styles: PosStyles(bold: true,align: PosAlign.center,height: PosTextSize.size2,));
  bytes +=generator.text("ORDER TYPE : $dropdownvalue",styles: PosStyles(bold: true,align: PosAlign.center,height: PosTextSize.size2,width: PosTextSize.size2));
  bytes +=generator.text("-------------------------------------------",styles: PosStyles(bold: true,align: PosAlign.center,height: PosTextSize.size2,));


  print(DateTime.now());

  final im.Image? imagehead = im.decodeImage(capturedhead);
  bytes += generator.imageRaster(imagehead!,);


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
  //
  Map<String, dynamic> config = Map();
  List<Widget> itemWidgets = [];
  List<Widget> itemWidgets1 = [];
  for (Map<String, dynamic> item in items) {
    addOnPrice =  item['addOnPrice']??0-item['removePrice']??0-item['addLessPrice']??0+item['addMorePrice']??0;
    double total = (double.tryParse(item['price'].toString()) !+ addOnPrice) * double.tryParse(item['qty'].toString())!;
    double grossTotal = total * 100 / 115;
    double vat = (double.tryParse(item['price'].toString())! + addOnPrice) * 15 / 115;
    newAddOn = item['addOns']??''+item['addLess']??''+item['addMore']??''+item['remove']??'';

    arabic = item['arabicName'];
    english = item['pdtname'];


    grantTotal += total;

    deliveryCharge = item['deliveryCharge'] == null ? 0 : double.tryParse(item['deliveryCharge'].toString());
    newAddOn = item['addOns']??''+item['addLess']??''+item['addMore']??''+item['remove']??'';

    newAddOnArabic = item['addOnArabic']??''+item['addLessArabic']??''+item['addMoreArabic']??''+item['removeArabic']??'';    addOnArabic = newAddOnArabic.isEmpty ? '' : newAddOnArabic.toString();
    addON = newAddOn.isEmpty ? '' : newAddOn.toString();
    double price = (double.tryParse(item['price'].toString())! + addOnPrice) * 100 / 115;
    totalAmount += price * double.tryParse(item['qty'].toString())!;
    itemTotal += (totalAmount * ((100 + gst) / 100) - (double.tryParse(discount.toString()) ?? 0)).toStringAsFixed(2);
    itemGrossTotal += grossTotal.toStringAsFixed(2);
    itemTax += (totalAmount * gst / 100).toStringAsFixed(2);
  }


  for(im.Image a in imageList){
    bytes += generator.imageRaster(a);
  }



  itemWidgets.add(
      Column(
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
                Text('${(totalAmount * gst / 100).toStringAsFixed(2)}',style:  TextStyle(color: Colors.black,fontSize: fontSize+4,fontWeight: FontWeight.w600),),
              ],
            ),),
          Container(    padding: const EdgeInsets.all(1.0),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child:     Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Delivery Charge - رسوم التوصيل : ',style:  TextStyle(color: Colors.black,fontSize: fontSize+4,fontWeight: FontWeight.w600),),
                Text('${deliveryAmount.toStringAsFixed(2)}',style:  TextStyle(color: Colors.black,fontSize: fontSize+4,fontWeight: FontWeight.w600),),
              ],
            ),),
          Container(
            padding: const EdgeInsets.all(1.0),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Discount -  خصم  : ', style: TextStyle(color: Colors.black, fontSize: fontSize+4, fontWeight: FontWeight.w600),),
                Text((discount == null ? "0.00" : (discount).toStringAsFixed(2)), style: TextStyle(color: Colors.black, fontSize: fontSize+4, fontWeight: FontWeight.w600),),

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
          Container(    padding: const EdgeInsets.all(1.0),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child:     Center(
              child:  Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children:   [
                  Text('Cash      :  ${pc.toStringAsFixed(2)}',style:  TextStyle(color: Colors.black,fontSize: fontSize+2,fontWeight: FontWeight.w600),),
                  Text('Bank      :  ${pb.toStringAsFixed(2)}',style:  TextStyle(color: Colors.black,fontSize: fontSize+2,fontWeight: FontWeight.w600),),
                  Text('Change :  ${bal.toStringAsFixed(2)}',style:  TextStyle(color: Colors.black,fontSize: fontSize+2,fontWeight: FontWeight.w600),),
                  // Text('Waiter   :  ${currentWaiter}',style:  TextStyle(color: Colors.black,fontSize: fontSize+2,fontWeight: FontWeight.w600),),

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
      )
  );


  String qrVat = (totalAmount * gst / 100).toStringAsFixed(2);
  String qrTotal = (grantTotal - (double.tryParse(discount.toString()) ?? 0) +
      (deliveryAmount ?? 0)).toStringAsFixed(2);

  // itemWidgets.add(
  //     Container(
  //       color: Colors.white,
  //       width: printWidth * 2.4,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           QrImageView(
  //
  //             data: qr(qrVat, qrTotal),
  //             version: 6,
  //             size: size/1.5,
  //           )
  //
  //         ],
  //       ),
  //     )
  // );

  itemWidgets.add(Container(
    height: qrCode + 100,
    width: printWidth * 3.1,
    color: Colors.white,
    // width: qrCode,
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




  // var capturedImage2 = await screenshotController
  //     .captureFromWidget(Container(
  //   width: printWidth * 3,
  //
  //   child: ListView.builder(
  //       shrinkWrap: true,
  //       itemCount: itemWidgets.length,
  //       itemBuilder: (context, index) {
  //         return itemWidgets[index];
  //       }),
  // ));


  var capturedImage2 = await screenshotController
      .captureFromWidget(Container(
      width: printWidth * 3,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(itemWidgets.length, (index) {
            return itemWidgets[index];
          }),
          ),
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
      }
      else{
        print("end");
        print(DateTime.now());
      }
    }

  }
  catch (ex) {
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
            styles: const PosStyles(align: PosAlign.center,height: PosTextSize.size2,width: PosTextSize.size2,));
         bytes += generator.feed(1);
        bytes += generator.text(
            'Date : ${DateTime.now().toString().substring(0, 16)}',
            styles: const PosStyles(align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size2));
         bytes += generator.feed(1);
        bytes += generator.text('Invoice No : $invNo',
            styles: const PosStyles(align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size2));
         bytes += generator.feed(1);
    bytes += generator.text('Order Type : $dropdownvalue',
            styles: const PosStyles(align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size2));
         bytes += generator.feed(1);
         if(dropdownvalue!="Take Away"){
           bytes += generator.text('Table No : $selectedTable',styles: const PosStyles(align: PosAlign.center, height: PosTextSize.size1, width: PosTextSize.size2));
           bytes += generator.feed(1);
         }
         bytes += generator.text('=======================', styles: const PosStyles(align: PosAlign.center, height: PosTextSize.size1, width: PosTextSize.size2));
         bytes += generator.feed(2);


        for (Map<String, dynamic> item in items) {
          if (categoryLists.contains(item['category'])) {
            List includeKot=item['addOns']??[];
            List addLessKot=item['addLess']??[];
            List addMoreKot=item['addMore']??[];
            List removeKot=item['remove']??[];
            // newAddOn = item['addOns'];
            // newAddOnArabic = item['addOnArabic'];
            addON = newAddOn.isEmpty ? '' : newAddOn.toString();
            bytes += generator.text("${int.tryParse(item['qty'].toString())} x ${item['pdtname']} ",styles: const PosStyles(height: PosTextSize.size1,width: PosTextSize.size2));
            bytes += generator.feed(1);
            if (includeKot.isNotEmpty){
              bytes += generator.text( "Include :$includeKot",styles: const PosStyles(align: PosAlign.left,height: PosTextSize.size1,width: PosTextSize.size2));
            }
            if (addLessKot.isNotEmpty){
              bytes += generator.text( "Add Less :$addLessKot",styles: const PosStyles(align: PosAlign.left,height: PosTextSize.size1,width: PosTextSize.size2));
            }
            if (addMoreKot.isNotEmpty){
              bytes += generator.text( "Add More :$addMoreKot",styles: const PosStyles(align: PosAlign.left,height: PosTextSize.size1,width: PosTextSize.size2));
            }
            if (removeKot.isNotEmpty){
              bytes += generator.text( "Remove :$removeKot",styles: const PosStyles(align: PosAlign.left,height: PosTextSize.size1,width: PosTextSize.size2));
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
        printSuccess = await flutterUsbPrinter.write(Uint8List.fromList(bytes));

        i++;
        if (!printSuccess!) {

          await _getDevicelist();
          await Future.delayed(Duration(milliseconds: 200));
        }
        else{
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
            PosPrintResult res = await printer1.connect(
                ip, port: port, timeout: const Duration(seconds: 10));
            int j=0;
            while (res != PosPrintResult.success && j<5 ) {
              res = await printer1.connect(
                  ip, port: port, timeout: const Duration(seconds: 2));
              j++;
            }
            if (res == PosPrintResult.success) {
              printer1.feed(4);
              printer1.text('Token No : $token',
                  styles: const PosStyles(align: PosAlign.center,height: PosTextSize.size2,width: PosTextSize.size2));
              printer1.feed(1);
              printer1.text(
                  'Date : ${DateTime.now().toString().substring(0, 16)}',
                  styles: const PosStyles(align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size2));
              printer1.feed(1);
              printer1.text('Invoice No : $invNo',
                  styles: const PosStyles(align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size2));
              printer1.feed(1);
          printer1.text('Oredre Type: $dropdownvalue',
                  styles: const PosStyles(align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size2));
              printer1.feed(1);
             if(dropdownvalue!="Take Away"){
               printer1.text('Table  No : $selectedTable',
                   styles: const PosStyles(align: PosAlign.center, height: PosTextSize.size1, width: PosTextSize.size2));

             }
              printer1.feed(4);
              for (Map<String, dynamic> item in items) {
                if (categoryLists.contains(item['category'])) {
                  // newAddOn = item['addOns'];
                  // newAddOnArabic = item['addOnArabic'];
                  List includeKot2=item['addOns']??[];
                  List addLessKot2=item['addLess']??[];
                  List addMoreKot2=item['addMore']??[];
                  List removeKot2=item['remove']??[];
                  addON = newAddOn.isEmpty ? '' : newAddOn.toString();
                  printer1.text("${int.tryParse(item['qty']
                      .toString())} x ${item['pdtname']} $addON",styles: const PosStyles(height: PosTextSize.size1,width: PosTextSize.size2));
                  printer1.feed(1);
                  if (includeKot2.isNotEmpty){
                    printer1.text( "Include :$includeKot2",styles: const PosStyles(align: PosAlign.left,height: PosTextSize.size1,width: PosTextSize.size2));
                  }
                  if (addLessKot2.isNotEmpty){
                    printer1.text( "Add Less :$addLessKot2",styles: const PosStyles(align: PosAlign.left,height: PosTextSize.size1,width: PosTextSize.size2));
                  }
                  if (addMoreKot2.isNotEmpty){
                    printer1.text( "Add More :$addMoreKot2",styles: const PosStyles(align: PosAlign.left,height: PosTextSize.size1,width: PosTextSize.size2));
                  }
                  if (removeKot2.isNotEmpty){
                    printer1.text( "Remove :$removeKot2",styles: const PosStyles(align: PosAlign.left,height: PosTextSize.size1,width: PosTextSize.size2));
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
    }
    catch (ex) {
      print("usb exceptionnnnnnnnnnnnnnnnnn");
      print(ex.toString());
      await await flutterUsbPrinter.write(Uint8List.fromList(bytes));
    }
  }
  catch (error) {
    print(error.toString(),);
  }

  print("end");
}catch(e){
  print("error occuredddddddddddddddddd");
  print(e.toString());
}
  }


//   abc(
//
//       int invNo,double discount,List items,int token,String selectedTable,
//       double deliveryAmount,double pc,double pb,double bal,double netTotal,
//       String dropdownvalue,
//
//       // int invNo,
//       // double discount,
//       // List items,
//       // int token,
//       // String selectedTable,
//       // double deliveryAmount,
//       // double pc,
//       // double pb,
//       // double bal,
//       // double offDiscountTotal1,
//       // double netTotal,
//       // String dropdownvalue,
//       // BuildContext context
//       ) async {
//     // try {
//
//     print("bill started  $approve");
//
//     final CapabilityProfile profile = await CapabilityProfile.load();
//     const PaperSize paper1 = PaperSize.mm80;
//     var profile1 = await CapabilityProfile.load();
//     var printer1 = NetworkPrinter(paper1, profile1);
//
//     final generator = Generator(PaperSize.mm80, profile);
//     bytes = [];
//     kotBytes = [];
//
//     final Uint8List imgBytes = data!.buffer.asUint8List();
//     final im.Image? image = im.decodeImage(imgBytes);
//     bytes += generator.image(image!);
//
//     final im.Image? image1 = im.decodeImage(capturedImage1);
//     bytes += generator.image(image1!);
//     List<Widget> itemWidgets3 = [];
//     itemWidgets3.add(Container(
//       color: Colors.white,
//       width: printWidth * 3,
//       child: Column(
//           mainAxisSize: MainAxisSize.min,
//           // shrinkWrap: true,
//           // physics: NeverScrollableScrollPhysics(),
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Date :',
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: fontSize + 2,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 Text(
//                   '${DateTime.now().toString().substring(0, 19)}',
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: fontSize,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Order Type',
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: fontSize + 2,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 Text(
//                   approve ? "Credit User" : dropdownvalue.toString(),
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: fontSize,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Invoice No:',
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: fontSize + 2,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 Text(
//                   "$invNo",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: fontSize,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ],
//             ),
//           ]),
//     ));
//     var capturedImage25 =
//     await screenshotController.captureFromWidget(Container(
//       width: printWidth * 3,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: List.generate(itemWidgets3.length, (index) {
//           return itemWidgets3[index];
//         }),
//       ),
//     ));
//     final im.Image? image25 = im.decodeImage(capturedImage25);
//     bytes += generator.image(image25!);
// // final im.Image image10 = im.decodeImage(capturedImage10)!;
// // bytes += generator.image(image10);
//
//     bytes += generator.text("-------------------------------------------",
//         styles: const PosStyles(
//           bold: true,
//           align: PosAlign.center,
//           height: PosTextSize.size2,
//         ));
//     bytes += generator.text("TOKEN NUMBER : $token",
//         styles: PosStyles(
//             bold: true,
//             align: PosAlign.center,
//             height: PosTextSize.size2,
//             width: PosTextSize.size2));
//     bytes += generator.text("-------------------------------------------",
//         styles: const PosStyles(
//           bold: true,
//           align: PosAlign.center,
//           height: PosTextSize.size2,
//         ));
//
//     final im.Image? imagehead = im.decodeImage(capturedhead);
//     bytes += generator.image(imagehead!);
//     String itemString = '';
//     String itemStringArabic = '';
//     String itemTotal = '';
//     String itemGrossTotal = '';
//     String itemTax = '';
//     String addON = '';
//     double? deliveryCharge = 0;
//     double grantTotal = 0;
//     double totalAmount = 0;
//     String arabic = '';
//     String english = '';
//     String addOnArabic = '';
//     addOnArabic = newAddOnArabic.isEmpty ? '' : newAddOnArabic.toString();
//     Map<String, dynamic> config = Map();
//     List<Widget> itemWidgets = [];
//
//     for (Map<String, dynamic> item in items) {
//       addOnPrice = item['addOnPrice'];
//       double? total =
//           (double.tryParse(item['price'].toString())! + addOnPrice) *
//               double.tryParse(item['qty'].toString())!;
//       double grossTotal = total * 100 / 115;
//       double.tryParse(item['qty'].toString());
//       double vat =
//           (double.tryParse(item['price'].toString())! + addOnPrice) * 15 / 115;
//       newAddOn = item['addOns'];
//       arabic = item['arabicName'];
//       english = item['pdtname'];
//
//       grantTotal += total;
//
//       deliveryCharge = item['deliveryCharge'] == null
//           ? 0
//           : double.tryParse(item['deliveryCharge'].toString());
//       newAddOn = item['addOns'];
//       newAddOnArabic = item['addOnArabic'];
//       addOnArabic = newAddOnArabic.isEmpty ? '' : newAddOnArabic.toString();
//       addON = newAddOn.isEmpty ? '' : newAddOn.toString();
//       double price =
//           (double.tryParse(item['price'].toString())! + addOnPrice) * 100 / 115;
//       totalAmount += price * double.tryParse(item['qty'].toString())!;
//       // double offDiscount = double.tryParse(item['discount'].toString())!;
//
//       itemTotal += (totalAmount * ((100 + gst) / 100) -
//           (double.tryParse(discount.toString()) ?? 0))
//           .toStringAsFixed(2);
//       itemGrossTotal += grossTotal.toStringAsFixed(2);
//       itemTax += (totalAmount * gst / 100).toStringAsFixed(2);
//
//       //itemWidgets adding
//
//       itemWidgets.add(Container(
//           width: printWidth * 6,
//           padding: const EdgeInsets.all(1.0),
//           decoration: const BoxDecoration(
//             color: Colors.white,
//           ),
//           child: Column(mainAxisSize: MainAxisSize.min, children: [
//             Container(
//               width: printWidth * 6,
//               child: Column(
//                 children: [
//                   Row(
//                     //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       //Product Name
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               '$arabic $addOnArabic',
//                               // textDirection: TextDirection.rtl,
//                               style: TextStyle(
//                                 fontFamily: 'GE Dinar One Medium',
//                                 fontSize: fontSize + 9,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.black,
//                               ),
//                             ),
//                             Text(
//                               '$english $addON',
//                               // textDirection: TextDirection.rtl,
//                               style: TextStyle(
//                                 fontFamily: 'GE Dinar One Medium',
//                                 fontSize: fontSize + 9,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       //qty
//                       Container(
//                         width: printWidth * 0.65,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Text('${arabicNumber.convert(double.tryParse(item['qty'].toString()).toStringAsFixed(2))}',
//                             //   style:  TextStyle(
//                             //       fontFamily: 'GE Dinar One Medium',
//                             //       color: Colors.black,
//                             //       fontSize: fontSize+2,
//                             //       fontWeight: FontWeight.w600),
//                             // ),
//                             Text(
//                               '${double.tryParse(item['qty'].toString())}',
//                               style: TextStyle(
//                                   fontFamily: 'GE Dinar One Medium',
//                                   color: Colors.black,
//                                   fontSize: fontSize + 9,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                           ],
//                         ),
//                       ),
//                       //rate
//                       Container(
//                         width: printWidth * 0.65,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Text('${arabicNumber.convert(price.toStringAsFixed(2))} ',
//                             //   style:  TextStyle(
//                             //       fontFamily: 'GE Dinar One Medium',
//                             //       color: Colors.black,
//                             //       fontSize: fontSize+2,
//                             //       fontWeight: FontWeight.w600),
//                             // ),
//                             Text(
//                               '${price.toStringAsFixed(2)} ',
//                               style: TextStyle(
//                                   fontFamily: 'GE Dinar One Medium',
//                                   color: Colors.black,
//                                   fontSize: fontSize + 9,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                           ],
//                         ),
//                       ),
//                       //vat
//                       Container(
//                         width: printWidth * 0.65,
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Text('${arabicNumber.convert(vat.toStringAsFixed(2))}',
//                             //   style:  TextStyle(
//                             //       fontFamily: 'GE Dinar One Medium',
//                             //       color: Colors.black,
//                             //       fontSize: fontSize+2,
//                             //       fontWeight: FontWeight.w600),
//                             // ),
//                             Text(
//                               '${vat.toStringAsFixed(2)}',
//                               style: TextStyle(
//                                   fontFamily: 'GE Dinar One Medium',
//                                   color: Colors.black,
//                                   fontSize: fontSize + 9,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                           ],
//                         ),
//                       ),
//                       //total
//                       Container(
//                         width: printWidth * 0.65,
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Text('${arabicNumber.convert(total.toStringAsFixed(2))}',
//                             //   style:  TextStyle(
//                             //       fontFamily: 'GE Dinar One Medium',
//                             //       color: Colors.black,
//                             //       fontSize: fontSize+2,
//                             //       fontWeight: FontWeight.w600),
//                             // ),
//                             Text(
//                               total.toStringAsFixed(2),
//                               style: TextStyle(
//                                   fontFamily: 'GE Dinar One Medium',
//                                   color: Colors.black,
//                                   fontSize: fontSize + 9,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10)
//                 ],
//               ),
//             ),
//             // Text("${item['pdtname']} $addON",
//             //   textDirection: TextDirection.ltr,
//             //   style: const TextStyle(
//             //     fontSize: 14,
//             //     color: Colors.black,
//             //   ),
//             // ),
//           ])));
//     }
//
//     itemWidgets.add(Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Container(
//             padding: const EdgeInsets.all(1.0),
//             decoration: const BoxDecoration(
//               color: Colors.white,
//             ),
//             child: Center(
//                 child: Text(
//                   '=====================',
//                   style: TextStyle(color: Colors.black, fontSize: printWidth * .25),
//                 ))),
//         Container(
//           padding: const EdgeInsets.all(1.0),
//           decoration: const BoxDecoration(
//             color: Colors.white,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Total - الإجمالي     :  ',
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: fontSize + 12,
//                     fontWeight: FontWeight.w600),
//               ),
//               Text(
//                 totalAmount.toStringAsFixed(2),
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: fontSize + 12,
//                     fontWeight: FontWeight.w600),
//               ),
//             ],
//           ),
//         ),
//         Container(
//           padding: const EdgeInsets.all(1.0),
//           decoration: const BoxDecoration(
//             color: Colors.white,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'VAT -  رقم ضريبة  :   ',
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: fontSize + 12,
//                     fontWeight: FontWeight.w600),
//               ),
//               Text(
//                 '${(totalAmount * gst / 100).toStringAsFixed(2)}',
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: fontSize + 12,
//                     fontWeight: FontWeight.w600),
//               ),
//             ],
//           ),
//         ),
//         Container(
//           padding: const EdgeInsets.all(1.0),
//           decoration: const BoxDecoration(
//             color: Colors.white,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Delivery Charge - رسوم التوصيل : ',
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: fontSize + 12,
//                     fontWeight: FontWeight.w600),
//               ),
//               Text(
//                 '${deliveryAmount.toStringAsFixed(2)} ',
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: fontSize + 12,
//                     fontWeight: FontWeight.w600),
//               ),
//             ],
//           ),
//         ),
//         Container(
//           padding: const EdgeInsets.all(1.0),
//           decoration: const BoxDecoration(
//             color: Colors.white,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Discount -  خصم  : ',
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: fontSize + 12,
//                     fontWeight: FontWeight.w600),
//               ),
//               Text(
//                 ((discount).toStringAsFixed(2)),
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: fontSize + 12,
//                     fontWeight: FontWeight.w600),
//               ),
//             ],
//           ),
//         ),
//         Container(
//             padding: const EdgeInsets.all(1.0),
//             decoration: const BoxDecoration(
//               color: Colors.white,
//             ),
//             child: Center(
//                 child: Text(
//                   '-------------------------------------------',
//                   style: TextStyle(color: Colors.black, fontSize: printWidth * .25),
//                 ))),
//         Container(
//           decoration: const BoxDecoration(
//             color: Colors.white,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'NET - المجموع الإجمالي  : ',
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: fontSize + 12,
//                     fontWeight: FontWeight.w700),
//               ),
//               Text(
//                 netTotal.toStringAsFixed(2) ?? "0",
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: fontSize + 12,
//                     fontWeight: FontWeight.w700),
//               ),
//             ],
//           ),
//         ),
//         Container(
//             decoration: const BoxDecoration(
//               color: Colors.white,
//             ),
//             child: Center(
//                 child: Text(
//                   '-------------------------------------------',
//                   style: TextStyle(color: Colors.black, fontSize: printWidth * .25),
//                 ))),
//         Container(
//           padding: const EdgeInsets.all(1.0),
//           decoration: const BoxDecoration(
//             color: Colors.white,
//           ),
//           child: Center(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Cash      :  ${pc ?? 0}',
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: fontSize + 9,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 Text(
//                   'Bank      :  ${pb ?? 0}',
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: fontSize + 9,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 Text(
//                   'Change :  ${bal ?? 0}',
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: fontSize + 9,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Container(
//             decoration: const BoxDecoration(
//               color: Colors.white,
//             ),
//             child: Center(
//                 child: Text(
//                   '-------------------------------------------',
//                   style: TextStyle(color: Colors.black, fontSize: printWidth * .2),
//                 ))),
//       ],
//     ));
//
//     String qrVat = (totalAmount * gst / 100).toStringAsFixed(2);
//     String qrTotal = (grantTotal -
//         (double.tryParse(discount.toString()) ?? 0) +
//         (deliveryAmount))
//         .toStringAsFixed(2);
//     itemWidgets.add(Container(
//       // height: qrCode + 100,
//       width: qrCode + 200,
//       color: Colors.white,
//       // width: qrCode,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           QrImageView(
//             data: qr(qrVat, qrTotal),
//             version: 6,
//             size: size,
//           ),
//         ],
//       ),
//     ));
//
//     bytes += generator.drawer(pin: PosDrawer.pin2);
//     print("testttttttttttttttttttttttt");
//     var capturedImage2 =
//     await screenshotController.captureFromLongWidget(Container(
//       width: printWidth * 4.5,
//       child: Column(
//         children: List.generate(itemWidgets.length, (index) {
//           return itemWidgets[index];
//         }),
//       ),
//     ));
//     final im.Image? image2 = im.decodeImage(capturedImage2);
//     bytes += generator.image(image2!);
//     final im.Image? footer = im.decodeImage(footerImage);
//     bytes += generator.image(footer!);
//     print("testttttt");
//
//     //old
//     bytes += generator.feed(2);
//     bytes += generator.cut();
//
//     // second bill print:-
//     // flutterUsbPrinter.write(Uint8List.fromList(bytes)).then((value)
//     print(DateTime.now());
//
//     // try {
//       List categories = [];
//       for (Map<String, dynamic> item in items) {
//         if (!categories.contains(item['category'])) {
//           print("testttttttttttttttttttttttt33333333333333333333");
//
//           categories.add(item['category']);
//         }
//       }
//
//       Map<String, dynamic> printerMap = {};
//       for (var category in categories) {
//         // if(category!="Beverage"){
//         print("testtttttttttttttttttttttt444444444444t");
//
//         String printerID = allCategories[category]['printer'];
//
//         if (printerMap[printerID] == null) {
//           printerMap[printerID] = [category];
//         } else {
//           printerMap[printerID].add(category);
//         }
//         // }
//       }
//
//       for (var printerID in printerMap.keys.toList()) {
//         kotPrinter = printers[printerID]['type'];
//         List categoryLists = printerMap[printerID];
//
//         if (kotPrinter == 0) {
//           print("testttttttttttttttttttttttt55555555555555");
//
//           bytes += generator.feed(4);
//           bytes += generator.text('Token No : $token',
//               styles: const PosStyles(
//                   align: PosAlign.center,
//                   height: PosTextSize.size1,
//                   width: PosTextSize.size2));
//           bytes += generator.feed(1);
//           bytes += generator.text(
//               'Date : ${DateTime.now().toString().substring(0, 16)}',
//               styles: const PosStyles(
//                   align: PosAlign.center,
//                   height: PosTextSize.size1,
//                   width: PosTextSize.size2));
//           bytes += generator.feed(1);
//           bytes += generator.text('Invoice No : $invNo',
//               styles: const PosStyles(
//                   align: PosAlign.center,
//                   height: PosTextSize.size1,
//                   width: PosTextSize.size2));
//           bytes += generator.feed(1);
//           bytes += generator.text('Table No : $selectedTable',
//               styles: const PosStyles(
//                   align: PosAlign.center,
//                   height: PosTextSize.size1,
//                   width: PosTextSize.size2));
//           bytes += generator.feed(1);
//           bytes += generator.text('================================',
//               styles: const PosStyles(
//                   align: PosAlign.center,
//                   height: PosTextSize.size1,
//                   width: PosTextSize.size2));
//           bytes += generator.feed(2);
//
//           for (Map<String, dynamic> item in items) {
//             if (categoryLists.contains(item['category'])) {
//               newAddOn = item['addOns'];
//               newAddOnArabic = item['addOnArabic'];
//               addON = newAddOn.isEmpty ? '' : newAddOn.toString();
//               bytes += generator.text(
//                   "${item['qty'].toString()} x ${item['pdtname']} $addON",
//                   styles: const PosStyles(
//                       align: PosAlign.left,
//                       height: PosTextSize.size1,
//                       width: PosTextSize.size2));
//               bytes += generator.feed(1);
//             }
//           }
//
//           bytes += generator.feed(5);
//           bytes += generator.cut();
//           //double print
//         }
//       }
//       // try {
//        bool printSuccess = false;
//         // bool? printSuccess;
//         int i = 0;
//         // while (printSuccess! && i < 5) {
//         while (!printSuccess && i < 5) {
//           // printSuccess = await flutterUsbPrinter.write(Uint8List.fromList(bytes));
//
//           i++;
//           // if (printSuccess!) {
//           if (!printSuccess) {
//             await _getDevicelist();
//             await Future.delayed(Duration(milliseconds: 200));
//           } else {
//             print("end");
//             print(DateTime.now());
//           }
//         }
//         for (var printerID in printerMap.keys.toList()) {
//           kotPrinter = printers[printerID]['type'];
//           List categoryLists = printerMap[printerID];
//
//           if (kotPrinter == 1) {
//             print("testttttttttttttttttttttttt6666666666666666666");
//
//             // await Future.delayed(Duration(seconds: 10));
//
//             String ip = printers[printerID]['ip'];
//             int port = printers[printerID]['port'];
//             print("$ip ip adressssssssssssssssss");
//             print("$port port");
//
//             // try {
//               PosPrintResult res = await printer1.connect(ip,
//                   port: port, timeout: const Duration(seconds: 10));
//               int j = 0;
//               while (res != PosPrintResult.success && j < 5) {
//                 res = await printer1.connect(ip,
//                     port: port, timeout: const Duration(seconds: 2));
//                 j++;
//               }
//               if (res == PosPrintResult.success) {
//                 printer1.feed(5);
//                 printer1.text('Token No : $token',
//                     styles: const PosStyles(
//                         align: PosAlign.center,
//                         height: PosTextSize.size1,
//                         width: PosTextSize.size2));
//                 printer1.feed(1);
//                 printer1.text(
//                     'Date : ${DateTime.now().toString().substring(0, 16)}',
//                     styles: const PosStyles(
//                         align: PosAlign.center,
//                         height: PosTextSize.size1,
//                         width: PosTextSize.size2));
//                 printer1.feed(1);
//                 printer1.text('Invoice No : $invNo',
//                     styles: const PosStyles(
//                         align: PosAlign.center,
//                         height: PosTextSize.size1,
//                         width: PosTextSize.size2));
//                 printer1.feed(1);
//                 printer1.text('Table  No : $selectedTable',
//                     styles: const PosStyles(
//                         align: PosAlign.center,
//                         height: PosTextSize.size1,
//                         width: PosTextSize.size2));
//                 printer1.feed(2);
//                 printer1.text('=======================',
//                     styles: const PosStyles(
//                         align: PosAlign.center,
//                         height: PosTextSize.size1,
//                         width: PosTextSize.size2));
//                 printer1.feed(2);
//
//                 for (Map<String, dynamic> item in items) {
//                   if (categoryLists.contains(item['category'])) {
//                     newAddOn = item['addOns'];
//                     newAddOnArabic = item['addOnArabic'];
//                     addON = newAddOn.isEmpty ? '' : newAddOn.toString();
//                     printer1.text(
//                         "${int.tryParse(item['qty'].toString())} x ${item['pdtname']} $addON",
//                         styles: const PosStyles(
//                             align: PosAlign.left,
//                             height: PosTextSize.size1,
//                             width: PosTextSize.size2));
//                   }
//                 }
//                 if (lastCut == true) {
//                   printer1.feed(4);
//                   printer1.cut();
//                   printer1.disconnect(delayMs: 10);
//                 }
//               } else {
//                 print(res.msg);
//                 print("no printer found");
//                 // printer.disconnect(delayMs: 10);
//               }
//             // } catch (e) {
//             //   print("button catch");
//             //   print(e.toString());
//             // }
//           }
//         }
//       // }
//       // // try {
//       // //   await flutterUsbPrinter.write(Uint8List.fromList(bytes));
//       // // }
//       // catch (ex) {
//       //   print("usb exception");
//       //   print(ex.toString());
//       //   await flutterUsbPrinter.write(Uint8List.fromList(bytes));
//       // }
//
//       // bytes = [];
//     // } catch (error) {
//     //   print(
//     //     error.toString(),
//     //   );
//     // }
//     print("end");
//     // }
//     //
//     // catch (e) {
//     //   print("error occuredddddddddddddddddd");
//     //   print(e.toString());
//     // }
//   }

  kotPrint(int invNo,List items,int token,String selectedTable,) async {
    try {



      final CapabilityProfile profile = await CapabilityProfile.load();
      const PaperSize paper1 = PaperSize.mm80;
      var profile1 = await CapabilityProfile.load();
      var printer1 = NetworkPrinter(paper1, profile1);
      print(DateTime.now());
      final generator = Generator(PaperSize.mm80, profile);
      bytes = [];
      kotBytes = [];












      String addON = '';

      double deliveryCharge = 0;
      double grantTotal = 0;
      double totalAmount = 0;
      String arabic = '';
      String english = '';
      String addOnArabic = '';
      addOnArabic = newAddOnArabic.isEmpty ? '' : newAddOnArabic.toString();

      Map<String, dynamic> config = Map();
      List<Widget> itemWidgets = [];
      List<Widget> itemWidgets1 = [];
      // for (Map<String, dynamic> item in items) {
      //   addOnPrice = item['addOnPrice'];
      //   double total = (double.tryParse(item['price'].toString()) + addOnPrice) * double.tryParse(item['qty'].toString());
      //   double grossTotal = total * 100 / 115;
      //   double vat = (double.tryParse(item['price'].toString()) + addOnPrice) * 15 / 115;
      //   newAddOn = item['addOns'];
      //   arabic = item['arabicName'];
      //   english = item['pdtname'];
      //
      //
      //   grantTotal += total;
      //
      //   deliveryCharge = item['deliveryCharge'] == null ? 0 : double.tryParse(item['deliveryCharge'].toString());
      //   newAddOn = item['addOns'];
      //   newAddOnArabic = item['addOnArabic'];
      //   addOnArabic = newAddOnArabic.isEmpty ? '' : newAddOnArabic.toString();
      //   addON = newAddOn.isEmpty ? '' : newAddOn.toString();
      //   double price = (double.tryParse(item['price'].toString()) + addOnPrice) * 100 / 115;
      //   totalAmount += price * double.tryParse(item['qty'].toString());
      //   itemTotal += (totalAmount * ((100 + gst) / 100) - (double.tryParse(discount.toString()) ?? 0)).toStringAsFixed(2);
      //   itemGrossTotal += grossTotal.toStringAsFixed(2);
      //   itemTax += (totalAmount * gst / 100).toStringAsFixed(2);
      // }





      print("end");
    }catch(e){
      print("error occuredddddddddddddddddd");
      print(e.toString());
    }
  }

  _connect(int vendorId, int productId) async {
    bool? returned;
    try {
      returned = await flutterUsbPrinter.connect(vendorId, productId);
    } on PlatformException {
    }
    if (returned!) {
      setState(() {
        connected = true;
      });
    }
  }

  getAlert(){
    FirebaseFirestore.instance.collection('orders')
        .where('branchId',isEqualTo: currentBranchId)
        .orderBy('salesDate',descending: true)
        .where('status',isEqualTo: 0)
        .snapshots()
        .listen((event) {
          if(event.docs.isNotEmpty){
            // print('mmm');
            for(var doc in event.docs){
             if(doc.get('orderId')!=null&&doc.get('status')==0){
               showDialog(
                 context: context,
                 builder: (ctx) => AlertDialog(
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(10),
                   ),
                   title:  Text('Online Order'),
                   content: Container(
                     height: MediaQuery.of(context).size.width*0.09,
                     padding: EdgeInsets.all(8),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text("You have received a new order",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17
                            ),),
                          ),
                          Text("Table  :${(doc.get('table'))}"),
                          Text("Customer Name :${(doc.get('name'))}"),
                       ],
                     ),
                   ),
                   actions: <Widget>[
                     TextButton(
                       onPressed: () {
                         Navigator.of(ctx).pop();
                         Navigator.push(context,MaterialPageRoute(builder: (context)=>OrderConfirmWidget(
                             orderId:doc.get('orderId'),
                           customerName:doc.get('userName'),)));

                       },
                       child: Container(
                         decoration: BoxDecoration(
                             color: default_color,
                           borderRadius: BorderRadius.circular(7)
                         ),
                         padding: const EdgeInsets.all(14),
                         child: const Text("view",style: TextStyle(
                           color: Colors.white,
                         ),),
                       ),
                     ),
                   ],
                 ),
               );
             }
            }
          }
    });
  }

  getCreditDetailes(String mobileNo) async {
    print("${mobileNo.toLowerCase()}      nnbnbnbnbnbnbn");
    FirebaseFirestore.
    instance.collection('creditUsers')
        .where("deleted",isEqualTo:false )
        .where("branchId",isEqualTo: currentBranchId)
        .where("phone",isEqualTo:mobileNo.trim())
        .get()
        .then((value){
      if(value.docs.isNotEmpty){
        print('GETTTTTTTTTTTTTTTT');
        credit=value.docs;
        for(var data in credit){
          print("GOT ");
          creditMap[data.id]=data.data();

          // creditUsers.add(data.get("name"));
          // mobileNumbers.add(data.get("phone"));
        }
      }

      setState(() {

      });
    });


  }

  @override
  void initState() {
    enable=false;
    dropdownvalue="Take Away";
    currentWaiter=null;
    bankValue="Select";
    getWaiters();
    setPrinterImages();
    super.initState();
    getPosUser();
    // updateProduct();
    getTables();
    getPrinters();
    getAllCategories();
     getToken();
    counter();
    getSettings();
    _getDevicelist();
    bluetooth = BlueThermalPrinter.instance;
    initPlatformState();
    initSavetoPath();
    mobileNo = TextEditingController();
    discountController = TextEditingController();
    deliveryCharge = TextEditingController();
    paidCash = TextEditingController(text: '0');
    paidBank = TextEditingController(text: '0');
    tableController = TextEditingController();

    amex = TextEditingController(text: "0.0");
    mada = TextEditingController(text: "0.0");
    visa = TextEditingController(text: "0.0");
    master = TextEditingController(text: "0.0");

    getAlert();
    double amexPaid=0;
    double masterPaid=0;
    double visaPaid=0;
    double madaPaid=0;

  }
  getPrinters(){
    FirebaseFirestore.instance.collection('printer')
        .where("branchId",isEqualTo: currentBranchId).
    where("available",isEqualTo: true).
    get().then((value){
      for(DocumentSnapshot<Map<String,dynamic>> printer in value.docs){
        printers[printer.id]=printer.data();
      }
    });
  }
  getAllCategories(){
    FirebaseFirestore.instance.collection('category').where("branchId",isEqualTo:currentBranchId).get().then((value){
      for(DocumentSnapshot<Map<String,dynamic>> category in value.docs){
        allCategories[category['name']]=category.data();
      }
    });
  }

  updateProduct(){
    FirebaseFirestore.instance
        .collection('product')
        .get()
        .then((value){
      for(var item in value.docs){
        item.reference.update({
          'productCode':'',
        });
      }
      setState(() {

      });
    });
  }

  setSearchParam(String caseNumber) {
    List<String> caseSearchList = [];
    String temp = "";

    List<String> nameSplits = caseNumber.split(" ");
    for (int i = 0; i < nameSplits.length; i++) {
      String name = "";

      for (int k = i; k < nameSplits.length; k++) {
        name = "$name${nameSplits[k]} ";
      }
      temp = "";

      for (int j = 0; j < name.length; j++) {
        temp = temp + name[j];
        caseSearchList.add(temp.toUpperCase());
      }
    }
    return caseSearchList;
  }

  getSettings() async {
    FirebaseFirestore.instance
        .collection('settings')
        .snapshots()
        .listen((value) {
      var data = value.docs;
      printWidth = double.tryParse(data[0]['logo'])!;
      qrCode = double.tryParse(data[0]['qr'])!;
      lastCut=data[0]['lastCut'];

      fontSize = double.tryParse(data[0]['fontSize'])!;
      size = double.tryParse(data[0]['size'])!;
      products = data[0]['product'];
      itemCount=data[0]['itemCount'];
      display_image=data[0]['display_image'];
      kotPrinter=data[0]['kotPrinter'];
      if(mounted){
      setState(() {
        // print(products);
        // print(display_image);
      }

      );}
    });
  }
  int token=0;

  getToken() async {
    FirebaseFirestore.instance
        .collection('invoiceNo').doc(currentBranchId)
        .snapshots()
        .listen((value) {
      // var token = value.get('token');
      token=value.get('token');

if(mounted)
      setState(() {
        // print(token);
      });
    });
  }
  initSavetoPath() async {
    //read and write
    //image max 300px X 300px
    const filename = 'pizzaromiBill.png';
    const filename1 = 'pizzaromiBill.png';
    var bytes = await rootBundle.load("assets/pizzaromiBill.png");
    var bytes1= await rootBundle.load("assets/pizzaromiBill.png");
    String dir = (await getApplicationDocumentsDirectory()).path;
    writeToFile(bytes, '$dir/$filename');
    writeToFile(bytes1, '$dir/$filename1');
    setState(() {
      topImage = '$dir/$filename';
      heading = '$dir/$filename1';
    });
  }
  Future<File> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future<void> initPlatformState() async {
    List<BluetoothDevice>? devices = [];

    try {
      devices = await bluetooth?.getBondedDevices();
    } on PlatformException {
      // TODO - Error
    }
    bluetooth!.onStateChanged().listen((state) {
      print("connect");
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          setState(() {
            _connected = true;
            _pressed = false;
          });
          break;
        case BlueThermalPrinter.DISCONNECTED:
          setState(() {
            _connected = false;
            _pressed = false;
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return;
    setState(() {
      btDevices = devices!;
    });
  }

  getTables() async {
    FirebaseFirestore.instance.collection('tables')
        .doc(currentBranchId)
        .collection('tables')
        .orderBy('tableNo',descending:false)
        .snapshots().listen((event) {
      tables = [];
      for (DocumentSnapshot doc in event.docs) {
        tables.add(doc.get('name'));
      }
      // selectedTable = tables[0];
      if(mounted){
        setState(() {

        });
      }

    });
  }


  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (btDevices.isEmpty) {
      print('             BLUETHOOTH DEVICES                   NO');
      items.add(const DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      print('             BLUETHOOTH DEVICES                   BLU');
      btDevices.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name!),
          value: device,
        ));
      });
    }
    return items;
  }
  Future show(
      String message, {
        Duration duration: const Duration(seconds: 3),
      }) async {
    await  Future.delayed( const Duration(milliseconds: 100));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:  Text(
          message,
          style:  const TextStyle(
            color: Colors.white,
          ),
        ),
        duration: duration,
      ),
    );
  }
  void btConnect() {

    if (device == null) {
      show('No device selected.');
    } else {
      bluetooth!.isConnected.then((isConnected) {
        // print("here");
        if (!isConnected!) {
          bluetooth!.connect(device!).catchError((error) {
            print(error);
            setState((){pressed = false;
            connected=false;
            });
          });
          setState((){pressed = true;
          connected=true;
          });
        }
        else{
          setState((){pressed = true;
          connected=true;
          });
        }
        Navigator.pop(context);

      }
      );
    }
  }
  void _disconnect() {
    bluetooth!.disconnect();
    setState(() => pressed = true);
    
  }
set(){
    setState(() {
      
    });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(

          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.35,
                  color: default_color,
                  padding: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height:20),

                        const SizedBox(height: 10,),
                        Text(
                          arabicLanguage? "${PosUserIdToArabicName[currentUserId]}":"${PosUserIdToName[currentUserId]}",

                          style: TextStyle(color: Colors.white),
                        ),


                        //image close
                        Container(
                          child: SwitchListTile.adaptive(
                            value: display_image ??= true,
                            onChanged: (newValue) async {
                              setState(()  {
                                display_image = newValue;
                                // print(display_image.toString()+" bbbdndb");

                                FirebaseFirestore.instance
                                    .collection('settings')
                                    .doc('settings')
                                    .update({
                                  "display_image":display_image,
                                });

                              }

                              );

                            },
                            title: Text(
                              'Image/صورة',
                              style: FlutterFlowTheme.title3.override(
                                fontFamily: 'Lexend Deca',
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            tileColor:Colors.grey,
                            inactiveTrackColor: Colors.grey.shade100,
                            activeColor: Colors.green,
                            activeTrackColor: Colors.yellow,
                            dense: true,
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
                          ),
                        ),
                        Container(
                          child: SwitchListTile.adaptive(
                            value: arabicLanguage ??= false,
                            onChanged: (newValue) async {
                              setState(()  {
                                arabicLanguage = newValue;

                                FirebaseFirestore.instance
                                    .collection('settings')
                                    .doc('settings')
                                    .update({
                                  "arabicLanguage":arabicLanguage,
                                });

                              }

                              );

                            },
                            title: Text(
                              'Arabic/عربي',
                              style: FlutterFlowTheme.title3.override(
                                fontFamily: 'Lexend Deca',
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            tileColor:Colors.grey,
                            inactiveTrackColor: Colors.grey.shade100,
                            activeColor: Colors.green,
                            activeTrackColor: Colors.yellow,
                            dense: true,
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  const history_View_Widget()),
                    );
                  },
                  child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                      ),
                      child:  Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(
                          arabicLanguage?"تاريخ":'HISTORY',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: default_color,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Expenses()),
                    );
                  },
                  child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                      ),
                      child:  Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(
                          arabicLanguage? 'إضافة حساب':'ADD EXPENSE',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: default_color,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Purchases()),
                    );
                  },
                  child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                      ),
                      child:  Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(
                          arabicLanguage? 'ضافة شراء':'ADD PURCHASE',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: default_color,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SalesReport()),
                    );
                  },
                  child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      width: double.infinity,
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child:  Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(
                          arabicLanguage? ' تقرير المبيعات':'SALES REPORT',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: default_color,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SalesReturnReport()),
                    );
                  },
                  child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      width: double.infinity,
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(
                          arabicLanguage?'تقرير الإرجاع':'RETURN REPORT',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: default_color,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ExpenseReport()),
                    );
                  },
                  child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                      ),
                      child:  Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(
                          arabicLanguage?'تقرير المصاريف':'EXPENSE REPORT',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: default_color,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PurchaseReport()),
                    );
                  },
                  child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      width: double.infinity,
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(
                          arabicLanguage?'تقارير الشراء':'PURCHASE REPORTS',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: default_color,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DailyReportsWidget()),
                    );
                  },
                  child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(
                          arabicLanguage? 'التقارير اليومية':'DAILY REPORTS',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: default_color,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )),
                ),


                InkWell(
                  onTap: () async {
                    await signOut();
                    await Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                          (r) => false,
                    );
                  },
                  child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 50),
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:[
                            Icon(
                              Icons.logout,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              arabicLanguage?'تسجيل خروج':'Log out',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: default_color,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      )),
                ),
              ],
            )),
        body:
        // !connected?AlertDialog(
        //
        //   content: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     children: <Widget>[
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: <Widget>[
        //           const Text(
        //             'Device:',
        //             style: TextStyle(
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //           DropdownButton(
        //             items: _getDeviceItems(),
        //             onChanged: (value) => setState(() => device = value),
        //             value: device,
        //           ),
        //           RaisedButton(
        //             onPressed:
        //             pressed ? null : connected ? _disconnect : btConnect,
        //             child: Text(connected ? 'Disconnect' : 'Connect'),
        //           ),
        //
        //         ],
        //       ),
        //       RaisedButton(
        //         onPressed:() async {
        //           if(connected ){
        //
        //
        //           }else{
        //
        //           }
        //         },
        //         child: const Text('Print'),
        //       ),
        //
        //     ],
        //   ),
        // ):
        Builder(
          builder: (context) => Row(
            children: [

              Container(
                width: MediaQuery.of(context).size.width * 0.08,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05),
                color:default_color,
                // decoration: BoxDecoration(
                //   image: DecorationImage(
                //     image: AssetImage("assets/awafi/coffeeAppBar1.jpg"),fit: BoxFit.cover
                //   )
                // ),
                child: Column(
                  children: [
                    IconButton(
                        onPressed: (){
                          Scaffold.of(context).openDrawer();
                          // FocusScope.of(context).unfocus();
                        },
                        tooltip: MaterialLocalizations.of(context)
                            .openAppDrawerTooltip,
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 30,
                        )),
                    const SingleChildScrollView(
                      child: SizedBox(
                        height: 20,
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          Map<String, dynamic> items;

                          items = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                    builder: (context, setState) {
                                      return AlertDialog(
                                        title: Container(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          height: 100,
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Text(
                                                "Add Token",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  padding: const EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(5),
                                                    color: Colors.black,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 200,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(3),
                                                            color: Colors.white),
                                                        child: Center(
                                                          child: TextFormField(

                                                            onEditingComplete: () {
                                                              FocusScope.of(context)
                                                                  .unfocus();

                                                              setState(() {
                                                                keyboard = false;
                                                              });
                                                            },
                                                            onTap: () {
                                                              setState(() {
                                                                keyboard = true;
                                                              });
                                                            },
                                                            controller:
                                                            tableController,
                                                            keyboardType:
                                                            TextInputType.number,
                                                            decoration:
                                                            InputDecoration(
                                                              labelText:
                                                              'Token No',
                                                              hoverColor:
                                                              default_color,
                                                              hintText:
                                                              'Token No',
                                                              border:
                                                              OutlineInputBorder(
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
                                                                    width: 1.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              FocusScope.of(context).unfocus();
                                              Navigator.pop(context,);
                                              keyboard = false;
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              FocusScope.of(context).unfocus();
                                              keyboard = false;
                                              Navigator.pop(context,);
                                              await FirebaseFirestore.instance
                                                  .collection('tables')
                                                  .doc(currentBranchId)
                                                  .collection('tables')
                                                  .doc(tableController.text)
                                                  .set({
                                                'items': [],
                                                'name': tableController.text,
                                                'tableNo':int.parse(tableController.text),
                                              });

                                              // Navigator.pop(context, items);
                                            },
                                            child: const Text('Add'),
                                          ),
                                        ],
                                      );
                                    });
                              });
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: tables.length,
                          itemBuilder: (context, index) {
                            return Column(children: [
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onLongPress: ()async{
                                  QuerySnapshot doc=await FirebaseFirestore.instance.collection('tables')
                                      .doc(currentBranchId)
                                      .collection('tables')
                                      .where('name',isEqualTo: tables[index].toString())
                                      // .orderBy('tableNo',descending:true)
                                      .get();
                                  int tb=0;
                                  var data=doc.docs;

                                  // for(var item in doc.docs){
                                  //   int tableNo=int.tryParse(item['name']);
                                  //   tb=tb++;
                                  //   if(tb==tableNo){
                                  //     data.add(item);
                                  //   }
                                  // }
                                  // data.sort((a, b) {
                                  //   return b['name'].compareTo(a['name']);
                                  // });
                                  DocumentSnapshot docs=data[0];
                                  await docs.reference.delete();

                                  showUploadMessage(context, 'Table Deleted...');

                                },
                                child: Container(
                                  padding:
                                  const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: index == selectedTableIndex
                                          ? Colors.white
                                          : default_color,
                                      border: Border.all(
                                          color: Colors.white)),
                                  child: Center(
                                    child: Text(
                                      arabicLanguage?arabicNumber.convert(tables[index]):tables[index],
                                      style: TextStyle(
                                          color: index != selectedTableIndex
                                              ? Colors.white
                                              : default_color,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  arabicLanguage?arabicNumber.convert(tables[index]):tables[index];
                                  selectedTableIndex = index;

                                 if(mounted){
                                   setState(() {
                                     selectedTable = tables[index];

                                     selectedTableIndex = index;
                                   });
                                 }
                                },
                              ),
                            ]);
                          }),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(

                  child: Column(
                    children: [

                      //appbar
                      Container(
                        color: default_color,
                        // decoration: BoxDecoration(
                        //     image: DecorationImage(
                        //         image: AssetImage("assets/awafi/coffeeappbar.jpg"),fit: BoxFit.cover
                        //     )
                        // ),
                        height: MediaQuery.of(context).size.height * 0.15,
                        padding: const EdgeInsets.only(right: 15, top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height:70 ,
                                width:150,
                                decoration: BoxDecoration(

                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.blue,
                                    border: Border.all(color: Colors.grey)
                                ),
                                child: Center(
                                  child: DropdownButton(
                                    borderRadius: BorderRadius.circular(10),
                                    alignment: AlignmentDirectional.centerStart,
                                    underline: Column(),
                                    dropdownColor: Colors.black,
                                    iconEnabledColor: Colors.white,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500
                                    ),
                                    value: dropdownvalue,
                                    icon: const Icon(
                                      Icons.expand_more,

                                    ),
                                    items: abcd.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(
                                          items,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      dropdownvalue = newValue;
                                      print(dropdownvalue);
                                      dropdownvalue=="Drive-Thru" && (deliveryCharge.text.isEmpty || deliveryCharge.text=="0")? delivery=DelCharge!.toStringAsFixed(2): delivery=deliveryCharge.text;
                                      if(mounted){
                                        setState(() {
                                         if(dropdownvalue=="Drive-Thru"){
                                         deliveryCharge.text=DelCharge.toString();
                                         }
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),

                            ),
                            const SizedBox(width: 15,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FFButtonWidget(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const Live_Orders_Widget()));

                                },
                                text: arabicLanguage?"الطلبات عبر الإنترنت":'Online Order',
                                options: FFButtonOptions(
                                  width: 150,
                                  height: 70,
                                  color: Colors.blue,
                                  textStyle: FlutterFlowTheme.subtitle2.override(
                                    fontFamily: 'Overpass',
                                    color: Colors.red,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  elevation: 10,
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  borderRadius: 12,
                                ), 
                              ),
                            ),
                            const SizedBox(width: 15,),

                            // Expanded(
                            //   child: SwitchListTile.adaptive(
                            //     value: blue ??= true,
                            //     onChanged: (newValue) async {
                            //
                            //       blue = newValue;
                            //
                            //       if(blue&&!bluetoothConnected){
                            //         if(_getDeviceItems().length==0){
                            //           await   initPlatformState();
                            //         }
                            //         // print('aaaaaa');
                            //
                            //         showDialog(context: context,
                            //             builder: (alertDialogContext){
                            //
                            //               return   AlertDialog(
                            //                 content: Container(
                            //                   child: Column(
                            //                     mainAxisSize: MainAxisSize.min,
                            //                     children: <Widget>[
                            //                       Row(
                            //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //                         children: <Widget>[
                            //                           Text(
                            //                             'Device:',
                            //                             style: TextStyle(
                            //                               fontWeight: FontWeight.bold,
                            //                             ),
                            //                           ),
                            //                           DropdownButton(
                            //                             items: _getDeviceItems(),
                            //                             onChanged: (value) =>
                            //                                 setState(() => device = value),
                            //                             value: device,
                            //                           ),
                            //                         ],
                            //                       ),
                            //                       Row(
                            //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //                         children: [
                            //                           ElevatedButton(
                            //                             onPressed: () async {
                            //                               blue=false;
                            //                               bluetoothConnected=false;
                            //                               pressed=false;
                            //                               setState(() {
                            //
                            //
                            //                               });
                            //                               Navigator.pop(context);
                            //                             },
                            //                             child: Text('Reset'),
                            //                           ),
                            //                           ElevatedButton(
                            //                             onPressed: pressed
                            //                                 ? null
                            //                                 : bluetoothConnected
                            //                                 ? _disconnect
                            //                                 : btConnect,
                            //
                            //                             child: Text(bluetoothConnected ? 'Disconnect' : 'Connect'),
                            //                           ),
                            //
                            //                         ],
                            //                       ),
                            //                     ],
                            //                   ),
                            //                 ),
                            //               );
                            //             }
                            //         );
                            //
                            //       }
                            //
                            //       setState(()  {
                            //         blue = newValue;
                            //
                            //       }
                            //
                            //       );
                            //
                            //     },
                            //     title: Text(
                            //       arabicLanguage?"البلوتوث":'Bluetooth',
                            //       style: FlutterFlowTheme.title3.override(
                            //         fontFamily: 'Lexend Deca',
                            //         color: Colors.white,
                            //         fontSize: 17,
                            //         fontWeight: FontWeight.w600,
                            //       ),
                            //     ),
                            //     tileColor:Colors.grey,
                            //     inactiveTrackColor: Colors.grey.shade100,
                            //     activeColor: Colors.green,
                            //     activeTrackColor: Colors.yellow,
                            //     dense: true,
                            //     controlAffinity: ListTileControlAffinity.leading,
                            //     contentPadding: EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
                            //   ),
                            // ),


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
                            //         value: currentWaiter,
                            //         disabledHint: const Text("Waiter",style: TextStyle(
                            //               color: Colors.white,
                            //               fontSize: 18,
                            //               fontWeight: FontWeight.w500
                            //           )),
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
                            //           currentWaiter = newValue;
                            //           setState(() {
                            //
                            //           });
                            //         },
                            //       ),
                            //     ),
                            //   ),
                            //
                            // ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  arabicLanguage?branchNameArabic!: currentBranchName!,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                const SizedBox(height: 10,),
                                const Text(
                                  "LOGGED IN USER",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(width: 15,),
                            // const CircleAvatar(
                            //   backgroundImage: NetworkImage("https://scontent.fcok4-1.fna.fbcdn.net/v/t1.6435-9/41645109"
                            //       "_1747771551988756_2209695106821259264_n.jpg?_nc_cat=102&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=Ir5KrY_qwQcAX-4TTg1&_nc_ht=scontent.fcok4-1.fna&oh=6f210f4258122449225c7fc2ab0606dd&oe=6176D772"),
                            // ),
                            Expanded(
                                child: Center(
                                    child: Text(
                                      arabicLanguage?"${arabicNumber.convert(token)}  : رمز":"Token : $token",
                                      style: const TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ))),
                            const SizedBox(width: 15,),

                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: InkWell(
                                onTap: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return AlertDialog(
                                        title: const Text('Clear Tokens !'),
                                        content: const Text('Do  You want to clear Tokens?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(alertDialogContext),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () async {

                                              FirebaseFirestore.instance
                                                  .collection('invoiceNo')
                                                  .doc(currentBranchId)
                                                  .update({
                                                'token':0,
                                              });

                                              Navigator.pop(alertDialogContext);
                                              showUploadMessage(context, 'Token Cleared');

                                            },
                                            child: Text('Confirm'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Colors.white,width: 2
                                    )
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10.0,right: 10),
                                      child: Text(arabicLanguage?"الرمز مسح: ${
                                          arabicNumber.convert(token)}":'Token Clear $token',
                                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 10.0),
                            //   child: InkWell(
                            //     onTap: () async {
                            //     if(items.length==0){
                            //       showUploadMessage(context, "PLEASE CHOOSE ITEMS");
                            //     }else{
                            //       await showDialog(
                            //         context: context,
                            //         builder: (alertDialogContext) {
                            //           return AlertDialog(
                            //             title: const Text('Dinner sale'),
                            //             content: const Text('Confirm Dinner Certificate Sale'),
                            //             actions: [
                            //               TextButton(
                            //                 onPressed: () => Navigator.pop(alertDialogContext),
                            //                 child: const Text('Cancel'),
                            //               ),
                            //               TextButton(
                            //                 onPressed: () async {
                            //                   setItemWidgets(items);
                            //                   dinnerCertificate=true;
                            //                   paidCash.text="0";
                            //                   paidBank.text="0";
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
                            //     }
                            //     },
                            //     child: Container(
                            //       height: 40,
                            //       decoration: BoxDecoration(
                            //           color: dinnerCertificate?Colors.green:Colors.red,
                            //         borderRadius: BorderRadius.circular(15),
                            //         border: Border.all(
                            //           color: Colors.white,width: 2
                            //         )
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
                            // )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),


                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration:  BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    offset: const Offset(
                                      0.0,
                                      -1.0,
                                    ),
                                    blurRadius: 20.0,
                                    spreadRadius: 1.0,
                                  ), //BoxShadow
                                  //BoxShadow
                                ],
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            offset: const Offset(
                                              0.0,
                                              -1.0,
                                            ),
                                            blurRadius: 20.0,
                                            spreadRadius: 1.0,
                                          ), //BoxShadow
                                          //BoxShadow
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 40,
                                            color: Colors.grey.shade200,
                                            child: Row(
                                              children:  [
                                                Expanded(
                                                  flex: 1,
                                                  child: Center(
                                                      child: Text(
                                                        arabicLanguage?"عدد":"NO:",
                                                        style: const TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold),
                                                      )),
                                                ),
                                                Expanded(
                                                  flex: 6,
                                                  child: Center(
                                                      child: Text(
                                                        arabicLanguage? 'منتج':"NAME",
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold),
                                                      )),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Center(
                                                      child: Text(
                                                        arabicLanguage? 'سعر':"PRICE",
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold),
                                                      )),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Center(
                                                      child: Text(
                                                        arabicLanguage?"كمية":"QTY",
                                                        style: const TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold),
                                                      )),
                                                ),
                                                const Expanded(
                                                  flex: 1,
                                                  child: Center(
                                                      child: Text(
                                                        "",

                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold),
                                                      )),
                                                )
                                              ],
                                            ),
                                          ),


                                          //Add Section
                                          Expanded(
                                            child:
                                            SingleChildScrollView(
                                              child: StreamBuilder<DocumentSnapshot>(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection('tables')
                                                      .doc(currentBranchId)
                                                      .collection('tables')
                                                      .doc(selectedTable)
                                                      .snapshots(),
                                                  builder:
                                                      (context, snapshot) {
                                                    items = [];
                                                    itemList=[];

                                                    if (!snapshot.hasData) {
                                                      return Container();
                                                    }
                                                    totalAmount = 0;
                                                    if (snapshot.data!
                                                        .get('items') !=
                                                        null) {
                                                      items = snapshot.data!
                                                          .get('items');

                                                      previousItems=[];
                                                      for (dynamic item
                                                      in snapshot.data!
                                                          .get('items')) {
                                                        previousItems.add(item);

                                                        itemList.add(
                                                            {
                                                              'arabicName':item['arabicName'],
                                                              'addOnArabic':item['addOnArabic'],
                                                              'variants':item['variants'],
                                                              'pdtname':item['pdtname'],
                                                              'price':item['price'],
                                                              'category':item['category'],
                                                              'qty':item['qty'],
                                                              'addOns':item['addOns']??[],
                                                              'addOnPrice':  item['addOnPrice']??0+item['removePrice']??0+item['addLessPrice']??0+item['addMorePrice']??0,
                                                              'ingredients':item['ingredients'],


                                                              'addLess': item['addLess']??[],
                                                              'addMore':item['addMore']??[],
                                                              'remove': item['remove']??[],
                                                              'removeArabic':item['removeArabic']??[],
                                                              'addLessArabic':item['addLessArabic']??[],
                                                              'addMoreArabic':item['addMoreArabic']??[],
                                                              'addMorePrice':item['addMorePrice']??0,
                                                              'addLessPrice':item['addLessPrice']??0,
                                                              'removePrice':item['removePrice']??0,
                                                              "variantName":item['variantName']??'',
                                                              "variantNameArabic":item['variantNameArabic']??'',
                                                              'return':false,
                                                              'returnQty':0
                                                            });
                                                        print(double.tryParse(item['price'].toString()));
                                                        print(double.tryParse(item['addOnPrice'].toString()));
                                                        print(double.tryParse(item['addLessPrice'].toString()));
                                                        print(double.tryParse(item['addMorePrice'].toString()));
                                                        print(double.tryParse(item['removePrice'].toString()));

                                                        totalAmount += (double.tryParse(item['price'].toString())! +
                                                            double.tryParse(item['addOnPrice'].toString())!
                                                            +double.tryParse(item['addLessPrice'].toString())!
                                                            +double.tryParse(item['addMorePrice'].toString())!
                                                            + double.tryParse(item['removePrice'].toString())!) * item['qty'];
                                                        print("totalAmountttttttttttttttttttttttttttttttttttttttt");
                                                        print(totalAmount);
                                                        double grandTotal=(totalAmount - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0))??0;
                                                        // paidCash.text=grandTotal.toStringAsFixed(2)??0;


                                                      }
                                                    }
                                                    return Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Container(
                                                            padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 10),
                                                            // child:  Container(),
                                                            child: keyboard
                                                                ? Container()
                                                                : BillWidget(
                                                              items: snapshot.data!.get('items'),
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                20,
                                                                10,
                                                                20,
                                                                10),
                                                            color: Colors
                                                                .blueGrey
                                                                .shade100,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                              children: [
                                                                Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    Text(
                                                                      arabicLanguage?"الإجمالي                                  : ": "Total Amount",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                          15,
                                                                          color:
                                                                          Colors.grey.shade700),
                                                                    ),
                                                                    Text(
                                                                      arabicLanguage?"تخفيض                                   :   ":"Discount",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                          15,
                                                                          color:
                                                                          Colors.grey.shade700),
                                                                    ),
                                                                    Text(
                                                                      arabicLanguage?"رقم ضريبة                               : ":"Vat ",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                          15,
                                                                          color:
                                                                          Colors.grey.shade700),
                                                                    ),
                                                                    Text(
                                                                      arabicLanguage?"توصيل                                    :  ":"Delivery ",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                          15,
                                                                          color:
                                                                          Colors.grey.shade700),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                      10,
                                                                    ),
                                                                    Text(
                                                                      arabicLanguage? "المجموع الإجمالي                  : ":"Grand Total",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                          16,
                                                                          color:
                                                                          Colors.grey.shade700),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                                  children: [
                                                                    Text(arabicLanguage? "SR ${arabicNumber.convert((totalAmount*100/(100+gst)).toStringAsFixed(2))}":"SR ${(totalAmount*100/(100+gst)).toStringAsFixed(2)}",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                          15,
                                                                          color:
                                                                          Colors.grey.shade700),
                                                                    ),
                                                                    Text(
                                                                           arabicLanguage?(double.tryParse(discount) == null ? arabicNumber.convert(00):"SR ${arabicNumber.convert(double.tryParse(discount)!.toStringAsFixed(2))}"):(double.tryParse(discount) == null ? "0.00":"SR ${double.tryParse(discount)!.toStringAsFixed(2)}"),
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                          15,
                                                                          color:
                                                                          Colors.grey.shade700),
                                                                    ),
                                                                    Text(arabicLanguage?" SR ${arabicNumber.convert((totalAmount * gst /(100+gst)).toStringAsFixed(2))}":" SR ${(totalAmount * gst /(100+gst)).toStringAsFixed(2)}",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                          15,
                                                                          color:
                                                                          Colors.grey.shade700),
                                                                    ),
                                                                    Text(
                                                                           arabicLanguage?(double.tryParse(delivery) == null ? arabicNumber.convert(00):"SR ${arabicNumber.convert(double.tryParse(delivery)!.toStringAsFixed(2))}"):(double.tryParse(delivery) == null ? "0.00":"SR ${double.tryParse(delivery)!.toStringAsFixed(2)}"),
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                          15,
                                                                          color:
                                                                          Colors.grey.shade700),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                      10,
                                                                    ),
                                                                    Text(
                                                                      arabicLanguage? "SR ${arabicNumber.convert((totalAmount - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0)).toStringAsFixed(2))}":"SR ${(totalAmount - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0)).toStringAsFixed(2)}",
                                                                      style: TextStyle(

                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                          16,
                                                                          color:
                                                                          Colors.grey.shade700),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ]);
                                                  }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // const SizedBox(
                                  //   height: 20,
                                  // ),

                                  //DISCOUNT AND DELIVERY
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.12,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        //CREDIT USER
                                        // SizedBox(
                                        //   height: MediaQuery.of(context).size.height *
                                        //       0.12,
                                        //   child: Column(
                                        //     crossAxisAlignment:
                                        //     CrossAxisAlignment.start,
                                        //     children: [
                                        //       Row(
                                        //         children:  [
                                        //           Expanded(
                                        //             child: Text(
                                        //               arabicLanguage? 'مستخدم الائتمان  :  ':"CREDIT USER  :-",
                                        //               textAlign: TextAlign.center,
                                        //               style: const TextStyle(
                                        //                   fontWeight: FontWeight.bold),
                                        //             ),
                                        //           ),
                                        //
                                        //         ],
                                        //       ),
                                        //       const SizedBox(
                                        //         height: 5,
                                        //       ),
                                        //       Row(
                                        //         children: [
                                        //           SizedBox(
                                        //             width:30,
                                        //           ),
                                        //           Expanded(
                                        //             child: Container(
                                        //               height: 45,
                                        //               child: TextFormField(
                                        //
                                        //                 onChanged: (x){
                                        //                   setState(() {
                                        //                     print('value     $x');
                                        //                     getCreditDetailes(x);
                                        //
                                        //                   });
                                        //
                                        //                 },
                                        //
                                        //
                                        //                 onTap: () {
                                        //                   setState(() {
                                        //                     // keyboard = true;
                                        //                   });
                                        //                 },
                                        //                 controller: mobileNo,
                                        //                 keyboardType:TextInputType.number,
                                        //
                                        //                 decoration: InputDecoration(
                                        //
                                        //
                                        //                     hoverColor: default_color,
                                        //                     hintText: arabicLanguage?'رقمالهتف  :  ':'Mobile NO:',
                                        //                     border:
                                        //                     OutlineInputBorder(
                                        //                       borderRadius:
                                        //                       BorderRadius
                                        //                           .circular(5.0),
                                        //                     ),
                                        //                     focusedBorder:
                                        //                     OutlineInputBorder(
                                        //                       borderSide: BorderSide(
                                        //                           color: Colors
                                        //                               .pink.shade900,
                                        //                           width: 1.0),
                                        //                     ),
                                        //                     contentPadding: EdgeInsets.all(5)
                                        //                 ),
                                        //               ),
                                        //             ),
                                        //           ),
                                        //           const SizedBox(
                                        //             width: 30,
                                        //           ),
                                        //           InkWell(
                                        //             onTap: () async {
                                        //               // setState(() {
                                        //               keyboard = false;
                                        //               FocusScope.of(context)
                                        //                   .unfocus();
                                        //               taped =true;
                                        //               if(taped){
                                        //                 print("$creditMap---------------------------111111");
                                        //                 if(mobileNo.text!=""&&creditMap!=null&&creditMap.isNotEmpty){
                                        //
                                        //                   print("$creditMap---------------------------22222");
                                        //
                                        //                   String  credituserId=creditMap.keys.toList()[0];
                                        //                   userMap=creditMap[credituserId];
                                        //
                                        //                   return showDialog<void>(
                                        //                     context: context,
                                        //                     barrierDismissible: false, // user must tap button!
                                        //                     builder: (BuildContext context) {
                                        //                       return AlertDialog(
                                        //                         title: const Text('Credit User'),
                                        //                         content:  SingleChildScrollView(
                                        //                           child: ListBody(
                                        //                             children: [
                                        //                               Column(
                                        //                                 children: const [
                                        //                                   CircleAvatar(radius: 30,
                                        //                                     child: Icon(Icons.person),),
                                        //                                 ],
                                        //                               ),
                                        //                               SizedBox(height: 10,),
                                        //                               Text('Name        :${userMap["name"]}'),
                                        //                               Text('Mobile No   :${userMap["phone"]}'),
                                        //
                                        //                             ],
                                        //                           ),
                                        //                         ),
                                        //                         actions: <Widget>[
                                        //                           TextButton(
                                        //
                                        //                             child:  const Text('Cancel',style: TextStyle(color: Colors.red),),
                                        //                             onPressed: () {
                                        //                               creditMap={};
                                        //                               userMap={};
                                        //                               approve=false;
                                        //                               Navigator.of(context).pop();
                                        //                               paidCash.text="0";
                                        //                               paidBank.text="0";
                                        //                               mobileNo.text="";
                                        //                             },
                                        //                           ),
                                        //                           TextButton(
                                        //                             child: const Text('Approve'),
                                        //                             onPressed: () {
                                        //                               setItemWidgets(items);
                                        //                               approve=true;
                                        //                               Navigator.of(context).pop();
                                        //                               paidCash.text="0";
                                        //                               paidBank.text="0";
                                        //                               setState(() {
                                        //
                                        //                               });
                                        //                             },
                                        //                           ),
                                        //
                                        //                         ],
                                        //                       );
                                        //                     },
                                        //                   );
                                        //
                                        //
                                        //                 }
                                        //                 else{
                                        //                   showUploadMessage(context, "Please Enter Valid Mobile Number");
                                        //                 }
                                        //               }
                                        //               setState(() {
                                        //
                                        //               });
                                        //               // Navigator.pop(context);
                                        //
                                        //
                                        //             },
                                        //             child: Container(
                                        //               width: 100,
                                        //               height: MediaQuery.of(context)
                                        //                   .size
                                        //                   .height *
                                        //                   0.06,
                                        //               decoration: BoxDecoration(
                                        //                   color: Colors.green,
                                        //                   borderRadius:
                                        //                   BorderRadius.circular(
                                        //                       10)),
                                        //               child: const Center(
                                        //                 child: Text(
                                        //                   "ENTER",
                                        //                   style: TextStyle(
                                        //                       color: Colors.white,
                                        //                       fontWeight:
                                        //                       FontWeight.bold,
                                        //                       fontSize: 16),
                                        //                 ),
                                        //               ),
                                        //             ),
                                        //           ),
                                        //
                                        //         ],
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),


                                        Row(
                                          children:  [
                                             Expanded(
                                              child: Text(
                                                arabicLanguage?"تخفيض":"DISCOUNT  :",
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                arabicLanguage?"توصيل":"DELIVERY  :",
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
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
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 45,
                                                child: TextFormField(

                                                  onEditingComplete: () {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    if(discountController.text.contains("%")){
                                                      double disc =double.tryParse(discountController.text.replaceAll("%", "").trim())??0;
                                                      discount = (totalAmount*disc/100).toStringAsFixed(2);
                                                    }else{
                                                      discount = discountController.text;
                                                    }

                                                    setState(() {
                                                      keyboard = false;
                                                    });
                                                  },
                                                  onTap: () {
                                                    setState(() {
                                                      // keyboard = true;
                                                    });
                                                  },
                                                  controller: discountController,
                                                  keyboardType:
                                                  TextInputType.text,
                                                  decoration: InputDecoration(
                                                    // labelText: 'DISCOUNT',
                                                    hoverColor: default_color,
                                                    hintText: arabicLanguage?"تخفيض":'Discount',
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
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  keyboard = false;
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  if(discountController.text.contains("%")){
                                                    double disc =double.tryParse(discountController.text.replaceAll("%", "").trim())??0;
                                                    discount = (totalAmount*disc/100).toStringAsFixed(2);
                                                  }else{
                                                    discount = discountController.text;
                                                  }

                                                });
                                              },
                                              child: Container(
                                                // width: 100,
                                                // height: MediaQuery.of(context)
                                                //     .size
                                                //     .height *
                                                //     0.06,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        10)),
                                                child:  const Center(
                                                  child:Padding(
                                                    padding: EdgeInsets.all(8.0),
                                                    child: Icon(Icons.check,color:Colors.white,size: 30,),
                                                  )
                                                  // child: Text(
                                                  //  arabicLanguage? "يدخل":"ENTER",
                                                  //   style: const TextStyle(
                                                  //       color: Colors.white,
                                                  //       fontWeight:
                                                  //       FontWeight.bold,
                                                  //       fontSize: 16),
                                                  // ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Container(
                                                  height: 45,
                                                child: TextFormField(
                                                  onEditingComplete: () {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    delivery = deliveryCharge.text;
                                                    setState(() {
                                                      // keyboard = false;
                                                    });
                                                  },
                                                  onTap: () {
                                                    setState(() {
                                                      // keyboard = true;
                                                    });
                                                  },
                                                  controller:
                                                  deliveryCharge,
                                                  keyboardType:
                                                  TextInputType.number,
                                                  decoration: InputDecoration(
                                                    // labelText: 'DELIVERY',
                                                    hoverColor: default_color,
                                                    hintText: arabicLanguage?"رسوم التوصيل":'Delivery Charge',
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
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  keyboard = false;
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  delivery =
                                                      deliveryCharge.text;
                                                });
                                              },
                                              child: Container(
                                                // width: 100,
                                                // height: MediaQuery.of(context)
                                                //     .size
                                                //     .height *
                                                //     0.06,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        10)),
                                                child:  Center(
                                                    child:Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Icon(Icons.check,color:Colors.white,size: 30,),
                                                    )
                                                  // child: Text(
                                                  //   arabicLanguage? "يدخل":"ENTER",
                                                  //   style: TextStyle(
                                                  //       color: Colors.white,
                                                  //       fontWeight:
                                                  //       FontWeight.bold,
                                                  //       fontSize: 16),
                                                  // ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 45,
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
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            InkWell(




                                              // onTap: () async {
                                              //   keyboard = false;
                                              //   FocusScope.of(context)
                                              //       .unfocus();
                                              //   taped =true;
                                              //   if(taped){
                                              //     if(mobileNo.text!=""&&creditMap!=null&&creditMap.isNotEmpty){
                                              //       String  credituserId=creditMap.keys.toList()[0];
                                              //       userMap=creditMap[credituserId];
                                              //       return showDialog<void>(
                                              //         context: context,
                                              //         barrierDismissible: false, // user must tap button!
                                              //         builder: (BuildContext context) {
                                              //           return AlertDialog(
                                              //             title: const Text('Credit User'),
                                              //             content:  SingleChildScrollView(
                                              //               child: ListBody(
                                              //                 children: [
                                              //                   Column(
                                              //                     children: const [
                                              //                       CircleAvatar(radius: 30,
                                              //                         child: Icon(Icons.person),),
                                              //                     ],
                                              //                   ),
                                              //                   SizedBox(height: 10,),
                                              //                   Text('Name        :${userMap["name"]}'),
                                              //                   Text('Mobile No   :${userMap["phone"]}'),
                                              //
                                              //                 ],
                                              //               ),
                                              //             ),
                                              //             actions: <Widget>[
                                              //               TextButton(
                                              //
                                              //                 child:  const Text('Cancel',style: TextStyle(color: Colors.red),),
                                              //                 onPressed: () {
                                              //                   creditMap={};
                                              //                   userMap={};
                                              //                   approve=false;
                                              //                   Navigator.of(context).pop();
                                              //                   paidCash.text="0";
                                              //                   paidBank.text="0";
                                              //                   mobileNo.text="";
                                              //                 },
                                              //               ),
                                              //               TextButton(
                                              //                 child: const Text('Approve'),
                                              //                 onPressed: () {
                                              //                   setItemWidgets(items);
                                              //                   approve=true;
                                              //                   Navigator.of(context).pop();
                                              //                   paidCash.text="0";
                                              //                   paidBank.text="0";
                                              //                   setState(() {
                                              //
                                              //                   });
                                              //                 },
                                              //               ),
                                              //
                                              //             ],
                                              //           );
                                              //         },
                                              //       );
                                              //
                                              //
                                              //     }
                                              //     else{
                                              //       showUploadMessage(context, "Please Enter Valid Mobile Number");
                                              //     }
                                              //   }
                                              //   setState(() {
                                              //
                                              //   });
                                              //
                                              //
                                              // },
                                              onTap: () async {
                                                if(items.isNotEmpty){
                                                  // if(currentWaiter!=null){
                                                  setItemWidgets1(items)
                                                      .then((value){
                                                    if(enable){

                                                      keyboard = false;
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                      taped =true;
                                                      if(taped){
                                                        print("$creditMap---------------------------111111");
                                                        if(mobileNo.text!=""&&creditMap!=null&&creditMap.isNotEmpty){

                                                          print("$creditMap---------------------------22222");

                                                          String  credituserId=creditMap.keys.toList()[0];
                                                          userMap=creditMap[credituserId];

                                                          return showDialog<void>(
                                                            context: context,
                                                            barrierDismissible: false, // user must tap button!
                                                            builder: (BuildContext context) {
                                                              return AlertDialog(
                                                                content: StatefulBuilder(
                                                                  builder: (BuildContext context, StateSetter setState) {
                                                                    setState;
                                                                    return SingleChildScrollView(
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
                                                                          Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                              children:[
                                                                                TextButton(

                                                                                  child:  const Text('Cancel',style: TextStyle(color: Colors.red),),
                                                                                  onPressed: () {
                                                                                    creditMap={};
                                                                                    userMap={};
                                                                                    approve=false;
                                                                                    Navigator.of(context).pop();
                                                                                    paidCash.text="0";
                                                                                    paidBank.text="0";
                                                                                    mobileNo.text="";
                                                                                  },
                                                                                ),
                                                                                TextButton(
                                                                                  child: const Text('Approve'),
                                                                                  onPressed: () async {

                                                                                    // onTap: () async {
                                                                                    print("approve============================");
                                                                                    print(approve);
                                                                                    print(userMap["name"]);
                                                                                    approve=true;

                                                                                    paidCash.text="0";
                                                                                    paidBank.text="0";
                                                                                    // if(currentWaiter!=null) {
                                                                                      String billDiscount = discount;
                                                                                      if (!disable) {
                                                                                        // List itemsList=items;
                                                                                        for(var b in items){
                                                                                          if(b["variantName"]!=''){
                                                                                            b['pdtname']="${b["pdtname"]} ${b["variantName"]??''}";
                                                                                            b['arabicName']="${b["pdtname"]} ${b["variantNameArabic"]??''}";
                                                                                          }
                                                                                        }
                                                                                        double netTotal = approve ? 0.00 : totalAmount - (double.tryParse(discount) ?? 0) + (double.tryParse(delivery) ?? 0);
                                                                                        print("netTotal=========================");
                                                                                        print(netTotal);
                                                                                        bankPaid=(amexPaid+madaPaid+visaPaid+masterPaid??0);
                                                                                        disable = true;
                                                                                        try {
                                                                                          if (items
                                                                                              .isNotEmpty) {
                                                                                            DocumentSnapshot invoiceNoDoc =
                                                                                            await FirebaseFirestore
                                                                                                .instance
                                                                                                .collection(
                                                                                                'invoiceNo')
                                                                                                .doc(
                                                                                                currentBranchId)
                                                                                                .get();

                                                                                            int invoiceNo =
                                                                                            invoiceNoDoc
                                                                                                .get(
                                                                                                'sales');
                                                                                            int token =
                                                                                            invoiceNoDoc
                                                                                                .get(
                                                                                                'token');
                                                                                            invoiceNo++;
                                                                                            token++;

                                                                                            List<
                                                                                                String> ingredientIds = [
                                                                                            ];
                                                                                            for (var a in items) {
                                                                                              for (var b in a['ingredients'] ??
                                                                                                  [
                                                                                                  ]) {
                                                                                                ingredientIds
                                                                                                    .add(
                                                                                                    b['ingredientId']);
                                                                                              }
                                                                                            }
                                                                                            blue
                                                                                                ?
                                                                                            showDialog(
                                                                                                barrierDismissible: false,
                                                                                                context: context,
                                                                                                builder:
                                                                                                    (
                                                                                                    BuildContext context) {
                                                                                                  items =
                                                                                                      items;
                                                                                                  printCopy =
                                                                                                      items;
                                                                                                  copyToken =
                                                                                                      token;
                                                                                                  copyInvoice =
                                                                                                      invoiceNo;
                                                                                                  copyCustomer =
                                                                                                  'Walking Customer';
                                                                                                  copyDate =
                                                                                                      DateTime
                                                                                                          .now();
                                                                                                  copyDelivery =
                                                                                                      double
                                                                                                          .tryParse(
                                                                                                          discount) ??
                                                                                                          0;
                                                                                                  copyDiscount =
                                                                                                      double
                                                                                                          .tryParse(
                                                                                                          discount)!;
                                                                                                  return mytest(
                                                                                                      salesDate: DateTime
                                                                                                          .now(),
                                                                                                      items: items,
                                                                                                      token: token,
                                                                                                      delivery: double
                                                                                                          .tryParse(
                                                                                                          discount),
                                                                                                      customer: 'Walking Customer',
                                                                                                      discountPrice: double
                                                                                                          .tryParse(
                                                                                                          discount),
                                                                                                      invoiceNo: invoiceNo
                                                                                                          .toString(),
                                                                                                      selectedTable: selectedTable,
                                                                                                      cashPaid: double
                                                                                                          .tryParse(
                                                                                                          paidCash
                                                                                                              .text) ??
                                                                                                          0,
                                                                                                      bankPaid: double
                                                                                                          .tryParse(
                                                                                                          paidBank
                                                                                                              .text) ??
                                                                                                          0,
                                                                                                      balance: balance ??
                                                                                                          0
                                                                                                  );
                                                                                                })
                                                                                                : abc(
                                                                                                invoiceNo,
                                                                                                double
                                                                                                    .tryParse(
                                                                                                    discount)??0,
                                                                                                items,
                                                                                                token,
                                                                                                selectedTable,
                                                                                                double
                                                                                                    .tryParse(
                                                                                                    delivery) ??
                                                                                                    0,
                                                                                                double
                                                                                                    .tryParse(
                                                                                                    paidCash
                                                                                                        .text) ??
                                                                                                    0,
                                                                                                double
                                                                                                    .tryParse(
                                                                                                    paidBank
                                                                                                        .text) ??
                                                                                                    0,
                                                                                                balance ??
                                                                                                    0,
                                                                                                netTotal ??
                                                                                                    0,
                                                                                                dropdownvalue!,
                                                                                               );
                                                                                            await FirebaseFirestore
                                                                                                .instance
                                                                                                .collection(
                                                                                                'sales')
                                                                                                .doc(
                                                                                                currentBranchId)
                                                                                                .collection(
                                                                                                'sales')
                                                                                                .doc(
                                                                                                invoiceNo
                                                                                                    .toString())
                                                                                                .set(
                                                                                                {
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
                                                                                                  'billItems': items,
                                                                                                  'discount': double.tryParse(discount) ?? 0,
                                                                                                  'totalAmount': totalAmount * 100 / (100 + gst),
                                                                                                  'tax': totalAmount * gst / (100 + gst),
                                                                                                  'grandTotal': totalAmount - (double.tryParse(discount) ?? 0) + (double.tryParse(delivery) ?? 0),
                                                                                                  'paidCash': double.tryParse(paidCash.text) ?? 0,
                                                                                                  'paidBank': approve?0:bankPaid ?? 0,
                                                                                                  'cash': approve?false:paidCash.text==''|| paidCash.text=='0.0'||double.tryParse(paidCash.text)!<=0||paidCash.text==null?false:true ,
                                                                                                  'bank': approve||bankPaid<=0?false:true,
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
                                                                                                  "amexAmount":double.tryParse(amex.text)??0,
                                                                                                  "madaAmount":double.tryParse(mada.text)??0,
                                                                                                  "visaAmount":double.tryParse(visa.text)??0,
                                                                                                  "masterAmount":double.tryParse(master.text)??0,
                                                                                                  "cancel":false,
                                                                                                  "orderType":dropdownvalue,
                                                                                                  // "waiterName":currentWaiter

                                                                                                });
                                                                                            FirebaseFirestore
                                                                                                .instance
                                                                                                .collection(
                                                                                                'invoiceNo')
                                                                                                .doc(
                                                                                                currentBranchId)
                                                                                                .update(
                                                                                                {
                                                                                                  'sales':
                                                                                                  FieldValue
                                                                                                      .increment(
                                                                                                      1),
                                                                                                  'token':
                                                                                                  FieldValue
                                                                                                      .increment(
                                                                                                      1)
                                                                                                });

                                                                                            await FirebaseFirestore
                                                                                                .instance
                                                                                                .collection(
                                                                                                'tables')
                                                                                                .doc(
                                                                                                currentBranchId)
                                                                                                .collection(
                                                                                                'tables')
                                                                                                .doc(
                                                                                                selectedTable)
                                                                                                .update(
                                                                                                {
                                                                                                  'items': [
                                                                                                  ]
                                                                                                });
                                                                                            setState(() {
                                                                                              mobileNo
                                                                                                  .text =
                                                                                              '';
                                                                                              deliveryCharge
                                                                                                  .text =
                                                                                              '0';

                                                                                              qty =
                                                                                              0;
                                                                                              enable =
                                                                                              false;
                                                                                              approve =
                                                                                              false;
                                                                                            }


                                                                                            );
                                                                                          }
                                                                                        }
                                                                                        catch (e) {
                                                                                          disable =
                                                                                          false;
                                                                                          showUploadMessage(
                                                                                              context,
                                                                                              e
                                                                                                  .toString());
                                                                                        }
                                                                                        setState(() {
                                                                                          approve =
                                                                                          false;
                                                                                        });
                                                                                      }

                                                                                      else {
                                                                                        showUploadMessage(
                                                                                            context,
                                                                                            "Another Print Already In Queue");
                                                                                      }
                                                                                      // }

                                                                                      setState(() {
                                                                                        approve = false;
                                                                                        creditMap = {};
                                                                                        userMap = {};
                                                                                        discount = '0.00';
                                                                                        delivery = '0.00';
                                                                                        disable =
                                                                                        false;
                                                                                        paidCash.text = '';
                                                                                        paidBank.text = '';
                                                                                        totalAmount = 0;
                                                                                        balance = 0;
                                                                                        cashPaid = 0;
                                                                                        bankPaid = 0;
                                                                                        dropdownvalue ="Take Away";
                                                                                        currentWaiter=null;
                                                                                        Navigator.of(context).pop();
                                                                                      });





                                                                                  },
                                                                                ),
                                                                              ]
                                                                          )
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
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


                                                    }
                                                  });
                                               // }
                                               //   else{
                                               // showUploadMessage(context, "Please Choose Waiter Name");
                                               //  }
                                                }
                                                else{
                                                  showUploadMessage(context, "PLEASE CHOOSE ITEMS");
                                                }


                                              },
                                              child: Container(

                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        10)),
                                                child: const Center(
                                                    child:Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Icon(Icons.check,color:Colors.white,size: 30,),
                                                    )
                                                  // child: Text(
                                                  //   "ENTER",
                                                  //   style: TextStyle(
                                                  //       color: Colors.white,
                                                  //       fontWeight:
                                                  //       FontWeight.bold,
                                                  //       fontSize: 16),
                                                  // ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              decoration: const BoxDecoration(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            offset: const Offset(0.0, -1.0,),
                                            blurRadius: 20.0,
                                            spreadRadius: 1.0,
                                          ), //BoxShadow
                                          //BoxShadow
                                        ],
                                      ),
                                       child: products?const ItemsPage():Container(),
                                      // child: const ItemsPage(),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(

                                          height: MediaQuery.of(context).size.height * 0.15,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                offset: const Offset(0.0, -1.0,),
                                                blurRadius: 20.0,
                                                spreadRadius: 1.0,
                                              ), //BoxShadow
                                              //BoxShadow
                                            ],
                                          ),
                                          child: Column(
                                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [

                                              //ADDON BUTTON
                                              // FFButtonWidget(
                                              //   onPressed: () {
                                              //     showDialog(
                                              //         context: context,
                                              //         builder: (BuildContext context) {
                                              //
                                              //           return StatefulBuilder(
                                              //               builder: (context,setState)
                                              //               {
                                              //                 return const AddOn();
                                              //               }
                                              //           );
                                              //         }
                                              //     );
                                              //
                                              //   },
                                              //   text: 'ADD ON',
                                              //   options: FFButtonOptions(
                                              //     width: 100,
                                              //     height: 70,
                                              //     color: Colors.green,
                                              //     textStyle: FlutterFlowTheme.subtitle2.override(
                                              //       fontFamily: 'Overpass',
                                              //       color: Colors.white,
                                              //       fontWeight: FontWeight.w800,
                                              //     ),
                                              //     elevation: 10,
                                              //     borderSide: const BorderSide(
                                              //       color: Colors.grey,
                                              //       width: 1,
                                              //     ),
                                              //     borderRadius: 12,
                                              //   ),
                                              // ),


                                              // FFButtonWidget(
                                              //   onPressed: () async {
                                              //     // print('paidCash.text');
                                              //     // print(paidCash.text);
                                              //     // print(paidBank.text);
                                              //
                                              //
                                              //     // if(paidBank.text!=''  || paidCash.text!=''){
                                              //       if(blue){
                                              //
                                              //
                                              //
                                              //         // print('paidCash.text');
                                              //         // print(paidCash.text);
                                              //
                                              //         await showDialog(
                                              //             barrierDismissible: false,
                                              //             context: context,
                                              //             builder: (BuildContext context) {
                                              //
                                              //               return mytest(items:printCopy,
                                              //                 token: copyToken,
                                              //                 salesDate: copyDate,
                                              //                 delivery: copyDelivery,
                                              //                 customer: 'Walking Customer',
                                              //                 discountPrice: copyDiscount,
                                              //                 invoiceNo: copyInvoice.toString(),
                                              //                 cashPaid:double.tryParse(paidCash.text)??0,
                                              //                 bankPaid:double.tryParse(paidBank.text)??0,
                                              //                 balance:balance??0
                                              //               );
                                              //             });
                                              //         setState(() {
                                              //           paidCash.text='0';
                                              //           paidCash.text='0';
                                              //           enable=false;
                                              //           approve=false;
                                              //           mobileNo.text='';
                                              //         });
                                              //
                                              //
                                              //       }else{
                                              //
                                              //         flutterUsbPrinter.write(Uint8List.fromList(bytes));
                                              //         bytes=[];
                                              //         if(lastCut==true){
                                              //            flutterUsbPrinter.write(Uint8List.fromList(kotBytes));
                                              //         }
                                              //
                                              //
                                              //       }
                                              //
                                              //
                                              //   },
                                              //   text: arabicLanguage?"ينسخ":'COPY',
                                              //   options:  FFButtonOptions(
                                              //     width: 90,
                                              //     height: 40,
                                              //     // color: Colors.green.shade700,
                                              //     // textStyle: FlutterFlowTheme.subtitle2.override(
                                              //     //   fontFamily: 'Overpass',
                                              //     //   fontSize: 15,
                                              //     //   color: Colors.white,
                                              //     //   fontWeight: FontWeight.w800,
                                              //     // ),
                                              //     elevation: 10,
                                              //     borderSide: BorderSide(
                                              //       color: Colors.grey,
                                              //       width: 1,
                                              //     ),
                                              //     borderRadius: 12,
                                              //   ),
                                              // ),
                                              // FFButtonWidget(
                                              //   // onPressed: () async {
                                              //   //   if(paidCash.text!='' || paidBank.text!=''){
                                              //   //     String billDiscount = discount;
                                              //   //     if (!disable) {
                                              //   //       disable = true;
                                              //   //
                                              //   //       DocumentSnapshot tableDoc =
                                              //   //       await FirebaseFirestore
                                              //   //           .instance
                                              //   //           .collection('tables')
                                              //   //           .doc(currentBranchId)
                                              //   //           .collection('tables')
                                              //   //           .doc(selectedTable)
                                              //   //           .get();
                                              //   //       List billItems =
                                              //   //       tableDoc.get('items');
                                              //   //       if (billItems.isNotEmpty) {
                                              //   //         DocumentSnapshot invoiceNoDoc =
                                              //   //         await FirebaseFirestore
                                              //   //             .instance
                                              //   //             .collection('invoiceNo')
                                              //   //             .doc(currentBranchId)
                                              //   //             .get();
                                              //   //         FirebaseFirestore.instance
                                              //   //             .collection('invoiceNo')
                                              //   //             .doc(currentBranchId)
                                              //   //             .update({
                                              //   //           'sales':
                                              //   //           FieldValue.increment(1),
                                              //   //           'token':
                                              //   //           FieldValue.increment(1)
                                              //   //         });
                                              //   //         int invoiceNo =
                                              //   //         invoiceNoDoc.get('sales');
                                              //   //         int token =
                                              //   //         invoiceNoDoc.get('token');
                                              //   //         invoiceNo++;
                                              //   //         token++;
                                              //   //         // if(!kIsWeb) {
                                              //   //         //   // connected == true
                                              //   //         //   //     ? _print()
                                              //   //         //   //     : const ScaffoldMessenger(
                                              //   //         //   //     child: Text(
                                              //   //         //   //         "Printer not Connected"));
                                              //   //         // }
                                              //   //         // else{
                                              //   //         //   printFunction(invoiceNo,double.tryParse(
                                              //   //         //       discount) ?? 0);
                                              //   //         // }
                                              //   //         List<String> ingredientIds=[];
                                              //   //         for(var a in billItems){
                                              //   //           for(var b in a['ingredients']){
                                              //   //             ingredientIds.add(b['ingredientId']);
                                              //   //           }
                                              //   //           for(var b in a['variants']){
                                              //   //             for(var c in b['ingredients']){
                                              //   //               ingredientIds.add(c['ingredientId']);
                                              //   //             }
                                              //   //
                                              //   //           }
                                              //   //         }
                                              //   //         await FirebaseFirestore.instance
                                              //   //             .collection('sales')
                                              //   //             .doc(currentBranchId)
                                              //   //             .collection('sales')
                                              //   //             .doc(invoiceNo.toString())
                                              //   //             .set({
                                              //   //           'salesDate': DateTime.now(),
                                              //   //           'invoiceNo': invoiceNo,
                                              //   //           'cash': cash,
                                              //   //           'token': token,
                                              //   //           'currentUserId':currentUserId,
                                              //   //           'currentBranchId':currentBranchId,
                                              //   //           'currentBranchPhNo': currentBranchPhNo,
                                              //   //           'currentBranchAddress': currentBranchAddress,
                                              //   //           'currentBranchArabic': currentBranchArabic,
                                              //   //           'deliveryCharge':double.tryParse(delivery) ?? 0,
                                              //   //           'table': selectedTable,
                                              //   //           'billItems': billItems,
                                              //   //           'discount': double.tryParse(discount) ?? 0,
                                              //   //           'totalAmount': totalAmount*100/(100+gst),
                                              //   //           'tax': totalAmount * gst / (100+gst),
                                              //   //           'grandTotal': totalAmount  - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0),
                                              //   //
                                              //   //
                                              //   //           'paidCash':double.tryParse(paidCash.text)??0,
                                              //   //           'paidBank':double.tryParse(paidBank.text)??0,
                                              //   //           'cash': paidCash.text==''|| paidCash.text=='0.0'?false:true ,
                                              //   //           'bank': paidBank.text==''||paidBank.text=='0.0'?false:true,
                                              //   //           'balance':balance,
                                              //   //           "ingredientIds":ingredientIds
                                              //   //         });
                                              //   //
                                              //   //         paidCash.text='';
                                              //   //         paidCash.text='';
                                              //   //
                                              //   //
                                              //   //         await FirebaseFirestore.instance
                                              //   //             .collection('tables')
                                              //   //             .doc(currentBranchId)
                                              //   //             .collection('tables')
                                              //   //             .doc(selectedTable)
                                              //   //             .update({'items': []});
                                              //   //         setState(() {
                                              //   //           discountController.text =
                                              //   //           '0';
                                              //   //           discount = '0.00';
                                              //   //           deliveryCharge.text =
                                              //   //           '0';
                                              //   //           delivery = '0.00';
                                              //   //           qty=0;
                                              //   //           paidCash.text='';
                                              //   //           paidBank.text='';
                                              //   //           totalAmount=0;
                                              //   //           balance=0;
                                              //   //           cashPaid=0;
                                              //   //           bankPaid=0;
                                              //   //           disable = false;
                                              //   //           enable=false;
                                              //   //         });
                                              //   //       }
                                              //   //       showUploadMessage(context, 'Saved Successfully');
                                              //   //
                                              //   //
                                              //   //
                                              //   //     }
                                              //   //   }else{
                                              //   //     showUploadMessage(context, 'PLEASE SELECT PAYMET METHOD');
                                              //   //   }
                                              //   //
                                              //   //
                                              //   //
                                              //   // },
                                              //   onPressed: () async {
                                              //     print("tapped");
                                              //     print(approve);
                                              //     if(paidCash.text!='' || amex.text!=''||visa.text!=''||master.text!=''||mada.text!=''){
                                              //
                                              //
                                              //       print("tapped2");
                                              //       print(approve);
                                              //      // if(currentWaiter!=null){
                                              //        if (!disable) {
                                              //          double  netTotal= dinnerCertificate? 0.00:totalAmount  - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0);
                                              //          bankPaid=(amexPaid+madaPaid+visaPaid+masterPaid??0);
                                              //          print("bankPaid============================");
                                              //          print(bankPaid);
                                              //          // List itemsList=items;
                                              //          for(var b in items){
                                              //            if(b["variantName"]!=''){
                                              //              b['pdtname']="${b["pdtname"]} ${b["variantName"]??''}";
                                              //              b['arabicName']="${b["pdtname"]} ${b["variantNameArabic"]??''}";
                                              //            }
                                              //          }
                                              //          String billDiscount = discount;
                                              //          disable = true;
                                              //          print("tapped3");
                                              //          print(approve);
                                              //          DocumentSnapshot tableDoc =
                                              //          await FirebaseFirestore
                                              //              .instance
                                              //              .collection('tables')
                                              //              .doc(currentBranchId)
                                              //              .collection('tables')
                                              //              .doc(selectedTable)
                                              //              .get();
                                              //          List billItems =
                                              //          tableDoc.get('items');
                                              //          if (billItems.isNotEmpty) {
                                              //            DocumentSnapshot invoiceNoDoc =
                                              //            await FirebaseFirestore
                                              //                .instance
                                              //                .collection('invoiceNo')
                                              //                .doc(currentBranchId)
                                              //                .get();
                                              //            FirebaseFirestore.instance
                                              //                .collection('invoiceNo')
                                              //                .doc(currentBranchId)
                                              //                .update({
                                              //              'sales':
                                              //              FieldValue.increment(1),
                                              //              'token':
                                              //              FieldValue.increment(1)
                                              //            });
                                              //            int invoiceNo =
                                              //            invoiceNoDoc.get('sales');
                                              //            int token =
                                              //            invoiceNoDoc.get('token');
                                              //            invoiceNo++;
                                              //            token++;
                                              //            print("tapped4");
                                              //            print(approve);
                                              //
                                              //            List<String> ingredientIds = [];
                                              //            for (var a in items) {
                                              //              for (var b in a['ingredients'] ?? []) {
                                              //                ingredientIds.add(b['ingredientId']);
                                              //              }
                                              //            }
                                              //            print("tapped5");
                                              //            print(approve);
                                              //            await FirebaseFirestore.instance
                                              //                .collection('sales')
                                              //                .doc(currentBranchId)
                                              //                .collection('sales')
                                              //                .doc(invoiceNo.toString())
                                              //                .set({
                                              //              'currentUserId': currentUserId,
                                              //              'salesDate': DateTime.now(),
                                              //              'invoiceNo': invoiceNo,
                                              //              'token': token,
                                              //              'currentBranchId': currentBranchId,
                                              //              'currentBranchPhNo': currentBranchPhNo,
                                              //              'currentBranchAddress': currentBranchAddress,
                                              //              'currentBranchArabic': currentBranchAddressArabic,
                                              //              'deliveryCharge': double.tryParse(delivery) ?? 0,
                                              //              'table': selectedTable,
                                              //              'billItems': items,
                                              //              'discount': double.tryParse(discount) ?? 0,
                                              //              'totalAmount': totalAmount * 100 / (100 + gst),
                                              //              'tax': totalAmount * gst / (100 + gst),
                                              //              'grandTotal': totalAmount - (double.tryParse(discount) ?? 0) + (double.tryParse(delivery) ?? 0),
                                              //              'paidCash': double.tryParse(paidCash.text) ?? 0,
                                              //              'paidBank': approve?0:bankPaid ?? 0,
                                              //              'cash': approve?false:paidCash.text==''|| paidCash.text=='0.0'||double.tryParse(paidCash.text)!<=0||paidCash.text==null?false:true ,
                                              //              'bank': approve||bankPaid<=0?false:true,
                                              //              'balance': balance,
                                              //              "ingredientIds": ingredientIds,
                                              //              'creditSale':approve?true:false,
                                              //              "creditName":approve?userMap["name"]:""??'',
                                              //              "creditNumber":approve?userMap["phone"]:""??'',
                                              //              "AMEX":amex.text!="0"&&amex.text!="0.0"&&amex.text!=""&&amex.text!=null?true:false,
                                              //              "VISA":visa.text!="0"&&visa.text!="0.0"&&visa.text!=""&&visa.text!=null?true:false,
                                              //              "MASTER":master.text!="0"&&master.text!="0.0"&&master.text!=""&&master.text!=null?true:false,
                                              //              "MADA":mada.text!="0"&&mada.text!="0.0"&&mada.text!=""&&mada.text!=null?true:false,
                                              //              "dinnerCertificate":dinnerCertificate?true:false,
                                              //              "amexAmount":double.tryParse(amex.text)??0,
                                              //              "madaAmount":double.tryParse(mada.text)??0,
                                              //              "visaAmount":double.tryParse(visa.text)??0,
                                              //              "masterAmount":double.tryParse(master.text)??0,
                                              //              "cancel":false,
                                              //              "orderType":dropdownvalue,
                                              //              // "waiterName":currentWaiter
                                              //
                                              //            });
                                              //            print("tapped6");
                                              //            print(approve);
                                              //            paidCash.text='0';
                                              //            paidCash.text='0';
                                              //
                                              //
                                              //            await FirebaseFirestore.instance
                                              //                .collection('tables')
                                              //                .doc(currentBranchId)
                                              //                .collection('tables')
                                              //                .doc(selectedTable)
                                              //                .update({'items': []});
                                              //            setState(() {
                                              //              creditMap={};
                                              //              userMap={};
                                              //              discountController.text =
                                              //              '0';
                                              //              discount = '0.00';
                                              //              deliveryCharge.text =
                                              //              '0';
                                              //              delivery = '0.00';
                                              //              qty=0;
                                              //              paidCash.text='0';
                                              //              paidBank.text='0';
                                              //              totalAmount=0;
                                              //              balance=0;
                                              //              cashPaid=0;
                                              //              bankPaid=0;
                                              //              disable = false;
                                              //              enable=false;
                                              //              approve=false;
                                              //              mobileNo.text='';
                                              //              mada.text="0.0";
                                              //              master.text="0.0";
                                              //              visa.text="0.0";
                                              //              amex.text="0.0";
                                              //              madaPaid=0;
                                              //              visaPaid=0;
                                              //              masterPaid=0;
                                              //              amexPaid=0;
                                              //              print("tapped7");
                                              //              print(approve);
                                              //              dropdownvalue="Take Away";
                                              //            });
                                              //            print("tapped8");
                                              //            print(approve);
                                              //          }
                                              //          showUploadMessage(context, 'Saved Successfully');
                                              //
                                              //
                                              //
                                              //        }
                                              //      // }
                                              //      // else{
                                              //      //   showUploadMessage(context, 'PLEASE CHOOSE WAITER NAME');
                                              //      // }
                                              //
                                              //
                                              //     }else{
                                              //       showUploadMessage(context, 'PLEASE SELECT PAYMET METHOD');
                                              //       print("tapped9");
                                              //       print(approve);
                                              //     }
                                              //
                                              //
                                              //
                                              //   },
                                              //   text:arabicLanguage? 'يحفظ':'SAVE',
                                              //   options:  FFButtonOptions(
                                              //     width: 90,
                                              //     height: 40,
                                              //     // color: Colors.green.shade700,
                                              //     // textStyle: FlutterFlowTheme.subtitle2.override(
                                              //     //   fontFamily: 'Overpass',
                                              //     //   fontSize: 15,
                                              //     //   color: Colors.white,
                                              //     //   fontWeight: FontWeight.w800,
                                              //     // ),
                                              //     elevation: 10,
                                              //     borderSide: BorderSide(
                                              //       color: Colors.grey,
                                              //       width: 1,
                                              //     ),
                                              //     borderRadius: 12,
                                              //   ),
                                              // ),
                                              ElevatedButton(
                                                  style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.blue)),
                                                  onPressed: () async {
                                                    // print('paidCash.text');
                                                    // print(paidCash.text);
                                                    // print(paidBank.text);


                                                    // if(paidBank.text!=''  || paidCash.text!=''){
                                                    if(blue){



                                                      // print('paidCash.text');
                                                      // print(paidCash.text);

                                                      await showDialog(
                                                          barrierDismissible: false,
                                                          context: context,
                                                          builder: (BuildContext context) {

                                                            return mytest(items:printCopy,
                                                                token: copyToken,
                                                                salesDate: copyDate,
                                                                delivery: copyDelivery,
                                                                customer: 'Walking Customer',
                                                                discountPrice: copyDiscount,
                                                                invoiceNo: copyInvoice.toString(),
                                                                cashPaid:double.tryParse(paidCash.text)??0,
                                                                bankPaid:double.tryParse(paidBank.text)??0,
                                                                balance:balance??0
                                                            );
                                                          });
                                                      setState(() {
                                                        paidCash.text='0';
                                                        paidCash.text='0';
                                                        enable=false;
                                                        approve=false;
                                                        mobileNo.text='';
                                                      });


                                                    }else{

                                                      flutterUsbPrinter.write(Uint8List.fromList(bytes));
                                                      bytes=[];
                                                      if(lastCut==true){
                                                        flutterUsbPrinter.write(Uint8List.fromList(kotBytes));
                                                      }


                                                    }


                                                  }, child: Text(arabicLanguage?"ينسخ":'COPY',style: TextStyle(color: Colors.white),)),
                                              ElevatedButton(
                                                style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.blue,)),
                                                onPressed: () async {
                                                print("tapped");
                                                print(approve);
                                                if(paidCash.text!='' || amex.text!=''||visa.text!=''||master.text!=''||mada.text!=''){


                                                  print("tapped2");
                                                  print(approve);
                                                  // if(currentWaiter!=null){
                                                  if (!disable) {
                                                    double  netTotal= dinnerCertificate? 0.00:totalAmount  - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0);
                                                    bankPaid=(amexPaid+madaPaid+visaPaid+masterPaid??0);
                                                    print("bankPaid============================");
                                                    print(bankPaid);
                                                    // List itemsList=items;
                                                    for(var b in items){
                                                      if(b["variantName"]!=''){
                                                        b['pdtname']="${b["pdtname"]} ${b["variantName"]??''}";
                                                        b['arabicName']="${b["pdtname"]} ${b["variantNameArabic"]??''}";
                                                      }
                                                    }
                                                    String billDiscount = discount;
                                                    disable = true;
                                                    print("tapped3");
                                                    print(approve);
                                                    DocumentSnapshot tableDoc =
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('tables')
                                                        .doc(currentBranchId)
                                                        .collection('tables')
                                                        .doc(selectedTable)
                                                        .get();
                                                    List billItems =
                                                    tableDoc.get('items');
                                                    if (billItems.isNotEmpty) {
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
                                                      print("tapped4");
                                                      print(approve);

                                                      List<String> ingredientIds = [];
                                                      for (var a in items) {
                                                        for (var b in a['ingredients'] ?? []) {
                                                          ingredientIds.add(b['ingredientId']);
                                                        }
                                                      }
                                                      print("tapped5");
                                                      print(approve);
                                                      await FirebaseFirestore.instance
                                                          .collection('sales')
                                                          .doc(currentBranchId)
                                                          .collection('sales')
                                                          .doc(invoiceNo.toString())
                                                          .set({
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
                                                        'billItems': items,
                                                        'discount': double.tryParse(discount) ?? 0,
                                                        'totalAmount': totalAmount * 100 / (100 + gst),
                                                        'tax': totalAmount * gst / (100 + gst),
                                                        'grandTotal': totalAmount - (double.tryParse(discount) ?? 0) + (double.tryParse(delivery) ?? 0),
                                                        'paidCash': double.tryParse(paidCash.text) ?? 0,
                                                        'paidBank': approve?0:bankPaid ?? 0,
                                                        'cash': approve?false:paidCash.text==''|| paidCash.text=='0.0'||double.tryParse(paidCash.text)!<=0||paidCash.text==null?false:true ,
                                                        'bank': approve||bankPaid<=0?false:true,
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
                                                        "amexAmount":double.tryParse(amex.text)??0,
                                                        "madaAmount":double.tryParse(mada.text)??0,
                                                        "visaAmount":double.tryParse(visa.text)??0,
                                                        "masterAmount":double.tryParse(master.text)??0,
                                                        "cancel":false,
                                                        "orderType":dropdownvalue,
                                                        // "waiterName":currentWaiter

                                                      });
                                                      print("tapped6");
                                                      print(approve);
                                                      paidCash.text='0';
                                                      paidCash.text='0';


                                                      await FirebaseFirestore.instance
                                                          .collection('tables')
                                                          .doc(currentBranchId)
                                                          .collection('tables')
                                                          .doc(selectedTable)
                                                          .update({'items': []});
                                                      setState(() {
                                                        creditMap={};
                                                        userMap={};
                                                        discountController.text =
                                                        '0';
                                                        discount = '0.00';
                                                        deliveryCharge.text =
                                                        '0';
                                                        delivery = '0.00';
                                                        qty=0;
                                                        paidCash.text='0';
                                                        paidBank.text='0';
                                                        totalAmount=0;
                                                        balance=0;
                                                        cashPaid=0;
                                                        bankPaid=0;
                                                        disable = false;
                                                        enable=false;
                                                        approve=false;
                                                        mobileNo.text='';
                                                        mada.text="0.0";
                                                        master.text="0.0";
                                                        visa.text="0.0";
                                                        amex.text="0.0";
                                                        madaPaid=0;
                                                        visaPaid=0;
                                                        masterPaid=0;
                                                        amexPaid=0;
                                                        print("tapped7");
                                                        print(approve);
                                                        dropdownvalue="Take Away";
                                                      });
                                                      print("tapped8");
                                                      print(approve);
                                                    }
                                                    showUploadMessage(context, 'Saved Successfully');



                                                  }
                                                  // }
                                                  // else{
                                                  //   showUploadMessage(context, 'PLEASE CHOOSE WAITER NAME');
                                                  // }


                                                }else{
                                                  showUploadMessage(context, 'PLEASE SELECT PAYMET METHOD');
                                                  print("tapped9");
                                                  print(approve);
                                                }



                                              }, child: Text(arabicLanguage? 'يحفظ':"SAVE",style: TextStyle(color: Colors.white)))
                                            ],
                                          ),
                                        ),

                                        //Cash and bank
                                        Expanded(
                                          child: Container(
                                            height: MediaQuery.of(context).size.height * 0.15,
                                            width: MediaQuery.of(context).size.width * 0.25,

                                            child: approve==true||dinnerCertificate==true?Center(
                                              child: Text(approve?"CREDIT SALE":"DINNER CERTIFICATE   SALE",
                                                style: TextStyle(color: Colors.brown,

                                                    fontWeight: FontWeight.bold,
                                                    fontSize: fontSize+10),),
                                            ):Column(children: [
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
                                                                 Text(
                                                                  arabicLanguage?' نقدأ:':"CASH :",
                                                                  textAlign: TextAlign.start,
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight.bold),
                                                                ),
                                                                Container(
                                                                  height: 45,
                                                                  child: TextFormField(

                                                                    onTap: () {
                                                                      setItemWidgets(items);
                                                                      double grandTotal=(totalAmount - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0));
                                                                      // print(grandTotal);


                                                                        cashPaid=grandTotal-masterPaid-amexPaid-visaPaid-madaPaid;
                                                                        if(cashPaid<0){
                                                                          cashPaid=0;
                                                                          balance=grandTotal-cashPaid-madaPaid-masterPaid-visaPaid-amexPaid;
                                                                        }

                                                                        paidCash.text=cashPaid.toStringAsFixed(1);


                                                                      setState(() {
                                                                        // keyboard = true;
                                                                      });
                                                                    },
                                                                    onChanged: (value){
                                                                      double grandTotal=(totalAmount - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0));

                                                                      cashPaid=double.tryParse(value)??0;
                                                                      bankPaid=grandTotal-cashPaid??0;
                                                                      if(bankPaid<0){
                                                                        bankPaid=0;
                                                                      }
                                                                      // master.text =(grandTotal-cashPaid-amexPaid-visaPaid-madaPaid).toStringAsFixed(2);
                                                                      // amex.text=(grandTotal-masterPaid-cashPaid-visaPaid-madaPaid).toStringAsFixed(2);
                                                                      // visa.text =(grandTotal-masterPaid-amexPaid-cashPaid-madaPaid).toStringAsFixed(2);
                                                                      // mada.text=(grandTotal-masterPaid-amexPaid-visaPaid-cashPaid).toStringAsFixed(2);

                                                                      paidBank.text=bankPaid.toStringAsFixed(1);
                                                                      balance=grandTotal-cashPaid-madaPaid-masterPaid-visaPaid-amexPaid;
                                                                      setState(() {
                                                                        // keyboard = true;
                                                                      });
                                                                    },
                                                                    controller: paidCash,
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
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(width: 10,),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                               Text(
                                                                arabicLanguage?'مصرف: ':"BANK :",
                                                                textAlign: TextAlign.start,
                                                                style: const TextStyle(
                                                                    fontWeight: FontWeight.bold),
                                                              ),
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
                                                                                                  // Text('AMEX'),
                                                                                                  Container(
                                                                                                    // height: 180,
                                                                                                    height:MediaQuery.of(context).size.height*0.180,
                                                                                                    width:MediaQuery.of(context).size.width*0.070,
                                                                                                    // width: 80,
                                                                                                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/american express.png"),fit: BoxFit.cover),),
                                                                                                  )
                                                                                                ],
                                                                                              )
                                                                                          )
                                                                                      ),
                                                                                      Container(
                                                                                        // height: 50,
                                                                                        // width:200,
                                                                                        height:MediaQuery.of(context).size.height*0.070,
                                                                                        width:MediaQuery.of(context).size.width*0.160,
                                                                                        child: Center(
                                                                                          child: TextFormField(

                                                                                            onTap: () {
                                                                                              setItemWidgets(items);
                                                                                              double grandTotal=(totalAmount - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0));



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
                                                                                              double grandTotal=(totalAmount - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0));
                                                                                              bankPaid=grandTotal-cashPaid??0;

                                                                                              cashPaid=grandTotal-madaPaid-masterPaid-visaPaid-amexPaid;
                                                                                              if(cashPaid<0){
                                                                                                cashPaid=0;
                                                                                              }
                                                                                              paidCash.text=cashPaid.toStringAsFixed(1);
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
                                                                                                  // Text('MADA'),
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
                                                                                              setItemWidgets(items);
                                                                                              double grandTotal=(totalAmount - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0));
                                                                                              // print(grandTotal);


                                                                                              madaPaid=   grandTotal-cashPaid-amexPaid-visaPaid-masterPaid??0;
                                                                                              if(madaPaid<0){
                                                                                                madaPaid=0;

                                                                                              }
                                                                                              mada.text=madaPaid.toStringAsFixed(1);


                                                                                              balance=grandTotal-cashPaid-madaPaid-masterPaid-visaPaid-amexPaid;
                                                                                              setState(() {
                                                                                                // keyboard = true;
                                                                                              }
                                                                                              );
                                                                                            },
                                                                                            onChanged: (value){
                                                                                              // print(value);
                                                                                              madaPaid=double.tryParse(value)??0;
                                                                                              double grandTotal=(totalAmount - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0));
                                                                                              bankPaid=grandTotal-cashPaid??0;

                                                                                              cashPaid=grandTotal-madaPaid-masterPaid-visaPaid-amexPaid;
                                                                                              if(cashPaid<0){
                                                                                                cashPaid=0;
                                                                                              }
                                                                                              paidCash.text=cashPaid.toStringAsFixed(1);
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
                                                                                                  // Text('MASTER'),
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
                                                                                              setItemWidgets(items);
                                                                                              double grandTotal=(totalAmount - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0));
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
                                                                                              double grandTotal=(totalAmount - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0));
                                                                                              bankPaid=grandTotal-cashPaid??0;

                                                                                              cashPaid=grandTotal-madaPaid-masterPaid-visaPaid-amexPaid;
                                                                                              if(cashPaid<0){
                                                                                                cashPaid=0;
                                                                                              }
                                                                                              paidCash.text=cashPaid.toStringAsFixed(1);
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
                                                                                                hintText:'Amount',
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
                                                                                                  // Text('VISA'),
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
                                                                                              setItemWidgets(items);
                                                                                              double grandTotal=(totalAmount - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0));
                                                                                              // print(grandTotal);


                                                                                              visaPaid=   grandTotal-cashPaid-amexPaid-masterPaid-madaPaid??0;
                                                                                              if(visaPaid<0){
                                                                                                visaPaid=0;

                                                                                              }
                                                                                              visa.text=visaPaid.toStringAsFixed(1);


                                                                                              balance=grandTotal-cashPaid-madaPaid-visaPaid-masterPaid-amexPaid;
                                                                                              setState(() {
                                                                                                // keyboard = true;
                                                                                              }
                                                                                              );
                                                                                            },
                                                                                            onChanged: (value){
                                                                                              // print(value);
                                                                                              visaPaid=double.tryParse(value)??0;
                                                                                              double grandTotal=(totalAmount - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0));
                                                                                              bankPaid=grandTotal-cashPaid??0;

                                                                                              cashPaid=grandTotal-madaPaid-masterPaid-visaPaid-amexPaid;
                                                                                              if(visaPaid<0){
                                                                                                visaPaid=0;
                                                                                              }
                                                                                              paidCash.text=cashPaid.toStringAsFixed(1);
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
                                                                                                hintText:'Amount ',
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
                                                              // Container(
                                                              //   height: 45,
                                                              //   // color: Colors.blue,
                                                              //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),
                                                              //     color: Colors.blue,
                                                              //     ),
                                                              //   child:  DropdownButton(
                                                              //     borderRadius: BorderRadius.circular(10),
                                                              //     alignment: AlignmentDirectional.center,
                                                              //     underline: Column(),
                                                              //     dropdownColor: Colors.green,
                                                              //     iconEnabledColor: Colors.blue,
                                                              //     style:  const TextStyle(
                                                              //         color: Colors.white,
                                                              //         fontSize: 18,
                                                              //         fontWeight: FontWeight.w500
                                                              //     ),
                                                              //     value: bankValue,
                                                              //     icon: const Padding(
                                                              //       padding: EdgeInsets.only(right: 5),
                                                              //       child: Icon(
                                                              //         Icons.account_balance,
                                                              //           color: Colors.white,
                                                              //
                                                              //       ),
                                                              //     ),
                                                              //     items: bankOptions.map((String items) {
                                                              //       return DropdownMenuItem(
                                                              //         value: items,
                                                              //         // child: Text(
                                                              //         //   items,
                                                              //         // ),
                                                              //         child: Row(
                                                              //           children: [
                                                              //             Text(items,),
                                                              //             // Container(
                                                              //             //   height: 45,
                                                              //             //   child: TextFormField(
                                                              //             //
                                                              //             //     onTap: () {
                                                              //             //
                                                              //             //     },
                                                              //             //     onChanged: (value){
                                                              //             //       double grandTotal=(totalAmount - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0));
                                                              //             //
                                                              //             //       cashPaid=double.tryParse(value)??0;
                                                              //             //       bankPaid=grandTotal-cashPaid??0;
                                                              //             //       if(bankPaid<0){
                                                              //             //         bankPaid=0;
                                                              //             //       }
                                                              //             //       paidBank.text=bankPaid.toStringAsFixed(1);
                                                              //             //       balance=grandTotal-cashPaid-bankPaid;
                                                              //             //       setState(() {
                                                              //             //         // keyboard = true;
                                                              //             //       });
                                                              //             //     },
                                                              //             //     controller: paidCash,
                                                              //             //     keyboardType:
                                                              //             //     TextInputType.number,
                                                              //             //     decoration: InputDecoration(
                                                              //             //       // labelText: 'DISCOUNT',
                                                              //             //         hoverColor: default_color,
                                                              //             //         hintText:arabicLanguage?'نقدأ':"Cash ",
                                                              //             //         border:
                                                              //             //         OutlineInputBorder(
                                                              //             //           borderRadius:
                                                              //             //           BorderRadius
                                                              //             //               .circular(5.0),
                                                              //             //         ),
                                                              //             //         focusedBorder:
                                                              //             //         OutlineInputBorder(
                                                              //             //           borderSide: BorderSide(
                                                              //             //               color: Colors
                                                              //             //                   .pink.shade900,
                                                              //             //               width: 1.0),
                                                              //             //         ),
                                                              //             //         prefixIcon: const Padding(
                                                              //             //           padding: EdgeInsets.all(0.0),
                                                              //             //           child: Icon(
                                                              //             //             Icons.money_outlined,
                                                              //             //             color: Colors.grey,
                                                              //             //           ), // icon is 48px widget.
                                                              //             //         ),
                                                              //             //         contentPadding: EdgeInsets.all(5)
                                                              //             //     ),
                                                              //             //   ),
                                                              //             // ),
                                                              //
                                                              //           ],
                                                              //         ),
                                                              //       );
                                                              //     }).toList(),
                                                              //     onChanged: (String newValue) {
                                                              //       setItemWidgets(items);
                                                              //
                                                              //
                                                              //       double grandTotal=(totalAmount - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0));
                                                              //       bankPaid=(grandTotal-cashPaid)??0;
                                                              //       cashPaid=grandTotal-bankPaid;
                                                              //       if(cashPaid<0){
                                                              //         cashPaid=0;
                                                              //       }
                                                              //       paidCash.text=cashPaid.toStringAsFixed(1);
                                                              //       // print(bankPaid);
                                                              //       balance=grandTotal-cashPaid-bankPaid;
                                                              //       setState(() {
                                                              //         // keyboard = true;
                                                              //       });
                                                              //
                                                              //
                                                              //
                                                              //
                                                              //
                                                              //
                                                              //       bankValue = newValue;
                                                              //       // print(dropdownvalue);
                                                              //       // dropdownvalue=="Drive-Thru" && (deliveryCharge.text.isEmpty || deliveryCharge.text=="0")? delivery=DelCharge.toStringAsFixed(2): delivery=deliveryCharge.text;
                                                              //       if(mounted){
                                                              //         setState(() {
                                                              //           // if(dropdownvalue=="Drive-Thru"){
                                                              //           //   deliveryCharge.text=DelCharge.toString();
                                                              //           // }
                                                              //         });
                                                              //       }
                                                              //     },
                                                              //   )
                                                              //   // TextFormField(
                                                              //   //   onTap: () {
                                                              //   //
                                                              //   //     setItemWidgets(items);
                                                              //   //     double grandTotal=(totalAmount - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0));
                                                              //   //     // print(grandTotal);
                                                              //   //
                                                              //   //
                                                              //   //     bankPaid=grandTotal-cashPaid;
                                                              //   //     if(bankPaid<0){
                                                              //   //       bankPaid=0;
                                                              //   //
                                                              //   //     }
                                                              //   //     paidBank.text=bankPaid.toStringAsFixed(1);
                                                              //   //
                                                              //   //
                                                              //   //     balance=grandTotal-cashPaid-bankPaid;
                                                              //   //     setState(() {
                                                              //   //       // keyboard = true;
                                                              //   //     });
                                                              //   //   },
                                                              //   //   onChanged: (value){
                                                              //   //     // print(value);
                                                              //   //     bankPaid=double.tryParse(value)??0;
                                                              //   //     double grandTotal=(totalAmount - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0));
                                                              //   //     cashPaid=grandTotal-bankPaid;
                                                              //   //     if(cashPaid<0){
                                                              //   //       cashPaid=0;
                                                              //   //     }
                                                              //   //     paidCash.text=cashPaid.toStringAsFixed(1);
                                                              //   //     // print(bankPaid);
                                                              //   //     balance=grandTotal-cashPaid-bankPaid;
                                                              //   //     setState(() {
                                                              //   //       // keyboard = true;
                                                              //   //     });
                                                              //   //   },
                                                              //   //   controller: paidBank,
                                                              //   //   keyboardType:
                                                              //   //   TextInputType.number,
                                                              //   //   decoration: InputDecoration(
                                                              //   //     // labelText: 'DISCOUNT',
                                                              //   //       prefixIcon: const Padding(
                                                              //   //         padding: EdgeInsets.all(0.0),
                                                              //   //         child: Icon(
                                                              //   //           Icons.home_repair_service_rounded,
                                                              //   //           color: Colors.grey,
                                                              //   //         ), // icon is 48px widget.
                                                              //   //       ),
                                                              //   //       hoverColor: default_color,
                                                              //   //       hintText:arabicLanguage?'مصرف: ':"Bank :",
                                                              //   //       border:
                                                              //   //       OutlineInputBorder(
                                                              //   //         borderRadius:
                                                              //   //         BorderRadius
                                                              //   //             .circular(5.0),
                                                              //   //       ),
                                                              //   //       focusedBorder:
                                                              //   //       OutlineInputBorder(
                                                              //   //         borderSide: BorderSide(
                                                              //   //             color: Colors
                                                              //   //                 .pink.shade900,
                                                              //   //             width: 1.0),
                                                              //   //       ),
                                                              //   //       contentPadding: EdgeInsets.all(5)
                                                              //   //   ),
                                                              //   // ),
                                                              // ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(width: 10,),


                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                Container(
                                                  height:MediaQuery.of(context).size.height * 0.05,
                                                  child: Center(child: Text(arabicLanguage?'  المتبقي:${arabicNumber.convert(balance.toString())}':'Balance :${balance.toStringAsFixed(2)} ',style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                    fontSize: 17
                                                  ),)),
                                                )

                                              ],),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            setState(() {
                                              discountController.text = '0';
                                              discount = '0';
                                              deliveryCharge.text = '0';
                                              paidBank.text = '0';
                                              paidCash.text = '0';
                                              balance = 0;
                                              delivery = '0';
                                              qty = 0;
                                              totalAmount=0;
                                              balance=0;
                                              cashPaid=0;
                                              bankPaid=0;
                                              enable=false;
                                              approve=false;
                                              mobileNo.text = '';
                                              dinnerCertificate=false;
                                              mada.text="0.0";
                                              master.text="0.0";
                                              visa.text="0.0";
                                              amex.text="0.0";
                                              madaPaid=0;
                                              visaPaid=0;
                                              masterPaid=0;
                                              amexPaid=0;
                                              balance=0;
                                              currentWaiter=null;

                                            });
                                            await FirebaseFirestore.instance
                                                .collection('tables')
                                            .doc(currentBranchId)
                                                .collection('tables')
                                                .doc(selectedTable)
                                                .update({'items': []});
                                            setState(() {

                                            });

                                          },
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.15,
                                            width: 120,
                                            decoration: const BoxDecoration(
                                                color: Colors.red),
                                           child: Column(
                                               mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children:  [
                                                Icon(
                                                  Icons.delete,
                                                  size: 35,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  arabicLanguage? "يلغي":"CANCEL",
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        enable?InkWell(
                                          onLongPress: (){
                                            disable=false;
                                            showUploadMessage(context, "print queue cleared successfully");


                                          },
                                          onTap: () async {

                                            log("start");


                                             if(paidCash.text!='' || amex.text!=''||visa.text!=''||master.text!=''||mada.text!=''){

                                               for(var b in items){
                                                 if(b["variantName"]!=''){
                                                   b['pdtname']="${b["pdtname"]} ${b["variantName"]??''}";
                                                   b['arabicName']="${b["arabicName"]} ${b["variantNameArabic"]??''}";
                                                 }
                                               }
                                              // if(currentWaiter!=null){
                                                if (!disable) {
                                                  // List itemsList=items;

                                                  disable = true;
                                                  String billDiscount = discount;
                                                   try {

                                                    print(DateTime.now());
                                                    double  netTotal= dinnerCertificate? 0.00:totalAmount  - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0);

                                                    print("*************************======================");
                                                    print(double.tryParse(paidCash.text));
                                                    print(amexPaid);
                                                    print(madaPaid);
                                                    print(visaPaid);
                                                    print(masterPaid);

                                                    bankPaid=(amexPaid+madaPaid+visaPaid+masterPaid??0);
                                                    print("bankPaid============================");
                                                    print(bankPaid);
                                                    // balance=totalAmount-(bankPaid??0+(double.tryParse(paidCash.text??0)));
                                                    if (items.isNotEmpty) {
                                                      DocumentSnapshot invoiceNoDoc =
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection('invoiceNo')
                                                          .doc(currentBranchId)
                                                          .get();


                                                      int invoiceNo = invoiceNoDoc.get('sales');
                                                      int token = invoiceNoDoc.get('token');
                                                      invoiceNo++;
                                                      token++;



                                                      List<String> ingredientIds = [];
                                                      for (var a in items) {
                                                        for (var b in a['ingredients'] ?? []) {
                                                          ingredientIds.add(b['ingredientId']);
                                                        }
                                                      }


                                                      if (blue) {
                                                        showDialog(
                                                            barrierDismissible: false,
                                                            context: context,
                                                            builder:
                                                                (BuildContext context) {
                                                              items = items;
                                                              printCopy = items;
                                                              copyToken = token;
                                                              copyInvoice = invoiceNo;
                                                              copyCustomer =
                                                              'Walking Customer';
                                                              copyDate =
                                                                  DateTime.now();
                                                              copyDelivery =
                                                                  double.tryParse(
                                                                      discount) ?? 0;
                                                              copyDiscount =
                                                                  double.tryParse(
                                                                      discount)!;
                                                              return mytest(
                                                                  salesDate: DateTime
                                                                      .now(),
                                                                  items: items,
                                                                  token: token,
                                                                  delivery: double
                                                                      .tryParse(
                                                                      discount),
                                                                  customer: 'Walking Customer',
                                                                  discountPrice: double
                                                                      .tryParse(
                                                                      discount),
                                                                  invoiceNo: invoiceNo
                                                                      .toString(),
                                                                  selectedTable: selectedTable,
                                                                  cashPaid: double
                                                                      .tryParse(
                                                                      paidCash
                                                                          .text) ?? 0,
                                                                  bankPaid: double
                                                                      .tryParse(
                                                                      paidBank
                                                                          .text) ?? 0,
                                                                  balance: balance ??
                                                                      0
                                                              );
                                                            });
                                                      } else {
                                                        print(DateTime.now());

                                                        print("bankPaid---------------------------------------");
                                                        print(bankPaid);
                                                        abc(
                                                            invoiceNo,
                                                            double.tryParse(discountController.text)??0,
                                                            items,
                                                            token,
                                                            selectedTable,
                                                            double.tryParse(deliveryCharge.text) ?? 0,
                                                            double.tryParse(paidCash.text) ?? 0,
                                                            bankPaid ?? 0,
                                                            balance ?? 0,
                                                            netTotal??0,
                                                             dropdownvalue!
                                                          // currentWaiter
                                                        );
                                                      }
                                                      print(DateTime.now());
                                                      ingredientsUpdate(items);
                                                      FirebaseFirestore.instance
                                                          .collection('sales')
                                                          .doc(currentBranchId)
                                                          .collection('sales')
                                                          .doc(invoiceNo.toString())
                                                          .set({
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
                                                        'billItems': items,
                                                        'discount': double.tryParse(discount) ?? 0,
                                                        'totalAmount': totalAmount * 100 / (100 + gst),
                                                        'tax': totalAmount * gst / (100 + gst),
                                                        'grandTotal': totalAmount - (double.tryParse(discount) ?? 0) + (double.tryParse(delivery) ?? 0),
                                                        'paidCash': double.tryParse(paidCash.text) ?? 0,
                                                        'paidBank': approve?0:bankPaid ?? 0,
                                                        'cash': approve?false:paidCash.text==''|| paidCash.text=='0.0'||double.tryParse(paidCash.text)!<=0||paidCash.text==null?false:true ,
                                                        'bank': approve||bankPaid<=0?false:true,
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
                                                        "amexAmount":double.tryParse(amex.text)??0,
                                                        "madaAmount":double.tryParse(mada.text)??0,
                                                        "visaAmount":double.tryParse(visa.text)??0,
                                                        "masterAmount":double.tryParse(master.text)??0,
                                                        "cancel":false,
                                                        "orderType":dropdownvalue,
                                                        // "waiterName":currentWaiter

                                                      });


                                                      FirebaseFirestore.instance
                                                          .collection('invoiceNo')
                                                          .doc(currentBranchId)
                                                          .update({
                                                        'sales':
                                                        FieldValue.increment(1),
                                                        'token':
                                                        FieldValue.increment(1)
                                                      });
                                                      FirebaseFirestore.instance
                                                          .collection('tables')
                                                          .doc(currentBranchId)
                                                          .collection('tables')
                                                          .doc(selectedTable)
                                                          .update({'items': []});
                                                      setState(() {
                                                        discountController.text = '0';
                                                        deliveryCharge.text = '0';
                                                        enable = false;
                                                        mobileNo.text = '';

                                                        qty = 0;
                                                      }


                                                      );
                                                    }


                                                    discount = '0.00';
                                                    delivery = '0.00';
                                                    disable = false;
                                                    paidCash.text = '0';
                                                    paidBank.text = '0';
                                                    totalAmount = 0;
                                                    balance = 0;
                                                    cashPaid = 0;
                                                    bankPaid = 0;
                                                    dropdownvalue = arabicLanguage ? "تناول الطعام في" : "Take Away";
                                                    bankValue = arabicLanguage ? "تناول الطعام في" : "Select";
                                                    dinnerCertificate=false;
                                                    mada.text="0.0";
                                                    master.text="0.0";
                                                    visa.text="0.0";
                                                    amex.text="0.0";
                                                    madaPaid=0;
                                                    visaPaid=0;
                                                    masterPaid=0;
                                                    amexPaid=0;
                                                    currentWaiter=null;
                                                    enable = false;


                                                  }
                                                  catch(e){
                                                    disable=false;
                                                    showUploadMessage(context, "Some Technical Errors Occured");
                                                  }

                                                }
                                                else{
                                                  //my change
                                                  disable=false;

                                                  showUploadMessage(context, "another print already in queue");
                                                }
                                              // }
                                              // else{
                                              //   showUploadMessage(context, 'PLEASE CHOOSE WAITER NAME');
                                              // }

                                            }
                                            else{
                                              disable = false;
                                              showUploadMessage(context, 'PLEASE SELECT THE PAYMENT METHOD');
                                            }
                                            approve=false;

                                          },
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.15,
                                            width: 120,
                                            decoration: BoxDecoration(
                                              color: Colors.green.shade700,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.print,
                                                  size: 35,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  arabicLanguage?'مطبعة':"PRINT",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                        ):
                                        InkWell(
                                          onLongPress: (){
                                            disable=false;
                                            enable=true;
                                            showUploadMessage(context, "print queue cleared successfully");
                                          },
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.15,
                                            width: 120,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade400,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children:   [
                                                const Icon(
                                                  Icons.print,
                                                  size: 25,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  arabicLanguage?'مطبعة':"PRINT",
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

            ],
          ),
        ));
  }

  List<Widget> _buildList(List<Map<String, dynamic>> devices) {
    return devices
        .map((device) => ListTile(
      onTap: () {

        _connect(int.parse(device['vendorId']),
            int.parse(device['productId']));
      },
      leading: const Icon(Icons.usb),
      title: Text(device['manufacturer'] + " " + device['productName']),
      subtitle: Text(device['vendorId'] + " " + device['productId']),
    ))
        .toList();
  }
}

