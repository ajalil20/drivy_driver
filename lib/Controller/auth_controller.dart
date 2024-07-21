import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:drivy_driver/Controller/global_controller.dart';
import 'package:drivy_driver/Model/user_model.dart';
import 'package:drivy_driver/Service/base_service.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Service/social_login.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:drivy_driver/Utils/app_strings.dart';
import 'package:drivy_driver/Utils/enum.dart';
import 'package:drivy_driver/Utils/local_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:drivy_driver/Component/custom_toast.dart';
import 'package:drivy_driver/Utils/utils.dart';
import '../Arguments/screen_arguments.dart';
import '../Service/api_endpoints.dart';

class AuthController extends GetxController {
  static AuthController get i => Get.find();
  BaseService b = BaseService();
  Rx<User> user = User().obs;
  String userID = "",
      imageProfile = "",
      name = "",
      country = "",
      firstName = "",
      lastName = "",
      email = "",
      otp = "",
      location = "",
      dialCode = "971",
      phone = "",
      password = "",
      confirmPassword = "",
      countryCode = "AE",
      dob = "",
      verificationId = "",
      emiratesId = "",
      passport = "";
  double lat = 0, lng = 0;
  bool isMerchantSetupDone = false, carRegister = false;
  List fileName = [], files = [];

  // Rx<File> imageProfile = File("").obs, resume = File("").obs;

  ///Login Validation
  loginValidation(context, {required bool isEmail}) async {
    // AppNavigation.navigateToRemovingAll(context, AppRouteName.HOME_SCREEN_ROUTE);
    FocusManager.instance.primaryFocus?.unfocus();
    if (isEmail) {
      if (email.isEmpty) {
        CustomToast().showToast("Warning", "Email field can't be empty", true);
      } else if (!email.trim().isEmail) {
        CustomToast()
            .showToast("Warning", "Please enter valid email address", true);
      } else if (password.isEmpty) {
        CustomToast()
            .showToast("Warning", "Password field can't be empty.", true);
      } else if (password.length < 8) {
        CustomToast().showToast("Warning", "Password is incorrect.", true);
      } else {
        userLogin(context, onSuccess: () {
          AppNavigation.navigateToRemovingAll(
              context, AppRouteName.HOME_SCREEN_ROUTE);
          // AppNavigation.navigateTo(context, AppRouteName.ENTER_OTP_SCREEN_ROUTE,arguments: ScreenArguments(isFirebase: false));
        }, isEmail: isEmail);
      }
    } else {
      print(dialCode);
      if (phone.isEmpty) {
        CustomToast()
            .showToast("Error", 'Phone number field can\'t be empty', true);
      } else if (!(dialCode + phone).isPhoneNumber) {
        CustomToast().showToast("Error", 'Invalid phone number', true);
      } else if (dialCode == '+971' && phone.length < 9) {
        CustomToast().showToast("Error", 'Invalid phone number', true);
      } else if (password.isEmpty) {
        CustomToast()
            .showToast("Warning", "Password field can't be empty.", true);
      } else if (password.length < 8) {
        CustomToast().showToast("Warning", "Password is incorrect.", true);
      } else {
        userLogin(context, onSuccess: () {
          AppNavigation.navigateToRemovingAll(
              context, AppRouteName.HOME_SCREEN_ROUTE);
          // AppNavigation.navigateTo(context, AppRouteName.ENTER_OTP_SCREEN_ROUTE,arguments: ScreenArguments(isFirebase: false));
        }, isEmail: isEmail);
      }
    }
  }

  phoneLoginValidation(context) async {
    FocusScope.of(context).unfocus();
    if (phone.isEmpty) {
      CustomToast()
          .showToast("Error", 'Phone number field can\'t be empty', true);
    } else if (!(dialCode + phone).isPhoneNumber) {
      CustomToast().showToast("Error", 'Invalid phone number', true);
    } else if (dialCode == '971' && phone.length < 9) {
      CustomToast().showToast("Error", 'Invalid phone number', true);
    } else {
      print(dialCode + phone);
      checkPhone(context, onSuccess: () {
        AppNavigation.navigateTo(context, AppRouteName.ENTER_OTP_SCREEN_ROUTE,
            arguments: ScreenArguments(fromForgetPassword: false));
      });
      // SocialAuthBloc social = SocialAuthBloc();
      // social.signInWithPhone(context: context,setProgressBar:(){
      //   EasyLoading.instance.userInteractions=false;
      //   EasyLoading.show(status: 'Please wait...',dismissOnTap: false);
      // },phoneNumber: phone,countryCode: '+$dialCode',cancelProgressBar: (){EasyLoading.dismiss();},
      //     onCodeSent: (){
      //       CustomToast().showToast("Success", "OTP verification code has been sent to your phone number", false);
      //       AppNavigation.navigateTo(context, AppRouteName.ENTER_OTP_SCREEN_ROUTE,arguments: ScreenArguments(isFirebase: true));
      //     }
      // );
    }
  }

