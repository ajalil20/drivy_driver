import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:drivy_user/Arguments/screen_arguments.dart';
import 'package:drivy_user/Component/custom_text.dart';
import 'package:drivy_user/Controller/auth_controller.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/app_router_name.dart';
import 'package:drivy_user/Utils/my_colors.dart';
import 'package:drivy_user/Utils/utils.dart';
import 'package:drivy_user/View/Widget/Dialog/profile_update_dialog.dart';
import 'package:drivy_user/Component/custom_icon_container.dart';
import 'package:drivy_user/Utils/image_path.dart';
import 'package:drivy_user/View/Widget/search_tile.dart';
import 'package:sizer/sizer.dart';

class MenuIcon extends StatelessWidget {
  const MenuIcon({super.key});
  @override
  Widget build(BuildContext context) {
    // return Padding(padding: EdgeInsets.only(top: 1.h, bottom: 1.h,left: 4.w,right: 0.h), child: Container(decoration: BoxDecoration( borderRadius: BorderRadius.circular(6),), child: IconContainer(image: ImagePath.menuIcon, onTap: (){AuthController.i.zoom.toggle?.call();},size: 6.w,padding: 1.8.w,)),);
    return IconContainer(image: ImagePath.menuIcon, onTap: (){
      FocusManager.instance.primaryFocus?.unfocus();AuthController.i.zoom.toggle?.call();});
  }
}

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
      // return Padding(padding: EdgeInsets.only(top: 7, bottom: 7,left: 7,right: 10), child: Container(decoration: BoxDecoration( borderRadius: BorderRadius.circular(6),), child: IconContainer(image: ImagePath.notificationIcon, onTap: (){},size: 7.w,padding: 2.2.w,)),);
    // return Padding(padding: EdgeInsets.only(top: .6.h, bottom: .6.h,left: 4.w,right: 4.w), child: Container(decoration: BoxDecoration( borderRadius: BorderRadius.circular(6),), child: IconContainer(image: ImagePath.notificationIcon, onTap: (){},size: 7.w,padding: 2.2.w,)),);
    return IconContainer(image: ImagePath.notificationIcon, onTap: (){AppNavigation.navigateTo(context, AppRouteName.NOTIFICATION_SCREEN_ROUTE);});
  }
}

class ChatIcon extends StatelessWidget {
  ChatIcon({super.key,this.onTap});
  Function? onTap;

  @override
  Widget build(BuildContext context) {
     return IconContainer(image: ImagePath.chatIcon, onTap: (){if(onTap!=null){onTap!();}else{AppNavigation.navigateTo(context, AppRouteName.MESSAGE_SCREEN_ROUTE);}});
  }
}

class EditProfileIcon extends StatelessWidget {
  const EditProfileIcon({super.key});

  @override
  Widget build(BuildContext context) {
    // return Padding(padding: EdgeInsets.only(top: 7, bottom: 7,left: 7,right: 10), child: Container(decoration: BoxDecoration( borderRadius: BorderRadius.circular(6),), child: IconContainer(image: ImagePath.notificationIcon, onTap: (){},size: 7.w,padding: 2.2.w,)),);
    // return Padding(padding: EdgeInsets.only(top: .6.h, bottom: .6.h,left: 4.w,right: 4.w), child: Container(decoration: BoxDecoration( borderRadius: BorderRadius.circular(6),), child: IconContainer(image: ImagePath.notificationIcon, onTap: (){},size: 7.w,padding: 2.2.w,)),);
    return IconContainer(image: ImagePath.editIcon, onTap: (){
      Utils().setUserLoginType(AuthController.i.user.value.userSocialType);
      AppNavigation.navigateTo(context, AppRouteName.COMPLETE_PROFILE_SCREEN_ROUTE,arguments: ScreenArguments(fromEdit: true));
    },);
  }
}

class CustomBackButton extends StatelessWidget {
  CustomBackButton({super.key,this.color});
  Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        AppNavigation.navigatorPop(context);
      },
      child: Container(
        padding: EdgeInsets.all(2.5.w),
        decoration: BoxDecoration(
          color: MyColors().whiteColor,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 7,
              blurRadius: 10,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.black,
          size: 18.sp,
        ),
      ),
    );
  }
}


class FilterIcon extends StatelessWidget {
  FilterIcon({super.key,this.onTap});
  Function? onTap;
  @override
  Widget build(BuildContext context) {
    return IconContainer(image: ImagePath.filterIcon, onTap: (){if(onTap!=null){onTap!();}},padding: 3.4.w ,);
  }
}

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconContainer(image: ImagePath.cart, onTap: (){AppNavigation.navigateTo(context, AppRouteName.CART_ROUTE);});
  }
}


class CustomAppBar extends StatelessWidget {
  CustomAppBar({super.key,this.horizontal=0,this.top=0,this.bottom=0,this.screenTitle='',this.leading,this.trailing});
  double horizontal,top,bottom;
  String screenTitle;
  Widget? leading,trailing;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal,)+EdgeInsets.only(top: top,bottom:bottom),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leading??SizedBox(),

              trailing??SizedBox(),
            ],),
          Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: MyText(title:  screenTitle,
                center: true,
                line: 1,
                size: 16,
                // toverflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w700,
                clr: MyColors().titleColor),
              ))
        ],
      ),
    );
  }
}
