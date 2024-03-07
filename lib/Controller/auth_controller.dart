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
import 'package:get/get.dart';
import 'package:drivy_driver/Component/custom_toast.dart';
import 'package:drivy_driver/Utils/utils.dart';
import '../Arguments/screen_arguments.dart';
import '../Service/api_endpoints.dart';

class AuthController extends GetxController{
  static AuthController get i => Get.find();
  BaseService b = BaseService();
  Rx<User> user = User().obs;
  String userID="",imageProfile="",firstName="",lastName="", email="", otp="", location="",dialCode="+971", phone="",password="",countryCode="AE", dob="",fb='',twitter='',noInstagramFollowers='',noTwitterFollowers='',verificationId="";
  double lat=0,lng=0;
  bool isMerchantSetupDone = false;
  List fileName=[],files =[];

  // Rx<File> imageProfile = File("").obs, resume = File("").obs;

  ///Login Validation
  loginValidation(context,{required bool isEmail}) async {
    AppNavigation.navigateToRemovingAll(context, AppRouteName.HOME_SCREEN_ROUTE);
    // AppNavigation.navigateTo(context, AppRouteName.ENTER_OTP_SCREEN_ROUTE,arguments: ScreenArguments(isFirebase: false));
    FocusManager.instance.primaryFocus?.unfocus();
    if(isEmail){if (email.isEmpty) {
      CustomToast().showToast("Warning", "Email field can't be empty", true);
    } else if (!email.trim().isEmail) {
      CustomToast().showToast("Warning", "Please enter valid email address", true);
    }else if (password.isEmpty) {
      CustomToast().showToast("Warning", "Password field can't be empty.", true);
    } else if (password.length < 8) {
      CustomToast().showToast("Warning", "Password is incorrect.", true);
    } else {
      userLogin(context,onSuccess: (){
        AppNavigation.navigateTo(context, AppRouteName.ENTER_OTP_SCREEN_ROUTE,arguments: ScreenArguments(isFirebase: false));
      });
    }}else{
      if (phone.isEmpty) {
        CustomToast().showToast("Error", 'Phone number field can\'t be empty', true);
      }else if (!(dialCode+phone).isPhoneNumber) {
        CustomToast().showToast("Error", 'Invalid phone number', true);
      }else if (password.isEmpty) {
        CustomToast().showToast("Warning", "Password field can't be empty.", true);
      } else if (password.length < 8) {
        CustomToast().showToast("Warning", "Password is incorrect.", true);
      }else {
        userLogin(context,onSuccess: (){
          AppNavigation.navigateTo(context, AppRouteName.ENTER_OTP_SCREEN_ROUTE,arguments: ScreenArguments(isFirebase: false));
        });
      }
    }
  }
  phoneLoginValidation(context) async {
    FocusScope.of(context).unfocus();
    if (phone.isEmpty) {
      CustomToast().showToast("Error", 'Phone number field can\'t be empty', true);
    }else if (!(dialCode+phone).isPhoneNumber) {
      CustomToast().showToast("Error", 'Invalid phone number', true);
    } else{
      print(dialCode+phone);
      AppNavigation.navigateTo(context, AppRouteName.ENTER_OTP_SCREEN_ROUTE,arguments: ScreenArguments(isFirebase: true));
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

  Future<void> userLogin(context,{required Function onSuccess}) async {
    // Map jsonData = {
    //   "email": email.toLowerCase().trim(),
    //   "role":GlobalController.values.userRole.value.name,
    //   "user_device_type": Platform.isIOS?"ios":"android",
    //   "user_device_token": SharedPreference().getFcmToken(),
    // };
    // var res =await b.basePostAPI(APIEndpoints.login, jsonData, loading: true,context: context);
    // if(res['status']==1){
    //   userID=res['data']['_id'];
    //   onSuccess();
    //   // loginSuccess(res);
    // }
    // else{
    //   CustomToast().showToast("Error",res['message'], true);
    // }
  }
  Future<void> socialLogin(context,{email,socialType,socialToken,String? firstName,String? lastName,String? phone,String? dialCode,String? countryCode}) async {
    Map jsonData = {
      "user_device_type": Platform.isIOS?"ios":"android",
      "user_social_token": socialToken,
      "user_social_type": socialType,
      "role":GlobalController.values.userRole.value.name,
      "user_device_token": SharedPreference().getFcmToken(),
      if(phone!=null)
      "phone_number": phone,
      if(dialCode!=null)
      "dial_code": dialCode,
      if(countryCode!=null)
      "country_code": countryCode,
      if(firstName!=null)
      "first_name" : firstName,
      if(lastName!=null)
      "last_name" : lastName,
    };
    print(jsonData);
    var res =await b.basePostAPI(APIEndpoints.socialLogin, jsonData, loading: true,context: context);
    if(res['status']==1){
      loginSuccess(res,context);
    }
    else{
      if(socialType==AppStrings.PHONE){AppNavigation.navigatorPop(context);}
      CustomToast().showToast("Error",res['message'], true);
    }
  }
  loginSuccess(res,context){
    SharedPreference().setBearerToken(token: res["data"]["user_authentication"]);
    SharedPreference().setUser(user: jsonEncode(res['data']));
    AuthController.i.user.value =User.fromJson(jsonDecode(SharedPreference().getUser()!));
    Utils().setUserRole(AuthController.i.user.value.role);
    log("loginSuccess");
    Utils().goToRoute(context: context, user:AuthController.i.user.value,isLogin: true);


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
    var res =await b.basePostAPI(APIEndpoints.logout, {'user_id':user.value.id}, loading: true,context: context);
  }

  ///SignUp Validation
  signUpValidation(context)async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (firstName.isEmpty) {
      CustomToast().showToast("Warning", "First Name field can't be empty", true);
    }else if (lastName.isEmpty) {
      CustomToast().showToast("Warning", "Last Name field can't be empty", true);
    } else if (email.isEmpty) {
      CustomToast().showToast("Warning", "Email field can't be empty", true);
    } else if (!email.trim().isEmail) {
      CustomToast().showToast("Warning", "Please enter valid email address", true);
    } else {
      // userSignUp(context);
    }
  }
  Future<void> userSignUp(context) async {
    Map jsonData = {
    "first_name" : firstName,
    "last_name" : lastName,
    "email": email.toLowerCase().trim(),
    "role":GlobalController.values.userRole.value.name,
    "user_device_type": Platform.isIOS?"ios":"android",
    "user_device_token": SharedPreference().getFcmToken(),
    };
    var res =await b.basePostAPI(APIEndpoints.signUp, jsonData, loading: true,context: context);
    if(res['status']==1)
      {
        userID=res['data']['_id'];
        CustomToast().showToast("Success", res['message'], false);
        AppNavigation.navigateTo(context, AppRouteName.ENTER_OTP_SCREEN_ROUTE,);
      }
    else{
      CustomToast().showToast("Error", res['message'], true);
    }
  }

  // ///OTP Validation
  Future<void> resendOTP(context,{required Function onSuccess}) async {
    var res =await b.basePostAPI(APIEndpoints.resendOTP, {"user_id":userID}, loading: true,context: context);
    if(res['status']==1){onSuccess();}
    else{CustomToast().showToast("Error", res['message'], true);}
  }

  // ///OTP Validation
  otpValidation(context,{required bool firebase,required bool fromForgetPassword})async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (otp.isEmpty) {CustomToast().showToast("Warning", "Please enter verification code", true);}
    else if (otp.length<4) {CustomToast().showToast("Warning", "Please enter a valid verification code", true);}
    else {
      if(fromForgetPassword){
        AppNavigation.navigatorPop(context);
        AppNavigation.navigateTo(context, AppRouteName.CreatePassword,arguments: ScreenArguments(fromForgetPassword: true));
      }
      else{
        AppNavigation.navigateTo(context, AppRouteName.SIGNUP_SCREEN_ROUTE);
      }
      // if(firebase){verifyFirebaseOTP(context);}
      // else{
      //   verifyOTP(context);
      // }
    }
  }
  Future<void> verifyOTP(context) async {
    Map jsonData = {"verification_code": int.parse(otp),"user_id":userID};
    var res =await b.basePostAPI(APIEndpoints.verifyOtp, jsonData, loading: true,context: context);
    if(res['status']==1){
      AppNavigation.navigatorPop(context);
      loginSuccess(res,context);

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
    else{
      CustomToast().showToast("Error", res['message'], true);
    }
  }

  verifyFirebaseOTP(context) async {
    FocusScope.of(context).unfocus();
    SocialAuthBloc social = SocialAuthBloc();
    social.verifyPhoneCode(context: context,phoneNo: phone,dialCode: '+$dialCode',verificationId:verificationId,verificationCode:otp,countryCode: countryCode,setProgressBar:(){
      EasyLoading.instance.userInteractions=false;
      EasyLoading.show(status: 'Please wait...',dismissOnTap: false);
    },cancelProgressBar: (){EasyLoading.dismiss();},);
  }
  resendFirebaseOTP(context,{required Function onSuccess}) async {
    FocusScope.of(context).unfocus();
    SocialAuthBloc social = SocialAuthBloc();
    social.resendPhoneCode(context: context,phoneNumber: phone,dialCode: '+$dialCode',getVerificationId:(v){verificationId=v??"";onSuccess();},
      setProgressBar:(){
        EasyLoading.instance.userInteractions=false;
        EasyLoading.show(status: 'Please wait...',dismissOnTap: false);
      },cancelProgressBar: (){EasyLoading.dismiss();},
    );
  }

  ///ProfileSetup Validation
  profileSetupValidation(context,{required bool editProfile,required Function onSuccess})async {
    FocusManager.instance.primaryFocus?.unfocus();
    bool emailLogin = GlobalController.values.loginType.value==LoginType.email;
    print(dialCode+phone);
    // bool phoneLogin = GlobalController.values.loginType.value==LoginType.phone;
    { if (firstName.isEmpty) {
        CustomToast().showToast("Warning", "First Name field can't be empty", true);
      }else if (lastName.isEmpty) {
        CustomToast().showToast("Warning", "Last Name field can't be empty", true);
      } else if (dob.isEmpty) {
        CustomToast().showToast("Warning", "Date of birth field can't be empty", true);
      } else if (location.isEmpty) {
        CustomToast().showToast("Warning", "Location field can't be empty", true);
      } else if (phone.isEmpty) {
        CustomToast().showToast("Warning", "Phone number field can't be empty", true);
      }
    //   else if (phone.length!=10) {
    //   CustomToast().showToast("Error", "Invalid phone", true);
    // }
    else if (!(dialCode+phone).isPhoneNumber) {
        CustomToast().showToast("Warning", "Invalid phone number", true);
      } else if (fb.isNotEmpty && !fb.isURL) {
        CustomToast().showToast("Warning", "Enter valid facebook url", true);
      } else if (twitter.isNotEmpty && !twitter.isURL) {
        CustomToast().showToast("Warning", "Enter valid twitter url", true);
      } else if (email.isEmpty && emailLogin) {
        CustomToast().showToast("Warning", "Email field can't be empty", true);
      } else if (!email.isEmail && emailLogin) {
        CustomToast().showToast("Warning", "Enter valid email", true);
      } else{if (isMerchantSetupDone==false && editProfile==false && GlobalController.values.userRole.value!=UserRole.user) {
      CustomToast().showToast("Error", "Merchant account setup is required", true);
      } else {
      setProfile(context,onSuccess: onSuccess,editProfile:editProfile);
      }}
    }

  }
  setProfile(context,{required Function onSuccess,required bool editProfile}) async {
    Map<String,String> jsonData;
    jsonData = {
      'id':userID,
      "first_name": firstName,
      "last_name": lastName,
      "phone_number": phone,
      "address": location,
      "latitude": lat.toString(),
      "longitude": lng.toString(),
      "dial_code":dialCode,
      "country_code":countryCode,
      "dob":dob,
      'facebook':fb,
      'twitter':twitter,
      'no_insta_follower':noInstagramFollowers,
      'no_twitter_follower':noTwitterFollowers
    };
    print(jsonData);
    getFiles();
    var res =await b.baseFormPostAPI(editProfile? APIEndpoints.editProfile:APIEndpoints.completeProfile, jsonData,files,fileName,loading: true,context: context);
    if(res['status']==1){
      SharedPreference().setUser(user: jsonEncode(res['data']));
      user.value =User.fromJson(jsonDecode(SharedPreference().getUser()!));
      onSuccess();
    }
    else{
      CustomToast().showToast("Error",res['message'], true);
    }
  }
  getFiles(){
    fileName=[];files =[];
    if(imageProfile.isNotEmpty)
    {fileName.add("user_image");files.add(File(imageProfile));}
  }

  Future<String?> checkMerchantVerification({required BuildContext context}) async {
    var r = await b.baseGetAPI(APIEndpoints.merchantAccount, loading: true,context: context);
    if(r['data']==null){CustomToast().showToast("Success", 'Your account has been verified', false);}
    return r['data'];
  }

  Future<void> deleteAccount(context) async {
    var res = await b.baseGetAPI(APIEndpoints.deleteAccount+AuthController.i.user.value.id, loading: true,context: context);
    if (res['status'] == 1) {
      Utils.logout(fromLogout: false, c: context);
      CustomToast().showToast("Success", res['message'], false);
    }
  }
  Future<void> getDashboard({loading,required BuildContext context}) async   {
    var r = await b.baseGetAPI(APIEndpoints.dashboard,loading: loading??true,context: context);
    if(r!=null){
      user.value.followers = User.fromJson(r['data']).followers;
      user.value.following = User.fromJson(r['data']).following;
      user.value.avgRating = User.fromJson(r['data']).avgRating;
      user.refresh();
    }
    update();
  }
}
