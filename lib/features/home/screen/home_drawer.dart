import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../DailyReport/dailyReport.dart';
import '../../../History/history.dart';
import '../../../auth/auth_util.dart';
import '../../../expenses.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../main.dart';
import '../../../orders/orders_widget.dart';
import '../../../purchase.dart';
import '../../../reports/expense_reports.dart';
import '../../../reports/purchase_reports.dart';
import '../../../return/sales_return.dart';
import '../../auth/screen/login.dart';

class HomeDrawer extends StatefulWidget {
  final StateSetter setState;
  const HomeDrawer({super.key,required this.setState});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(

      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                color: default_color,
                padding: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),

                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        arabicLanguage
                            ? "${PosUserIdToArabicName[currentUserId]}"
                            : "${PosUserIdToName[currentUserId]}",
                        style: TextStyle(color: Colors.white),
                      ),

                      //image close
                      Container(
                        child: SwitchListTile.adaptive(
                          value: display_image ??= true,
                          onChanged: (newValue) async {
                            widget.setState(() {
                              display_image = newValue;
                              // print(display_image.toString()+" bbbdndb");

                              FirebaseFirestore.instance
                                  .collection('settings')
                                  .doc('settings')
                                  .update({
                                "display_image": display_image,
                              });
                            });
                          },
                          title: Text(
                            'Image/صورة',
                            style: FlutterFlowTheme.title3.override(
                              fontFamily: 'Lexend Deca',
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          tileColor: Colors.grey,
                          inactiveTrackColor: Colors.grey.shade100,
                          activeColor: Colors.green,
                          activeTrackColor: Colors.yellow,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding:
                          EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
                        ),
                      ),
                      Container(
                        child: SwitchListTile.adaptive(
                          value: arabicLanguage ??= false,
                          onChanged: (newValue) async {
                            widget.setState(() {
                              arabicLanguage = newValue;

                              FirebaseFirestore.instance
                                  .collection('settings')
                                  .doc('settings')
                                  .update({
                                "arabicLanguage": arabicLanguage,
                              });
                            });
                          },
                          title: Text(
                            'Arabic/عربي',
                            style: FlutterFlowTheme.title3.override(
                              fontFamily: 'Lexend Deca',
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          tileColor: Colors.grey,
                          inactiveTrackColor: Colors.grey.shade100,
                          activeColor: Colors.green,
                          activeTrackColor: Colors.yellow,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding:
                          EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const history_View_Widget()),
                  );
                },
                child: Container(
                    padding: const EdgeInsets.only(right: 10),
                    width: double.infinity,
                    height:
                    MediaQuery.of(context).size.height * 0.07,
                    // 45,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        arabicLanguage ? "تاريخ" : 'HISTORY',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: default_color,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Expenses()),
                  );
                },
                child: Container(
                    padding: const EdgeInsets.only(right: 10),
                    width: double.infinity,
                    height:  MediaQuery.of(context).size.height * 0.07,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        arabicLanguage ? 'إضافة حساب' : 'ADD EXPENSE',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: default_color,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Purchases()),
                  );
                },
                child: Container(
                    padding: const EdgeInsets.only(right: 10),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.07,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        arabicLanguage ? 'ضافة شراء' : 'ADD PURCHASE',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: default_color,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SalesReport()),
                  );
                },
                child: Container(
                    padding: const EdgeInsets.only(right: 10),
                    width: double.infinity,
                    height:  MediaQuery.of(context).size.height * 0.07,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        arabicLanguage ? ' تقرير المبيعات' : 'SALES REPORT',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: default_color,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SalesReturnReport()),
                  );
                },
                child: Container(
                    padding: const EdgeInsets.only(right: 10),
                    width: double.infinity,
                    height:  MediaQuery.of(context).size.height * 0.07,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        arabicLanguage ? 'تقرير الإرجاع' : 'RETURN REPORT',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: default_color,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ExpenseReport()),
                  );
                },
                child: Container(
                    padding: const EdgeInsets.only(right: 10),
                    width: double.infinity,
                    height:  MediaQuery.of(context).size.height * 0.07,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        arabicLanguage ? 'تقرير المصاريف' : 'EXPENSE REPORT',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: default_color,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PurchaseReport()),
                  );
                },
                child: Container(
                    padding: const EdgeInsets.only(right: 10),
                    width: double.infinity,
                    height:  MediaQuery.of(context).size.height * 0.07,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        arabicLanguage ? 'تقارير الشراء' : 'PURCHASE REPORTS',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: default_color,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DailyReportsWidget()),
                  );
                },
                child: Container(
                    padding: const EdgeInsets.only(right: 10),
                    width: double.infinity,
                    height:  MediaQuery.of(context).size.height * 0.07,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        arabicLanguage ? 'التقارير اليومية' : 'DAILY REPORTS',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: default_color,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )),
              ),
              InkWell(
                onTap: () async {
                  await signOut();
                  await Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                        (r) => false,
                  );
                },
                child: Container(
                    padding: const EdgeInsets.only(right: 10),
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 50),
                    height:  MediaQuery.of(context).size.height * 0.07,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            arabicLanguage ? 'تسجيل خروج' : 'Log out',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: default_color,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ));
  }
}
