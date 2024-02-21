
import 'package:cloud_firestore/cloud_firestore.dart';

class DesignSettings {
  int category;
  int brand;
  List order;
  bool showVideoBanner;
  String videoBanner;
  bool showBrand;
  int product;
  bool catalogue;
  int leftPaint;
  int rightPaint;
  int phoneAuthentication;
  int newArrivals;
  int subCategory;
  String apiKey;
  int productPaint;


  DesignSettings(
      {required this.category,required this.order,required this.showVideoBanner,required this.videoBanner,required this.brand,required this.showBrand,required this.product,required this.catalogue,required this.leftPaint,required this.rightPaint,required this.phoneAuthentication,required this.newArrivals,required this.subCategory,required this.apiKey,required this.productPaint});

  factory DesignSettings.fromDocument(DocumentSnapshot document) {

    return DesignSettings(
      category: int.parse(document['category'].toString()),
      order: document['order'],
      showVideoBanner: document['showVideoBanner'],
      videoBanner: document['videoBanner'],
      brand: document['brand'],
      showBrand: document['showBrandBanner'],
      product: document['product'],
      catalogue: document['catalogue'],
      leftPaint: document['leftPaint'],
      rightPaint: document['rightPaint'],
      phoneAuthentication :document['phoneAuthentication'],
      newArrivals: document['newArrivals'],
      subCategory: document['subCategory'],
      apiKey: document['apiKey'],
      productPaint: document['productPaint'],
    );
  }
}
