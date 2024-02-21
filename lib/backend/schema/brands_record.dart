
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'serializers.dart';

part 'brands_record.g.dart';

abstract class BrandsRecord
    implements Built<BrandsRecord, BrandsRecordBuilder> {
  static Serializer<BrandsRecord> get serializer => _$brandsRecordSerializer;

  String get brand;

  String get brandId;

  String get imageUrl;
  BuiltList<String> get search;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(BrandsRecordBuilder builder) => builder
    ..brand = ''
    ..search = ListBuilder()
    ..imageUrl = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('brands');

  static Stream<BrandsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s as DocumentSnapshot<Map<String, dynamic>>))!);

  BrandsRecord._();
  factory BrandsRecord([void Function(BrandsRecordBuilder) updates]) =
  _$BrandsRecord;
}

Map<String, dynamic> createBrandsRecordData({
  String? brand,
  String? brandId,
  String? imageUrl,
  ListBuilder<String>? search,
}) =>
    serializers.serializeWith(
        BrandsRecord.serializer,
        BrandsRecord((b) => b
          ..brand = brand
          ..brandId = brandId
          ..search =search
          ..imageUrl = imageUrl))as Map<String,dynamic>;


