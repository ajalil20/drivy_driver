import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drivy_driver/Arguments/screen_arguments.dart';
import 'package:drivy_driver/Component/Appbar/appbar_components.dart';
import 'package:drivy_driver/Component/custom_buttom.dart';
import 'package:drivy_driver/Component/custom_card.dart';
import 'package:drivy_driver/Component/custom_empty_data.dart';
import 'package:drivy_driver/Component/custom_image.dart';
import 'package:drivy_driver/Component/custom_refresh.dart';
import 'package:drivy_driver/Component/custom_switch.dart';
import 'package:drivy_driver/Component/custom_text.dart';
import 'package:drivy_driver/Component/custom_toggle_bar.dart';
import 'package:drivy_driver/Controller/auth_controller.dart';
import 'package:drivy_driver/Controller/home_controller.dart';
import 'package:drivy_driver/Model/contract_model.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:drivy_driver/Utils/app_strings.dart';
import 'package:drivy_driver/Utils/image_path.dart';
import 'package:drivy_driver/View/User/More/payment_settings.dart';
import 'package:flutter/material.dart';
import 'package:drivy_driver/View/Widget/Dialog/delete_account.dart';
import '../../../../../Utils/my_colors.dart';
import '../../../../../Utils/responsive.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../Controller/global_controller.dart';
import '../../Utils/enum.dart';
import '../base_view.dart';
import '../User/More/change_password.dart';
import 'contract_tile.dart';


class ContractHistory extends StatefulWidget {
  @override
  State<ContractHistory> createState() => _ContractHistoryState();
}

