import 'dart:ui';

import 'package:drivy_user/Arguments/content_argument.dart';
import 'package:drivy_user/Arguments/screen_arguments.dart';
import 'package:drivy_user/Component/Appbar/appbar_components.dart';
import 'package:drivy_user/Component/custom_buttom.dart';
import 'package:drivy_user/Component/custom_empty_data.dart';
import 'package:drivy_user/Component/custom_icon_container.dart';
import 'package:drivy_user/Component/custom_image.dart';
import 'package:drivy_user/Component/custom_padding.dart';
import 'package:drivy_user/Component/custom_refresh.dart';
import 'package:drivy_user/Controller/auth_controller.dart';
import 'package:drivy_user/Controller/home_controller.dart';
import 'package:drivy_user/Model/menu_model.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:drivy_user/View/base_view.dart';
import '../../../Utils/image_path.dart';
import '../../Component/custom_bottomsheet_indicator.dart';
import '../../Component/custom_text.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../Controller/global_controller.dart';
import '../../Model/user_model.dart';
import '../../Utils/app_router_name.dart';
import '../../Utils/utils.dart';

class More extends StatefulWidget {
  More({super.key,this.isMe=true,this.u});
  bool isMe=true;
  User? u;
  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  TextEditingController s = TextEditingController();
  Rx<User> u = User().obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.addPostFrameCallback((_) {HomeController.i.onProfileVisitBack();});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: BaseView(
        showAppBar: false,
        showBottomBar: true,
        resizeBottomInset: false,
        showDrawer: true,
        child: CustomPadding(
          topPadding: 2.h,
          horizontalPadding: 4.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(screenTitle: "Menu",leading: MenuIcon(),bottom: 2.h,),
              profileCard(),
              showList(l:userList),
            ],
          ),
        ),
      ),
    );
  }
  profileCard(){
    return Obx(()=> Container(
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
      padding: EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              radius:3.0.h,
              backgroundColor: MyColors().primaryColor,
              child: CustomImage(
                height: 6.5.h,
                width: 6.5.h,
                isProfile: true,
                photoView: false,
                url: u.value.userImage,
                radius: 100,
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(title:'Rayna Siphron ',size: 14,clr: MyColors().textColor,fontWeight: FontWeight.w600,),
                  MyText(title:'raynasiphron@gmail.com',size: 12,clr: MyColors().greyColor),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded)
          ],
        ),
      ),
    );
  }

 getData()async{
    if(widget.isMe) {
      u=AuthController.i.user;
      await AuthController.i.getDashboard(context: context);
      u=AuthController.i.user;
    }else{
      u=HomeController.i.endUser;
      HomeController.i.followers= List<User>.empty().obs;
      HomeController.i.following= List<User>.empty().obs;
    }
  }
  showList({required List<MenuModel> l}){
    return Padding(
      padding: EdgeInsets.only(left: 1.w,top: 3.h),
      child: ListView.separated(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: l.length,
          itemBuilder: (context,index){
            return InkWell(
                onTap: (){l[index].onTap!(context);
                FocusManager.instance.primaryFocus?.unfocus();
                AuthController.i.zoom.toggle?.call();
                },
                child: Row(children: [
                  Image.asset(l[index].image!,width: 5.w,height: 5.w,),
                  SizedBox(width: 3.w,),
                  Expanded(child: MyText(title: l[index].name!,clr: Color(0xffA3B1BA),fontWeight: FontWeight.w600,)),
                  if(l.length-1!=index)
                  Icon(Icons.chevron_right_rounded)
                ],)
            );
          },
          separatorBuilder: (context,index){
            return SizedBox(height: 3.h,);
          }),
    );
  }
  List<MenuModel> userList = [
    MenuModel(name: 'My Drivers',image: ImagePath.driver,onTap: (context){AppNavigation.navigateTo(context, AppRouteName.MyDrivers,);}),
    MenuModel(name: 'Promo Codes',image: ImagePath.promo,onTap: (context){AppNavigation.navigateTo(context, AppRouteName.PromoCodes);}),
    MenuModel(name: 'Payment Method',image: ImagePath.card,onTap: (context){AppNavigation.navigateTo(context, AppRouteName.PaymentSettings);}),
    MenuModel(name: 'Saved Addresses',image: ImagePath.location,onTap: (context){AppNavigation.navigateTo(context, AppRouteName.SavedAddress);}),
    MenuModel(name: 'Help & Support',image: ImagePath.help,onTap: (context){AppNavigation.navigateTo(context, AppRouteName.HelpSupport);}),
    MenuModel(name: 'Settings',image: ImagePath.settings,onTap: (context){AppNavigation.navigateTo(context, AppRouteName.SETTINGS_ROUTE);}),
    MenuModel(name: 'Logout',image: ImagePath.logout,onTap: (context){AppNavigation.navigateTo(context, AppRouteName.SETTINGS_ROUTE);}),
    // MenuModel(name: 'Terms & Conditions',image: ImagePath.terms,onTap: (context){
    // AppNavigation.navigateTo(context, AppRouteName.CONTENT_SCREEN,
    //     arguments: ContentRoutingArgument(
    //         title:'Terms & Conditions',
    //         contentType: AppStrings.TERMS_AND_CONDITION_TYPE,
    //         url: 'https://www.google.com/'));}),
  ];

}
