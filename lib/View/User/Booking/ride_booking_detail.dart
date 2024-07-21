import 'package:drivy_driver/Arguments/screen_arguments.dart';
import 'package:drivy_driver/Component/custom_buttom.dart';
import 'package:drivy_driver/Component/custom_image.dart';
import 'package:drivy_driver/Controller/auth_controller.dart';
import 'package:drivy_driver/Controller/home_controller.dart';
import 'package:drivy_driver/Model/menu_model.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:flutter/material.dart';
import '../../../../../Utils/my_colors.dart';
import '../../../../../Utils/responsive.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../../Component/custom_text.dart';
import '../../../../Utils/image_path.dart';
import '../../base_view.dart';

class RideBookingDetail extends StatefulWidget {
  RideBookingDetail(
      {super.key, required this.fromRide, required this.bookingId});
  bool fromRide;
  int bookingId;
  @override
  State<RideBookingDetail> createState() => _RideBookingDetailState();
}

class _RideBookingDetailState extends State<RideBookingDetail> {
  @override
  void initState() {
    HomeController.i.getBookingDetail(context: context, id: widget.bookingId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        screenTitle: "Booking Detail",
        showAppBar: true,
        centerTitle: false,
        showBackButton: true,
        resizeBottomInset: false,
        child: GetBuilder<HomeController>(builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xffDAE1F1),
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: MyColors().hintColor.withOpacity(.1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    MyText(
                                      title: 'Booking ID  ',
                                      size: 15,
                                      clr: MyColors().greyColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    MyText(
                                      title: '#${controller.tripDataModel?.id}',
                                      size: 15,
                                      clr: MyColors().black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: .5.h,
                                ),
                                MyText(
                                  title:
                                      'Placed on ${controller.tripDataModel?.createdAt ?? ''}',
                                  size: 12,
                                  clr: MyColors().greyColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            MyText(
                              title:
                                  HomeController.i.tripDataModel?.status ?? '',
                              size: 12,
                              clr: HomeController.i.tripDataModel?.status ==
                                      'completed'
                                  ? MyColors().greenColor
                                  : MyColors().greyColor,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const MyText(
                              title: 'Service',
                              fontWeight: FontWeight.w400,
                            ),
                            MyText(
                              title: widget.fromRide
                                  ? 'Standard car'
                                  : 'Pay per minute',
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const MyText(
                              title: 'Schedule Time',
                              fontWeight: FontWeight.w400,
                            ),
                            MyText(
                              title:
                                  HomeController.i.tripDataModel?.createdAt ??
                                      '',
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  if (HomeController.i.tripDataModel?.car != null)
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xffDAE1F1),
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: MyColors().whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Image.asset(
                          //   ImagePath.marker,
                          //   scale: 2,
                          // ),
                          CircleAvatar(
                            radius: 2.8.h,
                            backgroundColor: MyColors().whiteColor,
                            child: CustomImage(
                              height: 6.h,
                              width: 6.h,
                              isProfile: true,
                              photoView: false,
                              url:
                                  AuthController.i.user.value.userImage ?? null,
                              radius: 100,
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: MyText(
                                      title: HomeController.i.tripDataModel
                                              ?.user?.firstName ??
                                          '',
                                      fontWeight: FontWeight.w700,
                                      line: 1,
                                    )),
                                    SizedBox(width: 3.w),
                                    const Icon(
                                      Icons.star_rounded,
                                      color: Color(0xffFBC400),
                                    ),
                                    SizedBox(width: 1.w),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MyText(
                                      title: widget.fromRide
                                          ? '${HomeController.i.tripDataModel?.car?.carBrand?.brandName ?? ''}'
                                          : 'Chauffeur',
                                      size: 12,
                                      clr: MyColors().greyColor,
                                      line: 1,
                                      toverflow: TextOverflow.ellipsis,
                                    ),
                                    if (widget.fromRide)
                                      MyText(
                                        title:
                                            '${HomeController.i.tripDataModel?.car?.licensePlateNumber ?? ''}',
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
                    ),
                  SizedBox(
                    height: 2.h,
                  ),
                  if (!widget.fromRide) ...[
                    if (HomeController.i.tripDataModel?.car != null)
                      Container(
                        decoration: BoxDecoration(
                          // border: Border.all(
                          //   color: Color(0xffDAE1F1).withOpacity(.3),
                          // ),
                          borderRadius: BorderRadius.circular(8),
                          color: MyColors().whiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(bottom: 1.5.h),
                        padding: const EdgeInsets.all(12) +
                            EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(ImagePath.rc, scale: 2),
                            SizedBox(
                              width: 3.w,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                    title:
                                        '${HomeController.i.tripDataModel?.car?.description ?? ''}',
                                    size: 15,
                                    clr: MyColors().greyColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(
                                    height: .5.h,
                                  ),
                                  MyText(
                                    title:
                                        '${HomeController.i.tripDataModel?.car?.carBrand?.brandName ?? 'No Brand'}',
                                    size: 13,
                                    clr: MyColors().primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                          ],
                        ),
                      ),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                  MyText(
                    title: 'Location',
                    size: 15,
                    clr: MyColors().textColor,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xffDAE1F1),
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: MyColors().whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
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
                                  const MyText(
                                    title: 'My Current Location',
                                    fontWeight: FontWeight.w600,
                                    size: 15,
                                  ),
                                  MyText(
                                    title: HomeController.i.tripDataModel
                                            ?.pickupAddress?.address ??
                                        '',
                                    clr: MyColors().greyColor,
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
                                  const MyText(
                                    title: 'Drop Location',
                                    fontWeight: FontWeight.w600,
                                    size: 15,
                                  ),
                                  MyText(
                                    title: HomeController.i.tripDataModel
                                            ?.dropoffAddress?.address ??
                                        '',
                                    clr: MyColors().greyColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  MyText(
                    title: 'Payment Method',
                    size: 15,
                    clr: MyColors().textColor,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                      // width: 100.w,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xffDAE1F1),
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: MyColors().whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(12) +
                          const EdgeInsets.symmetric(vertical: 6),
                      child: Center(
                        child: MyText(
                            title:
                                HomeController.i.tripDataModel?.pmType ?? ""),
                      )

                      // Row(
                      //   // crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     // MenuModel(name: 'XXXX XXXX XXXX XX58',description: 'Valid May 2022',value: '2'.obs, image: ImagePath.masterCard),

                      //     Image.asset(
                      //       ImagePath.masterCard,
                      //       scale: 2,
                      //       width: 9.w,
                      //     ),
                      //     SizedBox(
                      //       width: 3.w,
                      //     ),
                      //     Expanded(
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           const MyText(
                      //             title: 'XXXX XXXX XXXX XX58',
                      //             size: 15,
                      //             clr: Color(0xff4D5D65),
                      //             fontWeight: FontWeight.w600,
                      //           ),
                      //           SizedBox(
                      //             height: .5.h,
                      //           ),
                      //           MyText(
                      //             title: 'Valid May 2022',
                      //             size: 15,
                      //             clr: MyColors().greyColor,
                      //             fontWeight: FontWeight.w500,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      ),
                  SizedBox(
                    height: 2.h,
                  ),
                  MyText(
                    title: 'Order Summary',
                    size: 15,
                    clr: MyColors().textColor,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 1.h,
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
                        title:
                            'AED ${HomeController.i.tripDataModel?.platformFee}',
                        clr: MyColors().hintColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: .8.h,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     MyText(
                  //       title: 'Sales tax',
                  //       clr: MyColors().hintColor,
                  //     ),
                  //     MyText(
                  //       title: 'AED 1.96',
                  //       clr: MyColors().hintColor,
                  //     ),
                  //   ],
                  // ),
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
                        title:
                            'AED ${HomeController.i.tripDataModel?.subTotal}',
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
                              'AED ${(HomeController.i.tripDataModel?.subTotal ?? 0) + (HomeController.i.tripDataModel?.subTotal ?? 0.0)}',
                          fontWeight: FontWeight.w600),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  // MyButton(title: 'Give Rating',onTap: (){
                  //   // AppNavigation.navigateTo(context, AppRouteName.RateBooking);
                  // },bgColor: MyColors().whiteColor,borderColor: MyColors().primaryColor,textColor: MyColors().primaryColor,),
                  // SizedBox(height: 2.h,),
                ],
              ),
            ),
          );
        }));
  }
}
