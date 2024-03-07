import 'dart:ui';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:drivy_user/Component/custom_buttom.dart';
import 'package:drivy_user/Component/custom_image.dart';
import 'package:drivy_user/Component/custom_title_description.dart';
import 'package:drivy_user/Component/custom_toast.dart';
import 'package:drivy_user/Controller/global_controller.dart';
import 'package:drivy_user/Controller/home_controller.dart';
import 'package:drivy_user/Model/category_product_model.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/app_router_name.dart';
import 'package:drivy_user/Utils/app_strings.dart';
import 'package:drivy_user/Utils/image_path.dart';
import 'package:drivy_user/Utils/my_colors.dart';
import 'package:drivy_user/View/base_view.dart';
import '../../../Component/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../Utils/enum.dart';
import '../../Arguments/screen_arguments.dart';
import '../../Utils/utils.dart';

class SellerStreamRequest extends StatefulWidget {
  @override
  State<SellerStreamRequest> createState() => _SellerStreamRequestState();
}

class _SellerStreamRequestState extends State<SellerStreamRequest> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (d) {
          var c = d.contract.value;
        return BaseView(
            screenTitle: influencer?c.requestStatus==AppStrings.PENDING_KEY? 'Seller Request':'Contract Details':'Contract Details',
            showAppBar: true,
            showBackButton: true,
            resizeBottomInset: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        // SizedBox(height: 2.h,),
                        // StreamCard(hasInfluencer:false,height: 20.h,bottomPadding: 1.h,isInvitation: true,canNavigate: false,),
                        // SizedBox(height: 2.h,),
                        // MyText(
                        //   title: 'Product',
                        //   fontWeight:FontWeight.w600,
                        //   size: 18,
                        // ),
                        // SizedBox(height: 1.h,),
                        // ListView.builder(
                        //     physics: NeverScrollableScrollPhysics(),
                        //     shrinkWrap: true,
                        //     itemCount: 1,
                        //     padding: EdgeInsets.zero,
                        //     itemBuilder: (context,index){
                        //       return Card(
                        //         shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(8),
                        //         ),
                        //         color: MyColors().lightGrey,
                        //         margin: EdgeInsets.only(bottom: 1.h),
                        //         child: Container(
                        //           decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(8),
                        //             // color: Colors.pink
                        //           ),
                        //           padding: EdgeInsets.all(1.w),
                        //           child: Row(children: [
                        //             Container(
                        //               height: 7.h,
                        //               width: 7.h,
                        //               decoration: BoxDecoration(
                        //                   borderRadius: BorderRadius.circular(8),
                        //                   image: DecorationImage(image: AssetImage(ImagePath.random3),fit: BoxFit.cover,
                        //                   )
                        //               ),
                        //               padding: EdgeInsets.all(2.w),
                        //             ),
                        //             Expanded(
                        //               child: Padding(
                        //                 padding: EdgeInsets.all(1.w),
                        //                 child: Row(
                        //                   crossAxisAlignment: CrossAxisAlignment.end,
                        //                   children: [
                        //                     Expanded(
                        //                       child: Column(
                        //                         crossAxisAlignment: CrossAxisAlignment.start,
                        //                         children: [
                        //                           MyText(title: 'Lorem Ipsum',size: 12,fontWeight: FontWeight.w600,line: 1,),
                        //                           SizedBox(height: .5.h,),
                        //                           MyText(title: 'Category: Cloth',size: 12,fontWeight: FontWeight.w600,line: 1,),
                        //                           SizedBox(height: .5.h,),
                        //                           Row(children: [
                        //                             Image.asset(ImagePath.star,width: 3.w,),
                        //                             SizedBox(width: .5.w),
                        //                             MyText(title: '4.9',clr:  MyColors().rateColor),
                        //                           ],),
                        //                         ],
                        //                       ),
                        //                     ),
                        //                     MyText(title: '\$${index+2}.80',size: 12,clr: MyColors().black,line: 1,fontWeight: FontWeight.w600),
                        //
                        //                   ],
                        //                 ),
                        //               ),
                        //             ),
                        //             // SizedBox(height: 0.5.h),
                        //
                        //           ],),
                        //         ),
                        //       );
                        //     }),
                        // SizedBox(height: 2.h,),
                        SizedBox(height: 2.h,),
                        MyText(
                          title: 'Contract Signed',
                          fontWeight:FontWeight.w600,
                          size: 18,
                        ),
                        SizedBox(height: 2.h,),
                        TitleDescription(title:"${influencer?'Seller':'Influencer'} Name",description: c.userId==null?'':'${c.userId?.firstName} ${c.userId?.lastName}'),
                        Divider(),
                        TitleDescription(title:"Start Date",description: c.startDate==''?'':Utils.convertToLocalDate(time:'${c.startDate} ${Utils.dayStartTime}',format: Utils.MMDDYY)),
                        Divider(),
                        TitleDescription(title:"End Date",description: c.startDate==''?'':Utils.convertToLocalDate(time:'${c.endDate} ${Utils.dayEndTime}',format: Utils.MMDDYY)),
                        // Divider(),
                        // TitleDescription(title:"Date",description: c.createdAt==''?'':'${Utils().parseDate(d: c.createdAt??'')}'),
                        // Divider(),
                        // TitleDescription(title:"Time",description: '12:00 PM'),
                        Divider(),
                        TitleDescription(title:"Mode of Payment",description: Utils().getContractPaymentValue(c.paymentType)),
                        Divider(),
                        TitleDescription(title: c.paymentType==AppStrings.GIFT_KEY?'Gift':"Amount",description: c.paymentType==AppStrings.GIFT_KEY?c.gift:'${c.price}'),
                        Divider(),
                        if(c.requestStatus!=AppStrings.PENDING_KEY || seller)...[
                          TitleDescription(title: 'Contract status',description:c.requestStatus.capitalize),
                          Divider(),
                        ],
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h,),
                  if(c.requestStatus==AppStrings.PENDING_KEY && influencer)...[
                    Row(children: [
                      Flexible(child: MyButton(title: 'Reject',onTap: (){
                        onSubmit(status: AppStrings.REJECTED_KEY);
                        // CustomToast().showToast('Rejected', 'You have rejected invitation request', true);
                      },)),
                      SizedBox(width: 3.w,),
                      Flexible(child: MyButton(title: 'Accept',onTap: (){
                        onSubmit(status: AppStrings.ACCEPTED_KEY);
                        // AppNavigation.navigatorPop(context);
                        // AppNavigation.navigatorPop(context);
                        // AppNavigation.navigateTo(context, AppRouteName.LIVE_STREAM_ROUTE,arguments: ScreenArguments(hasInfluencer:true));
                      },bgColor: MyColors().purpleColor,))
                    ],),
                    SizedBox(height: 2.h,),
                  ],
                ],
              ),
            )
        );
      }
    );
  }
  onSubmit({required String status}){
    HomeController.i.acceptRejectContract(context,onSuccess: (){if(status==AppStrings.REJECTED_KEY){AppNavigation.navigatorPop(context);}},status: status);
  }
  bool influencer =GlobalController.values.userRole.value == UserRole.influencer;
  bool seller =GlobalController.values.userRole.value == UserRole.seller;
}
