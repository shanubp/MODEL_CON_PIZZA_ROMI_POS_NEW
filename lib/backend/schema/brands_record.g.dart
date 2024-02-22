// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'brands_record.dart';
//
// // **************************************************************************
// // BuiltValueGenerator
// // **************************************************************************
//
// Serializer<BrandsRecord> _$brandsRecordSerializer =
//     new _$BrandsRecordSerializer();
//
// class _$BrandsRecordSerializer implements StructuredSerializer<BrandsRecord> {
//   @override
//   final Iterable<Type> types = const [BrandsRecord, _$BrandsRecord];
//   @override
//   final String wireName = 'BrandsRecord';
//
//   @override
//   Iterable<Object?> serialize(Serializers serializers, BrandsRecord object,
//       {FullType specifiedType = FullType.unspecified}) {
//     final result = <Object?>[
//       'brand',
//       serializers.serialize(object.brand,
//           specifiedType: const FullType(String)),
//       'brandId',
//       serializers.serialize(object.brandId,
//           specifiedType: const FullType(String)),
//       'imageUrl',
//       serializers.serialize(object.imageUrl,
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
//   BrandsRecord deserialize(
//       Serializers serializers, Iterable<Object?> serialized,
//       {FullType specifiedType = FullType.unspecified}) {
//     final result = new BrandsRecordBuilder();
//
//     final iterator = serialized.iterator;
//     while (iterator.moveNext()) {
//       final key = iterator.current! as String;
//       iterator.moveNext();
//       final Object? value = iterator.current;
//       switch (key) {
//         case 'brand':
//           result.brand = serializers.deserialize(value,
//               specifiedType: const FullType(String))! as String;
//           break;
//         case 'brandId':
//           result.brandId = serializers.deserialize(value,
//               specifiedType: const FullType(String))! as String;
//           break;
//         case 'imageUrl':
//           result.imageUrl = serializers.deserialize(value,
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
// class _$BrandsRecord extends BrandsRecord {
//   @override
//   final String brand;
//   @override
//   final String brandId;
//   @override
//   final String imageUrl;
//   @override
//   final BuiltList<String> search;
//   @override
//   final DocumentReference<Object?> reference;
//
//   factory _$BrandsRecord([void Function(BrandsRecordBuilder)? updates]) =>
//       (new BrandsRecordBuilder()..update(updates))._build();
//
//   _$BrandsRecord._(
//       {required this.brand,
//       required this.brandId,
//       required this.imageUrl,
//       required this.search,
//       required this.reference})
//       : super._() {
//     BuiltValueNullFieldError.checkNotNull(brand, r'BrandsRecord', 'brand');
//     BuiltValueNullFieldError.checkNotNull(brandId, r'BrandsRecord', 'brandId');
//     BuiltValueNullFieldError.checkNotNull(
//         imageUrl, r'BrandsRecord', 'imageUrl');
//     BuiltValueNullFieldError.checkNotNull(search, r'BrandsRecord', 'search');
//     BuiltValueNullFieldError.checkNotNull(
//         reference, r'BrandsRecord', 'reference');
//   }
//
//   @override
//   BrandsRecord rebuild(void Function(BrandsRecordBuilder) updates) =>
//       (toBuilder()..update(updates)).build();
//
//   @override
//   BrandsRecordBuilder toBuilder() => new BrandsRecordBuilder()..replace(this);
//
//   @override
//   bool operator ==(Object other) {
//     if (identical(other, this)) return true;
//     return other is BrandsRecord &&
//         brand == other.brand &&
//         brandId == other.brandId &&
//         imageUrl == other.imageUrl &&
//         search == other.search &&
//         reference == other.reference;
//   }
//
//   @override
//   int get hashCode {
//     var _$hash = 0;
//     _$hash = $jc(_$hash, brand.hashCode);
//     _$hash = $jc(_$hash, brandId.hashCode);
//     _$hash = $jc(_$hash, imageUrl.hashCode);
//     _$hash = $jc(_$hash, search.hashCode);
//     _$hash = $jc(_$hash, reference.hashCode);
//     _$hash = $jf(_$hash);
//     return _$hash;
//   }
//
//   @override
//   String toString() {
//     return (newBuiltValueToStringHelper(r'BrandsRecord')
//           ..add('brand', brand)
//           ..add('brandId', brandId)
//           ..add('imageUrl', imageUrl)
//           ..add('search', search)
//           ..add('reference', reference))
//         .toString();
//   }
// }
//
// class BrandsRecordBuilder
//     implements Builder<BrandsRecord, BrandsRecordBuilder> {
//   _$BrandsRecord? _$v;
//
//   String? _brand;
//   String? get brand => _$this._brand;
//   set brand(String? brand) => _$this._brand = brand;
//
//   String? _brandId;
//   String? get brandId => _$this._brandId;
//   set brandId(String? brandId) => _$this._brandId = brandId;
//
//   String? _imageUrl;
//   String? get imageUrl => _$this._imageUrl;
//   set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;
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
//   BrandsRecordBuilder() {
//     BrandsRecord._initializeBuilder(this);
//   }
//
//   BrandsRecordBuilder get _$this {
//     final $v = _$v;
//     if ($v != null) {
//       _brand = $v.brand;
//       _brandId = $v.brandId;
//       _imageUrl = $v.imageUrl;
//       _search = $v.search.toBuilder();
//       _reference = $v.reference;
//       _$v = null;
//     }
//     return this;
//   }
//
//   @override
//   void replace(BrandsRecord other) {
//     ArgumentError.checkNotNull(other, 'other');
//     _$v = other as _$BrandsRecord;
//   }
//
//   @override
//   void update(void Function(BrandsRecordBuilder)? updates) {
//     if (updates != null) updates(this);
//   }
//
//   @override
//   BrandsRecord build() => _build();
//
//   _$BrandsRecord _build() {
//     _$BrandsRecord _$result;
//     try {
//       _$result = _$v ??
//           new _$BrandsRecord._(
//               brand: BuiltValueNullFieldError.checkNotNull(
//                   brand, r'BrandsRecord', 'brand'),
//               brandId: BuiltValueNullFieldError.checkNotNull(
//                   brandId, r'BrandsRecord', 'brandId'),
//               imageUrl: BuiltValueNullFieldError.checkNotNull(
//                   imageUrl, r'BrandsRecord', 'imageUrl'),
//               search: search.build(),
//               reference: BuiltValueNullFieldError.checkNotNull(
//                   reference, r'BrandsRecord', 'reference'));
//     } catch (_) {
//       late String _$failedField;
//       try {
//         _$failedField = 'search';
//         search.build();
//       } catch (e) {
//         throw new BuiltValueNestedFieldError(
//             r'BrandsRecord', _$failedField, e.toString());
//       }
//       rethrow;
//     }
//     replace(_$result);
//     return _$result;
//   }
// }
//
// // ignore_for_file: deprecated_member_use_from_same_package,type=lint
