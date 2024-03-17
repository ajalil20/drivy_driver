import 'package:drivy_driver/Arguments/screen_arguments.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drivy_driver/Component/Appbar/appbar_components.dart';
import 'package:drivy_driver/Component/custom_padding.dart';
import 'package:drivy_driver/Component/custom_refresh.dart';
import 'package:drivy_driver/Controller/home_controller.dart';
import 'package:drivy_driver/Model/category_product_model.dart';
import 'package:drivy_driver/Model/order_model.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:drivy_driver/View/Widget/bordered_container.dart';
import 'package:drivy_driver/View/Widget/search_tile.dart';

import 'package:drivy_driver/View/Widget/view_all_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:drivy_driver/View/base_view.dart';
import '../../../../Utils/image_path.dart';
import '../../../Component/custom_text.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class Bookings extends StatefulWidget {
  const Bookings({super.key});
  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> with SingleTickerProviderStateMixin{
  TextEditingController s = TextEditingController();
  final _tabs = [const Tab(text: 'Rides'), const Tab(text: 'Chauffeurs'),
    // const Tab(text: 'Car Rentals'), const Tab(text: 'City to City'),
  ];
  List status = [
    'Active','Completed','Cancelled',
  ];
  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    // fetchData(fetchAll: true);
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  late TabController _tabController;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() => true);
        // return Utils().onWillPop(context, currentBackPressTime: currentBackPressTime);
      },
      child: BaseView(
        showAppBar: false,
        leadingAppBar: MenuIcon(),
        showBottomBar: true,
        resizeBottomInset: false,
        showDrawer: true,
        centerTitle: false,
        screenTitle: "Bookings",
        trailingAppBar: NotificationIcon(),
        child: GetBuilder<HomeController>(
            builder: (d) {
            return CustomRefresh(
              onRefresh: () async{
                // await fetchData(fetchAll: false);
              },
              child: CustomPadding(
                topPadding: 2.h,
                horizontalPadding: 3.w,
                child:  SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomAppBar(screenTitle: "Bookings",trailing: NotificationIcon(),bottom: 2.h,a: Alignment.centerLeft,),
                      Stack(
                      fit: StackFit.passthrough,
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: MyColors().greyColor.withOpacity(.3), width: 2.0),
                          ),
                        ),
                      ),
                      TabBar(
                        controller: _tabController,
                        isScrollable: false,
                        indicator: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 2.0, color:MyColors().primaryColor,),)
                        ),
                        unselectedLabelStyle: GoogleFonts.poppins(
                          color: MyColors().lightGreyColor.withOpacity(.1),
                        ),
                        labelColor: MyColors().black,
                        labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 16),
                        tabs: _tabs,
                        onTap: (v){
                          setState(() {});
                        },
                      ),],
                      ),
                      SizedBox(height: 2.h,),
                      if(_tabController.index==0 || _tabController.index==1)
                      rideList(),
                      if(_tabController.index==2)
                      rentalList(),
                      if(_tabController.index==3)
                      cityList(),
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
  rideList(){
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: status.length,
      itemBuilder: (BuildContext context, int index) {
        return rides(t:status[index] );
      },
    );
  }
  Widget rides({required String t}) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(title: '$t   ',size: 18,fontWeight: FontWeight.w600,clr: MyColors().textColor),
            Expanded(child: Divider(color: Colors.grey))
          ],
        ),
        children: <Widget>[
          GestureDetector(
            onTap: (){
              AppNavigation.navigateTo(context, AppRouteName.RideBookingDetail,arguments: ScreenArguments(fromRide: _tabController.index==0));
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xffDAE1F1),
                ),
                borderRadius: BorderRadius.circular(12),
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
              child:  Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Column(children: [
                      Image.asset(ImagePath.marker,scale: 2,),
                      SizedBox(height: .5.h,),
                      MyText(title: '50.00',size: 15,clr: MyColors().primaryColor,fontWeight: FontWeight.w600,),
                      MyText(title: 'AED',size: 15,fontWeight: FontWeight.w600,),

                    ],),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(title: 'Marilyn Lipshutz',size: 15,fontWeight: FontWeight.w600,),
                                  MyText(title: _tabController.index==0?'Ride':'Chauffeur',size: 12,),
                                ],
                              ),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color:   t=='Active'?  MyColors().primaryColor.withOpacity(.1):
                                  t=='Completed'?  MyColors().greenColor.withOpacity(.1):
                                  t=='Cancelled'?  MyColors().redColor.withOpacity(.1):null,
                                ),
                                padding: EdgeInsets.all(4)+EdgeInsets.symmetric(horizontal: 8),
                                child: MyText(title: '$t',size: 12,clr:
                                t=='Active'?  MyColors().primaryColor:
                                t=='Completed'?  MyColors().greenColor:
                                t=='Cancelled'?  MyColors().redColor:null,
                                )),
                          ],
                        ),
                        SizedBox(height: .5.h,),
                        Divider(color: MyColors().hintColor,),
                        SizedBox(height: .5.h,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                MyText(title: 'Booking ID  ',size: 15,clr: MyColors().greyColor,fontWeight: FontWeight.w600,),
                                MyText(title: '#587456',size: 15,clr: MyColors().black,fontWeight: FontWeight.w600,),
                              ],
                            ),
                            SizedBox(height: .5.h,),
                            MyText(title: 'Placed on 25 Dec, 08:00PM',size: 12,clr: MyColors().greyColor,fontWeight: FontWeight.w500,),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  rentalList(){
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: status.length,
      itemBuilder: (BuildContext context, int index) {
        return rentals(t:status[index] );
      },
    );
  }
  Widget rentals({required String t}) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(title: '$t   ',size: 18,fontWeight: FontWeight.w600,clr: MyColors().textColor),
            Expanded(child: Divider(color: Colors.grey))
          ],
        ),
        children: <Widget>[
          GestureDetector(
            onTap: (){
              AppNavigation.navigateTo(context, AppRouteName.RentalBookingDetail);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xffDAE1F1),
                ),
                borderRadius: BorderRadius.circular(20),
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
                  ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset(ImagePath.car,width: 20.w,)),
                  SizedBox(width: 5.w,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(title: 'S 500 Sedan',size: 15,fontWeight: FontWeight.w600,),
                        SizedBox(height: 1.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(title: '10/05/2023',size: 12,clr: Color(0xff9695A8),),
                            MyText(title: '10/05/2023',size: 12,clr: Color(0xff9695A8),),
                          ],
                        ),
                        Center(child: Image.asset(ImagePath.dotLine,scale: 2,)),
                        // SizedBox(height: .5.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(title: '08 : 00 AM',size: 12,clr: Color(0xff9695A8),),
                            MyText(title: '08 : 00 PM',size: 12,clr: Color(0xff9695A8),),
                          ],
                        ),
                        SizedBox(height: .5.h,),
                        Divider(color: Colors.grey),
                        SizedBox(height: .5.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(title: 'AED 50.00',size: 15,fontWeight: FontWeight.w600,),
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color:   t=='Active'?  MyColors().primaryColor.withOpacity(.1):
                                  t=='Completed'?  MyColors().greenColor.withOpacity(.1):
                                  t=='Cancelled'?  MyColors().redColor.withOpacity(.1):null,
                                ),
                                padding: EdgeInsets.all(4)+EdgeInsets.symmetric(horizontal: 8),
                                child: MyText(title: '$t',size: 12,clr:
                                t=='Active'?  MyColors().primaryColor:
                                t=='Completed'?  MyColors().greenColor:
                                t=='Cancelled'?  MyColors().redColor:null,
                                )),
                          ],
                        ),
                      ],),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  cityList(){
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: status.length,
      itemBuilder: (BuildContext context, int index) {
        return cities(t:status[index] );
      },
    );
  }
  Widget cities({required String t}) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(title: '$t   ',size: 18,fontWeight: FontWeight.w600,clr: MyColors().textColor),
            Expanded(child: Divider(color: Colors.grey))
          ],
        ),
        children: <Widget>[
          GestureDetector(
            onTap: (){
              AppNavigation.navigateTo(context, AppRouteName.CityBookingDetail);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xffDAE1F1),
                ),
                borderRadius: BorderRadius.circular(20),
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
                  Image.asset(ImagePath.random0,scale: 1,),
                  SizedBox(height: 1.5.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(title: 'AED 1000.00',size: 15,clr: MyColors().primaryColor,fontWeight: FontWeight.w600,),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color:   t=='Active'?  MyColors().primaryColor.withOpacity(.1):
                            t=='Completed'?  MyColors().greenColor.withOpacity(.1):
                            t=='Cancelled'?  MyColors().redColor.withOpacity(.1):null,
                          ),
                          padding: EdgeInsets.all(4)+EdgeInsets.symmetric(horizontal: 8),
                          child: MyText(title: '$t',size: 12,clr:
                          t=='Active'?  MyColors().primaryColor:
                          t=='Completed'?  MyColors().greenColor:
                          t=='Cancelled'?  MyColors().redColor:null,
                          )),
                    ],
                  ),
                  SizedBox(height: 1.h,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(title:'Atlantis Dubai ',size: 16,clr: MyColors().textColor),
                      Row(
                        children: [
                          Icon(Icons.location_on,color: MyColors().primaryColor,),
                          MyText(title:'Salahuddin Rd Deira, Dubai, Emirates ',size: 12,clr: MyColors().textColor),
                        ],
                      ),
                    ],
                  ),

                ],),
            ),
          ),
        ],
      ),
    );
  }

  // Future<void> fetchData({required bool fetchAll}) async{
  //   if(fetchAll){
  //     await HomeController.i.getOrderHistory(loading: fetchAll,context: context,recent: true);
  //     await HomeController.i.getOrderHistory(context: context,recent: false);
  //   }else if(_tabController.index==0 || fetchAll){
  //     await HomeController.i.getOrderHistory(loading: fetchAll,context: context,recent: true);
  //   } else if(_tabController.index==1 || fetchAll){
  //     await HomeController.i.getOrderHistory(context: context,recent: false);
  //   }
  // }
}
