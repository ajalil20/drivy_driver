import 'dart:async';
import 'package:drivy_driver/Controller/auth_controller.dart';
import 'package:drivy_driver/Controller/global_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:drivy_driver/Service/dynamic_links.dart';
import 'package:drivy_driver/View/notification_alert.dart';
import '../../Utils/image_path.dart';
import '../../Utils/local_shared_preferences.dart';
import '../../Utils/utils.dart';

class Splash1 extends StatefulWidget {
  Splash1({super.key});
  @override
  State<Splash1> createState() => _Splash1State();
}

class _Splash1State extends State<Splash1> {
  // SplashController controller = Get.put(SplashController());
  GlobalController globalController = Get.put(GlobalController());
  AuthController a = Get.put(AuthController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    saveFCMToken();
    setNotifications(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImagePath.splashImage)
          )
      ),
      child: Image.asset(ImagePath.appLogo,scale: 4,),
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
