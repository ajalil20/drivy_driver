import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:drivy_user/Arguments/content_argument.dart';
import 'package:drivy_user/Component/custom_card.dart';
import 'package:drivy_user/Component/custom_image.dart';
import 'package:drivy_user/Component/custom_text.dart';
import 'package:drivy_user/Controller/auth_controller.dart';
import 'package:drivy_user/Controller/global_controller.dart';
import 'package:drivy_user/Model/menu_model.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/app_router_name.dart';
import 'package:drivy_user/Utils/app_strings.dart';
import 'package:drivy_user/Utils/enum.dart';
import 'package:drivy_user/Utils/image_path.dart';
import 'package:drivy_user/Utils/my_colors.dart';
import 'package:drivy_user/Utils/utils.dart';
import 'package:drivy_user/View/Widget/Dialog/logout.dart';
import 'package:sizer/sizer.dart';
import 'package:drivy_user/View/home_view.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 100.w,
        padding: EdgeInsets.symmetric(vertical: 7.h),
        child: Obx(()=> Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                shape: CircleBorder(),
                elevation: 3,
                color: MyColors().whiteColor,
                child:  Padding(
                  padding: EdgeInsets.all(1.w),
                  child: CustomImage(
                    height: 23.w,
                    width: 23.w,
                    isProfile: true,
                    photoView: false,
                    url: AuthController.i.user.value.userImage,
                    radius: 100,
                  ),
                ),

              ),
              SizedBox(height: 1.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w)+EdgeInsets.only(right: 2.w),
                child: Column(
                  children: [
                    MyText(title: '${AuthController.i.user.value.firstName} ${AuthController.i.user.value.lastName}',size: 16,fontWeight: FontWeight.w600,),
                    MyText(title: AuthController.i.user.value.email,size: 13),
                  ],
                ),
              ),
              showList(l:user?userList:seller?sellerList:influencer?influencerList:userList),
              SizedBox(height: 5.h,),
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: (){
                    logoutAlert(context);
                  },
                  child: Container(
                    width: 46.w,
                    decoration: BoxDecoration(
                        color: MyColors().pinkColor,
                        borderRadius: const BorderRadius.only(topRight: Radius.circular(12),bottomRight: Radius.circular(12))
                    ),
                    alignment: Alignment.center,
                    child:Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.5.h,horizontal: 5.w),
                      child:  MyText(
                        title:'Logout',
                        clr: MyColors().whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  showList({required List<MenuModel> l}){
    return Padding(
      padding: EdgeInsets.only(left: 5.w,top: 1.h),
      child: ListView.separated(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: l.length,
          itemBuilder: (context,index){
            return InkWell(
                onTap: (){l[index].onTap!(context);
                FocusManager.instance.primaryFocus?.unfocus();
                AuthController.i.zoom.toggle?.call();
                  },
                child: Row(children: [
                  Image.asset(l[index].image!,width: 5.w,height: 5.w,color: MyColors().purpleColor,),
                  SizedBox(width: 3.w,),
                  MyText(title: l[index].name!,clr: MyColors().purpleColor,fontWeight: FontWeight.w500,)
                ],)
            );
          },
          separatorBuilder: (context,index){
            return Padding(
                padding: EdgeInsets.only(bottom: 1.h),
                child: Divider());
          }),
    );
  }

  List<MenuModel> userList = [
    MenuModel(name: 'Home',image: ImagePath.home,onTap: (context){
      AppNavigation.navigateTo(context, AppRouteName.HOME_SCREEN_ROUTE,);
      // AuthController.i.zoom.toggle?.call();

    }),
    MenuModel(name: 'My Wishlist',image: ImagePath.heart,onTap: (context){AppNavigation.navigateTo(context, AppRouteName.MyDrivers);}),
    MenuModel(name: 'Privacy Policy',image: ImagePath.privacy,onTap: (context){ AppNavigation.navigateTo(context, AppRouteName.CONTENT_SCREEN,
        arguments: ContentRoutingArgument(
            title:'Privacy Policy',
            contentType: AppStrings.PRIVACY_POLICY_TYPE,
            url: 'https://www.google.com/'));}),
    MenuModel(name: 'Terms & Conditions',image: ImagePath.terms,onTap: (context){ AppNavigation.navigateTo(context, AppRouteName.CONTENT_SCREEN,
        arguments: ContentRoutingArgument(
            title:'Terms & Conditions',
            contentType: AppStrings.TERMS_AND_CONDITION_TYPE,
            url: 'https://www.google.com/'));}),
    MenuModel(name: 'Settings',image: ImagePath.settings,onTap: (context){AppNavigation.navigateTo(context, AppRouteName.SETTINGS_ROUTE);}),
  ];
  List<MenuModel> sellerList = [
    MenuModel(name: 'Home',image: ImagePath.home,onTap: (context){
      AppNavigation.navigateTo(context, AppRouteName.HOME_SCREEN_ROUTE,);
      // AuthController.i.zoom.toggle?.call();

    }),
    MenuModel(name: 'My Earnings',image: ImagePath.earning,onTap: (context){AppNavigation.navigateTo(context, AppRouteName.MY_EARNING_SCREEN);}),
    MenuModel(name: 'Influencers',image: ImagePath.profileIcon,onTap: (context){AppNavigation.navigateTo(context, AppRouteName.INFLUENCERS_LIST_ROUTE);}),
    MenuModel(name: 'Privacy Policy',image: ImagePath.privacy,onTap: (context){ AppNavigation.navigateTo(context, AppRouteName.CONTENT_SCREEN,
        arguments: ContentRoutingArgument(
            title:'Privacy Policy',
            contentType: AppStrings.PRIVACY_POLICY_TYPE,
            url: 'https://www.google.com/'));}),
    MenuModel(name: 'Terms & Conditions',image: ImagePath.terms,onTap: (context){ AppNavigation.navigateTo(context, AppRouteName.CONTENT_SCREEN,
        arguments: ContentRoutingArgument(
            title:'Terms & Conditions',
            contentType: AppStrings.TERMS_AND_CONDITION_TYPE,
            url: 'https://www.google.com/'));}),
    MenuModel(name: 'Settings',image: ImagePath.settings,onTap: (context){AppNavigation.navigateTo(context, AppRouteName.SETTINGS_ROUTE);}),
    MenuModel(name: 'Contract',image: ImagePath.contractHistory,onTap: (context){AppNavigation.navigateTo(context, AppRouteName.CONTRACT_HISTORY_SCREEN);}),
  ];
  List<MenuModel> influencerList = [
    MenuModel(name: 'Home',image: ImagePath.home,onTap: (context){
      AppNavigation.navigateTo(context, AppRouteName.HOME_SCREEN_ROUTE,);
      // AuthController.i.zoom.toggle?.call();

    }),
    MenuModel(name: 'My Earnings',image: ImagePath.earning,onTap: (context){AppNavigation.navigateTo(context, AppRouteName.MY_EARNING_SCREEN);}),
    MenuModel(name: 'Privacy Policy',image: ImagePath.privacy,onTap: (context){ AppNavigation.navigateTo(context, AppRouteName.CONTENT_SCREEN,
        arguments: ContentRoutingArgument(
            title:'Privacy Policy',
            contentType: AppStrings.PRIVACY_POLICY_TYPE,
            url: 'https://www.google.com/'));}),
    MenuModel(name: 'Terms & Conditions',image: ImagePath.terms,onTap: (context){ AppNavigation.navigateTo(context, AppRouteName.CONTENT_SCREEN,
        arguments: ContentRoutingArgument(
            title:'Terms & Conditions',
            contentType: AppStrings.TERMS_AND_CONDITION_TYPE,
            url: 'https://www.google.com/'));}),
    MenuModel(name: 'Settings',image: ImagePath.settings,onTap: (context){AppNavigation.navigateTo(context, AppRouteName.SETTINGS_ROUTE);}),
  ];
  logoutAlert(context){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: const EdgeInsets.fromLTRB(
                  0, 0, 0, 0),
              content: LogoutAlert(),
            ),
          );
        }
    );
  }

  bool user =GlobalController.values.userRole.value == UserRole.user;
  bool seller =GlobalController.values.userRole.value == UserRole.seller;
  bool influencer =GlobalController.values.userRole.value == UserRole.influencer;

}