class _ContractHistoryState extends State<ContractHistory>  with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    fetchData(fetchAll: true);
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  late TabController _tabController;
  final _tabs = [const Tab(text: 'Recent'), const Tab(text: 'History'),];

  @override
  Widget build(BuildContext context) {
    return BaseView(
        showAppBar: false,
        showBackButton: true,
        resizeBottomInset: false,
        child: CustomRefresh(
          onRefresh: () async{
            await fetchData(fetchAll: false);
          },
          child:GetBuilder<HomeController>(
              builder: (d) {
              return Padding(
                padding: EdgeInsets.only(bottom: 2.h,)+ EdgeInsets.symmetric(horizontal: 3.w),
                child: Column(
                  children: [
                    SizedBox(height: 2.h,),
                    CustomAppBar(screenTitle: 'Contract',leading: influencer?MenuIcon():CustomBackButton(),trailing: influencer?Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ChatIcon(),
                        SizedBox(width: 2.w,),
                        NotificationIcon(),
                      ],
                    ):null,bottom: 2.h,),
                    Container(
                      // height: kToolbarHeight - 8.0,
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1.0, color:MyColors().greyColor,),)

                      ),
                      child: TabBar(
                        controller: _tabController,
                        // isScrollable: true,
                        indicator: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 1.0, color:MyColors().black,),)
                        ),
                        unselectedLabelStyle: GoogleFonts.poppins(
                          color: MyColors().lightGreyColor.withOpacity(.1),
                        ),
                        labelColor: MyColors().black,
                        tabs: _tabs,
                        labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 16),
                        onTap: (v){
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(height: 2.h,),
                    contractList(c: _tabController.index==0?d.recentContract:d.historyContract),

                    // Expanded(
                    //   child: ListView.builder(
                    //     physics: BouncingScrollPhysics(),
                    //     shrinkWrap: true,
                    //     itemCount: 16,
                    //     itemBuilder: (context,index){
                    //       return GestureDetector(
                    //         onTap: (){
                    //           if(_tabController.index==0){
                    //             if(seller){
                    //               AppNavigation.navigateTo(context, AppRouteName.INFLUENCER_PROFILE_ROUTE,arguments: ScreenArguments(contractPending:index.isOdd? true:null,contractSigned: index.isOdd?null:true));
                    //             } else{
                    //               AppNavigation.navigateTo(context, AppRouteName.SELLER_STREAM_REQUEST_ROUTE);
                    //             }
                    //           } else{
                    //             if(seller){
                    //               AppNavigation.navigateTo(context, AppRouteName.INFLUENCER_PROFILE_ROUTE,arguments: ScreenArguments(contractSigned: true));
                    //             } else{
                    //               AppNavigation.navigateTo(context, AppRouteName.SELLER_PROFILE_ROUTE);
                    //             }
                    //           }
                    //         },
                    //         child: CustomCard(
                    //           padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 3.w),
                    //           margin:EdgeInsets.only(bottom: 1.5.h),
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Row(
                    //                 children: [
                    //                   CircleAvatar(
                    //                     radius:2.2.h,
                    //                     backgroundColor: MyColors().pinkColor,
                    //                     child: CircleAvatar(
                    //                       radius:2.h,
                    //                       backgroundColor: MyColors().whiteColor,
                    //                       child: CustomImage(
                    //                         height: 5.2.h,
                    //                         width: 5.2.h,
                    //                         isProfile: true,
                    //                         photoView: false,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   SizedBox(width: 2.w,),
                    //                   Column(
                    //                     crossAxisAlignment: CrossAxisAlignment.start,
                    //                     children: [
                    //                       MyText(title: 'Jacob Smith',size: 14,fontWeight: FontWeight.w700,),
                    //                       SizedBox(height: .5.h,),
                    //                       MyText(title: 'May, 25 2023 12:00 PM',size: 10,fontWeight: FontWeight.w600,clr: MyColors().greyColor,),
                    //                     ],
                    //                   ),
                    //                 ],
                    //               ),
                    //               if(_tabController.index==0)...[Row(
                    //                 children: [
                    //                   if(index.isOdd)...[
                    //                     MyText(title: 'Pending  ',fontWeight: FontWeight.w700,),
                    //                     Image.asset(ImagePath.time,width: 5.w,),
                    //                   ] else...[
                    //                     MyText(title: 'Accepted  ',fontWeight: FontWeight.w700,),
                    //                     Image.asset(ImagePath.doubleCheck,width: 5.w,),
                    //                   ]
                    //                 ],
                    //               )],
                    //               if(_tabController.index==1)...[Row(
                    //                 children: [
                    //                   MyText(title: index.isOdd?'Completed':'Cancelled',size: 14,fontWeight: FontWeight.w600,clr: index.isOdd?MyColors().greenColor:MyColors().errorColor,),
                    //                   // MyText(title: 'Accepted  ',fontWeight: FontWeight.w700,),
                    //                   // Image.asset(ImagePath.doubleCheck,width: 5.w,),
                    //                 ],
                    //               )],
                    //             ],
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              );
            }
          ),
        )
    );
  }
  Widget contractList({required RxList<ContractModel> c}){
    return Expanded(
      child: c.isEmpty?CustomEmptyData(title: 'No Contracts',):
      ListView.builder(
        physics: AlwaysScrollableScrollPhysics(parent: const ClampingScrollPhysics()),
        shrinkWrap: true,
        itemCount: c.length,
        itemBuilder: (context,index){
          return ContractTile(c:c[index]);
        },
      ),
    );
  }

  Future<void> fetchData({required bool fetchAll}) async{
    if(fetchAll){
      await HomeController.i.getContract(loading: fetchAll,context: context,type: AppStrings.RECENT);
      await HomeController.i.getContract(loading: false,context: context,type: AppStrings.HISTORY);
    }else if(_tabController.index==0 || fetchAll){
      await HomeController.i.getContract(loading: fetchAll,context: context,type: AppStrings.RECENT);
    } else if(_tabController.index==1 || fetchAll){
      await HomeController.i.getContract(loading: fetchAll,context: context,type: AppStrings.HISTORY);
    }
  }
  bool influencer =GlobalController.values.userRole.value == UserRole.influencer;
}