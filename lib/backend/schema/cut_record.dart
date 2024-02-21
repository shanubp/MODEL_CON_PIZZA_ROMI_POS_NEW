
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'serializers.dart';

part 'cut_record.g.dart';

abstract class CutRecord
    implements Built<CutRecord, CutRecordBuilder> {
  static Serializer<CutRecord> get serializer =>
      _$cutRecordSerializer;


  String get cutId;


  String get imageUrl;


  String get name;


  BuiltList<String> get search;


  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(CutRecordBuilder builder) => builder
    ..cutId = ''
    ..imageUrl = ''
    ..name = ''
    ..search = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('cuts');

  static Stream<CutRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s as DocumentSnapshot<Map<String, dynamic>>))!);

  CutRecord._();
  factory CutRecord([void Function(CutRecordBuilder) updates]) =
  _$CutRecord;
}

Map<String, dynamic> createCutRecordData({
  String? cutId,
  String? imageUrl,
  String? name,
  ListBuilder<String>? search,
}) =>
    serializers.serializeWith(
        CutRecord.serializer,
        CutRecord((c) => c
          ..cutId = cutId!
          ..imageUrl = imageUrl!
          ..name = name!
          ..search = search!)) as Map<String,dynamic>;


