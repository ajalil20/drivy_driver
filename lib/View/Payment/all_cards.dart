import 'dart:ui';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:drivy_driver/Component/custom_buttom.dart';
import 'package:drivy_driver/Component/custom_card.dart';
import 'package:drivy_driver/Component/custom_empty_data.dart';
import 'package:drivy_driver/Component/custom_image.dart';
import 'package:drivy_driver/Component/custom_padding.dart';
import 'package:drivy_driver/Component/custom_radio_tile.dart';
import 'package:drivy_driver/Controller/home_controller.dart';
import 'package:drivy_driver/Model/card_model.dart';
import 'package:drivy_driver/Model/category_product_model.dart';
import 'package:drivy_driver/Model/menu_model.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:drivy_driver/Utils/image_path.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:drivy_driver/View/Widget/Dialog/order_place.dart';
import 'package:drivy_driver/View/Widget/counter.dart';
import 'package:drivy_driver/View/base_view.dart';
import '../../../Component/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'card_tile.dart';

class AllCards extends StatefulWidget {
  @override
  State<AllCards> createState() => _AllCardsState();
}

class _AllCardsState extends State<AllCards> {

  RxString payment= ''.obs;

  @override
  void initState() {
    // TODO: implement initState
    HomeController.i.getCards(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BaseView(
        screenTitle: 'Payment Settings',
        showAppBar: true,
        showBackButton: true,
        resizeBottomInset: false,
        child: CustomPadding(
          horizontalPadding: 3.w,
          topPadding: 0,
          child: GetBuilder<HomeController>(
              builder: (d) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cardsList(c: d.cards),
                  SizedBox(height: 2.h,),
                  MyButton(
                      width: 90.w,
                      title: 'Add Card',
                      onTap: () {
                        AppNavigation.navigateTo(context, AppRouteName.ADD_CARD_ROUTE);
                      }),
                  SizedBox(height: 2.h,),
                ],
              );
            }
          ),
        )
    );
  }
  Widget cardsList({required RxList<CardModel> c}){
    return  Expanded(
      child: c.isEmpty?CustomEmptyData(title: 'No Cards',): ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: c.length,
          itemBuilder: (context,index){
            return  CardTile(c: c[index],index: index,);
          }),
    );
  }
}