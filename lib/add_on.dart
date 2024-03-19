
import 'package:awafi_pos/Branches/branches.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:awafi_pos/backend/backend.dart';
import 'package:awafi_pos/product_card.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'main.dart';

class AddOn extends StatefulWidget {
  final String? product;
  final int? index;
  final Map? item;
  const AddOn({Key? key, this.product, this.index,this.item}) : super(key: key);
  @override
  _AddOnState createState() => _AddOnState();
}
class _AddOnState extends State<AddOn> {
  int? selectedAddonIndex;
  int? selectedRemoveIndex;
  int? selectedAddMoreIndex;
  int? selectedAddLessIndex;
  List? selectedAddOn;
  List? selectedAddOnArabic;
  List? selectedRemove;
  List? selectedRemoveArabic;
  List? selectedAddLess;
  List? selectedAddLessArabic;
  List? selectedAddMore;
  List? selectedAddMoreArabic;
  double addOnPrice=0;
  double removePrice=0;
  double addLessPrice=0;
  double addMorePrice=0;
  List addOnList=[];

  getaddOns(){
    FirebaseFirestore.instance
        .collection("addOn")
        .get()
        .then((value){

      for(var item in value.docs){
        addOnList.add(item);
      }

      setState(() {

      });
    });

  }

  @override
  void initState() {
    currentProduct=widget.product;
    getaddOns();
    selectedAddOn=widget.item!['addOns'];
    selectedAddOnArabic=widget.item!['addOnArabic'];
    selectedRemove=widget.item!['remove'];
    selectedRemoveArabic=widget.item!['removeArabic'];
    selectedAddLess=widget.item!['addLess'];
    selectedAddLessArabic=widget.item!['addLessArabic'];
    selectedAddMore=widget.item!['addMore'];
    selectedAddMoreArabic=widget.item!['addMoreArabic'];
    addOnPrice=double.tryParse(widget.item!['addOnPrice'].toString())!;
    removePrice=double.tryParse(widget.item!['removePrice'].toString())!;
    addLessPrice=double.tryParse(widget.item!['addLessPrice'].toString())!;
    addMorePrice=double.tryParse(widget.item!['addMorePrice'].toString())!;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: Container(
          height: 550,
          width: MediaQuery.of(context).size.width*0.5,
      
          child:widget.product==null
              ?const Center(child: Text('Choose A product first'),)
              :
      
          addOn[currentProduct].length==0 &&
              remove[currentProduct].length==0 &&
              addMore[currentProduct].length==0 &&
              addLess[currentProduct].length==0
              ? Container(
            child: Center(child: Text('No Addons Found')),
          )
              : SingleChildScrollView(
            child: Column(
                children: [
      
                  //ADD ON
                  Container(
                    width: MediaQuery.of(context).size.width*0.4,
                    child:
                    !addOn.containsKey(currentProduct)||addOn[currentProduct].length==0
                        ?Container()
                        : Column(
                      children: [
                        const SizedBox(height: 10,),
                        const Text("INCLUDED ITEMS",style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                        const SizedBox(height: 10,),
                        GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1,
                          ),
                          scrollDirection: Axis.vertical,
                          itemCount: addOn[currentProduct].length,
                          itemBuilder: (context, int index) {
                            bool added=false;
      
                            return
                              // InkWell(
                              // onTap: () async{
                              //
                              //   await FirebaseFirestore.instance
                              //       .collection('tables')
                              //       .doc(currentBranchId)
                              //       .collection('tables')
                              //       .doc(selectedTable)
                              //       .update({
                              //     'items' :FieldValue.arrayRemove([widget.item])
                              //   });
                              //
                              //   added=true;
                              //   selectedAddonIndex=index;
                              //   if(
                              //   selectedAddOn.contains(addOn[currentProduct][index]['addOn'])&&
                              //       selectedAddOnArabic.contains(addOn[currentProduct][index]['addOnArabic'])){
                              //
                              //     selectedAddOn.remove(addOn[currentProduct][index]['addOn']);
                              //     selectedAddOnArabic.remove(addOn[currentProduct][index]['addOnArabic']);
                              //     addOnPrice-=double.tryParse(addOn[currentProduct][index]['price'].toString());
                              //   }
                              //   else{
                              //
                              //     selectedAddOn.add(addOn[currentProduct][index]['addOn']);
                              //     selectedAddOnArabic.add(addOn[currentProduct][index]['addOnArabic']);
                              //     addOnPrice+=double.tryParse(addOn[currentProduct][index]['price'].toString());
                              //   }
                              //   widget.item['addOns']=selectedAddOn;
                              //   widget.item['addOnArabic']=selectedAddOnArabic;
                              //   widget.item['addOnPrice']=addOnPrice;
                              //
                              //
                              //
                              //   FirebaseFirestore.instance
                              //       .collection('tables')
                              //       .doc(currentBranchId)
                              //       .collection('tables')
                              //       .doc(selectedTable)
                              //       .update({
                              //     'items' :FieldValue.arrayUnion([widget.item])
                              //   });
                              //
                              //   setState(() {
                              //
                              //   });
                              //   // Navigator.pop(context);
                              //
                              // },
                              // child:
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 3,
                                    color: selectedAddOn!.contains(addOn[currentProduct][index]['addOn'])
                                        ? Colors.blue
                                        : Colors.white30,
                                  ),
                                  color: const Color(0xFFEEEEEE),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          imageUrl: addOn[currentProduct][index]['imageUrl'],
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      addOn[currentProduct][index]['addOn'],
                                      style: FlutterFlowTheme.bodyText1,
                                    ),
                                    double.tryParse(addOn[currentProduct][index]['price']??0)! >0? Text(
                                      'SR ${addOn[currentProduct][index]['price']}',
                                      style:TextStyle(color: Colors.red,fontSize: fontSize),
                                        // FlutterFlowTheme.bodyText1
                                    ):Container()
                                  ],
                                ),
                              );
                            // );
                          },
                        ),
                      ],
                    ),
                  ),
      
                  //ADD MORE
                  Container(
                    width: MediaQuery.of(context).size.width*0.4,
                    child:
                    !addMore.containsKey(currentProduct)||addMore[currentProduct].length==0
                        ?Container()
                        : Column(
                      children: [
      
                        const SizedBox(height: 10,),
                        const Text("ADD MORE ITEMS",style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                        const SizedBox(height: 10,),
      
                        GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1,
                          ),
                          scrollDirection: Axis.vertical,
                          itemCount: addMore[currentProduct].length,
                          itemBuilder: (context, int index) {
                            bool added=false;
      
                            return InkWell(
                              onTap: () async{
      
                                await FirebaseFirestore.instance
                                    .collection('tables')
                                    .doc(currentBranchId)
                                    .collection('tables')
                                    .doc(selectedTable)
                                    .update({
                                  'items' :FieldValue.arrayRemove([widget.item])
                                });
      
                                added=true;
                                selectedAddMoreIndex=index;
                                if(selectedAddMore!.contains(addMore[currentProduct][index]['addOn'])&&
                                    selectedAddMoreArabic!.contains(addMore[currentProduct][index]['addOnArabic'])){
                                  print("IF   IF");
                                  selectedAddMore!.remove(addMore[currentProduct][index]['addOn']);
                                  selectedAddMoreArabic!.remove(addMore[currentProduct][index]['addOnArabic']);
                                  addMorePrice-=double.tryParse(addMore[currentProduct][index]['price'].toString())!;
                                }
                                else{
                                  print("ELSE");
                                  selectedAddMore!.add(addMore[currentProduct][index]['addOn']);
                                  selectedAddMoreArabic!.add(addMore[currentProduct][index]['addOnArabic']);
                                  addMorePrice+=double.tryParse(addMore[currentProduct][index]['price'].toString())!;
                                }
      
      
                                widget.item!['addMore']=selectedAddMore;
                                widget.item!['addMoreArabic']=selectedAddMoreArabic;
                                widget.item!['addMorePrice']=addMorePrice;
      
                                FirebaseFirestore.instance
                                    .collection('tables')
                                    .doc(currentBranchId)
                                    .collection('tables')
                                    .doc(selectedTable)
                                    .update({
                                  'items' :FieldValue.arrayUnion([widget.item])
                                });
      
                                setState(() {
      
                                });
                                // Navigator.pop(context);
      
                              },
      
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 3,
                                    color: selectedAddMore!.contains(addMore[currentProduct][index]['addOn'])
                                        ? Colors.blue
                                        : Colors.white30,
                                  ),
                                  color: const Color(0xFFEEEEEE),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          imageUrl: addMore[currentProduct][index]['imageUrl'],
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      addMore[currentProduct][index]['addOn'],
                                      style: FlutterFlowTheme.bodyText1,
                                    ),
                                    double.tryParse(addMore[currentProduct][index]['price']??0)!>0? Text(
                                      'SR ${addMore[currentProduct][index]['price']}',
                                      style:TextStyle(color: Colors.red,fontSize: fontSize),
                                      // FlutterFlowTheme.bodyText1
                                    ):Container()
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
      
                  //ADD LESS
                  Container(
                    width: MediaQuery.of(context).size.width*0.4,
                    child:
                    !addLess.containsKey(currentProduct)||addLess[currentProduct].length==0
                        ?Container()
                        : Column(
                      children: [
      
                        const SizedBox(height: 10,),
                        const Text("ADD LESS ITEMS",style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                        const SizedBox(height: 10,),
      
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1,
                          ),
                          scrollDirection: Axis.vertical,
                          itemCount: addLess[currentProduct].length,
                          itemBuilder: (context, int index) {
                            bool added=false;
      
                            return InkWell(
                              onTap: () async{
      
                                print(currentProduct);
                                print("*****************    GG");
                                await FirebaseFirestore.instance
                                    .collection('tables')
                                    .doc(currentBranchId)
                                    .collection('tables')
                                    .doc(selectedTable)
                                    .update({
                                  'items' :FieldValue.arrayRemove([widget.item])
                                });
      
                                added=true;
                                selectedAddLessIndex=index;
                                if(selectedAddLess!.contains(addLess[currentProduct][index]['addOn'])&&
                                    selectedAddLessArabic!.contains(addLess[currentProduct][index]['addOnArabic'])){
                                  print("IF   IF");
                                  selectedAddLess!.remove(addLess[currentProduct][index]['addOn']);
                                  selectedAddLessArabic!.remove(addLess[currentProduct][index]['addOnArabic']);
                                  addLessPrice-=double.tryParse(addLess[currentProduct][index]['price'].toString())!;
                                }
                                else{
                                  print("ELSE");
                                  selectedAddLess!.add(addLess[currentProduct][index]['addOn']);
                                  selectedAddLessArabic!.add(addLess[currentProduct][index]['addOnArabic']);
                                  addLessPrice+=double.tryParse(addLess[currentProduct][index]['price'].toString())!;
                                }
      
      
                                widget.item!['addLess']=selectedAddLess;
                                widget.item!['addLessArabic']=selectedAddLessArabic;
                                widget.item!['addLessPrice']=addLessPrice;
      
                                FirebaseFirestore.instance
                                    .collection('tables')
                                    .doc(currentBranchId)
                                    .collection('tables')
                                    .doc(selectedTable)
                                    .update({
                                  'items' :FieldValue.arrayUnion([widget.item])
                                });
      
                                setState(() {
      
                                });
                                // Navigator.pop(context);
      
                              },
      
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 3,
                                    color: selectedAddLess!.contains(addLess[currentProduct][index]['addOn'])
                                        ? Colors.blue
                                        : Colors.white30,
                                  ),
                                  color: const Color(0xFFEEEEEE),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          imageUrl: addLess[currentProduct][index]['imageUrl'],
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      addLess[currentProduct][index]['addOn'],
                                      style: FlutterFlowTheme.bodyText1,
                                    ),
                                    double.tryParse(addLess[currentProduct][index]['price']??0)! >0? Text(
                                      'SR ${addLess[currentProduct][index]['price']}',
                                      style:TextStyle(color: Colors.red,fontSize: fontSize),
                                      // FlutterFlowTheme.bodyText1
                                    ):Container()
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
      
                  //REMOVE
                  Container(
                    width: MediaQuery.of(context).size.width*0.4,
                    child:
                    !remove.containsKey(currentProduct)||remove[currentProduct].length==0
                        ?Container()
                        : Column(
                      children: [
      
                        const SizedBox(height: 10,),
                        const Text("REMOVE ITEMS",style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                        const SizedBox(height: 10,),
      
                        GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1,
                          ),
                          scrollDirection: Axis.vertical,
                          itemCount: remove[currentProduct].length,
                          itemBuilder: (context, int index) {
                            bool added=false;
      
                            return InkWell(
                              onTap: () async{
      
                                print("*****************");
                                await FirebaseFirestore.instance
                                    .collection('tables')
                                    .doc(currentBranchId)
                                    .collection('tables')
                                    .doc(selectedTable)
                                    .update({
                                  'items' :FieldValue.arrayRemove([widget.item])
                                });
      
                                added=true;
                                selectedRemoveIndex=index;
                                if(selectedRemove!.contains(remove[currentProduct][index]['addOn'])&&
                                    selectedRemoveArabic!.contains(remove[currentProduct][index]['addOnArabic'])){
                                  print("IF   IF");
                                  selectedRemove!.remove(remove[currentProduct][index]['addOn']);
                                  selectedRemoveArabic!.remove(remove[currentProduct][index]['addOnArabic']);
                                  removePrice-=double.tryParse(remove[currentProduct][index]['price'].toString())!;
                                }
                                else{
                                  print("ELSE");
                                  print(remove[currentProduct][index]);
                                  selectedRemove!.add(remove[currentProduct][index]['addOn']);
                                  selectedRemoveArabic!.add(remove[currentProduct][index]['addOnArabic']);
                                  removePrice+=double.tryParse(remove[currentProduct][index]['price'].toString())!;
                                }
      
      
                                widget.item!['remove']=selectedRemove;
                                widget.item!['removeArabic']=selectedRemoveArabic;
                                widget.item!['removePrice']=removePrice;
      
                                print(widget.item);
                                FirebaseFirestore.instance
                                    .collection('tables')
                                    .doc(currentBranchId)
                                    .collection('tables')
                                    .doc(selectedTable)
                                    .update({
                                  'items' :FieldValue.arrayUnion([widget.item])
                                });
      
                                setState(() {
      
                                });
                                // Navigator.pop(context);
      
                              },
      
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 3,
                                    color: selectedRemove!.contains(remove[currentProduct][index]['addOn'])
                                        ? Colors.blue
                                        : Colors.white30,
                                  ),
                                  color: const Color(0xFFEEEEEE),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          imageUrl: remove[currentProduct][index]['imageUrl'],
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      remove[currentProduct][index]['addOn'],
                                      style: FlutterFlowTheme.bodyText1,
                                    ),
                                    double.tryParse(remove[currentProduct][index]['price']??0)! >0? Text(
                                      'SR ${remove[currentProduct][index]['price']}',
                                      style:TextStyle(color: Colors.red,fontSize: fontSize),
                                      // FlutterFlowTheme.bodyText1
                                    ):Container()
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
      
                  // Container(
                  //   width: MediaQuery.of(context).size.width*0.4,
                  //      height: 500,
                  //     child:GridView.builder(
                  //           shrinkWrap: true,
                  //           padding: EdgeInsets.zero,
                  //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //             crossAxisCount: 4,
                  //             crossAxisSpacing: 10,
                  //             mainAxisSpacing: 10,
                  //             childAspectRatio: 1,
                  //           ),
                  //           scrollDirection: Axis.vertical,
                  //           itemCount: addOnList.length,
                  //           itemBuilder: (context, int index) {
                  //             bool added=false;
                  //
                  //             return InkWell(
                  //               onTap: () async{
                  //                 print(widget.product);
                  //                 print(addOn[widget.product]);
                  //                 print(selectedTable);
                  //                 print(selectedItems);
                  //                 print(selectedAddOn);
                  //                 print("*****************");
                  //
                  //                 if( selectedAddOn.contains(addOnList[index]['addOn'])){
                  //                   DocumentSnapshot doc=  await FirebaseFirestore.instance
                  //                       .collection('tables')
                  //                       .doc(currentBranchId)
                  //                       .collection('tables')
                  //                       .doc(selectedTable).get();
                  //                   List items=doc.get('items');
                  //                   Map test=items[widget.index];
                  //                   items.removeAt(widget.index);
                  //
                  //                   selectedIndex=index;
                  //                   selectedAddOn.remove(addOnList[index]['addOn']);
                  //                   selectedAddOnArabic.remove(addOnList[index]['addOnArabic']);
                  //                   addOnPrice-=double.tryParse(addOnList[index]['price'].toString());
                  //                   test['addOns']=selectedAddOn;
                  //                   test['addOnArabic']=selectedAddOnArabic;
                  //                   test['addOnPrice']=addOnPrice;
                  //                   items.insert(widget.index, test);
                  //                   FirebaseFirestore.instance
                  //                       .collection('tables')
                  //                       .doc(currentBranchId)
                  //                       .collection('tables')
                  //                       .doc(selectedTable)
                  //                       .update({
                  //                     'items' :items
                  //                   });
                  //
                  //                   setState(() {
                  //
                  //                   });
                  //                 }else{
                  //                   print("1234");
                  //
                  //                   DocumentSnapshot doc=  await FirebaseFirestore.instance
                  //                       .collection('tables')
                  //                       .doc(currentBranchId)
                  //                       .collection('tables')
                  //                       .doc(selectedTable).get();
                  //                   List items=doc.get('items');
                  //                   Map test=items[widget.index];
                  //                   // test['pdtname']='${test['pdtname']}-${addOnList[index]['addOn']}';
                  //                   test['pdtname']='${test['pdtname']}';
                  //                   print('trgrggreferferfr');
                  //                   items.removeAt(widget.index);
                  //
                  //
                  //
                  //                   selectedIndex=index;
                  //                   selectedAddOn.add(addOnList[index]['addOn']);
                  //                   selectedAddOnArabic.add(addOnList[index]['addOnArabic']);
                  //                   addOnPrice+=double.tryParse(addOnList[index]['price'].toString());
                  //                   test['addOns']=selectedAddOn;
                  //                   test['addOnArabic']=selectedAddOnArabic;
                  //                   test['addOnPrice']=addOnPrice;
                  //                   items.insert(widget.index, test);
                  //                   FirebaseFirestore.instance
                  //                       .collection('tables')
                  //                       .doc(currentBranchId)
                  //                       .collection('tables')
                  //                       .doc(selectedTable)
                  //                       .update({
                  //                     'items' :items
                  //                   });
                  //
                  //                   setState(() {
                  //
                  //                   });
                  //
                  //                 }
                  //
                  //               },
                  //
                  //               child: Container(
                  //                 width: 100,
                  //                 height: 100,
                  //                 decoration: BoxDecoration(
                  //                   border: Border.all(width: 3,
                  //                     color: selectedAddOn.contains(addOnList[index]['addOn'])
                  //                         ? Colors.blue
                  //                         : Colors.white30,
                  //                   ),
                  //                   color: const Color(0xFFEEEEEE),
                  //                   borderRadius: BorderRadius.circular(15),
                  //                 ),
                  //                 child: Column(
                  //                   mainAxisSize: MainAxisSize.max,
                  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //                   children: [
                  //                     Expanded(
                  //                       child: ClipRRect(
                  //                         borderRadius: BorderRadius.circular(15),
                  //                         child: CachedNetworkImage(
                  //                           imageUrl: addOnList[index]['imageUrl'],
                  //                           width: 80,
                  //                           height: 80,
                  //                           fit: BoxFit.cover,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     Text(
                  //                       addOnList[index]['addOn'],
                  //                       style: FlutterFlowTheme.bodyText1,
                  //                     ),
                  //                     Text(
                  //                       'SR ${addOnList[index]['price']}',
                  //                       style: FlutterFlowTheme.bodyText1,
                  //                     )
                  //                   ],
                  //                 ),
                  //               ),
                  //             );
                  //           },
                  //         ),
                  // )
      
                ]
            ),
          ),
      
        ),
      
        actions: <Widget>[
          TextButton(
            onPressed: () {
      
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
