import 'package:flutter/material.dart';
import 'package:drivy_driver/Arguments/screen_arguments.dart';
import 'package:drivy_driver/Component/custom_image.dart';
import 'package:drivy_driver/Controller/global_controller.dart';
import 'package:drivy_driver/Controller/home_controller.dart';
import 'package:drivy_driver/Model/user_model.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:drivy_driver/Utils/enum.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:sizer/sizer.dart';

class StackedImage extends StatelessWidget {
  StackedImage({super.key,required this.seller,required this.influencer});
  User seller;
  User? influencer;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(right: 5,bottom: 5),
          child: GestureDetector(
            onTap: ()async{
              if(!isSeller){
                print("Uyfddkfd");
                await HomeController.i.getUserDetail(context: context, id: seller.id);
                AppNavigation.navigateTo(context, AppRouteName.SELLER_PROFILE_ROUTE,);
              } else{
                AppNavigation.navigateTo(context, AppRouteName.HOME_SCREEN_ROUTE,arguments: ScreenArguments(index: 3));
              }
            },
            child: CircleAvatar(
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
                  url: seller.userImage,
                  radius: 100,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () async{
              if(!isInfluencer){
                await HomeController.i.getUserDetail(context: context, id: influencer!.id);
                AppNavigation.navigateTo(context, AppRouteName.INFLUENCER_PROFILE_ROUTE,);
              } else{
                AppNavigation.navigateTo(context, AppRouteName.HOME_SCREEN_ROUTE,arguments: ScreenArguments(index: 3));
              }
            },
            child: CircleAvatar(
              radius:2.h,
              backgroundColor: MyColors().purpleColor,
              child: CircleAvatar(
                radius:1.8.h,
                backgroundColor: MyColors().whiteColor,
                child: CustomImage(
                  height: 5.h,
                  width: 5.h,
                  isProfile: true,
                  photoView: false,
                  url: influencer?.userImage,
                  radius: 100,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  bool isSeller =GlobalController.values.userRole.value == UserRole.seller;
  bool isInfluencer =GlobalController.values.userRole.value == UserRole.influencer;
}
