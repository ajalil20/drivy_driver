import 'dart:developer';
import 'dart:ui';

import 'package:drivy_driver/Arguments/product_arguments.dart';
import 'package:drivy_driver/Component/custom_buttom.dart';
import 'package:drivy_driver/Component/custom_image.dart';
import 'package:drivy_driver/Model/category_product_model.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:drivy_driver/View/Widget/Dialog/cart_seller.dart';
import 'package:drivy_driver/View/Widget/bordered_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../Utils/image_path.dart';
import '../../Arguments/screen_arguments.dart';
import '../../Component/custom_text.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Controller/home_controller.dart';

class LiveStreamProductTile extends StatelessWidget {
  LiveStreamProductTile({super.key,required this.p});
  ProductsModel p;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (d) {
          return GestureDetector(
            onTap: (){
              d.getProductDetail(context,p: p);
              AppNavigation.navigatorPop(context);
              AppNavigation.navigateTo(context, AppRouteName.PRODUCT_DETAIL_ROUTE,arguments: ProductArguments(fromLiveStream: true,index: 0));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color: MyColors().whiteColor,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  // color: Colors.pink
                ),
                padding: EdgeInsets.all(1.w),
                child: Row(children: [
                  Padding(
                    padding: EdgeInsets.all(2.w),
                    child: CustomImage(height: 7.h,width: 7.h,url: p.image,radius: 8,photoView: false,fit: BoxFit.cover,),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(1.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(title:  p.title,size: 12,fontWeight: FontWeight.w600,line: 1,),
                                MyText(title: 'Category: ${p.category}',size: 12,fontWeight: FontWeight.w600,line: 1,),
                                Row(children: [
                                  Image.asset(ImagePath.star,width: 3.w,),
                                  MyText(title: ' ${p.avgRating.toStringAsFixed(1)}',clr:  MyColors().rateColor),
                                ],),

                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              MyText(title: '\$${p.price??'0'}',size: 13),
                              Row(children: [
                                StatefulBuilder(
                                    builder: (BuildContext context, StateSetter s) {
                                      return IconButton(
                                          onPressed:() async{
                                            await d.addRemoveFavorite(context,id:p.id,onSuccess: (){});
                                          },
                                          icon:p.isFavourite==1? Image.asset(ImagePath.heart,scale: 4,):Image.asset(ImagePath.heartEmpty,scale: 4,));
                                    }
                                ),
                                SizedBox(width: 1.w,),
                                MyButton(onTap: (){
                                  // AppNavigation.navigatorPop(context);
                                  // HomeController.i.addToCart(p:p);
                                  // AppNavigation.navigateTo(context, AppRouteName.CART_ROUTE,arguments: ScreenArguments(fromLiveStream: true));
                                  onSubmit(context);
                                },title: 'Buy Now',width: 20.w,fontSize: 10,height: 4.h,)
                              ],
                              )
                            ],)
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(height: 0.5.h),

                ],),
              ),
            ),
          );
        }
    );
  }

  onSubmit(context){
    var h = HomeController.i;
    if(h.sellerID=='' || h.cart.isEmpty){
      h.sellerID=p.sellerId?.id??'';
      addToCart(context);
    }
    else if(h.checkSellerInCart(p: p)){
      addToCart(context);
    }
    else{
      differentSellerCartAlert(context,onYes: (){
        h.emptyCart();
        addToCart(context);
        h.sellerID=p.sellerId?.id??'';
      });
    }
  }

  addToCart(context){
    var h = HomeController.i;
    AppNavigation.navigatorPop(context);
    AppNavigation.navigateTo(context, AppRouteName.CART_ROUTE,arguments: ScreenArguments(fromLiveStream: true));
    h.addToCart(p:p);
  }

  differentSellerCartAlert(context,{required Function onYes}){
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
              content: CartSeller(onYes: onYes,),
            ),
          );
        }
    );
  }
}
