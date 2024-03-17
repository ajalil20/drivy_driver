import 'dart:ui';
import 'package:drivy_driver/Component/custom_buttom.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/image_path.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:drivy_driver/View/base_view.dart';
import 'package:flutter/material.dart';
import '../../../../Component/custom_bottomsheet_indicator.dart';
import '../../../../Component/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import '../../../../Utils/app_size.dart';

class Ride extends StatelessWidget {
  GoogleMapController? mapController;
  static double CAMERA_ZOOM = 16;
  static double CAMERA_TILT = 80;
  static double CAMERA_BEARING = 30;
  RxInt i =0.obs;

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
              Positioned(
                top: 5.h,
                left: 4.w,
                child:GestureDetector(
                  onTap: (){if(i.value!=0){i--;}else{AppNavigation.navigatorPop(context);}},
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.chevron_left,
                      color: Colors.black,
                      size: 18.sp,
                    ),
                  ),
                ),
              ),
              if(i.value==0)
                tripDistance(),
              if(i.value==1)
                arrivedLocation(),
              if(i.value==2)
                tripStarted(context),
              if(i.value==3)
                rideCompleted(context),
            ],
          ),
        ),
    );
  }
  tripDistance(){return Positioned(
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
                MyText(title: 'Trip to Distance',fontWeight: FontWeight.w600,),
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
                Image.asset(ImagePath.marker,scale: 2,),
                // CircleAvatar(
                //   radius: 2.8.h,
                //   backgroundColor: MyColors().whiteColor,
                //   child: CustomImage(
                //     height: 6.h,
                //     width: 6.h,
                //     isProfile: true,
                //     photoView: false,
                //     // url: c.user?.userImage,
                //     radius: 100,
                //   ),
                // ),
                SizedBox(width : 2.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(title: 'Marilyn Lipshutz',fontWeight: FontWeight.w700,line: 1,),
                      MyText(
                        title: 'Standard Car',
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
  arrivedLocation(){return Positioned(
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
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: BottomSheetIndicator()),
            SizedBox(height: 2.h,),
            Image.asset(ImagePath.location2,scale: 2,),
            SizedBox(height: 2.h,),
            MyText(title: 'You have arrived at\nyour destination',fontWeight: FontWeight.w600,center: true,size: 20,),
            SizedBox(height: 2.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(title: 'Trip to Distance',fontWeight: FontWeight.w600,),
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
                Image.asset(ImagePath.marker,scale: 2,),
                // CircleAvatar(
                //   radius: 2.8.h,
                //   backgroundColor: MyColors().whiteColor,
                //   child: CustomImage(
                //     height: 6.h,
                //     width: 6.h,
                //     isProfile: true,
                //     photoView: false,
                //     // url: c.user?.userImage,
                //     radius: 100,
                //   ),
                // ),
                SizedBox(width : 2.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(title: 'Marilyn Lipshutz',fontWeight: FontWeight.w600,line: 1,),
                      MyText(
                        title: 'Standard Car',
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
            SizedBox(height: 2.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(ImagePath.cancel,scale: 2,),
                Image.asset(ImagePath.chat2,scale: 2,),
                Image.asset(ImagePath.call2,scale: 2,),
              ],),
            SizedBox(height: 2.h,),
            MyButton(title: 'Start Trip',onTap: (){i++;},width: 70.w,height: 5.h,radius: 25,),
            SizedBox(height: 2.h,),
          ],
        ),
      ),
    ),);}
  tripStarted(context){return Positioned(
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
                Image.asset(ImagePath.marker,scale: 2,),
                // CircleAvatar(
                //   radius: 2.8.h,
                //   backgroundColor: MyColors().whiteColor,
                //   child: CustomImage(
                //     height: 6.h,
                //     width: 6.h,
                //     isProfile: true,
                //     photoView: false,
                //     // url: c.user?.userImage,
                //     radius: 100,
                //   ),
                // ),
                SizedBox(width : 2.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(title: 'Marilyn Lipshutz',fontWeight: FontWeight.w700,line: 1,),
                      MyText(
                        title: 'Standard Car',
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
              MyText(title: '0 Km'),
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
              MyText(title: '4.5 Km'),
            ],),
            SizedBox(height: 2.h,),
            MyButton(title: 'End Trip',onTap: (){i++;},width: 70.w,height: 5.h,radius: 25,),
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(ImagePath.marker,scale: 2,),
                // CircleAvatar(
                //   radius: 2.8.h,
                //   backgroundColor: MyColors().whiteColor,
                //   child: CustomImage(
                //     height: 6.h,
                //     width: 6.h,
                //     isProfile: true,
                //     photoView: false,
                //     // url: c.user?.userImage,
                //     radius: 100,
                //   ),
                // ),
                SizedBox(width : 2.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(title: 'Marilyn Lipshutz',fontWeight: FontWeight.w700,line: 1,),
                      MyText(
                        title: 'Standard Car',
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
              Flexible(child: MyButton(height: 5.h,title: 'Skip',radius: 25,bgColor: MyColors().whiteColor,textColor: MyColors().greyColor,borderColor: MyColors().greyColor,onTap: (){AppNavigation.navigatorPop(context);},)),
              SizedBox(width: 3.w,),
              Flexible(child: MyButton(height: 5.h,title: 'Submit',radius: 25,onTap: (){AppNavigation.navigatorPop(context);})),
            ],),
            SizedBox(height: 2.h,),
          ],
        ),
      ),
    ),);}

}

