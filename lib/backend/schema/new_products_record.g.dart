// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_products_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<NewProductsRecord> _$newProductsRecordSerializer =
    new _$NewProductsRecordSerializer();

class _$NewProductsRecordSerializer
    implements StructuredSerializer<NewProductsRecord> {
  @override
  final Iterable<Type> types = const [NewProductsRecord, _$NewProductsRecord];
  @override
  final String wireName = 'NewProductsRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, NewProductsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'unit',
      serializers.serialize(object.unit, specifiedType: const FullType(String)),
      'shopId',
      serializers.serialize(object.shopId,
          specifiedType: const FullType(String)),
      'shopName',
      serializers.serialize(object.shopName,
          specifiedType: const FullType(String)),
      'ones',
      serializers.serialize(object.ones, specifiedType: const FullType(int)),
      'twos',
      serializers.serialize(object.twos, specifiedType: const FullType(int)),
      'threes',
      serializers.serialize(object.threes, specifiedType: const FullType(int)),
      'fours',
      serializers.serialize(object.fours, specifiedType: const FullType(int)),
      'fives',
      serializers.serialize(object.fives, specifiedType: const FullType(int)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'price',
      serializers.serialize(object.price,
          specifiedType: const FullType(double)),
      'discountPrice',
      serializers.serialize(object.discountPrice,
          specifiedType: const FullType(double)),
      'userId',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
      'color',
      serializers.serialize(object.color,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'size',
      serializers.serialize(object.size,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'cuts',
      serializers.serialize(object.cuts,
          specifiedType:
              const FullType(BuiltList, const [const FullType(CutRecord)])),
      'imageId',
      serializers.serialize(object.imageId,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'search',
      serializers.serialize(object.search,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'productId',
      serializers.serialize(object.productId,
          specifiedType: const FullType(String)),
      'brand',
      serializers.serialize(object.brand,
          specifiedType: const FullType(String)),
      'subCategory',
      serializers.serialize(object.subCategory,
          specifiedType: const FullType(String)),
      'category',
      serializers.serialize(object.category,
          specifiedType: const FullType(String)),
      'available',
      serializers.serialize(object.available,
          specifiedType: const FullType(bool)),
      'open',
      serializers.serialize(object.open, specifiedType: const FullType(bool)),
      'branchId',
      serializers.serialize(object.branchId,
          specifiedType: const FullType(String)),
      'start',
      serializers.serialize(object.start,
          specifiedType: const FullType(double)),
      'step',
      serializers.serialize(object.step, specifiedType: const FullType(double)),
      'stop',
      serializers.serialize(object.stop, specifiedType: const FullType(double)),
      'Document__Reference__Field',
      serializers.serialize(object.reference,
          specifiedType: const FullType(
              DocumentReference, const [const FullType.nullable(Object)])),
    ];

    return result;
  }

  @override
  NewProductsRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new NewProductsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'unit':
          result.unit = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'shopId':
          result.shopId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'shopName':
          result.shopName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'ones':
          result.ones = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'twos':
          result.twos = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'threes':
          result.threes = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'fours':
          result.fours = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'fives':
          result.fives = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'discountPrice':
          result.discountPrice = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'color':
          result.color.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'size':
          result.size.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'cuts':
          result.cuts.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(CutRecord)]))!
              as BuiltList<Object?>);
          break;
        case 'imageId':
          result.imageId.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'search':
          result.search.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'productId':
          result.productId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'brand':
          result.brand = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'subCategory':
          result.subCategory = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'category':
          result.category = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'available':
          result.available = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'open':
          result.open = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'branchId':
          result.branchId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'start':
          result.start = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'step':
          result.step = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'stop':
          result.stop = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
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

