import 'package:flutter/material.dart';

class CustomSnackBar {
  static void showPaymentSuccessSnackBar(BuildContext context,String? messsage,Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          messsage??'',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating, 
        duration: const Duration(seconds: 2), 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
