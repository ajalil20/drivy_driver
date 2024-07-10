import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:drivy_driver/Arguments/screen_arguments.dart';
import 'package:drivy_driver/Component/custom_toast.dart';
import 'package:drivy_driver/Controller/global_controller.dart';
import 'package:drivy_driver/Controller/home_controller.dart';
import 'package:jiffy/jiffy.dart';
import 'package:drivy_driver/Model/category_product_model.dart';
import 'package:drivy_driver/Model/contract_model.dart';
import 'package:drivy_driver/Model/notification_model.dart';
import 'package:drivy_driver/Model/order_model.dart';
import 'package:drivy_driver/Model/schedule_model.dart';
import 'package:drivy_driver/Model/user_model.dart';
import 'package:drivy_driver/Service/api_endpoints.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Service/socket_service.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:intl/intl.dart';
import 'package:drivy_driver/Utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:drivy_driver/View/notification_alert.dart';
import 'package:drivy_driver/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:place_picker/place_picker.dart';
import '../Controller/auth_controller.dart';
import 'enum.dart';
import 'local_shared_preferences.dart';

class Utils {
  static const String mDY = 'MM-dd-yyyy';
  static const String yMD = 'yyyy-MM-dd';
  static const String MMDDYY = 'MMMM dd, yyyy';
  static const String dayStartTime = '12:00 AM';
  static const String dayEndTime = '11:59 PM';
  static const String _monthYearFormat = "MM/yy";
  DateTime selectedDate = DateTime.now();
  RxString formattedDate = "".obs;
  static const googleApiKey = "AIzaSyBmaS0B0qwokES4a_CiFNVkVJGkimXkNsk";

  bool validatePassword(String value) {
    String pattern = r'^(?=.*?[a-zA-Z])(?=.*?[0-9]).{0,}$';
    String passwordPattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(passwordPattern);
    return regExp.hasMatch(value);
  }

  static String getFormattedMonthYear({required String date, String? format}) {
    return DateFormat(format ?? _monthYearFormat).format(DateTime.parse(date));
  }

  static Future<Map<String, dynamic>> findStreetAreaMethod(
      {required BuildContext context, String? prediction}) async {
    Map<String, dynamic>? addressDetail = {
      "address": null,
      "city": null,
      "state": null
    };

    try {
      //log("Prediction description:${prediction?.description}");
      List? addressInArray = prediction?.split(",");
      print("Address in array:${addressInArray}");
      String address = "";
      if (addressInArray != null) {
        for (int i = 0; i < addressInArray.length - 2; i++) {
          address = address + addressInArray[i];
        }
        addressDetail["address"] = address;
        addressDetail["state"] =
            addressInArray[addressInArray.length - 1] ?? "";
        addressDetail["city"] = addressInArray[addressInArray.length - 2] ?? "";
      }
    } catch (e) {
      log("error:${e}");
    }

    return addressDetail;
  }

