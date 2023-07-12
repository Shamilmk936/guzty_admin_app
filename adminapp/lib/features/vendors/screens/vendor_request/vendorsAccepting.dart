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

import '../../../../common/flutter_flow_dropdown.dart';
import '../../../../common/show_upload.dart';
import '../../../../common/upload_media.dart';
import '../../../../model/vendorModel.dart';
import '../../../../splash_Screen.dart';
import '../../../authentication/login_page.dart';
import '../vendor_list/addVendor.dart';

class EditVendorRequest extends StatefulWidget {
  final VendorModel data;
  const EditVendorRequest({Key? key, required this.data}) : super(key: key);

  @override
  State<EditVendorRequest> createState() => _EditVendorRequestState();
}

class _EditVendorRequestState extends State<EditVendorRequest> {
  TextEditingController shopName = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController ownerName = TextEditingController();
  TextEditingController ownerEmail = TextEditingController();
  TextEditingController fssaiNumber = TextEditingController();
  TextEditingController commission = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController phone2 = TextEditingController();
  TextEditingController rejectReason = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController productCategory = TextEditingController();
  TextEditingController orderTypeController = TextEditingController();
  String downloadUrl = '';

  ScrollController scrollController = ScrollController();

  String categoryName = '';
  String branchId = '';
  Map<String, dynamic> productcategoryId = {};
  Map<String, dynamic> productcategoryNameById = {};
  Map<String, dynamic> branchIdByName = {};
  Map<String, dynamic> categoryIdByName = {};

  String phoneCode = '91';
  String countryCode = 'IN';
  String phoneCode2 = '91';
  String countryCode2 = 'IN';

  List selectedroles = [];
  List selectedrolesId = [];

