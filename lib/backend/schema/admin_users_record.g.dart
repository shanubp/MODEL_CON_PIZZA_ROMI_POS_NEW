// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'admin_users_record.dart';
//
// // **************************************************************************
// // BuiltValueGenerator
// // **************************************************************************
//
// Serializer<AdminUsersRecord> _$adminUsersRecordSerializer =
//     new _$AdminUsersRecordSerializer();
//
// class _$AdminUsersRecordSerializer
//     implements StructuredSerializer<AdminUsersRecord> {
//   @override
//   final Iterable<Type> types = const [AdminUsersRecord, _$AdminUsersRecord];
//   @override
//   final String wireName = 'AdminUsersRecord';
//
//   @override
//   Iterable<Object?> serialize(Serializers serializers, AdminUsersRecord object,
//       {FullType specifiedType = FullType.unspecified}) {
//     final result = <Object?>[
//       'email',
//       serializers.serialize(object.email,
//           specifiedType: const FullType(String)),
//       'display_name',
//       serializers.serialize(object.displayName,
//           specifiedType: const FullType(String)),
//       'photo_url',
//       serializers.serialize(object.photoUrl,
//           specifiedType: const FullType(String)),
//       'uid',
//       serializers.serialize(object.uid, specifiedType: const FullType(String)),
//       'created_time',
//       serializers.serialize(object.createdTime,
//           specifiedType: const FullType(Timestamp)),
//       'verified',
//       serializers.serialize(object.verified,
//           specifiedType: const FullType(bool)),
//       'mobileNumber',
//       serializers.serialize(object.mobileNumber,
//           specifiedType: const FullType(String)),
//       'userId',
//       serializers.serialize(object.userId,
//           specifiedType: const FullType(
//               DocumentReference, const [const FullType.nullable(Object)])),
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
//   AdminUsersRecord deserialize(
//       Serializers serializers, Iterable<Object?> serialized,
//       {FullType specifiedType = FullType.unspecified}) {
//     final result = new AdminUsersRecordBuilder();
//
//     final iterator = serialized.iterator;
//     while (iterator.moveNext()) {
//       final key = iterator.current! as String;
//       iterator.moveNext();
//       final Object? value = iterator.current;
//       switch (key) {
//         case 'email':
//           result.email = serializers.deserialize(value,
//               specifiedType: const FullType(String))! as String;
//           break;
//         case 'display_name':
//           result.displayName = serializers.deserialize(value,
//               specifiedType: const FullType(String))! as String;
//           break;
//         case 'photo_url':
//           result.photoUrl = serializers.deserialize(value,
//               specifiedType: const FullType(String))! as String;
//           break;
//         case 'uid':
//           result.uid = serializers.deserialize(value,
//               specifiedType: const FullType(String))! as String;
//           break;
//         case 'created_time':
//           result.createdTime = serializers.deserialize(value,
//               specifiedType: const FullType(Timestamp))! as Timestamp;
//           break;
//         case 'verified':
//           result.verified = serializers.deserialize(value,
//               specifiedType: const FullType(bool))! as bool;
//           break;
//         case 'mobileNumber':
//           result.mobileNumber = serializers.deserialize(value,
//               specifiedType: const FullType(String))! as String;
//           break;
//         case 'userId':
//           result.userId = serializers.deserialize(value,
//               specifiedType: const FullType(DocumentReference, const [
//                 const FullType.nullable(Object)
//               ]))! as DocumentReference<Object?>;
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
// class _$AdminUsersRecord extends AdminUsersRecord {
//   @override
//   final String email;
//   @override
//   final String displayName;
//   @override
//   final String photoUrl;
//   @override
//   final String uid;
//   @override
//   final Timestamp createdTime;
//   @override
//   final bool verified;
//   @override
//   final String mobileNumber;
//   @override
//   final DocumentReference<Object?> userId;
//   @override
//   final DocumentReference<Object?> reference;
//
//   factory _$AdminUsersRecord(
//           [void Function(AdminUsersRecordBuilder)? updates]) =>
//       (new AdminUsersRecordBuilder()..update(updates))._build();
//
//   _$AdminUsersRecord._(
//       {required this.email,
//       required this.displayName,
//       required this.photoUrl,
//       required this.uid,
//       required this.createdTime,
//       required this.verified,
//       required this.mobileNumber,
//       required this.userId,
//       required this.reference})
//       : super._() {
//     BuiltValueNullFieldError.checkNotNull(email, r'AdminUsersRecord', 'email');
//     BuiltValueNullFieldError.checkNotNull(
//         displayName, r'AdminUsersRecord', 'displayName');
//     BuiltValueNullFieldError.checkNotNull(
//         photoUrl, r'AdminUsersRecord', 'photoUrl');
//     BuiltValueNullFieldError.checkNotNull(uid, r'AdminUsersRecord', 'uid');
//     BuiltValueNullFieldError.checkNotNull(
//         createdTime, r'AdminUsersRecord', 'createdTime');
//     BuiltValueNullFieldError.checkNotNull(
//         verified, r'AdminUsersRecord', 'verified');
//     BuiltValueNullFieldError.checkNotNull(
//         mobileNumber, r'AdminUsersRecord', 'mobileNumber');
//     BuiltValueNullFieldError.checkNotNull(
//         userId, r'AdminUsersRecord', 'userId');
//     BuiltValueNullFieldError.checkNotNull(
//         reference, r'AdminUsersRecord', 'reference');
//   }
//
//   @override
//   AdminUsersRecord rebuild(void Function(AdminUsersRecordBuilder) updates) =>
//       (toBuilder()..update(updates)).build();
//
//   @override
//   AdminUsersRecordBuilder toBuilder() =>
//       new AdminUsersRecordBuilder()..replace(this);
//
//   @override
//   bool operator ==(Object other) {
//     if (identical(other, this)) return true;
//     return other is AdminUsersRecord &&
//         email == other.email &&
//         displayName == other.displayName &&
//         photoUrl == other.photoUrl &&
//         uid == other.uid &&
//         createdTime == other.createdTime &&
//         verified == other.verified &&
//         mobileNumber == other.mobileNumber &&
//         userId == other.userId &&
//         reference == other.reference;
//   }
//
//   @override
//   int get hashCode {
//     var _$hash = 0;
//     _$hash = $jc(_$hash, email.hashCode);
//     _$hash = $jc(_$hash, displayName.hashCode);
//     _$hash = $jc(_$hash, photoUrl.hashCode);
//     _$hash = $jc(_$hash, uid.hashCode);
//     _$hash = $jc(_$hash, createdTime.hashCode);
//     _$hash = $jc(_$hash, verified.hashCode);
//     _$hash = $jc(_$hash, mobileNumber.hashCode);
//     _$hash = $jc(_$hash, userId.hashCode);
//     _$hash = $jc(_$hash, reference.hashCode);
//     _$hash = $jf(_$hash);
//     return _$hash;
//   }
//
//   @override
//   String toString() {
//     return (newBuiltValueToStringHelper(r'AdminUsersRecord')
//           ..add('email', email)
//           ..add('displayName', displayName)
//           ..add('photoUrl', photoUrl)
//           ..add('uid', uid)
//           ..add('createdTime', createdTime)
//           ..add('verified', verified)
//           ..add('mobileNumber', mobileNumber)
//           ..add('userId', userId)
//           ..add('reference', reference))
//         .toString();
//   }
// }
//
// class AdminUsersRecordBuilder
//     implements Builder<AdminUsersRecord, AdminUsersRecordBuilder> {
//   _$AdminUsersRecord? _$v;
//
//   String? _email;
//   String? get email => _$this._email;
//   set email(String? email) => _$this._email = email;
//
//   String? _displayName;
//   String? get displayName => _$this._displayName;
//   set displayName(String? displayName) => _$this._displayName = displayName;
//
//   String? _photoUrl;
//   String? get photoUrl => _$this._photoUrl;
//   set photoUrl(String? photoUrl) => _$this._photoUrl = photoUrl;
//
//   String? _uid;
//   String? get uid => _$this._uid;
//   set uid(String? uid) => _$this._uid = uid;
//
//   Timestamp? _createdTime;
//   Timestamp? get createdTime => _$this._createdTime;
//   set createdTime(Timestamp? createdTime) => _$this._createdTime = createdTime;
//
//   bool? _verified;
//   bool? get verified => _$this._verified;
//   set verified(bool? verified) => _$this._verified = verified;
//
//   String? _mobileNumber;
//   String? get mobileNumber => _$this._mobileNumber;
//   set mobileNumber(String? mobileNumber) => _$this._mobileNumber = mobileNumber;
//
//   DocumentReference<Object?>? _userId;
//   DocumentReference<Object?>? get userId => _$this._userId;
//   set userId(DocumentReference<Object?>? userId) => _$this._userId = userId;
//
//   DocumentReference<Object?>? _reference;
//   DocumentReference<Object?>? get reference => _$this._reference;
//   set reference(DocumentReference<Object?>? reference) =>
//       _$this._reference = reference;
//
//   AdminUsersRecordBuilder() {
//     AdminUsersRecord._initializeBuilder(this);
//   }
//
//   AdminUsersRecordBuilder get _$this {
//     final $v = _$v;
//     if ($v != null) {
//       _email = $v.email;
//       _displayName = $v.displayName;
//       _photoUrl = $v.photoUrl;
//       _uid = $v.uid;
//       _createdTime = $v.createdTime;
//       _verified = $v.verified;
//       _mobileNumber = $v.mobileNumber;
//       _userId = $v.userId;
//       _reference = $v.reference;
//       _$v = null;
//     }
//     return this;
//   }
//
//   @override
//   void replace(AdminUsersRecord other) {
//     ArgumentError.checkNotNull(other, 'other');
//     _$v = other as _$AdminUsersRecord;
//   }
//
//   @override
//   void update(void Function(AdminUsersRecordBuilder)? updates) {
//     if (updates != null) updates(this);
//   }
//
//   @override
//   AdminUsersRecord build() => _build();
//
//   _$AdminUsersRecord _build() {
//     final _$result = _$v ??
//         new _$AdminUsersRecord._(
//             email: BuiltValueNullFieldError.checkNotNull(
//                 email, r'AdminUsersRecord', 'email'),
//             displayName: BuiltValueNullFieldError.checkNotNull(
//                 displayName, r'AdminUsersRecord', 'displayName'),
//             photoUrl: BuiltValueNullFieldError.checkNotNull(
//                 photoUrl, r'AdminUsersRecord', 'photoUrl'),
//             uid: BuiltValueNullFieldError.checkNotNull(
//                 uid, r'AdminUsersRecord', 'uid'),
//             createdTime: BuiltValueNullFieldError.checkNotNull(
//                 createdTime, r'AdminUsersRecord', 'createdTime'),
//             verified: BuiltValueNullFieldError.checkNotNull(
//                 verified, r'AdminUsersRecord', 'verified'),
//             mobileNumber: BuiltValueNullFieldError.checkNotNull(
//                 mobileNumber, r'AdminUsersRecord', 'mobileNumber'),
//             userId: BuiltValueNullFieldError.checkNotNull(
//                 userId, r'AdminUsersRecord', 'userId'),
//             reference: BuiltValueNullFieldError.checkNotNull(
//                 reference, r'AdminUsersRecord', 'reference'));
//     replace(_$result);
//     return _$result;
//   }
// }
//
// // ignore_for_file: deprecated_member_use_from_same_package,type=lint
