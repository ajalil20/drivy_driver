import 'dart:ui';
import 'package:drivy_user/Component/custom_buttom.dart';
import 'package:drivy_user/Component/custom_textfield.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/image_path.dart';
import 'package:drivy_user/Utils/my_colors.dart';
import 'package:drivy_user/View/base_view.dart';
import 'package:flutter/material.dart';
import '../../../../Component/custom_bottomsheet_indicator.dart';
import '../../../../Component/custom_image.dart';
import '../../../../Component/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import '../../../../Utils/app_router_name.dart';
import '../../../../Utils/app_size.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Ride extends StatelessWidget {
  GoogleMapController? mapController;
  static double CAMERA_ZOOM = 16;
  static double CAMERA_TILT = 80;
  static double CAMERA_BEARING = 30;
  List pastLocations = ['Home','Wasen','Planck StrawBerry','Home','Wasen','Planck StrawBerry'];
  RxInt i =0.obs;
  double rate = 0;

  @override
  Widget build(BuildContext context) {
    return BaseView(
          showAppBar: false,
      topSafeArea:false,
      bottomSafeArea:false,
        child:Obx(()=> Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition:
                CameraPosition(
                    zoom: CAMERA_ZOOM,
                    tilt: CAMERA_TILT,
                    bearing: CAMERA_BEARING,
                    target: LatLng(24.8296, 67.0415)),
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
              ),
              if(i.value!=4)
              Positioned(
                top: 5.h,
                left: 4.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){if(i.value!=0){i--;}else{AppNavigation.navigatorPop(context);}},
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.chevron_left,
                              color: Colors.black,
                              size: 18.sp,
                            ),
                          ),
                          if(i.value==4)
                          MyText(title: 'Searching for Driver',fontWeight: FontWeight.w600,)
                        ],
                      ),
                    ),
                    if(i.value==3)...[
                      MyText(title: 'Featured Drivers',fontWeight: FontWeight.w600,size: 16,),
                      SizedBox(height: 1.h,),
                      Container(height: 7.h,
                        width: 100.w,
                        alignment: Alignment.center,
                        child:  ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: pastLocations.length,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index){
                            return GestureDetector(
                                onTap: () {
                                  // AppNavigation.navigateTo(context, AppRouteName.CHAT_SCREEN_ROUTE,arguments: ScreenArguments(u:c.user));
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
                                  width: 70.w,
                                  // alignment: Alignment.bottomCenter,
                                  margin: EdgeInsets.only(right: 3.w),
                                  // padding: EdgeInsets.all(12),
                                  padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 2.w),
                                  child:  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 2.8.h,
                                        backgroundColor: MyColors().whiteColor,
                                        child: CustomImage(
                                          height: 6.h,
                                          width: 6.h,
                                          isProfile: true,
                                          photoView: false,
                                          // url: c.user?.userImage,
                                          radius: 100,
                                        ),
                                      ),
                                      SizedBox(width : 2.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Expanded(child: MyText(title: 'Jaylon',fontWeight: FontWeight.w700,line: 1,)),
                                                SizedBox(width: 3.w),
                                                Icon(Icons.star_rounded,color: Color(0xffFBC400),),
                                                SizedBox(width: 3.w),
                                                MyText(
                                                  title: '4.8',
                                                  size: 12,
                                                  clr: MyColors().greyColor,
                                                  line: 1,
                                                  toverflow: TextOverflow.ellipsis,
                                                ),
                                                // MyText(
                                                //   title: Utils.relativeTime(c.createdAt),
                                                //   size: 12,
                                                //   clr: MyColors().greyColor,
                                                //   line: 1,
                                                //   toverflow: TextOverflow.ellipsis,
                                                // ),
                                              ],
                                            ),
                                            // SizedBox(height: .5.h),
                                            MyText(
                                              title: 'Mercedes-Benz E-class',
                                              size: 12,
                                              clr: MyColors().greyColor,
                                              line: 1,
                                              toverflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            );
                          },),),
                    ],
                  ],
                ),
              ),
              if(i.value==0)
              startLocation(context),
              if(i.value==1)
              selectAddress(context),
              if(i.value==2)
              searchAddress(context),
              if(i.value==3)
              featuredDriver(context),
              if(i.value==4)...[
                GestureDetector(
                  onTap: (){i++;},
                    child: Container(
                    height: 50.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      // color: Colors.red,
                        image: DecorationImage(
                            image:  AssetImage(ImagePath.whiteBox,),
                            fit: BoxFit.cover
                        )
                    ),
                    alignment: Alignment.topLeft,
                    child:Padding(
                      padding: EdgeInsets.all(4.w)+EdgeInsets.only(top: 4.h),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: (){if(i.value!=0){i--;}else{AppNavigation.navigatorPop(context);}},
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.chevron_left,
                                    color: Colors.black,
                                    size: 18.sp,
                                  ),
                                ),

                                MyText(title: 'Searching for Driver',fontWeight: FontWeight.w600,size: 16,)
                              ],
                            ),
                          ),
                          // SizedBox(height: 3.h,),
                          Image.asset(ImagePath.ride,scale: 2,),
                          MyText(title: 'Searching Ride',fontWeight: FontWeight.w600,size: 16,),
                          MyText(title: 'This may take few minutes',size: 16,)

                        ],
                      ),
                    ),
                  ),
                ),
                searchingDriver(context),
              ],
              if(i.value==5)
              confirmDriver(),
              if(i.value==6)
              startRide(context),
              if(i.value==7)
              rideCompleted(context),
            ],
          ),
        ),
    );
  }
  startLocation(context){return Positioned(
    bottom: 0,
    child: GestureDetector(
        onTap: (){i++;},
      child: Container(
        padding: EdgeInsets.all(4.w),
        // height: 20.h,
        width: 100.w,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.BOTTOMSHEETRADIUS))
        ),
        child:Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: BottomSheetIndicator()),
            SizedBox(height: 2.h,),
            MyText(title: 'Previous Locations:'),
            SizedBox(height: 1.h,),
            Container(height: 5.h,
              alignment: Alignment.center,
              child:  ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: pastLocations.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  return Container(
                    decoration: BoxDecoration(
                        color: Color(0xffF0F4F8),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: 3.w),
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.replay),
                        SizedBox(width: 2.w,),
                        MyText(title: pastLocations[index]),
                      ],
                    ),
                  );
                },),),
            SizedBox(height: 2.h,),
            MyTextField(hintText: 'Where would you go?',readOnly: true,onTap: (){i++;},),
            SizedBox(height: 2.h,),
          ],
        ),
      ),
    ),);}
  selectAddress(context){return Positioned(
    bottom: 0,
    child:GestureDetector(
      onTap: (){i++;},
      child: Container(
        padding: EdgeInsets.all(4.w),
        // height: 20.h,
        width: 100.w,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.BOTTOMSHEETRADIUS))
        ),
        child:Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: BottomSheetIndicator()),
            SizedBox(height: 2.h,),
            MyText(title: 'Select Address'),
            SizedBox(height: 1.h,),
            Divider(),
            SizedBox(height: 1.h,),
            Row(
              children: [
                Image.asset(ImagePath.radioF,width: 4.w,),
                SizedBox(width: 3.w),
                Expanded(child: MyTextField(hintText: 'From',readOnly: true,onTap: (){i++;},)),
              ],
            ),
            SizedBox(height: 2.h,),
            Row(
              children: [
                Image.asset(ImagePath.location,width: 4.w,),
                SizedBox(width: 3.w),
                Expanded(child: MyTextField(hintText: 'Destination',readOnly: true,onTap: (){i++;},)),
              ],
            ),
            SizedBox(height: 1.h,),
            Divider(),
            SizedBox(height: 1.h,),
            GestureDetector(
              onTap: (){
                AppNavigation.navigateTo(context, AppRouteName.SavedAddress);
              },
              child: Row(
                children: [
                Image.asset(ImagePath.saved,scale: 2,),
                  SizedBox(width: 2.w,),
                  Expanded(child: MyText(title: 'Saved Places',fontWeight: FontWeight.w600,)),
                Icon(Icons.chevron_right_rounded,color: MyColors().primaryColor,)
              ],),
            ),
            SizedBox(height: 1.h,),
            Divider(),
            SizedBox(height: 1.h,),
            ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: 3,
              // scrollDirection: Axis.horizontal,
              itemBuilder: (context,index){
                return Container(
                  // decoration: BoxDecoration(
                  //     color: Color(0xffF0F4F8),
                  //     borderRadius: BorderRadius.circular(10)
                  // ),
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 1.5.h),
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.schedule_rounded,color: MyColors().greyColor,),
                      SizedBox(width: 2.w,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(title: 'Eleonora Hotel',fontWeight: FontWeight.w600,size: 15,),
                            MyText(title: '7 glendale st. worcester, ma 02376',clr: MyColors().greyColor,),
                          ],
                        ),
                      ),
                      SizedBox(width: 2.w,),
                      MyText(title: '2.6 km',fontWeight: FontWeight.w500,),

                    ],
                  ),
                );
              },),
            SizedBox(height: 1.h,),
          ],
        ),
      ),
    ),);}
  searchAddress(context){return Positioned(
    bottom: 0,
    child:GestureDetector(
      onTap: (){i++;},
      child: Container(
        padding: EdgeInsets.all(4.w),
        height: 100.h,
        width: 100.w,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.BOTTOMSHEETRADIUS))
        ),
        child:Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5.h,),
            Row(
              children: [
                GestureDetector(
                  onTap: (){i--;},
                  child: Icon(
                    Icons.chevron_left,
                    color: Colors.black,
                    size: 18.sp,
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(child: MyTextField(hintText: 'Where would you go?',readOnly: true,onTap: (){i++;},)),
              ],
            ),
            SizedBox(height: 2.h,),
            Row(
              children: [
                Image.asset(ImagePath.current,scale: 2,),
                SizedBox(width: 3.w),
                MyText(title: 'Current Location',clr: MyColors().hintColor,)
              ],
            ),
            SizedBox(height: 2.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(title: 'Recent',fontWeight: FontWeight.w600,),
                MyText(title: 'Clear All',fontWeight: FontWeight.w500,under: true,clr: MyColors().primaryColor,),
              ],),
            SizedBox(height: 1.h,),
            Divider(),
            SizedBox(height: 1.h,),
            ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: 3,
              // scrollDirection: Axis.horizontal,
              itemBuilder: (context,index){
                return Container(
                  // decoration: BoxDecoration(
                  //     color: Color(0xffF0F4F8),
                  //     borderRadius: BorderRadius.circular(10)
                  // ),
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 1.5.h),
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.schedule_rounded,color: MyColors().greyColor,),
                      SizedBox(width: 2.w,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(title: 'Eleonora Hotel',fontWeight: FontWeight.w600,size: 15,),
                            MyText(title: '7 glendale st. worcester, ma 02376',clr: MyColors().greyColor,),
                          ],
                        ),
                      ),
                      SizedBox(width: 2.w,),
                      MyText(title: '2.6 km',fontWeight: FontWeight.w500,),

                    ],
                  ),
                );
              },),
            SizedBox(height: 1.h,),
          ],
        ),
      ),
    ),);}
  featuredDriver(context){return Positioned(
    bottom: 0,
    child:GestureDetector(
      onTap: (){i++;},
      child: Container(
        padding: EdgeInsets.all(4.w),
        // height: 20.h,
        width: 100.w,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.BOTTOMSHEETRADIUS))
        ),
        child:Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: BottomSheetIndicator()),
            SizedBox(height: 2.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(title: 'Distance',fontWeight: FontWeight.w600,),
                MyText(title: '4.5 km',),
              ],
            ),
            SizedBox(height: 1.h,),
            Divider(),
            SizedBox(height: 1.h,),
            Row(children: [
              Image.asset(ImagePath.source,scale: 2,),
              SizedBox(width: 2.w,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(title: 'My Current Location',fontWeight: FontWeight.w600,size: 15,),
                    MyText(title: '35 Oak Ave. Antioch, TN 3456',clr: MyColors().greyColor,),
                  ],
                ),
              ),
              SizedBox(width: 2.w,),
              Image.asset(ImagePath.edit,scale: 2,),
            ],),
            SizedBox(height: 2.h,),
            Row(children: [
              Image.asset(ImagePath.destination,scale: 2,),
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
              SizedBox(width: 2.w,),
              Image.asset(ImagePath.edit,scale: 2,),
            ],),
            SizedBox(height: 2.h,),
            MyButton(title: 'Continue', onTap: (){
              i++;
              AppNavigation.navigateTo(context, AppRouteName.SelectCarCategory);
              },),
            SizedBox(height: 2.h,),
          ],
        ),
      ),
    ),);}
  searchingDriver(context){return Align(
    alignment: Alignment.bottomCenter,
    // bottom: 10,
    child:GestureDetector(
      onTap: (){i++;},
      child: Container(
        padding: EdgeInsets.all(3.w)+EdgeInsets.symmetric(horizontal: 3.w),
        // height: 20.h,
        // width: 100.w,
          margin: EdgeInsets.only(bottom: 5.h),
        decoration: BoxDecoration(
            color: MyColors().redColor.withOpacity(.2),
            border: Border.all(
              color: MyColors().redColor,
            ),
            borderRadius: BorderRadius.circular(25)
        ),
        child: MyText(title: 'Cancel',clr: MyColors().redColor,)
      ),
    ),);}
  confirmDriver(){return Positioned(
    bottom: 0,
    child:GestureDetector(
      onTap: (){i++;},
      child: Container(
        padding: EdgeInsets.all(4.w),
        // height: 20.h,
        width: 100.w,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.BOTTOMSHEETRADIUS))
        ),
        child:Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: BottomSheetIndicator()),
            SizedBox(height: 2.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(title: 'Driver is Arriving..',fontWeight: FontWeight.w600,),
                MyText(title: '2 mins',),
              ],
            ),
            SizedBox(height: 1.h,),
            Divider(),
            SizedBox(height: 1.h,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 2.8.h,
                  backgroundColor: MyColors().whiteColor,
                  child: CustomImage(
                    height: 6.h,
                    width: 6.h,
                    isProfile: true,
                    photoView: false,
                    // url: c.user?.userImage,
                    radius: 100,
                  ),
                ),
                SizedBox(width : 2.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(child: MyText(title: 'Jaylon',fontWeight: FontWeight.w700,line: 1,)),
                          SizedBox(width: 3.w),
                          Icon(Icons.star_rounded,color: Color(0xffFBC400),),
                          SizedBox(width: 3.w),
                          MyText(
                            title: '4.8',
                            size: 12,
                            clr: MyColors().greyColor,
                            line: 1,
                            toverflow: TextOverflow.ellipsis,
                          ),
                          // MyText(
                          //   title: Utils.relativeTime(c.createdAt),
                          //   size: 12,
                          //   clr: MyColors().greyColor,
                          //   line: 1,
                          //   toverflow: TextOverflow.ellipsis,
                          // ),
                        ],
                      ),
                      // SizedBox(height: .5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            title: 'Mercedes-Benz E-class',
                            size: 12,
                            clr: MyColors().greyColor,
                            line: 1,
                            toverflow: TextOverflow.ellipsis,
                          ),
                          MyText(
                            title: 'HSW 7345 XK',
                            size: 12,
                            clr: MyColors().greyColor,
                            line: 1,
                            fontWeight: FontWeight.w600,
                            toverflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Image.asset(ImagePath.cancel,scale: 2,),
              Image.asset(ImagePath.chat2,scale: 2,),
              Image.asset(ImagePath.call2,scale: 2,),
            ],),
            SizedBox(height: 2.h,),
          ],
        ),
      ),
    ),);}
  startRide(context){return Positioned(
    bottom: 0,
    child:GestureDetector(
      onTap: (){i++;},
      child: Container(
        padding: EdgeInsets.all(4.w),
        // height: 20.h,
        width: 100.w,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.BOTTOMSHEETRADIUS))
        ),
        child:Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: BottomSheetIndicator()),
            SizedBox(height: 2.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(title: 'Distance',fontWeight: FontWeight.w600,),
                MyText(title: '4.5 km',),
              ],
            ),
            SizedBox(height: 1.h,),
            Divider(),
            SizedBox(height: 1.h,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 2.8.h,
                  backgroundColor: MyColors().whiteColor,
                  child: CustomImage(
                    height: 6.h,
                    width: 6.h,
                    isProfile: true,
                    photoView: false,
                    // url: c.user?.userImage,
                    radius: 100,
                  ),
                ),
                SizedBox(width : 2.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(child: MyText(title: 'Daniel Austin',fontWeight: FontWeight.w700,line: 1,)),
                          SizedBox(width: 3.w),
                          Icon(Icons.star_rounded,color: Color(0xffFBC400),),
                          SizedBox(width: 3.w),
                          MyText(
                            title: '4.8',
                            size: 12,
                            clr: MyColors().greyColor,
                            line: 1,
                            toverflow: TextOverflow.ellipsis,
                          ),
                          // MyText(
                          //   title: Utils.relativeTime(c.createdAt),
                          //   size: 12,
                          //   clr: MyColors().greyColor,
                          //   line: 1,
                          //   toverflow: TextOverflow.ellipsis,
                          // ),
                        ],
                      ),
                      // SizedBox(height: .5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            title: 'Mercedes-Benz E-class',
                            size: 12,
                            clr: MyColors().greyColor,
                            line: 1,
                            toverflow: TextOverflow.ellipsis,
                          ),
                          MyText(
                            title: 'HSW 7345 XK',
                            size: 12,
                            clr: MyColors().greyColor,
                            line: 1,
                            fontWeight: FontWeight.w600,
                            toverflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 1.h,),
            Row(children: [
              Image.asset(ImagePath.source,scale: 2,),
              SizedBox(width: 2.w,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(title: 'My Current Location',fontWeight: FontWeight.w600,size: 15,),
                    MyText(title: '35 Oak Ave. Antioch, TN 3456',clr: MyColors().greyColor,),
                  ],
                ),
              ),
              SizedBox(width: 2.w,),
              MyText(title: '0 km',fontWeight: FontWeight.w600,size: 15,),
            ],),
            SizedBox(height: 2.h,),
            Row(children: [
              Image.asset(ImagePath.destination,scale: 2,),
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
              SizedBox(width: 2.w,),
              MyText(title: '4.5 km',fontWeight: FontWeight.w600,size: 15,),
            ],),
            SizedBox(height: 2.h,),
          ],
        ),
      ),
    ),);}
  rideCompleted(context){return Positioned(
    bottom: 0,
    child:GestureDetector(
      onTap: (){
        // i++;
        },
      child: Container(
        padding: EdgeInsets.all(4.w),
        // height: 20.h,
        width: 100.w,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.BOTTOMSHEETRADIUS))
        ),
        child:Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: BottomSheetIndicator()),
            SizedBox(height: 2.h,),
            Align(alignment: Alignment.centerLeft, child: MyText(title: 'Ride Completed',fontWeight: FontWeight.w600,)),
            SizedBox(height: 1.h,),
            Divider(),
            SizedBox(height: 1.h,),
            MyText(title: 'How was your driver',fontWeight: FontWeight.w600,),
            SizedBox(height: 1.h,),
            MyText(title: 'Please rate your driver',clr: MyColors().hintColor,),
            SizedBox(height: 1.h,),
            Center(
              child: RatingBar(
                initialRating: rate,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                glowColor: Colors.yellow,
                updateOnDrag:true,
                ratingWidget: RatingWidget(
                  full: Icon(Icons.star_rounded,color: Color(0xffFBC400),),
                  half:  Icon(Icons.star_half_rounded,color: Color(0xffFBC400),),
                  empty: Icon(Icons.star_outline_rounded,color: Color(0xffFBC400),),
                ),
                itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                onRatingUpdate: (rating) {
                  rate=rating;
                },
                itemSize:7.w,
              ),
            ),
            SizedBox(height: 1.h,),
            Divider(),
            SizedBox(height: 1.h,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 2.8.h,
                  backgroundColor: MyColors().whiteColor,
                  child: CustomImage(
                    height: 6.h,
                    width: 6.h,
                    isProfile: true,
                    photoView: false,
                    // url: c.user?.userImage,
                    radius: 100,
                  ),
                ),
                SizedBox(width : 2.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(child: MyText(title: 'Daniel Austin',fontWeight: FontWeight.w700,line: 1,)),
                          SizedBox(width: 3.w),
                          Icon(Icons.star_rounded,color: Color(0xffFBC400),),
                          SizedBox(width: 3.w),
                          MyText(
                            title: '4.8',
                            size: 12,
                            clr: MyColors().greyColor,
                            line: 1,
                            toverflow: TextOverflow.ellipsis,
                          ),
                          // MyText(
                          //   title: Utils.relativeTime(c.createdAt),
                          //   size: 12,
                          //   clr: MyColors().greyColor,
                          //   line: 1,
                          //   toverflow: TextOverflow.ellipsis,
                          // ),
                        ],
                      ),
                      // SizedBox(height: .5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            title: 'Mercedes-Benz E-class',
                            size: 12,
                            clr: MyColors().greyColor,
                            line: 1,
                            toverflow: TextOverflow.ellipsis,
                          ),
                          MyText(
                            title: 'HSW 7345 XK',
                            size: 12,
                            clr: MyColors().greyColor,
                            line: 1,
                            fontWeight: FontWeight.w600,
                            toverflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 1.h,),
            Divider(),
            SizedBox(height: 1.h,),
            Align(alignment: Alignment.centerLeft, child: MyText(title: 'Booking Summary',fontWeight: FontWeight.w600,)),
            SizedBox(height: .8.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              MyText(title: 'Subtotal',clr: MyColors().hintColor,),
              MyText(title: 'AED 58.96',clr: MyColors().hintColor,),
            ],),
            SizedBox(height: .8.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              MyText(title: 'Platform Fee',clr: MyColors().hintColor,),
              MyText(title: 'AED 1.55',clr: MyColors().hintColor,),
            ],),
            SizedBox(height: .8.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              MyText(title: 'Total',fontWeight: FontWeight.w600),
              MyText(title: 'AED 62.55',fontWeight: FontWeight.w600),
            ],),
            SizedBox(height: 2.h,),
            Row(children: [
              Flexible(child: MyButton(height: 5.h,title: 'Skip',radius: 25,bgColor: MyColors().whiteColor,textColor: MyColors().greyColor,borderColor: MyColors().greyColor,onTap: (){i.value=0;},)),
              SizedBox(width: 3.w,),
              Flexible(child: MyButton(height: 5.h,title: 'Submit',radius: 25,onTap: (){i.value=0;})),
            ],),
            SizedBox(height: 2.h,),
          ],
        ),
      ),
    ),);}

}

