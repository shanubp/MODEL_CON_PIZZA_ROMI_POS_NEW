
import 'dart:developer';
import 'dart:io';

import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:awafi_pos/flutter_flow/upload_media.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:awafi_pos/bill.dart';
import 'package:awafi_pos/services/shoppingBagService.dart';
import 'package:awafi_pos/services/userService.dart';
import 'Branches/branches.dart';
import 'backend/schema/new_products_record.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'main.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

List offCategoryLowercase=[];
int qty=0;
Map <String,dynamic>addOn={};
Map <String,dynamic>remove={};
Map <String,dynamic>addMore={};
Map <String,dynamic>addLess={};
List newAddOn=[];
List newAddMore=[];
List newAddLess=[];
List newAddRemove=[];
List newAddOnArabic=[];
double addOnPrice=0;

Map <String,dynamic>originalSelectedItems={};
String? currentProduct;
class ProductCard extends StatefulWidget {
  final  String? name;
  final  String? category;
  final  String? arabicName;
  final  String? pid;
  final  double? discountPrice;
  final  String? imageUrl;
  final Function? set;
  final List? addOns;
  final List? remove;
  final List? addMore;
  final List? addLess;
  final List? variants;
  final List? ingredients;
  const ProductCard({this.name, this.set, this.discountPrice, this.imageUrl, this.pid, this.addOns,this.remove, this.addMore, this.addLess, this.variants,this.arabicName, this.category, this.ingredients,});
  @override
  State<ProductCard> createState() => _ProductCardState();
}
class _ProductCardState extends State<ProductCard> {
  ArabicNumbers arabicNumber = ArabicNumbers();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<State> keyLoader = GlobalKey<State>();
  final UserService _userService = UserService();
  //final ShoppingBagService _shoppingBagService = ShoppingBagService();
  int counter = 0;

  void _incrementCounter() {
    setState(() {
      counter++;
    });
  }

  int totalReviews = 0;
  double avgRating = 0;
  int _itemCount = 1;
  bool ?userLiked;
  bool exist =false;
  NewProductsRecord? product;
  Map<String, dynamic>? currentItem;
  @override
  void initState() {
    super.initState();
    offCatLower();
    if(counter==0){
      qty=counter;

    }

  }
  bucketExistence() {
    String uid = currentUserModel!.id;
    List bag = currentUserModel!.bag;
    for (int i = 0; i < bag.length; i++) {
      Map<String, dynamic> item = bag[i];

      if (item['id'] == product!.productId &&
          item['size'] == "" &&
          item['color'] == "" &&
          item['cut'] == "" &&
          item['unit'] == product!.unit &&
          item['quantity'] == 1.00) {
        setState(() {
          exist = true;
          currentItem=item;

        })
        ;
        break;
      } else {
        setState(() {
          exist = false;
        });
      }
    }
  }

  offCatLower(){
    offCategoryLowercase=[];
    for(var i in offerCategory!){
      offCategoryLowercase.add(i.toLowerCase());
    }
  }



