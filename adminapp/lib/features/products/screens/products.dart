import 'dart:async';

import 'package:adminapp/features/products/screens/product_categories.dart';
import 'package:adminapp/features/products/screens/products_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../../../model/productModel.dart';
import '../../../splash_Screen.dart';

class Products extends StatefulWidget {
  const Products({
    Key? key,
  }) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          automaticallyImplyLeading: true,
          title: Text(
            'Products',
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductList(),
                      ));
                },
                child: Text('Products List')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductCategoryList(),
                      ));
                },
                child: Text('Products Category')),
          ],
        ));
  }
}
