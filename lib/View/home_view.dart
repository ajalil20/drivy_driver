import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:drivy_user/Component/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:drivy_user/Controller/home_controller.dart';
import 'package:drivy_user/Controller/auth_controller.dart';
import 'package:drivy_user/Utils/image_path.dart';
import 'package:drivy_user/Utils/my_colors.dart';
import 'package:drivy_user/View/User/Home/home.dart';
import 'package:drivy_user/View/User/more.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'User/bookings.dart';
import 'User/chat.dart';

class HomeView extends StatelessWidget{
  HomeView({this.i});
  int? i=0;
  AuthController a = Get.put(AuthController());
  HomeController h = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return  WillPopScope(
      onWillPop:(){
        return onWillPop(context);
      },
      child: MainScreens(index: i??0,)
    );
  }
  onWillPop(context) async {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return false;
  }
}


class MainScreens extends StatefulWidget {
  MainScreens({required this.index});
  int index = 0;
  @override
  State<MainScreens> createState() => _MainScreensState();
}
class _MainScreensState extends State<MainScreens> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors().whiteColor,
        body: (userPages[widget.index]),
        // PageView(
        //   physics: BouncingScrollPhysics(),
        //   controller: PageController(initialPage: index),
        //   children:user,
        //   onPageChanged: (i){_appBarKey.currentState?.animateTo(i);} ,
        // ),
        extendBody: true,
        bottomNavigationBar:  Container(
          color: Colors.white,
          child:
          AnimatedBottomNavigationBar.builder(
            itemCount: userTab.length,
            // height: 65,
            activeIndex: widget.index,
            safeAreaValues: SafeAreaValues(
              bottom: false,
              top: false
            ),
            tabBuilder: (int index, bool isActive) {
              final color = isActive
                  ? MyColors().primaryColor
                  : MyColors().greyColor;
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isActive?userTab[index].activeIcon: userTab[index].icon,
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: MyText(
                      title: userTab[index].title!,
                      clr: color,
                    ),
                  )
                ],
              );
            },
            // backgroundColor: colors.bottomNavigationBarBackgroundColor,
            // activeIndex: _bottomNavIndex,
            splashColor: MyColors().primaryColor,
            // notchAndCornersAnimation: borderRadiusAnimation,
            splashSpeedInMilliseconds: 300,
            notchSmoothness: NotchSmoothness.defaultEdge,
            gapLocation: GapLocation.none,
            leftCornerRadius: 0,
            rightCornerRadius: 0,
            onTap: (index) => setState(() => widget.index = index),
            // hideAnimationController: _hideBottomBarAnimationController,
            shadow: BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 12,
              spreadRadius: 0.5,
              color: Colors.grey,
            ),
          ),
        ),
    );
  }

  List<Widget> userPages = <Widget>[const Home(), const Bookings(), const ChatScreen(), More(),];
  List<TabItem> userTab = <TabItem>[
    TabItem(icon: Image.asset(ImagePath.homeIcon,scale: 2,),activeIcon: Image.asset(ImagePath.homeIcon,scale: 2,color: MyColors().primaryColor,),  title: 'Home'),
    TabItem(icon: Image.asset(ImagePath.calendarIcon,scale: 2,),activeIcon: Image.asset(ImagePath.calendarIcon,scale: 2,color: MyColors().primaryColor,),  title: 'Bookings'),
    TabItem(icon: Image.asset(ImagePath.chatIcon,scale: 2,),activeIcon: Image.asset(ImagePath.chatIcon,scale: 2,color: MyColors().primaryColor,),  title: 'Chat'),
    TabItem(icon: Image.asset(ImagePath.menuIcon,scale: 2,),activeIcon: Image.asset(ImagePath.menuIcon,scale: 2,color: MyColors().primaryColor,),  title: 'More'),
  ];
}