  List<String> categoryList = [];
  List<String> productCategoryList = [];
  getCategory() {
    FirebaseFirestore.instance
        .collection('vendorCategory')
        .snapshots()
        .listen((event) {
      categoryList = [];
      for (var a in event.docs) {
        categoryList.add(a.get('name'));
        categoryIdByName[a.get('name')] = a.id;
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  List<String> branchList = [];
  getBranches() {
    FirebaseFirestore.instance.collection('branch').snapshots().listen((event) {
      branchList = [];
      for (var a in event.docs) {
        branchList.add(a.get('name'));
        branchIdByName[a.get('name')] = a.id;
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  List orderTypesList = [];
  List<String> orderListA = [];

  getOrdertypes() async {
    var data = await FirebaseFirestore.instance
        .collection('settings')
        .doc('settings')
        .get();

    orderTypesList = data.get('ordersType');
    print('orderTypesList');
    print(orderTypesList);
    orderListA = orderTypesList.map((element) => element.toString()).toList();
  }

  StreamSubscription? a;

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
        print(a);
        selectedroles.add(productcategoryNameById[a]);
        print(productcategoryNameById[a]);
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
    uploadTask = FirebaseStorage.instance
        .ref('uploads/${DateTime.now().toString()}-$name.$ext')
        .putData(fileBytes);
    final snapshot = await uploadTask?.whenComplete(() {});
    final urlDownlod = await snapshot?.ref.getDownloadURL();
    print(urlDownlod);
    print('******************');

    Documents.addAll({
      name: urlDownlod,
    });
    print(Documents.keys.toList().toString());
    print('        SUCCESS           ');

    showUploadMessage(context, '$name Uploaded Successfully...');
    setState(() {});
  }

  List uploadDocument = [];
  List orderType = [];

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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    getCategory();

    getDocuments();
    getProductCategories();
    getBranches();
    getOrdertypes();
    branchList.add('Select Branch');
    orderTypesList.add('select type');

    shopName = TextEditingController(text: widget.data.shopName);
    ownerName = TextEditingController(text: widget.data.ownerName);
    ownerEmail = TextEditingController(text: widget.data.ownerEmail);
    fssaiNumber = TextEditingController(text: widget.data.fssaiNumber);
    commission = TextEditingController(text: widget.data.commission.toString());
    passwordController = TextEditingController(text: widget.data.password);
    city = TextEditingController(text: widget.data.city);
    phone = TextEditingController(text: widget.data.contactNumber);
    phone2 = TextEditingController(text: widget.data.contactNumber2);
    categoryName = widget.data.categoryName!;
    description = TextEditingController(text: widget.data.description ?? "");
    orderType =
        widget.data.ordersType!.map((element) => element.toString()).toList();
    branchController = TextEditingController(text: widget.data.branch);
    downloadUrl = widget.data.image == null ? "" : widget.data.image.toString();
    Documents = widget.data.document!;

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
        body: productcategoryNameById.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
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
                                          final selectedMedia =
                                              await selectMedia(
                                            mediaSource:
                                                MediaSource.photoGallery,
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
                                            final uploadSnap =
                                                await FirebaseStorage
                                                    .instance
                                                    .ref()
                                                    .child(
                                                        DateTime.now()
                                                            .toLocal()
                                                            .toString()
                                                            .substring(0, 10))
                                                    .child(
                                                        DateTime.now()
                                                            .toLocal()
                                                            .toString()
                                                            .substring(10, 17))
                                                    .putData(
                                                        selectedMedia.bytes,
                                                        metadata);
                                            downloadUrl = await uploadSnap.ref
                                                .getDownloadURL();
                                            ScaffoldMessenger.of(context)
                                                .hideCurrentSnackBar();
                                            if (downloadUrl != '' &&
                                                downloadUrl != null) {
                                              setState(() {});
                                              print(downloadUrl.toString() +
                                                  "   mnmnmnmnmn");
                                              showUploadMessage(
                                                  context, 'Success!');
                                            } else {
                                              showUploadMessage(context,
                                                  'Failed to upload media');
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
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 10),
                                    child: TextFormField(
                                      controller: shopName,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
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
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 10),
                                    child: TextFormField(
                                      controller: description,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide.none),
                                          labelText: 'Description',
                                          labelStyle: GoogleFonts.ubuntu(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                              color: Colors.black),
                                          hintText: 'Enter your Description',
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
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 10),
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      controller: ownerEmail,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 10),
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
                                      },
                                      onCountryChanged: (country) {
                                        phoneCode = country.dialCode;
                                        countryCode = country.code;
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          labelText: 'Enter phone'),
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
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 10),
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      controller: fssaiNumber,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
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
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 10),
                                    child: TextFormField(
                                      autofillHints: [AutofillHints.password],
                                      controller: passwordController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
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
                                    items: orderListA,
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
                                        behavior:
                                            ScrollConfiguration.of(context)
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
                                                      orderType.remove(
                                                          orderType[index]);
                                                      setState(() {});
                                                    },
                                                    child: const Icon(
                                                        Icons.close,
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
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 10),
                                    child: TextFormField(
                                      controller: ownerName,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
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
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 10),
                                    child: TextFormField(
                                      controller: city,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 10),
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
                                      onChanged: (phone) {
                                        // phoneCode = phone.countryCode;
                                        // countryCode = phone.countryISOCode;
                                      },
                                      onCountryChanged: (country) {
                                        phoneCode2 = country.dialCode;
                                        countryCode2 = country.code;
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          labelText: 'Enter phone'),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: scrWidth * 0.35,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 2,
                                          offset: Offset(2, 0))
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 4, 0, 0),
                                    child: FlutterFlowDropDown(
                                      initialOption: categoryName,
                                      options: categoryList,
                                      onChanged: (val) => setState(() {
                                        categoryName = val;
                                      }),
                                      width: 180,
                                      height: 50,
                                      textStyle: const TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                      ),
                                      hintText: 'Please select',
                                      fillColor: Colors.white,
                                      elevation: 0,
                                      borderColor: Colors.transparent,
                                      borderWidth: 0,
                                      borderRadius: 8,
                                      margin:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              12, 4, 12, 4),
                                      hidesUnderline: true,
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
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 10),
                                    child: TextFormField(
                                      controller: commission,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
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
                                    hintText: 'Select Branch',
                                    hintStyle: TextStyle(color: Colors.black),
                                    items: branchList,
                                    controller: branchController,
                                    // excludeSelected: false,
                                    onChanged: (text) async {
                                      branchId = branchIdByName[text];

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
                                        showErrorToast(
                                            context, 'Already contains');
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
                                        behavior:
                                            ScrollConfiguration.of(context)
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
                                              return SizedBox(
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
                                                      selectedroles.remove(
                                                          selectedroles[index]);
                                                      setState(() {});
                                                    },
                                                    child: const Icon(
                                                        Icons.close,
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
                        Container(
                          color: Colors.white,
                          width: scrWidth * 0.6,
                          height: scrWidth * 0.1,
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),

                            itemCount: uploadDocument
                                .length, // Replace with your desired item count
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    title: InkWell(
                                      onTap: () {
                                        showUploadMessage(context,
                                            'please upload ${docName}');
                                        selectFile(docName.toUpperCase());
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Documents.keys
                                                  .toList()
                                                  .contains(docName
                                                      .toString()
                                                      .toUpperCase())
                                              ? Color(0xffCB202D)
                                              : Color(0xff615F5F),
                                        ),
                                        child: Center(
                                          child: Text(
                                            Documents.keys.toList().contains(
                                                    docName
                                                        .toString()
                                                        .toUpperCase())
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
                                    trailing: Documents.keys.toList().contains(
                                            docName.toString().toUpperCase())
                                        ? InkWell(
                                            onTap: () {
                                              launchURL(
                                                Documents.values
                                                    .toString()
                                                    .substring(
                                                        1,
                                                        Documents.values
                                                                .toString()
                                                                .length -
                                                            1),
                                              );
                                            },
                                            child: Icon(Icons.download))
                                        : SizedBox(),
                                  ));
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Reject Vendor?'),
                                        content:
                                            Text('Do you want to continue?'),
                                        actions: [
                                          Column(
                                            children: [
                                              Container(
                                                height: scrHeight * 0.065,
                                                width: scrWidth * 0.35,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.black,
                                                          blurRadius: 2,
                                                          offset: Offset(2, 0))
                                                    ]),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20, top: 10),
                                                  child: TextFormField(
                                                    controller: rejectReason,
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                borderSide:
                                                                    BorderSide
                                                                        .none),
                                                        labelText:
                                                            'Enter the Reject Reason',
                                                        labelStyle:
                                                            GoogleFonts.ubuntu(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 13,
                                                                color:
                                                                    Colors
                                                                        .black),
                                                        hintText:
                                                            'Reject Reason',
                                                        hintStyle:
                                                            GoogleFonts.ubuntu(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black)),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text(
                                                        'Cancel',
                                                        style: TextStyle(
                                                            color:
                                                                primaryColor),
                                                      )),
                                                  TextButton(
                                                      onPressed: () {
                                                        if (rejectReason.text !=
                                                            '') {
                                                          final shop = widget
                                                              .data
                                                              .copyWith(
                                                            rejected: true,
                                                            rejectReason:
                                                                rejectReason
                                                                    .text,
                                                          );
                                                          VendorModels(shop);

                                                          showErrorToast(
                                                              context,
                                                              "Vendor Rejected");
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.pop(
                                                              context);

                                                          setState(() {});
                                                        } else {
                                                          showSnackbar(context,
                                                              'please enter the reject reason');
                                                        }
                                                      },
                                                      child: Text(
                                                        'ok',
                                                        style: TextStyle(
                                                            color:
                                                                primaryColor),
                                                      ))
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    });
                              },
                              child: Container(
                                height: scrHeight * 0.05,
                                width: scrWidth * 0.1,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: primaryColor),
                                child: Center(
                                  child: Text(
                                    'Reject Vendor',
                                    style: GoogleFonts.ubuntu(
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
                                if (Documents.keys.length != 0 &&
                                    branchController.text != '' &&
                                    orderType.isNotEmpty &&
                                    selectedroles.isNotEmpty &&
                                    shopName.text != '' &&
                                    ownerName.text != '' &&
                                    ownerEmail.text.contains('@gmail.com') &&
                                    phone.text.length == 10 &&
                                    phone2.text.length == 10 &&
                                    city.text != '' &&
                                    fssaiNumber.text != '' &&
                                    categoryName != '' &&
                                    passwordController.text != '' &&
                                    double.tryParse(commission.text) != null &&
                                    Documents != {}) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Add Vendor Users?'),
                                          content:
                                              Text('Do you want to continue?'),
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
                                                onPressed: () {
                                                  List idList = [];
                                                  List<String> prdtId = [];
                                                  for (var a in selectedroles) {
                                                    idList.add(
                                                        productcategoryId[a]);
                                                  }

                                                  prdtId = idList
                                                      .map((element) =>
                                                          element.toString())
                                                      .toList();

                                                  final shop =
                                                      widget.data.copyWith(
                                                    shopName: shopName.text
                                                        .toUpperCase(),
                                                    city: city.text,
                                                    productCategories: prdtId,
                                                    branch:
                                                        branchController.text,
                                                    fssaiNumber:
                                                        fssaiNumber.text,
                                                    categoryId:
                                                        categoryIdByName[
                                                            categoryName],
                                                    categoryName: categoryName,
                                                    ownerName: ownerName.text,
                                                    contactNumber: phone.text,
                                                    contactNumber2: phone2.text,
                                                    ownerEmail: ownerEmail.text,
                                                    password:
                                                        passwordController.text,
                                                    commission: double.tryParse(
                                                        commission.text),
                                                    document: Documents,
                                                    createdTime: DateTime.now(),
                                                    deleted: false,
                                                    verified: true,
                                                    rejected: false,
                                                    available: false,
                                                    position: null,
                                                    lat: 0,
                                                    long: 0,
                                                    branchId: branchId,
                                                  );

                                                  VendorModels(shop);
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                  showSuccessToast(context,
                                                      "Vendor Added Successfully");

                                                  setState(() {});
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
                                  shopName.text == ''
                                      ? showErrorToast(
                                          context, 'please enter Shop Name')
                                      : branchController.text == ''
                                          ? showErrorToast(context,
                                              'please enter Branch Name')
                                          : orderType.isEmpty
                                              ? showErrorToast(context,
                                                  'please choose order Type')
                                              : selectedroles.isEmpty
                                                  ? showErrorToast(context,
                                                      'please choose Product Categories')
                                                  : ownerName.text == ''
                                                      ? showErrorToast(context,
                                                          'please enter Owner Name')
                                                      : city.text == ''
                                                          ? showErrorToast(
                                                              context,
                                                              'please enter Shop Location')
                                                          : phone.text.length !=
                                                                  10
                                                              ? showErrorToast(
                                                                  context,
                                                                  'please enter Shop Contact')
                                                              : phone2.text.length !=
                                                                      10
                                                                  ? showErrorToast(
                                                                      context,
                                                                      'please enter Shop Second Contact')
                                                                  : fssaiNumber.text ==
                                                                          ''
                                                                      ? showErrorToast(
                                                                          context,
                                                                          'please enter Shop fssai number')
                                                                      : categoryName ==
                                                                              ''
                                                                          ? showErrorToast(
                                                                              context,
                                                                              'please Choose shop Category')
                                                                          : double.tryParse(commission.text) == null
                                                                              ? showErrorToast(context, 'please enter Commission Percentage')
                                                                              : passwordController.text == ''
                                                                                  ? showErrorToast(context, 'please enter password')
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
                                    'Add Vendor',
                                    style: GoogleFonts.ubuntu(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ));
  }

  VendorModels(VendorModel vendor) {
    FirebaseFirestore.instance
        .collection('vendors')
        .doc(vendor.id)
        .update(vendor.toJson());
  }
}
