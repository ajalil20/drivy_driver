import 'dart:ui';

import 'package:drivy_driver/Arguments/content_argument.dart';
import 'package:drivy_driver/Arguments/screen_arguments.dart';
import 'package:drivy_driver/Component/Appbar/appbar_components.dart';
import 'package:drivy_driver/Component/custom_buttom.dart';
import 'package:drivy_driver/Component/custom_empty_data.dart';
import 'package:drivy_driver/Component/custom_icon_container.dart';
import 'package:drivy_driver/Component/custom_image.dart';
import 'package:drivy_driver/Component/custom_padding.dart';
import 'package:drivy_driver/Component/custom_refresh.dart';
import 'package:drivy_driver/Controller/auth_controller.dart';
import 'package:drivy_driver/Controller/home_controller.dart';
import 'package:drivy_driver/Model/menu_model.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:drivy_driver/View/base_view.dart';
import '../../../Utils/image_path.dart';
import '../../Component/custom_bottomsheet_indicator.dart';
import '../../Component/custom_text.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../Controller/global_controller.dart';
import '../../Model/user_model.dart';
import '../../Utils/app_router_name.dart';
import '../../Utils/utils.dart';
import '../Widget/Dialog/logout.dart';

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
              CustomAppBar(screenTitle: "Menu",bottom: 5.h,a: Alignment.centerLeft,),
              profileCard(),
              showList(l:userList),
            ],
          ),
        ),
      ),
    );
  }
  profileCard(){
    return Obx(()=>  GestureDetector(
      onTap: (){
        AppNavigation.navigateTo(context, AppRouteName.ProfileView);
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
                    MyText(title:AuthController.i.user.value.fullName,size: 14,clr: MyColors().textColor,fontWeight: FontWeight.w600,),
                    MyText(title:AuthController.i.user.value.email,size: 12,clr: MyColors().greyColor),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded)
            ],
          ),
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
    MenuModel(name: 'Account Details',image: ImagePath.document,onTap: (context){AppNavigation.navigateTo(context, AppRouteName.AccountDetails,);}),
    MenuModel(name: 'Help & Support',image: ImagePath.help,onTap: (context){AppNavigation.navigateTo(context, AppRouteName.HelpSupport);}),
    MenuModel(name: 'Settings',image: ImagePath.settings,onTap: (context){AppNavigation.navigateTo(context, AppRouteName.SETTINGS_ROUTE);}),
    MenuModel(name: 'Logout',image: ImagePath.logout,onTap: (context){ showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: const EdgeInsets.fromLTRB(
                  0, 0, 0, 0),
              content: LogoutAlert(),
            ),
          );
        }
    );}),
    // MenuModel(name: 'Terms & Conditions',image: ImagePath.terms,onTap: (context){
    // AppNavigation.navigateTo(context, AppRouteName.CONTENT_SCREEN,
    //     arguments: ContentRoutingArgument(
    //         title:'Terms & Conditions',
    //         contentType: AppStrings.TERMS_AND_CONDITION_TYPE,
    //         url: 'https://www.google.com/'));}),
  ];
}

