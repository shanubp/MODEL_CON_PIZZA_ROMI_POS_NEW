
import 'dart:developer';

import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:awafi_pos/Branches/branches.dart';
import 'package:awafi_pos/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../add_on.dart';
import '../product_card.dart';

class billWidget extends StatefulWidget {
  final int? index;
  final String? name;
  final String? arabicName;
  final List? addOns;
  final List? addOnsArabic;
  final List? items;
  final double? price;
  final int? progrss;
  final double? addOnPrice;
  final String? category;
  final List? ingredients;
  final List? variants;
  final List? remove;
  final List? addMoreArabic;
  final double? removePrice;
  final double? addMorePrice;
  final double? addLessPrice;
  final List? removeArabic;
  final List? addMore;
  final List? addLess;
  final List? addLessArabic;
  final String? variantName;
  final String? variantNameArabic;

  const   billWidget({Key? key, this.index, this.name, this.arabicName, this.addOns, this.addOnsArabic, this.items, this.price, this.progrss, this.addOnPrice, this.category, this.ingredients, this.variants, this.remove, this.removePrice, this.removeArabic, this.addMore, this.addMoreArabic, this.addMorePrice, this.addLess, this.addLessArabic, this.addLessPrice, this.variantName,this.variantNameArabic,   }) : super(key: key);

  @override
  _billWidgetState createState() => _billWidgetState();
}

class _billWidgetState extends State<billWidget> {
  ArabicNumbers arabicNumber = ArabicNumbers();
  int progress = 0;

