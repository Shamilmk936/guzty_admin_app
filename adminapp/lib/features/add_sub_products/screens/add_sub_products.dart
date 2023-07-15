import 'dart:io';

import 'package:adminapp/model/sub_Product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/show_upload.dart';
import '../../../splash_Screen.dart';

class AddSubProducts extends StatefulWidget {
  const AddSubProducts({Key? key}) : super(key: key);

  @override
  State<AddSubProducts> createState() => _AddSubProductsState();
}

class _AddSubProductsState extends State<AddSubProducts> {
  String pic = '';
  var pickedFile;
  final ImagePicker _picker = ImagePicker();
  File? file;
  String url = "";
  var bytes;
  String variantId = '';
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: true,
        title: const Text(
          'Add Sub Products',
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
                        hintText: 'Enter Name of Sub Product',
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
          pic == ''
              ? InkWell(
                  onTap: () {
                    _imgFromGallery();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: scrWidth * 0.3,
                        height: scrHeight * 0.1,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: primaryColor)),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.add_circle_outline_outlined,
                              color: primaryColor,
                              size: 30,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              "Pick Image",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                          ],
                        )),
                      ),
                    ],
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: scrWidth * 0.3,
                      height: scrHeight * 0.1,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: primaryColor)),
                      child: CachedNetworkImage(imageUrl: pic),
                    ),
                  ],
                ),
          const SizedBox(
            height: 20,
          ),
          Row(
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
                    var subProduct = id["subProductId"].toString();
                    id.reference
                        .update({"subProductId": FieldValue.increment(1)});
                    var spId = 'GZSPID$subProduct';
                    var subProductData = SubProductModel(
                        name: nameController.text,
                        deleted: false,
                        available: true,
                        image: pic,
                        subProductId: spId,
                        createdTime: DateTime.now(),
                        search: setSearchParam(nameController.text));
                    FirebaseFirestore.instance
                        .collection('subProducts')
                        .doc(spId)
                        .set(subProductData.toJson());
                    setState(() {});
                  },
                  child: Text(
                    'Add Sub Products',
                    style: TextStyle(
                        fontSize: h * 0.016,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     ElevatedButton(
          //         style: ElevatedButton.styleFrom(
          //             backgroundColor: Colors.black.withOpacity(0.78),
          //             minimumSize: Size(w * 0.8, h * 0.048),
          //             shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(4))),
          //         onPressed: () async {
          //           FirebaseFirestore.instance
          //               .collection('variants')
          //               .doc(variantId)
          //               .update({'name': nameController.text});
          //           nameController.clear();

          //           setState(() {});
          //         },
          //         child: Text(
          //           'Edit',
          //           style: TextStyle(
          //               fontSize: h * 0.016,
          //               color: Colors.white,
          //               fontWeight: FontWeight.bold),
          //         )),
          //   ],
          // ),

          SizedBox(
            height: h * 0.05,
          ),
          const Center(
            child: Text(
              'Added Sub Products',
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
        ],
      ),
    );
  }

  _imgFromGallery() async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 70);

    var fileName = DateTime.now();
    var ref = FirebaseStorage.instance
        .ref()
        .child('onlineStudents/$currentUserId/$fileName');
    UploadTask uploadTask = ref.putFile(File(image!.path));
    uploadTask.then((res) async {
      pic = (await ref.getDownloadURL()).toString();
      setState(() {});
      print('--------------------------------------------------------------');
      print(pic);
      print('--------------------------------------------------------------');
    });
  }
}
