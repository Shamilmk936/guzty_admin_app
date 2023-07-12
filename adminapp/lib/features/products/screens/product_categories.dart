import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../common/show_upload.dart';
import '../../../common/upload_media.dart';
import '../../../model/ProductCategoryModel.dart';
import '../../../splash_Screen.dart';
import '../../authentication/login_page.dart';

class ProductCategoryList extends StatefulWidget {
  const ProductCategoryList({Key? key}) : super(key: key);

  @override
  State<ProductCategoryList> createState() => _ProductCategoryListState();
}

class _ProductCategoryListState extends State<ProductCategoryList> {
  List<productCategoryModel> categoryList = [];
  getAdmins() {
    FirebaseFirestore.instance
        .collection('productCategory')
        .where('deleted', isEqualTo: false)
        .orderBy('date', descending: true)
        .snapshots()
        .listen((event) {
      categoryList = [];
      for (var doc in event.docs) {
        categoryList.add(productCategoryModel.fromJson(doc.data()));

        print(categoryList);
        print('planList');
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  bool add = false;
  bool update = false;

  String categoryId = '';

  TextEditingController planSearch = TextEditingController(text: '');
  TextEditingController categoryName = TextEditingController(text: '');

  List searchList = [];
  String downloadUrl = '';
  searchShop(String search, List shop) {
    searchList.clear();

    for (productCategoryModel searchItem in shop) {
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
            'PRODUCT CATEGORIES',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          ),
        ),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 0, 20),
                  child: Container(
                    width: w * 0.6500,
                    height: 50,
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
                                  hintText: 'Please Enter ',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: const Color(0xFF7C8791),
                                    fontSize: h * 0.020,
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
                                  fontSize: h * 0.020,
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
                              },
                              child: Container(
                                width: w * 0.2,
                                height: h * 0.040,
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
                  width: w * 0.01,
                ),
                add == false
                    ? InkWell(
                        onTap: () {
                          add = true;
                          setState(() {});
                        },
                        child: Container(
                          width: w * 0.2,
                          height: h * 0.040,
                          decoration: BoxDecoration(
                            color: myColor,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Center(
                              child: Text(
                            'Create',
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      )
                    : Container()
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
            SizedBox(
              height: 20,
            ),
            add == true
                ? Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            width: w * 0.1,
                            height: w * 0.1,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    final selectedMedia = await selectMedia(
                                      mediaSource: MediaSource.photoGallery,
                                    );
                                    if (selectedMedia != null &&
                                        validateFileFormat(
                                            selectedMedia.storagePath,
                                            context)) {
                                      showUploadMessage(
                                          context, 'Uploading file...',
                                          showLoading: true);

                                      final metadata = SettableMetadata(
                                        contentType: 'image/jpeg',
                                        customMetadata: {
                                          'picked-file-path':
                                              selectedMedia.storagePath
                                        },
                                      );
                                      print(metadata.contentType);
                                      final uploadSnap = await FirebaseStorage
                                          .instance
                                          .ref()
                                          .child(DateTime.now()
                                              .toLocal()
                                              .toString()
                                              .substring(0, 10))
                                          .child(DateTime.now()
                                              .toLocal()
                                              .toString()
                                              .substring(10, 17))
                                          .putData(
                                              selectedMedia.bytes, metadata);
                                      downloadUrl =
                                          await uploadSnap.ref.getDownloadURL();
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      if (downloadUrl != '' &&
                                          downloadUrl != null) {
                                        setState(() {});
                                        print(downloadUrl.toString() +
                                            "   mnmnmnmnmn");
                                        showUploadMessage(context, 'Success!');
                                      } else {
                                        showUploadMessage(
                                            context, 'Failed to upload media');
                                        return;
                                      }
                                    }
                                  },
                                  child: DottedBorder(
                                    color: Colors.black,
                                    strokeWidth: 1,
                                    child: SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: Center(
                                          child: downloadUrl == '' ||
                                                  downloadUrl == null
                                              ? const Text('Upload Image')
                                              : Container(
                                                  height: 100,
                                                  width: 100,
                                                  child: Image.network(
                                                      downloadUrl),
                                                  // decoration: BoxDecoration(
                                                  //     image: DecorationImage(
                                                  //         image:
                                                  //         NetworkImage(
                                                  //             downloadUrl))),
                                                  // child: const Center(
                                                  //   child: Icon(
                                                  //     FontAwesomeIcons.edit,
                                                  //     shadows: [
                                                  //       Shadow(
                                                  //         blurRadius: 15.0,
                                                  //         color: Colors.white,
                                                  //       ),
                                                  //     ],
                                                  //     color: Colors.black,
                                                  //   ),
                                                  // ),
                                                ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                                    labelText: 'Enter Product Category',
                                    labelStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: Colors.black),
                                    hintText: 'Product Category',
                                    hintStyle: TextStyle(
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    add = false;
                                    update = false;
                                    downloadUrl = '';
                                    categoryName.clear();
                                    setState(() {});
                                  });
                                },
                                child: Container(
                                  height: h * 0.05,
                                  width: w * 0.10,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: primaryColor),
                                  child: Center(
                                    child: Text(
                                      'clear',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {});

                                  if (categoryName.text.isEmpty) {
                                    return showSnackbar(context,
                                        "Please Enter Product Category");
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(update == false
                                                ? 'Add ?'
                                                : 'Edit '),
                                            content: Text(
                                                'Do you want to continue?'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color: primaryColor),
                                                  )),
                                              TextButton(
                                                  onPressed: () async {
                                                    if (update == false) {
                                                      QuerySnapshot snap =
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'productCategory')
                                                              .where('name',
                                                                  isEqualTo:
                                                                      categoryName
                                                                          .text)
                                                              .get();

                                                      if (snap.docs.isEmpty) {
                                                        final shop =
                                                            productCategoryModel(
                                                                image:
                                                                    downloadUrl,
                                                                search: setSearchParam(
                                                                    categoryName
                                                                        .text),
                                                                date: DateTime
                                                                    .now(),
                                                                deleted: false,
                                                                name:
                                                                    categoryName
                                                                        .text);
                                                        AdminModels(shop);
                                                        Navigator.of(context)
                                                            .pop();
                                                        update = false;
                                                        add = false;

                                                        showSuccessToast(
                                                            context,
                                                            'Product Category added Successfully');
                                                        setState(() {});
                                                      } else {
                                                        showErrorToast(context,
                                                            'Category Already Exsist');
                                                      }
                                                    } else {
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'productCategory')
                                                          .doc(categoryId)
                                                          .update({
                                                        'image': downloadUrl,
                                                        'name':
                                                            categoryName.text,
                                                      });
                                                      update = false;
                                                      add = false;
                                                      Navigator.pop(context);
                                                      showSuccessToast(context,
                                                          'Product Category Updated Successfully');
                                                      setState(() {});
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
                                      style: TextStyle(
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
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    DataTable(
                      horizontalMargin: 10,
                      columnSpacing: 10,
                      headingRowColor: MaterialStateProperty.all(primaryColor),
                      columns: [
                        DataColumn(
                          label: Text(
                            "S.No ",
                            style: TextStyle(
                              fontSize: w * 0.010,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Date ",
                            style: TextStyle(
                              fontSize: w * 0.010,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Category Name",
                            style: TextStyle(
                              fontSize: w * 0.010,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Action",
                            style: TextStyle(
                              fontSize: w * 0.010,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Delete",
                            style: TextStyle(
                              fontSize: w * 0.010,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                      rows: List.generate(
                        planSearch.text == ''
                            ? categoryList.length
                            : searchList.length,
                        (index) {
                          productCategoryModel data = planSearch.text == ''
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
                                  DateFormat('dd-MM-yyyy').format(data.date),
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
                                  add = true;
                                  update = true;
                                  downloadUrl = data.image;

                                  categoryId = data.id!;
                                  categoryName.text = data.name;
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
                              DataCell(InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (buildcontext) {
                                          return AlertDialog(
                                            title: const Text(
                                                'Delete Product Category'),
                                            content: const Text(
                                                'Do you want to delete?'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  )),
                                              TextButton(
                                                  onPressed: () {
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            'productCategory')
                                                        .doc(data.id)
                                                        .update(
                                                            {'deleted': true});
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Delete',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  )),
                                            ],
                                          );
                                        });
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.black,
                                  ))),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

AdminModels(productCategoryModel adminUser) {
  FirebaseFirestore.instance
      .collection('productCategory')
      .add(adminUser.toJson())
      .then((value) {
    value.update({'id': value.id});
  });
}
