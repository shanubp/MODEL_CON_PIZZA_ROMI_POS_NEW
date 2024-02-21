
import 'package:awafi_pos/backend/backend.dart';

class Bag {
   String color;
   String cut;
  String name;
  double quantity;
  String size;
   String unit;
  NewProductsRecord product;
  double promoDiscount;



   Bag(
      {required this.color,
        required this.cut,
        required this.name,
        required this.quantity,
        required this.size,
        required this.unit,
        required this.product,
        this.promoDiscount=0.00,
      });

  // factory Bag.fromDocument(DocumentSnapshot document) {
  //
  //   return Bag(
  //     color: document['color'],
  //     cut: document['cut'],
  //     name: document['name'],
  //     quantity: document['quantity'],
  //     size: document['size'],
  //     unit: document['unit'],
  //     product: document['product'],
  //
  //   );
  // }
}
