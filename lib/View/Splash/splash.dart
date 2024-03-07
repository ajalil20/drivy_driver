import 'dart:async';

import 'package:drivy_driver/Component/custom_text.dart';
import 'package:drivy_driver/Controller/auth_controller.dart';
import 'package:drivy_driver/Controller/global_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:drivy_driver/Service/dynamic_links.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:drivy_driver/View/Authentication/role_selection.dart';
import 'package:drivy_driver/View/base_view.dart';
import 'package:drivy_driver/View/notification_alert.dart';
import 'package:sizer/sizer.dart';
import '../../Controller/splash_controller.dart';
import '../../Utils/image_path.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Utils/local_shared_preferences.dart';
import '../../Utils/utils.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // SplashController controller = Get.put(SplashController());
  GlobalController globalController = Get.put(GlobalController());
  AuthController a = Get.put(AuthController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      AppNavigation.navigateToRemovingAll(context, AppRouteName.LOGIN_SCREEN_ROUTE);
    });
    // saveFCMToken();
    // setNotifications(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImagePath.splashImage,)
        ),
      ),
    );
  }

  setNotifications(context) async{
    await FirebaseMessagingService().initializeNotificationSettings();
    Timer(const Duration(seconds: 3), () {
      FirebaseMessagingService().terminateNotification(context);
    });
    DynamicLinkProvider().initDynamicLinks();
    FirebaseMessagingService().foregroundNotification();
    FirebaseMessagingService().backgroundTapNotification();
  }
  saveFCMToken()async{
    await SharedPreference().sharedPreference;
    Utils().saveFCMToken();
  }
}
