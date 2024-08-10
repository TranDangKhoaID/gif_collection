import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetDialogHelper {
  static showLoading() async {
    Get.dialog(
      barrierDismissible: false,
      const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static close() async {
    Get.close(1);
  }
}
