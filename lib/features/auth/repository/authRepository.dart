import 'dart:collection';
import 'dart:io';
import 'package:awafi_pos/core/failure.dart';
import 'package:awafi_pos/modals/user.dart' as modal;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/constants/firebaseConstants.dart';
import '../../../core/providers/firebaseProviders.dart';
import '../../../core/type_defs.dart';
import '../../../main.dart';
import '../../../services/userService.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(
      auth: ref.watch(authProvider),
      firebaseFirestore: ref.watch(firestoreProvider));
});

class AuthRepository{
  FirebaseAuth _auth;
  FirebaseFirestore _firebaseFirestore;

  AuthRepository({
  required FirebaseAuth auth,
    required FirebaseFirestore firebaseFirestore
}) : _auth = auth,
     _firebaseFirestore = firebaseFirestore;


  FutureVoid loginUser({required String email, required String password}) async {
    try {
     await _auth.signInWithEmailAndPassword(email: email, password: password)
         .then((dynamic user) async{
          final User? currentUser = _auth.currentUser;
          // FirebaseMessaging.instance.subscribeToTopic("admin-app");
          DocumentSnapshot userRef =
          await _users.doc(currentUser!.uid).get();
          if (userRef.exists) {
            currentUserModel = modal.User.fromDocument(userRef);
            if (Platform.isAndroid) {
              String? token = await FirebaseMessaging.instance.getToken();
              await _users.doc(
                  currentUser!.uid).update({
                'token': FieldValue.arrayUnion([token])
              });

            }
          }
      });
      return right("");
      }on FirebaseException catch(e){
      return left(Failure("Please Check Your Username & Password"));
      }
    catch(e){
    return left(Failure(e.toString()));
    }
    }




  CollectionReference get _users =>
      _firebaseFirestore.collection(FirebaseConstants.authCollection);

}