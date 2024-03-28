import 'dart:io';
import 'package:awafi_pos/core/failure.dart';
import 'package:awafi_pos/core/providers/firebaseProviders.dart';
import 'package:awafi_pos/core/type_defs.dart';
import 'package:awafi_pos/features/home/screen/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../Branches/branches.dart';
import '../../../main.dart';

final homeRepositoryProvider =
    Provider((ref) => HomeRepository(firestore: ref.read(firestoreProvider)));

class HomeRepository {
  final FirebaseFirestore _firestore;
  HomeRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;
  Stream getPosUser() {
    return _firestore
        .collection('posUsers')
        .where('deleted', isEqualTo: false)
        .snapshots()
        .map((event) {
      posUsers = event.docs;
      for (var doc in event.docs) {
        PosUserIdToName[doc.id] = doc.get('name');
        PosUserIdToArabicName[doc.id] = doc.get('arabicName');
      }
    });
  }

  Stream<QuerySnapshot<Object?>> getAlert() {
    return _firestore
        .collection('orders')
        .where('branchId', isEqualTo: currentBranchId)
        .orderBy('salesDate', descending: true)
        .where('status', isEqualTo: 0)
        .snapshots();
  }

  ingredientsUpdate(List billItems) {
    for (var a in billItems) {
      for (var b in a['ingredients'] ?? []) {
        _firestore.collection("ingredients").doc(b['ingredientId']).update({
          "quantity": FieldValue.increment(-1 * ((b['quantity']) * a['qty'])),
        });
      }
      for (var b in a['variants'] ?? []) {
        for (var c in b['ingredients'] ?? []) {
          _firestore.collection("ingredients").doc(c['ingredientId']).update({
            "quantity": FieldValue.increment(-1 * (c['quantity'] * a['qty'])),
          });
        }
      }
    }
  }