  Future getReviews() async {
    double totalRating = 0;
    try {

      double totRating = 0;
      int noRating = product!.ones+product!.twos+product!.threes+product!.fours+product!.fives;
      totRating=(1.00*product!.ones)+(2.00*product!.twos)+(3.00*product!.threes)+(4.00*product!.fours)+(5.00*product!.fives);
      setState(() {
        totalReviews = noRating;
        avgRating =noRating==0?0: (totRating / noRating);
      });
    } catch (exception) {
      print(exception.toString());
    }
  }
  set(){
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap: () async {

          if(widget.variants!.length==0){

            bool notInCart =true;
            currentProduct=widget.name;
            for(Map<String,dynamic> doc in itemList){
              Map<String,dynamic> item =doc;
              int index=itemList.indexOf(doc);
              if(item['pdtname']==widget.name &&
                  item['price']== (((offCategoryLowercase.contains(widget.category!.toLowerCase()))&&offer)
                      ?widget.discountPrice! *(1-(offerValue!/100)):widget.discountPrice)
              ){

                notInCart=false;
//ne
                await itemList.removeAt(index);
                item['qty']=int.tryParse(item['qty'].toString())!+1;
                 itemList.insert(index, item);
                await  FirebaseFirestore.instance.collection('tables')
                    .doc(currentBranchId)
                    .collection('tables')
                    .doc(selectedTable).update(
                    {
                      'items':itemList
                    });

                setState(() {

                });


              }

            }
            if(notInCart){

              FirebaseFirestore.instance.collection('tables')
                  .doc(currentBranchId)
                  .collection('tables')
                  .doc(selectedTable).update(

                  {
                    'items':FieldValue.arrayUnion([{
                      'pdtname':widget.name,
                      'arabicName':widget.arabicName,
                      'price':((offCategoryLowercase.contains(widget.category!.toLowerCase()))&&offer)?widget.discountPrice!*(1-(offerValue!/100)):widget.discountPrice,
                      'discount':((offCategoryLowercase.contains(widget.category!.toLowerCase()))&&offer)?widget.discountPrice!*(offerValue!/100):0,
                      'qty':1,
                      'addOns':[],
                      'addLess': [],
                      'addMore': [],
                      'remove': [],
                      'addOnArabic':[],
                      'removeArabic':[],
                      'addLessArabic':[],
                      'addMoreArabic':[],
                      'addOnPrice':0.0,
                      'addMorePrice':0.0,
                      'addLessPrice':0.0,
                      'removePrice':0.0,
                      'variants':widget.variants,
                      "variantName":'',
                      "variantNameArabic":'',
                      'category':widget.category,
                      'ingredients':widget.ingredients??[],
                      'return':false,
                      'returnQty':0
                    }])

                  });
              addOn[widget.name!]=widget.addOns;
              remove[widget.name!]=widget.remove;
              addMore[widget.name!]=widget.addMore;
              addLess[widget.name!]=widget.addLess;




            }

          }


          else{
            //ALERT BOX
            showDialog(
                context: context,
                builder: (ctx){
                  return Box(
                      varList:widget.variants!,
                      discountPrice:widget.discountPrice!,
                      name:widget.name!,
                      arabicName:widget.arabicName!,
                      addOns:widget.addOns!,
                      addLess: widget.addLess!,
                      addMore: widget.addMore!,
                      remove: widget.remove!,
                      category: widget.category!,
                      ingredients:widget.ingredients!,
                      offCategoryLowercase:offCategoryLowercase
                  );
                }
            );
          }
        },
        child:  Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: FlutterFlowTheme.tertiaryColor,
          elevation: 10,
          child: Container(
            width: MediaQuery.of(context).size.width * 1,
            decoration:
            const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(0),
              ),
              color: FlutterFlowTheme.tertiaryColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    // color: Colors.yellow,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)
                      ),
                      child: display_image
                          ?CachedNetworkImage (

                        errorWidget: (context, url, error) => Icon(Icons.error), // Placeholder for failed image loading
                        cacheKey: widget.imageUrl, // Set a custom cache key
                        memCacheWidth: 300, // Set a custom width for memory cache
                        memCacheHeight: 300, // Set a custom height for memory cache
                        httpHeaders: {}, // Set custom headers for network requests
                        useOldImageOnUrlChange: true, // Use old image when the URL changes
                        imageUrl: widget.imageUrl!,
                        fit: BoxFit.contain,
                        maxWidthDiskCache: 300,
                        maxHeightDiskCache: 300,
                        // width: 200,
                      )
                          :Container(
                        padding: const EdgeInsets.only(left: 5,right:5,top: 5),
                        child: Container(
                          color: Colors.blueGrey.shade100,
                        ),
                      ),
                    ),
                  ),
                ),

                Center(
                  child: AutoSizeText(
                    (arabicLanguage? widget.arabicName!:widget.name!),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Text(arabicLanguage?arabicNumber.convert(widget.discountPrice.toString()):widget.discountPrice.toString(),
                    style: const TextStyle(
                        color: Color(0xFF33CC33),
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),

                const SizedBox(
                    height: 5
                ),

              ],
            ),
          ),
        ),);
  }



  void showInSnackBar(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: new Text(msg),
        action: SnackBarAction(
          label: 'Close',
          textColor: Colors.white,
          onPressed: () {
            if (mounted) {
              ScaffoldMessenger.of(context).clearSnackBars();
            }
          },
        ),
      ),
    );
  }

  // addToShoppingBag() async {
  //   String msg = await _shoppingBagService.add(
  //       widget.pid,
  //       widget.name,
  //       "",
  //       "",
  //       "",
  //       widget.discountPrice.toString(),
  //       1.00,
  //       double.tryParse(widget.discountPrice.toString()));
  //   bucketExistence();
  //
  //   widget.set!();
  //   setState(() {
  //
  //   });
  // }
}



