// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UsersRecord> _$usersRecordSerializer = new _$UsersRecordSerializer();

class _$UsersRecordSerializer implements StructuredSerializer<UsersRecord> {
  @override
  final Iterable<Type> types = const [UsersRecord, _$UsersRecord];
  @override
  final String wireName = 'UsersRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, UsersRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'fullName',
      serializers.serialize(object.fullName,
          specifiedType: const FullType(String)),
      'mobileNumber',
      serializers.serialize(object.mobileNumber,
          specifiedType: const FullType(String)),
      'photoUrl',
      serializers.serialize(object.photoUrl,
          specifiedType: const FullType(String)),
      'userId',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
      'wishlist',
      serializers.serialize(object.wishlist,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'branchId',
      serializers.serialize(object.branchId,
          specifiedType: const FullType(String)),
      'Document__Reference__Field',
      serializers.serialize(object.reference,
          specifiedType: const FullType(
              DocumentReference, const [const FullType.nullable(Object)])),
    ];

    return result;
  }

  @override
  UsersRecord deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UsersRecordBuilder();

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
        case 'fullName':
          result.fullName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'mobileNumber':
          result.mobileNumber = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'photoUrl':
          result.photoUrl = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'wishlist':
          result.wishlist.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'branchId':
          result.branchId = serializers.deserialize(value,
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

class _$UsersRecord extends UsersRecord {
  @override
  final String email;
  @override
  final String fullName;
  @override
  final String mobileNumber;
  @override
  final String photoUrl;
  @override
  final String userId;
  @override
  final BuiltList<String> wishlist;
  @override
  final String branchId;
  @override
  final DocumentReference<Object?> reference;

  factory _$UsersRecord([void Function(UsersRecordBuilder)? updates]) =>
      (new UsersRecordBuilder()..update(updates))._build();

  _$UsersRecord._(
      {required this.email,
      required this.fullName,
      required this.mobileNumber,
      required this.photoUrl,
      required this.userId,
      required this.wishlist,
      required this.branchId,
      required this.reference})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(email, r'UsersRecord', 'email');
    BuiltValueNullFieldError.checkNotNull(fullName, r'UsersRecord', 'fullName');
    BuiltValueNullFieldError.checkNotNull(
        mobileNumber, r'UsersRecord', 'mobileNumber');
    BuiltValueNullFieldError.checkNotNull(photoUrl, r'UsersRecord', 'photoUrl');
    BuiltValueNullFieldError.checkNotNull(userId, r'UsersRecord', 'userId');
    BuiltValueNullFieldError.checkNotNull(wishlist, r'UsersRecord', 'wishlist');
    BuiltValueNullFieldError.checkNotNull(branchId, r'UsersRecord', 'branchId');
    BuiltValueNullFieldError.checkNotNull(
        reference, r'UsersRecord', 'reference');
  }

  @override
  UsersRecord rebuild(void Function(UsersRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UsersRecordBuilder toBuilder() => new UsersRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UsersRecord &&
        email == other.email &&
        fullName == other.fullName &&
        mobileNumber == other.mobileNumber &&
        photoUrl == other.photoUrl &&
        userId == other.userId &&
        wishlist == other.wishlist &&
        branchId == other.branchId &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, fullName.hashCode);
    _$hash = $jc(_$hash, mobileNumber.hashCode);
    _$hash = $jc(_$hash, photoUrl.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, wishlist.hashCode);
    _$hash = $jc(_$hash, branchId.hashCode);
    _$hash = $jc(_$hash, reference.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UsersRecord')
          ..add('email', email)
          ..add('fullName', fullName)
          ..add('mobileNumber', mobileNumber)
          ..add('photoUrl', photoUrl)
          ..add('userId', userId)
          ..add('wishlist', wishlist)
          ..add('branchId', branchId)
          ..add('reference', reference))
        .toString();
  }
}

class UsersRecordBuilder implements Builder<UsersRecord, UsersRecordBuilder> {
  _$UsersRecord? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _fullName;
  String? get fullName => _$this._fullName;
  set fullName(String? fullName) => _$this._fullName = fullName;

  String? _mobileNumber;
  String? get mobileNumber => _$this._mobileNumber;
  set mobileNumber(String? mobileNumber) => _$this._mobileNumber = mobileNumber;

  String? _photoUrl;
  String? get photoUrl => _$this._photoUrl;
  set photoUrl(String? photoUrl) => _$this._photoUrl = photoUrl;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  ListBuilder<String>? _wishlist;
  ListBuilder<String> get wishlist =>
      _$this._wishlist ??= new ListBuilder<String>();
  set wishlist(ListBuilder<String>? wishlist) => _$this._wishlist = wishlist;

  String? _branchId;
  String? get branchId => _$this._branchId;
  set branchId(String? branchId) => _$this._branchId = branchId;

  DocumentReference<Object?>? _reference;
  DocumentReference<Object?>? get reference => _$this._reference;
  set reference(DocumentReference<Object?>? reference) =>
      _$this._reference = reference;

  UsersRecordBuilder() {
    UsersRecord._initializeBuilder(this);
  }

  UsersRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _fullName = $v.fullName;
      _mobileNumber = $v.mobileNumber;
      _photoUrl = $v.photoUrl;
      _userId = $v.userId;
      _wishlist = $v.wishlist.toBuilder();
      _branchId = $v.branchId;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UsersRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UsersRecord;
  }

  @override
  void update(void Function(UsersRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UsersRecord build() => _build();

  _$UsersRecord _build() {
    _$UsersRecord _$result;
    try {
      _$result = _$v ??
          new _$UsersRecord._(
              email: BuiltValueNullFieldError.checkNotNull(
                  email, r'UsersRecord', 'email'),
              fullName: BuiltValueNullFieldError.checkNotNull(
                  fullName, r'UsersRecord', 'fullName'),
              mobileNumber: BuiltValueNullFieldError.checkNotNull(
                  mobileNumber, r'UsersRecord', 'mobileNumber'),
              photoUrl: BuiltValueNullFieldError.checkNotNull(
                  photoUrl, r'UsersRecord', 'photoUrl'),
              userId: BuiltValueNullFieldError.checkNotNull(
                  userId, r'UsersRecord', 'userId'),
              wishlist: wishlist.build(),
              branchId: BuiltValueNullFieldError.checkNotNull(
                  branchId, r'UsersRecord', 'branchId'),
              reference: BuiltValueNullFieldError.checkNotNull(
                  reference, r'UsersRecord', 'reference'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'wishlist';
        wishlist.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'UsersRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
