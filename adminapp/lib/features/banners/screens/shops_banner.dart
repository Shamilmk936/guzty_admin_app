import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:multiple_select/Item.dart';
// import 'package:multiple_select/multi_filter_select.dart';
// import 'package:multiple_select/multiple_select.dart';

import '../../../core/common/ShopPopUp.dart';
import '../../../splash_Screen.dart';

Map<String, dynamic> shopMap = {};

class ShopsBanner extends StatefulWidget {
  ShopsBanner({Key? key}) : super(key: key);

  @override
  _BreakFastBannerWidget createState() => _BreakFastBannerWidget();
}

class _BreakFastBannerWidget extends State<ShopsBanner> {
  String uploadedFileUrl = '';
  String selectedBrand = '';
  String selectedShop = '';
  String selectedProducts = '';
  String selectedCategory = '';
  List<DropdownMenuItem> fetchedBrand = [];
  List<DropdownMenuItem> fetchedProducts = [];
  List<DropdownMenuItem> fetchedCategory = [];
  // List<MultipleSelectItem> shop = [];
  // List<Item> fetchedShops = [];
  // List<Item> eFetchedUsers = [];

  List _selectedCuisine = [];
  List _eSelectedCuisine = [];

  TimeOfDay? openTime;
  TimeOfDay? eOpenTime;
  TimeOfDay? eClosingTime;
  TimeOfDay? closingTime;

  late TextEditingController name;
  late TextEditingController eName;

  // Future getShops() async {
  //   QuerySnapshot data1 =
  //       await FirebaseFirestore.instance.collection("shops").get();
  //
  //   for (var doc in data1.docs) {
  //     shop.add(MultipleSelectItem.build(
  //       value: doc.id,
  //       display: doc['name'],
  //       content: doc['name'],
  //     ));
  //     eFetchedUsers.add(Item.build(
  //       value: doc.id,
  //       display: doc.get('name'),
  //       content: doc.get('name'),
  //     ));
  //
  //     // shopDetails.add(doc.data());
  //     shops[doc.get('name')] = doc.get('shopId');
  //     shopMap[doc.id] = doc.get('name');
  //     shopsName[doc.get('shopId')] = doc.get('name');
  //   }
  //   if (mounted) {
  //     setState(() {});
  //   }
  // }

  bool a = false;
  // getCategory() {
  //   FirebaseFirestore.instance
  //       .collection('banner')
  //       .doc(currentBranchId)
  //       .snapshots()
  //       .listen((event) {
  //     if (event.exists) {
  //       data = event['homeCategoryList'];
  //
  //       data.sort((a, b) {
  //         return a['order'].compareTo(b['order']);
  //       });
  //
  //       if (mounted) {
  //         setState(() {});
  //       }
  //     }
  //   });
  // }

  Map<String, dynamic> shops = {};
  Map<String, dynamic> shopsName = {};
  Map<String, dynamic> category = {};
  Map<String, dynamic> brand = {};
  Map<String, dynamic> product = {};

  Map<String, dynamic> categoryDetails = {};
  Map<String, dynamic> productDetails = {};
  Map<String, dynamic> brandDetails = {};
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String dropDownValue = '1';
  String eDropDownValue = '2';

  List data = [];
  var selectedList;
  int selectedIndex = 0;

  bool edit = false;

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    eName = TextEditingController();

