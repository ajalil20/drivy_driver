import 'package:google_fonts/google_fonts.dart';
import 'package:drivy_user/Component/Appbar/appbar_components.dart';
import 'package:drivy_user/Component/custom_empty_data.dart';
import 'package:drivy_user/Component/custom_icon_container.dart';
import 'package:drivy_user/Component/custom_image.dart';
import 'package:drivy_user/Component/custom_padding.dart';
import 'package:drivy_user/Component/custom_refresh.dart';
import 'package:drivy_user/Controller/home_controller.dart';
import 'package:drivy_user/Model/category_product_model.dart';
import 'package:drivy_user/Model/order_model.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/app_router_name.dart';
import 'package:drivy_user/Utils/my_colors.dart';
import 'package:drivy_user/View/Widget/bordered_container.dart';
import 'package:drivy_user/View/Widget/search_tile.dart';

import 'package:drivy_user/View/Widget/view_all_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:drivy_user/View/base_view.dart';
import '../../../Utils/image_path.dart';
import '../../Component/custom_text.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class Bookings extends StatefulWidget {
  const Bookings({super.key});
  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> with SingleTickerProviderStateMixin{
  TextEditingController s = TextEditingController();
  final _tabs = [const Tab(text: 'Rides'), const Tab(text: 'Chauffeurs'), const Tab(text: 'Car Rentals'), const Tab(text: 'City to City'),];
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
        screenTitle: "My Order History",
        trailingAppBar: NotificationIcon(),
        child: GetBuilder<HomeController>(
            builder: (d) {
            return CustomRefresh(
              onRefresh: () async{
                await fetchData(fetchAll: false);
              },
              child: CustomPadding(
                topPadding: 2.h,
                horizontalPadding: 3.w,
                child:  SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomAppBar(screenTitle: "My Order History",leading: MenuIcon(),trailing: NotificationIcon(),bottom: 2.h,),
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
                        isScrollable: true,
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
                      ),
                    ],
                  ),
                      SizedBox(height: 2.h,),
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: status.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _buildPlayerModelList(t:status[index] );
                        },
                      ),
                      // orderList(o: _tabController.index==0?d.recentOrders:d.pastOrders,showPopup: _tabController.index==0),
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
  Widget orderList({required RxList<OrderModel> o,required bool showPopup}){
    return Expanded(
      child: o.isEmpty?CustomEmptyData(title: 'No Orders',):
      ListView.builder(
          physics: AlwaysScrollableScrollPhysics(parent: const ClampingScrollPhysics()),
          shrinkWrap: true,
          itemCount: o.length,
          itemBuilder: (context,index){
            return Container();
          }),
    );
  }
  Widget _buildPlayerModelList({required String t}) {
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
              AppNavigation.navigateTo(context, AppRouteName.BookingDetail);
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
  Future<void> fetchData({required bool fetchAll}) async{
    if(fetchAll){
      await HomeController.i.getOrderHistory(loading: fetchAll,context: context,recent: true);
      await HomeController.i.getOrderHistory(context: context,recent: false);
    }else if(_tabController.index==0 || fetchAll){
      await HomeController.i.getOrderHistory(loading: fetchAll,context: context,recent: true);
    } else if(_tabController.index==1 || fetchAll){
      await HomeController.i.getOrderHistory(context: context,recent: false);
    }
  }
}
