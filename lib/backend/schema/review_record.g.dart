// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'review_record.dart';
//
// // **************************************************************************
// // BuiltValueGenerator
// // **************************************************************************
//
// Serializer<ReviewRecord> _$reviewRecordSerializer =
//     new _$ReviewRecordSerializer();
//
// class _$ReviewRecordSerializer implements StructuredSerializer<ReviewRecord> {
//   @override
//   final Iterable<Type> types = const [ReviewRecord, _$ReviewRecord];
//   @override
//   final String wireName = 'ReviewRecord';
//
//   @override
//   Iterable<Object?> serialize(Serializers serializers, ReviewRecord object,
//       {FullType specifiedType = FullType.unspecified}) {
//     final result = <Object?>[
//       'avatarUrl',
//       serializers.serialize(object.avatarUrl,
//           specifiedType: const FullType(String)),
//       'userId',
//       serializers.serialize(object.userId,
//           specifiedType: const FullType(String)),
//       'username',
//       serializers.serialize(object.username,
//           specifiedType: const FullType(String)),
//       'rating',
//       serializers.serialize(object.rating,
//           specifiedType: const FullType(double)),
//       'review',
//       serializers.serialize(object.review,
//           specifiedType: const FullType(String)),
//       'timestamp',
//       serializers.serialize(object.timestamp,
//           specifiedType: const FullType(Timestamp)),
//     ];
//
//     return result;
//   }
//
//   @override
//   ReviewRecord deserialize(
//       Serializers serializers, Iterable<Object?> serialized,
//       {FullType specifiedType = FullType.unspecified}) {
//     final result = new ReviewRecordBuilder();
//
//     final iterator = serialized.iterator;
//     while (iterator.moveNext()) {
//       final key = iterator.current! as String;
//       iterator.moveNext();
//       final Object? value = iterator.current;
//       switch (key) {
//         case 'avatarUrl':
//           result.avatarUrl = serializers.deserialize(value,
//               specifiedType: const FullType(String))! as String;
//           break;
//         case 'userId':
//           result.userId = serializers.deserialize(value,
//               specifiedType: const FullType(String))! as String;
//           break;
//         case 'username':
//           result.username = serializers.deserialize(value,
//               specifiedType: const FullType(String))! as String;
//           break;
//         case 'rating':
//           result.rating = serializers.deserialize(value,
//               specifiedType: const FullType(double))! as double;
//           break;
//         case 'review':
//           result.review = serializers.deserialize(value,
//               specifiedType: const FullType(String))! as String;
//           break;
//         case 'timestamp':
//           result.timestamp = serializers.deserialize(value,
//               specifiedType: const FullType(Timestamp))! as Timestamp;
//           break;
//       }
//     }
//
//     return result.build();
//   }
// }
//
// class _$ReviewRecord extends ReviewRecord {
//   @override
//   final String avatarUrl;
//   @override
//   final String userId;
//   @override
//   final String username;
//   @override
//   final double rating;
//   @override
//   final String review;
//   @override
//   final Timestamp timestamp;
//
//   factory _$ReviewRecord([void Function(ReviewRecordBuilder)? updates]) =>
//       (new ReviewRecordBuilder()..update(updates))._build();
//
//   _$ReviewRecord._(
//       {required this.avatarUrl,
//       required this.userId,
//       required this.username,
//       required this.rating,
//       required this.review,
//       required this.timestamp})
//       : super._() {
//     BuiltValueNullFieldError.checkNotNull(
//         avatarUrl, r'ReviewRecord', 'avatarUrl');
//     BuiltValueNullFieldError.checkNotNull(userId, r'ReviewRecord', 'userId');
//     BuiltValueNullFieldError.checkNotNull(
//         username, r'ReviewRecord', 'username');
//     BuiltValueNullFieldError.checkNotNull(rating, r'ReviewRecord', 'rating');
//     BuiltValueNullFieldError.checkNotNull(review, r'ReviewRecord', 'review');
//     BuiltValueNullFieldError.checkNotNull(
//         timestamp, r'ReviewRecord', 'timestamp');
//   }
//
//   @override
//   ReviewRecord rebuild(void Function(ReviewRecordBuilder) updates) =>
//       (toBuilder()..update(updates)).build();
//
//   @override
//   ReviewRecordBuilder toBuilder() => new ReviewRecordBuilder()..replace(this);
//
//   @override
//   bool operator ==(Object other) {
//     if (identical(other, this)) return true;
//     return other is ReviewRecord &&
//         avatarUrl == other.avatarUrl &&
//         userId == other.userId &&
//         username == other.username &&
//         rating == other.rating &&
//         review == other.review &&
//         timestamp == other.timestamp;
//   }
//
//   @override
//   int get hashCode {
//     var _$hash = 0;
//     _$hash = $jc(_$hash, avatarUrl.hashCode);
//     _$hash = $jc(_$hash, userId.hashCode);
//     _$hash = $jc(_$hash, username.hashCode);
//     _$hash = $jc(_$hash, rating.hashCode);
//     _$hash = $jc(_$hash, review.hashCode);
//     _$hash = $jc(_$hash, timestamp.hashCode);
//     _$hash = $jf(_$hash);
//     return _$hash;
//   }
//
//   @override
//   String toString() {
//     return (newBuiltValueToStringHelper(r'ReviewRecord')
//           ..add('avatarUrl', avatarUrl)
//           ..add('userId', userId)
//           ..add('username', username)
//           ..add('rating', rating)
//           ..add('review', review)
//           ..add('timestamp', timestamp))
//         .toString();
//   }
// }
//
// class ReviewRecordBuilder
//     implements Builder<ReviewRecord, ReviewRecordBuilder> {
//   _$ReviewRecord? _$v;
//
//   String? _avatarUrl;
//   String? get avatarUrl => _$this._avatarUrl;
//   set avatarUrl(String? avatarUrl) => _$this._avatarUrl = avatarUrl;
//
//   String? _userId;
//   String? get userId => _$this._userId;
//   set userId(String? userId) => _$this._userId = userId;
//
//   String? _username;
//   String? get username => _$this._username;
//   set username(String? username) => _$this._username = username;
//
//   double? _rating;
//   double? get rating => _$this._rating;
//   set rating(double? rating) => _$this._rating = rating;
//
//   String? _review;
//   String? get review => _$this._review;
//   set review(String? review) => _$this._review = review;
//
//   Timestamp? _timestamp;
//   Timestamp? get timestamp => _$this._timestamp;
//   set timestamp(Timestamp? timestamp) => _$this._timestamp = timestamp;
//
//   ReviewRecordBuilder();
//
//   ReviewRecordBuilder get _$this {
//     final $v = _$v;
//     if ($v != null) {
//       _avatarUrl = $v.avatarUrl;
//       _userId = $v.userId;
//       _username = $v.username;
//       _rating = $v.rating;
//       _review = $v.review;
//       _timestamp = $v.timestamp;
//       _$v = null;
//     }
//     return this;
//   }
//
//   @override
//   void replace(ReviewRecord other) {
//     ArgumentError.checkNotNull(other, 'other');
//     _$v = other as _$ReviewRecord;
//   }
//
//   @override
//   void update(void Function(ReviewRecordBuilder)? updates) {
//     if (updates != null) updates(this);
//   }
//
//   @override
//   ReviewRecord build() => _build();
//
//   _$ReviewRecord _build() {
//     final _$result = _$v ??
//         new _$ReviewRecord._(
//             avatarUrl: BuiltValueNullFieldError.checkNotNull(
//                 avatarUrl, r'ReviewRecord', 'avatarUrl'),
//             userId: BuiltValueNullFieldError.checkNotNull(
//                 userId, r'ReviewRecord', 'userId'),
//             username: BuiltValueNullFieldError.checkNotNull(
//                 username, r'ReviewRecord', 'username'),
//             rating: BuiltValueNullFieldError.checkNotNull(
//                 rating, r'ReviewRecord', 'rating'),
//             review: BuiltValueNullFieldError.checkNotNull(
//                 review, r'ReviewRecord', 'review'),
//             timestamp: BuiltValueNullFieldError.checkNotNull(
//                 timestamp, r'ReviewRecord', 'timestamp'));
//     replace(_$result);
//     return _$result;
//   }
// }
//
// // ignore_for_file: deprecated_member_use_from_same_package,type=lint
