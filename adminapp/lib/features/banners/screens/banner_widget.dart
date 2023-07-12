import 'package:adminapp/features/banners/screens/shops_banner.dart';
import 'package:flutter/material.dart';

import '../../../splash_Screen.dart';
import 'add_banner.dart';

class BannerWidget extends StatefulWidget {
  BannerWidget({Key? key}) : super(key: key);

  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  String homeGif = '';
  String offerTopBanner = '';
  String offerBottomBanner = '';
  bool _loadingButton1 = false;
  String homePageBottomBanner = '';
  bool _loadingButton2 = false;
  bool _loadingButton3 = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          'Banners',
          style: TextStyle(
            fontFamily: 'Lexend Deca',
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'HomePage',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddBanner()));
                      },
                      child: Text('Add Banner'),
                    ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => ShopsBanner()));
                    //   },
                    //   child: Text('Category List'),
                    // ),
                    // ElevatedButton(
                    //   onPressed: () async {
                    //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>FoodzerPick()));
                    //   },
                    //   child: Text('Foodzer Pick'),
                    // ),
                  ],
                ),
              ),
              // Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 10),
              //   child: Row(
              //     mainAxisSize: MainAxisSize.max,
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       ElevatedButton(
              //         onPressed: () async {
              //           // Navigator.push(context, MaterialPageRoute(builder: (context)=>ChefChoice()));
              //         },
              //         child: Text('Chef Choice'),
              //       ),
              //       ElevatedButton(
              //         onPressed: () async {
              //           // Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadOfferBottomWidget()));
              //         },
              //         child: Text('Offer Bottom Banner'),
              //       ),
              //     ],
              //   ),
              // ),
              // Divider(
              //   height: 2,
              //   thickness: 1,
              //   indent: 10,
              //   endIndent: 10,
              //   color: Color(0xFF0E0E0E),
              // ),
              // Row(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Text(
              //         'Popular Restaurant',
              //         style: TextStyle(fontWeight: FontWeight.w600),
              //       ),
              //     ),
              //   ],
              // ),
              // Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 10),
              //   child: Row(
              //     mainAxisSize: MainAxisSize.max,
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       ElevatedButton(
              //         onPressed: () async {
              //           // Navigator.push(context, MaterialPageRoute(builder: (context)=>PopularRestaurant()));
              //         },
              //         child: Text('Popular Restaurant'),
              //       ),
              //       ElevatedButton(
              //         onPressed: () async {
              //           // Navigator.push(context, MaterialPageRoute(builder: (context)=>NearYou()));
              //         },
              //         child: Text('Near You'),
              //       ),
              //     ],
              //   ),
              // ),
              // Divider(
              //   height: 2,
              //   thickness: 1,
              //   indent: 10,
              //   endIndent: 10,
              //   color: Color(0xFF0E0E0E),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
