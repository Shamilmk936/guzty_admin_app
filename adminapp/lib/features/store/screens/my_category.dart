import 'package:adminapp/features/add_sub_products/screens/add_sub_products.dart';
import 'package:adminapp/features/store/screens/categories.dart';
import 'package:flutter/material.dart';

import '../../../splash_Screen.dart';
import 'add_categories.dart';

class MyCategory extends StatefulWidget {
  const MyCategory({super.key});

  @override
  State<MyCategory> createState() => _MyCategoryState();
}

class _MyCategoryState extends State<MyCategory> {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddCategory(),
                        ));
                  },
                  child: Text(
                    'Add Category',
                    style: TextStyle(
                        fontSize: h * 0.016,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),
          SizedBox(
            height: h * 0.02,
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Categories(),
                        ));
                  },
                  child: Text(
                    'Add Product',
                    style: TextStyle(
                        fontSize: h * 0.016,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),
          SizedBox(
            height: h * 0.02,
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddSubProducts(),
                        ));
                  },
                  child: Text(
                    'Add Sub Products',
                    style: TextStyle(
                        fontSize: h * 0.016,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
