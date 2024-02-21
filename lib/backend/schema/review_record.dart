
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'serializers.dart';

part 'review_record.g.dart';

abstract class ReviewRecord
    implements Built<ReviewRecord, ReviewRecordBuilder> {



  String get avatarUrl;


  String get userId;


  String get username;


  double get rating;


  String get review;


  Timestamp get timestamp;


  ReviewRecord._();

  factory ReviewRecord([updates(ReviewRecordBuilder b)]) = _$ReviewRecord;

  static Serializer<ReviewRecord> get serializer =>
      _$reviewRecordSerializer;
}

  Map<String, dynamic> createReviewRecordData({
  String? avatarUrl,
  String?  userId,
  String?  username,
   double?  rating,
  String?  review,
  Timestamp? timestamp,
  }) =>
      serializers.serializeWith(
          ReviewRecord.serializer,
          ReviewRecord((n) => n
            ..avatarUrl = avatarUrl!
            ..userId = userId!
            ..username = username!
            ..rating=rating!
            ..review = review!
            ..timestamp=timestamp!))as Map<String,dynamic>;
