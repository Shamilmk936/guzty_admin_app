import 'dart:io';

import 'package:adminapp/common/show_upload.dart';
import 'package:adminapp/model/category_product_model.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/utils.dart';
import '../../../splash_Screen.dart';

class AddCategoryProduct extends StatefulWidget {
  final String id;
  final String name;
  final bool kit;
  const AddCategoryProduct(
      {super.key, required this.id, required this.name, required this.kit});

  @override
  State<AddCategoryProduct> createState() => _AddCategoryProductState();
}

class _AddCategoryProductState extends State<AddCategoryProduct> {
  String pic = '';
  var pickedFile;
  final ImagePicker _picker = ImagePicker();
  File? file;
  String url = "";
  List<String> myImages = [];
  List<String> addedSP = [];
  List subProducts = [''];
  var bytes;
  String variantId = '';
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final shortDescriptionController = TextEditingController();
  final insideController = TextEditingController();

  getSubProducts() async {
    QuerySnapshot sp =
        await FirebaseFirestore.instance.collection('subProducts').get();
    subProducts = [];
    if (sp.docs.isNotEmpty) {
      for (var a in sp.docs) {
        subProducts.add(a['name']!);
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    getSubProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: true,
        title: const Text(
          'Add Product Category',
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
      body: ListView(children: [
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
                  controller: priceController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      labelText: 'Price',
                      labelStyle: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Colors.black),
                      hintText: 'Enter Price',
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
          height: h * 0.03,
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
                  controller: shortDescriptionController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      labelText: 'Short Description',
                      labelStyle: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Colors.black),
                      hintText: 'Enter A Short Description',
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
        widget.kit == true
            ? Container(
                color: Colors.green,
                height: h * 0.05,
              )
            : const SizedBox(),
        Container(
          child: CustomDropdown.search(
            hintText: "Choose OrderTypes",
            borderSide: const BorderSide(
              width: 1.5,
              color: Color(0xffBBC5CD),
            ),
            items: List.generate(
              subProducts.length,
              (index) => subProducts[index],
            ),
            controller: insideController,
            onChanged: (text) {
              setState(() {
                if (!addedSP.contains(text)) {
                  addedSP.add(text);
                } else {
                  showSnackBar(context, 'Already Selected');
                }
                insideController.clear();

                setState(() {});
              });
            },
          ),
        ),
        addedSP.isNotEmpty
            ? Column(
                children: List.generate(
                  addedSP.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              '\u2022',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              addedSP[index],
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              addedSP.removeAt(index);
                            });
                          },
                          child: Container(
                            width: 17,
                            height: 17,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 0),
                                  color: Colors.grey.shade200,
                                  blurRadius: 1,
                                  spreadRadius: 2,
                                ),
                              ],
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.close,
                                size: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        SizedBox(
          height: h * 0.05,
        ),
        myImages.isEmpty
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
                  var productCategory = id["productCategoryId"].toString();
                  id.reference
                      .update({"productCategoryId": FieldValue.increment(1)});
                  var pId = 'GZPCID$productCategory';
                  var productData = CategoryProductModel(
                      available: true,
                      categoryId: widget.id,
                      categoryName: widget.name,
                      // combo: ,
                      createdTime: DateTime.now(),
                      deleted: false,
                      image: myImages,
                      inside: widget.kit == true ? addedSP : [''],
                      name: nameController.text,
                      price: double.tryParse(priceController.text),
                      productId: pId,
                      search: setSearchParam(nameController.text));
                  FirebaseFirestore.instance
                      .collection('storeCategory')
                      .doc(widget.id)
                      .collection('categoryProduct')
                      .doc(pId)
                      .set(productData.toJson());
                },
                child: Text(
                  'Add Product',
                  style: TextStyle(
                      fontSize: h * 0.016,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
          ],
        ),
        SizedBox(
          height: h * 0.05,
        ),
      ]),
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
    }).then((value) => myImages.add(pic));
  }
}
