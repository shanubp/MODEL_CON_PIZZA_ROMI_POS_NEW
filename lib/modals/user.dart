
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String id;
   String photoUrl;
   String phoneNo;
   String displayName;
   List wishlist;
  List bag;
  String branchId;



   User(
      {required this.phoneNo,
      required this.id,
      required this.photoUrl,
      required this.email,
      required this.displayName,
        required this.wishlist,
        required this.bag,
        required this.branchId,
     });

  factory User.fromDocument(DocumentSnapshot document) {


    return User(
      email: document['email'],
      phoneNo: document['mobileNumber']!=null?document['mobileNumber']:'Add Phone',
      photoUrl: document['photoUrl'],
      id: document['userId'],
      displayName: document['fullName'],
      wishlist: document['wishlist'],
      bag: document['bag'],
      branchId:document['branchId'],

    );
  }
}
