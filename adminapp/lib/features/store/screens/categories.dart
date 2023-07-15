import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Serialization/iconDataSerialization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../splash_Screen.dart';
import '../controller/store_controller.dart';
import 'add_category_product.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Icon? _icon;
  var icons;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: true,
        title: const Text(
          'Categories',
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Consumer(builder: (context, ref, child) {
            var data = ref.watch(getStoreCategoriesProvider);
            return data.when(
              data: (data) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    dynamic myIcon = data[index].icon;
                    var cId = data[index].categoryId;
                    icons = deserializeIcon(myIcon);
                    _icon = Icon(
                      icons,
                      color: Colors.black,
                      size: 40,
                    );
                    return InkWell(
                      onTap: () {
                        print(data[index].categoryId);
                        print(cId);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddCategoryProduct(
                                  id: cId!,
                                  name: data[index].name!,
                                  kit: data[index].kit!),
                            ));
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
                              children: [
                                SizedBox(
                                  width: w * 0.1,
                                ),
                                Text(data[index].name!,
                                    style: GoogleFonts.ubuntu(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 15,
                                        color: Colors.black)),
                                const Spacer(),
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: _icon,
                                ),
                                SizedBox(
                                  width: w * 0.1,
                                ),
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
