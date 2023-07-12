import 'package:adminapp/splash_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/authentication/login_page.dart';
import 'features/runner/AddRunner.dart';

List<String> units = [];
List<String> productListWithShop = [];
List<String> shopList = [];
List<String> branchList = [];
List<String> categoryList = [];

Map<String, dynamic> shopIdByName = {};
Map<String, dynamic> productIdByprdNameAndShpName = {};
Map<String, dynamic> productDataById = {};
Map<String, dynamic> shopNameById = {};
Map<String, dynamic> branchIdByName = {};
Map<String, dynamic> brandNameById = {};
Map<String, dynamic> categoryIdByName = {};
Map<String, dynamic> categoryNameById = {};

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseAuth _auth = FirebaseAuth.instance;

  // FirebaseFirestore _firestore  = FirebaseFirestore.instance;

  deleteData() {
    FirebaseFirestore.instance
        .collection('products')
        .where('shopId', isEqualTo: null)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        // element.reference.delete();
      });
      print('done');
    });
  }

  @override
  void initState() {
    // deleteData();
    // getBranches();
    // getData();
    // updateProducts();

    // TODO: implement initState
    super.initState();
  }

  // getData() {
  //   FirebaseFirestore.instance
  //       .collection("products")
  //       .where('branchId', isEqualTo: currentBranchId)
  //       .snapshots()
  //       .listen((event) {
  //     productListWithShop.clear();
  //     for (DocumentSnapshot doc in event.docs) {
  //       try {
  //         productListWithShop.add('${doc['name']} (${doc['shopName']})');
  //         productIdByprdNameAndShpName['${doc['name']} (${doc['shopName']})'] =
  //             doc.id;
  //         productDataById[doc.id] = doc.data();
  //       } catch (e) {
  //         print(doc.id);
  //       }
  //     }
  //
  //     if (mounted) {
  //       setState(() {});
  //     }
  //   });
  //
  //   FirebaseFirestore.instance
  //       .collection("units")
  //       .doc("units")
  //       .snapshots()
  //       .listen((event) {
  //     units.clear();
  //     for (var data in event['unitlist']) {
  //       units.add(data['name']);
  //     }
  //
  //     if (mounted) {
  //       setState(() {});
  //     }
  //   });
  //
  //   FirebaseFirestore.instance
  //       .collection('shops')
  //       .where('branchId', isEqualTo: currentBranchId)
  //       .snapshots()
  //       .listen((event) {
  //     shopList.clear();
  //     for (DocumentSnapshot doc in event.docs) {
  //       shopIdByName[doc['name']] = doc.id;
  //       shopNameById[doc.id] = doc['name'];
  //       shopList.add(doc['name']);
  //     }
  //
  //     if (mounted) {
  //       setState(() {});
  //     }
  //   });
  //
  //
  //   FirebaseFirestore.instance
  //       .collection('category')
  //       .snapshots()
  //       .listen((event) {
  //     categoryList.clear();
  //     for (DocumentSnapshot doc in event.docs) {
  //       categoryIdByName[doc['name']] = doc.id;
  //       categoryNameById[doc.id] = doc['name'];
  //       categoryList.add(doc['name']);
  //     }
  //
  //     if (mounted) {
  //       setState(() {});
  //     }
  //   });
  // }
  //
  // updateProduct() {
  //   String username = 'username@gmail.com';
  //   String password = 'password';
  //
  //   FirebaseFirestore.instance.collection('mail').add({
  //     'date': DateTime.now(),
  //     'emailList': [
  //       'ajmalbadhusha414@gmail.com',
  //       'akkuashkar158@gmail.com',
  //       'tm.shabeeb@gmail.com',
  //     ],
  //     'html': '<body>'
  //         '<p>Dear Team,</p>'
  //         '<p>Thank you very much for doing business with FoodZer.Kindly See the enclosed Invoice against the Businesses for the Period from 01-08-2022 To 20-08-2022</p>'
  //         '<br>'
  //         '<br>'
  //         '<p>Feel Free to contact for any further clarification.</p>'
  //         '<br>'
  //         '<br>'
  //         '<p>Best regards,</p>'
  //         '<br>'
  //         '<p>Finance Department</p>'
  //         '<p>FoodZer</p>'
  //         '</body>',
  //     'status': 'FoodZer Payment'
  //   });
  // }
  // final googleSignIn = GoogleSignIn();
  // setSearchParam(String caseNumber) {
  //   List<String> caseSearchList = List<String>();
  //   String temp = "";
  //
  //   List<String> nameSplits = caseNumber.split(" ");
  //   for (int i = 0; i < nameSplits.length; i++) {
  //     String name = "";
  //
  //     for (int k = i; k < nameSplits.length; k++) {
  //       name = name + nameSplits[k] + " ";
  //     }
  //     temp = "";
  //
  //     for (int j = 0; j < name.length; j++) {
  //       temp = temp + name[j];
  //       caseSearchList.add(temp.toUpperCase());
  //     }
  //   }
  //   return caseSearchList;
  // }
  // getTrendingProducts(){
  //
  //   FirebaseFirestore.instance.collection('banner')
  //       .doc(currentBranchId)
  //       .snapshots().listen((event) {
  //
  //     trendingProducts=event.get('trendingProducts');
  //     if(mounted){
  //       setState(() {
  //
  //       });
  //     }
  //
  //
  //   });
  // }
  //
  // updateProducts(){
  //   FirebaseFirestore.instance.collection('admin_users').get().then((value) {
  //     print(value.docs.length);
  //     int id=1000;
  //     for(DocumentSnapshot snap in value.docs){
  //       snap.reference.update({
  //         'search':setSearchParam(snap['display_name']),
  //       });
  //
  //       // FirebaseFirestore.instance.collection('admin_users')
  //       // .doc((id+1).toString())
  //       //     .set(snap.data());
  //       // id++;
  //
  //     }
  //   });
  // }
  // SharedPreferences localStorage;
  // getBranches()  async {
  //
  //   print('finalUserId');
  //   print(finalUserId);
  //   print('finalUserId');
  //
  //
  //   final SharedPreferences localStorage= await SharedPreferences.getInstance();
  //
  //
  //   FirebaseFirestore.instance.collection('branches')
  //       .snapshots()
  //       .listen((event) {
  //     branchList.clear();
  //
  //     event.docs.forEach((element) {
  //       brandNameById[element.id]=element['name'];
  //       branchIdByName[element['name']]=element.id;
  //       branchList.add(element['name']);
  //     });
  //
  //     if(mounted){
  //       setState(() {
  //
  //       });
  //     }
  //
  //   });
  //
  //   FirebaseFirestore.instance
  //       .collection('branches')
  //       .where('admins', arrayContains: finalUserId)
  //       .snapshots().listen((event)  {
  //
  //     if(event.docs.isNotEmpty){
  //       if(event.docs.length==1){
  //         branches=event;
  //
  //         localStorage.setString('currentBranchId', event.docs.first.id);
  //         currentBranchId = event.docs.first.id;
  //         getTrendingProducts();
  //         if(mounted){
  //           setState(() {
  //
  //           });
  //         }
  //
  //       }
  //
  //     }
  //
  //
  //
  //   });
  //
  //
  //
  //
  //
  //
  // }
  //
  // void pickFile() async {
  //   final result = await FilePicker.platform.pickFiles(
  //     allowMultiple: false,
  //     withData: true,
  //     // withReadStream: true,
  //   );
  //
  //   if (result == null) return;
  //   final file = result.files.first;
  //   print(file.name);
  //   _openFile(file);
  // }
  // List<String> bankList=[];
  // void _openFile(PlatformFile file) {
  //   print("-----------------------");
  //   List<List<dynamic>> listData =
  //   CsvToListConverter().convert(String.fromCharCodes(file.bytes));
  //   int i=0;
  //   print('abc');
  //   bankList=[];
  //   for(dynamic a in listData){
  //     if(a!=null && a!="") {
  //
  //       var abcs=   DateTime.parse("${a[3]} 00:00:00");
  //
  //       FirebaseFirestore.instance.collection('users')
  //           .doc(a[1].toString())
  //           .set({
  //         'created_date':abcs,
  //         'bag':[],
  //         'branchId':'bKhZbpjRB5Z55wKSX4mh',
  //         'cashback':0,
  //         'email':a[2].toString(),
  //         'fullName':a[0],
  //         'mobileNumber':a[1].toString(),
  //         'photoUrl':'',
  //         'pinnedShop':'',
  //         'search':setSearchParam(a[0].toString()),
  //         'selectedAddress':{},
  //         'userId':a[1].toString(),
  //         'verified':true,
  //         'wallet':0,
  //         'wishlist':[],
  //       });
  //     }
  //   }
  //
  //   print(bankList);
  //   setState(() {
  //
  //   });
  //
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        automaticallyImplyLeading: true,
        title: Text(
          'GUZTY ADMIN',
          style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
        ),
        actions: [
          TextButton.icon(
              onPressed: () async {
                bool pressed = await alert(context, 'Logout');
                if (pressed) {
                  final SharedPreferences localStorage =
                      await SharedPreferences.getInstance();

                  // await _auth.signOut();
                  // await googleSignIn.signOut();
                  localStorage.remove('currentBranchId');
                  localStorage.remove('email');
                  localStorage.remove('userId');
                  localStorage.remove('role');

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(foodZerColor),
              ),
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              label: Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ))
        ],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child:
              // branches == null
              //     ? Center(
              //         child: CircularProgressIndicator(),
              //       )
              //     : branches.docs.length == 0
              //         ? Center(
              //             child: Text('No branches found for you'),
              //           )
              //         : currentBranchId == null
              //             ? ListView.builder(
              //                 padding: EdgeInsets.zero,
              //                 scrollDirection: Axis.vertical,
              //                 itemCount: branches.docs.length,
              //                 itemBuilder: (context, listViewIndex) {
              //                   final branch = branches.docs[listViewIndex];
              //                   return Card(
              //                     clipBehavior: Clip.antiAliasWithSaveLayer,
              //                     color: Color(0xFFF5F5F5),
              //                     child: Stack(
              //                       children: [
              //                         InkWell(
              //                           onTap: () async {
              //                             // final SharedPreferences localStorage =
              //                             //     await SharedPreferences.getInstance();
              //                             // localStorage.setString('currentBranchId',
              //                             //     branch.get('branchId'));
              //                             // setState(() {
              //                             //   currentBranchId =
              //                             //       branch.get('branchId');
              //                             //   currentBranchName = branch.get('name');
              //                             //   getTrendingProducts();
              //                             // });
              //                           },
              //                           child: Container(
              //                             height: 100,
              //                             child: Column(
              //                               mainAxisSize: MainAxisSize.max,
              //                               children: [
              //                                 Align(
              //                                   alignment: Alignment(0, -0.11),
              //                                   child: Text(
              //                                     branch.get('name'),
              //                                     style: TextStyle(
              //                                       fontFamily: 'Poppins',
              //                                     ),
              //                                   ),
              //                                 ),
              //                               ],
              //                             ),
              //                           ),
              //                         )
              //                       ],
              //                     ),
              //                   );
              //                 },
              //               )
              //             :
              SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Align(
                  alignment: Alignment(0, 0),
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: [
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  //  Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         OrdersWidget(),
                                  //   ),
                                  // );
                                },
                                icon: Icon(
                                  Icons.add_box_outlined,
                                  color: Colors.black,
                                  size: 60,
                                ),
                                iconSize: 60,
                              ),
                              Text(
                                'Orders',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  //  Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         FeaturedBrandsWidget(),
                                  //   ),
                                  // );
                                },
                                icon: Icon(
                                  Icons.account_circle,
                                  color: Colors.black,
                                  size: 60,
                                ),
                                iconSize: 60,
                              ),
                              Text(
                                'Popular',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  //  Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         PaymentWidget(),
                                  //   ),
                                  // );
                                },
                                icon: Icon(
                                  Icons.payment,
                                  color: Colors.black,
                                  size: 60,
                                ),
                                iconSize: 60,
                              ),
                              Text(
                                'Payments',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  //  Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         ReportPage1Widget(),
                                  //   ),
                                  // );
                                },
                                icon: Icon(
                                  Icons.report,
                                  color: Colors.black,
                                  size: 60,
                                ),
                                iconSize: 60,
                              ),
                              Text(
                                'Reports',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  //  Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         CreateAdminUser(),
                                  //   ),
                                  // );
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.userCheck,
                                  color: Colors.black,
                                  size: 60,
                                ),
                                iconSize: 60,
                              ),
                              Text(
                                'Admin Users',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  //  Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         BreakFastWidget(),
                                  //   ),
                                  // );
                                },
                                icon: Icon(
                                  Icons.account_circle_outlined,
                                  color: Colors.black,
                                  size: 60,
                                ),
                                iconSize: 60,
                              ),
                              Text(
                                'Featured',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  //  Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         SettingsWidget(),
                                  //   ),
                                  // );
                                },
                                icon: Icon(
                                  Icons.settings,
                                  color: Colors.black,
                                  size: 60,
                                ),
                                iconSize: 60,
                              ),
                              Text(
                                'Settings',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddRunner(),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.delivery_dining,
                                  size: 70,
                                ),
                                iconSize: 60,
                              ),
                              Text(
                                'Riders',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  //  Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         FeedbackWidget(),
                                  //   ),
                                  // );
                                },
                                icon: Icon(
                                  Icons.feedback,
                                  size: 65,
                                ),
                                iconSize: 60,
                              ),
                              Text(
                                'Feedbacks',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  //  Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         IncentivesWidget(),
                                  //   ),
                                  // );
                                },
                                icon: Icon(
                                  Icons.monetization_on,
                                  size: 70,
                                ),
                                iconSize: 60,
                              ),
                              Text(
                                'Incentive',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  //  Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         RefundWidget(),
                                  //   ),
                                  // );
                                },
                                icon: Icon(
                                  Icons.monetization_on,
                                  size: 70,
                                ),
                                iconSize: 60,
                              ),
                              Text(
                                'Refund',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  //  Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         FullCustomers(),
                                  //   ),
                                  // );
                                },
                                icon: Icon(
                                  Icons.supervisor_account_sharp,
                                  size: 70,
                                ),
                                iconSize: 60,
                              ),
                              Text(
                                'Users',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  //  Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         Promotions(),
                                  //   ),
                                  // );
                                },
                                icon: Icon(
                                  Icons.list,
                                  size: 70,
                                ),
                                iconSize: 60,
                              ),
                              Text(
                                'Promotions',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  //  Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         FullShops(),
                                  //   ),
                                  // );
                                },
                                icon: Icon(
                                  Icons.library_books,
                                  size: 70,
                                ),
                                iconSize: 60,
                              ),
                              Text(
                                'Shops List',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  //  Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         CreateExcelWidget(),
                                  //   ),
                                  // );
                                },
                                icon: Icon(
                                  Icons.list_alt_sharp,
                                  size: 70,
                                ),
                                iconSize: 60,
                              ),
                              Text(
                                'Excel',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  //  Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         DeliveredReports(),
                                  //   ),
                                  // );
                                },
                                icon: Icon(
                                  Icons.report,
                                  size: 70,
                                ),
                                iconSize: 60,
                              ),
                              Text(
                                'Delivery',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  //  Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         InvoicePageWidget(),
                                  //   ),
                                  // );
                                },
                                icon: Icon(
                                  Icons.payments,
                                  size: 70,
                                ),
                                iconSize: 60,
                              ),
                              Text(
                                'Invoice',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