  Future<void> checkPhone(context, {required Function onSuccess}) async {
    Map jsonData = {
      "phone": '+${dialCode + phone}',
    };
    var res = await b.basePostAPI(APIEndpoints.sendUserOtp, jsonData,
        loading: true, context: context);
    if (res['success'] == true) {
      onSuccess();
      CustomToast().showToast(
          "Success", '${res['data']['otp']} ${res['message']}', false);
      // CustomToast().showToast("Success", res['message'], false);
    } else {
      CustomToast().showToast("Error", res['message'], true);
    }
  }

  Future<void> userLogin(context,
      {required Function onSuccess, required bool isEmail}) async {
    Map jsonData = {
      if (isEmail)
        "email": email.toLowerCase().trim()
      else
        "phone": dialCode + phone,
      "password": password,
      "type": "host",
      "user_device_type": Platform.isIOS ? "ios" : "android",
      // "user_device_token": SharedPreference().getFcmToken(),
    };
    var res = await b.basePostAPI(APIEndpoints.login, jsonData,
        loading: true, context: context);
    if (res['success'] == true) {
      // userID=res['data']['_id'];
      // onSuccess();
      loginSuccess(res, context);
    } else {
      CustomToast().showToast("Error", res['message'], true);
    }
  }

  Future<void> socialLogin(context,
      {email,
      socialType,
      socialToken,
      String? firstName,
      String? lastName,
      String? phone,
      String? dialCode,
      String? countryCode}) async {
    Map jsonData = {
      "user_device_type": Platform.isIOS ? "ios" : "android",
      "user_social_token": socialToken,
      "user_social_type": socialType,
      "role": GlobalController.values.userRole.value.name,
      "user_device_token": SharedPreference().getFcmToken(),
      if (phone != null) "phone_number": phone,
      if (dialCode != null) "dial_code": dialCode,
      if (countryCode != null) "country_code": countryCode,
      if (firstName != null) "first_name": firstName,
      if (lastName != null) "last_name": lastName,
    };
    print(jsonData);
    var res = await b.basePostAPI(APIEndpoints.socialLogin, jsonData,
        loading: true, context: context);
    if (res['success'] == true) {
      loginSuccess(res, context);
    } else {
      if (socialType == AppStrings.PHONE) {
        AppNavigation.navigatorPop(context);
      }
      CustomToast().showToast("Error", res['message'], true);
    }
  }

  loginSuccess(res, context, {bool route = true}) {
    SharedPreference().setBearerToken(token: res["data"]["token"]);
    SharedPreference().setUser(user: jsonEncode(res['data']));
    AuthController.i.user.value =
        User.fromJson(jsonDecode(SharedPreference().getUser()!));
    log("loginSuccess");
    Utils().goToRoute(
        context: context,
        user: AuthController.i.user.value,
        isLogin: true,
        route: route);

    // SharedPreference().setBearerToken(token:res['data']['user_authentication']);
    // SharedPreference().setUser(user: jsonEncode(res['data']));
    // user.value=User.fromJson(res['data']);
    // AppNavigation.navigatorPop(context);
    // if(user.value.userIsProfileComplete==1){
    //   CustomToast().showToast("Success", "Login Successfully", false);
    //   AppNavigation.navigateTo(context, AppRouteName.HOME_SCREEN_ROUTE,);
    // } else{
    //   CustomToast().showToast("Success", "Account validation completed.", false);
    //   AppNavigation.navigateTo(context, AppRouteName.COMPLETE_PROFILE_SCREEN_ROUTE,);
    // }
  }

