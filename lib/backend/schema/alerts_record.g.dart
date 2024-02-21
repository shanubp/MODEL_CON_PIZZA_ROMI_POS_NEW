// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alerts_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AlertsRecord> _$alertsRecordSerializer =
    new _$AlertsRecordSerializer();

class _$AlertsRecordSerializer implements StructuredSerializer<AlertsRecord> {
  @override
  final Iterable<Type> types = const [AlertsRecord, _$AlertsRecord];
  @override
  final String wireName = 'AlertsRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, AlertsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'date',
      serializers.serialize(object.date,
          specifiedType: const FullType(Timestamp)),
      'userId',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
      'seen',
      serializers.serialize(object.seen, specifiedType: const FullType(String)),
      'link',
      serializers.serialize(object.link, specifiedType: const FullType(String)),
      'Document__Reference__Field',
      serializers.serialize(object.reference,
          specifiedType: const FullType(
              DocumentReference, const [const FullType.nullable(Object)])),
    ];

    return result;
  }

  @override
  AlertsRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AlertsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'date':
          result.date = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp))! as Timestamp;
          break;
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'seen':
          result.seen = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'link':
          result.link = serializers.deserialize(value,
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

class _$AlertsRecord extends AlertsRecord {
  @override
  final Timestamp date;
  @override
  final String userId;
  @override
  final String title;
  @override
  final String message;
  @override
  final String seen;
  @override
  final String link;
  @override
  final DocumentReference<Object?> reference;

  factory _$AlertsRecord([void Function(AlertsRecordBuilder)? updates]) =>
      (new AlertsRecordBuilder()..update(updates))._build();

  _$AlertsRecord._(
      {required this.date,
      required this.userId,
      required this.title,
      required this.message,
      required this.seen,
      required this.link,
      required this.reference})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(date, r'AlertsRecord', 'date');
    BuiltValueNullFieldError.checkNotNull(userId, r'AlertsRecord', 'userId');
    BuiltValueNullFieldError.checkNotNull(title, r'AlertsRecord', 'title');
    BuiltValueNullFieldError.checkNotNull(message, r'AlertsRecord', 'message');
    BuiltValueNullFieldError.checkNotNull(seen, r'AlertsRecord', 'seen');
    BuiltValueNullFieldError.checkNotNull(link, r'AlertsRecord', 'link');
    BuiltValueNullFieldError.checkNotNull(
        reference, r'AlertsRecord', 'reference');
  }

  @override
  AlertsRecord rebuild(void Function(AlertsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AlertsRecordBuilder toBuilder() => new AlertsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AlertsRecord &&
        date == other.date &&
        userId == other.userId &&
        title == other.title &&
        message == other.message &&
        seen == other.seen &&
        link == other.link &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, seen.hashCode);
    _$hash = $jc(_$hash, link.hashCode);
    _$hash = $jc(_$hash, reference.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AlertsRecord')
          ..add('date', date)
          ..add('userId', userId)
          ..add('title', title)
          ..add('message', message)
          ..add('seen', seen)
          ..add('link', link)
          ..add('reference', reference))
        .toString();
  }
}

class AlertsRecordBuilder
    implements Builder<AlertsRecord, AlertsRecordBuilder> {
  _$AlertsRecord? _$v;

  Timestamp? _date;
  Timestamp? get date => _$this._date;
  set date(Timestamp? date) => _$this._date = date;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _seen;
  String? get seen => _$this._seen;
  set seen(String? seen) => _$this._seen = seen;

  String? _link;
  String? get link => _$this._link;
  set link(String? link) => _$this._link = link;

  DocumentReference<Object?>? _reference;
  DocumentReference<Object?>? get reference => _$this._reference;
  set reference(DocumentReference<Object?>? reference) =>
      _$this._reference = reference;

  AlertsRecordBuilder() {
    AlertsRecord._initializeBuilder(this);
  }

  AlertsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _date = $v.date;
      _userId = $v.userId;
      _title = $v.title;
      _message = $v.message;
      _seen = $v.seen;
      _link = $v.link;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AlertsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AlertsRecord;
  }

  @override
  void update(void Function(AlertsRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AlertsRecord build() => _build();

  _$AlertsRecord _build() {
    final _$result = _$v ??
        new _$AlertsRecord._(
            date: BuiltValueNullFieldError.checkNotNull(
                date, r'AlertsRecord', 'date'),
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'AlertsRecord', 'userId'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'AlertsRecord', 'title'),
            message: BuiltValueNullFieldError.checkNotNull(
                message, r'AlertsRecord', 'message'),
            seen: BuiltValueNullFieldError.checkNotNull(
                seen, r'AlertsRecord', 'seen'),
            link: BuiltValueNullFieldError.checkNotNull(
                link, r'AlertsRecord', 'link'),
            reference: BuiltValueNullFieldError.checkNotNull(
                reference, r'AlertsRecord', 'reference'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
