import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart' as ex;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../model/runnerModel.dart';
import '../../splash_Screen.dart';
import 'EditRunnerRequests.dart';

class RunnerRequests extends StatefulWidget {
  const RunnerRequests({
    Key? key,
  }) : super(key: key);

  @override
  _RunnerRequestsState createState() => _RunnerRequestsState();
}

class _RunnerRequestsState extends State<RunnerRequests> {
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

  List<RunnerModel> pendingRequests = [];
  List searchPending = [];
  List<RunnerModel> rejectedRequets = [];
  List searchRejected = [];

  StreamSubscription? runner;
  StreamSubscription? runner1;

  getPendingRequests() {
    runner = FirebaseFirestore.instance
        .collection('runner')
        .where('status', isEqualTo: 0)
        .where('delete', isEqualTo: false)
        .snapshots()
        .listen((event) {
      pendingRequests = [];
      for (var doc in event.docs) {
        pendingRequests.add(RunnerModel.fromJson(doc.data()));
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  getRejectedRequests() {
    runner1 = FirebaseFirestore.instance
        .collection('runner')
        .where('status', isEqualTo: 1)
        .where('delete', isEqualTo: false)
        .snapshots()
        .listen((event) {
      rejectedRequets = [];

      for (var doc in event.docs) {
        rejectedRequets.add(RunnerModel.fromJson(doc.data()));
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  searchpendingRqst(String search, List runList) {
    searchPending.clear();
    for (RunnerModel searchItem in runList) {
      if (searchItem.name
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
    for (RunnerModel searchItem in runList) {
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

  final pendingSearch = TextEditingController();

  final rejectedSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    getPendingRequests();
    getRejectedRequests();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    runner!.cancel();
    runner1!.cancel();
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
            'RUNNER REQUESTS',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 15),
                                      child: Container(
                                        width: scrWidth * 0.4,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: const [
                                            BoxShadow(
                                              blurRadius: 3,
                                              color: Color(0x39000000),
                                              offset: Offset(0, 1),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(4, 4, 0, 4),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(4, 0, 4, 0),
                                                  child: TextFormField(
                                                    controller: pendingSearch,
                                                    obscureText: false,
                                                    onChanged: (text) {
                                                      searchpendingRqst(text,
                                                          pendingRequests);

                                                      setState(() {});
                                                    },
                                                    decoration: InputDecoration(
                                                      labelText: 'Search ',
                                                      hintText:
                                                          'Please Enter name',
                                                      labelStyle:
                                                          const TextStyle(
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            Color(0xFF7C8791),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                          color:
                                                              Color(0x00000000),
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                          color:
                                                              Color(0x00000000),
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                    ),
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      color: myColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 8, 0),
                                                child: InkWell(
                                                  onTap: () {
                                                    pendingSearch.clear();

                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    width: 100,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: myColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18),
                                                    ),
                                                    child: const Center(
                                                        child: Text(
                                                      'Clear',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
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
                                    "Name",
                                    style: GoogleFonts.workSans(
                                      fontSize: scrWidth * 0.010,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    "Email",
                                    style: GoogleFonts.workSans(
                                      fontSize: scrWidth * 0.010,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    "Mobile number",
                                    style: GoogleFonts.workSans(
                                      fontSize: scrWidth * 0.010,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    "Status",
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
                                    ? pendingRequests.length
                                    : searchPending.length,
                                (index) {
                                  RunnerModel data = pendingSearch.text == ''
                                      ? pendingRequests[index]
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
                                        data.name.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                      DataCell(SelectableText(
                                        data.email.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                      DataCell(SelectableText(
                                        data.mobileNumber.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                      DataCell(SelectableText(
                                        data.status == 0
                                            ? 'Pending'
                                            : data.status == 1
                                                ? 'Rejcted'
                                                : 'Acepted',
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
                                                      EditRunnerRequests(
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

                  //PERSONAL DETAILS
                  : selectedIndex == 1
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 0, 0, 15),
                                          child: Container(
                                            width: scrWidth * 0.4,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: const [
                                                BoxShadow(
                                                  blurRadius: 3,
                                                  color: Color(0x39000000),
                                                  offset: Offset(0, 1),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(4, 4, 0, 4),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              4, 0, 4, 0),
                                                      child: TextFormField(
                                                        controller:
                                                            rejectedSearch,
                                                        obscureText: false,
                                                        onChanged: (text) {
                                                          searchRejectedRqst(
                                                              text,
                                                              rejectedRequets);

                                                          setState(() {});
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          labelText: 'Search ',
                                                          hintText:
                                                              'Please Enter Name',
                                                          labelStyle:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Color(
                                                                0xFF7C8791),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                              color: Color(
                                                                  0x00000000),
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                              color: Color(
                                                                  0x00000000),
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          filled: true,
                                                          fillColor:
                                                              Colors.white,
                                                        ),
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          color: myColor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            0, 0, 8, 0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        rejectedSearch.clear();

                                                        setState(() {});
                                                      },
                                                      child: Container(
                                                        width: 100,
                                                        height: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: myColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(18),
                                                        ),
                                                        child: const Center(
                                                            child: Text(
                                                          'Clear',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
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
                                        "Name",
                                        style: GoogleFonts.workSans(
                                          fontSize: scrWidth * 0.010,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Email",
                                        style: GoogleFonts.workSans(
                                          fontSize: scrWidth * 0.010,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Mobile number",
                                        style: GoogleFonts.workSans(
                                          fontSize: scrWidth * 0.010,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Status",
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
                                    rejectedSearch.text == ""
                                        ? rejectedRequets.length
                                        : searchRejected.length,
                                    (index) {
                                      RunnerModel data =
                                          rejectedSearch.text == ""
                                              ? rejectedRequets[index]
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
                                            data.name.toString(),
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(SelectableText(
                                            data.email.toString(),
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(SelectableText(
                                            data.mobileNumber.toString(),
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(SelectableText(
                                            data.status == 0
                                                ? 'Pending'
                                                : data.status == 1
                                                    ? 'Rejected'
                                                    : 'Accepted',
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
                                                          EditRunnerRequests(
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
