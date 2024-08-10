import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetxHelper extends GetxController {
  static showSnackBar({required String message}) {
    Get.showSnackbar(GetSnackBar(
      duration: Duration(seconds: 3),
      backgroundColor: Colors.white,
      message: message,
      messageText: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
    ));
  }
}
