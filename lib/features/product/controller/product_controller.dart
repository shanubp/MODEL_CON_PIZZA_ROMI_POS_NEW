import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/product_repository.dart';
final productControllerProvider=Provider((ref) => ProductController(productRepository: ref.read(productRepositoryProvider)));
final getCategoryProvider=StreamProvider.autoDispose((ref) => ref.read(productControllerProvider).getCategory());
final getCategoryProductProvider=StreamProvider.autoDispose.family((ref,String categoryName) => ref.read(productControllerProvider).getProduct(categoryName));
class ProductController{
  final ProductRepository _productRepository;
  ProductController({required  ProductRepository productRepository}):_productRepository=productRepository;
  Future<QuerySnapshot<Object>>getBranch(){
    return _productRepository.getBranch();
  }
  Stream<QuerySnapshot<Object>> getCategory(){
    return _productRepository.getCategory();
  }
  Stream<QuerySnapshot<Object>> getProduct(String categoryName){
    return _productRepository.getProduct(categoryName);
  }
}