class Box extends StatefulWidget {
  List? varList;
  String? name;
  double? discountPrice;
  String? arabicName;
  String? category;
  List? addOns;
  List? remove;
  List? addMore;
  List? addLess;
  List? ingredients;
  List? offCategoryLowercase;
  Box({Key ?key,this.varList,this.name,this.discountPrice,this.arabicName,this.addOns,this.remove,this.addMore,this.addLess,this.category,this.ingredients,this.offCategoryLowercase}) : super(key: key);

  @override
  _BoxState createState() => _BoxState();
}

class _BoxState extends State<Box> {
  ArabicNumbers arabicNumber = ArabicNumbers();
  int? selectedIndex;
  double selectedvariantPrice=0;
  String selectedvariantName='';
  String selectedvariantArName='';
  List selectedVarient=[];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title:  Text(arabicLanguage?"اختر البديل":"Choose Variant",style: TextStyle(fontWeight: FontWeight.bold),),
        content:  Container(
          width: MediaQuery.of(context).size.width*0.2,
          height: MediaQuery.of(context).size.height*0.2,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            itemCount: widget.varList!.length,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, int index) {
              return Padding(
                padding:
                const EdgeInsetsDirectional.fromSTEB(
                    10, 0, 10, 10),
                child: InkWell(
                  onTap: () async {

                    setState(() {
                      selectedIndex=index;

                      // selectedvariantPrice=double.tryParse(widget.varList[index]['price']);
                      selectedvariantPrice=(((offCategoryLowercase.contains(widget.category!.toLowerCase()))&&offer)?double.tryParse(widget.varList![index]['price'].toString())!*(1-(offerValue!/100)):double.tryParse(widget.varList![index]['price'].toString()))!;

                      selectedvariantName=widget.varList![index]['variant'];
                      selectedvariantArName=widget.varList![index]['variantArabic'];

                      List data=[];
                      data.add(widget.varList![selectedIndex!]);
                      selectedVarient=data;

                    });
                  },
                  child: Container(
                    color: selectedIndex!=index?Colors.white:Colors.blueGrey.shade200,
                    width: MediaQuery.of(context).size.width*0.15,
                    height: 30,
                    // child: RadioListTile(
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(arabicLanguage?' ${widget.varList![index]['variantArabic']}':"${widget.varList![index]['variant']}",
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(width: 5,),
                        Text(
                         arabicLanguage?"${arabicNumber.convert(widget.varList![index]['price'])}" :' ${widget.varList![index]['price']}',
                          style: FlutterFlowTheme
                              .bodyText1
                              .override(
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child:   Text(arabicLanguage?"يلغي":"Cancel",style:TextStyle(
                  fontSize: 17,
                  color: Colors.red
              )),
            ),
          ),
          TextButton(
            onPressed: () async {
              if(selectedIndex!=null){
                bool notInCart =true;
                currentProduct=widget.name;
                int ind=0;
                for(Map<String,dynamic> item in itemList){


                   if(
                   item['pdtname']==widget.name
                       &&item['variantName']==selectedvariantName
                       &&item['addOn']==widget.addOns
                       &&item['addMore']==widget.addMore
                       &&item['addLess']==widget.addLess
                       &&item['remove']==widget.remove
                   ){

                    notInCart=false;

                    // FirebaseFirestore.instance.collection('tables')
                    //     .doc(currentBranchId)
                    //     .collection('tables')
                    //     .doc(selectedTable).update(
                    //     {
                    //       'items':FieldValue.arrayRemove([{
                    //         // 'pdtname':widget.name,
                    //         // 'arabicName':widget.arabicName,
                    //         // 'price':selectedvariantPrice,
                    //         // 'qty':item['qty'],
                    //         // 'addOns':[],
                    //         // 'addLess': [],
                    //         // 'addMore': [],
                    //         // 'remove': [],
                    //         // 'addOnArabic':[],
                    //         // 'removeArabic':[],
                    //         // 'addLessArabic':[],
                    //         // 'addMoreArabic':[],
                    //         // 'addOnPrice':0,
                    //         // 'addMorePrice':0,
                    //         // 'addLessPrice':0,
                    //         // 'removePrice':0,
                    //         // 'category':widget.category,
                    //         // 'ingredients':widget.ingredients??[],
                    //         // 'variants':selectedVarient??[],
                    //         // "variantName":selectedvariantName??'',
                    //         // "variantNameArabic":selectedvariantArName??'',
                    //         // 'return':false,
                    //         // 'returnQty':0,
                    //         itemList
                    //       }])
                    //
                    //     });

                     itemList[ind]['qty']=itemList[ind]['qty']+1;
                    FirebaseFirestore.instance.collection('tables')
                        .doc(currentBranchId)
                        .collection('tables')
                        .doc(selectedTable).update(
                        {
                          'items':itemList
                          // FieldValue.arrayUnion([{
                          //   'pdtname':widget.name,
                          //   'arabicName':widget.arabicName,
                          //   'price':selectedvariantPrice,
                          //   'qty':item['qty']+1,
                          //   'addOns':[],
                          //   'addLess': [],
                          //   'addMore': [],
                          //   'remove': [],
                          //   'addOnArabic':[],
                          //   'removeArabic':[],
                          //   'addLessArabic':[],
                          //   'addMoreArabic':[],
                          //   'addOnPrice':0,
                          //   'addMorePrice':0,
                          //   'addLessPrice':0,
                          //   'removePrice':0,
                          //   'variants':selectedVarient??[],
                          //   "variantName":selectedvariantName??'',
                          //   "variantNameArabic":selectedvariantArName??'',
                          //   'category':widget.category,
                          //   'ingredients':widget.ingredients??[],
                          //   'return':false,
                          //   'returnQty':0
                          // }])
                        });

                  }
                   ind++;
                }
                if(notInCart){
                  FirebaseFirestore.instance.collection('tables')
                      .doc(currentBranchId)
                      .collection('tables')
                      .doc(selectedTable).update(
                      {
                        'items':FieldValue.arrayUnion([{
                          // 'pdtname':'${widget.name} $selectedvariantName',
                          'pdtname':widget.name,
                          // 'arabicName':'${widget.arabicName} $selectedvariantArName',
                          'arabicName':'${widget.arabicName} ',
                          'price':selectedvariantPrice,
                          'qty':1,
                          'addOns':[],
                          'addLess': [],
                          'addMore': [],
                          'remove': [],
                          'addOnArabic':[],
                          'removeArabic':[],
                          'addLessArabic':[],
                          'addMoreArabic':[],
                          'addOnPrice':0.0,
                          'addMorePrice':0.0,
                          'addLessPrice':0.0,
                          'removePrice':0.0,
                          'variants':selectedVarient,
                          "variantName":selectedvariantName,
                          "variantNameArabic":selectedvariantArName,
                          'category':widget.category,
                          'ingredients':widget.ingredients??[],
                          'return':false,
                          'returnQty':0
                        }])
                      });
                  addOn[widget.name!]=widget.addOns;
                  remove[widget.name!]=widget.remove;
                  addMore[widget.name!]=widget.addMore;
                  addLess[widget.name!]=widget.addLess;
                }

                Navigator.of(context).pop();
              }

            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child:   Text(arabicLanguage?"منتهي":"Done",style:const TextStyle(
                  fontSize: 17,
                  color: Colors.blue
              )),
            ),
          ),
        ],
      ),
    );
  }
}
