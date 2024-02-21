// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shops_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ShopsRecord> _$shopsRecordSerializer = new _$ShopsRecordSerializer();

class _$ShopsRecordSerializer implements StructuredSerializer<ShopsRecord> {
  @override
  final Iterable<Type> types = const [ShopsRecord, _$ShopsRecord];
  @override
  final String wireName = 'ShopsRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, ShopsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'imageUrl',
      serializers.serialize(object.imageUrl,
          specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'shopId',
      serializers.serialize(object.shopId,
          specifiedType: const FullType(String)),
      'address',
      serializers.serialize(object.address,
          specifiedType: const FullType(String)),
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'ones',
      serializers.serialize(object.ones, specifiedType: const FullType(int)),
      'twos',
      serializers.serialize(object.twos, specifiedType: const FullType(int)),
      'threes',
      serializers.serialize(object.threes, specifiedType: const FullType(int)),
      'fours',
      serializers.serialize(object.fours, specifiedType: const FullType(int)),
      'fives',
      serializers.serialize(object.fives, specifiedType: const FullType(int)),
      'sunFrom',
      serializers.serialize(object.sunFrom,
          specifiedType: const FullType(String)),
      'sunTo',
      serializers.serialize(object.sunTo,
          specifiedType: const FullType(String)),
      'monFrom',
      serializers.serialize(object.monFrom,
          specifiedType: const FullType(String)),
      'monTo',
      serializers.serialize(object.monTo,
          specifiedType: const FullType(String)),
      'tueFrom',
      serializers.serialize(object.tueFrom,
          specifiedType: const FullType(String)),
      'tueTo',
      serializers.serialize(object.tueTo,
          specifiedType: const FullType(String)),
      'wedFrom',
      serializers.serialize(object.wedFrom,
          specifiedType: const FullType(String)),
      'wedTo',
      serializers.serialize(object.wedTo,
          specifiedType: const FullType(String)),
      'thuFrom',
      serializers.serialize(object.thuFrom,
          specifiedType: const FullType(String)),
      'thuTo',
      serializers.serialize(object.thuTo,
          specifiedType: const FullType(String)),
      'friFrom',
      serializers.serialize(object.friFrom,
          specifiedType: const FullType(String)),
      'friTo',
      serializers.serialize(object.friTo,
          specifiedType: const FullType(String)),
      'satFrom',
      serializers.serialize(object.satFrom,
          specifiedType: const FullType(String)),
      'satTo',
      serializers.serialize(object.satTo,
          specifiedType: const FullType(String)),
      'FSSAIRegNo',
      serializers.serialize(object.fSSAIRegNo,
          specifiedType: const FullType(String)),
      'users',
      serializers.serialize(object.users,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'phoneNumber',
      serializers.serialize(object.phoneNumber,
          specifiedType: const FullType(String)),
      'search',
      serializers.serialize(object.search,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'admins',
      serializers.serialize(object.admins,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'online',
      serializers.serialize(object.online, specifiedType: const FullType(bool)),
      'discount',
      serializers.serialize(object.discount,
          specifiedType: const FullType(double)),
      'paid',
      serializers.serialize(object.paid, specifiedType: const FullType(double)),
      'sales',
      serializers.serialize(object.sales,
          specifiedType: const FullType(double)),
      'paidUpdate',
      serializers.serialize(object.paidUpdate,
          specifiedType: const FullType(Timestamp)),
      'salesUpdate',
      serializers.serialize(object.salesUpdate,
          specifiedType: const FullType(Timestamp)),
      'branchId',
      serializers.serialize(object.branchId,
          specifiedType: const FullType(String)),
      'latitude',
      serializers.serialize(object.latitude,
          specifiedType: const FullType(double)),
      'longitude',
      serializers.serialize(object.longitude,
          specifiedType: const FullType(double)),
      'Document__Reference__Field',
      serializers.serialize(object.reference,
          specifiedType: const FullType(
              DocumentReference, const [const FullType.nullable(Object)])),
    ];

    return result;
  }

  @override
  ShopsRecord deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ShopsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'imageUrl':
          result.imageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'shopId':
          result.shopId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'address':
          result.address = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'ones':
          result.ones = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'twos':
          result.twos = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'threes':
          result.threes = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'fours':
          result.fours = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'fives':
          result.fives = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'sunFrom':
          result.sunFrom = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'sunTo':
          result.sunTo = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'monFrom':
          result.monFrom = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'monTo':
          result.monTo = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'tueFrom':
          result.tueFrom = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'tueTo':
          result.tueTo = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'wedFrom':
          result.wedFrom = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'wedTo':
          result.wedTo = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'thuFrom':
          result.thuFrom = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'thuTo':
          result.thuTo = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'friFrom':
          result.friFrom = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'friTo':
          result.friTo = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'satFrom':
          result.satFrom = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'satTo':
          result.satTo = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'FSSAIRegNo':
          result.fSSAIRegNo = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'users':
          result.users.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'phoneNumber':
          result.phoneNumber = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'search':
          result.search.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'admins':
          result.admins.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'online':
          result.online = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'discount':
          result.discount = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'paid':
          result.paid = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'sales':
          result.sales = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'paidUpdate':
          result.paidUpdate = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp))! as Timestamp;
          break;
        case 'salesUpdate':
          result.salesUpdate = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp))! as Timestamp;
          break;
        case 'branchId':
          result.branchId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'latitude':
          result.latitude = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'longitude':
          result.longitude = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'Document__Reference__Field':
          result.reference = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ]))! as DocumentReference<Object?>;
          break;
      }
    }

    return result.build();
  }
}

