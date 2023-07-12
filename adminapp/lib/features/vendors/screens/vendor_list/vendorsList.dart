import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../model/vendorModel.dart';
import '../../../../splash_Screen.dart';
import 'addVendor.dart';
import 'editVendor.dart';

class VendorsList extends StatefulWidget {
  const VendorsList({Key? key}) : super(key: key);

  @override
  State<VendorsList> createState() => _VendorsListState();
}

class _VendorsListState extends State<VendorsList> {
  List<VendorModel> vendorsList=[];
  getVendors(){

    FirebaseFirestore.instance.collection('vendors').where('verified',isEqualTo: true).where('deleted',isEqualTo: false).orderBy('createdTime',descending: true).snapshots().listen((event) {
      vendorsList=[];
      for(var doc in event.docs){
        vendorsList.add(VendorModel.fromJson(doc.data()));

        print(vendorsList);
        print('planList');

      }
      if(mounted){
        setState(() {

        });
      }

    });
  }
  bool view=false;
  String? ImgUrl;
  String? userId;
  TextEditingController planSearch = TextEditingController(text: '');

  List searchList=[];
  searchShop(String search,List shop){

    searchList.clear();

    for(VendorModel searchItem in shop){

      if(searchItem.shopName.toString().toUpperCase().contains(search.toUpperCase())){
        searchList.add(searchItem);

      }
    }
    if(mounted){
      setState(() {

      });
    }

  }




  @override
  void initState() {
    getVendors();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Center(
          child: Text('VENDORS LIST',
            style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),),
        ),

      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                  const EdgeInsetsDirectional.fromSTEB(
                      20, 20, 0, 20),
                  child: Container(
                    width: scrWidth * 0.300,
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
                      BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional
                          .fromSTEB(0, 4, 0, 0),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                              const EdgeInsetsDirectional
                                  .fromSTEB(4, 0, 4, 0),
                              child: TextFormField(
                                controller: planSearch,
                                obscureText: false,
                                onChanged: (text) {
                                  searchShop(text.trim(),vendorsList);

                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  labelText: 'Search ',
                                  hintText: 'Please Enter Name',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: const Color(
                                        0xFF7C8791),
                                    fontSize:
                                    scrWidth * 0.010,
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                  enabledBorder:
                                  OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: const Color(
                                          0x00000000),
                                      width:
                                      scrWidth * 0.002,
                                    ),
                                    borderRadius:
                                    BorderRadius
                                        .circular(15),
                                  ),
                                  focusedBorder:
                                  OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: const Color(
                                          0x00000000),
                                      width:
                                      scrWidth * 0.002,
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
                                  fontSize:
                                  scrWidth * 0.010,
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
                                planSearch.clear();

                                setState(() {});
                              },
                              child: Container(
                                width: scrWidth * 0.070,
                                height: scrWidth * 0.020,
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
                SizedBox(width: 50,),
                 InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        AddVendor()));
                  },
                  child: Container(
                    width: scrWidth * 0.080,
                    height: scrWidth * 0.025,
                    decoration: BoxDecoration(
                      color: myColor,
                      borderRadius:
                      BorderRadius.circular(18),
                    ),
                    child: const Center(
                        child: Text(
                          'Create Vendor',
                          style: TextStyle(
                              color: Colors.white),
                        )),
                  ),
                )

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
                  columnSpacing:10,
                  headingRowColor: MaterialStateProperty.all(primaryColor),
                  columns: [
                    DataColumn(
                      label: Text("S.No ",
                        style:  GoogleFonts.workSans(
                          fontSize: scrWidth*0.010,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),),
                    ),
                    DataColumn(
                      label: Text("Date ",
                        style:  GoogleFonts.workSans(
                          fontSize: scrWidth*0.010,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),),
                    ),

                    DataColumn(
                      label: Text("Shop Name",
                        style:  GoogleFonts.workSans(
                          fontSize: scrWidth*0.010,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),),
                    ),
                    DataColumn(
                      label: Text("Category",
                        style:  GoogleFonts.workSans(
                          fontSize: scrWidth*0.010,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),),
                    ),
                    DataColumn(
                      label: Text("Owner Name",
                        style:  GoogleFonts.workSans(
                          fontSize: scrWidth*0.010,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),),
                    ),
                    DataColumn(
                      label: Text("Owner Email",
                        style:  GoogleFonts.workSans(
                          fontSize: scrWidth*0.010,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),),
                    ),
                    DataColumn(
                      label: Text("Action",
                        style:  GoogleFonts.workSans(
                          fontSize: scrWidth*0.010,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),),
                    ),
                    DataColumn(
                      label: Text("Delete",
                        style:  GoogleFonts.workSans(
                          fontSize: scrWidth*0.010,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),),
                    ),




                  ],
                  rows: List.generate(
                    planSearch.text==''?  vendorsList.length:searchList.length,
                        (index) {
                      VendorModel data=planSearch.text==''? vendorsList[index]:searchList[index];

                      return DataRow(
                        color: index.isOdd?
                        MaterialStateProperty.all(Colors.blueGrey.shade50.withOpacity(0.7))
                            :MaterialStateProperty.all(Colors.blueGrey.shade50),
                        cells: [
                          DataCell(Container(
                            width:MediaQuery.of(context).size.width*0.03,
                            child: SelectableText('${index+1}',  style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),),
                          )),
                          DataCell(Container(
                            width:MediaQuery.of(context).size.width*0.05,
                            child: SelectableText(DateFormat('dd-MM-yyyy').format(data.createdTime!).toString(),
                              style:TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),),
                          )),
                          DataCell(SelectableText(data.shopName.toString(),  style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),)),
                          DataCell(SelectableText(data.categoryName.toString(),  style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),)),
                          DataCell(SelectableText(data.ownerName.toString(),  style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),)),
                          DataCell(SelectableText(data.ownerEmail.toString(),  style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),)),
                          DataCell(InkWell(
                            onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>EditVendor(
                                    data:data
                                )));

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
                                  'Edit',  style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                ),
                              ),
                            ),
                          )),
                          DataCell(
                              InkWell(
                                  onTap: (){
                                    showDialog(
                                        context: context,
                                        builder: (buildcontext)
                                        {
                                          return AlertDialog(
                                            title: const Text('Delete Vendor'),
                                            content: const Text('Do you want to delete?'),
                                            actions: [
                                              TextButton(
                                                  onPressed: (){
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Cancel',style: TextStyle(color: Colors.black),)),
                                              TextButton(
                                                  onPressed: (){

                                                    FirebaseFirestore.instance.collection('vendors').doc(data.id).update({
                                                      'deleted':true
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Delete',style: TextStyle(color: Colors.black),)),
                                            ],
                                          );
                                        });
                                  },
                                  child: Icon(Icons.delete,color: Colors.black,))
                          ),







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
}
