// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rider_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<RiderRecord> _$riderRecordSerializer = new _$RiderRecordSerializer();

class _$RiderRecordSerializer implements StructuredSerializer<RiderRecord> {
  @override
  final Iterable<Type> types = const [RiderRecord, _$RiderRecord];
  @override
  final String wireName = 'RiderRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, RiderRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'address',
      serializers.serialize(object.address,
          specifiedType: const FullType(String)),
      'vehicleNo',
      serializers.serialize(object.vehicleNo,
          specifiedType: const FullType(String)),
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'online',
      serializers.serialize(object.online, specifiedType: const FullType(bool)),
      'display_name',
      serializers.serialize(object.displayName,
          specifiedType: const FullType(String)),
      'photo_url',
      serializers.serialize(object.photoUrl,
          specifiedType: const FullType(String)),
      'uid',
      serializers.serialize(object.uid, specifiedType: const FullType(String)),
      'walletBalance',
      serializers.serialize(object.walletBalance,
          specifiedType: const FullType(double)),
      'earnings',
      serializers.serialize(object.earnings,
          specifiedType: const FullType(double)),
      'tips',
      serializers.serialize(object.tips, specifiedType: const FullType(double)),
      'paid',
      serializers.serialize(object.paid, specifiedType: const FullType(double)),
      'cashInHand',
      serializers.serialize(object.cashInHand,
          specifiedType: const FullType(double)),
      'walletUpdate',
      serializers.serialize(object.walletUpdate,
          specifiedType: const FullType(Timestamp)),
      'earningsUpdate',
      serializers.serialize(object.earningsUpdate,
          specifiedType: const FullType(Timestamp)),
      'tipsUpdate',
      serializers.serialize(object.tipsUpdate,
          specifiedType: const FullType(Timestamp)),
      'paidUpdate',
      serializers.serialize(object.paidUpdate,
          specifiedType: const FullType(Timestamp)),
      'cashInHandUpdate',
      serializers.serialize(object.cashInHandUpdate,
          specifiedType: const FullType(Timestamp)),
      'created_time',
      serializers.serialize(object.createdTime,
          specifiedType: const FullType(DateTime)),
      'phone_number',
      serializers.serialize(object.phoneNumber,
          specifiedType: const FullType(String)),
      'Document__Reference__Field',
      serializers.serialize(object.reference,
          specifiedType: const FullType(
              DocumentReference, const [const FullType.nullable(Object)])),
    ];

    return result;
  }

  @override
  RiderRecord deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RiderRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'address':
          result.address = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'vehicleNo':
          result.vehicleNo = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'online':
          result.online = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'display_name':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'photo_url':
          result.photoUrl = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'uid':
          result.uid = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'walletBalance':
          result.walletBalance = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'earnings':
          result.earnings = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'tips':
          result.tips = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'paid':
          result.paid = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'cashInHand':
          result.cashInHand = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'walletUpdate':
          result.walletUpdate = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp))! as Timestamp;
          break;
        case 'earningsUpdate':
          result.earningsUpdate = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp))! as Timestamp;
          break;
        case 'tipsUpdate':
          result.tipsUpdate = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp))! as Timestamp;
          break;
        case 'paidUpdate':
          result.paidUpdate = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp))! as Timestamp;
          break;
        case 'cashInHandUpdate':
          result.cashInHandUpdate = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp))! as Timestamp;
          break;
        case 'created_time':
          result.createdTime = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'phone_number':
          result.phoneNumber = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
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

class _$RiderRecord extends RiderRecord {
  @override
  final String name;
  @override
  final String address;
  @override
  final String vehicleNo;
  @override
  final String email;
  @override
  final bool online;
  @override
  final String displayName;
  @override
  final String photoUrl;
  @override
  final String uid;
  @override
  final double walletBalance;
  @override
  final double earnings;
  @override
  final double tips;
  @override
  final double paid;
  @override
  final double cashInHand;
  @override
  final Timestamp walletUpdate;
  @override
  final Timestamp earningsUpdate;
  @override
  final Timestamp tipsUpdate;
  @override
  final Timestamp paidUpdate;
  @override
  final Timestamp cashInHandUpdate;
  @override
  final DateTime createdTime;
  @override
  final String phoneNumber;
  @override
  final DocumentReference<Object?> reference;