  getCreditDetails(String mobileNo) {
    _firestore
        .collection('creditUsers')
        .where("deleted", isEqualTo: false)
        .where("branchId", isEqualTo: currentBranchId)
        .where("phone", isEqualTo: mobileNo.trim())
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        print('GETTTTTTTTTTTTTTTT');
        credit = value.docs;
        for (var data in credit) {
          print("GOT ");
          creditMap[data.id] = data.data();

          // creditUsers.add(data.get("name"));
          // mobileNumbers.add(data.get("phone"));
        }
      }
    });
  }

  Stream getSettings() {
    return _firestore.collection('settings').snapshots().map((value) {
      var data = value.docs;
      printWidth = double.tryParse(data[0]['logo'])!;
      qrCode = double.tryParse(data[0]['qr'])!;
      lastCut = data[0]['lastCut'];

      fontSize = double.tryParse(data[0]['fontSize'])!;
      size = double.tryParse(data[0]['size'])!;
      products = data[0]['product'];
      itemCount = data[0]['itemCount'];
      display_image = data[0]['display_image'];
      kotPrinter = data[0]['kotPrinter'];
    });
  }

  getPrinters() {
    _firestore
        .collection('printer')
        .where("branchId", isEqualTo: currentBranchId)
        .where("available", isEqualTo: true)
        .get()
        .then((value) {
      for (DocumentSnapshot<Map<String, dynamic>> printer in value.docs) {
        printers[printer.id] = printer.data();
      }
    });
  }

  getAllCategories() {
    _firestore
        .collection('category')
        .where("branchId", isEqualTo: currentBranchId)
        .get()
        .then((value) {
      for (DocumentSnapshot<Map<String, dynamic>> category in value.docs) {
        allCategories[category['name']] = category.data();
      }
    });
  }

  Stream<int> getToken() {
    return _firestore
        .collection('invoiceNo')
        .doc(currentBranchId)
        .snapshots()
        .map((value) {
      // var token = value.get('token');
      return value.get('token');
    });
  }

  Stream<List<String>> getTables() {
    return _firestore
        .collection('tables')
        .doc(currentBranchId)
        .collection('tables')
        .orderBy('tableNo', descending: false)
        .snapshots()
        .map((event) {
      List<String> tables = [];
      for (DocumentSnapshot doc in event.docs) {
        tables.add(doc.get('name'));
      }
      return tables;
    });
  }

  FutureVoid addTable(String tab) async {
    try {
      return right(await _firestore
          .collection('tables')
          .doc(currentBranchId)
          .collection('tables')
          .doc(tab)
          .set({
        'items': [],
        'name': tab,
        'tableNo': int.parse(tab),
      }));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid deleteTable(String tab) async {
    try {
      QuerySnapshot doc = await _firestore
          .collection('tables')
          .doc(currentBranchId)
          .collection('tables')
          .where('name', isEqualTo: tab)
          // .orderBy('tableNo',descending:true)
          .get();
      var data = doc.docs;
      DocumentSnapshot docs = data[0];
      return right(await docs.reference.delete());
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid tokenClear() async {
    try {
      return right(
          _firestore.collection('invoiceNo').doc(currentBranchId).update({
        'token': 0,
      }));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getTableItem() {
    return _firestore
        .collection('tables')
        .doc(currentBranchId)
        .collection('tables')
        .doc(selectedTable)
        .snapshots();
  }

  Future<DocumentSnapshot> getInvoices() async {
    return await FirebaseFirestore.instance
        .collection('invoiceNo')
        .doc(currentBranchId)
        .get();
  }

  FutureVoid creditUserApprove(
      int invoiceNo,
      int token,
      String paidCash,
      List<String> ingredientIds,
      String amex,
      String visa,
      String mada,
      String master,
      String dropdownvalue,
      bool approve) async {
    try {
      await FirebaseFirestore.instance
          .collection('sales')
          .doc(currentBranchId)
          .collection('sales')
          .doc(invoiceNo.toString())
          .set({
        'currentUserId': currentUserId,
        'salesDate': DateTime.now(),
        'invoiceNo': invoiceNo,
        'token': token,
        'currentBranchId': currentBranchId,
        'currentBranchPhNo': currentBranchPhNo,
        'currentBranchAddress': currentBranchAddress,
        'currentBranchArabic': currentBranchAddressArabic,
        'deliveryCharge': double.tryParse(delivery) ?? 0,
        'table': selectedTable,
        'billItems': items,
        'discount': double.tryParse(discount) ?? 0,
        'totalAmount': totalAmount * 100 / (100 + gst),
        'tax': totalAmount * gst / (100 + gst),
        'grandTotal': totalAmount -
            (double.tryParse(discount) ?? 0) +
            (double.tryParse(delivery) ?? 0),
        'paidCash': double.tryParse(paidCash) ?? 0,
        'paidBank': approve ? 0 : bankPaid ?? 0,
        'cash': approve
            ? false
            : paidCash == '' ||
                    paidCash == '0.0' ||
                    double.tryParse(paidCash)! <= 0 ||
                    paidCash == null
                ? false
                : true,
        'bank': approve || bankPaid <= 0 ? false : true,
        'balance': balance,
        "ingredientIds": ingredientIds,
        'creditSale': approve ? true : false,
        "creditName": approve ? userMap["name"] : "" ?? '',
        "creditNumber": approve ? userMap["phone"] : "" ?? '',
        "AMEX": amex != "0" && amex != "0.0" && amex != "" && amex != null
            ? true
            : false,
        "VISA": visa != "0" && visa != "0.0" && visa != "" && visa != null
            ? true
            : false,
        "MASTER":
            master != "0" && master != "0.0" && master != "" && master != null
                ? true
                : false,
        "MADA": mada != "0" && mada != "0.0" && mada != "" && mada != null
            ? true
            : false,
        "dinnerCertificate": dinnerCertificate ? true : false,
        "amexAmount": double.tryParse(amex) ?? 0,
        "madaAmount": double.tryParse(mada) ?? 0,
        "visaAmount": double.tryParse(visa) ?? 0,
        "masterAmount": double.tryParse(master) ?? 0,
        "cancel": false,
        "orderType": dropdownvalue,
        // "waiterName":currentWaiter
      });
      await FirebaseFirestore.instance
          .collection('invoiceNo')
          .doc(currentBranchId)
          .update({
        'sales': FieldValue.increment(1),
        'token': FieldValue.increment(1)
      });

      await FirebaseFirestore.instance
          .collection('tables')
          .doc(currentBranchId)
          .collection('tables')
          .doc(selectedTable)
          .update({'items': []});
      return right("");
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid saveSales(String paidCash, String amex, String visa, String mada,
      String master) async {
    try {
      DocumentSnapshot tableDoc = await FirebaseFirestore.instance
          .collection('tables')
          .doc(currentBranchId)
          .collection('tables')
          .doc(selectedTable)
          .get();
      List billItems = tableDoc.get('items');
      if (billItems.isNotEmpty) {
        DocumentSnapshot invoiceNoDoc = await FirebaseFirestore.instance
            .collection('invoiceNo')
            .doc(currentBranchId)
            .get();
        FirebaseFirestore.instance
            .collection('invoiceNo')
            .doc(currentBranchId)
            .update({
          'sales': FieldValue.increment(1),
          'token': FieldValue.increment(1)
        });
        int invoiceNo = invoiceNoDoc.get('sales');
        int token = invoiceNoDoc.get('token');
        invoiceNo++;
        token++;
        print("tapped4");
        print(approve);

        List<String> ingredientIds = [];
        for (var a in items) {
          for (var b in a['ingredients'] ?? []) {
            ingredientIds.add(b['ingredientId']);
          }
        }
        print("tapped5");
        print(approve);
        await FirebaseFirestore.instance
            .collection('sales')
            .doc(currentBranchId)
            .collection('sales')
            .doc(invoiceNo.toString())
            .set({
          'currentUserId': currentUserId,
          'salesDate': DateTime.now(),
          'invoiceNo': invoiceNo,
          'token': token,
          'currentBranchId': currentBranchId,
          'currentBranchPhNo': currentBranchPhNo,
          'currentBranchAddress': currentBranchAddress,
          'currentBranchArabic': currentBranchAddressArabic,
          'deliveryCharge': double.tryParse(delivery) ?? 0,
          'table': selectedTable,
          'billItems': items,
          'discount': double.tryParse(discount) ?? 0,
          'totalAmount': totalAmount * 100 / (100 + gst),
          'tax': totalAmount * gst / (100 + gst),
          'grandTotal': totalAmount -
              (double.tryParse(discount) ?? 0) +
              (double.tryParse(delivery) ?? 0),
          'paidCash': double.tryParse(paidCash) ?? 0,
          'paidBank': approve ? 0 : bankPaid ?? 0,
          'cash': approve
              ? false
              : paidCash == '' ||
                      paidCash == '0.0' ||
                      double.tryParse(paidCash)! <= 0 ||
                      paidCash == null
                  ? false
                  : true,
          'bank': approve || bankPaid <= 0 ? false : true,
          'balance': balance,
          "ingredientIds": ingredientIds,
          'creditSale': approve ? true : false,
          "creditName": approve ? userMap["name"] : "" ?? '',
          "creditNumber": approve ? userMap["phone"] : "" ?? '',
          "AMEX": amex != "0" && amex != "0.0" && amex != "" && amex != null
              ? true
              : false,
          "VISA": visa != "0" && visa != "0.0" && visa != "" && visa != null
              ? true
              : false,
          "MASTER":
              master != "0" && master != "0.0" && master != "" && master != null
                  ? true
                  : false,
          "MADA": mada != "0" && mada != "0.0" && mada != "" && mada != null
              ? true
              : false,
          "dinnerCertificate": dinnerCertificate ? true : false,
          "amexAmount": double.tryParse(amex) ?? 0,
          "madaAmount": double.tryParse(mada) ?? 0,
          "visaAmount": double.tryParse(visa) ?? 0,
          "masterAmount": double.tryParse(master) ?? 0,
          "cancel": false,
          "orderType": dropdownvalue,
          // "waiterName":currentWaiter
        });

        await FirebaseFirestore.instance
            .collection('tables')
            .doc(currentBranchId)
            .collection('tables')
            .doc(selectedTable)
            .update({'items': []});
      }
      return right("");
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  cancelOrder() async {
    return await FirebaseFirestore.instance
        .collection('tables')
        .doc(currentBranchId)
        .collection('tables')
        .doc(selectedTable)
        .update({'items': []});
  }

  FutureVoid printOrder(
      int invoiceNo,
      int token,
      String paidCash,
      String visa,
      String mada,
      String amex,
      String master,
      List<String> ingredientIds) async {
    try {
      if (Platform.isAndroid) {
        FirebaseFirestore.instance
            .collection('sales')
            .doc(currentBranchId)
            .collection('sales')
            .doc(invoiceNo.toString())
            .set({
          'currentUserId': currentUserId,
          'salesDate': DateTime.now(),
          'invoiceNo': invoiceNo,
          'token': token,
          'currentBranchId': currentBranchId,
          'currentBranchPhNo': currentBranchPhNo,
          'currentBranchAddress': currentBranchAddress,
          'currentBranchArabic': currentBranchAddressArabic,
          'deliveryCharge': double.tryParse(delivery) ?? 0,
          'table': selectedTable,
          'billItems': items,
          'discount': double.tryParse(discount) ?? 0,
          'totalAmount': totalAmount * 100 / (100 + gst),
          'tax': totalAmount * gst / (100 + gst),
          'grandTotal': totalAmount -
              (double.tryParse(discount) ?? 0) +
              (double.tryParse(delivery) ?? 0),
          'paidCash': double.tryParse(paidCash) ?? 0,
          'paidBank': approve ? 0 : bankPaid ?? 0,
          'cash': approve
              ? false
              : paidCash == '' ||
                      paidCash == '0.0' ||
                      double.tryParse(paidCash)! <= 0 ||
                      paidCash == null
                  ? false
                  : true,
          'bank': approve || bankPaid <= 0 ? false : true,
          'balance': balance,
          "ingredientIds": ingredientIds,
          'creditSale': approve ? true : false,
          "creditName": approve ? userMap["name"] : "" ?? '',
          "creditNumber": approve ? userMap["phone"] : "" ?? '',
          "AMEX": amex != "0" && amex != "0.0" && amex != "" && amex != null
              ? true
              : false,
          "VISA": visa != "0" && visa != "0.0" && visa != "" && visa != null
              ? true
              : false,
          "MASTER":
              master != "0" && master != "0.0" && master != "" && master != null
                  ? true
                  : false,
          "MADA": mada != "0" && mada != "0.0" && mada != "" && mada != null
              ? true
              : false,
          "dinnerCertificate": dinnerCertificate ? true : false,
          "amexAmount": double.tryParse(amex) ?? 0,
          "madaAmount": double.tryParse(mada) ?? 0,
          "visaAmount": double.tryParse(visa) ?? 0,
          "masterAmount": double.tryParse(master) ?? 0,
          "cancel": false,
          "orderType": dropdownvalue,
          // "waiterName":currentWaiter
        });

        FirebaseFirestore.instance
            .collection('invoiceNo')
            .doc(currentBranchId)
            .update({
          'sales': FieldValue.increment(1),
          'token': FieldValue.increment(1)
        });
        FirebaseFirestore.instance
            .collection('tables')
            .doc(currentBranchId)
            .collection('tables')
            .doc(selectedTable)
            .update({'items': []});
      } else {
        FirebaseFirestore.instance
            .collection('sales')
            .doc(currentBranchId)
            .collection('sales')
            .doc(invoiceNo.toString())
            .set({
          'currentUserId': currentUserId,
          'salesDate': DateTime.now(),
          'invoiceNo': invoiceNo,
          'token': token,
          'currentBranchId': currentBranchId,
          'currentBranchPhNo': currentBranchPhNo,
          'currentBranchAddress': currentBranchAddress,
          'currentBranchArabic': currentBranchAddressArabic,
          'deliveryCharge': double.tryParse(delivery) ?? 0,
          'table': selectedTable,
          'billItems': items,
          'discount': double.tryParse(discount) ?? 0,
          'totalAmount': totalAmount * 100 / (100 + gst),
          'tax': totalAmount * gst / (100 + gst),
          'grandTotal': totalAmount -
              (double.tryParse(discount) ?? 0) +
              (double.tryParse(delivery) ?? 0),
          'paidCash': double.tryParse(paidCash) ?? 0,
          'paidBank': approve ? 0 : bankPaid ?? 0,
          'cash': approve
              ? false
              : paidCash == '' ||
                      paidCash == '0.0' ||
                      double.tryParse(paidCash)! <= 0 ||
                      paidCash == null
                  ? false
                  : true,
          'bank': approve || bankPaid <= 0 ? false : true,
          'balance': balance,
          "ingredientIds": ingredientIds,
          'creditSale': approve ? true : false,
          "creditName": approve ? userMap["name"] : "" ?? '',
          "creditNumber": approve ? userMap["phone"] : "" ?? '',
          "AMEX": amex != "0" && amex != "0.0" && amex != "" && amex != null
              ? true
              : false,
          "VISA": visa != "0" && visa != "0.0" && visa != "" && visa != null
              ? true
              : false,
          "MASTER":
              master != "0" && master != "0.0" && master != "" && master != null
                  ? true
                  : false,
          "MADA": mada != "0" && mada != "0.0" && mada != "" && mada != null
              ? true
              : false,
          "dinnerCertificate": dinnerCertificate ? true : false,
          "amexAmount": double.tryParse(amex) ?? 0,
          "madaAmount": double.tryParse(mada) ?? 0,
          "visaAmount": double.tryParse(visa) ?? 0,
          "masterAmount": double.tryParse(master) ?? 0,
          "cancel": false,
          "orderType": dropdownvalue,
          // "waiterName":currentWaiter
        });

        FirebaseFirestore.instance
            .collection('invoiceNo')
            .doc(currentBranchId)
            .update({
          'sales': FieldValue.increment(1),
          'token': FieldValue.increment(1)
        });
        FirebaseFirestore.instance
            .collection('tables')
            .doc(currentBranchId)
            .collection('tables')
            .doc(selectedTable)
            .update({'items': []});
      }
      return right("");
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
