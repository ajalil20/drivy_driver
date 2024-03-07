import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:drivy_user/Component/custom_buttom.dart';
import 'package:drivy_user/Component/custom_card.dart';
import 'package:drivy_user/Component/custom_switch.dart';
import 'package:drivy_user/Component/custom_text.dart';
import 'package:drivy_user/Component/custom_toast.dart';
import 'package:drivy_user/Component/custom_toggle_bar.dart';
import 'package:drivy_user/Controller/auth_controller.dart';
import 'package:drivy_user/Controller/home_controller.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/app_router_name.dart';
import 'package:drivy_user/Utils/image_path.dart';
import 'package:drivy_user/View/User/More/payment_settings.dart';
import 'package:flutter/material.dart';
import 'package:drivy_user/View/Widget/Dialog/delete_account.dart';
import '../../../../../../Utils/my_colors.dart';
import '../../../../../../Utils/responsive.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../../Arguments/content_argument.dart';
import '../../../Controller/global_controller.dart';
import '../../../Utils/app_strings.dart';
import '../../../Utils/enum.dart';
import '../../base_view.dart';
import 'change_password.dart';


class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool notification = false;
  bool night = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        screenTitle: 'Settings',
        showAppBar: true,
        centerTitle: false,
        showBackButton: true,
        resizeBottomInset: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              SizedBox(height: 2.h,),
              GestureDetector(
                onTap: (){
                  AppNavigation.navigateTo(context, AppRouteName.ChangePassword);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(title: 'Change Password',size: 14,fontWeight: FontWeight.w600,),
                    Row(
                      children: [
                        MyText(title: '**********',size: 14,fontWeight: FontWeight.w600,clr: MyColors().primaryColor,),
                        Icon(Icons.chevron_right_rounded,color: MyColors().primaryColor,)
                      ],
                    ),
                ],),
              ),
              SizedBox(height: 2.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(title: 'Notification',size: 14,fontWeight: FontWeight.w600,),
                  CustomSwitch(switchValue: notification.obs,onChange: (v){},),
              ],),
              SizedBox(height: 2.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(title: 'Night Mode',size: 14,fontWeight: FontWeight.w600,),
                  CustomSwitch(switchValue: night.obs,onChange: (v){},),
              ],),
              SizedBox(height: 2.h,),
              GestureDetector(
                onTap: (){
                  AppNavigation.navigateTo(context, AppRouteName.CONTENT_SCREEN,
                      arguments: ContentRoutingArgument(
                          title:'Terms & Conditions',
                          contentType: AppStrings.TERMS_AND_CONDITION_TYPE,
                          url: 'https://www.google.com/'));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(title: 'Terms & Conditions',size: 14,fontWeight: FontWeight.w600,),
                    Icon(Icons.chevron_right_rounded,color: MyColors().primaryColor,)
                  ],),
              ),
              SizedBox(height: 2.h,),
              GestureDetector(
                onTap: (){
                  AppNavigation.navigateTo(context, AppRouteName.CONTENT_SCREEN,
                      arguments: ContentRoutingArgument(
                          title:'Privacy Policy',
                          contentType: AppStrings.PRIVACY_POLICY_TYPE,
                          url: 'https://www.google.com/'));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(title: 'Privacy Policy',size: 14,fontWeight: FontWeight.w600,),
                    Icon(Icons.chevron_right_rounded,color: MyColors().primaryColor,)
                  ],),
              ),
              Spacer(),
              SizedBox(height: 2.h,),
              GestureDetector(
                onTap: (){
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: AlertDialog(
                            backgroundColor: Colors.transparent,
                            contentPadding: const EdgeInsets.fromLTRB(
                                0, 0, 0, 0),
                            content: DeleteDialog(title: 'Delete Account',subTitle: 'Do you want to delete your account?',onYes: (){
                              AuthController.i.deleteAccount(context);
                            },),
                          ),
                        );
                      }
                  );
                },
                child: MyText( title: "Delete Account",clr: MyColors().greyColor.withOpacity(.5),size: 16,fontWeight: FontWeight.w600,under: true,),
              )

            ],
          ),
        )
    );
  }

  getData(){
    if(AuthController.i.user.value.isNotification==true){
      // val=true;
    }
  }
}