
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'serializers.dart';

part 'users_record.g.dart';

abstract class UsersRecord implements Built<UsersRecord, UsersRecordBuilder> {
  static Serializer<UsersRecord> get serializer => _$usersRecordSerializer;


  String get email;


  String get fullName;


  String get mobileNumber;


  String get photoUrl;


  String get userId;


  BuiltList<String> get wishlist;

  String  get branchId;


  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(UsersRecordBuilder builder) => builder
    ..email = ''
    ..fullName = ''
    ..mobileNumber = ''
    ..photoUrl = ''
    ..userId = ''
    ..branchId=''
    ..wishlist = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(String ref) =>  FirebaseFirestore.instance.collection('users').doc(ref)
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s as DocumentSnapshot<Map<String, dynamic>>))!);

  UsersRecord._();
  factory UsersRecord([void Function(UsersRecordBuilder) updates]) =
      _$UsersRecord;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? fullName,
  String? mobileNumber,
  String? photoUrl,
  String? userId,
  String? branchId,
}) =>
    serializers.serializeWith(
        UsersRecord.serializer,
        UsersRecord((u) => u
          ..email = email!
          ..fullName = fullName!
          ..mobileNumber = mobileNumber!
          ..photoUrl = photoUrl!
          ..userId = userId!
          ..branchId=branchId!
          ..wishlist = null!)) as Map<String,dynamic>;


