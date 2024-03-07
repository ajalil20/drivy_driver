import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:drivy_user/Arguments/screen_arguments.dart';
import 'package:drivy_user/Component/Appbar/appbar_components.dart';
import 'package:drivy_user/Component/custom_icon_container.dart';
import 'package:drivy_user/Component/custom_image.dart';
import 'package:drivy_user/Component/custom_padding.dart';
import 'package:drivy_user/Component/custom_refresh.dart';
import 'package:drivy_user/Component/custom_toast.dart';
import 'package:drivy_user/Controller/auth_controller.dart';
import 'package:drivy_user/Controller/global_controller.dart';
import 'package:drivy_user/Controller/home_controller.dart';
import 'package:drivy_user/Model/stream_model.dart';
import 'package:drivy_user/Model/user_model.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/app_router_name.dart';
import 'package:drivy_user/Utils/enum.dart';
import 'package:drivy_user/Utils/my_colors.dart';
import 'package:drivy_user/Utils/utils.dart';
import 'package:drivy_user/View/Widget/bordered_container.dart';
import 'package:drivy_user/View/Widget/search_tile.dart';
import 'package:drivy_user/View/Widget/stacked_image.dart';

import 'package:drivy_user/View/Widget/view_all_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:drivy_user/View/base_view.dart';
import '../../../Utils/image_path.dart';
import '../../Component/custom_text.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'Dialog/scheduleDialog.dart';

