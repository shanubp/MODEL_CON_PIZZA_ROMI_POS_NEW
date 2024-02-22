//
// import 'dart:async';
//
// import 'index.dart';
// import 'serializers.dart';
// import 'package:built_value/built_value.dart';
//
// part 'offer_record.g.dart';
//
// abstract class OfferRecord
//     implements Built<OfferRecord, OfferRecordBuilder> {
//   static Serializer<OfferRecord> get serializer => _$offerRecordSerializer;
//
//
//   Timestamp get expiryDate;
//
//
//   BuiltList<String> get userId;
//
//
//   BuiltList<String> get search;
//
//   String get shopId;
//
//   String get productId;
//
//   String get categoryId;
//
//
//   String get title;
//
//
//   String get code;
//
//
//   BuiltList<String> get used;
//
//
//   String get description;
//
//   bool get global;
//
//   bool get unlimited;
//
//   bool get amount;
//
//   double get value;
//
//
//   @BuiltValueField(wireName: kDocumentReferenceField)
//   DocumentReference get reference;
//
//   static void _initializeBuilder(OfferRecordBuilder builder) => builder
//    ..expiryDate=Timestamp.now()
//    ..userId=ListBuilder<String>()
//    ..shopId=''
//    ..title=''
//    ..code=''
//    ..used=ListBuilder<String>()
//    ..description=''
//    ..global=true
//    ..amount=true
//    ..productId=''
//     ..unlimited=false
//     ..categoryId=''
//    ..value=0.00 ;
//
//   static CollectionReference get collection =>
//       FirebaseFirestore.instance.collection('offers');
//
//   static Stream<OfferRecord> getDocument(DocumentReference ref) => ref
//       .snapshots()
//       .map((s) => serializers.deserializeWith(serializer, serializedData(s as DocumentSnapshot<Map<String, dynamic>>))!);
//   OfferRecord._();
//   factory OfferRecord([void Function(OfferRecordBuilder) updates]) =
//   _$OfferRecord;
//
//   static OfferRecord? getDocumentFromData(
//       Map<String, dynamic> data, DocumentReference reference) =>
//       serializers.deserializeWith(
//           serializer, {...data, kDocumentReferenceField: reference});
// }
//
// Map<String, dynamic> createOfferRecordData({
//   Timestamp? expiryDate,
//   ListBuilder<String>?  userId,
//   String? shopId,
//   String? title,
//   String? productId,
//   String? categoryId,
//   String? code,
//   ListBuilder<String>? used,
//   String? description,
//   bool? global,
//   bool? unlimited,
//   bool? amount,
//   double? value,
//   ListBuilder<String>? search,
// }) =>
//     serializers.serializeWith(
//         OfferRecord.serializer,
//         OfferRecord((a) => a
//           ..expiryDate = expiryDate!
//           ..userId = userId!
//           ..shopId = shopId!
//           ..title = title!
//           ..code = code!
//           ..used = used!
//           ..description = description!
//           ..global = global!
//           ..search = search!
//           ..amount = amount!
//           ..value = value!
//           ..unlimited=unlimited!
//           ..productId=productId!
//           ..categoryId=categoryId!
//         )) as Map<String,dynamic>;
