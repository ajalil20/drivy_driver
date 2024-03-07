import 'dart:ui';

import 'package:drivy_driver/Component/Appbar/appbar_components.dart';
import 'package:drivy_driver/Component/custom_buttom.dart';
import 'package:drivy_driver/Component/custom_empty_data.dart';
import 'package:drivy_driver/Component/custom_icon_container.dart';
import 'package:drivy_driver/Component/custom_image.dart';
import 'package:drivy_driver/Component/custom_padding.dart';
import 'package:drivy_driver/Component/custom_refresh.dart';
import 'package:drivy_driver/Component/custom_toast.dart';
import 'package:drivy_driver/Controller/home_controller.dart';
import 'package:drivy_driver/Model/category_product_model.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:drivy_driver/View/Products/product_tile.dart';
import 'package:drivy_driver/View/Widget/card/upload_thumbnail.dart';
import 'package:drivy_driver/View/Widget/search_tile.dart';
import 'package:drivy_driver/View/Widget/streaming_card.dart';

import 'package:drivy_driver/View/Widget/view_all_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:drivy_driver/View/base_view.dart';
import '../../../Utils/image_path.dart';
import '../../Component/custom_text.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SellerLiveStreaming extends StatefulWidget {
  const SellerLiveStreaming({super.key});

  @override
  State<SellerLiveStreaming> createState() => _SellerLiveStreamingState();
}

class _SellerLiveStreamingState extends State<SellerLiveStreaming> {
  TextEditingController s = TextEditingController();

  @override
  void initState() {
    super.initState();
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
        showBackButton: false,
        screenTitle: "Live Streaming",
        leadingAppBar: MenuIcon(),
        trailingAppBar: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ChatIcon(),
            NotificationIcon(),
          ],
        ),
        child: GetBuilder<HomeController>(
            builder: (d) {
            return CustomPadding(
              topPadding: 2.h,
              horizontalPadding: 3.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(screenTitle: "Live Streaming",leading: MenuIcon(),trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ChatIcon(),
                      SizedBox(width: 2.w,),
                      NotificationIcon(),
                    ],
                  ),bottom: 2.h,),
                  MyButton(title: 'Go Live',bgColor:d.liveProducts.isEmpty?MyColors().hintColor:null ,onTap: (){
                    if(d.liveProducts.isEmpty){
                      // showDialog(
                      //     context: context,
                      //     barrierDismissible: false,
                      //     builder: (BuildContext context) {
                      //       return BackdropFilter(
                      //           filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      //           child: AuthPopup()
                      //       );
                      //     }
                      // );
                      CustomToast().showToast('Error', 'At least one product is required', true);
                    } else{
                      pickThumbnail();
                    }
                  },),
                  SizedBox(height: 2.h),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: d.liveProducts.isEmpty?CustomEmptyData(title: 'No Products',): ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: d.liveProducts.length,
                              itemBuilder: (context,index){
                                return LiveProductTile(p: d.liveProducts[index],);
                              }),
                        ),
                        SizedBox(height: 2.h),
                        GestureDetector(
                          onTap: (){
                            AppNavigation.navigateTo(context, AppRouteName.PRODUCT_CATALOG_SCREEN_ROUTE);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [Icon(Icons.add_box_rounded,color: MyColors().purpleColor,),SizedBox(width: 2.w,), MyText(title: 'Add Product',under: true,fontWeight: FontWeight.w600,)],),
                        ),
                        SizedBox(height: 2.h),

                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
  void pickThumbnail() {
    showDialog(context: context, builder: (context) {
      return UploadThumbnailDialog();
    });
  }
}

class LiveProductTile extends StatelessWidget {
  LiveProductTile({super.key,required this.p});
  ProductsModel p;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.only(bottom: 1.h),
      color: MyColors().whiteColor,
      child: Container(
        height: 8.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          // color: Colors.pink
        ),
        padding: EdgeInsets.all(1.w),
        child: Row(children: [
          CustomImage(height: 7.h,width: 7.h,url: p.image,radius: 8,photoView: false,fit: BoxFit.cover,),

          // Container(
          //   height: 7.h,
          //   width: 7.h,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(8),
          //       image: DecorationImage(image: AssetImage(ImagePath.random3),fit: BoxFit.cover,
          //       )
          //   ),
          //   padding: EdgeInsets.all(2.w),
          // ),
          SizedBox(width: 1.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.w),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MyText(title: p.title,size: 12,fontWeight: FontWeight.w700,line: 1,),
                            SizedBox(height: .5.h,),
                            MyText(title: 'Category: ${p.category}',size: 12,fontWeight: FontWeight.w700,line: 1,),
                          ],
                        ),
                      ),
                      SizedBox(width: .5.w),
                      GestureDetector(
                          onTap: (){
                            HomeController.i.addProductLiveStream(id: p.id);
                          },
                          child: Image.asset(ImagePath.cross,width: 5.w,)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Image.asset(ImagePath.star,width: 3.w,),
                        SizedBox(width: .5.w),
                        MyText(title: '${p.avgRating.toStringAsFixed(1)}',clr:  MyColors().rateColor,fontWeight: FontWeight.w700),
                      ],),
                      MyText(title:  '\$${p.price??'0'}',size: 13,fontWeight: FontWeight.w700),
                    ],
                  ),
                ],),
            ),
          ),
        ],),
      ),
    );
  }
}

