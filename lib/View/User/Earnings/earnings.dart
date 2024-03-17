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

class Earnings extends StatefulWidget {
  const Earnings({super.key});

  @override
  State<Earnings> createState() => _EarningsState();
}

class _EarningsState extends State<Earnings> {
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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.w),
                          child: CustomAppBar(screenTitle: "",
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
                        ),
                        MyText(title: 'Income Status',size: 16,clr: MyColors().black,),
                        SizedBox(height: 1.h),
                        Row(
                          children: [
                            MyText(title: 'AED 699,996  ',size: 20,clr: MyColors().black,fontWeight: FontWeight.w600,),
                            MyText(title: '+ 1700.254 (9.77%)',size: 16,clr: MyColors().greenColor,),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Image.asset(ImagePath.graph,),
                        SizedBox(height: 2.h),
                        MyText(title: 'Recent Transactions',size: 16,fontWeight: FontWeight.w600,clr: MyColors().textColor),
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
                          child:Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.w)+EdgeInsets.only(right: 2.w),
                                child: Image.asset(ImagePath.transfer,scale: 2,),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(title: 'Transfered money to William',fontWeight: FontWeight.w600,size: 13,),
                                    SizedBox(height: .5.h),
                                    MyText(title: '08:58 PM',clr: MyColors().hintColor,),

                                  ],
                                ),
                              ),
                            ],
                          ),
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
                          padding: EdgeInsets.all(12)+EdgeInsets.symmetric(vertical: 6),
                          child:Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.w)+EdgeInsets.only(right: 2.w),
                                child: Image.asset(ImagePath.receive,scale: 2,),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(title: 'Received money \$20 from Dito',fontWeight: FontWeight.w600,size: 13,),
                                    SizedBox(height: .5.h),
                                    MyText(title: '08:05 PM',clr: MyColors().hintColor,),

                                  ],
                                ),
                              ),
                            ],
                          ),
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
                          padding: EdgeInsets.all(12)+EdgeInsets.symmetric(vertical: 6),
                          child:Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.w)+EdgeInsets.only(right: 2.w),
                                child: Image.asset(ImagePath.transfer,scale: 2,),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(title: 'Transfered Money to Ilham',fontWeight: FontWeight.w600,size: 13,),
                                    SizedBox(height: .5.h),
                                    MyText(title: '07:58 PM',clr: MyColors().hintColor,),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2.h),
                        SizedBox(height: 2.h),
                      ],
                    ),
                  ),
                );
              }
          ),
        ),
      ),
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