class _$ShopsRecord extends ShopsRecord {
  @override
  final String imageUrl;
  @override
  final String name;
  @override
  final String shopId;
  @override
  final String address;
  @override
  final String email;
  @override
  final int ones;
  @override
  final int twos;
  @override
  final int threes;
  @override
  final int fours;
  @override
  final int fives;
  @override
  final String sunFrom;
  @override
  final String sunTo;
  @override
  final String monFrom;
  @override
  final String monTo;
  @override
  final String tueFrom;
  @override
  final String tueTo;
  @override
  final String wedFrom;
  @override
  final String wedTo;
  @override
  final String thuFrom;
  @override
  final String thuTo;
  @override
  final String friFrom;
  @override
  final String friTo;
  @override
  final String satFrom;
  @override
  final String satTo;
  @override
  final String fSSAIRegNo;
  @override
  final BuiltList<String> users;
  @override
  final String phoneNumber;
  @override
  final BuiltList<String> search;
  @override
  final BuiltList<String> admins;
  @override
  final bool online;
  @override
  final double discount;
  @override
  final double paid;
  @override
  final double sales;
  @override
  final Timestamp paidUpdate;
  @override
  final Timestamp salesUpdate;
  @override
  final String branchId;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final DocumentReference<Object?> reference;

  factory _$ShopsRecord([void Function(ShopsRecordBuilder)? updates]) =>
      (new ShopsRecordBuilder()..update(updates))._build();

