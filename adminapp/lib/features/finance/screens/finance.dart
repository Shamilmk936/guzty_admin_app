import 'dart:io';

import 'package:adminapp/common/show_upload.dart';
import 'package:adminapp/model/financial_model.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../splash_Screen.dart';

class Finance extends StatefulWidget {
  const Finance({
    super.key,
  });

  @override
  State<Finance> createState() => _FinanceState();
}

class _FinanceState extends State<Finance> {
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

  final amtController = TextEditingController();
  final vendorController = TextEditingController();
  Map<String, dynamic> idByName = {};
  double wallet = 0.0;

  getVendorDetails() async {
    QuerySnapshot sp = await FirebaseFirestore.instance
        .collection('vendors')
        .where('verified', isEqualTo: true)
        .get();
    if (sp.docs.isNotEmpty) {
      subProducts = [];

      for (var a in sp.docs) {
        subProducts.add(a['shopName']!);
        idByName[a['shopName']] = a.id;
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    getVendorDetails();
    // vendorController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: true,
        title: const Text(
          'Payout',
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
                  keyboardType: TextInputType.number,
                  controller: amtController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      labelText: 'Amount',
                      labelStyle: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Colors.black),
                      hintText: 'Enter Amount to be paid',
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: w * 0.85,
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
                controller: vendorController,
                onChanged: (text) {
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: h * 0.05,
        ),
        vendorController.text != ''
            ? StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('vendors')
                    .where('shopName', isEqualTo: vendorController.text)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var data = snapshot.data!.docs;
                  return InkWell(
                    onTap: () {
                      print(data[0]['wallet']);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: scrHeight * 0.055,
                          width: scrWidth * 0.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: primaryColor,
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 2,
                                    offset: Offset(2, 0))
                              ]),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                'Wallet Balance',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                '${double.tryParse(data[0]['wallet'].toString())}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          )),
                        ),
                      ],
                    ),
                  );
                },
              )
            : const SizedBox(),
        SizedBox(
          height: h * 0.05,
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
                  print(idByName[vendorController.text]);
                  DocumentSnapshot id = await FirebaseFirestore.instance
                      .collection('settings')
                      .doc('settings')
                      .get();
                  var productCategory = id["payout"].toString();
                  id.reference.update({"payout": FieldValue.increment(1)});
                  var pId = 'GZPAYID$productCategory';
                  var financeData = FinancialModel(
                      amount:
                          double.tryParse(amtController.text.toString()) ?? 0,
                      mbuid: idByName[vendorController.text].toString(),
                      narration: 'Payout',
                      date: DateTime.now(),
                      type: 0,
                      userId: currentUserId,
                      userName: currentUserName,
                      id: pId,
                      search: setSearchParam(pId));
                  FirebaseFirestore.instance
                      .collection('vendors')
                      .doc(idByName[vendorController.text].toString())
                      .collection('financial')
                      .doc(pId)
                      .set(financeData.toJson());
                  FirebaseFirestore.instance
                      .collection('vendors')
                      .doc(idByName[vendorController.text].toString())
                      .update({
                    'paid': FieldValue.increment(
                        double.tryParse(amtController.text.toString()) ?? 0),
                    'paidDate': FieldValue.serverTimestamp()
                  });
                  vendorController.clear();
                  amtController.clear();
                  // Navigator.pop(context);
                  const SnackBar(
                    content: Text('Successfully'),
                  );
                },
                child: Text(
                  'Add Payment',
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
}
