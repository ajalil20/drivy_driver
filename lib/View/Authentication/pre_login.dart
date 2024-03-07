import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:drivy_user/Component/Appbar/appbar_components.dart';
import 'package:drivy_user/Component/custom_background_image.dart';
import 'package:drivy_user/Component/custom_padding.dart';
import 'package:drivy_user/Component/custom_terms_condition.dart';
import 'package:drivy_user/Component/custom_toast.dart';
import 'package:drivy_user/Component/title.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Service/social_login.dart';
import 'package:drivy_user/Utils/app_router_name.dart';
import 'package:drivy_user/Utils/app_strings.dart';
import 'package:drivy_user/Utils/enum.dart';
import 'package:drivy_user/Utils/image_path.dart';
import 'package:drivy_user/Utils/my_colors.dart';
import 'package:drivy_user/View/Widget/appLogo.dart';
import '../../Component/custom_buttom.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io' show Platform;
import 'package:sizer/sizer.dart';

import '../../Controller/global_controller.dart';
import '../../Utils/utils.dart';

class PreLoginScreen extends StatelessWidget {
  const PreLoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackgroundImage(
        child: CustomPadding(
          topPadding: 6.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(alignment: Alignment.centerLeft, child: CustomBackButton(color: MyColors().whiteColor,)),
              SizedBox(height: 3.h,),
              AppLogo(onTap: (){},),
              SizedBox(
                height: 12.h,
              ),
              ScreenTitle(title: 'Social Login'),
              SizedBox(
                height: 2.h,
              ),
              MyButton(
                  title: 'Sign in with Email',
                  showPrefix: true,
                  prefixImage:ImagePath.emailIcon,
                  prefixIconSize: 4,
                  prefixIconColor: MyColors().pinkColor,
                  bgColor: MyColors().whiteColor,
                  textColor: MyColors().black,
                  onTap: () {
                    onTap(context,l: LoginType.email);
                    AppNavigation.navigateTo(context, AppRouteName.LOGIN_SCREEN_ROUTE,);
                  }),
              SizedBox(
                height: 2.h,
              ),
              MyButton(
                  title: 'Sign in with phone',
                  showPrefix: true,
                  prefixImage:ImagePath.phoneIcon,
                  onTap: () {
                    onTap(context,l: LoginType.phone);
                    AppNavigation.navigateTo(context, AppRouteName.PHONE_LOGIN_SCREEN_ROUTE,);
                  }),

              SizedBox(
                height: 2.h,
              ),
              MyButton(
                  title: 'Sign in with google',
                  bgColor: MyColors().purpleLight,
                  gradient: false,
                  showPrefix: true,
                  prefixImage:ImagePath.googleIcon,
                  prefixIconColor: MyColors().whiteColor,
                  onTap: () {
                    onTap(context,l: LoginType.social);
                    // CustomToast().showToast("Success", "Login Successfully", false);
                    // AppNavigation.navigateTo(context, AppRouteName.HOME_SCREEN_ROUTE,);
                    SocialAuthBloc social = SocialAuthBloc();
                    social.signInWithGoogle(mainContext: context,authName: AppStrings.GOOGLE);
                  }),
              if (Platform.isIOS)...[
                SizedBox(
                  height: 2.h,
                ),
                MyButton(
                    title: 'Sign in with Apple',
                    bgColor: MyColors().black,
                    showPrefix: true,
                    gradient: false,
                    prefixImage:ImagePath.appleIcon,
                    prefixIconColor: MyColors().whiteColor,
                    onTap: () {
                      onTap(context,l: LoginType.social);
                      SocialAuthBloc social = SocialAuthBloc();
                      social.signInWithApple(mainContext: context,authName: AppStrings.APPLE);
                    }),
              ],
              const Spacer(),
              CustomTermsCondition(),
              SizedBox(
                height: 4.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
  onTap(context,{required LoginType l}){
    Utils().saveFCMToken();
    GlobalController.values.loginType.value = l;
  }
}
