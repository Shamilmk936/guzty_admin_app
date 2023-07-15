import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
// import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/show_upload.dart';
import '../../../model/store_category.dart';
import '../../../splash_Screen.dart';
import '../controller/store_controller.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final nameController = TextEditingController();
  bool kit = false;
  bool available = false;
  bool update = false;
  String categoryId = "";
  Icon? _icon;
  var icons;
  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [
          IconPack.cupertino,
          IconPack.material,
          IconPack.fontAwesomeIcons
        ]);

    if (icon != null) {
      icons = icon;
      _icon = Icon(icon);
    }
    setState(() {});
    debugPrint('Picked Icon:  $_icon');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: true,
        title: const Text(
          'Add Category',
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
                        hintText: 'Enter Category Name',
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
          Center(
            child: InkWell(
              onTap: () {
                _pickIcon();
              },
              child: Container(
                width: scrWidth * 0.3,
                height: scrHeight * 0.1,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: primaryColor)),
                child: Center(
                    child: _icon ??
                        Column(
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
                              "Pick Icon",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                          ],
                        )),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     const Text('Add as Kit'),
          //     ToggleSwitch(
          //       minWidth: w * 0.2,
          //       minHeight: h * 0.04,
          //       initialLabelIndex: 0,
          //       totalSwitches: 2,
          //       activeBgColor: const [Colors.green],
          //       activeFgColor: Colors.white,
          //       inactiveBgColor: Colors.red,
          //       inactiveFgColor: Colors.white,
          //       labels: const [
          //         'No ',
          //         'Yes ',
          //       ],
          //       onToggle: (index) {
          //         print(kit);
          //         index == 0 ? kit : !kit;
          //         kit = !kit;
          //       },
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: h * 0.02,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     const Text('Available'),
          //     ToggleSwitch(
          //       minWidth: w * 0.2,
          //       minHeight: h * 0.04,
          //       initialLabelIndex: 0,
          //       totalSwitches: 2,
          //       activeBgColor: const [Colors.green],
          //       activeFgColor: Colors.white,
          //       inactiveBgColor: Colors.red,
          //       inactiveFgColor: Colors.white,
          //       labels: const [
          //         'No ',
          //         'Yes ',
          //       ],
          //       onToggle: (index) {
          //         print(available);
          //         index == 0 ? false : true;
          //         available = !available;
          //       },
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: h * 0.05,
          // ),
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
                              icon: serializeIcon(icons),
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
                          _icon = null;
                          setState(() {});
                          icons = '';
                          print(icons);
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
              'Added Kit Category',
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
            var data = ref.watch(getStoreCategoriesProvider);
            return data.when(
              data: (data) {
                return ListView.builder(
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        print(update);
                        nameController.text = data[index].name!;
                        update = true;
                        categoryId = data[index].categoryId!;
                      },
                      child: Row(
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(data[index].name!,
                                    style: GoogleFonts.ubuntu(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 15,
                                        color: Colors.black)),
                                const Icon(Icons.edit)
                              ],
                            ),
                          ),
                        ],
                      ),
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
          }),
        ],
      ),
    );
  }
}
