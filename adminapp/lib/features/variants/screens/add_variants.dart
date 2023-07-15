import 'package:adminapp/features/variants/controller/variants_controller.dart';
import 'package:adminapp/model/variant_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/show_upload.dart';
import '../../../splash_Screen.dart';

class AddVariants extends StatefulWidget {
  const AddVariants({Key? key}) : super(key: key);

  @override
  State<AddVariants> createState() => _AddVariantsState();
}

class _AddVariantsState extends State<AddVariants> {
  String variantId = '';
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: true,
        title: const Text(
          'Add Variants',
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
                        hintText: 'Enter Type of Variant',
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
                    var variant = id["variantId"].toString();
                    id.reference.update({"variantId": FieldValue.increment(1)});
                    var vId = 'GZVID$variant';
                    var variantData = VariantModel(
                        name: nameController.text,
                        deleted: false,
                        variantId: vId,
                        createdTime: DateTime.now(),
                        search: setSearchParam(nameController.text));
                    FirebaseFirestore.instance
                        .collection('variants')
                        .doc(vId)
                        .set(variantData.toJson());
                    nameController.clear();
                    setState(() {});
                  },
                  child: Text(
                    'Add Variants',
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
              'Added Variants',
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
          Consumer(builder: (contex, ref, child) {
            var data = ref.watch(getVariantsProvider);
            return data.when(
              data: (data) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Row(
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
                            child: Center(child: Text(data[index].name!))),
                      ],
                    );
                  },
                );
              },
              error: (error, stackTrace) {
                print(error);
                return Text(error.toString());
              },
              loading: () => const CircularProgressIndicator(),
            );
          })
        ],
      ),
    );
  }
}