  static Future<Map<String, dynamic>> getAddressFromLatLong(
      double lat, double long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    Map<String, dynamic>? addressDetail = {
      "address": null,
      "city": null,
      "state": null,
      "complete_address": null
    };

    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];
      addressDetail["address"] = placemark.name;
      addressDetail["city"] = placemark.locality;
      addressDetail["state"] = placemark.administrativeArea;
      addressDetail["complete_address"] =
          '${placemark.name}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}, ${placemark.postalCode}';
    }

    return addressDetail;
  }

  Future<LocationResult> showPlacePicker(context) async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePicker(
              AppStrings.GOOGLE_API_KEY,
            )));
    return result;
  }

  saveFCMToken() async {
    var t = SharedPreference().getFcmToken();
    log("getFcmToken ${t}");
    if (t == null) {
      log("getFcmToken k andar");
      SharedPreference().setFcmToken(token: "abc");
      // SharedPreference().setFcmToken(token: await FirebaseMessagingService().getToken());
    }
  }

  static String relativeTime(String date) {
    DateTime d = DateTime.parse(date);
    return Jiffy.parse(d.toLocal().toString()).fromNow();
  }

  static bool uniqueTimeCheck({
    required List<TimeOfDay> sTime,
    required List<TimeOfDay> eTime,
    required int startTime,
    required int endTime,
  }) {
    for (int i = 0; i < sTime.length; i++) {
      if (Utils().convertTimeToMinutes(h: sTime[i].hour, m: sTime[i].minute) >
          Utils().convertTimeToMinutes(h: startTime, m: startTime)) {
        return true;
      }
    }
    return false;
  }

  static String convertToLocalTime({required String time, String? format}) {
    var date = (time.split(' ')[0]).split('-')[2];
    var month = (time.split(' ')[0]).split('-')[1];
    var year = (time.split(' ')[0]).split('-')[0];
    var hour = (time.split(' ')[1]).split(':')[0];
    var min = (time.split(' ')[1]).split(':')[1];

    DateTime temp2 = DateFormat("yyyy-MM-dd hh:mm")
        .parse('${year}-${month}-${date} ${hour}:${min}Z');
    // DateTime temp2 = DateFormat("yyyy-MM-dd hh:mm").parse('${(time.split(' ')[0]).split('-')[0]}-${(time.split(' ')[0]).split('-')[1]}-${(time.split(' ')[0]).split('-')[2]} ${(time.split(' ')[1]).split(':')[0]}:${(time.split(' ')[1]).split(':')[1]} ${(time.split(' ')[2])}Z');
    // DateTime temp2 = DateFormat("yyyy-MM-dd hh:mm").parse(time);
    DateTime tempDate = DateTime.parse(temp2.toString() + "Z").toLocal();
    print(tempDate.toString());
    return DateFormat(format ?? "hh:mm a").format(tempDate);
  }

  static String convertToLocalDate({required String time, String? format}) {
    // "11-16-2023",
    // DateTime temp2 = DateFormat("MM-dd-yyyy hh:mm").parse(time);
    DateTime temp2 = DateFormat("yyyy-MM-dd hh:mm").parse(time);
    DateTime tempDate = DateTime.parse(temp2.toString() + "Z").toLocal();
    print(tempDate.toString());
    return DateFormat(format ?? "hh:mm a").format(tempDate);
  }

  //
  // static String relativeTime(DateTime date){
  //   // return Jiffy(date).fromNow();
  //   // // DateTime d = date.toUtc().toLocal();
  //   // // return d.toString();
  //   // // return Jiffy.parse(d.toString()).fromNow();
  //   // // return Jiffy.parse("${date.year}-${date.month}-${date.day}", "yyyy-MM-dd").fromNow();
  // }
  // // static String formatTimeAgo(String time) {
  // //   final now = DateTime.now();
  // //   DateTime timestamp = DateTime.parse(time);
  // //   final difference = now.difference(timestamp);
  // //   return timeago.format(now.subtract(difference));
  // // }
  //
  // getCommaSeparatedText({String? floor,String? address,String? country,String? state,}){
  //   List temp = [];
  //   (floor?? "").isNotEmpty ? temp.add("$floor") : null;
  //   (address?? "").isNotEmpty ? temp.add("$address") : null;
  //   (state?? "").isNotEmpty ? temp.add("$state") : null;
  //   (country?? "").isNotEmpty ? temp.add("$country") : null;
  //   if(temp!=[]) {
  //     return temp.join(",");
  //   }
  //   else {
  //     return "";
  //   }
  // }
  //
  // logout({bool fromLogout=false,BuildContext?context}) async {
  //   // if(fromLogout==true) {
  //   //   await AuthController.i.userLogout();
  //   // }
  //   // Get.offAll(() => RoleSelection());
  //   // Get.delete<UserController>();
  //   // var t=SharedPreference().getFcmToken();
  //   // SharedPreference().clear();
  //   // SharedPreference().setFcmToken(token: t);
  //   AppNavigation.navigateTo(context!, AppRouteName.ROLE_SELECTION);
  // }

  static Future<void> logout(
      {bool fromLogout = false, required BuildContext c}) async {
    if (fromLogout == true) {
      await AuthController.i.userLogout(context: c);
    }
    Utils().disposeSocket();
    AppNavigation.navigateTo(
        globalkey.currentState!.context, AppRouteName.LOGIN_SCREEN_ROUTE);
    saveRememberInfo();
    Get.delete<HomeController>();
  }

  static Future<void> saveRememberInfo() async {
    var t = SharedPreference().getFcmToken();
    SharedPreference().clear();
    SharedPreference().setFcmToken(token: t);
  }

  selectDate(BuildContext context,
      {DateTime? firstDate, DateTime? lastDate, initialDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? selectedDate,
      firstDate: firstDate ?? DateTime(1800),
      lastDate: lastDate ?? DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      formattedDate.value = DateFormat(mDY).format(selectedDate);
    }
    return (formattedDate.value);
  }

  parseDate({
    required String d,
  }) {
    return DateFormat('MMM dd yyyy')
        .format(((DateTime.parse(d))).toUtc().toLocal());
  }

  selectTime(BuildContext context, {required Function(TimeOfDay) onTap}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context, //context of current state
    );
    if (pickedTime != null) {
      onTap(pickedTime);
      return pickedTime.format(context);
    }
    // else{
    //   print("Time is not selected");
    // }
  }

  convertTimeToMinutes({required int h, required int m}) {
    final duration = Duration(hours: h, minutes: m, seconds: 0);
    return duration.inMinutes;
  }

  getUserChat(
      {required User? u1, required User? u2, required User currentUser}) {
    if (u1!.id != currentUser.id) {
      return u1;
    } else {
      return u2;
    }
  }

  maskedNumber({required String phone}) {
    var maskFormatter = MaskTextInputFormatter(
        mask: '(###) ###-####',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
    return maskFormatter.maskText(phone);
  }

  unMaskedNumber({required String phone}) {
    var maskFormatter = MaskTextInputFormatter(
        mask: '(###) ###-####',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
    return maskFormatter.unmaskText(phone);
  }

  setUserRole(role) {
    switch (role) {
      case AppStrings.INFLUENCER:
        GlobalController.values.userRole.value = UserRole.influencer;
        break;
      case AppStrings.SELLER:
        GlobalController.values.userRole.value = UserRole.seller;
        break;
      default:
        GlobalController.values.userRole.value = UserRole.user;
        break;
    }
  }

  setUserLoginType(type) {
    switch (type) {
      case (AppStrings.PHONE_LOGIN):
        GlobalController.values.loginType.value = LoginType.phone;
        break;
      case null:
        GlobalController.values.loginType.value = LoginType.email;
        break;
      default:
        GlobalController.values.loginType.value = LoginType.social;
        break;
    }
  }

  getContractPaymentKey(val) {
    switch (val) {
      case AppStrings.COMMISION:
        return AppStrings.COMMISION_KEY;
      case AppStrings.OTP:
        return AppStrings.OTP_KEY;
      case AppStrings.GIFT:
        return AppStrings.GIFT_KEY;
    }
  }

  getContractPaymentValue(val) {
    switch (val) {
      case AppStrings.COMMISION_KEY:
        return AppStrings.COMMISION;
      case AppStrings.OTP_KEY:
        return AppStrings.COMMISION;
      case AppStrings.GIFT_KEY:
        return AppStrings.GIFT;
    }
  }

  goToRoute(
      {required context,
      required User user,
      required bool isLogin,
      bool route = true}) async {
    ///Alfa
    // RemoteMessage? terminatedMessage =
    //     await FirebaseMessaging.instance.getInitialMessage();
    AuthController.i.userID = user.id ?? '';
    if (route) {
      AppNavigation.navigateToRemovingAll(
          context, AppRouteName.HOME_SCREEN_ROUTE);
    }
    // if (user.isVerified == 0 && isLogin) {
    //   AppNavigation.navigateTo(context, AppRouteName.ENTER_OTP_SCREEN_ROUTE);
    // } else if (user.isVerified == 1 && user.userIsProfileComplete == 0 && isLogin) {
    //   AppNavigation.navigateReplacementNamed(context, AppRouteName.COMPLETE_PROFILE_SCREEN_ROUTE,);
    // } else if (user.isVerified == 1 && user.userIsProfileComplete == 1) {
    //   connectSocket(onConnect: (){});
    //   AppNavigation.navigateTo(context, AppRouteName.HOME_SCREEN_ROUTE,);
    // }  else {
    //   AppNavigation.navigateReplacementNamed(context, AppRouteName.LOGIN_SCREEN_ROUTE,);
    // }
  }

  static double calculateDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) {
    double distance = Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);

    // Convert distance from meters to kilometers
    return distance / 1000;
  }

  goToNotificationRoute(
      {required context,
      required NotificationModel n,
      required bool isPush}) async {
    if (isPush) {
      AuthController.i.user.value =
          User.fromJson(jsonDecode(SharedPreference().getUser()!));
      // if(AuthController.i.user.value.userIsProfileComplete==1){
      //   connectSocket(onConnect: (){});
      // }
    }
    if (n.notificationType == AppStrings.MSG_NOTIFICATION) {
      if (isPush) {
        HomeController h = Get.put(HomeController());
        AppNavigation.navigateTo(
          context,
          AppRouteName.HOME_SCREEN_ROUTE,
        );
      }
      AppNavigation.navigateTo(context, AppRouteName.MESSAGE_SCREEN_ROUTE);
      AppNavigation.navigateTo(context, AppRouteName.CHAT_SCREEN_ROUTE,
          arguments:
              ScreenArguments(u: User(id: n.senderId, fullName: n.senderName)));
    }
    if (n.notificationType == AppStrings.STREAM_STARTED_NOTIFICATION) {
      if (isPush) {
        HomeController h = Get.put(HomeController());
      }
      AppNavigation.navigateToRemovingAll(
        context,
        AppRouteName.HOME_SCREEN_ROUTE,
      );
      await HomeController.i.joinStreaming(context, onSuccess: () {
        AppNavigation.navigateTo(context, AppRouteName.LIVE_STREAM_ROUTE);
      }, roomId: n.roomId);
    } else if (n.notificationType == AppStrings.STREAM_REQUEST_NOTIFICATION ||
        n.notificationType ==
            AppStrings.STREAM_REQUEST_CANCELLED_NOTIFICATION ||
        n.notificationType == AppStrings.STREAM_NOTIFICATION ||
        n.notificationType == AppStrings.ADMIN_NOTIFICATION) {
      if (isPush) {
        HomeController h = Get.put(HomeController());
      }
      AppNavigation.navigateToRemovingAll(
        context,
        AppRouteName.HOME_SCREEN_ROUTE,
      );
    } else if (n.notificationType == AppStrings.NEW_ORDER_NOTIFICATION) {
      if (isPush) {
        HomeController h = Get.put(HomeController());
      }
      AppNavigation.navigateToRemovingAll(
          context, AppRouteName.HOME_SCREEN_ROUTE,
          arguments: ScreenArguments(index: 2));
    } else if (n.notificationType ==
        AppStrings.CONTRACT_REQUEST_ACCEPTED_NOTIFICATION) {
      if (isPush) {
        HomeController h = Get.put(HomeController());
      }
      bool seller = GlobalController.values.userRole.value == UserRole.seller;
      if (seller) {
        if (isPush) {
          AppNavigation.navigateToRemovingAll(
              context, AppRouteName.HOME_SCREEN_ROUTE);
        }
        AppNavigation.navigateTo(context, AppRouteName.CONTRACT_HISTORY_SCREEN);
      } else {
        AppNavigation.navigateToRemovingAll(
            context, AppRouteName.HOME_SCREEN_ROUTE,
            arguments: ScreenArguments(index: 2));
      }
    } else if (n.notificationType == AppStrings.REQUEST_NOTIFICATION) {
      print("Check Notification");
      if (isPush) {
        HomeController h = Get.put(HomeController());
      }
      bool influencer =
          GlobalController.values.userRole.value == UserRole.influencer;
      if (influencer) {
        if (isPush) {
          AppNavigation.navigateToRemovingAll(
              context, AppRouteName.HOME_SCREEN_ROUTE,
              arguments: ScreenArguments(index: 2));
        }

        ///contractId nahi arahi ha notifications ma ... to navifation nhoi ho gi
        ///iss uncomment karna aur key check karna ha
        HomeController.i.onTapContract(c: ContractModel(id: n.requestId));
        //AppNavigation.navigateTo(context, AppRouteName.SELLER_STREAM_REQUEST_ROUTE);
        AppNavigation.navigateToRemovingAll(
            context, AppRouteName.HOME_SCREEN_ROUTE,
            arguments: ScreenArguments(index: 2));
      }
    } else if (n.notificationType == AppStrings.ORDER_STATUS_NOTIFICATION) {
      if (isPush) {
        HomeController h = Get.put(HomeController());
        AppNavigation.navigateTo(context, AppRouteName.HOME_SCREEN_ROUTE,
            arguments: ScreenArguments(index: 2));
      }
      await HomeController.i
          .getOrderDetails(context: context, o: OrderModel(id: n.orderId));
      AppNavigation.navigateTo(context, AppRouteName.ORDER_HISTORY_ROUTE);
    } else if (n.notificationType == AppStrings.USER_REVIEW_NOTIFICATION) {
      if (isPush) {
        HomeController h = Get.put(HomeController());
        AppNavigation.navigateTo(context, AppRouteName.HOME_SCREEN_ROUTE,
            arguments: ScreenArguments(index: 3));
      }
      HomeController.i.endUser.value = AuthController.i.user.value;
      AppNavigation.navigateTo(context, AppRouteName.ALL_REVIEWS_ROUTE);
    } else if (n.notificationType == AppStrings.PRODUCT_REVIEW_NOTIFICATION) {
      if (isPush) {
        HomeController h = Get.put(HomeController());
        AppNavigation.navigateTo(context, AppRouteName.HOME_SCREEN_ROUTE);
      }
      await HomeController.i
          .getProductDetail(context, p: ProductsModel(id: n.productId));
      AppNavigation.navigateTo(context, AppRouteName.PRODUCT_DETAIL_ROUTE);
    }
  }

  void connectSocket({required Function onConnect}) {
    loadingOn();
    print("Socked is initializeSocket");
    SocketService.instance?.initializeSocket();
    SocketService.instance?.connectSocket();
    SocketService.instance?.socketResponseMethod();
    onConnect();
  }

  loadingOn() {
    EasyLoading.instance.userInteractions = false;
    EasyLoading.show(status: 'Please wait...', dismissOnTap: false);
  }

  loadingOff() {
    EasyLoading.dismiss();
  }

  void disposeSocket() {
    SocketService.instance?.dispose();
    loadingOff();
  }

