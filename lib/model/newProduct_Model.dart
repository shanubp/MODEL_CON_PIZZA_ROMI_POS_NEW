


import 'cutRecord_Model.dart';

class NewProductModel{
  String? name;
  String? description;
  String? brand;
  String? subCategory;
  String? category;
  double? price;
  double? discountPrice;
  String? unit;
  String? shopId;
  String? shopName;
  String? userId;
  String? productId;
  List<String>? color;
  List<String>? size;
  List<String>? imageId;
  List<String>? search;
  List<CutRecordModel>? cuts;
  int? ones;
  int? twos;
  int? threes;
  int? fours;
  int? fives;
  bool? available;
  bool? open;
  String?  branchId;
  double? start;
  double? step;
  double? stop;

//<editor-fold desc="Data Methods">
  NewProductModel({
    this.name,
    this.description,
    this.brand,
    this.subCategory,
    this.category,
    this.price,
    this.discountPrice,
    this.unit,
    this.shopId,
    this.shopName,
    this.userId,
    this.productId,
    this.color,
    this.size,
    this.imageId,
    this.search,
    this.cuts,
    this.ones,
    this.twos,
    this.threes,
    this.fours,
    this.fives,
    this.available,
    this.open,
    this.branchId,
    this.start,
    this.step,
    this.stop,
  });

  NewProductModel copyWith({
    String? name,
    String? description,
    String? brand,
    String? subCategory,
    String? category,
    double? price,
    double? discountPrice,
    String? unit,
    String? shopId,
    String? shopName,
    String? userId,
    String? productId,
    List<String>? color,
    List<String>? size,
    List<String>? imageId,
    List<String>? search,
    List<CutRecordModel>? cuts,
    int? ones,
    int? twos,
    int? threes,
    int? fours,
    int? fives,
    bool? available,
    bool? open,
    String? branchId,
    double? start,
    double? step,
    double? stop,
  }) {
    return NewProductModel(
      name: name ?? this.name,
      description: description ?? this.description,
      brand: brand ?? this.brand,
      subCategory: subCategory ?? this.subCategory,
      category: category ?? this.category,
      price: price ?? this.price,
      discountPrice: discountPrice ?? this.discountPrice,
      unit: unit ?? this.unit,
      shopId: shopId ?? this.shopId,
      shopName: shopName ?? this.shopName,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      color: color ?? this.color,
      size: size ?? this.size,
      imageId: imageId ?? this.imageId,
      search: search ?? this.search,
      cuts: cuts ?? this.cuts,
      ones: ones ?? this.ones,
      twos: twos ?? this.twos,
      threes: threes ?? this.threes,
      fours: fours ?? this.fours,
      fives: fives ?? this.fives,
      available: available ?? this.available,
      open: open ?? this.open,
      branchId: branchId ?? this.branchId,
      start: start ?? this.start,
      step: step ?? this.step,
      stop: stop ?? this.stop,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'description': this.description,
      'brand': this.brand,
      'subCategory': this.subCategory,
      'category': this.category,
      'price': this.price,
      'discountPrice': this.discountPrice,
      'unit': this.unit,
      'shopId': this.shopId,
      'shopName': this.shopName,
      'userId': this.userId,
      'productId': this.productId,
      'color': this.color,
      'size': this.size,
      'imageId': this.imageId,
      'search': this.search,
      'cuts': this.cuts,
      'ones': this.ones,
      'twos': this.twos,
      'threes': this.threes,
      'fours': this.fours,
      'fives': this.fives,
      'available': this.available,
      'open': this.open,
      'branchId': this.branchId,
      'start': this.start,
      'step': this.step,
      'stop': this.stop,
    };
  }

  factory NewProductModel.fromMap(Map<String, dynamic> map) {
    return NewProductModel(
      name: map['name'] ??'',
      description: map['description'] ??'',
      brand: map['brand'] ??'',
      subCategory: map['subCategory'] ??'',
      category: map['category'] ??'',
      price: map['price'] ??0.0,
      discountPrice: map['discountPrice'] ??0.0,
      unit: map['unit'] ??'',
      shopId: map['shopId'] ??'',
      shopName: map['shopName'] ??'',
      userId: map['userId'] ??'',
      productId: map['productId'] ??'',
      color: map['color'] ??[] ,
      size: map['size'] ??[],
      imageId: map['imageId'] ??[],
      search: map['search'] ??[],
      cuts: map['cuts'] ??[],
      ones: map['ones'] ??0,
      twos: map['twos'] ??0,
      threes: map['threes'] ??0,
      fours: map['fours'] ??0,
      fives: map['fives'] ??0,
      available: map['available'] ??false,
      open: map['open'] ??false,
      branchId: map['branchId'] ??'',
      start: map['start'] ??0.0,
      step: map['step'] ??0.0,
      stop: map['stop'] ??0.0,
    );
  }

//</editor-fold>
}