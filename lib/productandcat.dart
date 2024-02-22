
import 'dart:async';

import 'package:awafi_pos/model/category_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:awafi_pos/Branches/branches.dart';
import 'package:awafi_pos/product_card.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'backend/backend.dart';
import 'backend/schema/categories_record.dart';
import 'main.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage>  with TickerProviderStateMixin{

  TextEditingController textController  = TextEditingController();
  final pageViewController1 = PageController();
  final pageViewController2 = PageController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TabController? _tabController;


  @override
  void initState() {
    super.initState();
     _tabController = TabController(length: 0, vsync: this);
    textController = TextEditingController();
    getBranches();
  }
  getBranches() async {


    branches=await FirebaseFirestore.instance.collection('branches').get();
    // if(currentUserModel.branchId!=""||currentUserModel.branchId!=null){
    //   for(DocumentSnapshot branch in branches.docs){
    //     if(branch.get('branchId')==currentUserModel.branchId)
    //     {
    //       branchName=branch.get('name');
    //       DocumentSnapshot data1 = await FirebaseFirestore.instance
    //           .collection("settings")
    //           .doc(branch.get('branchId'))
    //           .get();
    //       currentSetting = DesignSettings.fromDocument(data1);
    //     }
    //   }
    //   if(mounted) {
    //     setState(() {
    //
    //     });
    //   }
    // }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          // child: StreamBuilder<List<CategoriesRecord>>(
          child: StreamBuilder<QuerySnapshot>(
            // stream: queryCategoriesRecord(queryBuilder: (categoryRecord)=>
            //     categoryRecord.orderBy('SNo').where('branchId',isEqualTo: currentBranchId),
            // ),
            stream: FirebaseFirestore.instance.collection("category")
                .orderBy("SNo").where("branchId",isEqualTo: currentBranchId).snapshots(),
            builder: (context, snapshot) {

              // Customize what your widget looks like when it's loading.
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              // List<CategoriesRecord>? tabBarCategoryRecordList = snapshot.data;
              List<CategoryModel> tabBarCategoryRecordList = snapshot.data!.docs.map((e)
              => CategoryModel.fromMap(e.data() as Map<String,dynamic>)).toList();

              _tabController = TabController(vsync: this, length: tabBarCategoryRecordList.length+1,);
              List<Widget> tabList=[];
              List<Widget> tabPages=[];

              // for( CategoriesRecord tabBarCategoryRecord in tabBarCategoryRecordList){
              for( CategoryModel tabBarCategoryRecord in tabBarCategoryRecordList){

                tabList.add(
                    SizedBox(
                      width: 120,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          products?
                          Container(
                              height: 50,width: 50,
                              child:CachedNetworkImage (
                                errorWidget: (context, url, error) => Icon(Icons.error), // Placeholder for failed image loading
                                cacheKey: tabBarCategoryRecord.imageUrl, // Set a custom cache key
                                memCacheWidth: 400, // Set a custom width for memory cache
                                memCacheHeight: 400, // Set a custom height for memory cache
                                httpHeaders: {}, // Set custom headers for network requests
                                useOldImageOnUrlChange: true, // Use old image when the URL changes
                                // imageUrl: tabBarCategoryRecord.imageUrl,
                                imageUrl: tabBarCategoryRecord.imageUrl!,
                                fit: BoxFit.contain,
                                width: 300,
                              )
                          ):Container(),
                          const SizedBox(height: 3,),
                          Text(arabicLanguage
                              ? tabBarCategoryRecord.arabicName!
                              :tabBarCategoryRecord.name!,
                            style: const TextStyle(
                              fontSize: 12
                          ),

                            textAlign: TextAlign.center,
                          ),

                        ],
                      ),
                    )
                );
                tabPages.add(tabPage(tabBarCategoryRecord.name!));
              }



              // Customize what your widget looks like with no query results.

              // if (snapshot.data!.isEmpty) {
              if (tabBarCategoryRecordList.isEmpty) {
                return const SizedBox(
                  height: 100,
                  child: Center(
                    child: Text('No results.'),
                  ),
                );
              }

              return DefaultTabController(
                length: tabPages.length,

                child: Column(
                  children: [
                    Container(height: 100,width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(0,15,0,0),
                      decoration: BoxDecoration(
                        color:Colors.grey.shade100,
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(2, 2),
                            blurRadius: 5,
                            color: Colors.black,
                          )
                        ],
                      ),
                      child:  Center(
                        child: TabBar(
                          onTap: (index){
                            setState(() {

                              // DefaultTabController.of(context).animateTo(index);

                            });
                          },
                          labelPadding: const EdgeInsets.only(left:15),
                          labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,fontSize: 18
                          ),
                          unselectedLabelStyle:  const TextStyle(
                              fontWeight: FontWeight.w400,fontSize: 12
                          ),
                          labelColor: Colors.red.shade900,
                          indicatorColor: Colors.pink.shade100,
                          indicatorWeight:1,
                          unselectedLabelColor: Colors.black,
                          tabs:tabList ,
                          isScrollable: true,

                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children:tabPages,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
  Widget tabPage(String categoryName) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('product')
          .where('available',isEqualTo: true)
          .orderBy('SNo').where('branchId',isEqualTo: currentBranchId)
          .where('category',isEqualTo:categoryName )
          .snapshots(),

      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return const Center(
              child: CircularProgressIndicator());
        }

        // Customize what your widget looks like with no query results.
        var data=snapshot.data!.docs;
        return SingleChildScrollView(

          child: Column(
            children: [

              Container(
                margin: const EdgeInsets.only(top: 10),
                color: Colors.white,
                child: GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  padding: const EdgeInsets.all(10),
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing:10,
                    childAspectRatio: 1.0,
                  ),

                  itemCount: data.length,
                  itemBuilder: (context, int index) {


                    return ProductCard(
                      name:data[index]['name'],
                      arabicName:data[index]['arabicName'],
                      discountPrice:(data[index]['discountPrice']!=0&&data[index]['discountPrice']!=null)
                          ?double.tryParse(data[index]['discountPrice'].toString()):data[index]['price']==null?0
                          :double.tryParse(data[index]['price'].toString()),
                      imageUrl:data[index]['imageUrl'],
                      pid:data[index]['productId'],
                      variants:data[index]['variant'],
                      category: data[index]['category'],
                      addOns:data[index]['addOn'],
                      remove:data[index]['remove'],
                      addMore:data[index]['addMore'],
                      addLess:data[index]['addLess'],
                      ingredients:data[index]['ingredients'],
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );

  }
}
