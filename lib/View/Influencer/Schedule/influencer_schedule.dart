import 'package:drivy_driver/Component/Appbar/appbar_components.dart';
import 'package:drivy_driver/Component/custom_empty_data.dart';
import 'package:drivy_driver/Component/custom_horizontal_calender.dart';
import 'package:drivy_driver/Component/custom_icon_container.dart';
import 'package:drivy_driver/Component/custom_image.dart';
import 'package:drivy_driver/Component/custom_padding.dart';
import 'package:drivy_driver/Component/custom_refresh.dart';
import 'package:drivy_driver/Controller/auth_controller.dart';
import 'package:drivy_driver/Controller/home_controller.dart';
import 'package:drivy_driver/Model/schedule_model.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:drivy_driver/View/Influencer/influencer_portfolio.dart';
import 'package:drivy_driver/View/Widget/search_tile.dart';
import 'package:drivy_driver/View/Widget/streaming_card.dart';

import 'package:drivy_driver/View/Widget/view_all_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:drivy_driver/View/base_view.dart';
import '../../../../Utils/image_path.dart';
import '../../../Component/custom_text.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../Utils/utils.dart';

class InfluencerSchedule extends StatefulWidget {
  const InfluencerSchedule({super.key});

  @override
  State<InfluencerSchedule> createState() => _InfluencerScheduleState();
}

class _InfluencerScheduleState extends State<InfluencerSchedule> {
  TextEditingController s = TextEditingController();
  String parsedDate = "";
  String date = "${DateTime.now()}";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() => true);
        // return Utils().onWillPop(context, currentBackPressTime: currentBackPressTime);
      },
      child: BaseView(
        showAppBar: false,
        showBottomBar: true,
        resizeBottomInset: false,
        showDrawer: false,
        child: CustomRefresh(
          onRefresh: () {
          },
          child: CustomPadding(
            topPadding: 2.h,
            horizontalPadding: 4.w,
            child: GetBuilder<HomeController>(
                builder: (d) {
                return Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomAppBar(screenTitle: "My Schedule",leading: MenuIcon(),trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ChatIcon(),
                            SizedBox(width: 2.w,),
                            NotificationIcon(),
                          ],
                        ),bottom: 2.h,),
                        MyText(title:'Available Schedule',size: 16,clr: MyColors().blueColor,fontWeight: FontWeight.w500,),
                        // HorizontalCalendar(selectedDate: (p,v) async{
                        //   d.startDate=v;parsedDate=p;
                        //   date=v;
                        //   d.selectedDate.value=Utils().convertToDateTime(formattedDateTime:Utils.yMD , d: p,);
                        //   setState(() {});fetchData(context);
                        //   // if(DateTime.now().isBefore(Utils().convertToDateTime(formattedDateTime:Utils.yMD , d: p,))){
                        //   // }
                        // },currentDate:  d.selectedDate),
                        scheduleList(s: d.schedule),
                        SizedBox(height: 2.h),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 1.h),
                        child: FloatingActionButton(
                          onPressed: () {
                            AppNavigation.navigateTo(context, AppRouteName.CREATE_SCHEDULE_ROUTE);
                          },
                          backgroundColor: MyColors().purpleColor,
                          child: Icon(Icons.add,color: MyColors().whiteColor,),
                        ),
                      )
                    ),
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );

  }
  Widget scheduleList({required RxList<ScheduleModel> s}){
    return Expanded(
      child: s.isEmpty?CustomEmptyData(title: 'No Schedule',):
      ListView.builder(
          physics: AlwaysScrollableScrollPhysics(parent: const ClampingScrollPhysics()),
          shrinkWrap: true,
          itemCount: s.length,
          itemBuilder: (context, index) {
          return ScheduleTile(
            orderStatus: index,
            isEnd: s.length-1 == index ? true : false,
            s: s[index],
          );
        },
          ),
    );
  }

  fetchData(context){
    HomeController.i.getSchedule(context, d: date,id: AuthController.i.user.value.id);
  }
}
