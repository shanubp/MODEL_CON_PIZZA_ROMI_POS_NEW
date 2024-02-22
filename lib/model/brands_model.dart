import 'package:firedart/firedart.dart';

class BrandModel{
  String? brand;
  String? brandId;
  String? imageUrl;
  List<String>? search;
  DocumentReference? reference;

//<editor-fold desc="Data Methods">
  BrandModel({
    this.brand,
    this.brandId,
    this.imageUrl,
    this.search,
    this.reference,
  });

  BrandModel copyWith({
    String? brand,
    String? brandId,
    String? imageUrl,
    List<String>? search,
    DocumentReference? reference,
  }) {
    return BrandModel(
      brand: brand ?? this.brand,
      brandId: brandId ?? this.brandId,
      imageUrl: imageUrl ?? this.imageUrl,
      search: search ?? this.search,
      reference: reference ?? this.reference,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'brand': this.brand,
      'brandId': this.brandId,
      'imageUrl': this.imageUrl,
      'search': this.search,
      'reference': this.reference,
    };
  }

  factory BrandModel.fromMap(Map<String, dynamic> map) {
    return BrandModel(
      brand: map['brand'] ??'',
      brandId: map['brandId'] ??'',
      imageUrl: map['imageUrl'] ??'',
      search: map['search'] ??[],
      reference: map['reference'] as DocumentReference,
    );
  }

//</editor-fold>
}