  _$ShopsRecord._(
      {required this.imageUrl,
      required this.name,
      required this.shopId,
      required this.address,
      required this.email,
      required this.ones,
      required this.twos,
      required this.threes,
      required this.fours,
      required this.fives,
      required this.sunFrom,
      required this.sunTo,
      required this.monFrom,
      required this.monTo,
      required this.tueFrom,
      required this.tueTo,
      required this.wedFrom,
      required this.wedTo,
      required this.thuFrom,
      required this.thuTo,
      required this.friFrom,
      required this.friTo,
      required this.satFrom,
      required this.satTo,
      required this.fSSAIRegNo,
      required this.users,
      required this.phoneNumber,
      required this.search,
      required this.admins,
      required this.online,
      required this.discount,
      required this.paid,
      required this.sales,
      required this.paidUpdate,
      required this.salesUpdate,
      required this.branchId,
      required this.latitude,
      required this.longitude,
      required this.reference})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(imageUrl, r'ShopsRecord', 'imageUrl');
    BuiltValueNullFieldError.checkNotNull(name, r'ShopsRecord', 'name');
    BuiltValueNullFieldError.checkNotNull(shopId, r'ShopsRecord', 'shopId');
    BuiltValueNullFieldError.checkNotNull(address, r'ShopsRecord', 'address');
    BuiltValueNullFieldError.checkNotNull(email, r'ShopsRecord', 'email');
    BuiltValueNullFieldError.checkNotNull(ones, r'ShopsRecord', 'ones');
    BuiltValueNullFieldError.checkNotNull(twos, r'ShopsRecord', 'twos');
    BuiltValueNullFieldError.checkNotNull(threes, r'ShopsRecord', 'threes');
    BuiltValueNullFieldError.checkNotNull(fours, r'ShopsRecord', 'fours');
    BuiltValueNullFieldError.checkNotNull(fives, r'ShopsRecord', 'fives');
    BuiltValueNullFieldError.checkNotNull(sunFrom, r'ShopsRecord', 'sunFrom');
    BuiltValueNullFieldError.checkNotNull(sunTo, r'ShopsRecord', 'sunTo');
    BuiltValueNullFieldError.checkNotNull(monFrom, r'ShopsRecord', 'monFrom');
    BuiltValueNullFieldError.checkNotNull(monTo, r'ShopsRecord', 'monTo');
    BuiltValueNullFieldError.checkNotNull(tueFrom, r'ShopsRecord', 'tueFrom');
    BuiltValueNullFieldError.checkNotNull(tueTo, r'ShopsRecord', 'tueTo');
    BuiltValueNullFieldError.checkNotNull(wedFrom, r'ShopsRecord', 'wedFrom');
    BuiltValueNullFieldError.checkNotNull(wedTo, r'ShopsRecord', 'wedTo');
    BuiltValueNullFieldError.checkNotNull(thuFrom, r'ShopsRecord', 'thuFrom');
    BuiltValueNullFieldError.checkNotNull(thuTo, r'ShopsRecord', 'thuTo');
    BuiltValueNullFieldError.checkNotNull(friFrom, r'ShopsRecord', 'friFrom');
    BuiltValueNullFieldError.checkNotNull(friTo, r'ShopsRecord', 'friTo');
    BuiltValueNullFieldError.checkNotNull(satFrom, r'ShopsRecord', 'satFrom');
    BuiltValueNullFieldError.checkNotNull(satTo, r'ShopsRecord', 'satTo');
    BuiltValueNullFieldError.checkNotNull(
        fSSAIRegNo, r'ShopsRecord', 'fSSAIRegNo');
    BuiltValueNullFieldError.checkNotNull(users, r'ShopsRecord', 'users');
    BuiltValueNullFieldError.checkNotNull(
        phoneNumber, r'ShopsRecord', 'phoneNumber');
    BuiltValueNullFieldError.checkNotNull(search, r'ShopsRecord', 'search');
    BuiltValueNullFieldError.checkNotNull(admins, r'ShopsRecord', 'admins');
    BuiltValueNullFieldError.checkNotNull(online, r'ShopsRecord', 'online');
    BuiltValueNullFieldError.checkNotNull(discount, r'ShopsRecord', 'discount');
    BuiltValueNullFieldError.checkNotNull(paid, r'ShopsRecord', 'paid');
    BuiltValueNullFieldError.checkNotNull(sales, r'ShopsRecord', 'sales');
    BuiltValueNullFieldError.checkNotNull(
        paidUpdate, r'ShopsRecord', 'paidUpdate');
    BuiltValueNullFieldError.checkNotNull(
        salesUpdate, r'ShopsRecord', 'salesUpdate');
    BuiltValueNullFieldError.checkNotNull(branchId, r'ShopsRecord', 'branchId');
    BuiltValueNullFieldError.checkNotNull(latitude, r'ShopsRecord', 'latitude');
    BuiltValueNullFieldError.checkNotNull(
        longitude, r'ShopsRecord', 'longitude');
    BuiltValueNullFieldError.checkNotNull(
        reference, r'ShopsRecord', 'reference');
  }

  @override
  ShopsRecord rebuild(void Function(ShopsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ShopsRecordBuilder toBuilder() => new ShopsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ShopsRecord &&
        imageUrl == other.imageUrl &&
        name == other.name &&
        shopId == other.shopId &&
        address == other.address &&
        email == other.email &&
        ones == other.ones &&
        twos == other.twos &&
        threes == other.threes &&
        fours == other.fours &&
        fives == other.fives &&
        sunFrom == other.sunFrom &&
        sunTo == other.sunTo &&
        monFrom == other.monFrom &&
        monTo == other.monTo &&
        tueFrom == other.tueFrom &&
        tueTo == other.tueTo &&
        wedFrom == other.wedFrom &&
        wedTo == other.wedTo &&
        thuFrom == other.thuFrom &&
        thuTo == other.thuTo &&
        friFrom == other.friFrom &&
        friTo == other.friTo &&
        satFrom == other.satFrom &&
        satTo == other.satTo &&
        fSSAIRegNo == other.fSSAIRegNo &&
        users == other.users &&
        phoneNumber == other.phoneNumber &&
        search == other.search &&
        admins == other.admins &&
        online == other.online &&
        discount == other.discount &&
        paid == other.paid &&
        sales == other.sales &&
        paidUpdate == other.paidUpdate &&
        salesUpdate == other.salesUpdate &&
        branchId == other.branchId &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, shopId.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, ones.hashCode);
    _$hash = $jc(_$hash, twos.hashCode);
    _$hash = $jc(_$hash, threes.hashCode);
    _$hash = $jc(_$hash, fours.hashCode);
    _$hash = $jc(_$hash, fives.hashCode);
    _$hash = $jc(_$hash, sunFrom.hashCode);
    _$hash = $jc(_$hash, sunTo.hashCode);
    _$hash = $jc(_$hash, monFrom.hashCode);
    _$hash = $jc(_$hash, monTo.hashCode);
    _$hash = $jc(_$hash, tueFrom.hashCode);
    _$hash = $jc(_$hash, tueTo.hashCode);
    _$hash = $jc(_$hash, wedFrom.hashCode);
    _$hash = $jc(_$hash, wedTo.hashCode);
    _$hash = $jc(_$hash, thuFrom.hashCode);
    _$hash = $jc(_$hash, thuTo.hashCode);
    _$hash = $jc(_$hash, friFrom.hashCode);
    _$hash = $jc(_$hash, friTo.hashCode);
    _$hash = $jc(_$hash, satFrom.hashCode);
    _$hash = $jc(_$hash, satTo.hashCode);
    _$hash = $jc(_$hash, fSSAIRegNo.hashCode);
    _$hash = $jc(_$hash, users.hashCode);
    _$hash = $jc(_$hash, phoneNumber.hashCode);
    _$hash = $jc(_$hash, search.hashCode);
    _$hash = $jc(_$hash, admins.hashCode);
    _$hash = $jc(_$hash, online.hashCode);
    _$hash = $jc(_$hash, discount.hashCode);
    _$hash = $jc(_$hash, paid.hashCode);
    _$hash = $jc(_$hash, sales.hashCode);
    _$hash = $jc(_$hash, paidUpdate.hashCode);
    _$hash = $jc(_$hash, salesUpdate.hashCode);
    _$hash = $jc(_$hash, branchId.hashCode);
    _$hash = $jc(_$hash, latitude.hashCode);
    _$hash = $jc(_$hash, longitude.hashCode);
    _$hash = $jc(_$hash, reference.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ShopsRecord')
          ..add('imageUrl', imageUrl)
          ..add('name', name)
          ..add('shopId', shopId)
          ..add('address', address)
          ..add('email', email)
          ..add('ones', ones)
          ..add('twos', twos)
          ..add('threes', threes)
          ..add('fours', fours)
          ..add('fives', fives)
          ..add('sunFrom', sunFrom)
          ..add('sunTo', sunTo)
          ..add('monFrom', monFrom)
          ..add('monTo', monTo)
          ..add('tueFrom', tueFrom)
          ..add('tueTo', tueTo)
          ..add('wedFrom', wedFrom)
          ..add('wedTo', wedTo)
          ..add('thuFrom', thuFrom)
          ..add('thuTo', thuTo)
          ..add('friFrom', friFrom)
          ..add('friTo', friTo)
          ..add('satFrom', satFrom)
          ..add('satTo', satTo)
          ..add('fSSAIRegNo', fSSAIRegNo)
          ..add('users', users)
          ..add('phoneNumber', phoneNumber)
          ..add('search', search)
          ..add('admins', admins)
          ..add('online', online)
          ..add('discount', discount)
          ..add('paid', paid)
          ..add('sales', sales)
          ..add('paidUpdate', paidUpdate)
          ..add('salesUpdate', salesUpdate)
          ..add('branchId', branchId)
          ..add('latitude', latitude)
          ..add('longitude', longitude)
          ..add('reference', reference))
        .toString();
  }
}

