import 'package:adminapp/homepage.dart';
import 'package:adminapp/nav_bar.dart';
import 'package:adminapp/splash_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode userNameFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    emailController = TextEditingController(text: 'custom@gmail.com');
    passwordController = TextEditingController(text: '123');

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 110,
            width: 110,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/logo.png"), fit: BoxFit.contain)),
            // child: Image(image:AssetImage("assets/login.gif")
            // )
          ),
          SizedBox(
            height: h * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: w * 0.8,
                    padding: EdgeInsets.symmetric(
                      horizontal: w * 0.015,
                      vertical: h * 0.002,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xffF3F3F3),
                      borderRadius: BorderRadius.circular(w * 0.026),
                    ),
                    child: TextFormField(
                      controller: emailController,
                      focusNode: userNameFocus,
                      cursorWidth: 1,
                      cursorColor: Colors.black,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        fontFamily: 'Urbanist',
                      ),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: userNameFocus.hasFocus
                              ? Colors.blueGrey
                              : Color(0xffB0B0B0),
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          fontFamily: 'Urbanist',
                        ),
                        prefixIcon: Icon(Icons.person),
                        fillColor: Color(0xffF3F3F3),
                        filled: true,
                        contentPadding: EdgeInsets.only(top: 5, left: 10),
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        border: InputBorder.none,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.03,
                  ),
                  Container(
                    height: 50,
                    width: w * 0.8,
                    padding: EdgeInsets.symmetric(
                      horizontal: w * 0.015,
                      vertical: h * 0.002,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xffF3F3F3),
                      borderRadius: BorderRadius.circular(w * 0.026),
                    ),
                    child: TextFormField(
                      controller: passwordController,
                      focusNode: passwordFocus,
                      cursorWidth: 1,
                      cursorColor: Colors.black,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        fontFamily: 'Urbanist',
                      ),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: passwordFocus.hasFocus
                              ? Colors.blueGrey
                              : Color(0xffB0B0B0),
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          fontFamily: 'Urbanist',
                        ),
                        prefixIcon: Icon(Icons.lock),
                        fillColor: Color(0xffF3F3F3),
                        filled: true,
                        contentPadding: EdgeInsets.only(top: 5, left: 10),
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        border: InputBorder.none,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.07,
                  ),
                  InkWell(
                    onTap: () async {
                      if (emailController.text.contains('@gmail.com') &&
                          passwordController.text != '') {
                        FirebaseFirestore.instance
                            .collection('adminUser')
                            .where('email', isEqualTo: emailController.text)
                            .where('password',
                                isEqualTo: passwordController.text)
                            .where('deleted', isEqualTo: false)
                            .get()
                            .then((value) async {
                          if (value.docs.isNotEmpty) {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString('userId', value.docs[0]['id']);
                            currentUserId = value.docs[0]['id'];
                            currentUserEmail = value.docs[0]['email'];
                            currentUserName = value.docs[0]['userName'];
                            currentUserPhone = value.docs[0]['phone'];
                            currentUserRole = value.docs[0]['role'];
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NavBarPage()),
                                (route) => false);
                          } else {
                            showUploadMessage(
                                context, 'User Does Not Exist in Admins List');
                          }
                        });
                      } else {
                        emailController.text.isEmpty
                            ? showUploadMessage(
                                context, 'Please enter your Email')
                            : passwordController.text.isEmpty
                                ? showUploadMessage(
                                    context, 'Please enter password')
                                : showUploadMessage(
                                    context, 'Please enter a valid email');
                      }
                    },
                    child: Container(
                      height: 50,
                      width: w * 0.8,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(21.5)),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Urbanist',
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void showUploadMessage(BuildContext context, String message,
    {bool showLoading = false}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        duration: showLoading ? Duration(minutes: 30) : Duration(seconds: 4),
        content: Row(
          children: [
            if (showLoading)
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: CircularProgressIndicator(),
              ),
            Text(message),
          ],
        ),
      ),
    );
}

Future<bool> alert(
  BuildContext context,
  String message,
) async {
  bool result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0)),
            title: Text('Are you sure ?'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop(false);
                },
                child: Text('No',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop(true);
                },
                child: Text('Yes',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
              )
            ],
          ));
  return result;
}

void showSnackbar(
  BuildContext context,
  String message, {
  bool loading = false,
  int duration = 4,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          if (loading)
            Padding(
              padding: EdgeInsetsDirectional.only(end: 10.0),
              child: Container(
                height: 20,
                width: 20,
                child: const CircularProgressIndicator(
                    // color: Colors.white,
                    ),
              ),
            ),
          Text(message),
        ],
      ),
      duration: Duration(seconds: duration),
    ),
  );
}