  factory _$RiderRecord([void Function(RiderRecordBuilder)? updates]) =>
      (new RiderRecordBuilder()..update(updates))._build();

  _$RiderRecord._(
      {required this.name,
      required this.address,
      required this.vehicleNo,
      required this.email,
      required this.online,
      required this.displayName,
      required this.photoUrl,
      required this.uid,
      required this.walletBalance,
      required this.earnings,
      required this.tips,
      required this.paid,
      required this.cashInHand,
      required this.walletUpdate,
      required this.earningsUpdate,
      required this.tipsUpdate,
      required this.paidUpdate,
      required this.cashInHandUpdate,
      required this.createdTime,
      required this.phoneNumber,
      required this.reference})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'RiderRecord', 'name');
    BuiltValueNullFieldError.checkNotNull(address, r'RiderRecord', 'address');
    BuiltValueNullFieldError.checkNotNull(
        vehicleNo, r'RiderRecord', 'vehicleNo');
    BuiltValueNullFieldError.checkNotNull(email, r'RiderRecord', 'email');
    BuiltValueNullFieldError.checkNotNull(online, r'RiderRecord', 'online');
    BuiltValueNullFieldError.checkNotNull(
        displayName, r'RiderRecord', 'displayName');
    BuiltValueNullFieldError.checkNotNull(photoUrl, r'RiderRecord', 'photoUrl');
    BuiltValueNullFieldError.checkNotNull(uid, r'RiderRecord', 'uid');
    BuiltValueNullFieldError.checkNotNull(
        walletBalance, r'RiderRecord', 'walletBalance');
    BuiltValueNullFieldError.checkNotNull(earnings, r'RiderRecord', 'earnings');
    BuiltValueNullFieldError.checkNotNull(tips, r'RiderRecord', 'tips');
    BuiltValueNullFieldError.checkNotNull(paid, r'RiderRecord', 'paid');
    BuiltValueNullFieldError.checkNotNull(
        cashInHand, r'RiderRecord', 'cashInHand');
    BuiltValueNullFieldError.checkNotNull(
        walletUpdate, r'RiderRecord', 'walletUpdate');
    BuiltValueNullFieldError.checkNotNull(
        earningsUpdate, r'RiderRecord', 'earningsUpdate');
    BuiltValueNullFieldError.checkNotNull(
        tipsUpdate, r'RiderRecord', 'tipsUpdate');
    BuiltValueNullFieldError.checkNotNull(
        paidUpdate, r'RiderRecord', 'paidUpdate');
    BuiltValueNullFieldError.checkNotNull(
        cashInHandUpdate, r'RiderRecord', 'cashInHandUpdate');
    BuiltValueNullFieldError.checkNotNull(
        createdTime, r'RiderRecord', 'createdTime');
    BuiltValueNullFieldError.checkNotNull(
        phoneNumber, r'RiderRecord', 'phoneNumber');
    BuiltValueNullFieldError.checkNotNull(
        reference, r'RiderRecord', 'reference');
  }

  @override
  RiderRecord rebuild(void Function(RiderRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RiderRecordBuilder toBuilder() => new RiderRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RiderRecord &&
        name == other.name &&
        address == other.address &&
        vehicleNo == other.vehicleNo &&
        email == other.email &&
        online == other.online &&
        displayName == other.displayName &&
        photoUrl == other.photoUrl &&
        uid == other.uid &&
        walletBalance == other.walletBalance &&
        earnings == other.earnings &&
        tips == other.tips &&
        paid == other.paid &&
        cashInHand == other.cashInHand &&
        walletUpdate == other.walletUpdate &&
        earningsUpdate == other.earningsUpdate &&
        tipsUpdate == other.tipsUpdate &&
        paidUpdate == other.paidUpdate &&
        cashInHandUpdate == other.cashInHandUpdate &&
        createdTime == other.createdTime &&
        phoneNumber == other.phoneNumber &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, vehicleNo.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, online.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, photoUrl.hashCode);
    _$hash = $jc(_$hash, uid.hashCode);
    _$hash = $jc(_$hash, walletBalance.hashCode);
    _$hash = $jc(_$hash, earnings.hashCode);
    _$hash = $jc(_$hash, tips.hashCode);
    _$hash = $jc(_$hash, paid.hashCode);
    _$hash = $jc(_$hash, cashInHand.hashCode);
    _$hash = $jc(_$hash, walletUpdate.hashCode);
    _$hash = $jc(_$hash, earningsUpdate.hashCode);
    _$hash = $jc(_$hash, tipsUpdate.hashCode);
    _$hash = $jc(_$hash, paidUpdate.hashCode);
    _$hash = $jc(_$hash, cashInHandUpdate.hashCode);
    _$hash = $jc(_$hash, createdTime.hashCode);
    _$hash = $jc(_$hash, phoneNumber.hashCode);
    _$hash = $jc(_$hash, reference.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RiderRecord')
          ..add('name', name)
          ..add('address', address)
          ..add('vehicleNo', vehicleNo)
          ..add('email', email)
          ..add('online', online)
          ..add('displayName', displayName)
          ..add('photoUrl', photoUrl)
          ..add('uid', uid)
          ..add('walletBalance', walletBalance)
          ..add('earnings', earnings)
          ..add('tips', tips)
          ..add('paid', paid)
          ..add('cashInHand', cashInHand)
          ..add('walletUpdate', walletUpdate)
          ..add('earningsUpdate', earningsUpdate)
          ..add('tipsUpdate', tipsUpdate)
          ..add('paidUpdate', paidUpdate)
          ..add('cashInHandUpdate', cashInHandUpdate)
          ..add('createdTime', createdTime)
          ..add('phoneNumber', phoneNumber)
          ..add('reference', reference))
        .toString();
  }
}

