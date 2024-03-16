import 'package:drivy_driver/Component/Appbar/appbar_components.dart';
import 'package:drivy_driver/Component/custom_empty_data.dart';
import 'package:drivy_driver/Component/custom_icon_container.dart';
import 'package:drivy_driver/Component/custom_image.dart';
import 'package:drivy_driver/Component/custom_padding.dart';
import 'package:drivy_driver/Component/custom_refresh.dart';
import 'package:drivy_driver/Controller/home_controller.dart';
import 'package:drivy_driver/Model/menu_model.dart';
import 'package:drivy_driver/Model/stream_model.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:drivy_driver/View/Widget/search_tile.dart';
import 'package:drivy_driver/View/Widget/streaming_card.dart';

import 'package:drivy_driver/View/Widget/view_all_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:drivy_driver/View/base_view.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Utils/image_path.dart';
import '../../../Component/custom_switch.dart';
import '../../../Component/custom_text.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController s = TextEditingController();
  bool night = false;
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  List pages = [ImagePath.random1,ImagePath.random1,ImagePath.random1];
  List<MenuModel> rides =[
    MenuModel(image: ImagePath.home1,name: 'Ride with Drivy',description: 'Lorem ipsum dolor sit amet, consectetur  elit.',onTap: (context){AppNavigation.navigateTo(context, AppRouteName.Ride);}),
    MenuModel(image: ImagePath.home2,name: 'Hire a Chauffer',description: 'Lorem ipsum dolor sit amet, consectetur  elit.',onTap: (context){AppNavigation.navigateTo(context, AppRouteName.SelectCar);}),
    MenuModel(image: ImagePath.home3,name: 'Drivy Rental Cars',description: 'Lorem ipsum dolor sit amet, consectetur  elit.',onTap: (context){AppNavigation.navigateTo(context, AppRouteName.CarRentals);}),
    MenuModel(image: ImagePath.home4,name: ' City to City',description: 'Lorem ipsum dolor sit amet, consectetur  elit.',onTap: (context){AppNavigation.navigateTo(context, AppRouteName.CityToCity);}),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() => true);
        // return Utils().onWillPop(context, currentBackPressTime: currentBackPressTime);
      },
      child: BaseView(
        showAppBar: false,
        showBottomBar: true,
        resizeBottomInset: false,
        showDrawer: false,
        showBackButton: false,
        screenTitle: "Home",
        leadingAppBar: MenuIcon(),
        trailingAppBar: NotificationIcon(),
        child: CustomRefresh(
          onRefresh: () async {
            // await fetchData(loading: false);
          },
          child: GetBuilder<HomeController>(
            builder: (d) {
              return CustomPadding(
                topPadding: 2.h,
                horizontalPadding: 3.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar(screenTitle: "",
                      leading: Row(children: [
                        CustomImage(height: 5.h,width: 5.h,isProfile: true,radius: 200,),
                        SizedBox(width: 2.w,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          MyText(title: 'My Location',size: 12,clr: MyColors().greyColor,),
                          MyText(title: 'This is a dummy address',size: 12,),
                        ],)
                      ],),
                      trailing: Row(
                      children: [
                        // ChatIcon(),
                        // SizedBox(width: 2.w,),
                        NotificationIcon(),
                      ],
                    ),bottom: 2.h,),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(title: 'Welcome Back',size: 15,),
                              MyText(title: 'Mary Jane',size: 25,clr: MyColors().black,fontWeight: FontWeight.w700,),
                            ],
                          ),
                        ),
                        MyText(title: 'Availability   ',size: 15),
                        CustomSwitch(switchValue: night.obs,onChange: (v){},),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffDAE1F1),
                        ),
                        borderRadius: BorderRadius.circular(8),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(title: 'Your Total Earning is',size: 15,),
                          SizedBox(height: 1.h),
                          MyText(title: 'AED 699,996',size: 28,clr: MyColors().black,fontWeight: FontWeight.w600,),
                          SizedBox(height: 1.h),
                          Row(
                            children: [
                              Image.asset(ImagePath.triangle),
                              RichText(
                                textAlign: TextAlign.center,
                                textScaleFactor: 1.03,
                                text: TextSpan(
                                  text: "  0.4%  ",
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: MyColors().greenColor
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'AED 78.21',
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          color: MyColors().greyColor
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],),
                    ),
                    SizedBox(height: 2.h),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffDAE1F1),
                        ),
                        borderRadius: BorderRadius.circular(8),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(title: 'Rides Completed',size: 15,),
                          SizedBox(height: 1.h),
                          MyText(title: '75 Rides ',size: 28,clr: MyColors().black,fontWeight: FontWeight.w600,),
                          SizedBox(height: 1.h),
                          Row(
                            children: [
                              Image.asset(ImagePath.triangle),
                              RichText(
                                textAlign: TextAlign.center,
                                textScaleFactor: 1.03,
                                text: TextSpan(
                                  text: "  0.4%  ",
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: MyColors().greenColor
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '4 Rides',
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          color: MyColors().greyColor
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],),
                    ),
                    SizedBox(height: 2.h),
                    MyText(title: 'Requests',size: 18,fontWeight: FontWeight.w600,clr: MyColors().textColor),
                    SizedBox(height: 2.h),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffDAE1F1),
                        ),
                        borderRadius: BorderRadius.circular(8),
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
                      padding: EdgeInsets.all(12)+EdgeInsets.symmetric(vertical: 6),
                      child:Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(title: 'Ride Now ',size: 15,),
                              MyText(title: '4.5 km',size: 13,clr: MyColors().primaryColor,),

                            ],
                          ),
                          SizedBox(height: 1.h,),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.w, vertical:0.w),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Color(0xffE6EBEF))),
                            child: LinearPercentIndicator(
                              width: 80.7.w,
                              animation: true,
                              lineHeight: 5,
                              padding: EdgeInsets.all(0),
                              animationDuration: 2000,
                              percent: .6,
                              backgroundColor: Colors.transparent,
                              animateFromLastPercent: true,
                              barRadius: Radius.circular(12),
                              progressColor: MyColors().primaryColor,
                              // maskFilter: MaskFilter.blur(BlurStyle.solid, 3),
                            ),
                          ),
                          SizedBox(height: 1.h,),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        MyText(title: 'Booking ID  ',size: 15,clr: MyColors().greyColor,fontWeight: FontWeight.w600,),
                                        MyText(title: '#587456',size: 15,clr: MyColors().black,fontWeight: FontWeight.w600,),
                                      ],
                                    ),
                                    SizedBox(height: .5.h,),
                                    MyText(title: 'Standard Car ',size: 15,clr: MyColors().greyColor,),
                                    SizedBox(height: 1.h,),

                                    Row(children: [
                                      Image.asset(ImagePath.source,scale: 2,),
                                      SizedBox(width: 2.w,),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            MyText(title: 'Soft Bank Buildings',fontWeight: FontWeight.w600,size: 15,),
                                            MyText(title: '25 State St. Daphne, Al 3456',clr: MyColors().greyColor,),
                                          ],
                                        ),
                                      ),
                                    ],),
                                  ],
                                ),
                              ),
                              SizedBox(width: 2.w,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Image.asset(ImagePath.tick,width: 10.w,),
                                SizedBox(height: 1.h,),
                                Image.asset(ImagePath.cancel,width: 10.w,),
                              ],)
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 2.h),
                    ridesList(r:rides),
                    SizedBox(height: 2.h),
                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }
  Widget ridesList({required List<MenuModel> r}){
    return Expanded(
      child: r.isEmpty?CustomEmptyData(title: 'No Rides',):
      GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1.2,crossAxisSpacing: 3.w,mainAxisSpacing: 3.w,),
          physics: AlwaysScrollableScrollPhysics(parent: const ClampingScrollPhysics()),
          shrinkWrap: true,
          itemCount: r.length,
          itemBuilder: (context,index){
            return GestureDetector(
              onTap: (){
                r[index].onTap!(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffDAE1F1),
                  ),
                  borderRadius: BorderRadius.circular(8),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Image.asset(r[index].image!,scale: 2,),
                  SizedBox(height: 1.5.h,),
                  MyText(title: r[index].name!,size: 15,clr: MyColors().black,fontWeight: FontWeight.w600,),
                  SizedBox(height: 1.h,),
                  MyText(title: r[index].description!,size: 13,clr: MyColors().greyColor,center: true),

                ],),
              ),
            );
        }),
    );
  }

  getData(){
  //   WidgetsBinding.instance.addPostFrameCallback((_){
  //     HomeController.i.getLocalCart();
  //     fetchData(loading: true);
  //   });
  // }
  // Future<void> fetchData({loading}) async{
  //   await HomeController.i.getStreaming(loading:loading??true,context: context);
  }
}