class ShopsRecordBuilder implements Builder<ShopsRecord, ShopsRecordBuilder> {
  _$ShopsRecord? _$v;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _shopId;
  String? get shopId => _$this._shopId;
  set shopId(String? shopId) => _$this._shopId = shopId;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  int? _ones;
  int? get ones => _$this._ones;
  set ones(int? ones) => _$this._ones = ones;

  int? _twos;
  int? get twos => _$this._twos;
  set twos(int? twos) => _$this._twos = twos;

  int? _threes;
  int? get threes => _$this._threes;
  set threes(int? threes) => _$this._threes = threes;

  int? _fours;
  int? get fours => _$this._fours;
  set fours(int? fours) => _$this._fours = fours;

  int? _fives;
  int? get fives => _$this._fives;
  set fives(int? fives) => _$this._fives = fives;

  String? _sunFrom;
  String? get sunFrom => _$this._sunFrom;
  set sunFrom(String? sunFrom) => _$this._sunFrom = sunFrom;

  String? _sunTo;
  String? get sunTo => _$this._sunTo;
  set sunTo(String? sunTo) => _$this._sunTo = sunTo;

  String? _monFrom;
  String? get monFrom => _$this._monFrom;
  set monFrom(String? monFrom) => _$this._monFrom = monFrom;