class _$NewProductsRecord extends NewProductsRecord {
  @override
  final String name;
  @override
  final String unit;
  @override
  final String shopId;
  @override
  final String shopName;
  @override
  final int ones;
  @override
  final int twos;
  @override
  final int threes;
  @override
  final int fours;
  @override
  final int fives;
  @override
  final String description;
  @override
  final double price;
  @override
  final double discountPrice;
  @override
  final String userId;
  @override
  final BuiltList<String> color;
  @override
  final BuiltList<String> size;
  @override
  final BuiltList<CutRecord> cuts;
  @override
  final BuiltList<String> imageId;
  @override
  final BuiltList<String> search;
  @override
  final String productId;
  @override
  final String brand;
  @override
  final String subCategory;
  @override
  final String category;
  @override
  final bool available;
  @override
  final bool open;
  @override
  final String branchId;
  @override
  final double start;
  @override
  final double step;
  @override
  final double stop;
  @override
  final DocumentReference<Object?> reference;

  factory _$NewProductsRecord(
          [void Function(NewProductsRecordBuilder)? updates]) =>
      (new NewProductsRecordBuilder()..update(updates))._build();

  _$NewProductsRecord._(
      {required this.name,
      required this.unit,
      required this.shopId,
      required this.shopName,
      required this.ones,
      required this.twos,
      required this.threes,
      required this.fours,
      required this.fives,
      required this.description,
      required this.price,
      required this.discountPrice,
      required this.userId,
      required this.color,
      required this.size,
      required this.cuts,
      required this.imageId,
      required this.search,
      required this.productId,
      required this.brand,
      required this.subCategory,
      required this.category,
      required this.available,
      required this.open,
      required this.branchId,
      required this.start,
      required this.step,
      required this.stop,
      required this.reference})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'NewProductsRecord', 'name');
    BuiltValueNullFieldError.checkNotNull(unit, r'NewProductsRecord', 'unit');
    BuiltValueNullFieldError.checkNotNull(
        shopId, r'NewProductsRecord', 'shopId');
    BuiltValueNullFieldError.checkNotNull(
        shopName, r'NewProductsRecord', 'shopName');
    BuiltValueNullFieldError.checkNotNull(ones, r'NewProductsRecord', 'ones');
    BuiltValueNullFieldError.checkNotNull(twos, r'NewProductsRecord', 'twos');
    BuiltValueNullFieldError.checkNotNull(
        threes, r'NewProductsRecord', 'threes');
    BuiltValueNullFieldError.checkNotNull(fours, r'NewProductsRecord', 'fours');
    BuiltValueNullFieldError.checkNotNull(fives, r'NewProductsRecord', 'fives');
    BuiltValueNullFieldError.checkNotNull(
        description, r'NewProductsRecord', 'description');
    BuiltValueNullFieldError.checkNotNull(price, r'NewProductsRecord', 'price');
    BuiltValueNullFieldError.checkNotNull(
        discountPrice, r'NewProductsRecord', 'discountPrice');
    BuiltValueNullFieldError.checkNotNull(
        userId, r'NewProductsRecord', 'userId');
    BuiltValueNullFieldError.checkNotNull(color, r'NewProductsRecord', 'color');
    BuiltValueNullFieldError.checkNotNull(size, r'NewProductsRecord', 'size');
    BuiltValueNullFieldError.checkNotNull(cuts, r'NewProductsRecord', 'cuts');
    BuiltValueNullFieldError.checkNotNull(
        imageId, r'NewProductsRecord', 'imageId');
    BuiltValueNullFieldError.checkNotNull(
        search, r'NewProductsRecord', 'search');
    BuiltValueNullFieldError.checkNotNull(
        productId, r'NewProductsRecord', 'productId');
    BuiltValueNullFieldError.checkNotNull(brand, r'NewProductsRecord', 'brand');
    BuiltValueNullFieldError.checkNotNull(
        subCategory, r'NewProductsRecord', 'subCategory');
    BuiltValueNullFieldError.checkNotNull(
        category, r'NewProductsRecord', 'category');
    BuiltValueNullFieldError.checkNotNull(
        available, r'NewProductsRecord', 'available');
    BuiltValueNullFieldError.checkNotNull(open, r'NewProductsRecord', 'open');
    BuiltValueNullFieldError.checkNotNull(
        branchId, r'NewProductsRecord', 'branchId');
    BuiltValueNullFieldError.checkNotNull(start, r'NewProductsRecord', 'start');
    BuiltValueNullFieldError.checkNotNull(step, r'NewProductsRecord', 'step');
    BuiltValueNullFieldError.checkNotNull(stop, r'NewProductsRecord', 'stop');
    BuiltValueNullFieldError.checkNotNull(
        reference, r'NewProductsRecord', 'reference');
  }

  @override
  NewProductsRecord rebuild(void Function(NewProductsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NewProductsRecordBuilder toBuilder() =>
      new NewProductsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NewProductsRecord &&
        name == other.name &&
        unit == other.unit &&
        shopId == other.shopId &&
        shopName == other.shopName &&
        ones == other.ones &&
        twos == other.twos &&
        threes == other.threes &&
        fours == other.fours &&
        fives == other.fives &&
        description == other.description &&
        price == other.price &&
        discountPrice == other.discountPrice &&
        userId == other.userId &&
        color == other.color &&
        size == other.size &&
        cuts == other.cuts &&
        imageId == other.imageId &&
        search == other.search &&
        productId == other.productId &&
        brand == other.brand &&
        subCategory == other.subCategory &&
        category == other.category &&
        available == other.available &&
        open == other.open &&
        branchId == other.branchId &&
        start == other.start &&
        step == other.step &&
        stop == other.stop &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, unit.hashCode);
    _$hash = $jc(_$hash, shopId.hashCode);
    _$hash = $jc(_$hash, shopName.hashCode);
    _$hash = $jc(_$hash, ones.hashCode);
    _$hash = $jc(_$hash, twos.hashCode);
    _$hash = $jc(_$hash, threes.hashCode);
    _$hash = $jc(_$hash, fours.hashCode);
    _$hash = $jc(_$hash, fives.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, discountPrice.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, color.hashCode);
    _$hash = $jc(_$hash, size.hashCode);
    _$hash = $jc(_$hash, cuts.hashCode);
    _$hash = $jc(_$hash, imageId.hashCode);
    _$hash = $jc(_$hash, search.hashCode);
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, brand.hashCode);
    _$hash = $jc(_$hash, subCategory.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, available.hashCode);
    _$hash = $jc(_$hash, open.hashCode);
    _$hash = $jc(_$hash, branchId.hashCode);
    _$hash = $jc(_$hash, start.hashCode);
    _$hash = $jc(_$hash, step.hashCode);
    _$hash = $jc(_$hash, stop.hashCode);
    _$hash = $jc(_$hash, reference.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NewProductsRecord')
          ..add('name', name)
          ..add('unit', unit)
          ..add('shopId', shopId)
          ..add('shopName', shopName)
          ..add('ones', ones)
          ..add('twos', twos)
          ..add('threes', threes)
          ..add('fours', fours)
          ..add('fives', fives)
          ..add('description', description)
          ..add('price', price)
          ..add('discountPrice', discountPrice)
          ..add('userId', userId)
          ..add('color', color)
          ..add('size', size)
          ..add('cuts', cuts)
          ..add('imageId', imageId)
          ..add('search', search)
          ..add('productId', productId)
          ..add('brand', brand)
          ..add('subCategory', subCategory)
          ..add('category', category)
          ..add('available', available)
          ..add('open', open)
          ..add('branchId', branchId)
          ..add('start', start)
          ..add('step', step)
          ..add('stop', stop)
          ..add('reference', reference))
        .toString();
  }
}