class RiderRecordBuilder implements Builder<RiderRecord, RiderRecordBuilder> {
  _$RiderRecord? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  String? _vehicleNo;
  String? get vehicleNo => _$this._vehicleNo;
  set vehicleNo(String? vehicleNo) => _$this._vehicleNo = vehicleNo;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  bool? _online;
  bool? get online => _$this._online;
  set online(bool? online) => _$this._online = online;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _photoUrl;
  String? get photoUrl => _$this._photoUrl;
  set photoUrl(String? photoUrl) => _$this._photoUrl = photoUrl;

  String? _uid;
  String? get uid => _$this._uid;
  set uid(String? uid) => _$this._uid = uid;

  double? _walletBalance;
  double? get walletBalance => _$this._walletBalance;
  set walletBalance(double? walletBalance) =>
      _$this._walletBalance = walletBalance;

  double? _earnings;
  double? get earnings => _$this._earnings;
  set earnings(double? earnings) => _$this._earnings = earnings;

  double? _tips;
  double? get tips => _$this._tips;
  set tips(double? tips) => _$this._tips = tips;

  double? _paid;
  double? get paid => _$this._paid;
  set paid(double? paid) => _$this._paid = paid;

  double? _cashInHand;
  double? get cashInHand => _$this._cashInHand;
  set cashInHand(double? cashInHand) => _$this._cashInHand = cashInHand;

  Timestamp? _walletUpdate;
  Timestamp? get walletUpdate => _$this._walletUpdate;
  set walletUpdate(Timestamp? walletUpdate) =>
      _$this._walletUpdate = walletUpdate;

  Timestamp? _earningsUpdate;
  Timestamp? get earningsUpdate => _$this._earningsUpdate;
  set earningsUpdate(Timestamp? earningsUpdate) =>
      _$this._earningsUpdate = earningsUpdate;

  Timestamp? _tipsUpdate;
  Timestamp? get tipsUpdate => _$this._tipsUpdate;
  set tipsUpdate(Timestamp? tipsUpdate) => _$this._tipsUpdate = tipsUpdate;

  Timestamp? _paidUpdate;
  Timestamp? get paidUpdate => _$this._paidUpdate;
  set paidUpdate(Timestamp? paidUpdate) => _$this._paidUpdate = paidUpdate;

  Timestamp? _cashInHandUpdate;
  Timestamp? get cashInHandUpdate => _$this._cashInHandUpdate;
  set cashInHandUpdate(Timestamp? cashInHandUpdate) =>
      _$this._cashInHandUpdate = cashInHandUpdate;

