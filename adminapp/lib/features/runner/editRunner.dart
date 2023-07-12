import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../common/show_upload.dart';
import '../../model/runnerModel.dart';
import '../../splash_Screen.dart';
import '../authentication/login_page.dart';
import '../vendors/screens/vendor_list/addVendor.dart';

class EditRunner extends StatefulWidget {
  final RunnerModel data;
  const EditRunner({Key? key, required this.data}) : super(key: key);

  @override
  State<EditRunner> createState() => _EditRunnerState();
}

class _EditRunnerState extends State<EditRunner> {
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

  TextEditingController phone = TextEditingController();
  TextEditingController branchController = TextEditingController(text: "Kochi");
  String branchId = "";
  bool? passwordVisibility = false;
  bool? passwordVisibility2 = false;

  List uploadDocument = [];
  Map<String, dynamic> branchIdByName = {};
  Map<String, dynamic> branchNameById = {};
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
    //personal details
    nameController.text = widget.data.name.toString();
    phone.text = widget.data.mobileNumber.toString();
    emailController.text = widget.data.email.toString();
    passwordController.text = widget.data.password.toString();
    password2Controller.text = widget.data.password.toString();
    dataDoc = widget.data.documents!;
    // branchController.text = ;
    //bank details
    branch.text = widget.data.bankDetails!.branch.toString();
    holderName.text = widget.data.bankDetails!.name.toString();
    accountNumber.text = widget.data.bankDetails!.acctNo.toString();
    ifscCode.text = widget.data.bankDetails!.ifsc.toString();
    bank.text = widget.data.bankDetails!.bank.toString();
    // print(branchNameById[widget.data.branchId].toString());

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
      body: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
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
                              validator: (email) {
                                if (email!.isEmpty) {
                                } else if (!RegExp(
                                        r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
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
                                      () => passwordVisibility2 =
                                          !passwordVisibility2!,
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
                            padding: const EdgeInsets.only(left: 20, top: 10),
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
                              onChanged: (phone) {},
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
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
                                      () => passwordVisibility =
                                          !passwordVisibility!,
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
                      ],
                    ),
                  ],
                ),
                Text(
                  'Account details',
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
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
                      width: 20,
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
                      width: 20,
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
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
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
                      width: 20,
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
                      crossAxisCount: uploadDocument
                          .length, // Set the desired number of items in a row
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
                                selectFileToMessage(docName.toUpperCase());
                                setState(() {});
                              },
                              child: Container(
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: dataDoc.keys.toList().contains(
                                          docName.toString().toUpperCase())
                                      ? Color(0xffCB202D)
                                      : Color(0xff615F5F),
                                ),
                                child: Center(
                                  child: Text(
                                    dataDoc.keys.toList().contains(
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
                            trailing: dataDoc.keys
                                    .toList()
                                    .contains(docName.toString().toUpperCase())
                                ? InkWell(
                                    onTap: () {
                                      launchURL(
                                        dataDoc.values.toString().substring(
                                            1,
                                            dataDoc.values.toString().length -
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
                    setState(() {});
                    if (nameController.text.isEmpty) {
                      return showErrorToast(context, "please Enter Name");
                    } else if (phone.text.isEmpty || phone.text.length != 10) {
                      return showErrorToast(context, "Please Enter Phone");
                    } else if (emailController.text.isEmpty) {
                      return showErrorToast(context, "Please Enter  Email");
                    } else if (passwordController.text.isEmpty) {
                      return showErrorToast(context, "Please Enter Password");
                    } else if (password2Controller.text.isEmpty) {
                      return showErrorToast(
                          context, "Please Enter Confirm password");
                    } else if (password2Controller.text !=
                        passwordController.text) {
                      return showErrorToast(
                        context,
                        "Incorrect Password ",
                      );
                    } else {
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
                                      var show = widget.data.copyWith(
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
                                        branchId: "1000",
                                        documents: dataDoc,
                                        earnings: 0,
                                        guztyCash: 0,
                                        tips: 0,
                                        delete: false,
                                        verified: true,
                                        walletBalance: 0,
                                      );
                                      FirebaseFirestore.instance
                                          .collection('runner')
                                          .doc(widget.data.uid)
                                          .update(show.toJson());

                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      showSuccessToast(
                                        context,
                                        'Runner Updated Successfully',
                                      );
                                      setState(() {});
                                    },
                                    child: Text(
                                      'ok',
                                      style: TextStyle(color: primaryColor),
                                    ))
                              ],
                            );
                          });
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
                        'Update User',
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
