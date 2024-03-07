import 'dart:ui';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:drivy_driver/Arguments/screen_arguments.dart';
import 'package:drivy_driver/Component/custom_buttom.dart';
import 'package:drivy_driver/Component/custom_empty_data.dart';
import 'package:drivy_driver/Component/custom_image.dart';
import 'package:drivy_driver/Component/custom_toast.dart';
import 'package:drivy_driver/Controller/global_controller.dart';
import 'package:drivy_driver/Model/category_product_model.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:drivy_driver/Utils/app_size.dart';
import 'package:drivy_driver/Utils/image_path.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:drivy_driver/View/Widget/Dialog/rating.dart';
import 'package:drivy_driver/View/Widget/counter.dart';
import 'package:drivy_driver/View/base_view.dart';
import '../../../Component/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../Utils/enum.dart';
import '../../Controller/home_controller.dart';

class Cart extends StatefulWidget {
  bool fromLiveStream;
  Cart({required this.fromLiveStream});
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  @override
  void initState() {
    // TODO: implement initState
    // checkProductInCart();
    HomeController.i.getCards(context,loading: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GetBuilder<HomeController>(
          builder: (d) {
          return BaseView(
              screenTitle: 'Cart',
              showAppBar: true,
              showBackButton: true,
              resizeBottomInset: false,
              onTapBackButton: (){
                _onWillPop;
                AppNavigation.navigatorPop(context);
              },
              child:  Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  children: [
                    Expanded(
                      child: d.cart.isEmpty?CustomEmptyData(title: 'No Products') : ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: d.cart.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context,index){
                            return Card(
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
                                padding: EdgeInsets.all(1.w),
                                child: Row(children: [
                                  // Container(
                                  //   height: 8.h,
                                  //   width: 8.h,
                                  //   decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.circular(8),
                                  //       image: DecorationImage(image: NetworkImage(d.cart[index].image),
                                  //         fit: BoxFit.cover,
                                  //       )
                                  //   ),
                                  //   padding: EdgeInsets.all(2.w),
                                  // ),
                                  CustomImage(height: 8.h,width: 8.h,url: d.cart[index].image,radius: 8,photoView: false,fit: BoxFit.cover,),
                                  SizedBox(width: 2.w,),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(1.w),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                MyText(title: d.cart[index].title,size: 12,fontWeight: FontWeight.w700,line: 2,),
                                                SizedBox(height: .5.h,),
                                                MyText(title: 'Category: ${d.cart[index].category}',size: 12,fontWeight: FontWeight.w600,line: 1,),
                                                SizedBox(height: .5.h,),
                                                MyText(title: '\$${(d.cart[index].price*d.cart[index].quantity).toStringAsFixed(2)}',size: 13),
                                              ],
                                            ),
                                          ),
                                          Counter(addToCart: true,onTapRemove: (v){d.cart[index].quantity=v;d.getCartTotal();
                                            // if(d.cart.isEmpty){d.emptyCart();}
                                            },onTapAdd: (v){d.cart[index].quantity=v;d.getCartTotal();},onTapDelete: (){d.removeFromCart(p: d.cart[index]);d.getCartTotal();},q: d.cart[index].quantity,),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // SizedBox(height: 0.5.h),

                                ],),
                              ),
                            );
                          }),
                    ),
                    SizedBox(height: 2.h),
                    getTotalCard(),
                    SizedBox(height: 2.h),
                    MyButton(
                        title: 'Proceed to Checkout',
                        bgColor: d.cart.isEmpty?Colors.grey:null,
                        onTap: () {
                          if(d.cart.isEmpty){
                            CustomToast().showToast('Error', 'Add Products to cart', true);
                          } else{
                            AppNavigation.navigateTo(context, AppRouteName.PAYMENT_METHOD_ROUTE,arguments: ScreenArguments(fromLiveStream: widget.fromLiveStream));
                          }
                        }),
                    SizedBox(height: 2.h),
                  ],
                ),
              )
          );
        }
      ),
    );
  }
  getTotalCard(){
    return GetBuilder<HomeController>(
        builder: (d) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.w),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MyText(title: "Price",fontWeight: FontWeight.w700,),
                  MyText(title: "\$${d.cartTotal.toStringAsFixed(2)}"),
                ],
              ),
              SizedBox(height: 1.h,),
              const Divider(),
              SizedBox(height: 1.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MyText(title: "Tax",fontWeight: FontWeight.w700,),
                  MyText(title: "\$${d.productTax.toStringAsFixed(2)}"),
                ],
              ),
              SizedBox(height: 1.h,),
              const Divider(),
              SizedBox(height: 1.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MyText(title: "Sub Total",fontWeight: FontWeight.w700,),
                  MyText(title: "\$${d.totalAmount.toStringAsFixed(2)}",fontWeight: FontWeight.w600,)
                ],
              ),
              SizedBox(height: 1.h,),
              const Divider(),
            ],),
          );
        }
    );
  }

  Future<bool> _onWillPop() async {
    HomeController.i.getProductQuantity();
    return true;
  }
}