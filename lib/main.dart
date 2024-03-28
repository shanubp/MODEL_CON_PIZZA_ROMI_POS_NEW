import 'dart:async';
import 'dart:io';
import 'package:awafi_pos/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_usb_printer/flutter_usb_printer.dart';
import 'package:screenshot/screenshot.dart';
import 'features/home/screen/home_page.dart';
import 'modals/user.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:image/image.dart' as im;
bool dinnerCertificate = false;
bool approve = false;
bool taped = false;
bool arabicLanguage = false;
final default_color = Colors.green[900];
bool offer = false;
int? kotPrinter;
String? currentUserId;
Map PosUserIdToName = {};
Map PosUserIdToArabicName = {};
var posUsers;
var credit;
Map<String, dynamic> creditMap = {};
Map userMap = {};
const logoPath = "assets/pizzaromi512.png";
Map<String, dynamic> printers = {};
ScreenshotController screenshotController = ScreenshotController();
var capturedImage1;
var capturedhead;
var footerImage;
var itemImage;
List<im.Image> imageList = [];
bool blue = false;
ByteData? data;
ByteData? data1;
double qrCode = 0;
double size = 0;
String? heading;
String? topImage;
bool product = false;
String discount = '';
String delivery = '';
List items = [];
final primaryColor = Colors.green[900];
const secondaryColor = Colors.black;
QuerySnapshot? branches;
User? currentUserModel;
bool products = false;
double fontSize = 0;
double printWidth = 0;
String selectedTable = '1';
bool keyboard = false;
bool cash = true;
double totalAmount = 0;
String tableName = '';
double gst = 15;
List<Map<String, dynamic>> devices = [];
FlutterUsbPrinter flutterUsbPrinter = FlutterUsbPrinter();
bool connected = false;
bool pressed = false;
bool lastCut = false;
BlueThermalPrinter? bluetooth;
List<BluetoothDevice> btDevices = [];
BluetoothDevice? device;
int itemCount = 5;
bool display_image = true;
Map<String, dynamic> allCategories = {};
double cashPaid = 0;
double bankPaid = 0;
double balance = 0;

// var capturedImage1;

var capturedImage10;
var capturedImage11;

bool notificationArrived = false;
AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel',
    // 'High importance Notifications',
    'this is a channel test',
    importance: Importance.high,
    playSound: true,
    sound: RawResourceAndroidNotificationSound("wegoaudio"),
    enableVibration: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  notificationArrived = true;
}

Future<void> main() async {
  if (Platform.isAndroid) {
    runZonedGuarded<Future<void>>(() async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
      await FirebaseMessaging.instance.subscribeToTopic('admin-app');
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      // The following lines are the same as previously explained in "Handling uncaught errors"
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

      runApp(const ProviderScope(child: HomePage()));
    },
            (error, stack) =>
            FirebaseCrashlytics.instance.recordError(error, stack));
  } else if (kIsWeb) {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();

    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    runApp(const ProviderScope(child: HomePage()));
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  } else {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const ProviderScope(child: HomePage()));
  }
}




