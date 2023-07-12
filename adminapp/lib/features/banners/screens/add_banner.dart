import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/utils.dart';
import '../../../splash_Screen.dart';

class AddBanner extends StatefulWidget {
  const AddBanner({Key? key}) : super(key: key);

  @override
  State<AddBanner> createState() => _AddBannerState();
}

class _AddBannerState extends State<AddBanner> {
  String profile = '';
  var pickedFile;
  final ImagePicker _picker = ImagePicker();
  File? file;
  List urls = [];
  Map homeBanner = {};
  var bytes;
  final vendorController = TextEditingController();
  List vendors = [''];
  List a = [];
  List myList = [
    "abc",
    "def",
    "ghi",
    "jkl",
    "mno",
    "pqr",
  ];
  getVendors() async {
    QuerySnapshot a = await FirebaseFirestore.instance
        .collection('vendors')
        .where('verified', isEqualTo: true)
        .get();
    vendors = [];
    if (a.docs.isNotEmpty) {
      for (var v in a.docs) {
        vendors.add(v['id']);

        print(vendors);
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getVendors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          'Add Banner',
          style: TextStyle(
            fontFamily: 'Lexend Deca',
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                print("AAAAAAa");
                print(currentUserId);
                _imgFromGallery();
              });
            },
            child: CircleAvatar(
              radius: h * 0.07,
              child: profile == ""
                  ? const Icon(Icons.add_photo_alternate)
                  : CachedNetworkImage(imageUrl: '${profile}'),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15, left: 18, right: 18, bottom: 10),
            // height: 109,
            width: 370,
            decoration: BoxDecoration(
              color: Color(0xffFFFFFF),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Orders Type',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: h * 0.035,
                ),
                Container(
                  child: CustomDropdown.search(
                    hintText: "Choose OrderTypes",
                    borderSide: const BorderSide(
                      width: 1.5,
                      color: Color(0xffBBC5CD),
                    ),
                    items: List.generate(
                      vendors.length,
                      (index) => vendors[index],
                    ),
                    controller: vendorController,
                    onChanged: (text) {
                      setState(() {
                        if (!a.contains(text)) {
                          a.add(text);
                        } else {
                          showSnackBar(context, 'Already Selected');
                        }
                        vendorController.clear();

                        setState(() {});
                      });
                    },
                  ),
                ),
                a.isNotEmpty
                    ? Column(
                        children: List.generate(
                          a.length,
                          (index) => Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '\u2022',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      a[index],
                                      style: TextStyle(
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
                                      a.removeAt(index);
                                    });
                                  },
                                  child: Container(
                                    width: 17,
                                    height: 17,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.8),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 0),
                                          color: Colors.grey.shade200,
                                          blurRadius: 1,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
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
                    : SizedBox(),
                ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('banner')
                          .doc('1000')
                          .update(
                        {
                          'homeBanner': FieldValue.arrayUnion([
                            {'vendors': a, 'url': urls[0]['url ']}
                          ])
                        },
                      );
                    },
                    clipBehavior: Clip.antiAlias,
                    child: Text('add'))
              ],
            ),
          )
        ],
      ),
    );
  }

  _imgFromGallery() async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 70);

    var fileName = DateTime.now();
    var ref = await FirebaseStorage.instance
        .ref()
        .child('banner/$currentUserId/$fileName');
    UploadTask uploadTask = ref.putFile(File(image!.path));
    uploadTask.then((res) async {
      profile = (await ref.getDownloadURL()).toString();
      setState(() {});
      print('--------------------------------------------------------------');
      urls = [
        {'url': profile}
      ];
      print(profile);
      print('--------------------------------------------------------------');
      // })
      //     .then((value) {
      //   FirebaseFirestore.instance.collection('banner').doc('1000').update(
      //     {
      //       'homeBanner': FieldValue.arrayUnion(urls)
      //     },
      //   );
    });
  }
}
