
import 'package:cloud_firestore/cloud_firestore.dart';

class DesignSettings {
  double limit;
 double kmCharge;
 double fixedCharge;
 double fixedChargeLimit;





  DesignSettings(
      {required this.limit,required this.kmCharge,required this.fixedCharge,required this.fixedChargeLimit});

  factory DesignSettings.fromDocument(DocumentSnapshot document) {

    return DesignSettings(
      limit: document['limit'],
      kmCharge: document['kmCharge'],
      fixedCharge: document['fixedCharge'],
      fixedChargeLimit: document['fixedChargeLimit'],

    );
  }
}