  ///User Logout
  Future<void> userLogout({required BuildContext context}) async {
    var res = await b.basePostAPI(
        APIEndpoints.logout, {'user_id': user.value.id},
        loading: true, context: context);
  }

  ///SignUp Validation
  passwordValidation(context, {required bool fromForgetPassword}) {
    print(phone);
    if (password.isEmpty) {
      CustomToast()
          .showToast("Warning", "Password field can't be empty.", true);
    } else if (password.length < 8) {
      CustomToast()
          .showToast("Warning", "Password must contain 8 characters", true);
    } else if (confirmPassword.isEmpty) {
      CustomToast()
          .showToast("Warning", "Confirm Password field can't be empty.", true);
    } else if (confirmPassword != password) {
      CustomToast().showToast(
          "Warning", "Password and Confirm Password must be same.", true);
    } else {
      if (fromForgetPassword) {
        updatePassword(context, onSuccess: () {
          AppNavigation.navigatorPop(context);
          AppNavigation.navigatorPop(context);
        });
      } else {
        AppNavigation.navigateTo(context, AppRouteName.DriverRegister);
      }
    }
  }

  signUpValidation(context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (firstName.isEmpty) {
      CustomToast()
          .showToast("Warning", "First Name field can't be empty", true);
    } else if (lastName.isEmpty) {
      CustomToast()
          .showToast("Warning", "Last Name field can't be empty", true);
    } else if (dob.isEmpty) {
      CustomToast()
          .showToast("Warning", "Date of birth field can't be empty", true);
    } else if (email.isEmpty) {
      CustomToast().showToast("Warning", "Email field can't be empty", true);
    } else if (!email.trim().isEmail) {
      CustomToast()
          .showToast("Warning", "Please enter valid email address", true);
    } else {
      AppNavigation.navigateTo(context, AppRouteName.CreatePassword);
    }
  }

  driverRegisterationValidation(context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (emiratesId.isEmpty) {
      CustomToast()
          .showToast("Warning", "Emirates ID field can't be empty", true);
    } else if (lastName.isEmpty) {
      CustomToast()
          .showToast("Warning", "Passport Number field can't be empty", true);
    } else {
      userSignUp(context);
    }
  }

  Future<void> userSignUp(context) async {
    Map<String, String> jsonData = {
      "first_name": firstName,
      "last_name": lastName,
      "email": email.toLowerCase().trim(),
      "phone": dialCode + phone,
      "dial_code": dialCode,
      "country_code": countryCode,
      "date_of_birth": dob,
      "type": "host",
      "user_device_type": Platform.isIOS ? "ios" : "android",
      "user_device_token": "233",
      // "user_device_token": SharedPreference().getFcmToken() ?? '',
      "password": password,
      "password_confirmation": password,
    };
    getFiles();
    var res = await b.baseFormPostAPI(
        APIEndpoints.signUp, jsonData, files, fileName,
        loading: true, context: context);
    if (res['success'] == true) {
      loginSuccess(res, context, route: false);
      if (carRegister) {
        AppNavigation.navigateTo(context, AppRouteName.AddCar,
            arguments: ScreenArguments(fromSignup: true));
      } else {
        AppNavigation.navigateToRemovingAll(
            context, AppRouteName.HOME_SCREEN_ROUTE);
      }
      CustomToast().showToast("Success", res['message'], false);
    } else {
      CustomToast().showToast("Error", res['message'], true);
    }
  }

  forgetPasswordValidation(context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (email.isEmpty) {
      CustomToast().showToast("Warning", "Email field can't be empty", true);
    } else if (!email.trim().isEmail) {
      CustomToast().showToast("Warning", "Email is not valid.", true);
    } else {
      forgetPassword(context, onSuccess: () {
        AppNavigation.navigateTo(context, AppRouteName.ENTER_OTP_SCREEN_ROUTE,
            arguments: ScreenArguments(fromForgetPassword: true));
      });
    }
  }

  Future<void> forgetPassword(context, {required Function onSuccess}) async {
    Map jsonData = {
      "email": email,
    };
    var res = await b.basePostAPI(APIEndpoints.forgotPassword, jsonData,
        loading: true, context: context);
    if (res['success'] == true) {
      // userID=res['_id'];
      onSuccess();
      CustomToast().showToast("Success",
          '${res['data']['remember_token']} ${res['message']}', false);
      // CustomToast().showToast("Success", res['message'], false);
    } else {
      CustomToast().showToast("Error", res['message'], true);
    }
  }

