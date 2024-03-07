import 'dart:ui';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:drivy_user/Arguments/screen_arguments.dart';
import 'package:drivy_user/Component/custom_buttom.dart';
import 'package:drivy_user/Component/custom_empty_data.dart';
import 'package:drivy_user/Component/custom_image.dart';
import 'package:drivy_user/Component/custom_toast.dart';
import 'package:drivy_user/Controller/global_controller.dart';
import 'package:drivy_user/Controller/home_controller.dart';
import 'package:drivy_user/Model/category_product_model.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/app_router_name.dart';
import 'package:drivy_user/Utils/enum.dart';
import 'package:drivy_user/Utils/image_path.dart';
import 'package:drivy_user/Utils/my_colors.dart';
import 'package:drivy_user/View/Products/product_tile.dart';
import 'package:drivy_user/View/Widget/Dialog/delete_account.dart';
import 'package:drivy_user/View/Widget/counter.dart';
import 'package:drivy_user/View/Widget/search_tile.dart';
import 'package:drivy_user/View/base_view.dart';
import '../../Component/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductCatalog extends StatelessWidget {
  ProductCatalog({this.fromLiveStream});
  TextEditingController s = TextEditingController();
  RxBool searchOn = false.obs;
  bool?fromLiveStream;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return onWillPop(context);
      },
      child: BaseView(
          screenTitle: 'Product Catalog',
          showAppBar: true,
          showBackButton: true,
          resizeBottomInset: false,
          onTapBackButton: (){
            onWillPop(context);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child:GetBuilder<HomeController>(
                builder: (d) {
                return Column(
                  children: [
                    SearchTile(
                      onChange: (val) {
                        if (val.isNotEmpty) {
                          searchOn.value = true;
                          d.getSearchProducts(s: val);
                        }
                        else {
                          searchOn.value = false;
                          d.update();
                        }
                      },
                      search:s,
                      showFilter: false,
                    ),
                    SizedBox(height: 2.2.h),
                    productsList(p: searchOn.isTrue?d.searchProducts:d.products),
                    MyButton(
                        width: 90.w,
                        title: 'Done',
                        onTap: () {
                          onWillPop(context);}),
                    SizedBox(height: 2.h,),
                  ],
                );
              }
            ),
          )
      ),
    );
  }
  onWillPop(context) async {
    if(fromLiveStream==true){
      if(HomeController.i.liveProducts.isEmpty){
        CustomToast().showToast('Error', 'At least one product is required', true);
      } else{
        HomeController.i.addProductToLiveStream();
        AppNavigation.navigatorPop(context);
        return false;
      }
    }
    else{
      AppNavigation.navigatorPop(context);
      return false;
    }
  }
  Widget productsList({required RxList<ProductsModel> p}){
    return Expanded(
      child: p.isEmpty?CustomEmptyData(title: 'No Products',):
      GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: .89,crossAxisSpacing: 3.w,mainAxisSpacing: 3.w,),
          physics: AlwaysScrollableScrollPhysics(parent: const ClampingScrollPhysics()),
          shrinkWrap: true,
          itemCount: p.length,
          itemBuilder: (context,index){
            return ProductTile(p:p[index],index: index,showFavorite: false,showCheck: true,onPressed: (){
              HomeController.i.addProductLiveStream(id: p[index].id);
            },);
          }),
    );
  }
}