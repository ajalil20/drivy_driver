import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:drivy_driver/Component/custom_buttom.dart';
import 'package:drivy_driver/Component/custom_card.dart';
import 'package:drivy_driver/Component/custom_image.dart';
import 'package:drivy_driver/Component/custom_switch.dart';
import 'package:drivy_driver/Component/custom_text.dart';
import 'package:drivy_driver/Component/custom_toggle_bar.dart';
import 'package:drivy_driver/Controller/auth_controller.dart';
import 'package:drivy_driver/Controller/home_controller.dart';
import 'package:drivy_driver/Model/earning_model.dart';
import 'package:drivy_driver/Model/user_model.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:drivy_driver/Utils/image_path.dart';
import 'package:drivy_driver/View/User/More/payment_settings.dart';
import 'package:flutter/material.dart';
import 'package:drivy_driver/View/Widget/Dialog/delete_account.dart';
import '../../../../../Utils/my_colors.dart';
import '../../../../../Utils/responsive.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../Component/custom_empty_data.dart';
import '../../Component/custom_refresh.dart';
import '../../Utils/utils.dart';
import '../base_view.dart';
import '../User/More/change_password.dart';


class MyEarning extends StatefulWidget {
  @override
  State<MyEarning> createState() => _MyEarningState();
}

class _MyEarningState extends State<MyEarning> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        screenTitle: 'My Earnings',
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
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: 16.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: MyColors().pinkColor,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyText(title: '\$ ${d.totalEarning}',clr: MyColors().whiteColor,fontWeight: FontWeight.w600,size: 35,),
                            SizedBox(height: 1.h,),
                            MyText(title: 'Total Earnings',clr: MyColors().whiteColor,fontWeight: FontWeight.w600,size: 16,)
                          ],
                        )
                    ),
                    SizedBox(height: 1.h,),
                    Divider(),
                    MyText(title: 'Transactions',size: 18,fontWeight: FontWeight.w700,),
                    SizedBox(height: 2.h,),
                    Expanded(
                      child:
                      d.earnings.isEmpty?CustomEmptyData(title: 'No Earnings',):
                      ListView.separated(
                        physics: AlwaysScrollableScrollPhysics(parent: const ClampingScrollPhysics()),
                        itemCount: d.earnings.length,
                          itemBuilder: (context,index){
                            return EarningTile(e: d.earnings[index],);
                          },
                        separatorBuilder: (context,index){return Padding(
                          padding: EdgeInsets.only(bottom: 1.h),
                          child: Divider(),
                        );},
                      ),
                    ),
                    SizedBox(height: 2.h,),
                  ],
                ),
              );
            }
          ),
        )
    );
  }

  Future<void> getData({loading}) async{
    await HomeController.i.getEarnings(loading:loading??true,context: context);
  }
}

class EarningTile extends StatelessWidget {
  EarningTile({super.key,required this.e});
  EarningModel e;

  @override
  Widget build(BuildContext context) {
    var u = e.userId;
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Row(
            children: [
              CircleAvatar(
                radius:2.h,
                backgroundColor: MyColors().pinkColor,
                child: CircleAvatar(
                  radius:1.8.h,
                  backgroundColor: MyColors().whiteColor,
                  child: CustomImage(
                    height: 5.h,
                    width: 5.h,
                    isProfile: true,
                    photoView: false,
                    url: u?.userImage,
                    radius: 100,
                  ),
                ),
              ),
              SizedBox(width: 2.w,),
              Expanded(child: MyText(title: u==null?'':'${u.firstName} ${u.lastName}',size: 14,fontWeight: FontWeight.w600,)),
            ],
          ),
        ),
        Expanded(flex: 2, child: Center(child: MyText(title: e.createdAt==null?'':'${Utils().parseDate(d: e.createdAt??'')}',size: 14,fontWeight: FontWeight.w600,clr: MyColors().greyColor,))),
        Expanded(  flex: 2,child: Center(child: MyText(title: '\$${e.amount}',size: 14,fontWeight: FontWeight.w600,clr: MyColors().greyColor))),
      ],
    );
  }
}
