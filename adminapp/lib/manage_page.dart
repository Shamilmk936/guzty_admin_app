import 'package:adminapp/features/products/screens/products.dart';
import 'package:adminapp/features/store/screens/add_category.dart';
import 'package:adminapp/splash_Screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/banners/screens/banner_widget.dart';

String finalEmail = '';
String finalUserId = '';
String finalUserName = '';
String finalUserRole = '';

class ManagePage extends StatefulWidget {
  const ManagePage({Key? key}) : super(key: key);

  @override
  _ManagePageState createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // getBranches();
    // TODO: implement initState
    super.initState();
  }

  SharedPreferences? localStorage;

  // getBranches()  async {
  //   final SharedPreferences localStorage= await SharedPreferences.getInstance();
  //
  //   FirebaseFirestore.instance
  //       .collection('branches')
  //       .where('admins', arrayContains: finalUserId)
  //       .snapshots().listen((event) {
  //
  //     if(event.docs.isNotEmpty){
  //       if(event.docs.length==1){
  //         branches=event;
  //
  //         localStorage.setString('currentBranchId', event.docs.first.id);
  //
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
  // getTrendingProducts(){
  //
  //   FirebaseFirestore.instance.collection('banner')
  //       .doc(currentBranchId)
  //       .snapshots().listen((event) {
  //
  //     trendingProducts=event.get('trendingProducts');
  //     setState(() {
  //
  //     });
  //
  //
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: foodZerColor,
        automaticallyImplyLeading: true,
        title: const Text(
          'Manage',
          style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('V.1.1.7'),
          ),
        ],
        centerTitle: true,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Align(
            alignment: const Alignment(0, 0),
            child: Wrap(
              direction: Axis.horizontal,
              children: [
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        //  Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => ProductsWidget(),
                        //   ),
                        // );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Products(),
                                ),
                              );
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.productHunt,
                              color: Colors.black,
                              size: 70,
                            ),
                            iconSize: 60,
                          ),
                          const Text(
                            'Products',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                            ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        //  Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => BrandsWidget(),
                        //   ),
                        // );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              //  Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => BrandsWidget(),
                              //   ),
                              // );
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.bold,
                              color: Colors.black,
                              size: 70,
                            ),
                            iconSize: 60,
                          ),
                          const Text(
                            'Brands',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                            ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        //  Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => CategoryWidget(),
                        //   ),
                        // );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              //  Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         CategoryWidget(),
                              //   ),
                              // );
                            },
                            icon: const Icon(
                              Icons.category,
                              color: Colors.black,
                              size: 70,
                            ),
                            iconSize: 60,
                          ),
                          const Text(
                            'Category',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        //  Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => ShopWidget(),
                        //   ),
                        // );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              //  Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => ShopWidget(),
                              //   ),
                              // );
                            },
                            icon: const Icon(
                              Icons.store_mall_directory,
                              color: Colors.black,
                              size: 70,
                            ),
                            iconSize: 60,
                          ),
                          const Text(
                            'Shops',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                            ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        //  Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => OfferWidget(),
                        //   ),
                        // );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              //  Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => OfferWidget(),
                              //   ),
                              // );
                            },
                            icon: const Icon(
                              Icons.local_offer,
                              color: Colors.black,
                              size: 70,
                            ),
                            iconSize: 60,
                          ),
                          const Text(
                            'Offers',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                            ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        //  Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => OfferWidget(),
                        //   ),
                        // );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              //  Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => BranchWidget(),
                              //   ),
                              // );
                            },
                            icon: const Icon(
                              Icons.location_on,
                              color: Colors.black,
                              size: 70,
                            ),
                            iconSize: 60,
                          ),
                          const Text(
                            'Branches',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => CuisineWidget(),
                        //   ),
                        // );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.fastfood,
                              color: Colors.black,
                              size: 70,
                            ),
                            iconSize: 60,
                            onPressed: () {},
                          ),
                          const Text(
                            'Cuisine',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                            ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => BannerWidget(),
                        //   ),
                        // );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.photo_library,
                              color: Colors.black,
                              size: 70,
                            ),
                            iconSize: 60,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BannerWidget(),
                                ),
                              );
                            },
                          ),
                          const Text(
                            'Banners',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                            ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        //  Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => SendNotificationWidget(),
                        //   ),
                        // );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.notification_add,
                              color: Colors.black,
                              size: 70,
                            ),
                            iconSize: 60,
                            onPressed: () {},
                          ),
                          const Text(
                            'Notifications',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.category,
                            color: Colors.black,
                            size: 70,
                          ),
                          iconSize: 60,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddCategories(),
                              ),
                            );
                          },
                        ),
                        const Text(
                          'Store Category',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                          ),
                        )
                      ],
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
