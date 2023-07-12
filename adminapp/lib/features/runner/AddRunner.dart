import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter/services.dart';

import '../../common/show_upload.dart';
import '../../model/runnerModel.dart';
import '../../splash_Screen.dart';
import '../authentication/login_page.dart';
import '../vendors/screens/vendor_list/addVendor.dart';

class AddRunner extends StatefulWidget {
  const AddRunner({Key? key}) : super(key: key);

  @override
  State<AddRunner> createState() => _AddRunnerState();
}

class _AddRunnerState extends State<AddRunner> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController holderName = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  TextEditingController ifscCode = TextEditingController();
  TextEditingController branch = TextEditingController();
  TextEditingController bank = TextEditingController();
  TextEditingController branchController = TextEditingController(text: "Kochi");

  TextEditingController phone = TextEditingController();
  bool? passwordVisibility = false;
  bool? passwordVisibility2 = false;
  String branchId = '';

  List uploadDocument = [];
  Map<String, dynamic> branchIdByName = {};
  List<String> branchList = ["Kochi"];

  getDocuments() {
    FirebaseFirestore.instance
        .collection('settings')
        .doc('settings')
        .snapshots()
        .listen((value) {
      uploadDocument = [];
      if (value.exists) {
        uploadDocument = value.get('ridersDocs');
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  List<String> assigned = [];
  String role = 'Admin';

  List<String> rolesList = [
    'superAdmin',
    'Admin',
  ];

  PlatformFile? pickFile;
  UploadTask? uploadTask;
  Map<String, dynamic> dataDoc = {};

  Future selectFileToMessage(String name) async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    pickFile = result.files.first;

    String ext = pickFile!.name.split('.').last;
    final fileBytes = result.files.first.bytes;

    showUploadMessage(context, 'Uploading...', showLoading: true);

    uploadFileToFireBase(name, fileBytes, ext);

    setState(() {});
  }

  Future uploadFileToFireBase(String name, fileBytes, String ext) async {
    uploadTask = FirebaseStorage.instance
        .ref('uploads/${DateTime.now().toString()}/$name.$ext')
        .putData(fileBytes);
    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownlod = await snapshot.ref.getDownloadURL();

    // List uploadDocument = [];
    //  uploadDocument.add(urlDownlod);

    dataDoc.addAll({
      name: urlDownlod,
    });
    print(dataDoc);

    showUploadMessage(
      context,
      '$name Uploaded Successfully...',
    );

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Center(
          child: Text(
            'ADD RUNNER',
            style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Column(
            children: [
              Container(
                height: scrHeight * 0.075,
                width: scrWidth * 0.85,
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
                        hintText: 'Enter Rider Name',
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
                width: scrWidth * 0.85,
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) {
                      if (email!.isEmpty) {
                      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                          .hasMatch(email)) {
                        return "Email is Invalid";
                      } else {
                        return null;
                      }
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none),
                        labelText: 'Email',
                        labelStyle: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Colors.black),
                        hintText: 'Enter Your Email',
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
                width: scrWidth * 0.85,
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
                    controller: password2Controller,
                    obscureText: !passwordVisibility2!,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none),
                        labelText: 'Confirm Password',
                        labelStyle: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Colors.black),
                        hintText: 'Confirm Your Password',
                        hintStyle: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                            color: Colors.black),
                        suffixIcon: InkWell(
                          onTap: () => setState(
                            () => passwordVisibility2 = !passwordVisibility2!,
                          ),
                          focusNode: FocusNode(skipTraversal: true),
                          child: Icon(
                            !passwordVisibility2!
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Color(0xFF757575),
                            size: 22,
                          ),
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: scrHeight * 0.075,
                width: scrWidth * 0.85,
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
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
// for version 2 and greater youcan also use this
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  controller: phone,
                  initialCountryCode: 'IN',
                  onChanged: (phone) {},
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
                width: scrWidth * 0.85,
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
                    obscureText: !passwordVisibility!,
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
                        suffixIcon: InkWell(
                          onTap: () => setState(
                            () => passwordVisibility = !passwordVisibility!,
                          ),
                          focusNode: FocusNode(skipTraversal: true),
                          child: Icon(
                            !passwordVisibility!
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Color(0xFF757575),
                            size: 22,
                          ),
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: scrHeight * 0.075,
                width: scrWidth * 0.85,
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
            ],
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
          //       initialOption: role,
          //       options: rolesList,
          //       onChanged: (val) =>
          //           setState(() {
          //             role = val;
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

          SizedBox(
            height: 20,
          ),
          Text(
            'Account details',
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              height: scrHeight * 0.075,
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
                  controller: holderName,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      labelText: 'Holder Name',
                      labelStyle: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Colors.black),
                      hintText: 'Acc Holder Name',
                      hintStyle: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                          color: Colors.black)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
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
                  controller: accountNumber,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                    labelText: 'Account No',
                    labelStyle: GoogleFonts.ubuntu(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: Colors.black),
                    hintText: 'Please enter Account No',
                    hintStyle: GoogleFonts.ubuntu(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
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
                  controller: ifscCode,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      labelText: 'IFSC code',
                      labelStyle: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Colors.black),
                      hintText: 'please enter IFSC code',
                      hintStyle: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                          color: Colors.black)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              height: scrHeight * 0.075,
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
                  controller: branch,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      labelText: 'Branch',
                      labelStyle: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Colors.black),
                      hintText: 'Branch Name',
                      hintStyle: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                          color: Colors.black)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
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
                  controller: bank,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                    labelText: 'Bank',
                    labelStyle: GoogleFonts.ubuntu(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: Colors.black),
                    hintText: 'Bank Name',
                    hintStyle: GoogleFonts.ubuntu(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: uploadDocument.length,
            itemBuilder: (context, index) {
              var docName = uploadDocument[index];
              return Container(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Text(
                      docName,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    title: InkWell(
                      onTap: () {
                        showUploadMessage(context, 'please upload ${docName}');
                        selectFileToMessage(docName.toUpperCase());
                        setState(() {});
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: dataDoc.keys
                                  .toList()
                                  .contains(docName.toString().toUpperCase())
                              ? Color(0xffCB202D)
                              : Color(0xff615F5F),
                        ),
                        child: Center(
                          child: Text(
                            dataDoc.keys
                                    .toList()
                                    .contains(docName.toString().toUpperCase())
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
                    trailing: dataDoc.keys
                            .toList()
                            .contains(docName.toString().toUpperCase())
                        ? InkWell(
                            onTap: () {
                              launchURL(
                                dataDoc.values.toString().substring(
                                    1, dataDoc.values.toString().length - 1),
                              );
                            },
                            child: Icon(Icons.download))
                        : SizedBox(),
                  ));
            },
          ),
          InkWell(
            onTap: () async {
              setState(() {});
              if (nameController.text.isEmpty) {
                return showErrorToast(context, 'Please enter Name');
              } else if (emailController.text.isEmpty) {
                return showErrorToast(context, 'Please enter email');
              } else if (passwordController.text.isEmpty) {
                return showErrorToast(context, 'Please enter password');
              } else if (password2Controller.text.isEmpty) {
                return showErrorToast(context, 'Please enter confirm password');
              } else if (password2Controller.text != passwordController.text) {
                return showErrorToast(context, 'Incorrect password');
              } else {
                QuerySnapshot snap = await FirebaseFirestore.instance
                    .collection('runner')
                    .where('email', isEqualTo: emailController.text)
                    .get();

                if (snap.docs.isEmpty) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Add  Runner?'),
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
                                onPressed: () async {
                                  var id;
                                  var iddata = await FirebaseFirestore.instance
                                      .collection('settings')
                                      .doc('settings')
                                      .get();

                                  id = iddata.get('runnerId');
                                  iddata.reference.update(
                                      {"runnerId": FieldValue.increment(1)});

                                  var data = RunnerModel(
                                    branchId: "1000",
                                    name: nameController.text,
                                    bankDetails: BankDetails(
                                        name: holderName.text,
                                        acctNo: accountNumber.text,
                                        bank: bank.text,
                                        branch: branch.text,
                                        ifsc: ifscCode.text),
                                    password: passwordController.text,
                                    mobileNumber: phone.text,
                                    email: emailController.text,
                                    createdTime: DateTime.now(),
                                    available: false,
                                    documents: dataDoc,
                                    earnings: 0,
                                    guztyCash: 0,
                                    tips: 0,
                                    status: 2,
                                    rejectedReason: "",
                                    delete: false,
                                    search: setSearchParam(nameController.text),
                                    verified: true,
                                    walletBalance: 0,
                                    uid: id.toString(),
                                  );
                                  FirebaseFirestore.instance
                                      .collection('runner')
                                      .doc(id.toString())
                                      .set(data.toJson());

                                  nameController.clear();
                                  emailController.clear();
                                  passwordController.clear();
                                  password2Controller.clear();
                                  dataDoc.clear();
                                  phone.clear();

                                  branch.clear();
                                  bank.clear();
                                  ifscCode.clear();
                                  accountNumber.clear();
                                  holderName.clear();
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  showSuccessToast(
                                      context, 'Rider added successfully');
                                  setState(() {});
                                },
                                child: Text(
                                  'ok',
                                  style: TextStyle(color: primaryColor),
                                ))
                          ],
                        );
                      });
                } else {
                  showErrorToast(context, 'User already exsist');
                }
              }
            },
            child: Container(
              height: scrHeight * 0.05,
              width: scrWidth * 0.1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: primaryColor),
              child: Center(
                child: Text(
                  'Add User',
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
    );
  }

  //
  //
  // AdminModels(AdminModel adminUser) {
  //   FirebaseFirestore.instance.collection('adminUser').add(
  //       adminUser.toJson()).then((value) {
  //     value.update({
  //       'id': value.id
  //     });
  //   });
  //
  // }
}
