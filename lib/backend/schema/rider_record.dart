//
// import 'dart:async';
//
// import 'index.dart';
// import 'serializers.dart';
// import 'package:built_value/built_value.dart';
//
// part 'rider_record.g.dart';
//
// abstract class RiderRecord implements Built<RiderRecord, RiderRecordBuilder> {
//   static Serializer<RiderRecord> get serializer => _$riderRecordSerializer;
//
//
//   String get name;
//
//
//   String get address;
//
//
//   String get vehicleNo;
//
//
//   String get email;
//
//   bool get online;
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
//   double get walletBalance;
//
//   double get earnings;
//
//   double get tips;
//
//   double get paid;
//
//   double get cashInHand;
//
//   Timestamp get walletUpdate;
//
//   Timestamp get earningsUpdate;
//
//   Timestamp get tipsUpdate;
//
//   Timestamp get paidUpdate;
//
//   Timestamp get cashInHandUpdate;
//
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
//   static void _initializeBuilder(RiderRecordBuilder builder) => builder
//     ..name = ''
//     ..address = ''
//     ..vehicleNo = ''
//     ..email = ''
//     ..displayName = ''
//     ..photoUrl = ''
//     ..uid = ''
//     ..online=false
//     ..walletBalance=0.0
//     ..earnings=0.0
//     ..tips=0.0
//     ..paid=0.0
//     ..cashInHand=0.0
//     ..walletUpdate=Timestamp.now()
//     ..earningsUpdate=Timestamp.now()
//     ..tipsUpdate=Timestamp.now()
//     ..paidUpdate=Timestamp.now()
//     ..cashInHandUpdate=Timestamp.now()
//     ..phoneNumber = '';
//
//   static CollectionReference get collection =>
//       FirebaseFirestore.instance.collection('rider');
//
//   static Stream<RiderRecord> getDocument(DocumentReference ref) => ref
//       .snapshots()
//       .map((s) => serializers.deserializeWith(serializer, serializedData(s as DocumentSnapshot<Map<String, dynamic>>))!);
//   RiderRecord._();
//   factory RiderRecord([void Function(RiderRecordBuilder) updates]) =
//       _$RiderRecord;
//
//   static RiderRecord? getDocumentFromData(
//           Map<String, dynamic> data, DocumentReference reference) =>
//       serializers.deserializeWith(
//           serializer, {...data, kDocumentReferenceField: reference});
// }
//
// Map<String, dynamic> createRiderRecordData({
//   String? name,
//   String? address,
//   String? vehicleNo,
//   String? email,
//   String? displayName,
//   String? photoUrl,
//   String? uid,
//   DateTime? createdTime,
//   String? phoneNumber,
//   bool? online,
//   double? walletBalance,
//   double? earnings,
//   double? tips,
//   double? paid,
//   double? cashInHand,
//   Timestamp? walletUpdate,
//   Timestamp? earningsUpdate,
//   Timestamp? tipsUpdate,
//   Timestamp? paidUpdate,
//   Timestamp? cashInHandUpdate,
//
// }) =>
//     serializers.serializeWith(
//         RiderRecord.serializer,
//         RiderRecord((r) => r
//           ..name = name!
//           ..address = address!
//           ..vehicleNo = vehicleNo!
//           ..email = email!
//           ..displayName = displayName!
//           ..photoUrl = photoUrl!
//           ..uid = uid!
//           ..online =online!
//           ..createdTime = createdTime!
//           ..walletBalance=walletBalance!
//           ..earnings=earnings!
//           ..tips=tips!
//           ..paid=paid!
//           ..cashInHand=cashInHand!
//           ..walletUpdate=walletUpdate!
//           ..earningsUpdate=earningsUpdate!
//           ..tipsUpdate=tipsUpdate!
//           ..paidUpdate=paidUpdate!
//           ..cashInHandUpdate=cashInHandUpdate!
//           ..phoneNumber = phoneNumber!)) as Map<String,dynamic>;
