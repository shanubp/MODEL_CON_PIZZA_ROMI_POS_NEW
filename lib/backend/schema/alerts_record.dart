//
// import 'dart:async';
//
// import 'index.dart';
// import 'serializers.dart';
// import 'package:built_value/built_value.dart';
//
// part 'alerts_record.g.dart';
//
// abstract class AlertsRecord
//     implements Built<AlertsRecord, AlertsRecordBuilder> {
//   static Serializer<AlertsRecord> get serializer => _$alertsRecordSerializer;
//
//
//   Timestamp get date;
//
//
//   String get userId;
//
//
//   String get title;
//
//
//   String get message;
//   String get seen;
//
//
//   String get link;
//
//
//   @BuiltValueField(wireName: kDocumentReferenceField)
//   DocumentReference get reference;
//
//   static void _initializeBuilder(AlertsRecordBuilder builder) => builder
//     ..title = ''
//     ..message = ''
//     ..seen = ''
//     ..link = '';
//
//   static CollectionReference get collection =>
//       FirebaseFirestore.instance.collection('alerts');
//
//   static Stream<AlertsRecord> getDocument(DocumentReference ref) => ref
//       .snapshots()
//       .map((s) => serializers.deserializeWith(serializer, serializedData(s as DocumentSnapshot<Map<String, dynamic>>))!);
//
//   AlertsRecord._();
//   factory AlertsRecord([void Function(AlertsRecordBuilder) updates]) =
//       _$AlertsRecord;
//
//   static AlertsRecord? getDocumentFromData(
//           Map<String, dynamic> data, DocumentReference reference) =>
//       serializers.deserializeWith(
//           serializer, {...data, kDocumentReferenceField: reference});
// }
//
// Map<String, dynamic> createAlertsRecordData({
//   Timestamp? date,
//   String? userId,
//   String? title,
//   String? message,
//   String? seen,
//   String? link,
// }) =>
//     serializers.serializeWith(
//         AlertsRecord.serializer,
//         AlertsRecord((a) => a
//           ..date = date!
//           ..userId = userId!
//           ..title = title!
//           ..message = message!
//           ..seen = seen!
//           ..link = link!))as Map<String,dynamic> ;