// static String? formatChatTimeMethod({String? createdDate,String? format,String? inputFormat}) {
//   if (createdDate != null && createdDate.isNotEmpty) {
//     return formatDateTime(
//         parseFormat: format??mDY,
//         inputDateTime: parseDateTime(
//             parseFormat: inputFormat??yMD,
//             inputDateTime: createdDate,
//             utc: false)
//             .toLocal());
//   }
//   return null;
// }

  DateTime convertToDateTime({String? formattedDateTime, required String d}) {
    return DateFormat(formattedDateTime ?? mDY).parse(d);
  }

  int calculateAgeFromDateOfBirth({required String d}) {
    int daysInAge = DateTime.now().difference(convertToDateTime(d: d)).inDays;
    int ageInYears = daysInAge ~/ 365;
    return ageInYears;
  }

  String convertFormattedDateTime(
      String formattedDateTime, String outputFormatt) {
    DateFormat inputFormat = DateFormat(formattedDateTime);
    DateFormat outputFormat = DateFormat(outputFormatt);
    DateTime dateTime = inputFormat.parse(formattedDateTime);
    String convertedDateTime = outputFormat.format(dateTime);
    return convertedDateTime;
  }

  getFollowStatus({required int v}) {
    return v == 0 ? AppStrings.FOLLOW : AppStrings.UN_FOLLOW;
  }

  getRequestStatus({required String v}) {
    if (v == AppStrings.PENDING_KEY) {
      return AppStrings.REQUEST_PENDING.obs;
    } else if (v == AppStrings.ACCEPTED_KEY) {
      return AppStrings.CONTRACT_SIGNED.obs;
    } else {
      return AppStrings.CREATE_CONTRACT;
    }
  }

  static ScheduleModel createScheduleJson(
      {required String title,
      required String description,
      required DateTime start,
      required DateTime end,
      required String startTime,
      required String endTime}) {
    var s = Utils.convertTimeToUTC(date: start, time: startTime);
    var e = Utils.convertTimeToUTC(date: end, time: endTime);
    return ScheduleModel(
        id: '${DateTime.now()}',
        title: title,
        description: description,
        startTime: s,
        endTime: e);

    // return({'"id"':'"${DateTime.now()}"','"title"':'"$title"', '"description"':'"$description"','"start_time"':'"$s"', '"end_time"':'"$e"'});
  }

  static String convertTimeToUTC(
      {required DateTime date, required String time, String? dateFormat}) {
    DateTime tempDate = DateFormat("yyyy-MM-dd hh:mm a")
        .parse('${date.year}-${date.month}-${date.day} $time');
    return tempDate.toUtc().toString();
  }

  static String formatDateTime(
      {required String parseFormat, required DateTime inputDateTime}) {
    return DateFormat(parseFormat).format(inputDateTime);
  }

  Future<bool> requestCameraPermissions() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      HomeController.i.cameraPermission = true;
      return true;
    } else if (status.isPermanentlyDenied) {
      CustomToast().showToast(
          'Camera access denied',
          'To enable camera access, please visit our app\'s settings. ⚙️',
          true);
      openAppSettings();
      return false;
    } else {
      return false;
    }
  }

  Future<bool> requestMicrophonePermissions() async {
    final status = await Permission.microphone.request();
    if (status.isGranted) {
      HomeController.i.microphonePermission = true;
      return true;
    } else if (status.isPermanentlyDenied) {
      CustomToast().showToast(
          'Microphone access denied',
          'To enable microphone access, please visit our app\'s settings. ⚙️',
          true);
      openAppSettings();
      return false;
    } else {
      return false;
    }
  }

  String addPlusSign(String text) {
    if (!text.startsWith("+")) {
      text = "+$text";
    }
    return text;
  }
}

extension StringExtension on String {
  String? capitalizeFirstLetter() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
