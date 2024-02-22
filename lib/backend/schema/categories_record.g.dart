// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'categories_record.dart';
//
// // **************************************************************************
// // BuiltValueGenerator
// // **************************************************************************
//
// Serializer<CategoriesRecord> _$categoriesRecordSerializer =
//     new _$CategoriesRecordSerializer();
//
// class _$CategoriesRecordSerializer
//     implements StructuredSerializer<CategoriesRecord> {
//   @override
//   final Iterable<Type> types = const [CategoriesRecord, _$CategoriesRecord];
//   @override
//   final String wireName = 'CategoriesRecord';
//
//   @override
//   Iterable<Object?> serialize(Serializers serializers, CategoriesRecord object,
//       {FullType specifiedType = FullType.unspecified}) {
//     final result = <Object?>[
//       'categoryId',
//       serializers.serialize(object.categoryId,
//           specifiedType: const FullType(String)),
//       'imageUrl',
//       serializers.serialize(object.imageUrl,
//           specifiedType: const FullType(String)),
//       'branchId',
//       serializers.serialize(object.branchId,
//           specifiedType: const FullType(String)),
//       'name',
//       serializers.serialize(object.name, specifiedType: const FullType(String)),
//       'arabicName',
//       serializers.serialize(object.arabicName,
//           specifiedType: const FullType(String)),
//       'SNo',
//       serializers.serialize(object.SNo, specifiedType: const FullType(int)),
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
//   CategoriesRecord deserialize(
//       Serializers serializers, Iterable<Object?> serialized,
//       {FullType specifiedType = FullType.unspecified}) {
//     final result = new CategoriesRecordBuilder();
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
//         case 'branchId':
//           result.branchId = serializers.deserialize(value,
//               specifiedType: const FullType(String))! as String;
//           break;
//         case 'name':
//           result.name = serializers.deserialize(value,
//               specifiedType: const FullType(String))! as String;
//           break;
//         case 'arabicName':
//           result.arabicName = serializers.deserialize(value,
//               specifiedType: const FullType(String))! as String;
//           break;
//         case 'SNo':
//           result.SNo = serializers.deserialize(value,
//               specifiedType: const FullType(int))! as int;
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
// class _$CategoriesRecord extends CategoriesRecord {
//   @override
//   final String categoryId;
//   @override
//   final String imageUrl;
//   @override
//   final String branchId;
//   @override
//   final String name;
//   @override
//   final String arabicName;
//   @override
//   final int SNo;
//   @override
//   final BuiltList<String> search;
//   @override
//   final DocumentReference<Object?> reference;
//
//   factory _$CategoriesRecord(
//           [void Function(CategoriesRecordBuilder)? updates]) =>
//       (new CategoriesRecordBuilder()..update(updates))._build();
//
//   _$CategoriesRecord._(
//       {required this.categoryId,
//       required this.imageUrl,
//       required this.branchId,
//       required this.name,
//       required this.arabicName,
//       required this.SNo,
//       required this.search,
//       required this.reference})
//       : super._() {
//     BuiltValueNullFieldError.checkNotNull(
//         categoryId, r'CategoriesRecord', 'categoryId');
//     BuiltValueNullFieldError.checkNotNull(
//         imageUrl, r'CategoriesRecord', 'imageUrl');
//     BuiltValueNullFieldError.checkNotNull(
//         branchId, r'CategoriesRecord', 'branchId');
//     BuiltValueNullFieldError.checkNotNull(name, r'CategoriesRecord', 'name');
//     BuiltValueNullFieldError.checkNotNull(
//         arabicName, r'CategoriesRecord', 'arabicName');
//     BuiltValueNullFieldError.checkNotNull(SNo, r'CategoriesRecord', 'SNo');
//     BuiltValueNullFieldError.checkNotNull(
//         search, r'CategoriesRecord', 'search');
//     BuiltValueNullFieldError.checkNotNull(
//         reference, r'CategoriesRecord', 'reference');
//   }
//
//   @override
//   CategoriesRecord rebuild(void Function(CategoriesRecordBuilder) updates) =>
//       (toBuilder()..update(updates)).build();
//
//   @override
//   CategoriesRecordBuilder toBuilder() =>
//       new CategoriesRecordBuilder()..replace(this);
//
//   @override
//   bool operator ==(Object other) {
//     if (identical(other, this)) return true;
//     return other is CategoriesRecord &&
//         categoryId == other.categoryId &&
//         imageUrl == other.imageUrl &&
//         branchId == other.branchId &&
//         name == other.name &&
//         arabicName == other.arabicName &&
//         SNo == other.SNo &&
//         search == other.search &&
//         reference == other.reference;
//   }
//
//   @override
//   int get hashCode {
//     var _$hash = 0;
//     _$hash = $jc(_$hash, categoryId.hashCode);
//     _$hash = $jc(_$hash, imageUrl.hashCode);
//     _$hash = $jc(_$hash, branchId.hashCode);
//     _$hash = $jc(_$hash, name.hashCode);
//     _$hash = $jc(_$hash, arabicName.hashCode);
//     _$hash = $jc(_$hash, SNo.hashCode);
//     _$hash = $jc(_$hash, search.hashCode);
//     _$hash = $jc(_$hash, reference.hashCode);
//     _$hash = $jf(_$hash);
//     return _$hash;
//   }
//
//   @override
//   String toString() {
//     return (newBuiltValueToStringHelper(r'CategoriesRecord')
//           ..add('categoryId', categoryId)
//           ..add('imageUrl', imageUrl)
//           ..add('branchId', branchId)
//           ..add('name', name)
//           ..add('arabicName', arabicName)
//           ..add('SNo', SNo)
//           ..add('search', search)
//           ..add('reference', reference))
//         .toString();
//   }
// }
//
// class CategoriesRecordBuilder
//     implements Builder<CategoriesRecord, CategoriesRecordBuilder> {
//   _$CategoriesRecord? _$v;
//
//   String? _categoryId;
//   String? get categoryId => _$this._categoryId;
//   set categoryId(String? categoryId) => _$this._categoryId = categoryId;
//
//   String? _imageUrl;
//   String? get imageUrl => _$this._imageUrl;
//   set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;
//
//   String? _branchId;
//   String? get branchId => _$this._branchId;
//   set branchId(String? branchId) => _$this._branchId = branchId;
//
//   String? _name;
//   String? get name => _$this._name;
//   set name(String? name) => _$this._name = name;
//
//   String? _arabicName;
//   String? get arabicName => _$this._arabicName;
//   set arabicName(String? arabicName) => _$this._arabicName = arabicName;
//
//   int? _SNo;
//   int? get SNo => _$this._SNo;
//   set SNo(int? SNo) => _$this._SNo = SNo;
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
//   CategoriesRecordBuilder() {
//     CategoriesRecord._initializeBuilder(this);
//   }
//
//   CategoriesRecordBuilder get _$this {
//     final $v = _$v;
//     if ($v != null) {
//       _categoryId = $v.categoryId;
//       _imageUrl = $v.imageUrl;
//       _branchId = $v.branchId;
//       _name = $v.name;
//       _arabicName = $v.arabicName;
//       _SNo = $v.SNo;
//       _search = $v.search.toBuilder();
//       _reference = $v.reference;
//       _$v = null;
//     }
//     return this;
//   }
//
//   @override
//   void replace(CategoriesRecord other) {
//     ArgumentError.checkNotNull(other, 'other');
//     _$v = other as _$CategoriesRecord;
//   }
//
//   @override
//   void update(void Function(CategoriesRecordBuilder)? updates) {
//     if (updates != null) updates(this);
//   }
//
//   @override
//   CategoriesRecord build() => _build();
//
//   _$CategoriesRecord _build() {
//     _$CategoriesRecord _$result;
//     try {
//       _$result = _$v ??
//           new _$CategoriesRecord._(
//               categoryId: BuiltValueNullFieldError.checkNotNull(
//                   categoryId, r'CategoriesRecord', 'categoryId'),
//               imageUrl: BuiltValueNullFieldError.checkNotNull(
//                   imageUrl, r'CategoriesRecord', 'imageUrl'),
//               branchId: BuiltValueNullFieldError.checkNotNull(
//                   branchId, r'CategoriesRecord', 'branchId'),
//               name: BuiltValueNullFieldError.checkNotNull(
//                   name, r'CategoriesRecord', 'name'),
//               arabicName: BuiltValueNullFieldError.checkNotNull(
//                   arabicName, r'CategoriesRecord', 'arabicName'),
//               SNo: BuiltValueNullFieldError.checkNotNull(
//                   SNo, r'CategoriesRecord', 'SNo'),
//               search: search.build(),
//               reference: BuiltValueNullFieldError.checkNotNull(
//                   reference, r'CategoriesRecord', 'reference'));
//     } catch (_) {
//       late String _$failedField;
//       try {
//         _$failedField = 'search';
//         search.build();
//       } catch (e) {
//         throw new BuiltValueNestedFieldError(
//             r'CategoriesRecord', _$failedField, e.toString());
//       }
//       rethrow;
//     }
//     replace(_$result);
//     return _$result;
//   }
// }
//
// // ignore_for_file: deprecated_member_use_from_same_package,type=lint
