// import 'dart:async';
//
// import 'index.dart';
// import 'serializers.dart';
// import 'package:built_value/built_value.dart';
//
// part 'shops_record.g.dart';
//
// abstract class ShopsRecord implements Built<ShopsRecord, ShopsRecordBuilder> {
//   static Serializer<ShopsRecord> get serializer => _$shopsRecordSerializer;
//
//   String get imageUrl;
//
//   String get name;
//
//   String get shopId;
//
//   String get address;
//
//   String get email;
//   int get ones;
//   int get twos;
//   int get threes;
//   int get fours;
//
//   int get fives;
//
//   String get sunFrom;
//
//   String get sunTo;
//
//   String get monFrom;
//
//   String get monTo;
//
//   String get tueFrom;
//
//   String get tueTo;
//
//   String get wedFrom;
//
//   String get wedTo;
//
//   String get thuFrom;
//
//   String get thuTo;
//
//   String get friFrom;
//
//   String get friTo;
//
//   String get satFrom;
//
//   String get satTo;
//
//   @BuiltValueField(wireName: 'FSSAIRegNo')
//   String get fSSAIRegNo;
//
//   BuiltList<String> get users;
//
//   String get phoneNumber;
//   BuiltList<String> get search;
//   BuiltList<String> get admins;
//   bool get online;
//   double get discount;
//   double get paid;
//   double get sales;
//   Timestamp get paidUpdate;
//   Timestamp get salesUpdate;
//   String  get branchId;
//   double get latitude;
//   double get longitude;
//
//   @BuiltValueField(wireName: kDocumentReferenceField)
//   DocumentReference get reference;
//
//   static void _initializeBuilder(ShopsRecordBuilder builder) => builder
//     ..imageUrl = ''
//     ..name = ''
//     ..shopId = ''
//     ..address = ''
//     ..email = ''
//     ..sunFrom = ''
//     ..sunTo = ''
//     ..monFrom = ''
//     ..monTo = ''
//     ..tueFrom = ''
//     ..tueTo = ''
//     ..wedFrom = ''
//     ..wedTo = ''
//     ..thuFrom = ''
//     ..thuTo = ''
//     ..friFrom = ''
//     ..friTo = ''
//     ..satFrom = ''
//     ..satTo = ''
//     ..fSSAIRegNo = ''
//     ..users = ListBuilder()
//     ..search=ListBuilder()
//     ..admins=ListBuilder()
//     ..phoneNumber = ''
//     ..ones=0
//     ..twos=0
//     ..threes=0
//     ..fours=0
//     ..fives=0
//     ..discount=0.0
//     ..paid=0.0
//     ..sales=0.0
//     ..latitude=0.0
//     ..longitude=0.0
//     ..paidUpdate=Timestamp.now()
//     ..salesUpdate=Timestamp.now()
//     ..branchId=''
//     ..online=false;
//
//   static CollectionReference get collection =>
//       FirebaseFirestore.instance.collection('shops');
//
//   static Stream<ShopsRecord> getDocument(DocumentReference ref) => ref
//       .snapshots()
//       .map((s) => serializers.deserializeWith(serializer, serializedData(s as DocumentSnapshot<Map<String, dynamic>>))!);
//
//   ShopsRecord._();
//   factory ShopsRecord([void Function(ShopsRecordBuilder) updates]) =
//   _$ShopsRecord;
//
//   static ShopsRecord? getDocumentFromData(
//       Map<String, dynamic> data, DocumentReference reference) =>
//       serializers.deserializeWith(
//           serializer, {...data, kDocumentReferenceField: reference});
// }
//
// Map<String, dynamic> createShopsRecordData({
//   String? imageUrl,
//   String? name,
//   String? shopId,
//   String? address,
//   String? email,
//   String? sunFrom,
//   String? sunTo,
//   String? monFrom,
//   String? monTo,
//   String? tueFrom,
//   String? tueTo,
//   String? wedFrom,
//   String? wedTo,
//   String? thuFrom,
//   String? thuTo,
//   String? friFrom,
//   String? friTo,
//   String? satFrom,
//   String? satTo,
//   String? fSSAIRegNo,
//   String? phoneNumber,
//   ListBuilder? search,
//   ListBuilder? admins,
//   bool? online,
//   int? ones,
//   int? twos,
//   int? threes,
//   int? fours,
//   int? fives,
//   double? discount,
//   double? paid,
//   double? sales,
//   double? latitude,
//   double? longitude,
//   Timestamp? paidUpdate,
//   Timestamp? salesUpdate,
//   String? branchId,
// }) =>
//     serializers.serializeWith(
//         ShopsRecord.serializer,
//         ShopsRecord((s) => s
//           ..imageUrl = imageUrl!
//           ..name = name!
//           ..shopId = shopId!
//           ..address = address!
//           ..email = email!
//           ..sunFrom = sunFrom!
//           ..sunTo = sunTo!
//           ..monFrom = monFrom!
//           ..monTo = monTo!
//           ..tueFrom = tueFrom!
//           ..tueTo = tueTo!
//           ..wedFrom = wedFrom!
//           ..wedTo = wedTo!
//           ..thuFrom = thuFrom!
//           ..thuTo = thuTo!
//           ..friFrom = friFrom!
//           ..friTo = friTo!
//           ..satFrom = satFrom!
//           ..satTo = satTo!
//           ..fSSAIRegNo = fSSAIRegNo!
//
//           ..phoneNumber = phoneNumber!
//           ..search=search as ListBuilder<String>
//           ..admins =admins as ListBuilder<String>
//           ..ones=ones!
//           ..twos=twos!
//           ..threes=threes!
//           ..fours=fours!
//           ..fives=fives!
//           ..discount=discount!
//           ..paid=paid!
//           ..sales=sales!
//           ..paidUpdate=paidUpdate!
//           ..salesUpdate=salesUpdate!
//           ..online=online!
//           ..latitude=latitude!
//           ..longitude=longitude!
//           ..branchId=branchId!))as Map<String,dynamic>;
