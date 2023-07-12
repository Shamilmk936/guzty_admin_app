import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/authentication/login_page.dart';

Color foodZerColor = Colors.cyan;
var h;
var scrHeight;
var w;
var scrWidth;
var currentUserName;
var currentUserEmail;
var currentUserPhone;
var currentUserImage;
var currentUserId;
var currentUserRole;
const Color primaryColor = Color(0xff0d2241);
var myColor = const Color.fromRGBO(36, 75, 141, 1);
var mySecondColor = Colors.blue.shade300;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var auth = FirebaseAuth.instance;
  bool login = false;

  keepLogin() async {
    FirebaseAuth.instance.signOut();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString(
      'userId',
    );
    currentUserId = prefs.getString(
      'userId',
    );
    print(currentUserId);
    if (currentUserId != null) {
      print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
      FirebaseFirestore.instance
          .collection('adminUser')
          .where('id', isEqualTo: currentUserId)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          print('1111111111111');
          login = true;
          currentUserEmail = value.docs[0]['email'].toString();
          currentUserEmail = value.docs[0]['email'].toString();
          currentUserName = value.docs[0]['userName'].toString();
          currentUserPhone = value.docs[0]['phone'] ?? '';
          currentUserRole = value.docs[0]['role'] ?? [];

          print('///////////////////////////////////////////');
          print(currentUserEmail);
          print(currentUserId);
          print(currentUserName);
          print(currentUserPhone);
          print(currentUserRole);

          print('///////////////////////////');
        } else {
          login = false;
        }

        if (mounted) {
          setState(() {});
        }
      });
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    keepLogin();

    Timer(const Duration(seconds: 3), () {
      // if (login != true) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => false);
      // }
      // else {
      //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      //       builder: (context) => Home()), (route) => false);
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    scrWidth = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    scrHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: h * 0.062),
              child: Column(
                children: [
                  CircularProgressIndicator(color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
