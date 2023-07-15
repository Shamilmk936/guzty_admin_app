import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../splash_Screen.dart';

class ExpenseCategoryPage extends StatefulWidget {
  const ExpenseCategoryPage({Key? key}) : super(key: key);

  @override
  State<ExpenseCategoryPage> createState() => _ExpenseCategoryPageState();
}

class _ExpenseCategoryPageState extends State<ExpenseCategoryPage> {
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

  TextEditingController? expenseCategory;

  getIcon() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('expenses')
        .doc('cn3myFOpRZrE8NLKC8fg')
        .get();
    icons = deserializeIcon(doc['serviceCity']);
    _icon = Icon(icons);

    setState(() {});
  }

  @override
  void initState() {
    // getIcon();
    expenseCategory = TextEditingController(text: '');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: primaryColor,
          backgroundColor: Colors.white,
          title: const Text(
            'Add Expense Category',
            style: TextStyle(fontFamily: 'Outfit', color: primaryColor),
          ),
          bottom: TabBar(
              unselectedLabelColor: primaryColor,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: primaryColor),
              tabs: [
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: primaryColor, width: 1)),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text("Add"),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: primaryColor, width: 1)),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(" view Icons"),
                    ),
                  ),
                ),
              ]),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 10, right: 10, top: scrWidth * 0.025,
                // vertical: scrWidth * 0.05,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: scrWidth * 0.08,
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
                    SizedBox(
                      height: scrWidth * 0.08,
                    ),
                    SizedBox(
                      height: scrWidth * 0.04,
                    ),
                    GestureDetector(
                        onTap: () {
                          if (expenseCategory?.text != '') {
                            showDialog(
                                context: context,
                                builder: (buildcontext) {
                                  return AlertDialog(
                                    title: const Text('Add Expense Category'),
                                    content: const Text('Do you want to Add?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Cancel')),
                                      TextButton(
                                          onPressed: () {
                                            FirebaseFirestore.instance
                                                .collection('expenses')
                                                .add({
                                              "icon": serializeIcon(icons),
                                              'expenseName':
                                                  expenseCategory!.text,
                                              'user': ''
                                            }).whenComplete(() =>
                                                    Navigator.pop(context));

                                            Navigator.pop(context);
                                            expenseCategory?.clear();
                                            _icon == '';

                                            // Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => CharityCatogoryPage(),), (route) => false);
                                          },
                                          child: const Text('Yes')),
                                    ],
                                  );
                                });
                          } else {}
                        },
                        child: Container(
                          height: scrHeight * 0.065,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(17)),
                          margin: EdgeInsets.symmetric(
                              vertical: scrWidth * 0.03,
                              horizontal: scrHeight * 0.06),
                          child: const Center(
                              child: Text(
                            "ADD",
                            style: TextStyle(color: Colors.white),
                          )),
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('expenses')
                      .where('user', isEqualTo: '')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                          child:
                              const Center(child: CircularProgressIndicator()));
                    }
                    var data = snapshot.data?.docs;
                    return data == ''
                        ? Center(
                            child: Text(
                              'No Expense category ',
                              style: GoogleFonts.urbanist(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          )
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 0.9),
                            padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.05,
                            ),
                            itemCount: data?.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              icons = deserializeIcon(data![index]['icon']);
                              _icon = Icon(
                                icons,
                                color: Colors.white,
                                size: 40,
                              );
                              return Padding(
                                padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15,
                                  bottom: 10,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>DropdownEditPage(
                                    //   id:data![index].id,
                                    // )));
                                  },
                                  onLongPress: () {
                                    showDialog(
                                        context: context,
                                        builder: (buildcontext) {
                                          return AlertDialog(
                                            title: const Text('Delete'),
                                            content:
                                                const Text('Are you sure?'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Cancel')),
                                              TextButton(
                                                  onPressed: () {
                                                    FirebaseFirestore.instance
                                                        .collection('expenses')
                                                        .doc(data[index].id)
                                                        .delete();

                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Delete')),
                                            ],
                                          );
                                        });
                                  },
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.primaries[Random()
                                                    .nextInt(Colors
                                                        .primaries.length)],
                                                shape: BoxShape.circle),
                                            child: _icon,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            child: Text(
                                              data[index]['expenseName'],
                                              style: TextStyle(
                                                  fontFamily: 'urbanist',
                                                  fontSize: scrWidth * 0.029,
                                                  fontWeight: FontWeight.bold,
                                                  // color: Color(0xff034a82)
                                                  color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
