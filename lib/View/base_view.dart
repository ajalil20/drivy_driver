import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:drivy_user/Component/custom_text.dart';
import 'package:drivy_user/Utils/my_colors.dart';
import 'package:sizer/sizer.dart';



class BaseView extends StatelessWidget {
  final Widget? child,floating;
  final showAppBar;
  final String? screenTitle,screenSubtitle, bgImage;
  final Widget? leadingAppBar;
  final Widget? trailingAppBar;
  final double? leadingWidth;
  Function? onTapTrailing,onTapSubtitle;
  Color? backgroundColor, screenTitleColor, statusBarColor, appbarColor, backColor;
  final bool? centerTitle, topSafeArea,bottomSafeArea, showBackButton,showBackgroundImage, showBottomBar, resizeBottomInset ,showDrawer;
  Function? onTapBackButton, onTapFloatingButton;
  // BottomBarController bottomBarController = Get.put(BottomBarController());
  final GlobalKey? scafoldkey;

  BaseView({super.key,
    this.child,
    this.screenTitle,
    this.showAppBar,
    this.floating,
    this.bgImage,
    this.scafoldkey,
    this.bottomSafeArea=true,
    this.topSafeArea=true,
    this.statusBarColor,
    this.centerTitle,
    this.onTapSubtitle,
    this.showDrawer=false,
    this.backColor,
    this.onTapBackButton,
    this.screenTitleColor,
    this.leadingWidth,
    this.showBackButton = false,
    this.leadingAppBar,
    this.screenSubtitle,
    this.showBackgroundImage=false,
    this.resizeBottomInset,
    this.onTapTrailing,
    this.appbarColor,
    this.backgroundColor,
    this.trailingAppBar,
    this.showBottomBar = false,
  });
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: backgroundColor ?? MyColors().whiteColor,
       resizeToAvoidBottomInset: resizeBottomInset??true,
       // key: showDrawer == true ? _scaffoldKey : null,
       // drawer:showDrawer == true ? Container(
       //   width: 400,
       //   color: Colors.red,
       // ):null,
       appBar: showAppBar == true
           ? AppBar(
         leadingWidth: leadingWidth,
         backgroundColor: backgroundColor ?? MyColors().whiteColor,
         leading: showBackButton == false ?
         Padding(padding: EdgeInsets.only(top: .8.h, bottom: .8.h,left: 3.w,right: 0.h), child: Container(decoration: BoxDecoration( borderRadius: BorderRadius.circular(6),), child: leadingAppBar),)
         // Padding(padding: EdgeInsets.only(top: .6.h, bottom: .6.h,left: 2.w,right: 0.h), child: Container(decoration: BoxDecoration( borderRadius: BorderRadius.circular(6),), child: leadingAppBar),)
         // Padding(padding: EdgeInsets.only(top: 7, bottom: 7,left: 10,right: 0), child: Container(decoration: BoxDecoration( borderRadius: BorderRadius.circular(6),), child: leadingAppBar),)
             : InkWell(
           onTap: () {
             FocusManager.instance.primaryFocus?.unfocus();
             onTapBackButton == null ?
             Get.back() : onTapBackButton!();
           },
           splashFactory: NoSplash.splashFactory,
           hoverColor: Colors.transparent,
           splashColor: Colors.transparent,
           highlightColor: Colors.transparent,
           child: Padding(
             padding: EdgeInsets.symmetric(
                 vertical: .6.h, horizontal: 1.h),
             child: CircleAvatar(
               backgroundColor: Colors.white,
               child: Icon(
                 Icons.chevron_left,
                 color: backColor??Colors.black,
                 size: 18.sp,
               ),
             ),
           ),
         ),
         centerTitle:centerTitle?? true,
         title: MyText(title: screenTitle ?? '',
             center: true,
             line: 2,
             size: 16,
             toverflow: TextOverflow.ellipsis,
             fontWeight: FontWeight.w600,
             clr: screenTitleColor??MyColors().titleColor),
         elevation: .2,
         actions: <Widget>[trailingAppBar??Container()],
       )
           : null,
       extendBodyBehindAppBar: true,
       body: Container(
           width: 100.w,
           height: 100.h,
           decoration: BoxDecoration(
             image: bgImage==null?null: DecorationImage(image: AssetImage(bgImage!),fit: BoxFit.cover)
           ),
           child: SafeArea(
             bottom: bottomSafeArea??true,
             top: topSafeArea??true,
               child: child!)),
       floatingActionButton:Padding(padding: EdgeInsets.only(bottom: 2.h), child: floating),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

     ) ;
  }

}
