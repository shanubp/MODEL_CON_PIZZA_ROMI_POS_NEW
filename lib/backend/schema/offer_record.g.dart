// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'offer_record.dart';
//
// // **************************************************************************
// // BuiltValueGenerator
// // **************************************************************************
//
// Serializer<OfferRecord> _$offerRecordSerializer = new _$OfferRecordSerializer();
//
// class _$OfferRecordSerializer implements StructuredSerializer<OfferRecord> {
//   @override
//   final Iterable<Type> types = const [OfferRecord, _$OfferRecord];
//   @override
//   final String wireName = 'OfferRecord';
//
//   @override
//   Iterable<Object?> serialize(Serializers serializers, OfferRecord object,
//       {FullType specifiedType = FullType.unspecified}) {
//     final result = <Object?>[
//       'expiryDate',
//       serializers.serialize(object.expiryDate,
//           specifiedType: const FullType(Timestamp)),
//       'userId',
//       serializers.serialize(object.userId,
//           specifiedType:
//               const FullType(BuiltList, const [const FullType(String)])),
//       'search',
//       serializers.serialize(object.search,
//           specifiedType:
//               const FullType(BuiltList, const [const FullType(String)])),
//       'shopId',
//       serializers.serialize(object.shopId,
//           specifiedType: const FullType(String)),
//       'productId',
//       serializers.serialize(object.productId,
//           specifiedType: const FullType(String)),
//       'categoryId',
//       serializers.serialize(object.categoryId,
//           specifiedType: const FullType(String)),
//       'title',
//       serializers.serialize(object.title,
//           specifiedType: const FullType(String)),
//       'code',
//       serializers.serialize(object.code, specifiedType: const FullType(String)),
//       'used',
//       serializers.serialize(object.used,
//           specifiedType:
//               const FullType(BuiltList, const [const FullType(String)])),
//       'description',
//       serializers.serialize(object.description,
//           specifiedType: const FullType(String)),
//       'global',
//       serializers.serialize(object.global, specifiedType: const FullType(bool)),
//       'unlimited',
//       serializers.serialize(object.unlimited,
//           specifiedType: const FullType(bool)),
//       'amount',
//       serializers.serialize(object.amount, specifiedType: const FullType(bool)),
//       'value',
//       serializers.serialize(object.value,
//           specifiedType: const FullType(double)),
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
//   OfferRecord deserialize(Serializers serializers, Iterable<Object?> serialized,
//       {FullType specifiedType = FullType.unspecified}) {
//     final result = new OfferRecordBuilder();
//
//     final iterator = serialized.iterator;
//     while (iterator.moveNext()) {
//       final key = iterator.current! as String;
//       iterator.moveNext();
//       final Object? value = iterator.current;
//       switch (key) {
//         case 'expiryDate':
//           result.expiryDate = serializers.deserialize(value,
//               specifiedType: const FullType(Timestamp))! as Timestamp;
//           break;
//         case 'userId':
//           result.userId.replace(serializers.deserialize(value,
//                   specifiedType: const FullType(
//                       BuiltList, const [const FullType(String)]))!
//               as BuiltList<Object?>);
//           break;
//         case 'search':
//           result.search.replace(serializers.deserialize(value,
//                   specifiedType: const FullType(
//                       BuiltList, const [const FullType(String)]))!
//               as BuiltList<Object?>);
//           break;
//         case 'shopId':
//           result.shopId = serializers.deserialize(value,
//               specifiedType: const FullType(String))! as String;
//           break;
//         case 'productId':
//           result.productId = serializers.deserialize(value,
//               specifiedType: const FullType(String))! as String;
//           break;
//         case 'categoryId':
//           result.categoryId = serializers.deserialize(value,
//               specifiedType: const FullType(String))! as String;
//           break;
//         case 'title':
//           result.title = serializers.deserialize(value,
//               specifiedType: const FullType(String))! as String;
//           break;
//         case 'code':
//           result.code = serializers.deserialize(value,
//               specifiedType: const FullType(String))! as String;
//           break;
//         case 'used':
//           result.used.replace(serializers.deserialize(value,
//                   specifiedType: const FullType(
//                       BuiltList, const [const FullType(String)]))!
//               as BuiltList<Object?>);
//           break;
//         case 'description':
//           result.description = serializers.deserialize(value,
//               specifiedType: const FullType(String))! as String;
//           break;
//         case 'global':
//           result.global = serializers.deserialize(value,
//               specifiedType: const FullType(bool))! as bool;
//           break;
//         case 'unlimited':
//           result.unlimited = serializers.deserialize(value,
//               specifiedType: const FullType(bool))! as bool;
//           break;
//         case 'amount':
//           result.amount = serializers.deserialize(value,
//               specifiedType: const FullType(bool))! as bool;
//           break;
//         case 'value':
//           result.value = serializers.deserialize(value,
//               specifiedType: const FullType(double))! as double;
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
// class _$OfferRecord extends OfferRecord {
//   @override
//   final Timestamp expiryDate;
//   @override
//   final BuiltList<String> userId;
//   @override
//   final BuiltList<String> search;
//   @override
//   final String shopId;
//   @override
//   final String productId;
//   @override
//   final String categoryId;
//   @override
//   final String title;
//   @override
//   final String code;
//   @override
//   final BuiltList<String> used;
//   @override
//   final String description;
//   @override
//   final bool global;
//   @override
//   final bool unlimited;
//   @override
//   final bool amount;
//   @override
//   final double value;
//   @override
//   final DocumentReference<Object?> reference;
//
//   factory _$OfferRecord([void Function(OfferRecordBuilder)? updates]) =>
//       (new OfferRecordBuilder()..update(updates))._build();
//
//   _$OfferRecord._(
//       {required this.expiryDate,
//       required this.userId,
//       required this.search,
//       required this.shopId,
//       required this.productId,
//       required this.categoryId,
//       required this.title,
//       required this.code,
//       required this.used,
//       required this.description,
//       required this.global,
//       required this.unlimited,
//       required this.amount,
//       required this.value,
//       required this.reference})
//       : super._() {
//     BuiltValueNullFieldError.checkNotNull(
//         expiryDate, r'OfferRecord', 'expiryDate');
//     BuiltValueNullFieldError.checkNotNull(userId, r'OfferRecord', 'userId');
//     BuiltValueNullFieldError.checkNotNull(search, r'OfferRecord', 'search');
//     BuiltValueNullFieldError.checkNotNull(shopId, r'OfferRecord', 'shopId');
//     BuiltValueNullFieldError.checkNotNull(
//         productId, r'OfferRecord', 'productId');
//     BuiltValueNullFieldError.checkNotNull(
//         categoryId, r'OfferRecord', 'categoryId');
//     BuiltValueNullFieldError.checkNotNull(title, r'OfferRecord', 'title');
//     BuiltValueNullFieldError.checkNotNull(code, r'OfferRecord', 'code');
//     BuiltValueNullFieldError.checkNotNull(used, r'OfferRecord', 'used');
//     BuiltValueNullFieldError.checkNotNull(
//         description, r'OfferRecord', 'description');
//     BuiltValueNullFieldError.checkNotNull(global, r'OfferRecord', 'global');
//     BuiltValueNullFieldError.checkNotNull(
//         unlimited, r'OfferRecord', 'unlimited');
//     BuiltValueNullFieldError.checkNotNull(amount, r'OfferRecord', 'amount');
//     BuiltValueNullFieldError.checkNotNull(value, r'OfferRecord', 'value');
//     BuiltValueNullFieldError.checkNotNull(
//         reference, r'OfferRecord', 'reference');
//   }
//
//   @override
//   OfferRecord rebuild(void Function(OfferRecordBuilder) updates) =>
//       (toBuilder()..update(updates)).build();
//
//   @override
//   OfferRecordBuilder toBuilder() => new OfferRecordBuilder()..replace(this);
//
//   @override
//   bool operator ==(Object other) {
//     if (identical(other, this)) return true;
//     return other is OfferRecord &&
//         expiryDate == other.expiryDate &&
//         userId == other.userId &&
//         search == other.search &&
//         shopId == other.shopId &&
//         productId == other.productId &&
//         categoryId == other.categoryId &&
//         title == other.title &&
//         code == other.code &&
//         used == other.used &&
//         description == other.description &&
//         global == other.global &&
//         unlimited == other.unlimited &&
//         amount == other.amount &&
//         value == other.value &&
//         reference == other.reference;
//   }
//
//   @override
//   int get hashCode {
//     var _$hash = 0;
//     _$hash = $jc(_$hash, expiryDate.hashCode);
//     _$hash = $jc(_$hash, userId.hashCode);
//     _$hash = $jc(_$hash, search.hashCode);
//     _$hash = $jc(_$hash, shopId.hashCode);
//     _$hash = $jc(_$hash, productId.hashCode);
//     _$hash = $jc(_$hash, categoryId.hashCode);
//     _$hash = $jc(_$hash, title.hashCode);
//     _$hash = $jc(_$hash, code.hashCode);
//     _$hash = $jc(_$hash, used.hashCode);
//     _$hash = $jc(_$hash, description.hashCode);
//     _$hash = $jc(_$hash, global.hashCode);
//     _$hash = $jc(_$hash, unlimited.hashCode);
//     _$hash = $jc(_$hash, amount.hashCode);
//     _$hash = $jc(_$hash, value.hashCode);
//     _$hash = $jc(_$hash, reference.hashCode);
//     _$hash = $jf(_$hash);
//     return _$hash;
//   }
//
//   @override
//   String toString() {
//     return (newBuiltValueToStringHelper(r'OfferRecord')
//           ..add('expiryDate', expiryDate)
//           ..add('userId', userId)
//           ..add('search', search)
//           ..add('shopId', shopId)
//           ..add('productId', productId)
//           ..add('categoryId', categoryId)
//           ..add('title', title)
//           ..add('code', code)
//           ..add('used', used)
//           ..add('description', description)
//           ..add('global', global)
//           ..add('unlimited', unlimited)
//           ..add('amount', amount)
//           ..add('value', value)
//           ..add('reference', reference))
//         .toString();
//   }
// }
//
// class OfferRecordBuilder implements Builder<OfferRecord, OfferRecordBuilder> {
//   _$OfferRecord? _$v;
//
//   Timestamp? _expiryDate;
//   Timestamp? get expiryDate => _$this._expiryDate;
//   set expiryDate(Timestamp? expiryDate) => _$this._expiryDate = expiryDate;
//
//   ListBuilder<String>? _userId;
//   ListBuilder<String> get userId =>
//       _$this._userId ??= new ListBuilder<String>();
//   set userId(ListBuilder<String>? userId) => _$this._userId = userId;
//
//   ListBuilder<String>? _search;
//   ListBuilder<String> get search =>
//       _$this._search ??= new ListBuilder<String>();
//   set search(ListBuilder<String>? search) => _$this._search = search;
//
//   String? _shopId;
//   String? get shopId => _$this._shopId;
//   set shopId(String? shopId) => _$this._shopId = shopId;
//
//   String? _productId;
//   String? get productId => _$this._productId;
//   set productId(String? productId) => _$this._productId = productId;
//
//   String? _categoryId;
//   String? get categoryId => _$this._categoryId;
//   set categoryId(String? categoryId) => _$this._categoryId = categoryId;
//
//   String? _title;
//   String? get title => _$this._title;
//   set title(String? title) => _$this._title = title;
//
//   String? _code;
//   String? get code => _$this._code;
//   set code(String? code) => _$this._code = code;
//
//   ListBuilder<String>? _used;
//   ListBuilder<String> get used => _$this._used ??= new ListBuilder<String>();
//   set used(ListBuilder<String>? used) => _$this._used = used;
//
//   String? _description;
//   String? get description => _$this._description;
//   set description(String? description) => _$this._description = description;
//
//   bool? _global;
//   bool? get global => _$this._global;
//   set global(bool? global) => _$this._global = global;
//
//   bool? _unlimited;
//   bool? get unlimited => _$this._unlimited;
//   set unlimited(bool? unlimited) => _$this._unlimited = unlimited;
//
//   bool? _amount;
//   bool? get amount => _$this._amount;
//   set amount(bool? amount) => _$this._amount = amount;
//
//   double? _value;
//   double? get value => _$this._value;
//   set value(double? value) => _$this._value = value;
//
//   DocumentReference<Object?>? _reference;
//   DocumentReference<Object?>? get reference => _$this._reference;
//   set reference(DocumentReference<Object?>? reference) =>
//       _$this._reference = reference;
//
//   OfferRecordBuilder() {
//     OfferRecord._initializeBuilder(this);
//   }
//
//   OfferRecordBuilder get _$this {
//     final $v = _$v;
//     if ($v != null) {
//       _expiryDate = $v.expiryDate;
//       _userId = $v.userId.toBuilder();
//       _search = $v.search.toBuilder();
//       _shopId = $v.shopId;
//       _productId = $v.productId;
//       _categoryId = $v.categoryId;
//       _title = $v.title;
//       _code = $v.code;
//       _used = $v.used.toBuilder();
//       _description = $v.description;
//       _global = $v.global;
//       _unlimited = $v.unlimited;
//       _amount = $v.amount;
//       _value = $v.value;
//       _reference = $v.reference;
//       _$v = null;
//     }
//     return this;
//   }
//
//   @override
//   void replace(OfferRecord other) {
//     ArgumentError.checkNotNull(other, 'other');
//     _$v = other as _$OfferRecord;
//   }
//
//   @override
//   void update(void Function(OfferRecordBuilder)? updates) {
//     if (updates != null) updates(this);
//   }
//
//   @override
//   OfferRecord build() => _build();
//
//   _$OfferRecord _build() {
//     _$OfferRecord _$result;
//     try {
//       _$result = _$v ??
//           new _$OfferRecord._(
//               expiryDate: BuiltValueNullFieldError.checkNotNull(
//                   expiryDate, r'OfferRecord', 'expiryDate'),
//               userId: userId.build(),
//               search: search.build(),
//               shopId: BuiltValueNullFieldError.checkNotNull(
//                   shopId, r'OfferRecord', 'shopId'),
//               productId: BuiltValueNullFieldError.checkNotNull(
//                   productId, r'OfferRecord', 'productId'),
//               categoryId: BuiltValueNullFieldError.checkNotNull(
//                   categoryId, r'OfferRecord', 'categoryId'),
//               title: BuiltValueNullFieldError.checkNotNull(
//                   title, r'OfferRecord', 'title'),
//               code: BuiltValueNullFieldError.checkNotNull(
//                   code, r'OfferRecord', 'code'),
//               used: used.build(),
//               description: BuiltValueNullFieldError.checkNotNull(
//                   description, r'OfferRecord', 'description'),
//               global: BuiltValueNullFieldError.checkNotNull(
//                   global, r'OfferRecord', 'global'),
//               unlimited: BuiltValueNullFieldError.checkNotNull(
//                   unlimited, r'OfferRecord', 'unlimited'),
//               amount: BuiltValueNullFieldError.checkNotNull(amount, r'OfferRecord', 'amount'),
//               value: BuiltValueNullFieldError.checkNotNull(value, r'OfferRecord', 'value'),
//               reference: BuiltValueNullFieldError.checkNotNull(reference, r'OfferRecord', 'reference'));
//     } catch (_) {
//       late String _$failedField;
//       try {
//         _$failedField = 'userId';
//         userId.build();
//         _$failedField = 'search';
//         search.build();
//
//         _$failedField = 'used';
//         used.build();
//       } catch (e) {
//         throw new BuiltValueNestedFieldError(
//             r'OfferRecord', _$failedField, e.toString());
//       }
//       rethrow;
//     }
//     replace(_$result);
//     return _$result;
//   }
// }
//
// // ignore_for_file: deprecated_member_use_from_same_package,type=lint
