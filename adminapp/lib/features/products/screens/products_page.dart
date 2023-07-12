import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../../../model/productModel.dart';
import '../../../splash_Screen.dart';

class ProductList extends StatefulWidget {
  const ProductList({
    Key? key,
  }) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  int selectedIndex = 0;

  List items = [
    {
      'completed': false,
      'name': 'Verified',
    },
    {
      'completed': false,
      'name': 'Not Verified',
    },
  ];

  bool PD = true;
  bool TK = true;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final ScrollController _scrollController = ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: true,
  );

  List<ProductModel> verifiedProducts = [];
  List searchVerified = [];
  List<ProductModel> rejectedProducts = [];
  List searchRejected = [];

  StreamSubscription? products;
  StreamSubscription? products1;

  getVerifiedProducts() {
    products = FirebaseFirestore.instance
        .collectionGroup('products')
        .where('verified', isEqualTo: true)
        .snapshots()
        .listen((event) {
      verifiedProducts = [];

      for (var doc in event.docs) {
        verifiedProducts.add(ProductModel.fromJson(doc.data()));
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  getNotVerifeid() {
    products1 = FirebaseFirestore.instance
        .collectionGroup('products')
        .where('verified', isEqualTo: false)
        .snapshots()
        .listen((event) {
      rejectedProducts = [];

      for (var doc in event.docs) {
        rejectedProducts.add(ProductModel.fromJson(doc.data()));
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  searchpendingRqst(String search, List runList) {
    searchVerified.clear();
    for (ProductModel searchItem in runList) {
      if (searchItem.name
          .toString()
          .toUpperCase()
          .contains(search.toUpperCase())) {
        searchVerified.add(searchItem);
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  searchRejectedRqst(String search, List runList) {
    searchRejected.clear();
    for (ProductModel searchItem in runList) {
      if (searchItem.name
          .toString()
          .toUpperCase()
          .contains(search.toUpperCase())) {
        searchRejected.add(searchItem);
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  final verifiedSearch = TextEditingController();

  final notVerifedSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    getVerifiedProducts();
    getNotVerifeid();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    products!.cancel();
    products1!.cancel();
  }

  @override
  @override
  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          'Products',
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
      key: scaffoldKey,
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    color: Colors.transparent,
                    elevation: 0,
                    child: Container(
                      width: w,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1,
                            color: Color(0xFFF1F4F8),
                            offset: Offset(0, 0),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24, 12, 24, 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16, 0, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 2, 0, 0),
                                    child: Text(
                                      '',
                                      style: TextStyle(
                                        color: Color(0xFF090F13),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 0),
                                    child: Text(
                                      '',
                                      style: TextStyle(
                                        color: Color(0xFF090F13),
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            SingleChildScrollView(
                              child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children:
                                      List.generate(items.length, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: InkWell(
                                        onTap: () {
                                          selectedIndex = index;
                                          setState(() {});
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: selectedIndex == index
                                                    ? myColor
                                                    : const Color(0xFFF1F4F8),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    blurRadius: 5,
                                                    color: Color(0x3B000000),
                                                    offset: Offset(0, 2),
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(4, 4, 4, 4),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    index < 2
                                                        ? (index == 0 && PD) ||
                                                                (index == 1 &&
                                                                    TK)
                                                            ? CircleAvatar(
                                                                radius: 5,
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                child:
                                                                    CircleAvatar(
                                                                  radius: 2,
                                                                  backgroundColor:
                                                                      myColor,
                                                                ),
                                                              )
                                                            : Icon(
                                                                Icons
                                                                    .access_time_rounded,
                                                                color: selectedIndex ==
                                                                        index
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .red,
                                                                size: 25,
                                                              )
                                                        : Container(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              items[index]['name'],
                                              style: TextStyle(
                                                  color: myColor,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  })),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            selectedIndex == 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                        child: Container(
                          width: scrWidth * .5,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                color: Colors.grey.shade300,
                                offset: Offset(0, 1),
                              )
                            ],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(4, 4, 0, 4),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        4, 0, 4, 0),
                                    child: TextFormField(
                                      controller: verifiedSearch,
                                      obscureText: false,
                                      onChanged: (text) {
                                        searchpendingRqst(
                                            text, verifiedProducts);

                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Search ',
                                        hintText: 'Please Enter Product Name',
                                        labelStyle: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF7C8791),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF090F13),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 8, 0),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        verifiedSearch.clear();
                                        setState(() {});
                                      },
                                      child: Text('Clear')),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              DataTable(
                                horizontalMargin: 35,
                                columnSpacing: 20,
                                headingRowColor:
                                    MaterialStateProperty.all(primaryColor),
                                columns: [
                                  DataColumn(
                                    label: Text(
                                      "S.No ",
                                      style: TextStyle(
                                        fontSize: scrWidth * 0.030,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Product ID ",
                                      style: TextStyle(
                                        fontSize: scrWidth * 0.030,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Product Name",
                                      style: TextStyle(
                                        fontSize: scrWidth * 0.030,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Shop Name",
                                      style: TextStyle(
                                        fontSize: scrWidth * 0.030,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Category",
                                      style: TextStyle(
                                        fontSize: scrWidth * 0.030,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Price",
                                      style: TextStyle(
                                        fontSize: scrWidth * 0.030,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Verified",
                                      style: TextStyle(
                                        fontSize: scrWidth * 0.030,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Action",
                                      style: TextStyle(
                                        fontSize: scrWidth * 0.030,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                                rows: List.generate(
                                  verifiedSearch.text == ''
                                      ? verifiedProducts.length
                                      : searchVerified.length,
                                  (index) {
                                    ProductModel data =
                                        verifiedSearch.text == ''
                                            ? verifiedProducts[index]
                                            : searchVerified[index];

                                    return DataRow(
                                      color: index.isOdd
                                          ? MaterialStateProperty.all(Colors
                                              .blueGrey.shade50
                                              .withOpacity(0.7))
                                          : MaterialStateProperty.all(
                                              Colors.blueGrey.shade50),
                                      cells: [
                                        DataCell(Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                          child: SelectableText(
                                            '${index + 1}',
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )),
                                        DataCell(Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                          child: SelectableText(
                                            data.productId.toString(),
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )),
                                        DataCell(SelectableText(
                                          data.name.toString(),
                                          style: TextStyle(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                        DataCell(SelectableText(
                                          data.vendorName.toString(),
                                          style: TextStyle(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                        DataCell(SelectableText(
                                          data.categoryName.toString(),
                                          style: TextStyle(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                        DataCell(SelectableText(
                                          data.price.toString(),
                                          style: TextStyle(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                        DataCell(SelectableText(
                                          data.verified == true
                                              ? 'Verified'
                                              : 'Not Verified',
                                          style: TextStyle(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                        DataCell(InkWell(
                                          onTap: () {
                                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>editProduct(
                                            //     data:data
                                            // )));
                                          },
                                          child: Container(
                                            height: 45,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: primaryColor,
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Proceed',
                                                style: TextStyle(
                                                  fontFamily: 'Lexend Deca',
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )

                //PERSONAL DETAILS
                : selectedIndex == 1
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                            child: Container(
                              width: scrWidth * .5,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 3,
                                    color: Colors.grey.shade300,
                                    offset: Offset(0, 1),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(4, 4, 0, 4),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4, 0, 4, 0),
                                        child: TextFormField(
                                          controller: notVerifedSearch,
                                          obscureText: false,
                                          onChanged: (text) {
                                            searchRejectedRqst(
                                                text, rejectedProducts);

                                            setState(() {});
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'Search ',
                                            hintText:
                                                'Please Enter Product Name',
                                            labelStyle: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF7C8791),
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF090F13),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 8, 0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          notVerifedSearch.clear();
                                          setState(() {});
                                        },
                                        child: Text('Clear'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  DataTable(
                                    horizontalMargin: 50,
                                    columnSpacing: 50,
                                    headingRowColor:
                                        MaterialStateProperty.all(primaryColor),
                                    columns: [
                                      DataColumn(
                                        label: Text(
                                          "S.No ",
                                          style: TextStyle(
                                            fontSize: scrWidth * 0.030,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          "Product ID ",
                                          style: TextStyle(
                                            fontSize: scrWidth * 0.030,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          "Product Name",
                                          style: TextStyle(
                                            fontSize: scrWidth * 0.030,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          "Shop Name",
                                          style: TextStyle(
                                            fontSize: scrWidth * 0.030,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          "Category",
                                          style: TextStyle(
                                            fontSize: scrWidth * 0.030,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          "Price",
                                          style: TextStyle(
                                            fontSize: scrWidth * 0.030,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          "Verified",
                                          style: TextStyle(
                                            fontSize: scrWidth * 0.030,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          "Action",
                                          style: TextStyle(
                                            fontSize: scrWidth * 0.030,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                    rows: List.generate(
                                      notVerifedSearch.text == ''
                                          ? rejectedProducts.length
                                          : searchRejected.length,
                                      (index) {
                                        ProductModel data =
                                            notVerifedSearch.text == ''
                                                ? rejectedProducts[index]
                                                : searchRejected[index];

                                        return DataRow(
                                          color: index.isOdd
                                              ? MaterialStateProperty.all(Colors
                                                  .blueGrey.shade50
                                                  .withOpacity(0.7))
                                              : MaterialStateProperty.all(
                                                  Colors.blueGrey.shade50),
                                          cells: [
                                            DataCell(Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                              child: SelectableText(
                                                '${index + 1}',
                                                style: TextStyle(
                                                  fontFamily: 'Lexend Deca',
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )),
                                            DataCell(Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                              child: SelectableText(
                                                data.productId.toString(),
                                                style: TextStyle(
                                                  fontFamily: 'Lexend Deca',
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )),
                                            DataCell(SelectableText(
                                              data.name.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Lexend Deca',
                                                color: Colors.black,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                            DataCell(SelectableText(
                                              data.vendorName.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Lexend Deca',
                                                color: Colors.black,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                            DataCell(SelectableText(
                                              data.categoryName.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Lexend Deca',
                                                color: Colors.black,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                            DataCell(SelectableText(
                                              data.price.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Lexend Deca',
                                                color: Colors.black,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                            DataCell(SelectableText(
                                              data.verified == true
                                                  ? 'Verified'
                                                  : 'Not Verified',
                                              style: TextStyle(
                                                fontFamily: 'Lexend Deca',
                                                color: Colors.black,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                            DataCell(InkWell(
                                              onTap: () {
                                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>editProduct(
                                                //     data:data
                                                // )));
                                              },
                                              child: Container(
                                                height: 45,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: primaryColor,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Proceed',
                                                    style: TextStyle(
                                                      fontFamily: 'Lexend Deca',
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : selectedIndex == 2
                        ? Column(
                            children: const [],
                          )
                        : Container()
          ],
        ),
      ),
    );
  }
}
