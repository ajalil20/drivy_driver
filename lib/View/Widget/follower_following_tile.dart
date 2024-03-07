import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';
import 'package:drivy_user/Arguments/content_argument.dart';
import 'package:drivy_user/Component/Appbar/appbar_components.dart';
import 'package:drivy_user/Component/custom_buttom.dart';
import 'package:drivy_user/Component/custom_icon_container.dart';
import 'package:drivy_user/Component/custom_image.dart';
import 'package:drivy_user/Component/custom_padding.dart';
import 'package:drivy_user/Component/custom_refresh.dart';
import 'package:drivy_user/Controller/auth_controller.dart';
import 'package:drivy_user/Controller/global_controller.dart';
import 'package:drivy_user/Controller/home_controller.dart';
import 'package:drivy_user/Model/category_product_model.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/app_router_name.dart';
import 'package:drivy_user/Utils/app_size.dart';
import 'package:drivy_user/Utils/app_strings.dart';
import 'package:drivy_user/Utils/enum.dart';
import 'package:drivy_user/Utils/my_colors.dart';
import 'package:drivy_user/Utils/utils.dart';
import 'package:drivy_user/View/Products/product_tile.dart';
import 'package:drivy_user/View/Widget/bordered_container.dart';
import 'package:drivy_user/View/Widget/profile_card.dart';
import 'package:drivy_user/View/Widget/search_tile.dart';
import 'package:drivy_user/View/Widget/streaming_card.dart';

import 'package:drivy_user/View/Widget/view_all_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:drivy_user/View/base_view.dart';
import '../../../Utils/image_path.dart';
import '../../Component/custom_bottomsheet_indicator.dart';
import '../../Component/custom_text.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../Model/user_model.dart';

class FollowFollower extends StatelessWidget {
  FollowFollower({super.key,required this.u,required this.isFollowing,required this.onTap});
  User u;
  bool isFollowing;
  Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        onTap();
        // if(user){
        //   await HomeController.i.getUserDetail(context: context,id: u.id);
        //   AppNavigation.navigatorPop(context);
        //   if(u.role==AppStrings.INFLUENCER){
        //     AppNavigation.navigateTo(context, AppRouteName.INFLUENCER_PROFILE_ROUTE);
        //   } else if(u.role==AppStrings.SELLER){
        //     AppNavigation.navigateTo(context, AppRouteName.SELLER_PROFILE_ROUTE);
        //   }
        // }
        // else if (seller) {
        //   await HomeController.i.getUserDetail(loading: true, context: context, id: u.id);
        //   AppNavigation.navigatorPop(context);
        //   if (u.role == AppStrings.INFLUENCER) {
        //     AppNavigation.navigateTo(
        //         context, AppRouteName.INFLUENCER_PROFILE_ROUTE);
        //   } else if (u.role == AppStrings.USER) {
        //     AppNavigation.navigateTo(context, AppRouteName.USER_PROFILE_ROUTE);
        //   }
        // }
        // else if (influencer) {
        //   await HomeController.i.getUserDetail(loading: true, context: context, id: u.id);
        //   AppNavigation.navigatorPop(context);
        //   if(u.role==AppStrings.SELLER){
        //     AppNavigation.navigateTo(context, AppRouteName.SELLER_PROFILE_ROUTE);
        //   } else if(u.role==AppStrings.USER){
        //     AppNavigation.navigateTo(context, AppRouteName.USER_PROFILE_ROUTE);
        //   }
        // }
      },
      child: Container(
        padding: EdgeInsets.all(1.w)+EdgeInsets.symmetric(vertical: 1.h),
        child:Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius:2.5.h,
              backgroundColor: MyColors().pinkColor,
              child: CircleAvatar(
                radius:2.3.h,
                backgroundColor: MyColors().whiteColor,
                child: CustomImage(
                  height: 5.5.h,
                  width: 5.5.h,
                  isProfile: true,
                  photoView: false,
                  url: u.userImage,
                  radius: 100,
                ),
              ),
            ),
            SizedBox(width: 2.w,),
            Expanded(child: MyText(title: '${u.firstName} ${u.lastName}',size: 14,fontWeight: FontWeight.w700,)),
            if(GlobalController.values.userRole.value.name!=u.role)
            MyButton(onTap: (){
              print("isFollowing ${isFollowing}");
              if(isFollowing){
                HomeController.i.addFollowUnFollow(context, onSuccess: (){
                  HomeController.i.removeFollowFollowers(isFollowing:isFollowing,u: u);
                }, id: u.id);
              }else{
                HomeController.i.addFollowUnFollow(context, onSuccess: (){
                  HomeController.i.addFollowFollowers(u: u);
                }, id: u.id);
              }
            },title:u.isFollowing==1?'UnFollow':'Follow',width: 22.w,fontSize: 11,height: 4.3.h,)
          ],),

      ),
    );
  }
  bool user =GlobalController.values.userRole.value == UserRole.user;
  bool seller =GlobalController.values.userRole.value == UserRole.seller;
  bool influencer =GlobalController.values.userRole.value == UserRole.influencer;
}
