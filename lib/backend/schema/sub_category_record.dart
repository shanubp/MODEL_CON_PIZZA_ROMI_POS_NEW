//
// import 'package:built_value/built_value.dart';
// import 'package:built_value/serializer.dart';
// import 'package:built_collection/built_collection.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
//
// import 'serializers.dart';
//
// part 'sub_category_record.g.dart';
//
// abstract class SubCategoryRecord
//     implements Built<SubCategoryRecord, SubCategoryRecordBuilder> {
//   static Serializer<SubCategoryRecord> get serializer =>
//       _$subCategoryRecordSerializer;
//
//
//   String get categoryId;
//
//
//   String get imageUrl;
//
//
//   String get name;
//
//
//   String get subCategoryId;
//
//
//   BuiltList<String> get search;
//
//
//   @BuiltValueField(wireName: kDocumentReferenceField)
//   DocumentReference get reference;
//
//   static void _initializeBuilder(SubCategoryRecordBuilder builder) => builder
//     ..categoryId = ''
//     ..imageUrl = ''
//     ..name = ''
//     ..subCategoryId = ''
//     ..search = ListBuilder();
//
//   static CollectionReference get collection =>
//       FirebaseFirestore.instance.collection('subCategory');
//
//   static Stream<SubCategoryRecord?> getDocument(DocumentReference ref) => ref
//       .snapshots()
//       .map((s) => serializers.deserializeWith(serializer, serializedData(s as DocumentSnapshot<Map<String, dynamic>>))!);
//
//   SubCategoryRecord._();
//   factory SubCategoryRecord([void Function(SubCategoryRecordBuilder) updates]) =
//       _$SubCategoryRecord;
// }
//
// Map<String, dynamic> createSubCategoryRecordData({
//   String? categoryId,
//   String? imageUrl,
//   String? name,
//   String? subCategoryId,
//   ListBuilder<String>? search,
// }) =>
//     serializers.serializeWith(
//         SubCategoryRecord.serializer,
//         SubCategoryRecord((s) => s
//           ..categoryId = categoryId!
//           ..imageUrl = imageUrl!
//           ..name = name!
//           ..subCategoryId = subCategoryId!
//           ..search = search!)) as Map<String,dynamic>;
//
//
//
//
