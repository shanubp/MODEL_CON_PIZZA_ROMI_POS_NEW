// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'sub_category_record.dart';
//
// // **************************************************************************
// // BuiltValueGenerator
// // **************************************************************************
//
// Serializer<SubCategoryRecord> _$subCategoryRecordSerializer =
//     new _$SubCategoryRecordSerializer();
//
// class _$SubCategoryRecordSerializer
//     implements StructuredSerializer<SubCategoryRecord> {
//   @override
//   final Iterable<Type> types = const [SubCategoryRecord, _$SubCategoryRecord];
//   @override
//   final String wireName = 'SubCategoryRecord';
//
//   @override
//   Iterable<Object?> serialize(Serializers serializers, SubCategoryRecord object,
//       {FullType specifiedType = FullType.unspecified}) {
//     final result = <Object?>[
//       'categoryId',
//       serializers.serialize(object.categoryId,
//           specifiedType: const FullType(String)),
//       'imageUrl',
//       serializers.serialize(object.imageUrl,
//           specifiedType: const FullType(String)),
//       'name',
//       serializers.serialize(object.name, specifiedType: const FullType(String)),
//       'subCategoryId',
//       serializers.serialize(object.subCategoryId,
//           specifiedType: const FullType(String)),
//       'search',
//       serializers.serialize(object.search,
//           specifiedType:
//               const FullType(BuiltList, const [const FullType(String)])),
//       'Document__Reference__Field',
//       serializers.serialize(object.reference,
//           specifiedType: const FullType(
//               DocumentReference, const [const FullType.nullable(Object)])),
//     ];
//
//     return result;
//   }
//
//   @override
//   SubCategoryRecord deserialize(
//       Serializers serializers, Iterable<Object?> serialized,
//       {FullType specifiedType = FullType.unspecified}) {
//     final result = new SubCategoryRecordBuilder();
//
//     final iterator = serialized.iterator;
//     while (iterator.moveNext()) {
//       final key = iterator.current! as String;
//       iterator.moveNext();
//       final Object? value = iterator.current;
//       switch (key) {
//         case 'categoryId':
//           result.categoryId = serializers.deserialize(value,
//               specifiedType: const FullType(String))! as String;
//           break;
//         case 'imageUrl':
//           result.imageUrl = serializers.deserialize(value,
//               specifiedType: const FullType(String))! as String;
//           break;
//         case 'name':
//           result.name = serializers.deserialize(value,
//               specifiedType: const FullType(String))! as String;
//           break;
//         case 'subCategoryId':
//           result.subCategoryId = serializers.deserialize(value,
//               specifiedType: const FullType(String))! as String;
//           break;
//         case 'search':
//           result.search.replace(serializers.deserialize(value,
//                   specifiedType: const FullType(
//                       BuiltList, const [const FullType(String)]))!
//               as BuiltList<Object?>);
//           break;
//         case 'Document__Reference__Field':
//           result.reference = serializers.deserialize(value,
//               specifiedType: const FullType(DocumentReference, const [
//                 const FullType.nullable(Object)
//               ]))! as DocumentReference<Object?>;
//           break;
//       }
//     }
//
//     return result.build();
//   }
// }
//
// class _$SubCategoryRecord extends SubCategoryRecord {
//   @override
//   final String categoryId;
//   @override
//   final String imageUrl;
//   @override
//   final String name;
//   @override
//   final String subCategoryId;
//   @override
//   final BuiltList<String> search;
//   @override
//   final DocumentReference<Object?> reference;
//
//   factory _$SubCategoryRecord(
//           [void Function(SubCategoryRecordBuilder)? updates]) =>
//       (new SubCategoryRecordBuilder()..update(updates))._build();
//
//   _$SubCategoryRecord._(
//       {required this.categoryId,
//       required this.imageUrl,
//       required this.name,
//       required this.subCategoryId,
//       required this.search,
//       required this.reference})
//       : super._() {
//     BuiltValueNullFieldError.checkNotNull(
//         categoryId, r'SubCategoryRecord', 'categoryId');
//     BuiltValueNullFieldError.checkNotNull(
//         imageUrl, r'SubCategoryRecord', 'imageUrl');
//     BuiltValueNullFieldError.checkNotNull(name, r'SubCategoryRecord', 'name');
//     BuiltValueNullFieldError.checkNotNull(
//         subCategoryId, r'SubCategoryRecord', 'subCategoryId');
//     BuiltValueNullFieldError.checkNotNull(
//         search, r'SubCategoryRecord', 'search');
//     BuiltValueNullFieldError.checkNotNull(
//         reference, r'SubCategoryRecord', 'reference');
//   }
//
//   @override
//   SubCategoryRecord rebuild(void Function(SubCategoryRecordBuilder) updates) =>
//       (toBuilder()..update(updates)).build();
//
//   @override
//   SubCategoryRecordBuilder toBuilder() =>
//       new SubCategoryRecordBuilder()..replace(this);
//
//   @override
//   bool operator ==(Object other) {
//     if (identical(other, this)) return true;
//     return other is SubCategoryRecord &&
//         categoryId == other.categoryId &&
//         imageUrl == other.imageUrl &&
//         name == other.name &&
//         subCategoryId == other.subCategoryId &&
//         search == other.search &&
//         reference == other.reference;
//   }
//
//   @override
//   int get hashCode {
//     var _$hash = 0;
//     _$hash = $jc(_$hash, categoryId.hashCode);
//     _$hash = $jc(_$hash, imageUrl.hashCode);
//     _$hash = $jc(_$hash, name.hashCode);
//     _$hash = $jc(_$hash, subCategoryId.hashCode);
//     _$hash = $jc(_$hash, search.hashCode);
//     _$hash = $jc(_$hash, reference.hashCode);
//     _$hash = $jf(_$hash);
//     return _$hash;
//   }
//
//   @override
//   String toString() {
//     return (newBuiltValueToStringHelper(r'SubCategoryRecord')
//           ..add('categoryId', categoryId)
//           ..add('imageUrl', imageUrl)
//           ..add('name', name)
//           ..add('subCategoryId', subCategoryId)
//           ..add('search', search)
//           ..add('reference', reference))
//         .toString();
//   }
// }
//
// class SubCategoryRecordBuilder
//     implements Builder<SubCategoryRecord, SubCategoryRecordBuilder> {
//   _$SubCategoryRecord? _$v;
//
//   String? _categoryId;
//   String? get categoryId => _$this._categoryId;
//   set categoryId(String? categoryId) => _$this._categoryId = categoryId;
//
//   String? _imageUrl;
//   String? get imageUrl => _$this._imageUrl;
//   set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;
//
//   String? _name;
//   String? get name => _$this._name;
//   set name(String? name) => _$this._name = name;
//
//   String? _subCategoryId;
//   String? get subCategoryId => _$this._subCategoryId;
//   set subCategoryId(String? subCategoryId) =>
//       _$this._subCategoryId = subCategoryId;
//
//   ListBuilder<String>? _search;
//   ListBuilder<String> get search =>
//       _$this._search ??= new ListBuilder<String>();
//   set search(ListBuilder<String>? search) => _$this._search = search;
//
//   DocumentReference<Object?>? _reference;
//   DocumentReference<Object?>? get reference => _$this._reference;
//   set reference(DocumentReference<Object?>? reference) =>
//       _$this._reference = reference;
//
//   SubCategoryRecordBuilder() {
//     SubCategoryRecord._initializeBuilder(this);
//   }
//
//   SubCategoryRecordBuilder get _$this {
//     final $v = _$v;
//     if ($v != null) {
//       _categoryId = $v.categoryId;
//       _imageUrl = $v.imageUrl;
//       _name = $v.name;
//       _subCategoryId = $v.subCategoryId;
//       _search = $v.search.toBuilder();
//       _reference = $v.reference;
//       _$v = null;
//     }
//     return this;
//   }
//
//   @override
//   void replace(SubCategoryRecord other) {
//     ArgumentError.checkNotNull(other, 'other');
//     _$v = other as _$SubCategoryRecord;
//   }
//
//   @override
//   void update(void Function(SubCategoryRecordBuilder)? updates) {
//     if (updates != null) updates(this);
//   }
//
//   @override
//   SubCategoryRecord build() => _build();
//
//   _$SubCategoryRecord _build() {
//     _$SubCategoryRecord _$result;
//     try {
//       _$result = _$v ??
//           new _$SubCategoryRecord._(
//               categoryId: BuiltValueNullFieldError.checkNotNull(
//                   categoryId, r'SubCategoryRecord', 'categoryId'),
//               imageUrl: BuiltValueNullFieldError.checkNotNull(
//                   imageUrl, r'SubCategoryRecord', 'imageUrl'),
//               name: BuiltValueNullFieldError.checkNotNull(
//                   name, r'SubCategoryRecord', 'name'),
//               subCategoryId: BuiltValueNullFieldError.checkNotNull(
//                   subCategoryId, r'SubCategoryRecord', 'subCategoryId'),
//               search: search.build(),
//               reference: BuiltValueNullFieldError.checkNotNull(
//                   reference, r'SubCategoryRecord', 'reference'));
//     } catch (_) {
//       late String _$failedField;
//       try {
//         _$failedField = 'search';
//         search.build();
//       } catch (e) {
//         throw new BuiltValueNestedFieldError(
//             r'SubCategoryRecord', _$failedField, e.toString());
//       }
//       rethrow;
//     }
//     replace(_$result);
//     return _$result;
//   }
// }
//
// // ignore_for_file: deprecated_member_use_from_same_package,type=lint
