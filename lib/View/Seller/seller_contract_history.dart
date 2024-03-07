import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:drivy_user/Component/custom_buttom.dart';
import 'package:drivy_user/Component/custom_card.dart';
import 'package:drivy_user/Component/custom_switch.dart';
import 'package:drivy_user/Component/custom_text.dart';
import 'package:drivy_user/Component/custom_toggle_bar.dart';
import 'package:drivy_user/Controller/auth_controller.dart';
import 'package:drivy_user/Controller/home_controller.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/app_router_name.dart';
import 'package:drivy_user/Utils/image_path.dart';
import 'package:drivy_user/View/User/More/payment_settings.dart';
import 'package:flutter/material.dart';
import 'package:drivy_user/View/Widget/Dialog/delete_account.dart';
import '../../../../../Utils/my_colors.dart';
import '../../../../../Utils/responsive.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../base_view.dart';
import '../User/More/change_password.dart';


class SellerContractHistory extends StatefulWidget {
  const SellerContractHistory({super.key});

  @override
  State<SellerContractHistory> createState() => _SellerContractHistoryState();
}

class _SellerContractHistoryState extends State<SellerContractHistory> {
  bool val = false;

  @override
  Widget build(BuildContext context) {
    return BaseView(
        screenTitle: 'Settings',
        showAppBar: true,
        showBackButton: true,
        resizeBottomInset: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              CustomCard(
                  padding: EdgeInsets.all(3.5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(ImagePath.notification,color: MyColors().pinkColor,scale: 4,),
                          SizedBox(width: 2.w,),
                          MyText(title: 'Push Notification',size: 12,),
                        ],
                      ),
                      CustomSwitch(switchValue: val.obs,onChange: (v){},),

                    ],)),
              SizedBox(height: 1.h,),
              GestureDetector(
                onTap: (){
                  AppNavigation.navigateTo(context, AppRouteName.ALL_CARDS_ROUTE);
                },
                child: CustomCard(
                    padding: EdgeInsets.all(3.5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(title: 'Payment Settings',size: 12,),
                        Icon(Icons.chevron_right_rounded,color: MyColors().darkGreyColor,)
                      ],)),
              ),
              SizedBox(height: 2.h,),
              MyButton(
                title: "Delete Account",
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
                            content: DeleteDialog(title: 'Delete Account',subTitle: 'Do you want to delete your account?',onYes: (){},),
                          ),
                        );
                      }
                  );
                },
              )

            ],
          ),
        )
    );
  }
}