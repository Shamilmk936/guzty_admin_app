import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:adminapp/features/vendors/screens/vendor_request/vendorsAccepting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart' as ex;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../model/vendorModel.dart';
import '../../../../splash_Screen.dart';

class vendorRequest extends StatefulWidget {
  const vendorRequest({
    Key? key,
  }) : super(key: key);

  @override
  _vendorRequestState createState() => _vendorRequestState();
}

class _vendorRequestState extends State<vendorRequest> {
  int selectedIndex = 0;

  List items = [
    {
      'completed': false,
      'name': 'Requests',
    },
    {
      'completed': false,
      'name': 'Rejected',
    },
  ];

  bool PD = true;
  bool TK = true;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final ScrollController _scrollController = ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: true,
  );

  TextEditingController pendingSearch = TextEditingController();
  TextEditingController rejectedSearch = TextEditingController();

  List searchPending = [];
  List searchRejected = [];

  List<VendorModel> vendorsListRqst = [];
  List<VendorModel> vendorsListRjct = [];
  getVendorsRequests() {
    FirebaseFirestore.instance
        .collection('vendors')
        .where('verified', isEqualTo: false)
        .where('rejected', isEqualTo: false)
        .orderBy('createdTime', descending: true)
        .snapshots()
        .listen((event) {
      vendorsListRqst = [];
      for (var doc in event.docs) {
        vendorsListRqst.add(VendorModel.fromJson(doc.data()));

        print(vendorsListRqst);
        print('planList');
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  getVendorsRejected() {
    FirebaseFirestore.instance
        .collection('vendors')
        .where('verified', isEqualTo: false)
        .where('rejected', isEqualTo: true)
        .orderBy('createdTime', descending: true)
        .snapshots()
        .listen((event) {
      vendorsListRjct = [];
      for (var doc in event.docs) {
        vendorsListRjct.add(VendorModel.fromJson(doc.data()));
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  searchpendingRqst(String search, List runList) {
    searchPending.clear();
    for (VendorModel searchItem in runList) {
      if (searchItem.shopName
          .toString()
          .toUpperCase()
          .contains(search.toUpperCase())) {
        searchPending.add(searchItem);
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  searchRejectedRqst(String search, List runList) {
    searchRejected.clear();
    for (VendorModel searchItem in runList) {
      if (searchItem.shopName
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

  @override
  void initState() {
    super.initState();
    getVendorsRequests();
    getVendorsRejected();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // runner!.cancel();
    // runner1!.cancel();
  }

  @override
  @override
  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Center(
          child: Text(
            'VENDOR REQUESTS',
            style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          ),
        ),
      ),
      key: scaffoldKey,
      body: SizedBox(
        height: scrWidth * 0.9,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      color: Colors.transparent,
                      elevation: 0,
                      child: Container(
                        width: 900,
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
                              // SingleChildScrollView(
                              //   child: Row(
                              //       mainAxisSize: MainAxisSize.max,
                              //       mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //       children: List.generate(items.length, (index) {
                              //         return Padding(
                              //           padding:
                              //           const EdgeInsets.only(right: 10),
                              //           child: InkWell(
                              //             onTap: () {
                              //               selectedIndex = index;
                              //               setState(() {});
                              //             },
                              //             child: Row(
                              //               children: [
                              //                 Container(
                              //                   width: 30,
                              //                   height: 30,
                              //                   decoration: BoxDecoration(
                              //                     color: selectedIndex == index
                              //                         ? myColor
                              //                         : const Color(0xFFF1F4F8),
                              //                     boxShadow: const [
                              //                       BoxShadow(
                              //                         blurRadius: 5,
                              //                         color: Color(0x3B000000),
                              //                         offset: Offset(0, 2),
                              //                       )
                              //                     ],
                              //                     borderRadius:
                              //                     BorderRadius.circular(15),
                              //                   ),
                              //                   child: Padding(
                              //                     padding:
                              //                     const EdgeInsetsDirectional
                              //                         .fromSTEB(4, 4, 4, 4),
                              //                     child: Column(
                              //                       mainAxisSize:
                              //                       MainAxisSize.max,
                              //                       mainAxisAlignment:
                              //                       MainAxisAlignment
                              //                           .center,
                              //                       children: [
                              //                         index < 2
                              //                             ? (index ==  0 && PD) ||
                              //                             (index ==  1 && TK)
                              //                             ? CircleAvatar(
                              //                           radius: 5,
                              //                           backgroundColor:
                              //                           Colors
                              //                               .white,
                              //                           child:
                              //                           CircleAvatar(
                              //                             radius: 2 ,
                              //                             backgroundColor:
                              //                             myColor,
                              //                           ),
                              //                         )
                              //                             : Icon(
                              //                           Icons
                              //                               .access_time_rounded,
                              //                           color: selectedIndex ==
                              //                               index
                              //                               ? Colors
                              //                               .white
                              //                               : Colors
                              //                               .red,
                              //                           size: 25,
                              //                         )
                              //                             : Container(),
                              //                       ],
                              //                     ),
                              //                   ),
                              //                 ),
                              //                 const SizedBox(
                              //                   width: 10,
                              //                 ),
                              //                 Text(
                              //                   items[index]['name'],
                              //                   style: TextStyle(
                              //                       color: myColor,
                              //                       fontWeight:
                              //                       FontWeight.bold),
                              //                 )
                              //               ],
                              //             ),
                              //           ),
                              //         );
                              //       })),
                              // ),

                              SingleChildScrollView(
                                child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children:
                                        List.generate(items.length, (index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
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
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      index < 2
                                                          ? (index == 0 &&
                                                                      PD) ||
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                        controller: pendingSearch,
                                        obscureText: false,
                                        onChanged: (text) {
                                          searchpendingRqst(
                                              text, vendorsListRqst);

                                          setState(() {});
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Search ',
                                          hintText: 'Please Enter '
                                              ' Name',
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
                                        pendingSearch.clear();

                                        setState(() {});
                                      },
                                      child: Text('clear'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: // double.infinity,
                                MediaQuery.of(context).size.width,
                            child: DataTable(
                              horizontalMargin: 10,
                              columnSpacing: 10,
                              headingRowColor:
                                  MaterialStateProperty.all(primaryColor),
                              columns: [
                                DataColumn(
                                  label: Text(
                                    "S.No ",
                                    style: GoogleFonts.workSans(
                                      fontSize: scrWidth * 0.010,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    "Date ",
                                    style: GoogleFonts.workSans(
                                      fontSize: scrWidth * 0.010,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    "Shop Name",
                                    style: GoogleFonts.workSans(
                                      fontSize: scrWidth * 0.010,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    "Category",
                                    style: GoogleFonts.workSans(
                                      fontSize: scrWidth * 0.010,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    "Owner Name",
                                    style: GoogleFonts.workSans(
                                      fontSize: scrWidth * 0.010,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    "Owner Email",
                                    style: GoogleFonts.workSans(
                                      fontSize: scrWidth * 0.010,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    "Action",
                                    style: GoogleFonts.workSans(
                                      fontSize: scrWidth * 0.010,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                              rows: List.generate(
                                pendingSearch.text == ''
                                    ? vendorsListRqst.length
                                    : searchPending.length,
                                (index) {
                                  VendorModel data = pendingSearch.text == ''
                                      ? vendorsListRqst[index]
                                      : searchPending[index];

                                  return DataRow(
                                    color: index.isOdd
                                        ? MaterialStateProperty.all(Colors
                                            .blueGrey.shade50
                                            .withOpacity(0.7))
                                        : MaterialStateProperty.all(
                                            Colors.blueGrey.shade50),
                                    cells: [
                                      DataCell(Container(
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        child: SelectableText(
                                          DateFormat(
                                            'dd-MM-yyyy',
                                          )
                                              .format(data.createdTime!)
                                              .toString(),
                                          style: TextStyle(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )),
                                      DataCell(SelectableText(
                                        data.shopName.toString(),
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
                                        data.ownerName.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                      DataCell(SelectableText(
                                        data.ownerEmail.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                      DataCell(InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditVendorRequest(
                                                          data: data)));
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
                          ),
                        ),
                      ],
                    )
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      4, 4, 0, 4),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  4, 0, 4, 0),
                                          child: TextFormField(
                                            controller: rejectedSearch,
                                            obscureText: false,
                                            onChanged: (text) {
                                              searchRejectedRqst(
                                                  text, vendorsListRjct);

                                              setState(() {});
                                            },
                                            decoration: InputDecoration(
                                              labelText: 'Search ',
                                              hintText: 'Please Enter '
                                                  ' Name',
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
                              child: SizedBox(
                                width: // double.infinity,
                                    MediaQuery.of(context).size.width,
                                child: DataTable(
                                  horizontalMargin: 10,
                                  columnSpacing: 10,
                                  headingRowColor:
                                      MaterialStateProperty.all(primaryColor),
                                  columns: [
                                    DataColumn(
                                      label: Text(
                                        "S.No ",
                                        style: GoogleFonts.workSans(
                                          fontSize: scrWidth * 0.010,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Date ",
                                        style: GoogleFonts.workSans(
                                          fontSize: scrWidth * 0.010,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Shop Name",
                                        style: GoogleFonts.workSans(
                                          fontSize: scrWidth * 0.010,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Category",
                                        style: GoogleFonts.workSans(
                                          fontSize: scrWidth * 0.010,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Owner Name",
                                        style: GoogleFonts.workSans(
                                          fontSize: scrWidth * 0.010,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Owner Email",
                                        style: GoogleFonts.workSans(
                                          fontSize: scrWidth * 0.010,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Action",
                                        style: GoogleFonts.workSans(
                                          fontSize: scrWidth * 0.010,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: List.generate(
                                    rejectedSearch.text == ''
                                        ? vendorsListRjct.length
                                        : searchRejected.length,
                                    (index) {
                                      VendorModel data =
                                          rejectedSearch.text == ''
                                              ? vendorsListRjct[index]
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
                                              DateFormat('dd-MM-yyyy')
                                                  .format(data.createdTime!)
                                                  .toString(),
                                              style: TextStyle(
                                                fontFamily: 'Lexend Deca',
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )),
                                          DataCell(SelectableText(
                                            data.shopName.toString(),
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
                                            data.ownerName.toString(),
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(SelectableText(
                                            data.ownerEmail.toString(),
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(InkWell(
                                            onTap: () {
                                              print('ssss');
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditVendorRequest(
                                                              data: data)));
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
      ),
    );
  }
}
