import 'package:adminapp/features/store/controller/store_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/show_upload.dart';
import '../../../model/store_category.dart';
import '../../../splash_Screen.dart';

class AddStoreCategory extends StatefulWidget {
  const AddStoreCategory({Key? key}) : super(key: key);

  @override
  State<AddStoreCategory> createState() => _AddStoreCategoryState();
}

class _AddStoreCategoryState extends State<AddStoreCategory> {
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
          'Add Store Category',
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
                        hintText: 'Enter Accesories Category Name',
                        hintStyle: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                            color: Colors.black)),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: h * 0.05,
          ),
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
                              kit: false,
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
              'Added Store Category',
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
          Consumer(builder: (context, ref, child) {
            var data = ref.watch(getStoreCategoriesProvider(false));
            return data.when(
              data: (data) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Text(data[index].name!);
                  },
                );
              },
              error: (error, stackTrace) {
                print(error);
                return Text(error.toString());
              },
              loading: () => const CircularProgressIndicator(),
            );
          }),
          // StreamBuilder(
          //   stream: FirebaseFirestore.instance
          //       .collection('storeCategory')
          //       .where('kit', isEqualTo: true)
          //       .snapshots(),
          //   builder: (context, snapshot) {
          //     if (!snapshot.hasData) {
          //       return const Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //     var data = snapshot.data!.docs;
          //     return ListView.builder(
          //       shrinkWrap: true,
          //       itemCount: data.length,
          //       itemBuilder: (context, index) {
          //         return InkWell(
          //           onTap: () {
          //             nameController.text = data[index]['name'];
          //             update = true;
          //             categoryId = data[index].id;
          //             setState(() {});
          //           },
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Container(
          //                 margin: const EdgeInsets.all(10),
          //                 height: scrHeight * 0.075,
          //                 width: scrWidth * 0.85,
          //                 decoration: BoxDecoration(
          //                     borderRadius: BorderRadius.circular(15),
          //                     color: Colors.white,
          //                     boxShadow: const [
          //                       BoxShadow(
          //                           color: Colors.black,
          //                           blurRadius: 2,
          //                           offset: Offset(2, 0))
          //                     ]),
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //                   children: [
          //                     Text(data[index]['name'],
          //                         style: GoogleFonts.ubuntu(
          //                             fontWeight: FontWeight.w300,
          //                             fontSize: 15,
          //                             color: Colors.black)),
          //                     const Icon(Icons.edit)
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           ),
          //         );
          //       },
          //     );
          //   },
          // )
        ],
      ),
    );
  }
}