  DateTime? _createdTime;
  DateTime? get createdTime => _$this._createdTime;
  set createdTime(DateTime? createdTime) => _$this._createdTime = createdTime;

  String? _phoneNumber;
  String? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String? phoneNumber) => _$this._phoneNumber = phoneNumber;

  DocumentReference<Object?>? _reference;
  DocumentReference<Object?>? get reference => _$this._reference;
  set reference(DocumentReference<Object?>? reference) =>
      _$this._reference = reference;

  RiderRecordBuilder() {
    RiderRecord._initializeBuilder(this);
  }

  RiderRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _address = $v.address;
      _vehicleNo = $v.vehicleNo;
      _email = $v.email;
      _online = $v.online;
      _displayName = $v.displayName;
      _photoUrl = $v.photoUrl;
      _uid = $v.uid;
      _walletBalance = $v.walletBalance;
      _earnings = $v.earnings;
      _tips = $v.tips;
      _paid = $v.paid;
      _cashInHand = $v.cashInHand;
      _walletUpdate = $v.walletUpdate;
      _earningsUpdate = $v.earningsUpdate;
      _tipsUpdate = $v.tipsUpdate;
      _paidUpdate = $v.paidUpdate;
      _cashInHandUpdate = $v.cashInHandUpdate;
      _createdTime = $v.createdTime;
      _phoneNumber = $v.phoneNumber;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RiderRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RiderRecord;
  }

  @override
  void update(void Function(RiderRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RiderRecord build() => _build();

  _$RiderRecord _build() {
    final _$result = _$v ??
        new _$RiderRecord._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'RiderRecord', 'name'),
            address: BuiltValueNullFieldError.checkNotNull(
                address, r'RiderRecord', 'address'),
            vehicleNo: BuiltValueNullFieldError.checkNotNull(
                vehicleNo, r'RiderRecord', 'vehicleNo'),
            email: BuiltValueNullFieldError.checkNotNull(
                email, r'RiderRecord', 'email'),
            online: BuiltValueNullFieldError.checkNotNull(
                online, r'RiderRecord', 'online'),
            displayName: BuiltValueNullFieldError.checkNotNull(
                displayName, r'RiderRecord', 'displayName'),
            photoUrl: BuiltValueNullFieldError.checkNotNull(
                photoUrl, r'RiderRecord', 'photoUrl'),
            uid: BuiltValueNullFieldError.checkNotNull(
                uid, r'RiderRecord', 'uid'),
            walletBalance: BuiltValueNullFieldError.checkNotNull(
                walletBalance, r'RiderRecord', 'walletBalance'),
            earnings:
                BuiltValueNullFieldError.checkNotNull(earnings, r'RiderRecord', 'earnings'),
            tips: BuiltValueNullFieldError.checkNotNull(tips, r'RiderRecord', 'tips'),
            paid: BuiltValueNullFieldError.checkNotNull(paid, r'RiderRecord', 'paid'),
            cashInHand: BuiltValueNullFieldError.checkNotNull(cashInHand, r'RiderRecord', 'cashInHand'),
            walletUpdate: BuiltValueNullFieldError.checkNotNull(walletUpdate, r'RiderRecord', 'walletUpdate'),
            earningsUpdate: BuiltValueNullFieldError.checkNotNull(earningsUpdate, r'RiderRecord', 'earningsUpdate'),
            tipsUpdate: BuiltValueNullFieldError.checkNotNull(tipsUpdate, r'RiderRecord', 'tipsUpdate'),
            paidUpdate: BuiltValueNullFieldError.checkNotNull(paidUpdate, r'RiderRecord', 'paidUpdate'),
            cashInHandUpdate: BuiltValueNullFieldError.checkNotNull(cashInHandUpdate, r'RiderRecord', 'cashInHandUpdate'),
            createdTime: BuiltValueNullFieldError.checkNotNull(createdTime, r'RiderRecord', 'createdTime'),
            phoneNumber: BuiltValueNullFieldError.checkNotNull(phoneNumber, r'RiderRecord', 'phoneNumber'),
            reference: BuiltValueNullFieldError.checkNotNull(reference, r'RiderRecord', 'reference'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
