
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:awafi_pos/modals/user.dart' as modal;
import 'package:awafi_pos/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

import 'dart:io' show Platform;


import '../features/auth/screen/login.dart';

class UserService{
  FirebaseAuth _auth= FirebaseAuth.instance;
  FirebaseFirestore _firestore  = FirebaseFirestore.instance;

  final googleSignIn = GoogleSignIn();

  UserService(){
    initializeFirebaseApp();
  }

  void initializeFirebaseApp() async{


      await Firebase.initializeApp();
      // _auth = FirebaseAuth.instance;
      // _firestore = FirebaseFirestore.instance;
      // _storage = new FlutterSecureStorage();

  }

  int? statusCode;
  String msg="unable to Login!!please try again";



  Future<void> logOut(context) async{

    await _auth.signOut();
    await googleSignIn.signOut();
    currentUserModel=null;
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Login()
      ),

    );
  }

  // Future<bool> login(userValues) async{
  //   String email = userValues['email'];
  //   String password = userValues['password'];
  //
  //   await _auth.signInWithEmailAndPassword(email: email, password: password).then((dynamic user) async{
  //     try {
  //       final User? currentUser = _auth.currentUser;
  //       // FirebaseMessaging.instance.subscribeToTopic("admin-app");
  //       DocumentSnapshot userRef = await FirebaseFirestore.instance.collection(
  //           'users').doc(currentUser!.uid).get();
  //       if (userRef.exists) {
  //         currentUserModel = modal.User.fromDocument(userRef);
  //         if (Platform.isAndroid) {
  //           String? token = await FirebaseMessaging.instance.getToken();
  //           await FirebaseFirestore.instance.collection('users').doc(
  //               currentUser!.uid).update({
  //             'token': FieldValue.arrayUnion([token])
  //           });
  //         }
  //         return true;
  //       }
  //       return false;
  //     }catch(e){
  //       print(e.toString());
  //     }
  //
  //   });
  //   return false;
  // }

  Future<String> getUserId() async{ try {
    // var token = await _storage.read(key: 'idToken');
    // var uid = validateToken(token);
    // if(uid==null){
    //   return currentUserModel.id;
    // }
    //
    // return uid;
    return currentUserModel!.id;
  }
  catch(exception){
    return currentUserModel!.id;
  }
  }

  Future<void> signup(userValues,context) async{

    String email = userValues['email'];
    String password = userValues['password'];
    int exist=0;
    QuerySnapshot userRef = await _firestore.collection('users').where('email',isEqualTo: email).get();
    QuerySnapshot userRef1 = await _firestore.collection('users').where('mobileNumber',isEqualTo: userValues['mobileNumber']).get();
     exist=userRef.docs.length+userRef1.docs.length;
     if(exist==0) {

       await _auth.createUserWithEmailAndPassword(
           email: email, password: password).then((dynamic user) {

         String uid =user.user.uid;
         _firestore.collection('users').doc(user.user.uid).set({
           'fullName': userValues['fullName'],
           'mobileNumber': userValues['mobileNumber'],
           'userId': uid,
           'email': userValues['email'],
           'photoUrl': "",
           'wishlist' :[],
           'bag' :[],
           'branchId' :'',
         });


         // _firestore.collection('profileSetting').doc(user.user.uid).set({
         //   'newArrivals': true,
         //   'orderUpdates': true,
         //   'promotions': true,
         //   'saleAlerts': true,
         //   'touchId': true,
         //   'userId': uid,
         // });


         statusCode = 200;
       }).catchError((error) {

         handleAuthErrors(error);
       });
     }
     else{

       return showDialog(
           context: context,
           builder: (BuildContext context) {
             return SizedBox();
           });
       // return showDialog(
       //   context: context,
       //   builder: (ctx) => AlertDialog(
       //     title: Text("Alert Dialog Box"),
       //     content: Text("You have raised a Alert Dialog Box"),
       //     actions: <Widget>[
       //       FlatButton(
       //         onPressed: () {
       //           Navigator.of(ctx).pop();
       //         },
       //         child: Text("okay"),
       //       ),
       //     ],
       //   ),
       // );
     }
  }

  void handleAuthErrors(error){
    String errorCode = error.code;
    switch(errorCode){
      case "ERROR_EMAIL_ALREADY_IN_USE":
        {
          statusCode = 400;
          msg = "Email ID already existed";
        }
        break;
      case "ERROR_WRONG_PASSWORD":
        {
          statusCode = 400;
          msg = "Password is wrong";
        }
    }
  }

  String capitalizeName(String name){
    name = name[0].toUpperCase()+ name.substring(1);
    return name;
  }

  String? userEmail(){
    var user = _auth.currentUser;
    return user!.email;
  }
  String userId(){
    var user = _auth.currentUser;
    return user!.uid;
  }

  Future<List> userWishlist() async{
    String uid = currentUserModel!.id;
    QuerySnapshot userRef = await _firestore.collection('users').where('userId',isEqualTo: uid).get();

    Map? userData = userRef.docs[0].data() as Map?;
    List userWishList = [];

    if(userData!.containsKey('wishlist')){
      for(String item in userData['wishlist']){
        Map<String, dynamic> tempWishList = new Map();
        DocumentSnapshot<Map<String , dynamic>> productRef = await _firestore.collection('products').doc(item).get();
        tempWishList['productName'] = productRef.data()!['name'];
        tempWishList['price'] = productRef.data()!['price'];
        tempWishList['image'] = productRef.data()!['imageId'];
        tempWishList['productId'] = productRef.data()!['productId'];

        userWishList.add(tempWishList);
      }
    }
    return userWishList;
  }

  Future<void> deleteUserWishlistItems(String productId) async{
    String uid = await getUserId();
    QuerySnapshot userRef = await _firestore.collection('users').where('userId',isEqualTo: uid).get();
    String documentId = userRef.docs[0].id;
    Map<String,dynamic>? wishlist = userRef.docs[0].data() as Map<String, dynamic>?;
    wishlist!['wishlist'].remove(productId);

    await _firestore.collection('users').doc(documentId).update({
      'wishlist':wishlist['wishlist']
    });
  }
  Future<void> addWishlistItem(String productId) async{
    bool  userLiked=currentUserModel!.wishlist.contains(productId);
    if(userLiked){
      currentUserModel!.wishlist.remove(productId);
      FirebaseFirestore.instance.collection('users').doc(currentUserModel!.id).update({
        'wishlist' :FieldValue.arrayRemove([productId])
      });



    }
    else{
      currentUserModel!.wishlist.add(productId);
      FirebaseFirestore.instance.collection('users').doc(currentUserModel!.id).update({
        'wishlist' :FieldValue.arrayUnion([productId])
      });



    }

  }







}

