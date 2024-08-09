import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetDialogHelper {
  static bool _isOpened = false;
  static bool get isOpened => _isOpened == true;
  static const double _dialogWidth = 400;
  static openDialog() {
    _isOpened = true;
  }

  static closeDialog() {
    _isOpened = false;
  }

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
