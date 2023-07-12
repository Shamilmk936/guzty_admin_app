
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/show_upload.dart';
import '../../../model/store_category.dart';
import '../../../splash_Screen.dart';

class AddKitCategory extends StatefulWidget {
  const AddKitCategory({Key? key}) : super(key: key);

  @override
  State<AddKitCategory> createState() => _AddKitCategoryState();
}

class _AddKitCategoryState extends State<AddKitCategory> {
  final nameController = TextEditingController();
  bool kit = false;
  bool available = false;
  bool update = false;
  String categoryId = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: true,
        title: const Text(
          'Add Kit Category',
          style: TextStyle(
            fontFamily: 'Lexend Deca',
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        actions: const [],
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: h * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: scrHeight * 0.075,
                width: scrWidth * 0.85,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 2,
                          offset: Offset(2, 0))
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none),
                        labelText: 'Name',
                        labelStyle: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Colors.black),
                        hintText: 'Enter Kit Category Name',
                        hintStyle: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                            color: Colors.black)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     const Text('Add as Kit'),
          //     ToggleSwitch(
          //       minWidth: w * 0.2,
          //       minHeight: h * 0.04,
          //       initialLabelIndex: 0,
          //       totalSwitches: 2,
          //       activeBgColor: const [Colors.green],
          //       activeFgColor: Colors.white,
          //       inactiveBgColor: Colors.red,
          //       inactiveFgColor: Colors.white,
          //       labels: const [
          //         'No ',
          //         'Yes ',
          //       ],
          //       onToggle: (index) {
          //         print(kit);
          //         index == 0 ? kit : !kit;
          //         kit = !kit;
          //       },
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: h * 0.02,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     const Text('Available'),
          //     ToggleSwitch(
          //       minWidth: w * 0.2,
          //       minHeight: h * 0.04,
          //       initialLabelIndex: 0,
          //       totalSwitches: 2,
          //       activeBgColor: const [Colors.green],
          //       activeFgColor: Colors.white,
          //       inactiveBgColor: Colors.red,
          //       inactiveFgColor: Colors.white,
          //       labels: const [
          //         'No ',
          //         'Yes ',
          //       ],
          //       onToggle: (index) {
          //         print(available);
          //         index == 0 ? false : true;
          //         available = !available;
          //       },
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: h * 0.05,
          // ),
          update == false
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black.withOpacity(0.78),
                            minimumSize: Size(w * 0.8, h * 0.048),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4))),
                        onPressed: () async {
                          DocumentSnapshot id = await FirebaseFirestore.instance
                              .collection('settings')
                              .doc('settings')
                              .get();
                          var storeCategory = id["storeCategoryId"].toString();
                          id.reference.update(
                              {"storeCategoryId": FieldValue.increment(1)});
                          var cId = 'GZSCID$storeCategory';
                          var storeData = StoreCategoryModel(
                              available: true,
                              name: nameController.text,
                              kit: true,
                              categoryId: cId,
                              date: DateTime.now(),
                              deleted: false,
                              search: setSearchParam(nameController.text));
                          FirebaseFirestore.instance
                              .collection('storeCategory')
                              .doc(cId)
                              .set(storeData.toJson());
                          nameController.clear();
                        },
                        child: Text(
                          'Add store Category',
                          style: TextStyle(
                              fontSize: h * 0.016,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                )
              : const SizedBox(),
          update == true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black.withOpacity(0.78),
                            minimumSize: Size(w * 0.8, h * 0.048),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4))),
                        onPressed: () async {
                          FirebaseFirestore.instance
                              .collection('storeCategory')
                              .doc(categoryId)
                              .update({'name': nameController.text});
                          nameController.clear();
                          update = false;
                          setState(() {});
                        },
                        child: Text(
                          'Edit',
                          style: TextStyle(
                              fontSize: h * 0.016,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                )
              : const SizedBox(),
          SizedBox(
            height: h * 0.05,
          ),
          const Center(
            child: Text(
              'Added Kit Category',
              style: TextStyle(
                fontFamily: 'Lexend Deca',
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            height: h * 0.02,
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('storeCategory')
                .where('kit', isEqualTo: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var data = snapshot.data!.docs;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      nameController.text = data[index]['name'];
                      update = true;
                      categoryId = data[index].id;
                      setState(() {});
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          height: scrHeight * 0.075,
                          width: scrWidth * 0.85,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 2,
                                    offset: Offset(2, 0))
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(data[index]['name'],
                                  style: GoogleFonts.ubuntu(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15,
                                      color: Colors.black)),
                              const Icon(Icons.edit)
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
