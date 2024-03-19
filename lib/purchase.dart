
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:awafi_pos/Branches/branches.dart';
import 'package:image_picker/image_picker.dart';

import 'backend/firebase_storage/storage.dart';
import 'flutter_flow/upload_media.dart';
import 'main.dart';
class Purchases extends StatefulWidget {
  const Purchases({Key? key}) : super(key: key);

  @override
  _PurchasesState createState() => _PurchasesState();
}

class _PurchasesState extends State<Purchases> {


  final ImagePicker _picker = ImagePicker();
  String imgurl="";
  XFile? pickedFile;
  // String? uploadedFileUrl1;

  Future<String?> imgPicking() async {
    try {
      print('1');
      pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      var fileName = DateTime.now();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 1),
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(
              width:  20,
            ),
            Text('Uploding..........'),
          ],
        ),
      ));
      var ref1 = FirebaseStorage.instance.ref().child('ProductImages/$fileName');
      print('12');

      await ref1.putFile(File(pickedFile!.path));

      imgurl = (await ref1.getDownloadURL()).toString();

      print(imgurl);
      // showSnackbar(context, "Uploded", false);

      return imgurl;

      // });
    } catch (e) {
      print(e.toString());
    }
  }


  String? uploadedFileUrl1;
  String? invoiceNo;
  String? supplier;
  String? amount;
  String? gst;
  String? gstNo;
  String? description;
  bool disable=false;

  bool cashPayment=false;
  bool bankPayment=false;

  TextEditingController invoiceNoController = TextEditingController();
  TextEditingController supplierController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController gstNoController = TextEditingController();
   @override
  void initState() {
   invoiceNoController=TextEditingController();
   supplierController=TextEditingController();
   amountController=TextEditingController();
   gstController=TextEditingController();
   descriptionController=TextEditingController();
   gstNoController=TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: default_color,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: true,
        title: const Text("Purchase",style: TextStyle(
            fontWeight: FontWeight.bold,
          color: Colors.white
        ),),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding:  EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.15,MediaQuery.of(context).size.height*0.05,MediaQuery.of(context).size.width*0.15,MediaQuery.of(context).size.width*0.05),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
            ),
            child: ListView(
              children: [
                if (uploadedFileUrl1==''||uploadedFileUrl1==null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                      ),
                      child: IconButton(
                        onPressed: () async {

                          // final selectedMedia = await selectMedia(
                          //   maxWidth: 1080.00,
                          //   maxHeight: 1320.00,
                          // );
                          // if (selectedMedia != null &&
                          //     validateFileFormat(
                          //         selectedMedia.storagePath,
                          //         context)) {
                          //   showUploadMessage(
                          //       context, 'Uploading file...',
                          //       showLoading: true);
                          //   final downloadUrl = await uploadData(
                          //       selectedMedia.storagePath,
                          //       selectedMedia.bytes);
                          //   ScaffoldMessenger.of(context)
                          //       .hideCurrentSnackBar();
                          //   if (downloadUrl != null) {
                          //     setState(() =>
                          //     uploadedFileUrl1 = downloadUrl);
                          //     showUploadMessage(context,
                          //         'Media upload Success!');
                          //   } else {
                          //     showUploadMessage(context,
                          //         'Failed to upload media');
                          //   }
                          // }


                          if(Platform.isAndroid){
                            final selectedMedia = await selectMedia(
                              maxWidth: 1080.00,
                              maxHeight: 1320.00,
                            );
                            if (selectedMedia != null &&
                                validateFileFormat(
                                    selectedMedia.storagePath,
                                    context)) {
                              showUploadMessage(
                                  context, 'Uploading file...',
                                  showLoading: true);
                              final downloadUrl = await uploadData(
                                  selectedMedia.storagePath,
                                  selectedMedia.bytes);
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              if (downloadUrl != null) {
                                setState(() =>
                                uploadedFileUrl1 = downloadUrl);
                                showUploadMessage(context,
                                    'Media upload Success!');
                              } else {
                                showUploadMessage(context,
                                    'Failed to upload media');
                              }
                            }
                          }else if(Platform.isWindows){
                            final data=await imgPicking();
                            if(data!=null){
                              uploadedFileUrl1=data;
                              setState(() {

                              });
                            }
                          }


                        },
                        icon: const Icon(
                          Icons.image_rounded,
                          color: Colors.black,
                          size: 50,
                        ),
                        iconSize: 50,
                      ),
                ),
                    ],
                  )
                else Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.1,
                        color: Colors.grey.shade300,
                        child: Image.network(uploadedFileUrl1!,fit: BoxFit.cover,),
                      ),
                      SizedBox(width: 20,),
                      InkWell(
                        onTap: () async {


                          if(Platform.isAndroid){
                            final selectedMedia = await selectMedia(
                              maxWidth: 1080.00,
                              maxHeight: 1320.00,
                            );
                            if (selectedMedia != null &&
                                validateFileFormat(
                                    selectedMedia.storagePath,
                                    context)) {
                              showUploadMessage(
                                  context, 'Uploading file...',
                                  showLoading: true);
                              final downloadUrl = await uploadData(
                                  selectedMedia.storagePath,
                                  selectedMedia.bytes);
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              if (downloadUrl != null) {
                                setState(() =>
                                uploadedFileUrl1 = downloadUrl);
                                showUploadMessage(context,
                                    'Media upload Success!');
                              } else {
                                showUploadMessage(context,
                                    'Failed to upload media');
                              }
                            }
                          }else if(Platform.isWindows){
                            final data=await imgPicking();
                            if(data!=null){
                              uploadedFileUrl1=data;
                              setState(() {

                              });
                            }
                          }


                          // final selectedMedia = await selectMedia(
                          //   maxWidth: 1080.00,
                          //   maxHeight: 1320.00,
                          // );
                          // if (selectedMedia != null &&
                          //     validateFileFormat(
                          //         selectedMedia.storagePath,
                          //         context)) {
                          //   showUploadMessage(
                          //       context, 'Uploading file...',
                          //       showLoading: true);
                          //   final downloadUrl = await uploadData(
                          //       selectedMedia.storagePath,
                          //       selectedMedia.bytes);
                          //   ScaffoldMessenger.of(context)
                          //       .hideCurrentSnackBar();
                          //   if (downloadUrl != null) {
                          //     setState(() =>
                          //     uploadedFileUrl1 = downloadUrl);
                          //     showUploadMessage(context,
                          //         'Media upload Success!');
                          //   } else {
                          //     showUploadMessage(context,
                          //         'Failed to upload media');
                          //   }
                          // }


                        },
                        child: Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Color(0xFF2b0e10),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Text('Change Image'
                            ,style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                              ),),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (value){
                          setState(() {
                            invoiceNo=value;
                          });
                        },
                      controller: invoiceNoController,
                        decoration: InputDecoration(

                          labelText: 'INVOICE NO',
                          hoverColor: Color(0xFF2b0e10),
                          hintText: 'Enter Invoice Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF2b0e10), width: 1.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.09,
                      height: 50,
                      child: Row(
                        children: [
                          Text('Cash',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 17
                          ),
                          ),
                          Checkbox(
                            value: cashPayment,
                            onChanged: (value) {
                              setState(() {
                                cashPayment = !cashPayment;
                                if(cashPayment==true){
                                  bankPayment=false;
                                }
                              });
                            },
                          ),

                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.1,
                      height: 50,
                      child: Row(
                        children: [
                          Text('Bank',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 17
                          ),
                          ),
                          Checkbox(
                            value: bankPayment,
                            onChanged: (value) {
                              setState(() {
                                bankPayment = !bankPayment;
                                if(bankPayment==true){
                                  cashPayment=false;
                                }

                              });
                            },
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value){
                    setState(() {
                      gstNo=value;
                    });
                  },
                  controller: gstNoController,
                  decoration: InputDecoration(
                    labelText: 'VAT NUMBER',
                    hoverColor: Color(0xFF2b0e10),
                    hintText: 'Enter Vat Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2b0e10), width: 1.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value){
                          setState(() {
                            amount=value;
                          });
                        },
                        controller: amountController,
                        decoration: InputDecoration(
                          labelText: 'TOTAL AMOUNT',
                          hoverColor: Color(0xFF2b0e10),
                          hintText: 'Enter Total Amount',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF2b0e10), width: 1.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value){
                          setState(() {
                            gst=value;
                          });
                        },
                        controller: gstController,
                        decoration: InputDecoration(
                          labelText: 'VAT AMOUNT',
                          hoverColor: Color(0xFF2b0e10),
                          hintText: 'Enter Vat Amount',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF2b0e10), width: 1.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                // TextFormField(
                //   onChanged: (value){
                //     setState(() {
                //       supplier=value;
                //     });
                //   },
                //   controller: supplierController,
                //   decoration: InputDecoration(
                //     labelText: 'SUPPLIER NAME',
                //     hoverColor: Color(0xFF2b0e10),
                //     hintText: 'Enter Supplier Name',
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(5.0),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderSide: BorderSide(color: Color(0xFF2b0e10), width: 1.0),
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 20,),
                TextField(
                  keyboardType: TextInputType.multiline,
                  onChanged: (value){
                    setState(() {
                      description=value;
                    });
                  },
                  maxLines: 5,
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'DESCRIPTION',
                    hoverColor: Color(0xFF2b0e10),
                    hintText: 'Enter Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2b0e10), width: 1.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () async {

                        // if(invoiceNo!=null&&gst!=null&&description!=null
                         if(invoiceNo!=null&&description!=null
                            &&amount!=null&&(cashPayment==true||bankPayment==true)){
                          print('nnnnnnnnnnnnnn');

                          DocumentSnapshot doc = await FirebaseFirestore.instance
                              .collection('invoiceNo')
                              .doc(currentBranchId)
                              .get();
                          print( doc.get('purchase'));
                          int voucherNo = doc.get('purchase') + 1;

                          await FirebaseFirestore.instance.collection('purchases')
                              .doc(currentBranchId)
                              .collection('purchases')
                              .add(
                              {
                                'voucherNo': voucherNo,
                                'invoiceNo': invoiceNo,
                                'amount': double.tryParse(amount!),
                                'gst': gst??0,
                                'vatNumber': gstNo??0,
                                'image': uploadedFileUrl1,
                                'description': description,
                                'salesDate' :DateTime.now(),
                                'currentUserId':currentUserId,
                                'cash':cashPayment==true?true:false,
                                'branchId':currentBranchId
                              });
                          FirebaseFirestore.instance
                              .collection('invoiceNo')
                              .doc(currentBranchId)
                              .update({
                            'purchase': FieldValue.increment(1)
                          });


                          showUploadMessage(context, 'Purchase Added Succesfully',);
                          setState(() {
                            invoiceNoController.text = '';
                            supplierController.text = '';
                            amountController.text = '';
                            gstController.text = '';
                            uploadedFileUrl1 = '';
                            descriptionController.text = '';
                            description = '';
                            invoiceNo = '';
                            supplier = '';
                            amount = '';
                            gst = '';
                            cashPayment=false;
                            bankPayment=false;
                          });

                        }else{
                          invoiceNo==null?showUploadMessage(context, 'Please Enter Invoice Number')
                              :(cashPayment==false&&bankPayment==false)?showUploadMessage(context, 'Please Select Payment Method')
                              :gstNo==null?showUploadMessage(context, 'Please Enter Vat Number')
                              :amount==null?showUploadMessage(context, 'Please Enter Amount')
                              :gst==null?showUploadMessage(context, 'Please Enter Vat Amount')
                              :showUploadMessage(context, 'Please Enter description');
                        }

                      },
                      child: Container(
                        height: 50,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFF2b0e10)
                        ),
                        child: const Center(
                          child: Text("ENTER",
                            style: TextStyle(
                              color: Colors.white,
                                fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
