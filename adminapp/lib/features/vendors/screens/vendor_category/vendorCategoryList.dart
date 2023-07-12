import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../common/show_upload.dart';
import '../../../../model/vendorCategoryModel.dart';
import '../../../../splash_Screen.dart';
import 'package:intl/intl.dart';

class vendorCategoryList extends StatefulWidget {
  const vendorCategoryList({Key? key}) : super(key: key);

  @override
  State<vendorCategoryList> createState() => _vendorCategoryListState();
}

class _vendorCategoryListState extends State<vendorCategoryList> {
  List<vendorCategoryModel> categoryList = [];
  TextEditingController categoryName = TextEditingController();
  String vendorCategoryId = '';
  getAdmins() {
    FirebaseFirestore.instance
        .collection('vendorCategory')
        .where('deleted', isEqualTo: false)
        .orderBy('date', descending: true)
        .snapshots()
        .listen((event) {
      categoryList = [];
      for (var doc in event.docs) {
        categoryList.add(vendorCategoryModel.fromJson(doc.data()));

        print(categoryList);
        print('planList');
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  bool view = false;
  bool add = false;
  bool update = false;
  String? userId;

  TextEditingController planSearch = TextEditingController(text: '');

  List searchList = [];
  searchShop(String search, List shop) {
    searchList.clear();

    for (vendorCategoryModel searchItem in shop) {
      if (searchItem.name
          .toString()
          .toUpperCase()
          .contains(search.toUpperCase())) {
        searchList.add(searchItem);
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    getAdmins();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Center(
          child: Text(
            'VENDOR CATEGORIES',
            style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            add == true
                ? Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            height: h * 0.075,
                            width: w * 0.35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 2,
                                      offset: Offset(2, 0))
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20, top: 10),
                              child: TextFormField(
                                controller: categoryName,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide.none),
                                    labelText: 'Vendor Category',
                                    labelStyle: GoogleFonts.ubuntu(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: Colors.black),
                                    hintText: 'Enter Vendor Category',
                                    hintStyle: GoogleFonts.ubuntu(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 15,
                                        color: Colors.black)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  add = false;
                                  setState(() {});
                                  categoryName.clear();
                                  update = false;
                                },
                                child: Container(
                                  height: h * 0.05,
                                  width: w * 0.15,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: primaryColor),
                                  child: Center(
                                    child: Text(
                                      'Clear',
                                      style: GoogleFonts.ubuntu(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  if (categoryName.text.isEmpty) {
                                    return showErrorToast(context,
                                        "Please Enter Vendor Category");
                                  } else {
                                    QuerySnapshot snap = await FirebaseFirestore
                                        .instance
                                        .collection('vendorCategory')
                                        .where('name',
                                            isEqualTo: categoryName.text)
                                        .get();

                                    if (snap.docs.isEmpty) {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text(update == false
                                                  ? 'Add Vendor Category?'
                                                  : 'Edit Vendor Category'),
                                              content: Text(
                                                  'Do you want to continue?'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                          color: primaryColor),
                                                    )),
                                                TextButton(
                                                    onPressed: () {
                                                      if (update == false) {
                                                        final shop =
                                                            vendorCategoryModel(
                                                                date: DateTime
                                                                    .now(),
                                                                deleted: false,
                                                                name: categoryName
                                                                    .text
                                                                    .toUpperCase());
                                                        add = false;
                                                        AdminModels(shop);
                                                        Navigator.of(context)
                                                            .pop();
                                                        showSuccessToast(
                                                            context,
                                                            'Vendor Category Created Successfully');
                                                      } else {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'vendorCategory')
                                                            .doc(
                                                                vendorCategoryId)
                                                            .update({
                                                          'name':
                                                              categoryName.text,
                                                        });
                                                        update = false;
                                                        add = false;
                                                        Navigator.of(context)
                                                            .pop();
                                                        showSuccessToast(
                                                            context,
                                                            'Vendor Category Updated Successfully');
                                                      }
                                                    },
                                                    child: Text(
                                                      'ok',
                                                      style: TextStyle(
                                                          color: primaryColor),
                                                    ))
                                              ],
                                            );
                                          });
                                    } else {
                                      showErrorToast(context,
                                          'Category Name Already Exsist');
                                    }
                                  }
                                },
                                child: Container(
                                  height: h * 0.05,
                                  width: w * 0.15,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: primaryColor),
                                  child: Center(
                                    child: Text(
                                      update == false ? 'Add ' : 'Edit ',
                                      style: GoogleFonts.ubuntu(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                : SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 0, 20),
                  child: Container(
                    width: w * 0.300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 3,
                          color: Color(0x39000000),
                          offset: Offset(0, 1),
                        )
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  4, 0, 4, 0),
                              child: TextFormField(
                                controller: planSearch,
                                obscureText: false,
                                onChanged: (text) {
                                  searchShop(text, categoryList);

                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  labelText: 'Search ',
                                  hintText: 'Please Enter Name',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: const Color(0xFF7C8791),
                                    fontSize: w * 0.010,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: const Color(0x00000000),
                                      width: w * 0.002,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: const Color(0x00000000),
                                      width: w * 0.002,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: myColor,
                                  fontSize: w * 0.010,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 8, 0),
                            child: InkWell(
                              onTap: () {
                                planSearch.clear();

                                setState(() {});
                              },
                              child: Container(
                                width: w * 0.070,
                                height: w * 0.020,
                                decoration: BoxDecoration(
                                  color: myColor,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: const Center(
                                    child: Text(
                                  'Clear',
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                add == false
                    ? InkWell(
                        onTap: () {
                          add = true;
                          setState(() {});
                        },
                        child: Container(
                          width: w * 0.080,
                          height: w * 0.025,
                          decoration: BoxDecoration(
                            color: myColor,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Center(
                              child: Text(
                            'Create Category',
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      )
                    : SizedBox(),

                // InkWell(
                //   onTap: () {
                //     add = false;
                //     dataDoc.clear();
                //     fileNameController.clear();
                //     name.clear();
                //     phoneNumber.clear();
                //     idNumber.clear();
                //     address.clear();
                //     emailController.clear();
                //     setState(() {});
                //     setState(() {});
                //   },
                //   child: Container(
                //     height: scrWidth*0.025,
                //     width: scrWidth*0.080,
                //     decoration: BoxDecoration(
                //       color: Colors.red,
                //       borderRadius:
                //       BorderRadius.circular(15),
                //     ),
                //     child: const Center(
                //       child: Text(
                //         'Clear',
                //         style: TextStyle(
                //             color: Colors.white,
                //             fontSize: 15,
                //             fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //   ),
                // ),
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
                  headingRowColor: MaterialStateProperty.all(primaryColor),
                  columns: [
                    DataColumn(
                      label: Text(
                        "S.No ",
                        style: GoogleFonts.workSans(
                          fontSize: w * 0.010,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Date ",
                        style: GoogleFonts.workSans(
                          fontSize: w * 0.010,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    DataColumn(
                      label: Text(
                        "Category Name",
                        style: GoogleFonts.workSans(
                          fontSize: w * 0.010,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Action",
                        style: GoogleFonts.workSans(
                          fontSize: w * 0.010,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // DataColumn(
                    //   label: Text("Delete",
                    //     style:  GoogleFonts.workSans(
                    //       fontSize: scrWidth*0.010,
                    //       fontWeight: FontWeight.w700,
                    //       color: Colors.white,
                    //     ),),
                    // ),
                  ],
                  rows: List.generate(
                    planSearch.text == ''
                        ? categoryList.length
                        : searchList.length,
                    (index) {
                      vendorCategoryModel data = planSearch.text == ''
                          ? categoryList[index]
                          : searchList[index];

                      return DataRow(
                        color: index.isOdd
                            ? MaterialStateProperty.all(
                                Colors.blueGrey.shade50.withOpacity(0.7))
                            : MaterialStateProperty.all(
                                Colors.blueGrey.shade50),
                        cells: [
                          DataCell(Container(
                            width: MediaQuery.of(context).size.width * 0.03,
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
                            width: MediaQuery.of(context).size.width * 0.05,
                            child: SelectableText(
                              DateFormat('dd-MM-yyyy')
                                  .format(data.date)
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

                          DataCell(InkWell(
                            onTap: () {
                              categoryName.text = data.name;
                              update = true;
                              add = true;
                              vendorCategoryId = data.id!;
                              setState(() {});
                            },
                            child: Container(
                              height: 45,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: primaryColor,
                              ),
                              child: Center(
                                child: Text(
                                  'Edit',
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
                          // DataCell(
                          //     InkWell(
                          //         onTap: (){
                          //           showDialog(
                          //               context: context,
                          //               builder: (buildcontext)
                          //               {
                          //                 return AlertDialog(
                          //                   title: const Text('Delete Vendor Category'),
                          //                   content: const Text('Do you want to delete?'),
                          //                   actions: [
                          //                     TextButton(
                          //                         onPressed: (){
                          //                           Navigator.pop(context);
                          //                         },
                          //                         child: Text('Cancel',style: TextStyle(color: Colors.black),)),
                          //                     TextButton(
                          //                         onPressed: (){
                          //
                          //                           FirebaseFirestore.instance.collection('vendorCategory').doc(data.id).update(
                          //                               {
                          //                                 'deleted':true
                          //                               });
                          //                           Navigator.pop(context);
                          //                         },
                          //                         child: Text('Delete',style: TextStyle(color: Colors.black),)),
                          //                   ],
                          //                 );
                          //               });
                          //         },
                          //         child: Icon(Icons.delete,color: Colors.black,))
                          // ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AdminModels(vendorCategoryModel adminUser) {
    FirebaseFirestore.instance
        .collection('vendorCategory')
        .add(adminUser.toJson())
        .then((value) {
      value.update({'id': value.id});
    });
  }
}
