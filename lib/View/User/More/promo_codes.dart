import 'package:drivy_user/Component/custom_buttom.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:drivy_user/Component/custom_empty_data.dart';
import 'package:drivy_user/Component/custom_padding.dart';
import 'package:drivy_user/Component/custom_refresh.dart';
import 'package:drivy_user/Controller/home_controller.dart';
import 'package:drivy_user/Model/category_product_model.dart';
import 'package:drivy_user/View/base_view.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dash/flutter_dash.dart';
import '../../../../Component/custom_image.dart';
import '../../../../Component/custom_text.dart';
import '../../../../Utils/my_colors.dart';

class PromoCodes extends StatefulWidget {
  @override
  State<PromoCodes> createState() => _PromoCodesState();
}

class _PromoCodesState extends State<PromoCodes>{

  @override
  Widget build(BuildContext context) {
    return BaseView(
      screenTitle: 'Promo Codes',
      showAppBar: true,
      centerTitle: false,
      showBackButton: true,
      // resizeBottomInset: false,
      child: GetBuilder<HomeController>(
          builder: (d) {
            return CustomRefresh(
              onRefresh: () async{
                await fetchData(loading: false);
              },
              child: CustomPadding(
                topPadding: 1.h,
                horizontalPadding: 3.w,
                child: Column(
                  children: [
                    myWishList(p: d.wishlist),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
  Widget myWishList({required RxList<ProductsModel> p}){
    return Expanded(
      child: p.isNotEmpty?CustomEmptyData(title: 'No Products',):
      ListView.builder(
          physics: AlwaysScrollableScrollPhysics(parent: const ClampingScrollPhysics()),
          // shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context,index){
            return  GestureDetector(
              onTap: (){
                // HomeController.i.getProductDetail(context,p: p);
                // AppNavigation.navigateTo(context, AppRouteName.PRODUCT_DETAIL_ROUTE);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffDAE1F1),
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: MyColors().whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                margin: EdgeInsets.only(bottom: 2.h),
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    CustomImage(
                      height: 10.h,
                      width: 10.h,
                      photoView: false,
                      // url: u.value.userImage,
                    ),
                    SizedBox(width: 2.w),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Dash(
                          direction: Axis.vertical,
                          length: 10.h,
                          dashLength: 12,
                          dashGap: 5,
                          dashThickness: 2,
                          dashColor: MyColors().borderColor),
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(title:'20% Off',size: 20,clr: MyColors().textColor,fontWeight: FontWeight.w600,),
                          SizedBox(height: 1.h,),
                          MyText(title:'Valid until 01 February 2022',size: 12,clr: MyColors().greyColor),
                          SizedBox(height: 1.h,),
                          MyButton(title: 'Copy Code',fontSize: 11, height:3.5.h,width: 24.w,radius: 25,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
  Future<void> fetchData({bool? loading}) async{
    await HomeController.i.getWishlistProducts(loading: loading,context: context);
  }
}