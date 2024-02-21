



import 'package:cloud_firestore/cloud_firestore.dart';

class AdminUserModel{
  String? email;
  String? displayName;
  String? photoUrl;
  String? uid;
  Timestamp? createdTime;
  bool? verified;
  String? mobileNumber;
  DocumentReference? userId;

  AdminUserModel({
    this.email,
    this.displayName,
    this.photoUrl,
    this.uid,
    this.createdTime,
    this.verified,
    this.mobileNumber,
    this.userId,
  });
  AdminUserModel copyWith({
    String? email,
    String? displayName,
    String? photoUrl,
    String? uid,
    Timestamp? createdTime,
    bool? verified,
    String? mobileNumber,
    DocumentReference? userId,
  }) {
    return AdminUserModel(
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      uid: uid ?? this.uid,
      createdTime: createdTime ?? this.createdTime,
      verified: verified ?? this.verified,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': this.email,
      'displayName': this.displayName,
      'photoUrl': this.photoUrl,
      'uid': this.uid,
      'createdTime': this.createdTime,
      'verified': this.verified,
      'mobileNumber': this.mobileNumber,
      'userId': this.userId,
    };
  }

  factory AdminUserModel.fromMap(Map<String, dynamic> map) {
    return AdminUserModel(
      email: map['email'] ??"",
      displayName: map['displayName'] ??"",
      photoUrl: map['photoUrl'] ??"",
      uid: map['uid'] ??"",
      createdTime: map['createdTime'].toDate(),
      verified: map['verified'] ?? false,
      mobileNumber: map['mobileNumber'] ??"",
      userId: map['userId'] as DocumentReference,
    );
  }

}