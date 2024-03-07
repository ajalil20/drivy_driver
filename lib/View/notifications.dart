import 'dart:developer';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:drivy_driver/Component/custom_buttom.dart';
import 'package:drivy_driver/Component/custom_empty_data.dart';
import 'package:drivy_driver/Component/custom_image.dart';
import 'package:drivy_driver/Component/custom_refresh.dart';
import 'package:drivy_driver/Controller/home_controller.dart';
import 'package:drivy_driver/Model/category_product_model.dart';
import 'package:drivy_driver/Model/notification_model.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:drivy_driver/Utils/image_path.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:drivy_driver/View/Widget/Dialog/rating.dart';
import 'package:drivy_driver/View/Widget/counter.dart';
import 'package:drivy_driver/View/base_view.dart';
import '../../../Component/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../Utils/utils.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        screenTitle: 'Notifications',
        showAppBar: true,
        showBackButton: true,
        resizeBottomInset: false,
        child: CustomRefresh(
          onRefresh: () async{
            await getData(loading: false);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child:GetBuilder<HomeController>(
                builder: (d) {
                return d.notifications.isEmpty?CustomEmptyData(title: 'No Notifications',):ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(parent: const ClampingScrollPhysics()),
                    itemCount:d.notifications.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context,index){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // if(index==0)...[
                          //   MyText(title: 'Today',size: 18,fontWeight: FontWeight.w700,),
                          //   SizedBox(height: 10,)
                          // ],
                          // if(index==3)...[
                          //   MyText(title: 'Yesterday',size: 18,fontWeight: FontWeight.w700,),
                          //   SizedBox(height: 10,)
                          // ],
                          NotifcationTile(n: d.notifications[d.notifications.length-index-1],),
                        ],
                      );
                    });
              }
            ),
          ),
        )
    );
  }
  Future<void> getData({loading}) async{
    await HomeController.i.getNotifications(loading: loading??true,context: context);
  }
}

class NotifcationTile extends StatelessWidget {
  NotifcationTile({super.key,required this.n});
  NotificationModel n;

  @override
  Widget build(BuildContext context) {

    log("Notification Model:${n.toJson()}");


    return GestureDetector(
      onTap: (){
        Utils().goToNotificationRoute(context: context,n: n,isPush: false);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: MyColors().whiteColor,
        margin: EdgeInsets.only(bottom: 1.h),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            // color: Colors.pink
          ),
          padding: EdgeInsets.all(2.4.w),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyText(title: n.title,size: 15,fontWeight: FontWeight.w600),
                  MyText(title: Utils.relativeTime(n.createdAt),size: 13),
                ],
              ),
              SizedBox(height: 5,),
              MyText(title: n.body,size: 13,),

            ],
          ),
        ),
      ),
    );
  }
}
