
// import 'package:built_value/built_value.dart';
// import 'package:built_value/serializer.dart';
// import 'package:built_collection/built_collection.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
//
// import 'serializers.dart';
//
// part 'categories_record.g.dart';
//
// abstract class CategoriesRecord
//     implements Built<CategoriesRecord, CategoriesRecordBuilder> {
//   static Serializer<CategoriesRecord> get serializer =>
//       _$categoriesRecordSerializer;
//
//
//   String get categoryId;
//
//
//   String get imageUrl;
//
//
//   String get branchId;
//
//
//   String get name;
//
//
//   String get arabicName;
//
//
//   int get SNo;
//
//
//   BuiltList<String> get search;
//
//
//   @BuiltValueField(wireName: kDocumentReferenceField)
//   DocumentReference get reference;
//
//   static void _initializeBuilder(CategoriesRecordBuilder builder) => builder
//     ..categoryId = ''
//     ..imageUrl = ''
//     ..name = ''
//     ..arabicName = ''
//     ..branchId = ''
//     ..SNo = 0
//     ..search = ListBuilder();
//
//   static CollectionReference get collection =>
//       FirebaseFirestore.instance.collection('category');
//
//   static Stream<CategoriesRecord> getDocument(DocumentReference ref) => ref
//       .snapshots()
//       .map((s) => serializers.deserializeWith(serializer, serializedData(s as DocumentSnapshot<Map<String, dynamic>>))!);
//
//   CategoriesRecord._();
//   factory CategoriesRecord([void Function(CategoriesRecordBuilder) updates]) =
//   _$CategoriesRecord;
// }
//
// Map<String, dynamic> createCategoriesRecordData({
//   String? categoryId,
//   String? imageUrl,
//   String? name,
//   String? arabicName,
//   String? branchId,
//   int? SNo,
//   ListBuilder<String>? search,
// }) =>
//     serializers.serializeWith(
//         CategoriesRecord.serializer,
//         CategoriesRecord((c) => c
//           ..categoryId = categoryId!
//           ..imageUrl = imageUrl!
//           ..name = name!
//           ..arabicName = arabicName!
//           ..branchId = branchId!
//           ..SNo = SNo!
//           ..search = search!) )as Map<String,dynamic>;
//
//
