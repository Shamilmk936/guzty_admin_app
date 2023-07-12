import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../model/runnerModel.dart';
import '../../splash_Screen.dart';
import '../authentication/login_page.dart';
import 'AddRunner.dart';
import 'editRunner.dart';


class RunnersList extends StatefulWidget {
  const RunnersList({Key? key}) : super(key: key);

  @override
  State<RunnersList> createState() => _RunnersListState();
}

class _RunnersListState extends State<RunnersList> {
  List<RunnerModel> runnerList=[];
  getRunner(){

    FirebaseFirestore.instance.collection('runner').
    orderBy('createdTime',descending: true)
    .where('delete',isEqualTo: false).
    where('status',isEqualTo: 2)
        .snapshots().listen((event) {
      runnerList=[];
      for(var doc in event.docs){
        runnerList.add(RunnerModel.fromJson(doc.data()));

        print(runnerList);
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
 // String? userId;
  TextEditingController planSearch = TextEditingController(text: '');

  List searchList=[];
  searchShop(String search,List runList){

    searchList.clear();

    for(RunnerModel searchItem in runList){

      if(searchItem.name.toString().toUpperCase().contains(search.toUpperCase())){
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
    getRunner();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Center(
          child: Text('RUNNERS LIST',
            style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),),
        ),
        actions: [


        ],
      ),
      body: Container(
        child:  Column(
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
                                  searchShop(text,runnerList);

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
                        AddRunner()));
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
                          'Create Runner',
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
                      label: Text(" Name",
                        style:  GoogleFonts.workSans(
                          fontSize: scrWidth*0.010,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),),
                    ),
                    DataColumn(
                      label: Text("Email",
                        style:  GoogleFonts.workSans(
                          fontSize: scrWidth*0.010,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),),
                    ),
                    DataColumn(
                      label: Text("Phone",
                        style:  GoogleFonts.workSans(
                          fontSize: scrWidth*0.010,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),),
                    ),
                    DataColumn(
                      label: Text("Wallet",
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
                    planSearch.text==''?  runnerList.length:searchList.length,
                        (index) {
                      RunnerModel data=planSearch.text==''? runnerList[index]:searchList[index];

                      return DataRow(
                        color: index.isOdd?
                        MaterialStateProperty.all(Colors.blueGrey.shade50.withOpacity(0.7))
                            :MaterialStateProperty.all(Colors.blueGrey.shade50),
                        cells: [
                          DataCell(Container(
                            width:MediaQuery.of(context).size.width*0.03,
                            child: SelectableText('${index+1}',  style:TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),),
                          )),

                          DataCell(SelectableText(data.name.toString(),  style:TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),)),
                          DataCell(SelectableText(data.email.toString(),  style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),)),

                          DataCell(SelectableText(data.mobileNumber.toString(),  style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),)),
                          DataCell(SelectableText(data.walletBalance.toString(),  style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),)),
                          DataCell(InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>EditRunner(
                                  data: data,
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
                                  'Edit',  style:TextStyle(
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
                                            title: const Text('Delete Runner'),
                                            content: const Text('Do you want to delete?'),
                                            actions: [
                                              TextButton(
                                                  onPressed: (){
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Cancel',style: TextStyle(color: Colors.black),)),
                                              TextButton(
                                                  onPressed: (){

                                                    FirebaseFirestore.instance.collection('runner').doc(data.uid).update({
                                                      'delete' : true,
                                                    });
                                                    Navigator.pop(context);
                                                    showUploadMessage(context, 'Runner deleted Successfully');
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
