import 'dart:ui';
import 'package:drivy_driver/Component/custom_buttom.dart';
import 'package:drivy_driver/Component/custom_image.dart';
import 'package:drivy_driver/Controller/auth_controller.dart';
import 'package:drivy_driver/Controller/home_controller.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:drivy_driver/Utils/image_path.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:drivy_driver/Utils/utils.dart';
import 'package:drivy_driver/View/base_view.dart';
import 'package:flutter/material.dart';
import '../../../../Component/custom_bottomsheet_indicator.dart';
import '../../../../Component/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import '../../../../Utils/app_size.dart';

class Ride extends StatefulWidget {
  static double CAMERA_ZOOM = 16;
  static double CAMERA_TILT = 80;
  static double CAMERA_BEARING = 30;

  @override
  State<Ride> createState() => _RideState();
}

class _RideState extends State<Ride> {
  GoogleMapController? mapController;

  RxInt i = 0.obs;

  @override
  void initState() {
    HomeController.i.getCurrentActiveRide(context: context);
    AuthController.i.listenForPostion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      showAppBar: false,
      topSafeArea: false,
      bottomSafeArea: false,
      child: GetBuilder<HomeController>(builder: (p) {
        return Obx(
          () => Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                    zoom: Ride.CAMERA_ZOOM,
                    tilt: Ride.CAMERA_TILT,
                    bearing: Ride.CAMERA_BEARING,
                    target: LatLng(24.8296, 67.0415)),
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
              ),
              Positioned(
                top: 5.h,
                left: 4.w,
                child: GestureDetector(
                  onTap: () {
                    if (i.value != 0) {
                      i--;
                    } else {
                      AppNavigation.navigatorPop(context);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.chevron_left,
                      color: Colors.black,
                      size: 18.sp,
                    ),
                  ),
                ),
              ),
              if (i.value == 0) tripDistance(),
              if (i.value == 1) arrivedLocation(),
              if (i.value == 2) tripStarted(context),
              if (i.value == 3) rideCompleted(context),
            ],
          ),
        );
      }),
    );
  }

  tripDistance() {
    return Positioned(
      bottom: 0,
      child: GestureDetector(
        onTap: () {
          i++;
        },
        child: Container(
          padding: EdgeInsets.all(4.w),
          // height: 20.h,
          width: 100.w,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppSize.BOTTOMSHEETRADIUS))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: BottomSheetIndicator()),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MyText(
                    title: 'Trip to Distance',
                    fontWeight: FontWeight.w600,
                  ),
                  MyText(
                      title:
                          '${HomeController.i.currentActiveRide?.rideDistance}')
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Divider(),
              SizedBox(
                height: 1.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image.asset(
                  //   ImagePath.marker,
                  //   scale: 2,
                  // ),

                  SizedBox(
                    height: 50,
                    width: 50,
                    child: CustomImage(
                      url: HomeController
                          .i.currentActiveRide?.car?.owner?.userImage,
                    ),
                  ),
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
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          title:
                              '${HomeController.i.currentActiveRide?.user?.firstName ?? ''}  ${HomeController.i.currentActiveRide?.user?.lastName ?? ''}',
                          fontWeight: FontWeight.w700,
                          line: 1,
                        ),
                        MyText(
                          title: HomeController.i.currentActiveRide?.car
                                  ?.carBrand?.brandName ??
                              '',
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
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    ImagePath.cancel,
                    scale: 2,
                  ),
                  Image.asset(
                    ImagePath.chat2,
                    scale: 2,
                  ),
                  Image.asset(
                    ImagePath.call2,
                    scale: 2,
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  arrivedLocation() {
    return Positioned(
      bottom: 0,
      child: GestureDetector(
        onTap: () {
          i++;
        },
        child: Container(
          padding: EdgeInsets.all(4.w),
          // height: 20.h,
          width: 100.w,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppSize.BOTTOMSHEETRADIUS))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: BottomSheetIndicator()),
              SizedBox(
                height: 2.h,
              ),
              Image.asset(
                ImagePath.location2,
                scale: 2,
              ),
              SizedBox(
                height: 2.h,
              ),
              const MyText(
                title: 'You have arrived at\nyour destination',
                fontWeight: FontWeight.w600,
                center: true,
                size: 20,
              ),
              SizedBox(
                height: 2.h,
              ),
              // const Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     MyText(
              //       title: 'Trip to Distance',
              //       fontWeight: FontWeight.w600,
              //     ),
              //     MyText(
              //       title: '4.5 km',
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 1.h,
              ),
              const Divider(),
              SizedBox(
                height: 1.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: CustomImage(
                      url: HomeController.i.currentActiveRide?.user?.userImage,
                    ),
                  ),
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
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          title:
                              '${HomeController.i.currentActiveRide?.user?.firstName ?? ''}  ${HomeController.i.currentActiveRide?.user?.lastName ?? ''}',
                          fontWeight: FontWeight.w600,
                          line: 1,
                        ),
                        MyText(
                          title: HomeController.i.currentActiveRide?.car
                                  ?.carBrand?.brandName ??
                              '',
                          fontWeight: FontWeight.w700,
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
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    ImagePath.cancel,
                    scale: 2,
                  ),
                  Image.asset(
                    ImagePath.chat2,
                    scale: 2,
                  ),
                  Image.asset(
                    ImagePath.call2,
                    scale: 2,
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              MyButton(
                title: 'Start Trip',
                onTap: () {
                  // i++;
                  HomeController.i.changeRideStatus(context, onSuccess: () {
                    HomeController.i.changeRideStatus(context, onSuccess: () {
                      i++;
                    },
                        rideStatus: "start_drive",
                        rideId:
                            HomeController.i.currentActiveRideId.toString());
                  },
                      rideStatus: "confirm_arrival",
                      rideId: HomeController.i.currentActiveRideId.toString());
                },
                width: 70.w,
                height: 5.h,
                radius: 25,
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // accept,reject,timeout,complete,confirm_arrival,start_drive,end_drive

  tripStarted(context) {
    return Positioned(
      bottom: 0,
      child: GestureDetector(
        onTap: () {
          i++;
        },
        child: Container(
          padding: EdgeInsets.all(4.w),
          // height: 20.h,
          width: 100.w,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppSize.BOTTOMSHEETRADIUS))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(child: BottomSheetIndicator()),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                    title: 'Distance',
                    fontWeight: FontWeight.w600,
                  ),
                  MyText(
                    title:
                        '${HomeController.i.currentActiveRide?.rideDistance}',
                  ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Divider(),
              SizedBox(
                height: 1.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: CustomImage(
                      url: HomeController.i.currentActiveRide?.user?.userImage,
                    ),
                  ),
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
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          title:
                              '${HomeController.i.currentActiveRide?.user?.firstName ?? ''}  ${HomeController.i.currentActiveRide?.user?.lastName ?? ''}',
                          fontWeight: FontWeight.w700,
                          line: 1,
                        ),
                        MyText(
                          title: HomeController.i.currentActiveRide?.car
                                  ?.carBrand?.brandName ??
                              '',
                          fontWeight: FontWeight.w600,
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
              SizedBox(
                height: 1.h,
              ),
              Divider(),
              SizedBox(
                height: 1.h,
              ),
              Row(
                children: [
                  Image.asset(
                    ImagePath.source,
                    scale: 2,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          title: 'My Current Location',
                          fontWeight: FontWeight.w600,
                          size: 15,
                        ),
                        GetBuilder<AuthController>(builder: (a) {
                          return MyText(
                            title: a.userCurrentPosition.value,
                            fontWeight: FontWeight.w600,
                            clr: MyColors().greyColor,
                          );
                        }),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  // MyText(title: '0 Km'),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                children: [
                  Image.asset(
                    ImagePath.destination,
                    scale: 2,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          title: 'Drop Off Address',
                          fontWeight: FontWeight.w600,
                          size: 15,
                        ),
                        MyText(
                          title:
                              '${HomeController.i.currentActiveRide?.dropoffAddress ?? ''}  ${HomeController.i.currentActiveRide?.rideDistance ?? ''}',
                          clr: MyColors().greyColor,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  // MyText(title: '4.5 Km'),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              MyButton(
                title: 'End Trip',
                onTap: () {
                  HomeController.i.changeRideStatus(context, onSuccess: () {
                    i++;
                  },
                      rideStatus: "end_drive",
                      rideId: HomeController.i.currentActiveRideId.toString());
                },
                width: 70.w,
                height: 5.h,
                radius: 25,
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  rideCompleted(context) {
    return Positioned(
      bottom: 0,
      child: GestureDetector(
        onTap: () {
          // i++;
        },
        child: Container(
          padding: EdgeInsets.all(4.w),
          // height: 20.h,
          width: 100.w,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppSize.BOTTOMSHEETRADIUS))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: BottomSheetIndicator()),
              SizedBox(
                height: 2.h,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: MyText(
                    title: 'Ride Completed',
                    fontWeight: FontWeight.w600,
                  )),
              SizedBox(
                height: 1.h,
              ),
              Divider(),
              SizedBox(
                height: 1.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: CustomImage(
                      url: HomeController.i.currentActiveRide?.user?.userImage,
                    ),
                  ),
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
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          title:
                              '${HomeController.i.currentActiveRide?.user?.firstName ?? ''}  ${HomeController.i.currentActiveRide?.user?.lastName ?? ''}',
                          fontWeight: FontWeight.w700,
                          line: 1,
                        ),
                        MyText(
                          title: HomeController.i.currentActiveRide?.car
                                  ?.carBrand?.brandName ??
                              '',
                          fontWeight: FontWeight.w700,
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
              SizedBox(
                height: 1.h,
              ),
              Divider(),
              SizedBox(
                height: 1.h,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: MyText(
                    title: 'Booking Summary',
                    fontWeight: FontWeight.w600,
                  )),
              SizedBox(
                height: .8.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                    title: 'Subtotal',
                    clr: MyColors().hintColor,
                  ),
                  MyText(
                    title: 'AED ${HomeController.i.currentActiveRide?.amount}',
                    clr: MyColors().hintColor,
                  ),
                ],
              ),
              SizedBox(
                height: .8.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                    title: 'Platform Fee',
                    clr: MyColors().hintColor,
                  ),
                  MyText(
                    title: 'AED 2',
                    clr: MyColors().hintColor,
                  ),
                ],
              ),
              SizedBox(
                height: .8.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MyText(title: 'Total', fontWeight: FontWeight.w600),
                  MyText(
                      title:
                          'AED ${(HomeController.i.currentActiveRide?.amount ?? 0.0) + 2}',
                      fontWeight: FontWeight.w600),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                children: [
                  Flexible(
                      child: MyButton(
                    height: 5.h,
                    title: 'Skip',
                    radius: 25,
                    bgColor: MyColors().whiteColor,
                    textColor: MyColors().greyColor,
                    borderColor: MyColors().greyColor,
                    onTap: () {
                      AppNavigation.navigatorPop(context);
                    },
                  )),
                  SizedBox(
                    width: 3.w,
                  ),
                  Flexible(
                      child: MyButton(
                          height: 5.h,
                          title: 'Submit',
                          radius: 25,
                          onTap: () {
                            HomeController.i.changeRideStatus(context,
                                onSuccess: () {
                              AppNavigation.navigateToRemovingAll(
                                  context, AppRouteName.HOME_SCREEN_ROUTE);
                            },
                                rideStatus: "complete",
                                rideId: HomeController.i.currentActiveRideId
                                    .toString());
                            // AppNavigation.navigatorPop(context);
                          })),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