class NewProductsRecordBuilder
    implements Builder<NewProductsRecord, NewProductsRecordBuilder> {
  _$NewProductsRecord? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _unit;
  String? get unit => _$this._unit;
  set unit(String? unit) => _$this._unit = unit;

  String? _shopId;
  String? get shopId => _$this._shopId;
  set shopId(String? shopId) => _$this._shopId = shopId;

  String? _shopName;
  String? get shopName => _$this._shopName;
  set shopName(String? shopName) => _$this._shopName = shopName;

  int? _ones;
  int? get ones => _$this._ones;
  set ones(int? ones) => _$this._ones = ones;

  int? _twos;
  int? get twos => _$this._twos;
  set twos(int? twos) => _$this._twos = twos;

  int? _threes;
  int? get threes => _$this._threes;
  set threes(int? threes) => _$this._threes = threes;

  int? _fours;
  int? get fours => _$this._fours;
  set fours(int? fours) => _$this._fours = fours;

  int? _fives;
  int? get fives => _$this._fives;
  set fives(int? fives) => _$this._fives = fives;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  double? _price;
  double? get price => _$this._price;
  set price(double? price) => _$this._price = price;

  double? _discountPrice;
  double? get discountPrice => _$this._discountPrice;
  set discountPrice(double? discountPrice) =>
      _$this._discountPrice = discountPrice;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  ListBuilder<String>? _color;
  ListBuilder<String> get color => _$this._color ??= new ListBuilder<String>();
  set color(ListBuilder<String>? color) => _$this._color = color;

  ListBuilder<String>? _size;
  ListBuilder<String> get size => _$this._size ??= new ListBuilder<String>();
  set size(ListBuilder<String>? size) => _$this._size = size;

  ListBuilder<CutRecord>? _cuts;
  ListBuilder<CutRecord> get cuts =>
      _$this._cuts ??= new ListBuilder<CutRecord>();
  set cuts(ListBuilder<CutRecord>? cuts) => _$this._cuts = cuts;

  ListBuilder<String>? _imageId;
  ListBuilder<String> get imageId =>
      _$this._imageId ??= new ListBuilder<String>();
  set imageId(ListBuilder<String>? imageId) => _$this._imageId = imageId;

  ListBuilder<String>? _search;
  ListBuilder<String> get search =>
      _$this._search ??= new ListBuilder<String>();
  set search(ListBuilder<String>? search) => _$this._search = search;

  String? _productId;
  String? get productId => _$this._productId;
  set productId(String? productId) => _$this._productId = productId;

  String? _brand;
  String? get brand => _$this._brand;
  set brand(String? brand) => _$this._brand = brand;

  String? _subCategory;
  String? get subCategory => _$this._subCategory;
  set subCategory(String? subCategory) => _$this._subCategory = subCategory;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  bool? _available;
  bool? get available => _$this._available;
  set available(bool? available) => _$this._available = available;

  bool? _open;
  bool? get open => _$this._open;
  set open(bool? open) => _$this._open = open;

  String? _branchId;
  String? get branchId => _$this._branchId;
  set branchId(String? branchId) => _$this._branchId = branchId;

  double? _start;
  double? get start => _$this._start;
  set start(double? start) => _$this._start = start;

  double? _step;
  double? get step => _$this._step;
  set step(double? step) => _$this._step = step;

  double? _stop;
  double? get stop => _$this._stop;
  set stop(double? stop) => _$this._stop = stop;

  DocumentReference<Object?>? _reference;
  DocumentReference<Object?>? get reference => _$this._reference;
  set reference(DocumentReference<Object?>? reference) =>
      _$this._reference = reference;

  NewProductsRecordBuilder() {
    NewProductsRecord._initializeBuilder(this);
  }

  NewProductsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _unit = $v.unit;
      _shopId = $v.shopId;
      _shopName = $v.shopName;
      _ones = $v.ones;
      _twos = $v.twos;
      _threes = $v.threes;
      _fours = $v.fours;
      _fives = $v.fives;
      _description = $v.description;
      _price = $v.price;
      _discountPrice = $v.discountPrice;
      _userId = $v.userId;
      _color = $v.color.toBuilder();
      _size = $v.size.toBuilder();
      _cuts = $v.cuts.toBuilder();
      _imageId = $v.imageId.toBuilder();
      _search = $v.search.toBuilder();
      _productId = $v.productId;
      _brand = $v.brand;
      _subCategory = $v.subCategory;
      _category = $v.category;
      _available = $v.available;
      _open = $v.open;
      _branchId = $v.branchId;
      _start = $v.start;
      _step = $v.step;
      _stop = $v.stop;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NewProductsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$NewProductsRecord;
  }

  @override
  void update(void Function(NewProductsRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NewProductsRecord build() => _build();

  _$NewProductsRecord _build() {
    _$NewProductsRecord _$result;
    try {
      _$result = _$v ??
          new _$NewProductsRecord._(
              name: BuiltValueNullFieldError.checkNotNull(
                  name, r'NewProductsRecord', 'name'),
              unit: BuiltValueNullFieldError.checkNotNull(
                  unit, r'NewProductsRecord', 'unit'),
              shopId: BuiltValueNullFieldError.checkNotNull(
                  shopId, r'NewProductsRecord', 'shopId'),
              shopName: BuiltValueNullFieldError.checkNotNull(
                  shopName, r'NewProductsRecord', 'shopName'),
              ones: BuiltValueNullFieldError.checkNotNull(
                  ones, r'NewProductsRecord', 'ones'),
              twos: BuiltValueNullFieldError.checkNotNull(
                  twos, r'NewProductsRecord', 'twos'),
              threes: BuiltValueNullFieldError.checkNotNull(
                  threes, r'NewProductsRecord', 'threes'),
              fours: BuiltValueNullFieldError.checkNotNull(
                  fours, r'NewProductsRecord', 'fours'),
              fives: BuiltValueNullFieldError.checkNotNull(
                  fives, r'NewProductsRecord', 'fives'),
              description: BuiltValueNullFieldError.checkNotNull(description, r'NewProductsRecord', 'description'),
              price: BuiltValueNullFieldError.checkNotNull(price, r'NewProductsRecord', 'price'),
              discountPrice: BuiltValueNullFieldError.checkNotNull(discountPrice, r'NewProductsRecord', 'discountPrice'),
              userId: BuiltValueNullFieldError.checkNotNull(userId, r'NewProductsRecord', 'userId'),
              color: color.build(),
              size: size.build(),
              cuts: cuts.build(),
              imageId: imageId.build(),
              search: search.build(),
              productId: BuiltValueNullFieldError.checkNotNull(productId, r'NewProductsRecord', 'productId'),
              brand: BuiltValueNullFieldError.checkNotNull(brand, r'NewProductsRecord', 'brand'),
              subCategory: BuiltValueNullFieldError.checkNotNull(subCategory, r'NewProductsRecord', 'subCategory'),
              category: BuiltValueNullFieldError.checkNotNull(category, r'NewProductsRecord', 'category'),
              available: BuiltValueNullFieldError.checkNotNull(available, r'NewProductsRecord', 'available'),
              open: BuiltValueNullFieldError.checkNotNull(open, r'NewProductsRecord', 'open'),
              branchId: BuiltValueNullFieldError.checkNotNull(branchId, r'NewProductsRecord', 'branchId'),
              start: BuiltValueNullFieldError.checkNotNull(start, r'NewProductsRecord', 'start'),
              step: BuiltValueNullFieldError.checkNotNull(step, r'NewProductsRecord', 'step'),
              stop: BuiltValueNullFieldError.checkNotNull(stop, r'NewProductsRecord', 'stop'),
              reference: BuiltValueNullFieldError.checkNotNull(reference, r'NewProductsRecord', 'reference'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'color';
        color.build();
        _$failedField = 'size';
        size.build();
        _$failedField = 'cuts';
        cuts.build();
        _$failedField = 'imageId';
        imageId.build();
        _$failedField = 'search';
        search.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'NewProductsRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