    // getShops();
    // getCategory();
  }

  @override
  Widget build(BuildContext context) {
    print(dropDownValue);
    print(eDropDownValue);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          'Category List',
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
            ),
            edit == true && dropDownValue == null
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10.0),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.30,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Color(0xFFE6E6E6),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                child: TextFormField(
                                  controller: eName,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF8B97A2),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                    hintText: 'Please Enter Name',
                                    hintStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF8B97A2),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                  ),
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            DropdownButton<String>(
                              focusColor: Colors.white,
                              value: eDropDownValue,
                              //elevation: 5,
                              style: TextStyle(color: Colors.white),
                              iconEnabledColor: Colors.black,
                              items: <String>[
                                '1',
                                '2',
                                '3',
                                '4',
                                '5',
                                '6',
                                '8',
                                '9',
                                '10',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                              hint: Text(
                                "Please choose a langauage",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  eDropDownValue = value!;
                                });
                              },
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    eOpenTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(
                                          DateTime.now()),
                                    );

                                    setState(() {});
                                  },
                                  child: Text(eOpenTime == null
                                      ? 'Open'
                                      : '${eOpenTime?.format(context)}'),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    eClosingTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(
                                          DateTime.now()),
                                    );

                                    setState(() {});
                                  },
                                  child: Text(
                                      "${eClosingTime == null ? 'Close' : eClosingTime?.format(context)}"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          // width: MediaQuery.of(context).size.width*0.2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Color(0xFFE6E6E6),
                            ),
                          ),
                          // child: MultiFilterSelect(
                          //     allItems: eFetchedUsers,
                          //     initValue: _eSelectedCuisine,
                          //     hintText: 'Select Shops',
                          //     selectCallback: (List selectedValue) {
                          //       _eSelectedCuisine = selectedValue;
                          //       print(selectedValue);
                          //     })
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                edit = false;
                                eDropDownValue = "";
                                setState(() {});
                              },
                              child: Text('Cancel'),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                // print(eOpenTime?.minute);
                                //
                                // if(eName.text!=''&&eOpenTime!=null&&eClosingTime!=null&&_eSelectedCuisine.isNotEmpty){
                                //   bool pressed=await alert(context, 'Update Category List');
                                //   if(pressed){
                                //     List list=[];
                                //
                                //     list.add({
                                //       'name':eName.text,
                                //       'open':eOpenTime!.hour.toString()+':'+eOpenTime!.minute.toString(),
                                //       'close':eClosingTime!.hour.toString()+':'+eClosingTime!.minute.toString(),
                                //       'order':int.tryParse(eDropDownValue),
                                //       'shops':_eSelectedCuisine
                                //     });
                                //
                                //     FirebaseFirestore.instance.collection('banner')
                                //         .doc(currentBranchId)
                                //         .update({
                                //       'homeCategoryList':FieldValue.arrayRemove([selectedList]),
                                //     });
                                //
                                //     FirebaseFirestore.instance.collection('banner')
                                //         .doc(currentBranchId)
                                //         .update({
                                //       'homeCategoryList':FieldValue.arrayUnion(list),
                                //     });
                                //
                                //
                                //
                                //     showUploadMessage(context, 'List Updated...');
                                //     setState(() {
                                //       edit=false;
                                //       eName.clear();
                                //       eOpenTime=null;
                                //       eClosingTime=null;
                                //       _eSelectedCuisine.clear();
                                //     });
                                //
                                //   }
                                // }else{
                                //   eName.text==''?showUploadMessage(context, 'Please Enter Name'):
                                //   eOpenTime==null?showUploadMessage(context, 'Please Choose Opening Time'):
                                //   _eSelectedCuisine.isEmpty?showUploadMessage(context, 'Please Choose Shops'):
                                //   showUploadMessage(context, 'Please Choose Closing Time');
                                // }
                                //
                                //
                              },
                              child: Text('Update'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10.0),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.30,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Color(0xFFE6E6E6),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                child: TextFormField(
                                  controller: name,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF8B97A2),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                    hintText: 'Please Enter Name',
                                    hintStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF8B97A2),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                  ),
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            DropdownButton<String>(
                              focusColor: Colors.white,
                              value: dropDownValue,
                              //elevation: 5,
                              style: TextStyle(color: Colors.white),
                              iconEnabledColor: Colors.black,
                              items: <String>[
                                '1',
                                '2',
                                '3',
                                '4',
                                '5',
                                '6',
                                '8',
                                '9',
                                '10',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                              hint: Text(
                                "Please choose",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  dropDownValue = value!;
                                });
                              },
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    openTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(
                                          DateTime.now()),
                                    );

                                    setState(() {});
                                  },
                                  child: Text(openTime == null
                                      ? 'Open'
                                      : '${openTime?.format(context)}'),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    closingTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(
                                          DateTime.now()),
                                    );

                                    setState(() {});
                                  },
                                  child: Text(closingTime == null
                                      ? 'Close'
                                      : closingTime!.format(context)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            // width: MediaQuery.of(context).size.width*0.2,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Color(0xFFE6E6E6),
                              ),
                            ),
                            // child: MultiFilterSelect(
                            //     allItems: eFetchedUsers,
                            //     initValue: _selectedCuisine,
                            //     hintText: 'Select Shops',
                            //     selectCallback: (List selectedValue) {
                            //       _selectedCuisine = selectedValue;
                            //       print(selectedValue);
                            //     })),
                          )),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                              ),
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    // if(name.text!=''&&openTime!=null&&closingTime!=null&&_selectedCuisine.isNotEmpty){
                                    //   bool pressed=await alert(context, 'Add Category List');
                                    //   if(pressed){
                                    //     List list=[];
                                    //     list.add({
                                    //       'name':name.text,
                                    //       'open':openTime!.hour.toString()+':'+openTime!.minute.toString(),
                                    //       'close':closingTime!.hour.toString()+':'+closingTime!.minute.toString(),
                                    //       'order':int.tryParse(dropDownValue),
                                    //       'shops':_selectedCuisine
                                    //     });
                                    //
                                    //
                                    //
                                    //     FirebaseFirestore.instance.collection('banner')
                                    //         .doc(currentBranchId)
                                    //         .update({
                                    //       'homeCategoryList':FieldValue.arrayUnion(list),
                                    //     });
                                    //
                                    //
                                    //
                                    //     showUploadMessage(context, 'New List Added...');
                                    //     setState(() {
                                    //       name.clear();
                                    //       openTime=null;
                                    //       closingTime=null;
                                    //       _selectedCuisine.clear();
                                    //     });
                                    //
                                    //   }
                                    // }else{
                                    //   name.text==''?showUploadMessage(context, 'Please Enter Name'):
                                    //   openTime==null?showUploadMessage(context, 'Please Choose Opening Time'):
                                    //   _selectedCuisine.isEmpty?showUploadMessage(context, 'Please Choose Shops'):
                                    //   showUploadMessage(context, 'Please Choose Closing Time');
                                    // }
                                    //
                                    //
                                    //
                                  },
                                  child: Text('Add'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
            data.length == 0
                ? CircularProgressIndicator()
                : SizedBox(
                    width: double.infinity,
                    child: DataTable(
                      horizontalMargin: 10,
                      columns: [
                        DataColumn(
                          label: Text(
                            "Sl No",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 11),
                          ),
                        ),
                        DataColumn(
                          label: Text("Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 11)),
                        ),
                        DataColumn(
                          label: Text("Order",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 11)),
                        ),
                        DataColumn(
                          label: Text("Opening",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 11)),
                        ),
                        DataColumn(
                          label: Text("Closing",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 11)),
                        ),
                        DataColumn(
                          label: Text("Shops",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 11)),
                        ),
                        DataColumn(
                          label: Text("Action",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 11)),
                        ),
                      ],
                      rows: List.generate(
                        data.length,
                        (index) {
                          String names = data[index]['name'];
                          String opening = data[index]['open'];
                          String closing = data[index]['close'];
                          String order = data[index]['order'].toString();
                          List shops = data[index]['shops'];

                          return DataRow(
                            onLongPress: () {
                              showDialog(
                                  context: context,
                                  builder: (buildContext) {
                                    return ShopPopUp(
                                      shops: shops,
                                    );
                                  });
                            },
                            color: index.isOdd
                                ? MaterialStateProperty.all(
                                    Colors.blueGrey.shade50.withOpacity(0.7))
                                : MaterialStateProperty.all(
                                    Colors.blueGrey.shade50),
                            cells: [
                              DataCell(Text(
                                (index + 1).toString(),
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                              DataCell(Text(
                                names,
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                              DataCell(Text(
                                order,
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                              DataCell(Text(
                                opening,
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                              DataCell(Text(
                                closing,
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                              DataCell(Text(
                                shops.length.toString(),
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: data[index]['status'] == 1
                                      ? Color(0xFF4B39EF)
                                      : Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                              DataCell(
                                Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // setState(() {
                                        //   selectedList=data[index];
                                        //   edit=true;
                                        //   dropDownValue=null;
                                        //
                                        //   eDropDownValue=data[index]['order'].toString();
                                        //   eName.text=names;
                                        //   eOpenTime=TimeOfDay(hour:int.parse(opening.split(":")[0]),minute: int.parse(opening.split(":")[1]));
                                        //   eClosingTime=TimeOfDay(hour:int.parse(closing.split(":")[0]),minute: int.parse(closing.split(":")[1]));
                                        //   _selectedCuisine=[];
                                        //   _eSelectedCuisine=[];
                                        //   shops.forEach((element) {
                                        //     _eSelectedCuisine.add(element);
                                        //   });
                                        //   print('value '+eDropDownValue+' is');
                                        //
                                        //
                                        //
                                        // });
                                      },
                                      child: Text('Add'),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Color(0xFFEE0000),
                                        size: 25,
                                      ),
                                      onPressed: () async {
                                        //
                                        // bool pressed=await alert(context, 'Do you want Delete List');
                                        //
                                        // if(pressed){
                                        //   a=false;
                                        //   edit=false;
                                        //
                                        //
                                        //   FirebaseFirestore.instance.collection('banner')
                                        //       .doc(currentBranchId)
                                        //       .update({
                                        //     'homeCategoryList':FieldValue.arrayRemove([data[index]]),
                                        //   });
                                        //
                                        //   showUploadMessage(context, 'List Deleted...');
                                        //   setState(() {
                                        //
                                        //   });
                                        //
                                        // }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              // DataCell(Text(fileInfo.size)),
                            ],
                          );
                        },
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
