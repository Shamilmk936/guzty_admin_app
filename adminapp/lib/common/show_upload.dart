import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

void showUploadErrorMessage(BuildContext context, String message, Color color,
    {bool showLoading = false}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: color,
        duration: showLoading
            ? const Duration(minutes: 30)
            : const Duration(seconds: 4),
        content: Row(
          children: [
            if (showLoading)
              const Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: CircularProgressIndicator(),
              ),
            Text(message),
          ],
        ),
      ),
    );
}

setSearchParam(String caseNumber) {
  List<String> caseSearchList = [];
  String temp = "";

  List<String> nameSplits = caseNumber.split(" ");
  for (int i = 0; i < nameSplits.length; i++) {
    String name = "";

    for (int k = i; k < nameSplits.length; k++) {
      name = name + nameSplits[k] + " ";
    }
    temp = "";

    for (int j = 0; j < name.length; j++) {
      temp = temp + name[j];
      caseSearchList.add(temp.toUpperCase());
    }
  }
  return caseSearchList;
}

void showErrorToast(BuildContext context, String message) {
  MotionToast.error(
          title: Text(
            'Error !',
          ),
          enableAnimation: true,
          position: MotionToastPosition.center,
          description: Text(message))
      .show(context);
}

void showSuccessToast(BuildContext context, String message) {
  MotionToast.success(
          title: Text(
            'Success !',
          ),
          enableAnimation: true,
          position: MotionToastPosition.center,
          description: Text(message))
      .show(context);
}
