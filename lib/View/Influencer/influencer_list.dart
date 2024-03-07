import 'package:drivy_driver/Component/custom_card.dart';
import 'package:drivy_driver/Component/custom_empty_data.dart';
import 'package:drivy_driver/Component/custom_image.dart';
import 'package:drivy_driver/Component/custom_text.dart';
import 'package:drivy_driver/Controller/auth_controller.dart';
import 'package:drivy_driver/Controller/global_controller.dart';
import 'package:drivy_driver/Model/user_model.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:drivy_driver/Utils/app_strings.dart';
import 'package:drivy_driver/Utils/enum.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:drivy_driver/Utils/utils.dart';
import 'package:drivy_driver/View/Chat/chatting.dart';
import 'package:drivy_driver/View/Widget/message_disclouse.dart';
import 'package:flutter/material.dart';
import '../../../../Utils/image_path.dart';
import '../../../../Utils/responsive.dart';
import '../../Component/custom_refresh.dart';
import '../../Controller/home_controller.dart';
import '../base_view.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class InfluencersList extends StatefulWidget {
  @override
  State<InfluencersList> createState() => _InfluencersListState();
}


class _InfluencersListState extends State<InfluencersList> {

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BaseView(
      screenTitle: 'Influencers',
      showAppBar: true,
      showBackButton: true,
      resizeBottomInset: false,
      child: CustomRefresh(
        onRefresh: () async{
          await getData(loading: false);
        },
        child: GetBuilder<HomeController>(
            builder: (d) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: influencersList(u: d.influencers),
            );
          }
        ),
      ),
    );
  }
  Widget influencersList({required RxList<User> u}){
    return u.isEmpty?CustomEmptyData(title: 'No Users',):
    ListView.builder(
      itemCount: u.length,
      physics: AlwaysScrollableScrollPhysics(parent: const ClampingScrollPhysics()),
      // shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return InfluencerTile(u: u[index]);
      },
    );
  }

  Future<void> getData({loading}) async{
    await HomeController.i.getInfluencers(loading: loading??true,context: context);
  }
}

class InfluencerTile extends StatelessWidget {
  InfluencerTile({super.key,required this.u});
  User u;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: GestureDetector(
          onTap: () async{
            // HomeController.i.endUser.value=u;
            await HomeController.i.getUserDetail(context: context,id: u.id);
            AppNavigation.navigateTo(context, AppRouteName.INFLUENCER_PROFILE_ROUTE);
          },
          child: CustomCard(
            elevation: 2,
            padding: EdgeInsets.symmetric(vertical: 1.5.h,horizontal: 2.w),
            child:  Row(
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
                Expanded(child: MyText(title: '${u.firstName} ${u.lastName}',fontWeight: FontWeight.w700,))
              ],
            ),
          )
      ),
    );
  }
}
