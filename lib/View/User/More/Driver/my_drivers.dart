import 'package:drivy_driver/Utils/image_path.dart';
import 'package:drivy_driver/View/User/More/Driver/driver_tile.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:drivy_driver/Component/custom_empty_data.dart';
import 'package:drivy_driver/Component/custom_padding.dart';
import 'package:drivy_driver/Component/custom_refresh.dart';
import 'package:drivy_driver/Controller/home_controller.dart';
import 'package:drivy_driver/Model/category_product_model.dart';
import 'package:drivy_driver/View/base_view.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Component/custom_image.dart';
import '../../../../Component/custom_text.dart';
import '../../../../Utils/my_colors.dart';

class MyDrivers extends StatefulWidget {
  @override
  State<MyDrivers> createState() => _MyDriversState();
}

class _MyDriversState extends State<MyDrivers> with SingleTickerProviderStateMixin{

  final _tabs = [const Tab(text: 'All'), const Tab(text: 'Favorites')];
  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    fetchData(loading: true);
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
    return BaseView(
        screenTitle: 'My Drivers',
        showAppBar: true,
        centerTitle: false,
        showBackButton: true,
        // resizeBottomInset: false,
        child: GetBuilder<HomeController>(
            builder: (d) {
            return CustomRefresh(
              onRefresh: () async{
                await fetchData(loading: false);
              },
              child: CustomPadding(
                topPadding: 1.h,
                horizontalPadding: 3.w,
                child: Column(
                  children: [
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
                          // isScrollable: true,
                          indicator: BoxDecoration(
                              border: Border(bottom: BorderSide(width: 2.0, color:MyColors().primaryColor,),)
                          ),
                          unselectedLabelStyle: GoogleFonts.poppins(
                            color: MyColors().lightGreyColor.withOpacity(.1),
                          ),
                          labelColor: MyColors().black,
                          labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 16,),
                          tabs: _tabs,
                          onTap: (v){
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h,),

                    myWishList(p: d.wishlist),
                  ],
                ),
              ),
            );
          }
        ),
    );
  }
  Widget myWishList({required RxList<ProductsModel> p}){
    return Expanded(
      child: p.isNotEmpty?CustomEmptyData(title: 'No Products',):
      ListView.builder(
          physics: AlwaysScrollableScrollPhysics(parent: const ClampingScrollPhysics()),
          // shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context,index){
            return DriverTile(onTap: (){},);
          }),
    );
  }
  Future<void> fetchData({bool? loading}) async{
    await HomeController.i.getWishlistProducts(loading: loading,context: context);
  }
}