import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastManger {
  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: const Color(0xFFED4261),
      textColor: Colors.white,
      timeInSecForIosWeb: 2,
      fontSize: 18,
    );
  }
}
