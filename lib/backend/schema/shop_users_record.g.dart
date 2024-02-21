// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_users_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ShopUsersRecord> _$shopUsersRecordSerializer =
    new _$ShopUsersRecordSerializer();

class _$ShopUsersRecordSerializer
    implements StructuredSerializer<ShopUsersRecord> {
  @override
  final Iterable<Type> types = const [ShopUsersRecord, _$ShopUsersRecord];
  @override
  final String wireName = 'ShopUsersRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, ShopUsersRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'display_name',
      serializers.serialize(object.displayName,
          specifiedType: const FullType(String)),
      'photo_url',
      serializers.serialize(object.photoUrl,
          specifiedType: const FullType(String)),
      'uid',
      serializers.serialize(object.uid, specifiedType: const FullType(String)),
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
  ShopUsersRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ShopUsersRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
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

class _$ShopUsersRecord extends ShopUsersRecord {
  @override
  final String email;
  @override
  final String displayName;
  @override
  final String photoUrl;
  @override
  final String uid;
  @override
  final DateTime createdTime;
  @override
  final String phoneNumber;
  @override
  final DocumentReference<Object?> reference;

  factory _$ShopUsersRecord([void Function(ShopUsersRecordBuilder)? updates]) =>
      (new ShopUsersRecordBuilder()..update(updates))._build();

  _$ShopUsersRecord._(
      {required this.email,
      required this.displayName,
      required this.photoUrl,
      required this.uid,
      required this.createdTime,
      required this.phoneNumber,
      required this.reference})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(email, r'ShopUsersRecord', 'email');
    BuiltValueNullFieldError.checkNotNull(
        displayName, r'ShopUsersRecord', 'displayName');
    BuiltValueNullFieldError.checkNotNull(
        photoUrl, r'ShopUsersRecord', 'photoUrl');
    BuiltValueNullFieldError.checkNotNull(uid, r'ShopUsersRecord', 'uid');
    BuiltValueNullFieldError.checkNotNull(
        createdTime, r'ShopUsersRecord', 'createdTime');
    BuiltValueNullFieldError.checkNotNull(
        phoneNumber, r'ShopUsersRecord', 'phoneNumber');
    BuiltValueNullFieldError.checkNotNull(
        reference, r'ShopUsersRecord', 'reference');
  }

  @override
  ShopUsersRecord rebuild(void Function(ShopUsersRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ShopUsersRecordBuilder toBuilder() =>
      new ShopUsersRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ShopUsersRecord &&
        email == other.email &&
        displayName == other.displayName &&
        photoUrl == other.photoUrl &&
        uid == other.uid &&
        createdTime == other.createdTime &&
        phoneNumber == other.phoneNumber &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, photoUrl.hashCode);
    _$hash = $jc(_$hash, uid.hashCode);
    _$hash = $jc(_$hash, createdTime.hashCode);
    _$hash = $jc(_$hash, phoneNumber.hashCode);
    _$hash = $jc(_$hash, reference.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ShopUsersRecord')
          ..add('email', email)
          ..add('displayName', displayName)
          ..add('photoUrl', photoUrl)
          ..add('uid', uid)
          ..add('createdTime', createdTime)
          ..add('phoneNumber', phoneNumber)
          ..add('reference', reference))
        .toString();
  }
}

class ShopUsersRecordBuilder
    implements Builder<ShopUsersRecord, ShopUsersRecordBuilder> {
  _$ShopUsersRecord? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _photoUrl;
  String? get photoUrl => _$this._photoUrl;
  set photoUrl(String? photoUrl) => _$this._photoUrl = photoUrl;

  String? _uid;
  String? get uid => _$this._uid;
  set uid(String? uid) => _$this._uid = uid;

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

  ShopUsersRecordBuilder() {
    ShopUsersRecord._initializeBuilder(this);
  }

  ShopUsersRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _displayName = $v.displayName;
      _photoUrl = $v.photoUrl;
      _uid = $v.uid;
      _createdTime = $v.createdTime;
      _phoneNumber = $v.phoneNumber;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ShopUsersRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ShopUsersRecord;
  }

  @override
  void update(void Function(ShopUsersRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ShopUsersRecord build() => _build();

  _$ShopUsersRecord _build() {
    final _$result = _$v ??
        new _$ShopUsersRecord._(
            email: BuiltValueNullFieldError.checkNotNull(
                email, r'ShopUsersRecord', 'email'),
            displayName: BuiltValueNullFieldError.checkNotNull(
                displayName, r'ShopUsersRecord', 'displayName'),
            photoUrl: BuiltValueNullFieldError.checkNotNull(
                photoUrl, r'ShopUsersRecord', 'photoUrl'),
            uid: BuiltValueNullFieldError.checkNotNull(
                uid, r'ShopUsersRecord', 'uid'),
            createdTime: BuiltValueNullFieldError.checkNotNull(
                createdTime, r'ShopUsersRecord', 'createdTime'),
            phoneNumber: BuiltValueNullFieldError.checkNotNull(
                phoneNumber, r'ShopUsersRecord', 'phoneNumber'),
            reference: BuiltValueNullFieldError.checkNotNull(
                reference, r'ShopUsersRecord', 'reference'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
