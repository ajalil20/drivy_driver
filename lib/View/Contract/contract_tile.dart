import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drivy_user/Arguments/screen_arguments.dart';
import 'package:drivy_user/Component/Appbar/appbar_components.dart';
import 'package:drivy_user/Component/custom_buttom.dart';
import 'package:drivy_user/Component/custom_card.dart';
import 'package:drivy_user/Component/custom_empty_data.dart';
import 'package:drivy_user/Component/custom_image.dart';
import 'package:drivy_user/Component/custom_refresh.dart';
import 'package:drivy_user/Component/custom_switch.dart';
import 'package:drivy_user/Component/custom_text.dart';
import 'package:drivy_user/Component/custom_toggle_bar.dart';
import 'package:drivy_user/Controller/auth_controller.dart';
import 'package:drivy_user/Controller/home_controller.dart';
import 'package:drivy_user/Model/contract_model.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/app_router_name.dart';
import 'package:drivy_user/Utils/app_strings.dart';
import 'package:drivy_user/Utils/image_path.dart';
import 'package:drivy_user/View/User/More/payment_settings.dart';
import 'package:flutter/material.dart';
import 'package:drivy_user/View/Widget/Dialog/delete_account.dart';
import '../../../../../Utils/my_colors.dart';
import '../../../../../Utils/responsive.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../Controller/global_controller.dart';
import '../../Utils/enum.dart';
import '../../Utils/utils.dart';
import '../base_view.dart';
import '../User/More/change_password.dart';


class ContractTile extends StatelessWidget {
  ContractTile({required this.c});
  ContractModel c;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        HomeController.i.onTapContract(c: c);
        AppNavigation.navigateTo(context, AppRouteName.SELLER_STREAM_REQUEST_ROUTE);
        // if(_tabController.index==0){
        //   if(seller){
        //     AppNavigation.navigateTo(context, AppRouteName.INFLUENCER_PROFILE_ROUTE,arguments: ScreenArguments(contractPending:index.isOdd? true:null,contractSigned: index.isOdd?null:true));
        //   } else{
        //     AppNavigation.navigateTo(context, AppRouteName.SELLER_STREAM_REQUEST_ROUTE);
        //   }
        // } else{
        //   if(seller){
        //     AppNavigation.navigateTo(context, AppRouteName.INFLUENCER_PROFILE_ROUTE,arguments: ScreenArguments(contractSigned: true));
        //   } else{
        //     AppNavigation.navigateTo(context, AppRouteName.SELLER_PROFILE_ROUTE);
        //   }
        // }
      },
      child: CustomCard(
        padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 3.w),
        margin:EdgeInsets.only(bottom: 1.5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () async {
                await HomeController.i.getUserDetail(loading: true,context: context,id:c.userId!.id.toString());
                if(seller){
                    AppNavigation.navigateTo(context, AppRouteName.INFLUENCER_PROFILE_ROUTE);
                  } else{
                    AppNavigation.navigateTo(context, AppRouteName.SELLER_PROFILE_ROUTE);
                  }
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius:2.2.h,
                    backgroundColor: MyColors().pinkColor,
                    child: CircleAvatar(
                      radius:2.h,
                      backgroundColor: MyColors().whiteColor,
                      child: CustomImage(
                        height: 5.2.h,
                        width: 5.2.h,
                        isProfile: true,
                        photoView: false,
                        url: c.userId?.userImage,
                        radius: 100,
                      ),
                    ),
                  ),
                  SizedBox(width: 2.w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(title:c.userId==null?'':'${c.userId?.firstName} ${c.userId?.lastName}',size: 14,fontWeight: FontWeight.w700,),
                      // SizedBox(height: .5.h,),
                      // MyText(title: c.createdAt==''?'':'${Utils().parseDate(d: c.createdAt??'')}',//'May, 25 2023 12:00 PM'
                      //   size: 10,fontWeight: FontWeight.w600,clr: MyColors().greyColor,),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children:[
                MyText(title: '${c.requestStatus.capitalize}  ',fontWeight: FontWeight.w700,clr: c.requestStatus==AppStrings.COMPLETED_KEY?MyColors().greenColor:c.requestStatus==AppStrings.COMPLETED_KEY?MyColors().errorColor:null),
                if(c.requestStatus==AppStrings.PENDING_KEY)
                  Image.asset(ImagePath.time,width: 5.w,),
                if(c.requestStatus==AppStrings.ACCEPTED_KEY)
                  Image.asset(ImagePath.doubleCheck,width: 5.w,),
              ]
            )
          ],
        ),
      ),
    );
  }
  bool seller =GlobalController.values.userRole.value == UserRole.seller;
}