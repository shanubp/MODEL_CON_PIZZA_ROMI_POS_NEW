// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'cut_record.dart';
//
// // **************************************************************************
// // BuiltValueGenerator
// // **************************************************************************
//
// Serializer<CutRecord> _$cutRecordSerializer = new _$CutRecordSerializer();
//
// class _$CutRecordSerializer implements StructuredSerializer<CutRecord> {
//   @override
//   final Iterable<Type> types = const [CutRecord, _$CutRecord];
//   @override
//   final String wireName = 'CutRecord';
//
//   @override
//   Iterable<Object?> serialize(Serializers serializers, CutRecord object,
//       {FullType specifiedType = FullType.unspecified}) {
//     final result = <Object?>[
//       'cutId',
//       serializers.serialize(object.cutId,
//           specifiedType: const FullType(String)),
//       'imageUrl',
//       serializers.serialize(object.imageUrl,
//           specifiedType: const FullType(String)),
//       'name',
//       serializers.serialize(object.name, specifiedType: const FullType(String)),
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
//   CutRecord deserialize(Serializers serializers, Iterable<Object?> serialized,
//       {FullType specifiedType = FullType.unspecified}) {
//     final result = new CutRecordBuilder();
//
//     final iterator = serialized.iterator;
//     while (iterator.moveNext()) {
//       final key = iterator.current! as String;
//       iterator.moveNext();
//       final Object? value = iterator.current;
//       switch (key) {
//         case 'cutId':
//           result.cutId = serializers.deserialize(value,
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
// class _$CutRecord extends CutRecord {
//   @override
//   final String cutId;
//   @override
//   final String imageUrl;
//   @override
//   final String name;
//   @override
//   final BuiltList<String> search;
//   @override
//   final DocumentReference<Object?> reference;
//
//   factory _$CutRecord([void Function(CutRecordBuilder)? updates]) =>
//       (new CutRecordBuilder()..update(updates))._build();
//
//   _$CutRecord._(
//       {required this.cutId,
//       required this.imageUrl,
//       required this.name,
//       required this.search,
//       required this.reference})
//       : super._() {
//     BuiltValueNullFieldError.checkNotNull(cutId, r'CutRecord', 'cutId');
//     BuiltValueNullFieldError.checkNotNull(imageUrl, r'CutRecord', 'imageUrl');
//     BuiltValueNullFieldError.checkNotNull(name, r'CutRecord', 'name');
//     BuiltValueNullFieldError.checkNotNull(search, r'CutRecord', 'search');
//     BuiltValueNullFieldError.checkNotNull(reference, r'CutRecord', 'reference');
//   }
//
//   @override
//   CutRecord rebuild(void Function(CutRecordBuilder) updates) =>
//       (toBuilder()..update(updates)).build();
//
//   @override
//   CutRecordBuilder toBuilder() => new CutRecordBuilder()..replace(this);
//
//   @override
//   bool operator ==(Object other) {
//     if (identical(other, this)) return true;
//     return other is CutRecord &&
//         cutId == other.cutId &&
//         imageUrl == other.imageUrl &&
//         name == other.name &&
//         search == other.search &&
//         reference == other.reference;
//   }
//
//   @override
//   int get hashCode {
//     var _$hash = 0;
//     _$hash = $jc(_$hash, cutId.hashCode);
//     _$hash = $jc(_$hash, imageUrl.hashCode);
//     _$hash = $jc(_$hash, name.hashCode);
//     _$hash = $jc(_$hash, search.hashCode);
//     _$hash = $jc(_$hash, reference.hashCode);
//     _$hash = $jf(_$hash);
//     return _$hash;
//   }
//
//   @override
//   String toString() {
//     return (newBuiltValueToStringHelper(r'CutRecord')
//           ..add('cutId', cutId)
//           ..add('imageUrl', imageUrl)
//           ..add('name', name)
//           ..add('search', search)
//           ..add('reference', reference))
//         .toString();
//   }
// }
//
// class CutRecordBuilder implements Builder<CutRecord, CutRecordBuilder> {
//   _$CutRecord? _$v;
//
//   String? _cutId;
//   String? get cutId => _$this._cutId;
//   set cutId(String? cutId) => _$this._cutId = cutId;
//
//   String? _imageUrl;
//   String? get imageUrl => _$this._imageUrl;
//   set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;
//
//   String? _name;
//   String? get name => _$this._name;
//   set name(String? name) => _$this._name = name;
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
//   CutRecordBuilder() {
//     CutRecord._initializeBuilder(this);
//   }
//
//   CutRecordBuilder get _$this {
//     final $v = _$v;
//     if ($v != null) {
//       _cutId = $v.cutId;
//       _imageUrl = $v.imageUrl;
//       _name = $v.name;
//       _search = $v.search.toBuilder();
//       _reference = $v.reference;
//       _$v = null;
//     }
//     return this;
//   }
//
//   @override
//   void replace(CutRecord other) {
//     ArgumentError.checkNotNull(other, 'other');
//     _$v = other as _$CutRecord;
//   }
//
//   @override
//   void update(void Function(CutRecordBuilder)? updates) {
//     if (updates != null) updates(this);
//   }
//
//   @override
//   CutRecord build() => _build();
//
//   _$CutRecord _build() {
//     _$CutRecord _$result;
//     try {
//       _$result = _$v ??
//           new _$CutRecord._(
//               cutId: BuiltValueNullFieldError.checkNotNull(
//                   cutId, r'CutRecord', 'cutId'),
//               imageUrl: BuiltValueNullFieldError.checkNotNull(
//                   imageUrl, r'CutRecord', 'imageUrl'),
//               name: BuiltValueNullFieldError.checkNotNull(
//                   name, r'CutRecord', 'name'),
//               search: search.build(),
//               reference: BuiltValueNullFieldError.checkNotNull(
//                   reference, r'CutRecord', 'reference'));
//     } catch (_) {
//       late String _$failedField;
//       try {
//         _$failedField = 'search';
//         search.build();
//       } catch (e) {
//         throw new BuiltValueNestedFieldError(
//             r'CutRecord', _$failedField, e.toString());
//       }
//       rethrow;
//     }
//     replace(_$result);
//     return _$result;
//   }
// }
//
// // ignore_for_file: deprecated_member_use_from_same_package,type=lint
