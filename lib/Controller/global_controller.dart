import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:drivy_driver/Utils/app_strings.dart';
import 'package:drivy_driver/Utils/enum.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController{
  static GlobalController get values => Get.find();
  Rx<UserRole> userRole = UserRole.user.obs;
  Rx<LoginType> loginType = LoginType.email.obs;
  // String fName='',LName='',email='';

}