  String? _monTo;
  String? get monTo => _$this._monTo;
  set monTo(String? monTo) => _$this._monTo = monTo;

  String? _tueFrom;
  String? get tueFrom => _$this._tueFrom;
  set tueFrom(String? tueFrom) => _$this._tueFrom = tueFrom;

  String? _tueTo;
  String? get tueTo => _$this._tueTo;
  set tueTo(String? tueTo) => _$this._tueTo = tueTo;

  String? _wedFrom;
  String? get wedFrom => _$this._wedFrom;
  set wedFrom(String? wedFrom) => _$this._wedFrom = wedFrom;

  String? _wedTo;
  String? get wedTo => _$this._wedTo;
  set wedTo(String? wedTo) => _$this._wedTo = wedTo;

  String? _thuFrom;
  String? get thuFrom => _$this._thuFrom;
  set thuFrom(String? thuFrom) => _$this._thuFrom = thuFrom;

  String? _thuTo;
  String? get thuTo => _$this._thuTo;
  set thuTo(String? thuTo) => _$this._thuTo = thuTo;

  String? _friFrom;
  String? get friFrom => _$this._friFrom;
  set friFrom(String? friFrom) => _$this._friFrom = friFrom;

  String? _friTo;
  String? get friTo => _$this._friTo;
  set friTo(String? friTo) => _$this._friTo = friTo;

  String? _satFrom;
  String? get satFrom => _$this._satFrom;
  set satFrom(String? satFrom) => _$this._satFrom = satFrom;

  String? _satTo;
  String? get satTo => _$this._satTo;
  set satTo(String? satTo) => _$this._satTo = satTo;

  String? _fSSAIRegNo;
  String? get fSSAIRegNo => _$this._fSSAIRegNo;
  set fSSAIRegNo(String? fSSAIRegNo) => _$this._fSSAIRegNo = fSSAIRegNo;

  ListBuilder<String>? _users;
  ListBuilder<String> get users => _$this._users ??= new ListBuilder<String>();
  set users(ListBuilder<String>? users) => _$this._users = users;

