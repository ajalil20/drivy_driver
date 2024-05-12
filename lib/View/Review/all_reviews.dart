import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:drivy_driver/Component/custom_bottomsheet_indicator.dart';
import 'package:drivy_driver/Component/custom_buttom.dart';
import 'package:drivy_driver/Component/custom_card.dart';
import 'package:drivy_driver/Component/custom_image.dart';
import 'package:drivy_driver/Component/custom_switch.dart';
import 'package:drivy_driver/Component/custom_text.dart';
import 'package:drivy_driver/Component/custom_toast.dart';
import 'package:drivy_driver/Component/custom_toggle_bar.dart';
import 'package:drivy_driver/Controller/auth_controller.dart';
import 'package:drivy_driver/Controller/global_controller.dart';
import 'package:drivy_driver/Controller/home_controller.dart';
import 'package:drivy_driver/Model/category_product_model.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:drivy_driver/Utils/enum.dart';
import 'package:drivy_driver/Utils/image_path.dart';
import 'package:drivy_driver/View/User/More/payment_settings.dart';
import 'package:flutter/material.dart';
import 'package:drivy_driver/View/Widget/Dialog/delete_account.dart';
import 'package:drivy_driver/View/Widget/Dialog/rating.dart';
import '../../../../../Utils/my_colors.dart';
import '../../../../../Utils/responsive.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../Model/user_model.dart';
import '../../Utils/app_size.dart';
import '../../Utils/utils.dart';
import '../base_view.dart';
import '../User/More/change_password.dart';


class AllReviews extends StatefulWidget {
  @override
  State<AllReviews> createState() => _AllReviewsState();
}

class _AllReviewsState extends State<AllReviews> {
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (d) {
        return BaseView(
            screenTitle: '${d.endUser.value.firstName} ${d.endUser.value.lastName}',
            showAppBar: true,
            showBackButton: true,
            resizeBottomInset: false,
            floating:MyButton(
                width: 90.w,
                title: 'Write a Review',
                onTap: () {
                  giveReview(context);
                }),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyText(title: '${d.endUser.value.avgRating==null?'0.0':d.endUser.value.avgRating.toStringAsFixed(1)}',fontWeight: FontWeight.w700,size: 40,),
                  SizedBox(height: 1.h,),
                  RatingBar(
                    initialRating:d.endUser.value.avgRating==null?0.0:double.parse(d.endUser.value.avgRating.toString()),
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    glowColor: Colors.yellow,
                    updateOnDrag:false,
                    ignoreGestures:true,
                    ratingWidget: RatingWidget(
                      full: Image.asset(ImagePath.star,width: 3.w,),
                      half: Image.asset(ImagePath.star,width: 3.w,),
                      empty:Image.asset(ImagePath.starOutlined,width: 3.w,),
                    ),
                    itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                    onRatingUpdate: (rating) {},
                    itemSize:7.w,
                  ),
                  SizedBox(height: 1.h,),
                  SizedBox(height: 1.h,),
                  Divider(),
                  Expanded(
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: d.userReviews.length,
                        itemBuilder: (context, index) {
                          return UserReviewTile(r: d.userReviews[index],);
                        },
                        separatorBuilder: (context,index){
                          return Divider();
                        },
                    ),
                  ),
                  SizedBox(height: 2.h,),
                ],
              ),
            )
        );
      }
    );
  }
  giveReview(context,{bool? edit,Reviews? r}){
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
              content: RatingAlert(id:'1',index: 2,refreshData: (){},productId: '',edit: edit,r: r??Reviews(),isProduct:false),
            ),
          );
        }
    );
  }
  Future<void> getData() async{
  }
  // onSubmit(context){
  bool influencer =GlobalController.values.userRole.value == UserRole.influencer;
}

class UserReviewTile extends StatelessWidget {
  UserReviewTile({super.key,required this.r});
  Reviews r;

  @override
  Widget build(BuildContext context) {
    // print(r.userId!.id!=AuthController.i.user.value.id);
    // print(r.userId!.id);
    // print(AuthController.i.user.value.id);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 1.h),
        Row(
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
                  url: r.userId?.userImage,
                  radius: 100,
                ),
              ),
            ),
            SizedBox(width: 2.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(title: "${r.userId?.firstName} ${r.userId?.lastName}",fontWeight: FontWeight.w500,),
                      if(r.isMyReview==1)
                        GestureDetector(
                            onTap:(){
                              deleteDialog(context,r: r);
                            },
                            child: Icon(Icons.more_vert_rounded)),
                    ],
                  ),
                  // SizedBox(height: .5.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(children: [
                          RatingBar(
                            initialRating: double.parse(r.rating.toString()),
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            glowColor: Colors.yellow,
                            updateOnDrag:false,
                            ignoreGestures:true,
                            ratingWidget: RatingWidget(
                              full: Image.asset(ImagePath.star,width: 3.w,),
                              half: Image.asset(ImagePath.star,width: 3.w,),
                              empty:Image.asset(ImagePath.starOutlined,width: 3.w,),
                            ),
                            itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                            onRatingUpdate: (rating) {},
                            itemSize:3.w,
                          ),
                          SizedBox(width: .5.w),
                          MyText(title: '${r.rating.toStringAsFixed(1)??0.0}',
                            clr: MyColors().rateColor,
                            size: 12,),],),
                      ),
                      MyText(title: Utils.relativeTime(r.createdAt),
                        clr: MyColors().greyColor,
                        size: 12,)
                    ],),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        MyText(title: r.review,),
        SizedBox(height: 1.h),
      ],
    );
  }
  void deleteDialog(context,{required Reviews r}) {
    showModalBottomSheet(
        context: context,
        // backgroundColor: MyColors().whiteColor,
        builder: (BuildContext bc) {
          return  Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
                color:  MyColors().whiteColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.BOTTOMSHEETRADIUS))
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BottomSheetIndicator(),
                SizedBox(height: 1.5.h,),
                GestureDetector(
                  onTap: (){
                    AppNavigation.navigatorPop(context);
                    giveReview(context,edit: true,r: r);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(ImagePath.editReview,scale: 5,color: MyColors().pinkColor,),
                      SizedBox(width: 3.w,),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(title: 'Edit Review',size: 13,fontWeight: FontWeight.w700,),
                          MyText(title: 'Want to edit your review...…!',clr: MyColors().greyColor,size: 11,),
                        ],)
                    ],
                  ),
                ),
                SizedBox(height: 1.h,),
                GestureDetector(
                  onTap: (){
                    AppNavigation.navigatorPop(context);
                    // HomeController.i.deleteUserReview(context,onSuccess: (){},r: r);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(ImagePath.delete,scale: 5,color: MyColors().pinkColor),
                      SizedBox(width: 3.w,),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(title: 'Delete Review',size: 13,fontWeight: FontWeight.w700,),
                          MyText(title: 'Want to delete your review...!',clr: MyColors().greyColor,size: 11,),
                        ],)
                    ],
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
  giveReview(context,{bool? edit,Reviews? r}){
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
              content: RatingAlert(id:'1',index: 2,refreshData: (){},productId: '',edit: edit,r: r??Reviews(),isProduct:false),
            ),
          );
        }
    );
  }
  bool influencer =GlobalController.values.userRole.value == UserRole.influencer;
  bool seller =GlobalController.values.userRole.value == UserRole.seller;
}
