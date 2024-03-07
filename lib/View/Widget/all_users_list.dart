import 'dart:ui';

import 'package:drivy_user/Component/custom_bottomsheet_indicator.dart';
import 'package:drivy_user/Component/custom_card.dart';
import 'package:drivy_user/Component/custom_empty_data.dart';
import 'package:drivy_user/Component/custom_image.dart';
import 'package:drivy_user/Component/custom_text.dart';
import 'package:drivy_user/Controller/auth_controller.dart';
import 'package:drivy_user/Controller/global_controller.dart';
import 'package:drivy_user/Model/user_model.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/app_router_name.dart';
import 'package:drivy_user/Utils/app_size.dart';
import 'package:drivy_user/Utils/app_strings.dart';
import 'package:drivy_user/Utils/enum.dart';
import 'package:drivy_user/Utils/my_colors.dart';
import 'package:drivy_user/Utils/utils.dart';
import 'package:drivy_user/View/Chat/chatting.dart';
import 'package:drivy_user/View/Influencer/influencer_list.dart';
import 'package:drivy_user/View/Widget/message_disclouse.dart';
import 'package:flutter/material.dart';
import 'package:drivy_user/View/Widget/search_tile.dart';
import '../../../../Utils/image_path.dart';
import '../../../../Utils/responsive.dart';
import '../../Component/custom_buttom.dart';
import '../../Component/custom_refresh.dart';
import '../../Controller/home_controller.dart';
import '../base_view.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AllUsersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (d) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.BOTTOMSHEETRADIUS))
            ),
            child:Column(
              children: [
                BottomSheetIndicator(),
                Expanded(child: usersList(u: d.streamingUsers))
              ],
            ),
          ),
        );
      }
    );
  }

  Widget usersList({required RxList<User> u}){
    return u.isEmpty?CustomEmptyData(title: 'No Users',):
    ListView.separated(
      itemCount: u.length,
      physics: AlwaysScrollableScrollPhysics(parent: const ClampingScrollPhysics()),
      // shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return UsersTile(u: u[index]);
      },
        separatorBuilder: (context,index){
          return Divider();
        }
    );
  }

  Future<void> getData({loading,context}) async{
    await HomeController.i.getInfluencers(loading: loading??true,context: context);
  }
}
class UsersTile extends StatelessWidget {
  UsersTile({super.key,required this.u});
  User u;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: GestureDetector(
        onTap: () async{
          await HomeController.i.getUserDetail(context: context,id: u.id);
          AppNavigation.navigatorPop(context);
          AppNavigation.navigateTo(context, AppRouteName.USER_PROFILE_ROUTE);
        },
        child:Row(
          children: [
            CircleAvatar(
              radius: 2.5.h,
              backgroundColor: MyColors().pinkColor,
              child: CircleAvatar(
                radius: 2.3.h,
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
            SizedBox(width: 2.w),
            Expanded(child: MyText(title: '${u.firstName} ${u.lastName}',fontWeight: FontWeight.w700,)),
          ],
        ),
      ),
    );
  }
}
