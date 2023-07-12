import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common/show_upload.dart';
import '../../../../common/upload_media.dart';
import '../../../../model/vendorModel.dart';
import '../../../../splash_Screen.dart';
import '../../../authentication/login_page.dart';
import 'addVendor.dart';

class EditVendor extends StatefulWidget {
  final VendorModel data;
  const EditVendor({Key? key, required this.data}) : super(key: key);

  @override
  State<EditVendor> createState() => _EditVendorState();
}

class _EditVendorState extends State<EditVendor> {
  TextEditingController shopName = TextEditingController();
  TextEditingController ownerName = TextEditingController();
  TextEditingController ownerEmail = TextEditingController();
  TextEditingController fssaiNumber = TextEditingController();
  TextEditingController commission = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController phone2 = TextEditingController();
  TextEditingController description = TextEditingController();

  TextEditingController productCategory = TextEditingController();
  TextEditingController orderTypeController = TextEditingController();
  TextEditingController vendorCategory = TextEditingController();

  String downloadUrl = '';
  Map<String, dynamic> categoryId = {};

  Map<String, dynamic> branchIdByName = {};
  List selectedroles = [];
  List<String> productCategoryList = [];
  Map<String, dynamic> productcategoryId = {};
  Map<String, dynamic> productcategoryNameById = {};
  ScrollController scrollController = ScrollController();
  List orderType = [];
  List orderTypesList = [];
  List<String> orderListA = [];
  String phoneCode = '91';
  String phoneCode2 = '91';
  String countryCode = 'IN';
  String countryCode2 = 'IN';

  StreamSubscription? a;

