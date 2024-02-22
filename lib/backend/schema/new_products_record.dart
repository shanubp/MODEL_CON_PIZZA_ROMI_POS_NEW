//
// import 'package:built_value/built_value.dart';
// import 'package:built_value/serializer.dart';
// import 'package:built_collection/built_collection.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
//
// import 'cut_record.dart';
// import 'serializers.dart';
//
// part 'new_products_record.g.dart';
//
// abstract class NewProductsRecord
//     implements Built<NewProductsRecord, NewProductsRecordBuilder> {
//   static Serializer<NewProductsRecord> get serializer =>
//       _$newProductsRecordSerializer;
//
//
//   String get name;
//
//
//   String get unit;
//
//   String get shopId;
//
//   String get shopName;
//
//   int get ones;
//
//   int get twos;
//
//   int get threes;
//
//   int get fours;
//
//   int get fives;
//
//
//   String get description;
//
//
//   double get price;
//
//
//   double get discountPrice;
//
//
//   String get userId;
//
//
//   BuiltList<String> get color;
//
//   BuiltList<String> get size;
//
//   BuiltList<CutRecord> get cuts;
//
//
//   BuiltList<String> get imageId;
//
//   BuiltList<String> get search;
//
//
//
//   String get productId;
//
//   String get brand;
//
//   String get subCategory;
//
//   String get category;
//
//   bool get available;
//   bool get open;
//
//   String  get branchId;
//
//   double get start;
//
//   double get step;
//
//   double get stop;
//
//
//   @BuiltValueField(wireName: kDocumentReferenceField)
//   DocumentReference get reference;
//
//   static void _initializeBuilder(NewProductsRecordBuilder builder) => builder
//     ..name = ''
//     ..description = ''
//     ..brand = ''
//     ..unit =''
//     ..subCategory = ''
//     ..shopId = ''
//     ..shopName = ''
//     ..category = ''
//     ..productId = ''
//     ..price = 0.0
//     ..discountPrice = 0.0
//     ..ones=0
//     ..twos=0
//     ..threes=0
//     ..fours=0
//     ..fives=0
//     ..start=0.0
//     ..step=0.0
//     ..stop=0.0
//     ..available=false
//     ..open=false
//     ..color = ListBuilder<String>()
//     ..size = ListBuilder<String>()
//     ..imageId = ListBuilder<String>()
//     ..cuts = ListBuilder<CutRecord>()
//     ..size = ListBuilder<String>()
//     ..size = ListBuilder<String>()
//     ..branchId='';
//
//
//   static CollectionReference get collection =>
//       FirebaseFirestore.instance.collection('products');
//
//   static Stream<NewProductsRecord> getDocument(DocumentReference ref) => ref
//       .snapshots()
//       .map((s) => serializers.deserializeWith(serializer, serializedData(s as DocumentSnapshot<Map<String, dynamic>>))!);
//
//
//   NewProductsRecord._();
//   factory NewProductsRecord([void Function(NewProductsRecordBuilder) updates]) =
//   _$NewProductsRecord;
// }
//
// Map<String, dynamic> createNewProductsRecordData({
//   String? name,
//   String? description,
//   String? brand,
//   String? subCategory,
//   String? category,
//   double? price,
//   double? discountPrice,
//   String? unit,
//   String? shopId,
//   String? shopName,
//   String? userId,
//   String? productId,
//   ListBuilder<String>? color,
//   ListBuilder<String>? size,
//   ListBuilder<String>? imageId,
//   ListBuilder<String>? search,
//   ListBuilder<CutRecord>? cuts,
//   int? ones,
//   int? twos,
//   int? threes,
//   int? fours,
//   int? fives,
//   bool? available,
//   bool? open,
//   String?  branchId,
//   double? start,
//   double? step,
//   double? stop,
//
// }) =>
//     serializers.serializeWith(
//         NewProductsRecord.serializer,
//         NewProductsRecord((n) => n
//           ..name = name!
//           ..description = description!
//           ..brand = brand!
//           ..subCategory = subCategory!
//           ..category = category!
//           ..price = price!
//           ..discountPrice = discountPrice!
//           ..unit =unit!
//           ..userId = userId!
//           ..color = color!
//           ..size = size!
//           ..shopId = shopId!
//           ..shopName = shopName!
//           ..search = search!
//           ..imageId = imageId!
//           ..cuts=cuts!
//           ..ones=ones!
//           ..twos=twos!
//           ..threes=threes!
//           ..fours=fours!
//           ..fives=fives!
//           ..productId = productId!
//           ..available =available!
//           ..open=open!
//           ..branchId=branchId!
//           ..start=start!
//           ..step=step!
//           ..stop=stop!
//         )) as Map<String,dynamic>;
//
//
