import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showAppSnackbar(String title, String message, String status) {
  Color backgroundColor;

  switch (status.toLowerCase()) {
    case 'success':
      backgroundColor = Colors.green;
      break;
    case 'error':
      backgroundColor = Colors.red;
      break;
    default:
      backgroundColor = Colors.grey;
  }

  Get.snackbar(
    title,
    message,
    backgroundColor: backgroundColor,
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    margin: const EdgeInsets.all(16),
    borderRadius: 8,
  );
}
