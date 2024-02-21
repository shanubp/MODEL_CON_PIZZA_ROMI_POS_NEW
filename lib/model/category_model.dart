import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel{
  String? categoryId;
  String? imageUrl;
  String? name;
  String? arabicName;
  String? branchId;
  int? SNo;
  List<String>? search;
  DocumentReference? reference;

//<editor-fold desc="Data Methods">
  CategoryModel({
    this.categoryId,
    this.imageUrl,
    this.name,
    this.arabicName,
    this.branchId,
    this.SNo,
    this.search,
    this.reference,
  });

  CategoryModel copyWith({
    String? categoryId,
    String? imageUrl,
    String? name,
    String? arabicName,
    String? branchId,
    int? SNo,
    List<String>? search,
    DocumentReference? reference,
  }) {
    return CategoryModel(
      categoryId: categoryId ?? this.categoryId,
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      arabicName: arabicName ?? this.arabicName,
      branchId: branchId ?? this.branchId,
      SNo: SNo ?? this.SNo,
      search: search ?? this.search,
      reference: reference ?? this.reference,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categoryId': this.categoryId,
      'imageUrl': this.imageUrl,
      'name': this.name,
      'arabicName': this.arabicName,
      'branchId': this.branchId,
      'SNo': this.SNo,
      'search': this.search,
      'reference': this.reference,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryId: map['categoryId'] ??"",
      imageUrl: map['imageUrl'] ??"",
      name: map['name'] ??"",
      arabicName: map['arabicName'] ??"",
      branchId: map['branchId'] ??"",
      SNo: map['SNo'] ??0,
      search: map['search'] ??[],
      reference: map['reference'] as DocumentReference,
    );
  }

//</editor-fold>
}