  String? _phoneNumber;
  String? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String? phoneNumber) => _$this._phoneNumber = phoneNumber;

  ListBuilder<String>? _search;
  ListBuilder<String> get search =>
      _$this._search ??= new ListBuilder<String>();
  set search(ListBuilder<String>? search) => _$this._search = search;

  ListBuilder<String>? _admins;
  ListBuilder<String> get admins =>
      _$this._admins ??= new ListBuilder<String>();
  set admins(ListBuilder<String>? admins) => _$this._admins = admins;

  bool? _online;
  bool? get online => _$this._online;
  set online(bool? online) => _$this._online = online;

  double? _discount;
  double? get discount => _$this._discount;
  set discount(double? discount) => _$this._discount = discount;

  double? _paid;
  double? get paid => _$this._paid;
  set paid(double? paid) => _$this._paid = paid;

  double? _sales;
  double? get sales => _$this._sales;
  set sales(double? sales) => _$this._sales = sales;

  Timestamp? _paidUpdate;
  Timestamp? get paidUpdate => _$this._paidUpdate;
  set paidUpdate(Timestamp? paidUpdate) => _$this._paidUpdate = paidUpdate;

  Timestamp? _salesUpdate;
  Timestamp? get salesUpdate => _$this._salesUpdate;
  set salesUpdate(Timestamp? salesUpdate) => _$this._salesUpdate = salesUpdate;

  String? _branchId;
  String? get branchId => _$this._branchId;
  set branchId(String? branchId) => _$this._branchId = branchId;

  double? _latitude;
  double? get latitude => _$this._latitude;
  set latitude(double? latitude) => _$this._latitude = latitude;

  double? _longitude;
  double? get longitude => _$this._longitude;
  set longitude(double? longitude) => _$this._longitude = longitude;

  DocumentReference<Object?>? _reference;
  DocumentReference<Object?>? get reference => _$this._reference;
  set reference(DocumentReference<Object?>? reference) =>
      _$this._reference = reference;

  ShopsRecordBuilder() {
    ShopsRecord._initializeBuilder(this);
  }

  ShopsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _imageUrl = $v.imageUrl;
      _name = $v.name;
      _shopId = $v.shopId;
      _address = $v.address;
      _email = $v.email;
      _ones = $v.ones;
      _twos = $v.twos;
      _threes = $v.threes;
      _fours = $v.fours;
      _fives = $v.fives;
      _sunFrom = $v.sunFrom;
      _sunTo = $v.sunTo;
      _monFrom = $v.monFrom;
      _monTo = $v.monTo;
      _tueFrom = $v.tueFrom;
      _tueTo = $v.tueTo;
      _wedFrom = $v.wedFrom;
      _wedTo = $v.wedTo;
      _thuFrom = $v.thuFrom;
      _thuTo = $v.thuTo;
      _friFrom = $v.friFrom;
      _friTo = $v.friTo;
      _satFrom = $v.satFrom;
      _satTo = $v.satTo;
      _fSSAIRegNo = $v.fSSAIRegNo;
      _users = $v.users.toBuilder();
      _phoneNumber = $v.phoneNumber;
      _search = $v.search.toBuilder();
      _admins = $v.admins.toBuilder();
      _online = $v.online;
      _discount = $v.discount;
      _paid = $v.paid;
      _sales = $v.sales;
      _paidUpdate = $v.paidUpdate;
      _salesUpdate = $v.salesUpdate;
      _branchId = $v.branchId;
      _latitude = $v.latitude;
      _longitude = $v.longitude;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ShopsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ShopsRecord;
  }

  @override
  void update(void Function(ShopsRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ShopsRecord build() => _build();

  _$ShopsRecord _build() {
    _$ShopsRecord _$result;
    try {
      _$result = _$v ??
          new _$ShopsRecord._(
              imageUrl: BuiltValueNullFieldError.checkNotNull(
                  imageUrl, r'ShopsRecord', 'imageUrl'),
              name: BuiltValueNullFieldError.checkNotNull(
                  name, r'ShopsRecord', 'name'),
              shopId: BuiltValueNullFieldError.checkNotNull(
                  shopId, r'ShopsRecord', 'shopId'),
              address: BuiltValueNullFieldError.checkNotNull(
                  address, r'ShopsRecord', 'address'),
              email: BuiltValueNullFieldError.checkNotNull(
                  email, r'ShopsRecord', 'email'),
              ones: BuiltValueNullFieldError.checkNotNull(
                  ones, r'ShopsRecord', 'ones'),
              twos: BuiltValueNullFieldError.checkNotNull(
                  twos, r'ShopsRecord', 'twos'),
              threes: BuiltValueNullFieldError.checkNotNull(
                  threes, r'ShopsRecord', 'threes'),
              fours: BuiltValueNullFieldError.checkNotNull(
                  fours, r'ShopsRecord', 'fours'),
              fives:
                  BuiltValueNullFieldError.checkNotNull(fives, r'ShopsRecord', 'fives'),
              sunFrom: BuiltValueNullFieldError.checkNotNull(sunFrom, r'ShopsRecord', 'sunFrom'),
              sunTo: BuiltValueNullFieldError.checkNotNull(sunTo, r'ShopsRecord', 'sunTo'),
              monFrom: BuiltValueNullFieldError.checkNotNull(monFrom, r'ShopsRecord', 'monFrom'),
              monTo: BuiltValueNullFieldError.checkNotNull(monTo, r'ShopsRecord', 'monTo'),
              tueFrom: BuiltValueNullFieldError.checkNotNull(tueFrom, r'ShopsRecord', 'tueFrom'),
              tueTo: BuiltValueNullFieldError.checkNotNull(tueTo, r'ShopsRecord', 'tueTo'),
              wedFrom: BuiltValueNullFieldError.checkNotNull(wedFrom, r'ShopsRecord', 'wedFrom'),
              wedTo: BuiltValueNullFieldError.checkNotNull(wedTo, r'ShopsRecord', 'wedTo'),
              thuFrom: BuiltValueNullFieldError.checkNotNull(thuFrom, r'ShopsRecord', 'thuFrom'),
              thuTo: BuiltValueNullFieldError.checkNotNull(thuTo, r'ShopsRecord', 'thuTo'),
              friFrom: BuiltValueNullFieldError.checkNotNull(friFrom, r'ShopsRecord', 'friFrom'),
              friTo: BuiltValueNullFieldError.checkNotNull(friTo, r'ShopsRecord', 'friTo'),
              satFrom: BuiltValueNullFieldError.checkNotNull(satFrom, r'ShopsRecord', 'satFrom'),
              satTo: BuiltValueNullFieldError.checkNotNull(satTo, r'ShopsRecord', 'satTo'),
              fSSAIRegNo: BuiltValueNullFieldError.checkNotNull(fSSAIRegNo, r'ShopsRecord', 'fSSAIRegNo'),
              users: users.build(),
              phoneNumber: BuiltValueNullFieldError.checkNotNull(phoneNumber, r'ShopsRecord', 'phoneNumber'),
              search: search.build(),
              admins: admins.build(),
              online: BuiltValueNullFieldError.checkNotNull(online, r'ShopsRecord', 'online'),
              discount: BuiltValueNullFieldError.checkNotNull(discount, r'ShopsRecord', 'discount'),
              paid: BuiltValueNullFieldError.checkNotNull(paid, r'ShopsRecord', 'paid'),
              sales: BuiltValueNullFieldError.checkNotNull(sales, r'ShopsRecord', 'sales'),
              paidUpdate: BuiltValueNullFieldError.checkNotNull(paidUpdate, r'ShopsRecord', 'paidUpdate'),
              salesUpdate: BuiltValueNullFieldError.checkNotNull(salesUpdate, r'ShopsRecord', 'salesUpdate'),
              branchId: BuiltValueNullFieldError.checkNotNull(branchId, r'ShopsRecord', 'branchId'),
              latitude: BuiltValueNullFieldError.checkNotNull(latitude, r'ShopsRecord', 'latitude'),
              longitude: BuiltValueNullFieldError.checkNotNull(longitude, r'ShopsRecord', 'longitude'),
              reference: BuiltValueNullFieldError.checkNotNull(reference, r'ShopsRecord', 'reference'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'users';
        users.build();

        _$failedField = 'search';
        search.build();
        _$failedField = 'admins';
        admins.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ShopsRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
