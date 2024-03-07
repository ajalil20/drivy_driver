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
import '../../../../Utils/image_path.dart';
import '../../../Component/custom_text.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController s = TextEditingController();
  // RxBool searchOn = false.obs;
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
                    Container(
                      height: 16.h,
                      child: PageView.builder(
                        controller: controller,
                        // itemCount: pages.length,
                        itemBuilder: (_, index) {
                          return Image.asset(ImagePath.random1,scale: 2,);
                        },
                      ),
                    ),
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: pages.length,
                        effect: WormEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          type: WormType.thinUnderground,
                          activeDotColor: MyColors().primaryColor
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    MyText(title: 'Welcome Back Mary Jane',size: 15,),
                    MyText(title: 'Explore Rides',size: 25,clr: MyColors().black,fontWeight: FontWeight.w700,),
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
