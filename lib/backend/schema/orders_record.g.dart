// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'orders_record.dart';
//
// // **************************************************************************
// // BuiltValueGenerator
// // **************************************************************************
//
// Serializer<OrdersRecord> _$ordersRecordSerializer =
//     new _$OrdersRecordSerializer();
//
// class _$OrdersRecordSerializer implements StructuredSerializer<OrdersRecord> {
//   @override
//   final Iterable<Type> types = const [OrdersRecord, _$OrdersRecord];
//   @override
//   final String wireName = 'OrdersRecord';
//
//   @override
//   Iterable<Object?> serialize(Serializers serializers, OrdersRecord object,
//       {FullType specifiedType = FullType.unspecified}) {
//     final result = <Object?>[
//       'paymentCard',
//       serializers.serialize(object.paymentCard,
//           specifiedType: const FullType(String)),
//       'placedDate',
//       serializers.serialize(object.placedDate,
//           specifiedType: const FullType(Timestamp)),
//       'cancelledDate',
//       serializers.serialize(object.cancelledDate,
//           specifiedType: const FullType(Timestamp)),
//       'acceptedDate',
//       serializers.serialize(object.acceptedDate,
//           specifiedType: const FullType(Timestamp)),
//       'shippedDate',
//       serializers.serialize(object.shippedDate,
//           specifiedType: const FullType(Timestamp)),
//       'deliveredDate',
//       serializers.serialize(object.deliveredDate,
//           specifiedType: const FullType(Timestamp)),
//       'price',
//       serializers.serialize(object.price,
//           specifiedType: const FullType(double)),
//       'shippingMethod',
//       serializers.serialize(object.shippingMethod,
//           specifiedType: const FullType(String)),
//       'userId',
//       serializers.serialize(object.userId,
//           specifiedType: const FullType(String)),
//       'items',
//       serializers.serialize(object.items,
//           specifiedType:
//               const FullType(BuiltList, const [const FullType(OrderItems)])),
//       'shops',
//       serializers.serialize(object.shops,
//           specifiedType:
//               const FullType(BuiltList, const [const FullType(String)])),
//       'shippingAddress',
//       serializers.serialize(object.shippingAddress,
//           specifiedType: const FullType(BuiltMap,
//               const [const FullType(String), const FullType(String)])),
//       'orderStatus',
//       serializers.serialize(object.orderStatus,
//           specifiedType: const FullType(int)),
//       'deliveryCharge',
//       serializers.serialize(object.deliveryCharge,
//           specifiedType: const FullType(double)),
//       'tip',
//       serializers.serialize(object.tip, specifiedType: const FullType(double)),
//       'promoDiscount',
//       serializers.serialize(object.promoDiscount,
//           specifiedType: const FullType(double)),
//       'promoCode',
//       serializers.serialize(object.promoCode,
//           specifiedType: const FullType(String)),
//       'driverName',
//       serializers.serialize(object.driverName,
//           specifiedType: const FullType(String)),
//       'driverId',
//       serializers.serialize(object.driverId,
//           specifiedType: const FullType(String)),
//       'deliveryPin',
//       serializers.serialize(object.deliveryPin,
//           specifiedType: const FullType(String)),
//       'branchId',
//       serializers.serialize(object.branchId,
//           specifiedType: const FullType(String)),
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
//   OrdersRecord deserialize(
//       Serializers serializers, Iterable<Object?> serialized,
//       {FullType specifiedType = FullType.unspecified}) {
//     final result = new OrdersRecordBuilder();
//
//     final iterator = serialized.iterator;
//     while (iterator.moveNext()) {
//       final key = iterator.current! as String;
//       iterator.moveNext();
//       final Object? value = iterator.current;
//       switch (key) {
//         case 'paymentCard':
//           result.paymentCard = serializers.deserialize(value,
//               specifiedType: const FullType(String))! as String;
//           break;
//         case 'placedDate':
//           result.placedDate = serializers.deserialize(value,
//               specifiedType: const FullType(Timestamp))! as Timestamp;
//           break;
//         case 'cancelledDate':
//           result.cancelledDate = serializers.deserialize(value,
//               specifiedType: const FullType(Timestamp))! as Timestamp;
//           break;
//         case 'acceptedDate':
//           result.acceptedDate = serializers.deserialize(value,
//               specifiedType: const FullType(Timestamp))! as Timestamp;
//           break;
//         case 'shippedDate':
//           result.shippedDate = serializers.deserialize(value,
//               specifiedType: const FullType(Timestamp))! as Timestamp;
//           break;
//         case 'deliveredDate':
//           result.deliveredDate = serializers.deserialize(value,
//               specifiedType: const FullType(Timestamp))! as Timestamp;
//           break;
//         case 'price':
//           result.price = serializers.deserialize(value,
//               specifiedType: const FullType(double))! as double;
//           break;
//         case 'shippingMethod':
//           result.shippingMethod = serializers.deserialize(value,
//               specifiedType: const FullType(String))! as String;
//           break;
//         case 'userId':
//           result.userId = serializers.deserialize(value,
//               specifiedType: const FullType(String))! as String;
//           break;
//         case 'items':
//           result.items.replace(serializers.deserialize(value,
//                   specifiedType: const FullType(
//                       BuiltList, const [const FullType(OrderItems)]))!
//               as BuiltList<Object?>);
//           break;
//         case 'shops':
//           result.shops.replace(serializers.deserialize(value,
//                   specifiedType: const FullType(
//                       BuiltList, const [const FullType(String)]))!
//               as BuiltList<Object?>);
//           break;
//         case 'shippingAddress':
//           result.shippingAddress.replace(serializers.deserialize(value,
//               specifiedType: const FullType(BuiltMap,
//                   const [const FullType(String), const FullType(String)]))!);
//           break;
//         case 'orderStatus':
//           result.orderStatus = serializers.deserialize(value,
//               specifiedType: const FullType(int))! as int;
//           break;
//         case 'deliveryCharge':
//           result.deliveryCharge = serializers.deserialize(value,
//               specifiedType: const FullType(double))! as double;
//           break;
//         case 'tip':
//           result.tip = serializers.deserialize(value,
//               specifiedType: const FullType(double))! as double;
//           break;
//         case 'promoDiscount':
//           result.promoDiscount = serializers.deserialize(value,
//               specifiedType: const FullType(double))! as double;
//           break;
//         case 'promoCode':
//           result.promoCode = serializers.deserialize(value,
//               specifiedType: const FullType(String))! as String;
//           break;
//         case 'driverName':
//           result.driverName = serializers.deserialize(value,
//               specifiedType: const FullType(String))! as String;
//           break;
//         case 'driverId':
//           result.driverId = serializers.deserialize(value,
//               specifiedType: const FullType(String))! as String;
//           break;
//         case 'deliveryPin':
//           result.deliveryPin = serializers.deserialize(value,
//               specifiedType: const FullType(String))! as String;
//           break;
//         case 'branchId':
//           result.branchId = serializers.deserialize(value,
//               specifiedType: const FullType(String))! as String;
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
// class _$OrdersRecord extends OrdersRecord {
//   @override
//   final String paymentCard;
//   @override
//   final Timestamp placedDate;
//   @override
//   final Timestamp cancelledDate;
//   @override
//   final Timestamp acceptedDate;
//   @override
//   final Timestamp shippedDate;
//   @override
//   final Timestamp deliveredDate;
//   @override
//   final double price;
//   @override
//   final String shippingMethod;
//   @override
//   final String userId;
//   @override
//   final BuiltList<OrderItems> items;
//   @override
//   final BuiltList<String> shops;
//   @override
//   final BuiltMap<String, String> shippingAddress;
//   @override
//   final int orderStatus;
//   @override
//   final double deliveryCharge;
//   @override
//   final double tip;
//   @override
//   final double promoDiscount;
//   @override
//   final String promoCode;
//   @override
//   final String driverName;
//   @override
//   final String driverId;
//   @override
//   final String deliveryPin;
//   @override
//   final String branchId;
//   @override
//   final DocumentReference<Object?> reference;
//
//   factory _$OrdersRecord([void Function(OrdersRecordBuilder)? updates]) =>
//       (new OrdersRecordBuilder()..update(updates))._build();
//
//   _$OrdersRecord._(
//       {required this.paymentCard,
//       required this.placedDate,
//       required this.cancelledDate,
//       required this.acceptedDate,
//       required this.shippedDate,
//       required this.deliveredDate,
//       required this.price,
//       required this.shippingMethod,
//       required this.userId,
//       required this.items,
//       required this.shops,
//       required this.shippingAddress,
//       required this.orderStatus,
//       required this.deliveryCharge,
//       required this.tip,
//       required this.promoDiscount,
//       required this.promoCode,
//       required this.driverName,
//       required this.driverId,
//       required this.deliveryPin,
//       required this.branchId,
//       required this.reference})
//       : super._() {
//     BuiltValueNullFieldError.checkNotNull(
//         paymentCard, r'OrdersRecord', 'paymentCard');
//     BuiltValueNullFieldError.checkNotNull(
//         placedDate, r'OrdersRecord', 'placedDate');
//     BuiltValueNullFieldError.checkNotNull(
//         cancelledDate, r'OrdersRecord', 'cancelledDate');
//     BuiltValueNullFieldError.checkNotNull(
//         acceptedDate, r'OrdersRecord', 'acceptedDate');
//     BuiltValueNullFieldError.checkNotNull(
//         shippedDate, r'OrdersRecord', 'shippedDate');
//     BuiltValueNullFieldError.checkNotNull(
//         deliveredDate, r'OrdersRecord', 'deliveredDate');
//     BuiltValueNullFieldError.checkNotNull(price, r'OrdersRecord', 'price');
//     BuiltValueNullFieldError.checkNotNull(
//         shippingMethod, r'OrdersRecord', 'shippingMethod');
//     BuiltValueNullFieldError.checkNotNull(userId, r'OrdersRecord', 'userId');
//     BuiltValueNullFieldError.checkNotNull(items, r'OrdersRecord', 'items');
//     BuiltValueNullFieldError.checkNotNull(shops, r'OrdersRecord', 'shops');
//     BuiltValueNullFieldError.checkNotNull(
//         shippingAddress, r'OrdersRecord', 'shippingAddress');
//     BuiltValueNullFieldError.checkNotNull(
//         orderStatus, r'OrdersRecord', 'orderStatus');
//     BuiltValueNullFieldError.checkNotNull(
//         deliveryCharge, r'OrdersRecord', 'deliveryCharge');
//     BuiltValueNullFieldError.checkNotNull(tip, r'OrdersRecord', 'tip');
//     BuiltValueNullFieldError.checkNotNull(
//         promoDiscount, r'OrdersRecord', 'promoDiscount');
//     BuiltValueNullFieldError.checkNotNull(
//         promoCode, r'OrdersRecord', 'promoCode');
//     BuiltValueNullFieldError.checkNotNull(
//         driverName, r'OrdersRecord', 'driverName');
//     BuiltValueNullFieldError.checkNotNull(
//         driverId, r'OrdersRecord', 'driverId');
//     BuiltValueNullFieldError.checkNotNull(
//         deliveryPin, r'OrdersRecord', 'deliveryPin');
//     BuiltValueNullFieldError.checkNotNull(
//         branchId, r'OrdersRecord', 'branchId');
//     BuiltValueNullFieldError.checkNotNull(
//         reference, r'OrdersRecord', 'reference');
//   }
//
//   @override
//   OrdersRecord rebuild(void Function(OrdersRecordBuilder) updates) =>
//       (toBuilder()..update(updates)).build();
//
//   @override
//   OrdersRecordBuilder toBuilder() => new OrdersRecordBuilder()..replace(this);
//
//   @override
//   bool operator ==(Object other) {
//     if (identical(other, this)) return true;
//     return other is OrdersRecord &&
//         paymentCard == other.paymentCard &&
//         placedDate == other.placedDate &&
//         cancelledDate == other.cancelledDate &&
//         acceptedDate == other.acceptedDate &&
//         shippedDate == other.shippedDate &&
//         deliveredDate == other.deliveredDate &&
//         price == other.price &&
//         shippingMethod == other.shippingMethod &&
//         userId == other.userId &&
//         items == other.items &&
//         shops == other.shops &&
//         shippingAddress == other.shippingAddress &&
//         orderStatus == other.orderStatus &&
//         deliveryCharge == other.deliveryCharge &&
//         tip == other.tip &&
//         promoDiscount == other.promoDiscount &&
//         promoCode == other.promoCode &&
//         driverName == other.driverName &&
//         driverId == other.driverId &&
//         deliveryPin == other.deliveryPin &&
//         branchId == other.branchId &&
//         reference == other.reference;
//   }
//
//   @override
//   int get hashCode {
//     var _$hash = 0;
//     _$hash = $jc(_$hash, paymentCard.hashCode);
//     _$hash = $jc(_$hash, placedDate.hashCode);
//     _$hash = $jc(_$hash, cancelledDate.hashCode);
//     _$hash = $jc(_$hash, acceptedDate.hashCode);
//     _$hash = $jc(_$hash, shippedDate.hashCode);
//     _$hash = $jc(_$hash, deliveredDate.hashCode);
//     _$hash = $jc(_$hash, price.hashCode);
//     _$hash = $jc(_$hash, shippingMethod.hashCode);
//     _$hash = $jc(_$hash, userId.hashCode);
//     _$hash = $jc(_$hash, items.hashCode);
//     _$hash = $jc(_$hash, shops.hashCode);
//     _$hash = $jc(_$hash, shippingAddress.hashCode);
//     _$hash = $jc(_$hash, orderStatus.hashCode);
//     _$hash = $jc(_$hash, deliveryCharge.hashCode);
//     _$hash = $jc(_$hash, tip.hashCode);
//     _$hash = $jc(_$hash, promoDiscount.hashCode);
//     _$hash = $jc(_$hash, promoCode.hashCode);
//     _$hash = $jc(_$hash, driverName.hashCode);
//     _$hash = $jc(_$hash, driverId.hashCode);
//     _$hash = $jc(_$hash, deliveryPin.hashCode);
//     _$hash = $jc(_$hash, branchId.hashCode);
//     _$hash = $jc(_$hash, reference.hashCode);
//     _$hash = $jf(_$hash);
//     return _$hash;
//   }
//
//   @override
//   String toString() {
//     return (newBuiltValueToStringHelper(r'OrdersRecord')
//           ..add('paymentCard', paymentCard)
//           ..add('placedDate', placedDate)
//           ..add('cancelledDate', cancelledDate)
//           ..add('acceptedDate', acceptedDate)
//           ..add('shippedDate', shippedDate)
//           ..add('deliveredDate', deliveredDate)
//           ..add('price', price)
//           ..add('shippingMethod', shippingMethod)
//           ..add('userId', userId)
//           ..add('items', items)
//           ..add('shops', shops)
//           ..add('shippingAddress', shippingAddress)
//           ..add('orderStatus', orderStatus)
//           ..add('deliveryCharge', deliveryCharge)
//           ..add('tip', tip)
//           ..add('promoDiscount', promoDiscount)
//           ..add('promoCode', promoCode)
//           ..add('driverName', driverName)
//           ..add('driverId', driverId)
//           ..add('deliveryPin', deliveryPin)
//           ..add('branchId', branchId)
//           ..add('reference', reference))
//         .toString();
//   }
// }
//
// class OrdersRecordBuilder
//     implements Builder<OrdersRecord, OrdersRecordBuilder> {
//   _$OrdersRecord? _$v;
//
//   String? _paymentCard;
//   String? get paymentCard => _$this._paymentCard;
//   set paymentCard(String? paymentCard) => _$this._paymentCard = paymentCard;
//
//   Timestamp? _placedDate;
//   Timestamp? get placedDate => _$this._placedDate;
//   set placedDate(Timestamp? placedDate) => _$this._placedDate = placedDate;
//
//   Timestamp? _cancelledDate;
//   Timestamp? get cancelledDate => _$this._cancelledDate;
//   set cancelledDate(Timestamp? cancelledDate) =>
//       _$this._cancelledDate = cancelledDate;
//
//   Timestamp? _acceptedDate;
//   Timestamp? get acceptedDate => _$this._acceptedDate;
//   set acceptedDate(Timestamp? acceptedDate) =>
//       _$this._acceptedDate = acceptedDate;
//
//   Timestamp? _shippedDate;
//   Timestamp? get shippedDate => _$this._shippedDate;
//   set shippedDate(Timestamp? shippedDate) => _$this._shippedDate = shippedDate;
//
//   Timestamp? _deliveredDate;
//   Timestamp? get deliveredDate => _$this._deliveredDate;
//   set deliveredDate(Timestamp? deliveredDate) =>
//       _$this._deliveredDate = deliveredDate;
//
//   double? _price;
//   double? get price => _$this._price;
//   set price(double? price) => _$this._price = price;
//
//   String? _shippingMethod;
//   String? get shippingMethod => _$this._shippingMethod;
//   set shippingMethod(String? shippingMethod) =>
//       _$this._shippingMethod = shippingMethod;
//
//   String? _userId;
//   String? get userId => _$this._userId;
//   set userId(String? userId) => _$this._userId = userId;
//
//   ListBuilder<OrderItems>? _items;
//   ListBuilder<OrderItems> get items =>
//       _$this._items ??= new ListBuilder<OrderItems>();
//   set items(ListBuilder<OrderItems>? items) => _$this._items = items;
//
//   ListBuilder<String>? _shops;
//   ListBuilder<String> get shops => _$this._shops ??= new ListBuilder<String>();
//   set shops(ListBuilder<String>? shops) => _$this._shops = shops;
//
//   MapBuilder<String, String>? _shippingAddress;
//   MapBuilder<String, String> get shippingAddress =>
//       _$this._shippingAddress ??= new MapBuilder<String, String>();
//   set shippingAddress(MapBuilder<String, String>? shippingAddress) =>
//       _$this._shippingAddress = shippingAddress;
//
//   int? _orderStatus;
//   int? get orderStatus => _$this._orderStatus;
//   set orderStatus(int? orderStatus) => _$this._orderStatus = orderStatus;
//
//   double? _deliveryCharge;
//   double? get deliveryCharge => _$this._deliveryCharge;
//   set deliveryCharge(double? deliveryCharge) =>
//       _$this._deliveryCharge = deliveryCharge;
//
//   double? _tip;
//   double? get tip => _$this._tip;
//   set tip(double? tip) => _$this._tip = tip;
//
//   double? _promoDiscount;
//   double? get promoDiscount => _$this._promoDiscount;
//   set promoDiscount(double? promoDiscount) =>
//       _$this._promoDiscount = promoDiscount;
//
//   String? _promoCode;
//   String? get promoCode => _$this._promoCode;
//   set promoCode(String? promoCode) => _$this._promoCode = promoCode;
//
//   String? _driverName;
//   String? get driverName => _$this._driverName;
//   set driverName(String? driverName) => _$this._driverName = driverName;
//
//   String? _driverId;
//   String? get driverId => _$this._driverId;
//   set driverId(String? driverId) => _$this._driverId = driverId;
//
//   String? _deliveryPin;
//   String? get deliveryPin => _$this._deliveryPin;
//   set deliveryPin(String? deliveryPin) => _$this._deliveryPin = deliveryPin;
//
//   String? _branchId;
//   String? get branchId => _$this._branchId;
//   set branchId(String? branchId) => _$this._branchId = branchId;
//
//   DocumentReference<Object?>? _reference;
//   DocumentReference<Object?>? get reference => _$this._reference;
//   set reference(DocumentReference<Object?>? reference) =>
//       _$this._reference = reference;
//
//   OrdersRecordBuilder() {
//     OrdersRecord._initializeBuilder(this);
//   }
//
//   OrdersRecordBuilder get _$this {
//     final $v = _$v;
//     if ($v != null) {
//       _paymentCard = $v.paymentCard;
//       _placedDate = $v.placedDate;
//       _cancelledDate = $v.cancelledDate;
//       _acceptedDate = $v.acceptedDate;
//       _shippedDate = $v.shippedDate;
//       _deliveredDate = $v.deliveredDate;
//       _price = $v.price;
//       _shippingMethod = $v.shippingMethod;
//       _userId = $v.userId;
//       _items = $v.items.toBuilder();
//       _shops = $v.shops.toBuilder();
//       _shippingAddress = $v.shippingAddress.toBuilder();
//       _orderStatus = $v.orderStatus;
//       _deliveryCharge = $v.deliveryCharge;
//       _tip = $v.tip;
//       _promoDiscount = $v.promoDiscount;
//       _promoCode = $v.promoCode;
//       _driverName = $v.driverName;
//       _driverId = $v.driverId;
//       _deliveryPin = $v.deliveryPin;
//       _branchId = $v.branchId;
//       _reference = $v.reference;
//       _$v = null;
//     }
//     return this;
//   }
//
//   @override
//   void replace(OrdersRecord other) {
//     ArgumentError.checkNotNull(other, 'other');
//     _$v = other as _$OrdersRecord;
//   }
//
//   @override
//   void update(void Function(OrdersRecordBuilder)? updates) {
//     if (updates != null) updates(this);
//   }
//
//   @override
//   OrdersRecord build() => _build();
//
//   _$OrdersRecord _build() {
//     _$OrdersRecord _$result;
//     try {
//       _$result = _$v ??
//           new _$OrdersRecord._(
//               paymentCard: BuiltValueNullFieldError.checkNotNull(
//                   paymentCard, r'OrdersRecord', 'paymentCard'),
//               placedDate: BuiltValueNullFieldError.checkNotNull(
//                   placedDate, r'OrdersRecord', 'placedDate'),
//               cancelledDate: BuiltValueNullFieldError.checkNotNull(
//                   cancelledDate, r'OrdersRecord', 'cancelledDate'),
//               acceptedDate: BuiltValueNullFieldError.checkNotNull(
//                   acceptedDate, r'OrdersRecord', 'acceptedDate'),
//               shippedDate: BuiltValueNullFieldError.checkNotNull(
//                   shippedDate, r'OrdersRecord', 'shippedDate'),
//               deliveredDate: BuiltValueNullFieldError.checkNotNull(
//                   deliveredDate, r'OrdersRecord', 'deliveredDate'),
//               price: BuiltValueNullFieldError.checkNotNull(
//                   price, r'OrdersRecord', 'price'),
//               shippingMethod:
//                   BuiltValueNullFieldError.checkNotNull(shippingMethod, r'OrdersRecord', 'shippingMethod'),
//               userId: BuiltValueNullFieldError.checkNotNull(userId, r'OrdersRecord', 'userId'),
//               items: items.build(),
//               shops: shops.build(),
//               shippingAddress: shippingAddress.build(),
//               orderStatus: BuiltValueNullFieldError.checkNotNull(orderStatus, r'OrdersRecord', 'orderStatus'),
//               deliveryCharge: BuiltValueNullFieldError.checkNotNull(deliveryCharge, r'OrdersRecord', 'deliveryCharge'),
//               tip: BuiltValueNullFieldError.checkNotNull(tip, r'OrdersRecord', 'tip'),
//               promoDiscount: BuiltValueNullFieldError.checkNotNull(promoDiscount, r'OrdersRecord', 'promoDiscount'),
//               promoCode: BuiltValueNullFieldError.checkNotNull(promoCode, r'OrdersRecord', 'promoCode'),
//               driverName: BuiltValueNullFieldError.checkNotNull(driverName, r'OrdersRecord', 'driverName'),
//               driverId: BuiltValueNullFieldError.checkNotNull(driverId, r'OrdersRecord', 'driverId'),
//               deliveryPin: BuiltValueNullFieldError.checkNotNull(deliveryPin, r'OrdersRecord', 'deliveryPin'),
//               branchId: BuiltValueNullFieldError.checkNotNull(branchId, r'OrdersRecord', 'branchId'),
//               reference: BuiltValueNullFieldError.checkNotNull(reference, r'OrdersRecord', 'reference'));
//     } catch (_) {
//       late String _$failedField;
//       try {
//         _$failedField = 'items';
//         items.build();
//         _$failedField = 'shops';
//         shops.build();
//         _$failedField = 'shippingAddress';
//         shippingAddress.build();
//       } catch (e) {
//         throw new BuiltValueNestedFieldError(
//             r'OrdersRecord', _$failedField, e.toString());
//       }
//       rethrow;
//     }
//     replace(_$result);
//     return _$result;
//   }
// }
//
// // ignore_for_file: deprecated_member_use_from_same_package,type=lint