  @override
  Widget build(BuildContext context) {

    progress = widget.progrss!;
    log(progress.toString());
    log('progress');

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Center(child: Text(arabicLanguage?(arabicNumber.convert((widget.index!+1).toString())):(widget.index!+1).toString(),style: const TextStyle(
                  fontWeight: FontWeight.bold
              ),)),
            ),
            Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {




                            return StatefulBuilder(
                                builder: (context,setState)
                                {
                                  // currentProduct=widget.name;



                                  return  AddOn(

                                    product:widget.name,
                                    index: widget.index,
                                    item: widget.items![widget.index!],

                                  );
                                }
                            );
                          }
                      );

                      // currentProduct=widget.name;
                      //
                      // selectedItems = widget.items[widget.index];
                      // print(selectedItems);
                    },
                    child: Center(child: Text(arabicLanguage?"${widget.arabicName} ${widget.variantNameArabic??""}": "${widget.name} ${widget.variantName??''}  ",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold
                      ),)),
                  ),
                  widget.addOns!=null&& widget.addOns!.isNotEmpty
                      ?  Text( arabicLanguage
                      ?"يشمل  :${widget.addOnsArabic.toString().split('[')[1].split(']')[0]}"
                      :"include :${widget.addOns.toString().split('[')[1].split(']')[0]}"
                  )
                      : Container(),
                  widget.remove!=null&&widget.remove!.isNotEmpty
                      ? Text( arabicLanguage
                      ?"يزيل :${widget.removeArabic.toString().split('[')[1].split(']')[0]}"
                      :"remove  :${widget.remove.toString().split('[')[1].split(']')[0]}"
                  )
                      : Container(),
                  widget.addMore!=null&&widget.addMore!. isNotEmpty
                      ? Text(arabicLanguage
                      ?" أضف المزيد :${widget.addMoreArabic.toString().split('[')[1].split(']')[0]}"
                      :"add more :${widget.addMore.toString().split('[')[1].split(']')[0]}"
                  )
                      : Container(),
                  widget.addLess!=null&&widget.addLess!.isNotEmpty
                      ? Text(
                      arabicLanguage
                          ?"أضف أقل :${widget.addLessArabic.toString().split('[')[1].split(']')[0]}"
                          :"add less :${widget.addLess.toString().split('[')[1].split(']')[0]}"
                  )
                      : Container(),

                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                  child: Text(arabicLanguage?arabicNumber.convert((widget.price !+ widget.addOnPrice!+widget.addLessPrice!+widget.removePrice!).toStringAsFixed(2)):(widget.price !+ widget.addOnPrice!+widget.addMorePrice!+widget.addLessPrice!+widget.removePrice!).toStringAsFixed(2),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold
                    ),)),
            ),
            Expanded(
                flex: 3,
                child: Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                        onPressed: () {
                          if(progress!=0){
                            // List incredients=[];
                            int i=0;
                            for(int k=0;k<items.length;k++){
                              if(items[k]['pdtname']==widget.name
                                  &&items[k]['price']==widget.price
                                  && items[k]['addOns'].toString()==widget.addOns.toString()
                                  && items[k]['addMore'].toString()==widget.addMore.toString()
                                  && items[k]['addLess'].toString()==widget.addLess.toString()
                                  && items[k]['remove'].toString()==widget.remove.toString()
                              ){
                                i=k;

                                break;
                              }
                            }
                            items.removeAt(i);

                            if (progress != 1) {
                              items.insert(i,{
                                'pdtname': widget.name ,
                                'arabicName': widget.arabicName,
                                'price': widget.price,
                                'qty': progress - 1,
                                'addOns': widget.addOns,
                                'addOnArabic':widget.addOnsArabic,
                                'addOnPrice': widget.addOnPrice,


                                'addLess':widget.addLess,
                                'addMore': widget.addMore,
                                'remove': widget.remove,
                                'removeArabic':widget.removeArabic,
                                'addLessArabic':widget.addLessArabic,
                                'addMoreArabic':widget.addMoreArabic,
                                'addMorePrice':widget.addMorePrice,
                                'addLessPrice':widget.addLessPrice,
                                'removePrice':widget.removePrice,

                                "category":widget.category,
                                "variants":widget.variants,
                                "variantName":widget.variantName,
                                "variantNameArabic":widget.variantNameArabic,
                                'ingredients':widget.ingredients,
                                'return':false,
                                'returnQty':0

                              });
                            }
                            FirebaseFirestore.instance.collection(
                                'tables')
                                .doc(currentBranchId)
                                .collection('tables')
                                .doc(selectedTable).update(
                                {'items': items
                                });

                            setState(() {
                              progress = progress - 1;


                            });
                          }
                        },
                        icon:  const FaIcon(
                          FontAwesomeIcons.minusCircle,
                          color: Colors.black,
                          size: 20,
                        ),
                        iconSize: 20,
                      ),
                      Text(arabicLanguage?arabicNumber.convert(progress.toString()):progress.toString()),
                      IconButton(
                        onPressed: () {

                          int i=0;
                          List incredients=[];
                          // List varIncredient=[];
                          for(int k=0;k<items.length;k++){
                            if(items[k]['pdtname']==widget.name
                                &&items[k]['price']==widget.price
                                 && items[k]['addOns'].toString()==widget.addOns.toString()
                                 && items[k]['addMore'].toString()==widget.addMore.toString()
                                 && items[k]['addLess'].toString()==widget.addLess.toString()
                                 && items[k]['remove'].toString()==widget.remove.toString()
                            ){

                              i=k;
                              incredients=items[k]["ingredients"];
                              // for( var i in incredients){
                              //   i["quantity"]=i["quantity"]+i["SingleQty"];
                              // }
                              // varIncredient=items[k]['variants']['ingredients'];
                              // for( var j in varIncredient){
                              //   j["quantity"]=j["quantity"]+j["SingleQty"];
                              // }
                              break;
                            }
                          }
                          items.removeAt(i);
                          items.insert(i,{
                            'pdtname': widget.name ,
                            'arabicName':widget.arabicName,
                            'price':widget.price,
                            'qty':progress+1,
                            'addOns':widget.addOns,
                            'addOnArabic':widget.addOnsArabic,
                            'addOnPrice':widget.addOnPrice,

                            'addLess':widget.addLess,
                            'addMore': widget.addMore,
                            'remove': widget.remove,
                            'removeArabic':widget.removeArabic,
                            'addLessArabic':widget.addLessArabic,
                            'addMoreArabic':widget.addMoreArabic,
                            'addMorePrice':widget.addMorePrice,
                            'addLessPrice':widget.addLessPrice,
                            'removePrice':widget.removePrice,

                            "category":widget.category,
                            'ingredients':incredients,
                            "variants":widget.variants,
                            "variantName":widget.variantName,
                            "variantNameArabic":widget.variantNameArabic,
                            'return':false,
                            'returnQty':0

                          }
                          );


                          FirebaseFirestore.instance.collection('tables')
                              .doc(currentBranchId)
                              .collection('tables')
                              .doc(selectedTable).update(
                              {
                                'items' :items
                              });

                          setState(() {
                            progress = progress + 1;

                          });
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.plusCircle,
                          color: Colors.black,
                          size: 20,
                        ),
                        iconSize: 20,
                      )
                    ],
                  ),
                )
            ),
            const SizedBox(width: 20,),
            Expanded(
              flex: 1,
              child:  InkWell(
                onTap: (){

                  FirebaseFirestore.instance.collection('tables')
                      .doc(currentBranchId)
                      .collection('tables')
                      .doc(selectedTable).update(
                      {
                        'items': FieldValue.arrayRemove([widget.items![widget.index!]])
                      });
                },
                child: const Icon(Icons.delete,
                  color:Colors.teal,),
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
