import 'package:flutter/material.dart';

import '../../../splash_Screen.dart';
import 'add_kit.dart';
import 'add_store.dart';

class AddCategories extends StatefulWidget {
  const AddCategories({super.key});

  @override
  State<AddCategories> createState() => _AddCategoriesState();
}

class _AddCategoriesState extends State<AddCategories> {
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
                          builder: (context) => const AddKitCategory(),
                        ));
                  },
                  child: Text(
                    'Add Kit Cateory',
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
                          builder: (context) => const AddStoreCategory(),
                        ));
                  },
                  child: Text(
                    'Add Store Cateory',
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
