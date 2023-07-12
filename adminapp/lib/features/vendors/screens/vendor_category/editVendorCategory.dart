// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:multiselect/multiselect.dart';
// import '../flutter_flow/flutter_flow_util.dart';
// import '../flutter_flow/upload_media.dart';
// import '../models/adminModel.dart';
// import '../models/vendorCategoryModel.dart';
// import '../splashScreen.dart';
//
// class EditVendorCategory extends StatefulWidget {
//   final vendorCategoryModel data;
//   const EditVendorCategory({Key? key, required this.data}) : super(key: key);
//
//   @override
//   State<EditVendorCategory> createState() => _EditVendorCategoryState();
// }
//
// class _EditVendorCategoryState extends State<EditVendorCategory> {
//
//   TextEditingController categoryName = TextEditingController();
//
//
//
//   @override
//   void initState() {
//     categoryName = TextEditingController(text: widget.data.name);
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: primaryColor,
//         title: Center(
//           child: Text('ADD VENDOR CATEGORY',
//             style: GoogleFonts.ubuntu(
//               fontWeight: FontWeight.w800,
//               fontSize: 20,
//             ),),
//         ),
//
//       ),
//
//       body: Padding(
//         padding: const EdgeInsets.only(top: 20,bottom: 20),
//         child: Center(
//           child: Column(
//             children: [
//               Container(
//                 height: scrHeight*0.075,
//                 width: scrWidth*0.35,
//                 decoration:  BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                           color: Colors.black ,
//                           blurRadius: 2,
//                           offset: Offset(2, 0)
//                       )
//                     ]
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 20,top: 10),
//                   child: TextFormField(
//                     controller: categoryName,
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: BorderSide.none
//                         ),
//                         labelText: 'Enter Vendor Category',
//                         labelStyle: GoogleFonts.ubuntu(
//                             fontWeight: FontWeight.w500,
//                             fontSize: 13,
//                             color: Colors.black
//                         ),
//                         hintText: 'Vendor Category',
//                         hintStyle: GoogleFonts.ubuntu(
//                             fontWeight: FontWeight.w300,
//                             fontSize: 15,
//                             color: Colors.black
//                         )
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20,),
//               InkWell(
//                 onTap: () {
//                   setState(() {
//
//                   });
//
//                   if(categoryName.text.isEmpty){
//                     return showSnackbar(context, "Please Enter Vendor Category");
//                   }
//
//                   else {
//                     showDialog(context: context, builder: (context) {
//                       return AlertDialog(
//                         title: Text('Edit Vendor Category?'),
//                         content: Text('Do you want to continue?'),
//                         actions: [
//                           TextButton(onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                               child: Text('Cancel', style: TextStyle(color: primaryColor),)),
//
//                           TextButton(onPressed: () {
//                             FirebaseFirestore.instance.collection('vendorCategory').doc(widget.data.id).update({
//                               'name': categoryName.text,
//
//                             }
//                             );
//                             Navigator.of(context).pop();
//                             Navigator.of(context).pop();
//                           },
//                               child: Text('ok', style: TextStyle(color: primaryColor),))
//                         ],
//                       );
//                     });
//                   }
//
//                 },
//                 child: Container(
//                   height: scrHeight*0.05,
//                   width: scrWidth*0.15,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: primaryColor
//                   ),
//                   child: Center(
//                     child: Text('Edit Vendor Category',
//                       style: GoogleFonts.ubuntu(
//
//                           fontWeight: FontWeight.w600,
//                           fontSize: 15,
//                           color: Colors.white
//
//                       ),),
//                   ),
//                 ),
//               )
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
// }