class StreamCard extends StatelessWidget {
    StreamCard({super.key,this.height,this.width,this.leading,this.showViewersCount=true,this.isVideo,this.showSellerProfileOnly=false,this.bottomPadding,this.trailing=const SizedBox(),this.isInvitation,this.onTap,required this.s});
  double? height, width, bottomPadding;
  Widget? leading;
  Widget trailing;
  bool?isInvitation,showViewersCount=true,showSellerProfileOnly=false;
  bool? isVideo;
  StreamModel s;
  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () async{
        if(onTap!=null){
          onTap!();
        }
        if(isVideo==true){
          // print(HomeController.i.liveStreaming.value.influencerId?.id);
          AppNavigation.navigateTo(context, AppRouteName.VIDEO_PLAYER_ROUTE,arguments: ScreenArguments(url:s.recordingUrl,showSellerProfileOnly: showSellerProfileOnly));
        } else{
          if(user){
            await HomeController.i.joinStreaming(context, onSuccess: (){AppNavigation.navigateTo(context, AppRouteName.LIVE_STREAM_ROUTE);}, roomId: s.roomId);
          }
        }
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding??0),
        child: Stack(
          children: [
            CustomImage(
              height: height??35.h,
              width: 100.w,
              // width: 42.w,
              photoView: false,
              url: s.thumbnailImage,
              fit: BoxFit.cover,
              radius: 8,
            ),
            // Container(
            //   height: height??35.h,
            //   width: width,//??42.w,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(8),
            //       image: DecorationImage(image: AssetImage(ImagePath.random2),fit: BoxFit.cover,)
            //   ),
            // ),
            Container(
              height: height??35.h,
              width: width,//??42.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                gradient: LinearGradient(
                  colors: [
                    MyColors().purpleColor.withOpacity(.9),
                    Colors.transparent,
                    // Colors.transparent,
                    // MyColors().purpleColor,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              padding: EdgeInsets.all(2.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(s.influencerId!=null && showSellerProfileOnly==false)...[
                        StackedImage(seller:s.sellerId??User(),influencer: s.influencerId)
                      ]
                      else...[
                        GestureDetector(
                          onTap: () async{
                            if(!seller){
                              await HomeController.i.getUserDetail(context: context, id: s.sellerId!.id);
                              AppNavigation.navigateTo(context, AppRouteName.SELLER_PROFILE_ROUTE,);
                            } else{
                              AppNavigation.navigateTo(context, AppRouteName.HOME_SCREEN_ROUTE,arguments: ScreenArguments(index: 3));
                            }
                          },
                          child: CircleAvatar(
                            radius:4.w,
                            backgroundColor: MyColors().whiteColor,
                            child: CustomImage(
                              height: 7.w,
                              width: 7.w,
                              isProfile: true,
                              photoView: false,
                              url: s.sellerId?.userImage,
                              radius: 100,
                            ),
                          ),
                        ),
                      ],
                      SizedBox(width: 2.w,),
                      leading??Expanded(child: Padding(
                        padding: EdgeInsets.only(top: .5.w),
                        child: MyText(title: '${s.sellerId?.firstName} ${s.sellerId?.lastName}',clr: MyColors().whiteColor,size: 14,),
                      )),
                      trailing,
                      if(!(isInvitation==true) && showViewersCount==true)...[
                        SizedBox(width: 2.w,),
                        BorderedContainer(child:Row(children: [
                          Image.asset(ImagePath.eyeIcon,width: 5.w,),
                          MyText(title: ' ${s.totalViews} ',clr: MyColors().purpleColor,size: 10,)
                        ],),),
                      ],
                     ],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if(s.categoryId!=null)...[
                              BorderedContainer(child:MyText(title: ' ${s.categoryId?.categoryName} ',clr: MyColors().purpleColor,size: 10,)),
                            ],
                            if(s.description!='')...[
                              SizedBox(height: .5.h,),
                              MyText(title: s.description,clr: MyColors().whiteColor,size: 12,line: 2,),
                            ],
                            if(isInvitation==true && s.createdAt!='')...[
                              SizedBox(height: .5.h,),
                              // MyText(title: 'May, 25 - 12:00',clr: MyColors().whiteColor,size: 12,),
                              MyText(title: Utils.formatDateTime(parseFormat:'MMM, dd - hh:mm a',inputDateTime: DateTime.parse(s.createdAt).toLocal()),clr: MyColors().whiteColor,size: 12,),
                            ],
                          ],),
                      ),
                      Row(children: [
                          if(isInvitation==true)...[
                        GestureDetector(
                            onTap: (){
                              HomeController.i.rejectInvite(context: context, id: s.id);
                              // CustomToast().showToast('Cancelled', 'Request cancelled', true);
                            },
                            child: Image.asset(ImagePath.crossCircle,width: 6.w,)),
                        SizedBox(width: 2.w,),
                            GestureDetector(
                                onTap: () async{
                                  if(!(Platform.isIOS)){
                                    if(!(await Utils().requestCameraPermissions() )){
                                      CustomToast().showToast('Error', 'Camera access is required to go live', true);
                                    }else if(!(await Utils().requestMicrophonePermissions())){
                                      CustomToast().showToast('Error', 'Microphone access is required to go live', true);
                                    }
                                    // if(!HomeController.i.cameraPermission){
                                    //   CustomToast().showToast('Error', 'Camera access is required to go live', true);
                                    // }else if(!HomeController.i.microphonePermission){
                                    //   CustomToast().showToast('Error', 'Microphone access is required to go live', true);
                                    // }
                                    else {
                                      await HomeController.i.joinStreaming(context, onSuccess: (){
                                        HomeController.i.removeStreamInvite(id: s.id);
                                        AppNavigation.navigateTo(context, AppRouteName.LIVE_STREAM_ROUTE,arguments: ScreenArguments(hasInfluencer:true));
                                      }, roomId: s.roomId,id: s.id);
                                      }
                                  }else {
                                    await HomeController.i.joinStreaming(context, onSuccess: (){
                                      HomeController.i.removeStreamInvite(id: s.id);
                                      AppNavigation.navigateTo(context, AppRouteName.LIVE_STREAM_ROUTE,arguments: ScreenArguments(hasInfluencer:true));
                                    }, roomId: s.roomId,id: s.id);

                                    // HomeController.i.removeStreamInvite(id: s.id);
                                    // AppNavigation.navigateTo(context, AppRouteName.LIVE_STREAM_ROUTE,arguments: ScreenArguments(hasInfluencer:true));
                                  }
                                  },child: Image.asset(ImagePath.checkCircle,width: 6.w,)),],
                      ],)
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
    scheduleDialog(context){
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
                content: ScheduleDialog(),
              ),
            );
          }
      );
    }
    bool seller =GlobalController.values.userRole.value == UserRole.seller;
    bool user =GlobalController.values.userRole.value == UserRole.user;
}
