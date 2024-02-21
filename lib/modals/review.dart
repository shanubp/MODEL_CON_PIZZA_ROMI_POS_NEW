
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String username;
  final String userId;
  final String avatarUrl;
  String review;
  double rating;
  final Timestamp timestamp;

  static Serializer? serializer;

  Review(
      {required this.username,
        required this.userId,
        required this.avatarUrl,
        required this.review,
        required this.rating,
        required this.timestamp});

  factory Review.fromMap(Map<String,dynamic> data) {


    return Review(
      username: data['username'],
      userId: data['userId'],
      review: data["review"],
      rating: data["rating"],
      timestamp: data["timestamp"],
      avatarUrl: data["avatarUrl"],
    );
  }




}
