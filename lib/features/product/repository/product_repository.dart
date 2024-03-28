import 'package:awafi_pos/core/providers/firebaseProviders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Branches/branches.dart';
final productRepositoryProvider=Provider((ref) => ProductRepository(firestore: ref.read(firestoreProvider)));
class ProductRepository{
final FirebaseFirestore _firestore;
ProductRepository({required FirebaseFirestore firestore}):_firestore=firestore;
Future<QuerySnapshot<Object>>getBranch() async {
 return await FirebaseFirestore.instance.collection('branches').get();

}
Stream<QuerySnapshot<Object>> getCategory(){
 return _firestore.collection("category")
     .orderBy("SNo").where("branchId",isEqualTo: currentBranchId).snapshots();
}
Stream<QuerySnapshot<Object>> getProduct(String categoryName){
 return _firestore.collection('product')
     .where('available',isEqualTo: true)
     .orderBy('SNo').where('branchId',isEqualTo: currentBranchId)
     .where('category',isEqualTo:categoryName )
     .snapshots();
}
}