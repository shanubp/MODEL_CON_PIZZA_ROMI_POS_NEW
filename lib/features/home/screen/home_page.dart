import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../../auth/firebase_user_provider.dart';
import '../../../main.dart';
import '../../auth/screen/login.dart';
import 'home_body.dart';

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
int? DelCharge;
class _HomePageState extends State<HomePage> {
  DhaboEcommerceFirebaseUser? initialUser;
  Stream<DhaboEcommerceFirebaseUser>? userStream;
  @override
  void initState() {
    try {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                  android: AndroidNotificationDetails(
                    channel.id,
                    channel.name,
                    // channel.description,
                    color: Colors.blue,
                    playSound: true,
                    icon: '@mipmap/ic_launcher',
                    sound: RawResourceAndroidNotificationSound("wegoaudio"),
                  )));
        }
      });
      FirebaseMessaging.onMessageOpenedApp
          .listen((RemoteMessage message) async {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          setState(() {
            notificationArrived = true;
            // orderData =json.decode(message.data['extradata']);
          });
        } else {
          print('else');
        }
      });
    } catch (exception) {
      print(exception);
    }
    super.initState();
    getPrintImages();
    userStream = dhaboEcommerceFirebaseUserStream()
      ..listen((user) => initialUser ?? setState(() => initialUser = user));
  }

  getPrintImages() async {
    data = await rootBundle.load('assets/as.jpg');
    data1 = await rootBundle.load('assets/as.jpg');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      // home: Dummy(),
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