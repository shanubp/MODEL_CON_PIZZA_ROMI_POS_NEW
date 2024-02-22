//
// import 'package:built_value/built_value.dart';
// import 'package:built_value/serializer.dart';
//
// part 'order_items.g.dart';
//
// abstract class OrderItems implements Built<OrderItems, OrderItemsBuilder> {
//
//   String get color;
//   String get id;
//   String get name;
//   double get quantity;
//   String get size;
//
//   String get shopId;
//
//   int get status;
//
//   double get shopDiscount;
//
//   OrderItems._();
//
//   factory OrderItems([updates(OrderItemsBuilder b)]) = _$OrderItems;
//
//   static Serializer<OrderItems> get serializer => _$orderItemsSerializer;
//
// }