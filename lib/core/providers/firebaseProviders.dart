import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreProvider = Provider((ref) {
  return FirebaseFirestore.instance;
});

final authProvider = Provider((ref) {
  return FirebaseAuth.instance;
});