  Future<void> updatePassword(context, {required Function onSuccess}) async {
    Map jsonData = {"email": email, "password": password, "cpass": password};
    var res = await b.basePostAPI(APIEndpoints.resetPassword, jsonData,
        loading: true, context: context);
    if (res['success'] == true) {
      onSuccess();
      CustomToast().showToast("Success", res['message'], false);
    } else {
      CustomToast().showToast("Error", res['message'], true);
    }
  }

  // ///OTP Validation
  otpValidation(context,
      {required bool firebase, required bool fromForgetPassword}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (otp.isEmpty) {
      CustomToast()
          .showToast("Warning", "Please enter verification code", true);
    } else if (otp.length < 4) {
      CustomToast()
          .showToast("Warning", "Please enter a valid verification code", true);
    } else {
      verifyOTP(context, fromForgetPassword: fromForgetPassword, onSuccess: () {
        if (fromForgetPassword) {
          AppNavigation.navigateTo(context, AppRouteName.CreatePassword,
              arguments: ScreenArguments(fromForgetPassword: true));
        } else {
          AppNavigation.navigateTo(context, AppRouteName.SIGNUP_SCREEN_ROUTE);
        }
      });
      // if(firebase){verifyFirebaseOTP(context);}
      // else{
      //   verifyOTP(context);
      // }
    }
  }

  Future<void> verifyOTP(context,
      {required Function onSuccess, required bool fromForgetPassword}) async {
    Map jsonData = {
      if (fromForgetPassword)
        "token": int.parse(otp)
      else
        "otp": int.parse(otp),
      if (fromForgetPassword)
        "email": email
      else
        "phone": '+${dialCode + phone}',
    };
    var res = await b.basePostAPI(
        fromForgetPassword
            ? APIEndpoints.verifyOtp
            : APIEndpoints.verifyPhoneOtp,
        jsonData,
        loading: true,
        context: context);
    if (res['success'] == true) {
      AppNavigation.navigatorPop(context);
      onSuccess();
      // loginSuccess(res,context);
    } else {
      CustomToast().showToast("Error", res['message'], true);
    }
  }

  verifyFirebaseOTP(context) async {
    FocusScope.of(context).unfocus();
    SocialAuthBloc social = SocialAuthBloc();
    social.verifyPhoneCode(
      context: context,
      phoneNo: phone,
      dialCode: '+$dialCode',
      verificationId: verificationId,
      verificationCode: otp,
      countryCode: countryCode,
      setProgressBar: () {
        EasyLoading.instance.userInteractions = false;
        EasyLoading.show(status: 'Please wait...', dismissOnTap: false);
      },
      cancelProgressBar: () {
        EasyLoading.dismiss();
      },
    );
  }

  resendFirebaseOTP(context, {required Function onSuccess}) async {
    FocusScope.of(context).unfocus();
    SocialAuthBloc social = SocialAuthBloc();
    social.resendPhoneCode(
      context: context,
      phoneNumber: phone,
      dialCode: '+$dialCode',
      getVerificationId: (v) {
        verificationId = v ?? "";
        onSuccess();
      },
      setProgressBar: () {
        EasyLoading.instance.userInteractions = false;
        EasyLoading.show(status: 'Please wait...', dismissOnTap: false);
      },
      cancelProgressBar: () {
        EasyLoading.dismiss();
      },
    );
  }

  ///ProfileSetup Validation
  editProfile(context,
      {required bool editProfile, required Function onSuccess}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    bool emailLogin =
        GlobalController.values.loginType.value == LoginType.email;
    print(dialCode + phone);
    if (firstName.isEmpty) {
      CustomToast()
          .showToast("Warning", "First Name field can't be empty", true);
    } else if (lastName.isEmpty) {
      CustomToast()
          .showToast("Warning", "Last Name field can't be empty", true);
    }
    // else if (country.isEmpty) {
    //   CustomToast().showToast("Warning", "Country field can't be empty", true);
    // }
    else {
      setProfile(context, onSuccess: onSuccess, editProfile: editProfile);
    }
  }

