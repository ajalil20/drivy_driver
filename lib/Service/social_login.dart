import 'dart:convert';
import 'dart:developer';
import 'package:drivy_user/Controller/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:drivy_user/Utils/app_strings.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Component/custom_toast.dart';



class SocialAuthBloc {
  // SocialLoginBloc _socialLoginBloc = SocialLoginBloc();
  // LoginController controller = Get.find();

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserCredential? _userCredential;
  User? _user;

  ///-------------------- Google Sign In -------------------- ///
  Future<void> signInWithGoogle(
      {BuildContext? mainContext, String? authName}) async {
    // try {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: ['email'],
    );

    GoogleSignInAccount? _googleSignInAccount = await _googleSignIn.signIn();

    if (_googleSignInAccount != null) {
      // log("Access Token"+data.accessToken);
      await _googleSignIn.signOut();
      log("Google Sign in Account"+_googleSignInAccount.toString());
      bool containsSpace=false;
      String fName= _googleSignInAccount.displayName ?? "";
      String lName='';
      if(_googleSignInAccount.displayName!=null){
        containsSpace = _googleSignInAccount.displayName!.contains(" ");
        if(containsSpace){
          fName=_googleSignInAccount.displayName!.split(" ")[0];
          lName=_googleSignInAccount.displayName!.split(" ")[1];
        }
      }

      _socialLoginMethod(
          context: mainContext,
          authName: authName,
          socialToken: _googleSignInAccount.id,
          userFirstName: fName,
          userLastName: lName,
          userEmail: _googleSignInAccount.email,
          userImage: _googleSignInAccount.photoUrl ?? "");
    }
    // }
    // catch (error) {
    //   log(error.toString());
    //   // print(message: error.toString());
    // }
  }


  //////////////////////// Phone Sign In //////////////////////////////////
  Future<void> signInWithPhone(
      {required BuildContext context,
        required String countryCode,
        required String phoneNumber,
        required VoidCallback setProgressBar,
        required VoidCallback onCodeSent,
        required VoidCallback cancelProgressBar}) async {
    try {
      setProgressBar();
      FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: countryCode + phoneNumber,
          timeout: Duration(seconds: 60),
          verificationCompleted: (AuthCredential authCredential) async {
            print("verification completed");
          },
          verificationFailed: (FirebaseAuthException authException) {
            if (authException.code == AppStrings.INVALID_PHONE_NUMBER) {
              cancelProgressBar();
              CustomToast().showToast("Error",AppStrings.INVALID_PHONE_NUMBER_MESSAGE,true);
            } else {
              cancelProgressBar();
              CustomToast().showToast("Error",authException.message.toString(),true);
            }
            //print(authException.message);
          },
          codeSent: (String verificationId, int? forceResendingToken) {
            AuthController.i.verificationId=verificationId;
            //log("Verification Id:${verificationId}");
            cancelProgressBar();
            print("********* OTP_VERIFICATION_SCREEN_ROUTE ***********");
            onCodeSent();
            // AppNavigation.navigateTo(
            //     context, AppRouteName.OTP_VERIFICATION_SCREEN_ROUTE,
            //     arguments: OtpArguments(
            //         otpType: AppStrings.PHONE_OTP_TYPE,
            //         countryCode: countryCode,
            //         phoneNo: phoneNumber,
            //         phoneVerificationId: verificationId));
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            cancelProgressBar();
            log("Timeout Verification id:${verificationId.toString()}");
          });
    } catch (error) {
      log("error");
      cancelProgressBar();
      CustomToast().showToast("Error",error.toString(),true);
    }
  }


  Future<void> verifyPhoneCode(
      {required BuildContext context,
        String? dialCode,
        String? phoneNo,
        String? countryCode,
        required String verificationId,
        required String verificationCode,
        required VoidCallback setProgressBar,
        required VoidCallback cancelProgressBar
      }) async {
    setProgressBar();
    try {
      //print("Verify Phone Code Starts");

      AuthCredential _credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: verificationCode);

      _userCredential = await _firebaseAuth.signInWithCredential(_credential);

      _user = _userCredential?.user;

      if (_user != null) {
        await _firebaseUserSignOut();

        // API Call Here
        _socialLoginMethod(
          context: context,
          phoneNo: phoneNo,
          dialCode: dialCode,
          countryCode: countryCode,
          socialToken: _user?.uid,
          authName: AppStrings.PHONE_SOCIAL_TYPE,
        );
      }
    } on FirebaseAuthException catch (authException) {
      CustomToast().showToast("Error",authException.message.toString(),true);
    } catch (error) {
      CustomToast().showToast("Error",error.toString(),true);

    }
    cancelProgressBar();
  }


  Future<void> resendPhoneCode(
      {required BuildContext context,
        required String dialCode,
        required String phoneNumber,
        required ValueChanged<String?> getVerificationId,
        required VoidCallback setProgressBar,
        required VoidCallback cancelProgressBar}) async {
    setProgressBar();
    try {
      _firebaseAuth.verifyPhoneNumber(
          phoneNumber: dialCode + phoneNumber,
          timeout: Duration(seconds: 60),
          verificationCompleted: (AuthCredential authCredential) async {},
          verificationFailed: (FirebaseAuthException authException) {
            cancelProgressBar();
            CustomToast().showToast("Error",authException.message.toString(),true);
            //print(authException.message);
          },
          codeSent: (String verificationId, int? forceResendingToken) {
            cancelProgressBar();
            CustomToast().showToast("Success",AppStrings.RESEND_CODE_PHONE_NUMBER,false);
            getVerificationId(verificationId);
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            log(verificationId.toString());
          });
    } catch (error) {
      cancelProgressBar();
      CustomToast().showToast("Error",error.toString(),true);
    }
  }

  ///-------------------- Sign Out -------------------- ///
  Future<void> _firebaseUserSignOut() async {
    await _firebaseAuth.signOut();
  }



  ///-------------------- Facebook Sign In -------------------- ///
  // Future<void> signInWithFacebook({BuildContext? mainContext, String? authName}) async {
  //   try {
  //     final LoginResult result = await FacebookAuth.instance.login(
  //       permissions: ['public_profile', 'email'],
  //     );
  //     if (result.status == LoginStatus.success) {
  //       final AccessToken? accessToken = result.accessToken;
  //
  //       final graphResponse = await http.get(Uri.parse(
  //           'https://graph.facebook.com/v2.12/me?fields=name,picture.width(800).height(800),first_name,last_name,email&access_token=${accessToken!.token}'));
  //
  //       log("Graph response" + graphResponse.body.toString());
  //       await FacebookAuth.instance.logOut();
  //
  //       final String? fbGraphResponse = graphResponse.body;
  //
  //       if(fbGraphResponse != null)
  //       {
  //         FacebookGraphModel _fbGraphModel = FacebookGraphModel.fromJson(jsonDecode(fbGraphResponse));
  //
  //         _socialLoginMethod(
  //             context: mainContext,
  //             authName: authName,
  //             socialToken: _fbGraphModel.id,
  //             userFirstName: _fbGraphModel.name ?? "",
  //             userLastName: "",
  //             userEmail: _fbGraphModel.email ?? "",
  //             userImage: _fbGraphModel.picture?.data?.url ?? "");
  //
  //       }
  //
  //
  //     } else if (result.status == LoginStatus.failed) {
  //       print(result.message.toString());
  //       //print(result.message.toString());
  //     } else if (result.status == LoginStatus.cancelled) {
  //       print(result.message.toString());
  //       //print(result.message.toString());
  //     }
  //   } catch (error) {
  //     print(error.toString());
  //     print(error.toString());
  //   }
  // }

  ///-------------------- Apple Sign In --------------------  ///

  Future<void> signInWithApple(
      {BuildContext? mainContext, String? authName}) async {
    try {
      log("apple data");
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      if (credential != null) {
        // log("Apple Credentail:${credential}");
        // log("Auth text:${authName}");
        // log("Social Token:${credential.userIdentifier}");
        // log("User Name:${credential.givenName}");
        // log("family Name:${credential.familyName}");
        // log("Email Name:${credential.email}");

        _socialLoginMethod(
            context: mainContext,
            authName: authName,
            socialToken: credential.userIdentifier,
            userFirstName: credential.givenName ?? "",
            userLastName: credential.familyName ?? "",
            userEmail: credential.email ?? "",
            userImage: "");
      }
    } catch (error) {
      print(error.toString());
      print(error.toString());
    }
  }

  void _socialLoginMethod(
      {BuildContext? context,
        String? authName,
        String? socialToken,
        String? userFirstName,
        String? userLastName,
        String? phoneNo,
        String? dialCode,
        String? countryCode,
        String? userEmail,
        String? userImage}) {
    log("data");
    log("authName:$authName");
    log("socialToken:$socialToken");
    log("userFirstName:$userFirstName");
    log("userLastName: $userLastName");
    log("userEmail:$userEmail");
    log("userImage:$userImage");
     AuthController.i.socialLogin(context,email:userEmail,socialToken: socialToken,socialType: authName,firstName: userFirstName,lastName: userLastName,phone: phoneNo,dialCode:dialCode,countryCode:countryCode);
  }


}

class FacebookGraphModel {
  FacebookGraphModel({
    this.name,
    this.picture,
    this.firstName,
    this.lastName,
    this.email,
    this.id,
  });

  String? name;
  Picture? picture;
  String? firstName;
  String? lastName;
  String? email;
  String? id;

  factory FacebookGraphModel.fromJson(Map<String, dynamic> json) => FacebookGraphModel(
    name: json["name"],
    picture: json["picture"] != null ? Picture.fromJson(json["picture"]) : null,
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "picture": picture!.toJson(),
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "id": id,
  };
}

class Picture {
  Picture({
    this.data,
  });

  Data? data;

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
    data: json["data"] != null ? Data.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.height,
    this.isSilhouette,
    this.url,
    this.width,
  });

  int? height;
  bool? isSilhouette;
  String? url;
  int? width;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    height: json["height"] ?? 0,
    isSilhouette: json["is_silhouette"] ?? true,
    url: json["url"],
    width: json["width"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "height": height,
    "is_silhouette": isSilhouette,
    "url": url,
    "width": width,
  };
}