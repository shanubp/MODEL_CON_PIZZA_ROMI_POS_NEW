

import 'package:awafi_pos/features/home/repository/home_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../flutter_flow/upload_media.dart';
final homeControllerProvider=Provider((ref) => HomeController(homeRepository: ref.read(homeRepositoryProvider)));
final getPosUserProvider=StreamProvider.autoDispose((ref) =>ref.read(homeControllerProvider).getPosUser() );
final getAlertProvider=StreamProvider.autoDispose((ref) =>ref.read(homeControllerProvider).getAlert() );
final getSettingsProvider=StreamProvider.autoDispose((ref) =>ref.read(homeControllerProvider).getSettings() );
final getTokenProvider=StreamProvider.autoDispose((ref) =>ref.read(homeControllerProvider).getToken() );
final getTablesProvider=StreamProvider.autoDispose((ref) =>ref.read(homeControllerProvider).getTables() );
final getTablesItemProvider=StreamProvider.autoDispose((ref) =>ref.read(homeControllerProvider).getTableItem() );
class HomeController{
  final HomeRepository _homeRepository;
  HomeController({required HomeRepository homeRepository}):_homeRepository=homeRepository;
  Stream getPosUser(){
    return _homeRepository.getPosUser();
  }
  Stream<QuerySnapshot<Object?>>getAlert(){
    return _homeRepository.getAlert();
  }
  ingredientsUpdate(List billItems){
    return _homeRepository.ingredientsUpdate(billItems);
  }
  getCreditDetails(String mobileNo){
    return _homeRepository.getCreditDetails(mobileNo);
  }
  Stream getSettings(){
    return _homeRepository.getSettings();
  }
  getPrinters(){
    return _homeRepository.getPrinters();
  }
  getAllCategories() {
    return _homeRepository.getAllCategories();
  }
  Stream<int> getToken(){
    return _homeRepository.getToken();
  }
  Stream<List<String>> getTables(){
    return _homeRepository.getTables();
  }
  addTable(String tab,BuildContext context)async{
    var res=await _homeRepository.addTable(tab);
    res.fold((l) => showUploadMessage(context, l.message), (r) {
      Navigator.pop(
        context,
      );
      showUploadMessage(context, "New table Added");
    } );
  }
  deleteTable(String tab,BuildContext context)async{
    var res=await _homeRepository.deleteTable(tab);
    res.fold((l) => showUploadMessage(context, l.message), (r) {

      showUploadMessage(context,  'Table Deleted...');
    } );
  }
  tokenClear(BuildContext context)async{
    var res=await _homeRepository.tokenClear();
    res.fold((l) => showUploadMessage(context, l.message), (r) {
      Navigator.pop(context);
      showUploadMessage(
          context, 'Token Cleared');

    } );
  }
  Stream<DocumentSnapshot<Map<String,dynamic>>> getTableItem(){
    return _homeRepository.getTableItem();
  }
  Future<DocumentSnapshot>getInvoices(){
    return _homeRepository.getInvoices();
  }
  creditUserApprove(int invoiceNo,int token,String paidCash,List<String>ingredientIds,String amex,String visa,String mada,String master,String dropdownvalue,BuildContext context, bool approve)async{
    var res=await _homeRepository.creditUserApprove(invoiceNo, token, paidCash, ingredientIds, amex, visa, mada, master, dropdownvalue,approve);
    res.fold((l) =>showUploadMessage(context, l.message), (r) => showUploadMessage(context, "Credit Sales Successfully"));
  }
  saveSales(String paidCash,String amex,String visa,String mada,String master,BuildContext context)async{
    var res=await _homeRepository.saveSales(paidCash, amex, visa, mada, master);
    res.fold((l) =>showUploadMessage(context, l.message), (r) => showUploadMessage(context, 'Saved Successfully'));
  }
  cancelOrder(){
    return _homeRepository.cancelOrder();
  }
  printOrder(
      int invoiceNo,
      int token,
      String paidCash,
      String visa,
      String mada,
      String amex,
      String master,
      List<String> ingredientIds,BuildContext context) async {
    var res=await _homeRepository.printOrder(invoiceNo, token, paidCash, visa, mada, amex, master, ingredientIds);
    res.fold((l) =>showUploadMessage(context, l.message), (r) => showUploadMessage(context, 'Successfully'));
  }
}