  setProfile(context,
      {required Function onSuccess, required bool editProfile}) async {
    Map<String, String> jsonData;
    jsonData = {
      "first_name": firstName,
      "last_name": lastName,
      "phone": phone,
      // "address": location,
      // "latitude": lat.toString(),
      // "longitude": lng.toString(),
      "dial_code": dialCode,
      "country_code": countryCode,
      "country": country,
    };
    print(jsonData);
    getFiles();
    var res = await b.baseFormPostAPI(
        editProfile ? APIEndpoints.editProfile : APIEndpoints.editProfile,
        jsonData,
        files,
        fileName,
        loading: true,
        context: context);
    if (res['success'] == true) {
      SharedPreference().setUser(user: jsonEncode(res['data']));
      user.value = User.fromJson(jsonDecode(SharedPreference().getUser()!));
      onSuccess();
    } else {
      CustomToast().showToast("Error", res['message'], true);
    }
  }

  getFiles() {
    fileName = [];
    files = [];
    if (imageProfile.isNotEmpty) {
      fileName.add("profile_image");
      files.add(File(imageProfile));
    }
  }

  Future<String?> checkMerchantVerification(
      {required BuildContext context}) async {
    var r = await b.baseGetAPI(APIEndpoints.merchantAccount,
        loading: true, context: context);
    if (r['data'] == null) {
      CustomToast()
          .showToast("Success", 'Your account has been verified', false);
    }
    return r['data'];
  }

  Future<void> deleteAccount(context) async {
    var res = await b.baseGetAPI(
        APIEndpoints.deleteAccount + AuthController.i.user.value.id,
        loading: true,
        context: context);
    if (res['status'] == 1) {
      Utils.logout(fromLogout: false, c: context);
      CustomToast().showToast("Success", res['message'], false);
    }
  }

  Future<void> getDashboard({loading, required BuildContext context}) async {
    var r = await b.baseGetAPI(APIEndpoints.dashboard,
        loading: loading ?? true, context: context);
    if (r != null) {
      // user.value.avgRating = User.fromJson(r['data']).avgRating;
      user.refresh();
    }
    update();
  }

  RxString userCurrentPosition = "".obs;
  Position? currentPosition;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  getCurrentUserLocation() async {
    final permission = await _geolocatorPlatform.checkPermission();
    log(permission.name);

    if (permission == LocationPermission.denied) {
      final status = await _geolocatorPlatform.requestPermission();

      if (status == LocationPermission.always ||
          status == LocationPermission.whileInUse) {
        _permissionGranted();
      }
    } else if (permission == LocationPermission.deniedForever) {
      // settins();
      _openAppSettings();
    } else {
      _permissionGranted();
    }
  }

  _permissionGranted() async {
    // EasyLoading.instance.userInteractions = false;
    EasyLoading.show(status: 'Please wait...', dismissOnTap: false);
    log("PermissionGranted");
    _geolocatorPlatform.getCurrentPosition().then((position) async {
      userCurrentPosition.value = "${position.latitude},${position.longitude}";
      final address = await Utils.getAddressFromLatLong(
          position.latitude, position.longitude);

      print(address);

      if (address['complete_address'] != null) {
        userCurrentPosition.value = address['complete_address'];
      }

      currentPosition = position;
      update();

      EasyLoading.dismiss();
    }).catchError((onError) {
      print(onError);
      EasyLoading.dismiss();
    });
  }

  listenForPostion() {
    _geolocatorPlatform.getCurrentPosition().then((position) async {
      currentPosition = position;

      userCurrentPosition.value = "${position.latitude},${position.longitude}";

      // final address = await Utils.getAddressFromLatLong(
      //     position.latitude, position.longitude);

      // print(address);

      // if (address['complete_address'] != null) {
      //   userCurrentPosition.value = address['complete_address'];
      // }

      currentPosition = position;
      update();
    });
  }

  void _openAppSettings() async {
    final opened = await _geolocatorPlatform.openAppSettings();
    String displayValue;

    if (opened) {
      displayValue = 'Opened Application Settings.';
    } else {
      displayValue = 'Error opening Application Settings.';
    }

    // _updatePositionList(
    //   _PositionItemType.log,
    //   displayValue,
    // );
  }
}