  List<String> categoryList = [];
  getCategory() {
    FirebaseFirestore.instance
        .collection('vendorCategory')
        .snapshots()
        .listen((event) {
      categoryList = [];
      for (var a in event.docs) {
        categoryList.add(a.get('name'));
        categoryId[a.get('name')] = a.id;
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  getOrdertypes() async {
    var data = await FirebaseFirestore.instance
        .collection('settings')
        .doc('settings')
        .get();

    orderTypesList = data.get('ordersType');

    orderListA = orderTypesList.map((element) => element.toString()).toList();
  }

  getProductCategories() {
    a = FirebaseFirestore.instance
        .collection('productCategory')
        .snapshots()
        .listen((event) {
      productCategoryList = [];
      for (var a in event.docs) {
        productCategoryList.add(a.get('name'));
        productcategoryId[a.get('name')] = a.id;
        productcategoryNameById[a.id] = a['name'];
      }
      selectedroles = [];
      for (var a in widget.data.productCategories!) {
        selectedroles.add(productcategoryNameById[a]);
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  File? file;
  dynamic url;
  String? ext;
  String? size;
  String? fileName;
  var bytes;
  PlatformFile? pickedFile;

  Future selectFile(String name) async {
    final result = await FilePicker.platform.pickFiles(withData: true);
    if (result == null) return;

    pickedFile = result.files.first;

    String ext = pickedFile!.name.split('.').last;
    final fileBytes = result.files.first.bytes;

    showUploadMessage(context, 'Uploading...', showLoading: true);

    uploadFileToFireBase(name, fileBytes, ext);

    setState(() {});
  }

  UploadTask? uploadTask;
  Map<String, dynamic> Documents = {};
  Future uploadFileToFireBase(String name, fileBytes, String ext) async {
    print(name);
    print('ext : ' + ext);

    uploadTask = FirebaseStorage.instance
        .ref('uploads/${DateTime.now().toString()}/$name.$ext')
        .putData(fileBytes);
    final snapshot = await uploadTask?.whenComplete(() {});
    final urlDownlod = await snapshot?.ref.getDownloadURL();
    print(urlDownlod);
    print('******************');

    Documents.addAll({
      name: urlDownlod,
    });

    print('        SUCCESS           ');

    showUploadMessage(context, '$name Uploaded Successfully...');
    setState(() {});
  }

  List uploadDocument = [];

  getDocuments() {
    FirebaseFirestore.instance
        .collection('settings')
        .doc('settings')
        .snapshots()
        .listen((value) {
      uploadDocument = [];
      if (value.exists) {
        uploadDocument = value.get('documentRequired');
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    getCategory();
    getDocuments();

    getOrdertypes();
    getProductCategories();
    orderTypesList.add('select Branch');

    orderType.add('select batch');
    orderListA.add('select value');

    shopName = TextEditingController(text: widget.data.shopName);
    ownerName = TextEditingController(text: widget.data.ownerName);
    ownerEmail = TextEditingController(text: widget.data.ownerEmail);
    fssaiNumber = TextEditingController(text: widget.data.fssaiNumber);
    commission = TextEditingController(text: widget.data.commission.toString());
    passwordController = TextEditingController(text: widget.data.password);
    city = TextEditingController(text: widget.data.city);
    phone = TextEditingController(text: widget.data.contactNumber);
    phone2 = TextEditingController(text: widget.data.contactNumber2);
    orderType =
        widget.data.ordersType!.map((element) => element.toString()).toList();
    vendorCategory.text = widget.data.categoryName!;

    Documents = widget.data.document!;
    description = TextEditingController(text: widget.data.description ?? "");
    downloadUrl = widget.data.image == null ? "" : widget.data.image.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Center(
          child: Text(
            'EDIT VENDOR',
            style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: scrWidth * 0.1,
                          height: scrWidth * 0.1,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  final selectedMedia = await selectMedia(
                                    mediaSource: MediaSource.photoGallery,
                                  );
                                  if (selectedMedia != null &&
                                      validateFileFormat(
                                          selectedMedia.storagePath, context)) {
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
                                        .putData(selectedMedia.bytes, metadata);
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
                                                child:
                                                    Image.network(downloadUrl),
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
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: scrHeight * 0.075,
                          width: scrWidth * 0.35,
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
                              controller: shopName,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none),
                                  labelText: 'Shop Name',
                                  labelStyle: GoogleFonts.ubuntu(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: Colors.black),
                                  hintText: 'Enter Your Shop Name',
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
                        Container(
                          height: scrHeight * 0.075,
                          width: scrWidth * 0.35,
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
                              controller: description,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none),
                                  labelText: 'Enter Description',
                                  labelStyle: GoogleFonts.ubuntu(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: Colors.black),
                                  hintText: 'Enter Your  Description',
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
                        Container(
                          height: scrHeight * 0.075,
                          width: scrWidth * 0.35,
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: ownerEmail,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none),
                                  labelText: 'Owner Email',
                                  labelStyle: GoogleFonts.ubuntu(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: Colors.black),
                                  hintText: 'Enter Owner Email',
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
                        Container(
                          height: scrHeight * 0.075,
                          width: scrWidth * 0.35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 2,
                                    offset: Offset(2, 0))
                              ]),
                          child: IntlPhoneField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              // for below version 2 use this
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
// for version 2 and greater youcan also use this
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: phone,
                            initialCountryCode: 'IN',
                            onChanged: (phone) {
                              // phoneCode = phone.countryCode;
                              // countryCode = phone.countryISOCode;
                              print('phoneCode');
                            },
                            onCountryChanged: (country) {
                              phoneCode = country.dialCode;
                              countryCode = country.code;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: 'Enter phone'),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: scrHeight * 0.075,
                          width: scrWidth * 0.35,
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: fssaiNumber,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none),
                                  labelText: 'fssai Number',
                                  labelStyle: GoogleFonts.ubuntu(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: Colors.black),
                                  hintText: 'Enter Your fssai Number',
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
                        Container(
                          height: scrHeight * 0.075,
                          width: scrWidth * 0.35,
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
                              autofillHints: [AutofillHints.password],
                              controller: passwordController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none),
                                labelText: 'Password',
                                labelStyle: GoogleFonts.ubuntu(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: Colors.black),
                                hintText: 'Enter Your Password',
                                hintStyle: GoogleFonts.ubuntu(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: scrHeight * 0.075,
                          width: scrWidth * 0.35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 2,
                                    offset: Offset(2, 0))
                              ]),
                          child: CustomDropdown.search(
                            borderRadius: BorderRadius.circular(8),
                            fieldSuffixIcon: Icon(
                              Icons.arrow_drop_down,
                              size: scrWidth * 0.020,
                            ),
                            hintText: 'Select Order Type',
                            hintStyle: TextStyle(color: Colors.black),
                            items: orderListA.isEmpty ? [''] : orderListA,
                            controller: orderTypeController,
                            // excludeSelected: false,
                            onChanged: (text) async {
                              if (orderType
                                  .contains(orderTypeController.text)) {
                                showErrorToast(
                                    context, ' Item Already selected');
                              } else {
                                orderType.add(orderTypeController.text);
                              }

                              // await getContracts();
                              setState(() {});
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: scrWidth * 0.06,
                            width: scrWidth * 0.3,
                            child: Scrollbar(
                              interactive: true,
                              controller: scrollController,
                              child: ScrollConfiguration(
                                behavior: ScrollConfiguration.of(context)
                                    .copyWith(dragDevices: {
                                  PointerDeviceKind.touch,
                                  PointerDeviceKind.mouse
                                }),
                                child: SingleChildScrollView(
                                  controller: scrollController,
                                  scrollDirection: Axis.horizontal,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: orderType.length,
                                    itemBuilder: (context, index) {
                                      return SizedBox(
                                        height: scrWidth * 0.04,
                                        width: scrWidth * 0.1,
                                        child: ListTile(
                                          title: Text(
                                            orderType[index],
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                          trailing: InkWell(
                                            onTap: () {
                                              orderType
                                                  .remove(orderType[index]);
                                              setState(() {});
                                            },
                                            child: const Icon(Icons.close,
                                                color: Colors.red),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Edit Vendor Users?'),
                                    content: Text('Do you want to continue?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Cancel',
                                            style:
                                                TextStyle(color: primaryColor),
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            if (widget.data.available ==
                                                false) {
                                              FirebaseFirestore.instance
                                                  .collection('vendors')
                                                  .doc(widget.data.id)
                                                  .update({
                                                "available": true,
                                              });
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                              showSuccessToast(
                                                  context, 'Vendor Enabled');
                                              setState(() {});
                                            } else {
                                              FirebaseFirestore.instance
                                                  .collection('vendors')
                                                  .doc(widget.data.id)
                                                  .update({
                                                "available": false,
                                              });
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                              showSuccessToast(
                                                  context, 'Vendor Disabled');
                                              setState(() {});
                                            }
                                          },
                                          child: Text(
                                            'Ok',
                                            style:
                                                TextStyle(color: primaryColor),
                                          )),
                                    ],
                                  );
                                });
                          },
                          child: Container(
                            height: 60,
                            width: 100,
                            child: Center(
                                child: Text(
                              widget.data.available == true
                                  ? 'Disable Vendor'
                                  : 'Enable Vendor',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: widget.data.available == true
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        Container(
                          height: scrHeight * 0.075,
                          width: scrWidth * 0.35,
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
                              controller: ownerName,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none),
                                  labelText: 'Owner Name',
                                  labelStyle: GoogleFonts.ubuntu(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: Colors.black),
                                  hintText: 'Enter the Owner Name',
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
                        Container(
                          height: scrHeight * 0.075,
                          width: scrWidth * 0.35,
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
                              controller: city,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none),
                                  labelText: 'City',
                                  labelStyle: GoogleFonts.ubuntu(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: Colors.black),
                                  hintText: 'Enter the City',
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
                        Container(
                          height: scrHeight * 0.075,
                          width: scrWidth * 0.35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 2,
                                    offset: Offset(2, 0))
                              ]),
                          child: IntlPhoneField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              // for below version 2 use this
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
// for version 2 and greater youcan also use this
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: phone2,
                            initialCountryCode: 'IN',
                            onChanged: (phone) {},
                            onCountryChanged: (country) {
                              phoneCode2 = country.dialCode;
                              countryCode2 = country.code;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: 'Enter phone'),
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        // Container(
                        //   width: scrWidth*0.35,
                        //   height: 60,
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     boxShadow: [
                        //       BoxShadow(
                        //           color: Colors.black ,
                        //           blurRadius: 2,
                        //           offset: Offset(2, 0)
                        //       )
                        //     ],
                        //     borderRadius:
                        //     BorderRadius.circular(8),
                        //   ),
                        //   child: Padding(
                        //     padding:
                        //     const EdgeInsetsDirectional
                        //         .fromSTEB(0, 4, 0, 0),
                        //     child: FlutterFlowDropDown(
                        //       initialOption: categoryName,
                        //       options: categoryList,
                        //       onChanged: (val) =>
                        //           setState(() {
                        //             categoryName = val;
                        //           }),
                        //       width: 180,
                        //       height: 50,
                        //       textStyle: const TextStyle(
                        //         fontFamily: 'Poppins',
                        //         color: Colors.black,
                        //       ),
                        //       hintText: 'Please select...',
                        //       fillColor: Colors.white,
                        //       elevation: 0,
                        //       borderColor:
                        //       Colors.transparent,
                        //       borderWidth: 0,
                        //       borderRadius: 8,
                        //       margin:
                        //       const EdgeInsetsDirectional
                        //           .fromSTEB(
                        //           12, 4, 12, 4),
                        //       hidesUnderline: true,
                        //     ),
                        //   ),
                        // ),
                        //

                        Container(
                          height: scrHeight * 0.075,
                          width: scrWidth * 0.35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 2,
                                    offset: Offset(2, 0))
                              ]),
                          child: CustomDropdown.search(
                            borderRadius: BorderRadius.circular(8),
                            fieldSuffixIcon: Icon(
                              Icons.arrow_drop_down,
                              size: scrWidth * 0.020,
                            ),
                            hintText: 'Select vendor Category',
                            hintStyle: TextStyle(color: Colors.black),
                            items: categoryList.isEmpty ? [''] : categoryList,
                            controller: vendorCategory,
                            // excludeSelected: false,
                            onChanged: (text) async {
                              // await getContracts();
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: scrHeight * 0.075,
                          width: scrWidth * 0.35,
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
                              controller: commission,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none),
                                labelText: 'Commission Percentage',
                                labelStyle: GoogleFonts.ubuntu(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: Colors.black),
                                hintText: 'Enter Commission Percentage',
                                hintStyle: GoogleFonts.ubuntu(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: scrHeight * 0.075,
                          width: scrWidth * 0.35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 2,
                                    offset: Offset(2, 0))
                              ]),
                          child: CustomDropdown.search(
                            borderRadius: BorderRadius.circular(8),
                            fieldSuffixIcon: Icon(
                              Icons.arrow_drop_down,
                              size: scrWidth * 0.020,
                            ),
                            hintText: 'Select Product Category',
                            hintStyle: TextStyle(color: Colors.black),
                            items: productCategoryList.isEmpty
                                ? ['']
                                : productCategoryList,
                            controller: productCategory,
                            // excludeSelected: false,
                            onChanged: (text) async {
                              if (selectedroles
                                  .contains(productCategory.text)) {
                                showErrorToast(context, 'Already contains');
                              } else {
                                selectedroles.add(productCategory.text);
                              }

                              // await getContracts();
                              setState(() {});
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: scrWidth * 0.06,
                            width: scrWidth * 0.3,
                            child: Scrollbar(
                              interactive: true,
                              controller: scrollController,
                              child: ScrollConfiguration(
                                behavior: ScrollConfiguration.of(context)
                                    .copyWith(dragDevices: {
                                  PointerDeviceKind.touch,
                                  PointerDeviceKind.mouse
                                }),
                                child: SingleChildScrollView(
                                  controller: scrollController,
                                  scrollDirection: Axis.horizontal,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: selectedroles.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: scrWidth * 0.04,
                                        width: scrWidth * 0.1,
                                        child: ListTile(
                                          title: Text(
                                            selectedroles[index],
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                          trailing: InkWell(
                                            onTap: () {
                                              selectedroles
                                                  .remove(selectedroles[index]);
                                              setState(() {});
                                            },
                                            child: const Icon(Icons.close,
                                                color: Colors.red),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.white,
                  width: scrWidth * 0.6,
                  height: scrWidth * 0.1,
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: uploadDocument
                        .length, // Replace with your desired item count
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          3, // Set the desired number of items in a row
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      var docName = uploadDocument[index];
                      return Container(
                          margin: EdgeInsets.all(10),
                          child: ListTile(
                            leading: Text(
                              docName,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            title: InkWell(
                              onTap: () {
                                showUploadMessage(
                                    context, 'please upload ${docName}');
                                selectFile(docName.toUpperCase());
                                setState(() {});
                              },
                              child: Container(
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Documents.keys.toList().contains(
                                          docName.toString().toUpperCase())
                                      ? Color(0xffCB202D)
                                      : Color(0xff615F5F),
                                ),
                                child: Center(
                                  child: Text(
                                    Documents.keys.toList().contains(
                                            docName.toString().toUpperCase())
                                        ? 'Edit'
                                        : 'Upload',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            trailing: Documents.keys
                                    .toList()
                                    .contains(docName.toString().toUpperCase())
                                ? InkWell(
                                    onTap: () {
                                      launchURL(
                                        Documents.values.toString().substring(
                                            1,
                                            Documents.values.toString().length -
                                                1),
                                      );
                                    },
                                    child: Icon(Icons.download))
                                : SizedBox(),
                          ));
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (Documents.keys.length != 0 &&
                        orderType.isNotEmpty &&
                        selectedroles.isNotEmpty &&
                        shopName.text != '' &&
                        ownerName.text != '' &&
                        ownerEmail.text.contains('@gmail.com') &&
                        phone.text != '' &&
                        city.text != '' &&
                        fssaiNumber.text != '' &&
                        vendorCategory.text != '' &&
                        passwordController.text != '' &&
                        double.tryParse(commission.text) != null) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Edit Vendor Users?'),
                              content: Text('Do you want to continue?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(color: primaryColor),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      List idList = [];
                                      List<String> prdtId = [];
                                      for (var a in selectedroles) {
                                        idList.add(productcategoryId[a]);
                                      }

                                      prdtId = idList
                                          .map((element) => element.toString())
                                          .toList();

                                      final shop = widget.data.copyWith(
                                        image: downloadUrl,
                                        description: description.text,
                                        productCategories: prdtId,
                                        branch: "Kochi",
                                        branchId: "1000",
                                        ordersType: orderType,
                                        countryCode: phoneCode,
                                        countryCode2: phoneCode2,
                                        countryShortName: countryCode,
                                        countryShortName2: countryCode2,
                                        shopName: shopName.text.toUpperCase(),
                                        city: city.text,
                                        fssaiNumber: fssaiNumber.text,
                                        categoryId:
                                            categoryId[vendorCategory.text],
                                        categoryName: vendorCategory.text,
                                        ownerName: ownerName.text,
                                        contactNumber: phone.text,
                                        contactNumber2: phone2.text,
                                        ownerEmail: ownerEmail.text,
                                        password: passwordController.text,
                                        commission:
                                            double.tryParse(commission.text),
                                        document: Documents,
                                      );
                                      VendorModels(shop);
                                      setState(() {});
                                      showSuccessToast(context,
                                          "Vendor Edited Successfully");
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'ok',
                                      style: TextStyle(color: primaryColor),
                                    ))
                              ],
                            );
                          });
                    } else {
                      shopName.text == ''
                          ? showErrorToast(context, 'please enter Shop Name')
                          : ownerName.text == ''
                              ? showErrorToast(
                                  context, 'please enter Owner Name')
                              : downloadUrl == ''
                                  ? showErrorToast(
                                      context, 'please Upload Image')
                                  : city.text == ''
                                      ? showErrorToast(
                                          context, 'please enter Shop Location')
                                      : description.text == ''
                                          ? showErrorToast(context,
                                              'please enter Description')
                                          : phone.text.length != 10
                                              ? showErrorToast(context,
                                                  'please enter Shop Contact')
                                              : phone2.text.length != 10
                                                  ? showErrorToast(context,
                                                      'please enter Shop Second Contact')
                                                  : fssaiNumber.text == ''
                                                      ? showErrorToast(context,
                                                          'please enter Shop fssai number')
                                                      : vendorCategory.text ==
                                                              ''
                                                          ? showErrorToast(
                                                              context,
                                                              'please Choose shop Category')
                                                          : selectedroles
                                                                  .isEmpty
                                                              ? showErrorToast(
                                                                  context,
                                                                  'please choose Product Categories')
                                                              : orderType
                                                                      .isEmpty
                                                                  ? showErrorToast(
                                                                      context,
                                                                      'please choose Order Type')
                                                                  : double.tryParse(commission
                                                                              .text) ==
                                                                          null
                                                                      ? showErrorToast(
                                                                          context,
                                                                          'please enter Commission Percentage')
                                                                      : passwordController.text ==
                                                                              ''
                                                                          ? showErrorToast(
                                                                              context,
                                                                              'please enter password')
                                                                          : Documents.keys.length == 0
                                                                              ? showErrorToast(context, 'please enter the Documents')
                                                                              : showErrorToast(context, 'Email is badly formatted');
                    }
                  },
                  child: Container(
                    height: scrHeight * 0.05,
                    width: scrWidth * 0.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primaryColor),
                    child: Center(
                      child: Text(
                        'Edit Vendor',
                        style: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  VendorModels(VendorModel vendor) {
    FirebaseFirestore.instance
        .collection('vendors')
        .doc(vendor.id)
        .update(vendor.toJson());
  }
}
