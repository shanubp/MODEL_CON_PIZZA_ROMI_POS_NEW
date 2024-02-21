
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:awafi_pos/product_card.dart';
import 'BillWidget/bill_wdget.dart';
import 'backend/backend.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'main.dart';
import 'modals/bag.dart';

List<Map<String,dynamic>> itemList=[];

class BillWidget extends StatefulWidget {
  final  List? items;
  const BillWidget({Key? key, this.items}) : super(key: key);

  @override
  _BillWidgetState createState() => _BillWidgetState();
}

class _BillWidgetState extends State<BillWidget> {
  TextEditingController textController = TextEditingController();
  List items=[];


  final scaffoldKey = GlobalKey<ScaffoldState>();




  @override
  initState(){

    super.initState();
    items=[];

    textController=TextEditingController();

  }

  @override
  Widget build(BuildContext context) {

// if(items.isEmpty){
    items=widget.items!;

//
// }
    return Container(
      // color: Colors.green,
      height: MediaQuery.of(context).size.height*.42,
      padding: const EdgeInsets.only(left: 5,right: 5),
      child:  ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: items.length ?? 0,
          itemBuilder: (context,index){

            // selectedaddonsMap=items[index];
            // selectedRemoveMap=items[index];
            // selectedAddMoreMap=items[index];
            // selectedAddLessMap=items[index];
            String item = items[index]['pdtname'];
            String arabicName = items[index]['arabicName'];

            List  addOns = items[index]['addOns'];
            List  addOnsArabic = items[index]['addOnArabic'];

            double addOnPrice=double.tryParse(items[index]['addOnPrice'].toString())??0+
                double.tryParse(items[index]['addMorePrice'].toString())!??0-
                double.tryParse(items[index]['addLessPrice'].toString())!??0-
                double.tryParse(items[index]['removePrice'].toString())!??0;
            List  remove = items[index]['remove'];
            List  removeArabic = items[index]['removeArabic'];
            double  removePrice=double.tryParse(items[index]['removePrice'].toString())!;
            List  addMore = items[index]['addMore'];
            List  addMoreArabic = items[index]['addMoreArabic'];
            double  addMorePrice=double.tryParse(items[index]['addMorePrice'].toString())!;
            List  addLess = items[index]['addLess'];
            List  addLessArabic = items[index]['addLessArabic'];
            double  addLessPrice=double.tryParse(items[index]['addLessPrice'].toString())!;

            double price=double.tryParse(items[index]['price']!.toStringAsFixed(2))!;
            String catogery=items[index]['category'];
            int progrss = items[index]['qty'];
            List ing=items[index]["ingredients"];
            List variants=items[index]["variants"];
            String variantName=items[index]["variantName"];
            String variantNameArabic=items[index]["variantNameArabic"];

            return  AnimatedContainer(
              curve: Curves.bounceIn,
              duration: Duration(milliseconds: 2000),
              child: billWidget(
                  index: index,
                  name: item,
                  items: widget.items,
                  arabicName: arabicName,
                  price: price,
                  progrss: progrss,
                  category:catogery,
                  ingredients:ing,
                  variants:variants,
                  variantName:variantName,
                  variantNameArabic:variantNameArabic,
                  addOns: addOns,
                  addOnsArabic: addOnsArabic,
                  addOnPrice: addOnPrice,
                  remove:remove,
                  removeArabic:removeArabic,
                  removePrice:removePrice,
                  addMore:addMore,
                  addMoreArabic:addMoreArabic,
                  addMorePrice:addMorePrice,
                  addLess:addLess,
                  addLessArabic:addLessArabic,
                  addLessPrice:addLessPrice







              ),
            );
          }
      ),
    );
  }

  Widget deleteCard() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      decoration: const BoxDecoration(
          color: Colors.grey
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Text("Remove from Bag"),
          Icon(Icons.delete,
            color:Colors.teal,),
        ],
      ),
    );
  }
}
