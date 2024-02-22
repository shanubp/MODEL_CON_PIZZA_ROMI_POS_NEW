//
// import 'dart:async';
//
// import 'index.dart';
// import 'serializers.dart';
// import 'package:built_value/built_value.dart';
//
// part 'shop_users_record.g.dart';
//
// abstract class ShopUsersRecord
//     implements Built<ShopUsersRecord, ShopUsersRecordBuilder> {
//   static Serializer<ShopUsersRecord> get serializer =>
//       _$shopUsersRecordSerializer;
//
//
//   String get email;
//
//
//   @BuiltValueField(wireName: 'display_name')
//   String get displayName;
//
//
//   @BuiltValueField(wireName: 'photo_url')
//   String get photoUrl;
//
//
//   String get uid;
//
//
//   @BuiltValueField(wireName: 'created_time')
//   DateTime get createdTime;
//
//
//   @BuiltValueField(wireName: 'phone_number')
//   String get phoneNumber;
//
//
//   @BuiltValueField(wireName: kDocumentReferenceField)
//   DocumentReference get reference;
//
//   static void _initializeBuilder(ShopUsersRecordBuilder builder) => builder
//     ..email = ''
//     ..displayName = ''
//     ..photoUrl = ''
//     ..uid = ''
//     ..phoneNumber = '';
//
//   static CollectionReference get collection =>
//       FirebaseFirestore.instance.collection('shop_users');
//
//   static Stream<ShopUsersRecord> getDocument(DocumentReference ref) => ref
//       .snapshots()
//       .map((s) => serializers.deserializeWith(serializer, serializedData(s as DocumentSnapshot<Map<String, dynamic>>))!);
//
//   ShopUsersRecord._();
//   factory ShopUsersRecord([void Function(ShopUsersRecordBuilder) updates]) =
//       _$ShopUsersRecord;
//
//   static ShopUsersRecord? getDocumentFromData(
//           Map<String, dynamic> data, DocumentReference reference) =>
//       serializers.deserializeWith(
//           serializer, {...data, kDocumentReferenceField: reference});
// }
//
// Map<String, dynamic> createShopUsersRecordData({
//   String? email,
//   String? displayName,
//   String? photoUrl,
//   String? uid,
//   DateTime? createdTime,
//   String? phoneNumber,
// }) =>
//     serializers.serializeWith(
//         ShopUsersRecord.serializer,
//         ShopUsersRecord((s) => s
//           ..email = email!
//           ..displayName = displayName!
//           ..photoUrl = photoUrl!
//           ..uid = uid!
//           ..createdTime = createdTime!
//           ..phoneNumber = phoneNumber!)) as Map<String,dynamic>;
