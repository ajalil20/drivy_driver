import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:place_picker/place_picker.dart';
import 'package:drivy_user/Component/custom_buttom.dart';
import 'package:drivy_user/Component/custom_card.dart';
import 'package:drivy_user/Component/custom_image.dart';
import 'package:drivy_user/Component/custom_padding.dart';
import 'package:drivy_user/Component/custom_radio_tile.dart';
import 'package:drivy_user/Component/custom_textfield.dart';
import 'package:drivy_user/Component/custom_toast.dart';
import 'package:drivy_user/Controller/home_controller.dart';
import 'package:drivy_user/Model/category_product_model.dart';
import 'package:drivy_user/Model/menu_model.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/app_router_name.dart';
import 'package:drivy_user/Utils/image_path.dart';
import 'package:drivy_user/Utils/my_colors.dart';
import 'package:drivy_user/Utils/utils.dart';
import 'package:drivy_user/View/Payment/card_tile.dart';
import 'package:drivy_user/View/Widget/Dialog/order_place.dart';
import 'package:drivy_user/View/Widget/Dialog/success_payment.dart';
import 'package:drivy_user/View/Widget/counter.dart';
import 'package:drivy_user/View/base_view.dart';
import '../../../Component/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PayInfluencer extends StatefulWidget {
  @override
  State<PayInfluencer> createState() => _PayInfluencerState();
}

class _PayInfluencerState extends State<PayInfluencer> {
  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: BaseView(
          screenTitle: 'Select Payment Card',
          showAppBar: true,
          showBackButton: true,
          resizeBottomInset: true,
          // trailingAppBar: IconButton(icon: Icon(Icons.add_box_rounded,color: MyColors().purpleLight,),onPressed: (){
          //   AppNavigation.navigateTo(context, AppRouteName.ADD_CARD_ROUTE);
          // },),
          floating:!keyboardIsOpen? MyButton(
              width: 90.w, title: 'Send Request',
              onTap: () {
                onSubmit(context);
              }):null,
          trailingAppBar: IconButton(icon: Icon(Icons.add_box_rounded,color: MyColors().purpleLight,),onPressed: (){
            AppNavigation.navigateTo(context, AppRouteName.ADD_CARD_ROUTE);
          },),
          child: CustomPadding(
            horizontalPadding: 3.w,
            topPadding: 0,
            child: GetBuilder<HomeController>(
                builder: (d) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      d.cards.isEmpty?Container(
                        child: MyText(title: 'No Cards',),
                        alignment: Alignment.center,margin: EdgeInsets.symmetric(vertical: 10.h),): ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: d.cards.length,
                          itemBuilder: (context,index){
                            return CardTile(c: d.cards[index],index: index,);
                          }),
                      SizedBox(height: 2.h,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(title: "Contract Title",fontWeight: FontWeight.w700,),
                              SizedBox(width: 3.w,),
                              Expanded(child: Align(alignment: Alignment.centerRight, child: MyText(title: d.paymentMethod,))),
                            ],
                          ),
                          SizedBox(height: 1.h,),
                          Divider(),
                          SizedBox(height: 1.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(title: "Amount",fontWeight: FontWeight.w700,),
                              SizedBox(width: 3.w,),
                              Expanded(child: Align(alignment: Alignment.centerRight, child: MyText(title:"\$${d.amount}"))),
                            ],
                          ),
                          SizedBox(height: 1.h,),
                          Divider(),
                        ],),
                      ),
                    ],
                  ),
                );
              }
            ),
          )
      ),
    );
  }
  successDialog(){
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
              content: SuccessPaymentDialog(),
            ),
          );
        }
    );
  }
  onSubmit(context){
    var h = HomeController.i;
    h.createContractValidationII(context,onSuccess:(){ successDialog();
    });
  }
}
