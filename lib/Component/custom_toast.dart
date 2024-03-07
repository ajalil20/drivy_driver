import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Utils/my_colors.dart';

class CustomToast{

  MyColors colors=MyColors();
  void showToast(String title,String body,bool error){
    Get.closeAllSnackbars();
    Get.showSnackbar(GetBar(
      title: title,
      message: body,
      backgroundColor: error?MyColors().errorColor:MyColors().primaryColor,
      // backgroundColor: error?colors.errorColor:colors.primaryColor,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    ));
  }

}